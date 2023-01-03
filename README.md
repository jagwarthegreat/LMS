# Library Management System

---

## Setup & Installtion

Make sure you have the latest version of Python installed.

```bash
git clone <repo-url>
```

Make sure you have the latest version of Pip installed.

Install the requirements
```bash
pip install -r requirements.txt
```

## Database Connection

```bash
in website/__init__.py edit SQLALCHEMY_DATABASE_URI value to your mysql connection
mysqlConnection example = mysql://root@localhost/lms
#NOTE: if you have password: mysql://user:password@host/database
```

## Create a virtual environment
 - python -m venv myenv
 - To activate:
 	- myenv\Scripts\activate
 - pip install -r requirements.txt
 - To deactivate:
 	- deactivate

## Running The App

```bash
python main.py
```

OR

Run app directly using the bat
- double click the app.bat and will open chrome and serve the website


## Viewing The App

Go to `http://127.0.0.1:5000`
