from flask import Flask, render_template, request, redirect, session
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = "secretkey"
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'webapp'
app.config['MYSQL_PASSWORD'] = 'webapp'
app.config['MYSQL_DB'] = 'basketball_database'
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

@app.route('/teams', methods=['GET', 'POST'])
def showTeams():
    cursor = mysql.connection.cursor()
    if request.method == 'POST':
        type = request.form['type']
        query = request.form['query']
        if type == 'School':
            query.lower()
            cursor.execute(f"SELECT * FROM team WHERE LOWER(School) LIKE '%{query}%'")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Mascot':
            cursor.execute(f"SELECT * FROM team WHERE LOWER(Mascot) LIKE '%{query}%'")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Wins':
            cursor.execute(f"SELECT * FROM team WHERE wins = {query}")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Loss':
            cursor.execute(f"SELECT * FROM team WHERE losses = {query}")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
    cursor.execute("SELECT School, Mascot, wins, losses, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID")
    data = cursor.fetchall()
    cursor.close()
    return render_template('show-team.html', data=data)

@app.route('/players', methods=['GET', 'POST'])
def showPlayers():
    cursor = mysql.connection.cursor()
    if request.method == 'POST':
        type = request.form['type']
        query = request.form['query']
        if type == 'name':
            query.lower()
            cursor.execute(f"SELECT * FROM player WHERE LOWER(Player_Name) LIKE '%{query}%'")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-player.html', data=data)
        elif type == 'p-num':
            cursor.execute(f"SELECT * FROM player WHERE Player_No = {query}")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-player.html', data=data)
        elif type == 'height':
            cursor.execute(f"SELECT * FROM player WHERE Height = {query}")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-player.html', data=data)
        elif type == 'weight':
            cursor.execute(f"SELECT * FROM player WHERE Weight = {query}")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-player.html', data=data)
        elif type == 'year':
            cursor.execute(f"SELECT * FROM player WHERE Year_In_School = {query}")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-player.html', data=data)
    teamID = request.args.get('id', default=1, type=int)
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM player WHERE Team_ID = %s", [teamID])
    data = cursor.fetchall()
    cursor.close()
    return render_template('show-player.html', data=data)


@app.route("/moreinfo", methods=['GET'])
def moreInfo():
    PlayerID = request.args.get('id', default=1, type=int)
    cursor = mysql.connection.cursor()
    cursor.execute(f"SELECT * FROM player INNER JOIN team ON player.Team_ID = team.Team_ID WHERE player.Player_ID = {PlayerID}")
    data = cursor.fetchall()
    cursor.close()
    return render_template("more-info.html", data=data)

@app.route("/average", methods=['GET'])
def average():
    type = request.args.get('type', default='Height', type=str)
    id = request.args.get('id', default=1, type=int)
    cursor = mysql.connection.cursor()
    cursor.execute(f"SELECT AVG({type}) FROM player WHERE Team_ID = {id}")
    data = cursor.fetchall()
    cursor.close()
    return render_template("average.html", data=data)

@app.route("/login", methods=['GET','POST'])
def login():
    msg = ""
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = mysql.connection.cursor()
        cursor.execute(f"SELECT * FROM useraccounts WHERE UserName = '{username}'")
        record = cursor.fetchone()
        cursor.close()
        if record and check_password_hash(record[1], password):
            session['loggedin'] = True
            session['username'] = record[0]
            return redirect("/")
        else:
            msg = "Incorrect User Credentials"
    return render_template("login.html", msg=msg)

@app.route("/logout", methods=['GET'])
def logout():
    session.pop("loggedin", None)
    session.pop("username", None)
    return redirect("/")


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = generate_password_hash(request.form['password'])
        cur = mysql.connection.cursor()
        cur.execute(f"INSERT INTO useraccounts(UserName, password) VALUES ('{username}', '{password}')")
        mysql.connection.commit()
        cur.close()
        return redirect("/login")
    return render_template('register.html')



if __name__ == '__main__':
    app.run(debug=True)
