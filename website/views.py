from flask import Blueprint, render_template, request, flash, jsonify, redirect, url_for
from flask_login import login_required, current_user
from .models import User, Books, Category, BorrowedBooks, BorrowedBooksDetail
from . import db, ALLOWED_EXTENSIONS, UPLOAD_FOLDER
import json
from sqlalchemy import desc
from werkzeug.utils import secure_filename
from datetime import datetime
import os

import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

views = Blueprint('views', __name__)


@views.route('/', methods=['GET', 'POST'])
@login_required
def home():
    return render_template("home.html", user=current_user)

@views.route('/opac', methods=['GET', 'POST'])
@login_required
def opac():
    if request.method == 'POST':
        requestData = json.loads(request.data)
        book_search = requestData['book_search']
        filter_category = requestData['filter_category']

        return filteredBooksData(book_search, filter_category)

    books = Books.query.filter_by().all()
    return render_template("opac.html", user=current_user, books=books)

def filteredBooksData(book_search, filter_category):
    count=0
    data = []
    query = Books.query

    if book_search:
        query = Books.query.filter(
            (Books.book_title.ilike(f"%{book_search}%")) |
            (Books.book_author.ilike(f"%{book_search}%")) |
            (Books.book_publisher_name.ilike(f"%{book_search}%"))
        )

    if filter_category:
        query = query.filter_by(book_category_id=filter_category)

    books = query.all()
    for book in books:
        category_id = book.category.book_category

        # if category_id not in data:
        #     data[category_id] = []

        count += 1
        data.append({
            "count": count,
            "book_id": book.book_id,
            "book_title": book.book_title,
            "book_author": book.book_author,
            "book_publisher_name": book.book_publisher_name,
            "book_isbn": book.book_isbn,
            "book_year_published": book.book_year_published,
            "book_location": book.book_location,
            "book_cover_img": book.book_cover_img,
            "book_category": book.category.book_category,
            "borrows": bookBorrowCount(book.book_id),
            "onshelf": booksOnShelf(book.book_id),
            "date_added": book.date_added.strftime("%Y-%m-%d")
        })

    filteredBooks = jsonify({"data": data})
    return filteredBooks

def bookBorrowCount(book_id):
    count = BorrowedBooksDetail.query.filter_by(book_id=book_id).count()
    return count

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
        response = str(e)

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
            "borrow_detail_id":row.borrow_detail_id,
            "book": row.book.book_title,
            "author": row.book.book_author,
            "qty": row.qty,
            "action": ""
        })

    response = {"data": data}
    return jsonify(response)

@views.route('/books/borrow/data', methods=['GET', 'POST'])
@login_required
def borrow_data():
    # borrowId = request.form.get('borrowId')

    count=0
    data = []
    borrow_data = BorrowedBooks.query.filter_by().all()
    for row in borrow_data:
        count += 1

        if row.status == "B":
            status = "Borrowed"
        elif row.status == "R":
            status = "Returned"
        else:
            status = "Saved"

        data.append({
            "count": count,
            "borrow_id": row.borrow_id,
            "borrower":row.user.fname +" "+ row.user.mname +" "+ row.user.lname,
            "date_borrowed": row.date_borrowed.strftime("%Y-%m-%d"),
            "status": status,
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

    if borrow_details.status == "B":
        status = "Borrowed"
    elif borrow_details.status == "R":
        status = "Returned"
    else:
        status = "Saved"

    data = {
        "user_id": borrow_details.user_id,
        "status": status,
        "date_borrowed": borrow_details.date_borrowed.strftime("%Y-%m-%d")
    }

    return jsonify({ "data": data })

@views.route('/books/borrow/destroy', methods=['POST'])
@login_required
def delete_borrowed_item():
    requestData = json.loads(request.data)
    requestID = requestData['borrowId'] 
    borrow = BorrowedBooks.query.get(requestID)

    db.session.query(BorrowedBooksDetail).filter(BorrowedBooksDetail.borrow_id == requestID).delete(synchronize_session=False)
    db.session.delete(borrow)
    db.session.commit()

    return jsonify({})

@views.route('/books/borrow/detail/destroy', methods=['POST'])
@login_required
def delete_borrowed_detail_item():
    requestData = json.loads(request.data)
    requestID = requestData['detailId'] 
    borrow = BorrowedBooksDetail.query.get(requestID)
    db.session.delete(borrow)
    db.session.commit()

    return jsonify({})

@views.route('/books/recommendations', methods=['POST','GET'])
@login_required
def books_recommendations():
    requestData = json.loads(request.data)
    requestID = requestData['user_id'] 

    data = collab_filter_algo(requestID)
    return jsonify({ "data": data })

def collab_filter_algo(user_id):
    train_data = prepare_data()
    df = pd.DataFrame(train_data, columns=['user_id', 'book_id'])
    top_n_book_ids = get_recommendations(user_id, df, 5)

    data = []
    for ids in top_n_book_ids:
        book = Books.query.filter_by(book_id=ids).first()
        if book:
            data.append({
                "book_id": book.book_id,
                "book_title": book.book_title,
                "book_author": book.book_author,
                "book_publisher_name": book.book_publisher_name,
                "book_isbn": book.book_isbn,
                "book_year_published": book.book_year_published,
                "book_location": book.book_location,
                "book_cover_img": book.book_cover_img,
                "book_category": book.category.book_category,
                "borrows": bookBorrowCount(book.book_id),
                "onshelf": booksOnShelf(book.book_id),
                "date_added": book.date_added.strftime("%Y-%m-%d")
            })
    return data

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def booksOnShelf(book_id):
    book = Books.query.filter_by(book_id=book_id).first()
    total_books_borrowed = BorrowedBooksDetail.get_total_qty(book_id)

    if book is None:
        bqty = 0
    else:
        bqty = float(book.book_qty)

    if total_books_borrowed is None:
        bBorrowed = 0
    else:
        bBorrowed = float(total_books_borrowed)

    remaining = bqty - bBorrowed
    return remaining

def prepare_data():
    data = []
    headers = BorrowedBooks.query.all()
    for header in headers:
        details = BorrowedBooksDetail.query.filter_by(borrow_id = header.borrow_id)
        for detail in details:
            data.append((header.user_id,detail.book_id))
    books = Books.query.all()
    # for book in books:
    #     data.append((0,book.book_id))
    return data

def get_recommendations(user_id, df, num_recommendations):
    # Get the user's book IDs
    user_book_ids = df[df['user_id'] == user_id]['book_id'].tolist()
    
    # Get the books the user has not rated
    unrated_books = df[~df['book_id'].isin(user_book_ids)]
    
    # Create a pivot table of the user's book IDs
    pivot = pd.crosstab(index=df['book_id'], columns=df['user_id'], values=df['book_id'], aggfunc='count', normalize='index')
    
    # Get the cosine similarity between the pivot table and itself
    similarity = cosine_similarity(pivot, pivot)
    
    # Map the similarity to the unrated books
    similarity_map = pd.DataFrame(similarity, index=pivot.index, columns=pivot.index)
    similarity_map = similarity_map.sort_values(by=similarity_map.columns[0], ascending=False)

    # Get the top N most similar books to the pivot
    top_n = similarity_map[unrated_books['book_id']].head(num_recommendations)
    # Get the top N most similar books' IDs
    top_n_book_ids = top_n.index.tolist()
    
#     # Connect to the database
#     engine = create_engine('sqlite:///books.db')
    
#     # Query the database for book information
#     books = pd.read_sql_table('books', engine)
    
#     # Get the top N most similar books' titles
#     top_n_titles = books[books['book_id'].isin(top_n_book_ids)]['title']
    
    return top_n_book_ids