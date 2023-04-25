from . import db
from flask_login import UserMixin
from sqlalchemy.sql import func

class User(db.Model, UserMixin):
    __tablename__ = 'tbl_user'
    id = db.Column(db.Integer, primary_key=True)
    fname = db.Column(db.String(150))
    mname = db.Column(db.String(150))
    lname = db.Column(db.String(150))
    username = db.Column(db.String(150), unique=True)
    password = db.Column(db.String(150))
    category = db.Column(db.String(150))
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())

class Books(db.Model):
    __tablename__ = 'tbl_books'
    book_id = db.Column(db.Integer, primary_key=True)
    book_title = db.Column(db.String(200))
    book_author = db.Column(db.String(150))
    book_publisher_name = db.Column(db.String(150), nullable=True)
    book_category_id = db.Column(db.Integer, db.ForeignKey('tbl_book_category.book_category_id'))
    book_isbn = db.Column(db.String(50), nullable=True)
    book_year_published = db.Column(db.String(6), nullable=True)
    book_qty = db.Column(db.String(6), nullable=True)
    book_price = db.Column(db.String(16), nullable=True)
    book_cover_img = db.Column(db.Text(), nullable=True)
    book_location = db.Column(db.Text(), nullable=True)
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())
    category = db.relationship('Category')

class Category(db.Model):
    __tablename__ = 'tbl_book_category'
    book_category_id = db.Column(db.Integer, primary_key=True)
    book_category = db.Column(db.String(150))
    book_category_desc = db.Column(db.Text(), nullable=True)
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())

class BorrowedBooks(db.Model):
    __tablename__ = 'tbl_borrowed_books'
    borrow_id = db.Column(db.Integer, primary_key=True)
    trans_id = db.Column(db.Text())
    user_id = db.Column(db.Integer, db.ForeignKey('tbl_user.id'))
    status = db.Column(db.String(1), nullable=True)
    date_borrowed = db.Column(db.DateTime(timezone=True))
    date_returned = db.Column(db.DateTime(timezone=True))
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())
    user = db.relationship('User')

class BorrowedBooksDetail(db.Model):
    __tablename__ = 'tbl_borrowed_books_details'
    borrow_detail_id = db.Column(db.Integer, primary_key=True)
    borrow_id = db.Column(db.Integer, db.ForeignKey('tbl_borrowed_books.borrow_id'))
    book_id = db.Column(db.Integer, db.ForeignKey('tbl_books.book_id'))
    qty = db.Column(db.String(10), nullable=True)
    qty_returned = db.Column(db.String(10), nullable=True)
    date_returned = db.Column(db.DateTime(timezone=True), nullable=True)
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())
    borrowedBook = db.relationship('BorrowedBooks')
    book = db.relationship('Books')

    @classmethod
    def get_total_qty(cls, book_id):
        total_qty = db.session.query(func.sum(cls.qty)).\
            join(BorrowedBooks).\
            filter(BorrowedBooks.status == 'B').\
            filter(cls.book_id == book_id).scalar()
            
        return total_qty
