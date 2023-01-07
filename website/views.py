from flask import Blueprint, render_template, request, flash, jsonify, redirect, url_for
from flask_login import login_required, current_user
from .models import User, Books, Category, BorrowedBooks, BorrowedBooksDetail
from . import db, ALLOWED_EXTENSIONS, UPLOAD_FOLDER
import json
from sqlalchemy import desc
from werkzeug.utils import secure_filename
import os

views = Blueprint('views', __name__)


@views.route('/', methods=['GET', 'POST'])
@login_required
def home():
    return render_template("home.html", user=current_user)


@views.route('/books/categories', methods=['GET', 'POST'])
@login_required
def booksCategories():
    if request.method == 'POST':
        category = request.form.get('category')
        desc = request.form.get('desc')

        catValues = Category(book_category=category, book_category_desc=desc)
        db.session.add(catValues)
        db.session.commit()

        flash('Book Category added!', category='success')
        return redirect(url_for('views.booksCategories'))

    categories = Category.query.all()
    return render_template("books_categories.html", user=current_user, categories=categories)

@views.route('/books', methods=['GET', 'POST'])
@login_required
def books():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'cover_image' not in request.files:
            flash('No selected file')
            return redirect(url_for('views.books'))

        title = request.form.get('title')
        author = request.form.get('author')
        publisher_name = request.form.get('publisher_name')
        category = request.form.get('category')
        isbn = request.form.get('isbn')
        year_publish = request.form.get('year_published')
        qty = request.form.get('quantity')
        price = request.form.get('price')
        file = request.files['cover_image']
        location = request.form.get('location')

        # if file.filename == '':
        #     flash('No selected file')
        #     return redirect(url_for('views.books'))
        filePath = ""
        covr_file = ""
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filePath = os.path.join(UPLOAD_FOLDER, filename)
            file.save(filePath)

            covr_file = filePath.replace("website", '')

        # add to database
        book = Books(book_title=title, book_author=author, book_publisher_name=publisher_name, book_category_id=category, book_isbn=isbn, book_year_published=year_publish, book_qty=qty, book_price=price, book_cover_img=covr_file, book_location=location)
        db.session.add(book)
        db.session.commit()

        flash('Book added!', category='success')
        return redirect(url_for('views.books'))

    categories = Category.query.all()
    books = Books.query.all()
    return render_template("books.html", user=current_user, categories=categories, books=books)

@views.route('/books/borrow', methods=['GET', 'POST'])
@login_required
def booksBorrow():
    # if request.method == 'POST':
    #     category = request.form.get('category')
    #     desc = request.form.get('desc')

    #     catValues = Category(book_category=category, book_category_desc=desc)
    #     db.session.add(catValues)
    #     db.session.commit()

    #     flash('Book Category added!', category='success')
    #     return redirect(url_for('views.booksCategories'))

    users = User.query.all()
    borrowedBooks = BorrowedBooks.query.all()
    books = Books.query.all()
    return render_template("books_borrow.html", user=current_user, borrowedBooks=borrowedBooks, users=users, books=books)

@views.route('/books/destroy', methods=['POST'])
@login_required
def delete_book():
    requestData = json.loads(request.data)
    requestID = requestData['bookId'] 
    bookdata = Books.query.get(requestID)

    if(bookdata.book_cover_img is not None):
        if os.path.exists(bookdata.book_cover_img):
            test = os.remove(bookdata.book_cover_img)

    db.session.delete(bookdata)
    db.session.commit()

    flash('Book deleted', category="success")
    return jsonify({ "delete_response": "deleted" })

@views.route('/books/category/destroy', methods=['POST'])
@login_required
def delete_category():
    requestData = json.loads(request.data)
    requestID = requestData['categoryId'] 
    category = Category.query.get(requestID)
    db.session.delete(category)
    db.session.commit()

    return jsonify({})

@views.route('/books/borrow/store', methods=['POST'])
@login_required
def borrow_store():
    requestData = json.loads(request.data)
    borrower_id = requestData['borrower'] 
    date_borrowed = requestData['date_borrowed']

    try:
        borrow_insert = BorrowedBooks(user_id=borrower_id, status="S", date_borrowed=date_borrowed)
        db.session.add(borrow_insert)
        db.session.commit()
        last_id = borrow_insert.borrow_id
    except Exception as e:
        last_id = 0

    return jsonify({ "header_id": last_id })

@views.route('/books/borrow/detail/store', methods=['POST'])
@login_required
def borrow_detail_store():
    requestData = json.loads(request.data)
    selected_book_id = requestData['selected_book_id'] 
    book_qty = requestData['book_qty']
    borrow_header_id = requestData['borrow_header_id']

    try:
        detail_insert = BorrowedBooksDetail(borrow_id=borrow_header_id, book_id=selected_book_id, qty=book_qty)
        db.session.add(detail_insert)
        db.session.commit()
        response = 1
    except Exception as e:
        response = e

    return jsonify({ "response": response })

@views.route('/books/borrow/detail/data', methods=['GET', 'POST'])
@login_required
def borrow_detail_data():
    borrowId = request.form.get('borrowId')

    count=0
    data = []
    borrow_details = BorrowedBooksDetail.query.filter_by(borrow_id=borrowId).all()
    for row in borrow_details:
        count += 1
        data.append({
            "count": count,
            "borrow_id":row.borrow_id,
            "book": row.book.book_title,
            "qty": row.qty,
            "action": ""
        })

    response = {"data": data}
    return jsonify(response)

@views.route('/books/borrow/detail/edit', methods=['POST'])
@login_required
def borrow_detail_edit():
    requestData = json.loads(request.data)
    borrowId = requestData['id'] 

    borrow_details = BorrowedBooks.query.filter_by(borrow_id=borrowId).first()
    data = {
        "user_id": borrow_details.user_id,
        "status":borrow_details.status,
        "date_borrowed": borrow_details.date_borrowed      
    }

    return jsonify({ "data": data })

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS