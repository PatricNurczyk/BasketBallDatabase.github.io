from flask import Flask, render_template, request
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'flask'
mysql = MySQL(app)


@app.route('/', methods=['GET'])
def home():
    return render_template('index.html')


@app.route('/testpage', methods=['GET'])
def test():
    return "THIS IS ANOTHER PAGE"


if __name__ == '__main__':
    app.run(debug=True)
