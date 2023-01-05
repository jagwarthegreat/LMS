from flask import Blueprint, render_template, request, flash, jsonify, redirect, url_for
from flask_login import login_required, current_user
from .models import User, Books, Category
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

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS