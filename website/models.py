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
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())

class Student(db.Model):
    __tablename__ = 'tbl_students'
    student_id = db.Column(db.Integer, primary_key=True)
    student_fname = db.Column(db.String(150))
    student_mname = db.Column(db.String(150), nullable=True)
    student_lname = db.Column(db.String(150))
    student_year = db.Column(db.String(50), nullable=True)
    student_section = db.Column(db.String(50), nullable=True)
    student_address = db.Column(db.Text(), nullable=True)
    student_contact_number = db.Column(db.String(16), nullable=True)
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())

class Category(db.Model):
    __tablename__ = 'tbl_book_category'
    book_category_id = db.Column(db.Integer, primary_key=True)
    book_category = db.Column(db.String(150))
    book_category_desc = db.Column(db.Text(), nullable=True)
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())

class AutismPrediction(db.Model):
    __tablename__ = 'tbl_autism_predictions'
    ap_id = db.Column(db.Integer, primary_key=True)
    autism_sign_id = db.Column(db.Integer, db.ForeignKey('tbl_autism_signs.autism_sign_id'))
    student_id = db.Column(db.Integer, db.ForeignKey('tbl_students.student_id'))
    status = db.Column(db.String(50), nullable=True)
    date_added = db.Column(db.DateTime(timezone=True), default=func.now())
    student = db.relationship('Student')
