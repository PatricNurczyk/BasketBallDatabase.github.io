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

@app.route('/teams', methods=['GET'])
def showTeams():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM team")
    data = cursor.fetchall()
    cursor.close()
    return render_template('show-team.html', data=data)

@app.route('/players', methods=['GET'])
def showPlayers():
    teamID = request.args.get('id', default=1, type=int)
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM player WHERE Team_ID = 6")
    data = cursor.fetchall()
    cursor.close()
    return render_template('show-player.html', data=data)


if __name__ == '__main__':
    app.run(debug=True)
