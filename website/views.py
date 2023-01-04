from flask import Blueprint, render_template, request, flash, jsonify, redirect, url_for
from flask_login import login_required, current_user
from .models import User, Student, Category, AutismPrediction
from . import db
import json
from sqlalchemy import desc

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

# @views.route('/asd/prediction', methods=['GET', 'POST'])
# @login_required
# def asd_prediction():
#     if request.method == 'POST':
#         student = request.form.get('student')
#         sign = request.form.get('p_sign')
#         status = request.form.get('status')

#         predict = AutismPrediction(autism_sign_id=sign, student_id=student, status=status)
#         db.session.add(predict)
#         db.session.commit()

#         flash('Predicition added!', category='success')
#         return redirect(url_for('views.asd_prediction'))

#     students = Student.query.all()
#     signs = Category.query.all()
#     predictions = AutismPrediction.query.order_by(desc(AutismPrediction.ap_id)).all()
#     return render_template("asd_prediction.html", user=current_user, students=students, signs=signs, predictions=predictions)

# @views.route('/student', methods=['GET', 'POST'])
# @login_required
# def student():
#     if request.method == 'POST':
#         fname = request.form.get('first_name')
#         mname = request.form.get('middle_name')
#         lname = request.form.get('last_name')
#         year = request.form.get('year')
#         section = request.form.get('section')
#         address = request.form.get('address')
#         contact = request.form.get('contact')

#         student = Student(student_fname=fname, student_mname=mname, student_lname=lname, student_year=year, student_section=section, student_address=address, student_contact_number=contact)
#         db.session.add(student)
#         db.session.commit()

#         flash('Student added!', category='success')
#         return redirect(url_for('views.student'))

#     students = Student.query.all()
#     return render_template("student.html", user=current_user, students=students)

# @views.route('/asd/signs/destroy', methods=['POST'])
# @login_required
# def delete_asd_sign():
#     requestData = json.loads(request.data)
#     requestID = requestData['signId'] 
#     asdsign = Category.query.get(requestID)
#     db.session.delete(asdsign)
#     db.session.commit()

#     return jsonify({})

# @views.route('/asd/prediction/destroy', methods=['POST'])
# @login_required
# def delete_asd_prediction():
#     requestData = json.loads(request.data)
#     requestID = requestData['predictId'] 
#     asdpredict = AutismPrediction.query.get(requestID)
#     db.session.delete(asdpredict)
#     db.session.commit()

#     return jsonify({})

@views.route('/books/category/destroy', methods=['POST'])
@login_required
def delete_category():
    requestData = json.loads(request.data)
    requestID = requestData['categoryId'] 
    category = Category.query.get(requestID)
    db.session.delete(category)
    db.session.commit()

    return jsonify({})