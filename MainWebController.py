from flask import Flask, render_template, request
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'webapp'
app.config['MYSQL_PASSWORD'] = 'webapp'
app.config['MYSQL_DB'] = 'baskeball_database'
mysql = MySQL(app)



@app.route('/', methods=['GET'])
def home():
    return render_template('index.html')


@app.route('/testpage', methods=['GET'])
def test():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM useraccounts")
    data = cursor.fetchall()
    cursor.close()
    return render_template('test.html', data=data)


if __name__ == '__main__':
    app.run(debug=True)
