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
    if not session.get("loggedin"):
        session["loggedin"] = False
    name = ""
    if session["loggedin"]:
        name = f"Welcome {session['username']}"
    return render_template('index.html', username=name)

@app.route('/accounts', methods=['GET'])
def test():
    if session["loggedin"] == False:
        return redirect("/login")
    if session["username"] != "admin":
        return redirect("/")
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM useraccounts")
    data = cursor.fetchall()
    cursor.close()
    return render_template('test.html', data=data)

@app.route('/teams', methods=['GET', 'POST'])
def showTeams():
    if session["loggedin"] == False:
        return redirect("/login")
    cursor = mysql.connection.cursor()
    if request.method == 'POST':
        type = request.form['type']
        query = request.form['query']
        if len(query) == 0:
            cursor.execute("SELECT School, Mascot, wins, losses, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'School':
            query.lower()
            cursor.execute(f"SELECT School, Mascot, wins, losses, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID WHERE LOWER(School) LIKE '%{query}%'")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Mascot':
            cursor.execute(f"SELECT School, Mascot, wins, losses, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID WHERE LOWER(Mascot) LIKE '%{query}%'")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Wins':
            cursor.execute(f"SELECT School, Mascot, wins, losses, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID WHERE wins = {query}")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Loss':
            cursor.execute(f"SELECT School, Mascot, wins, losses, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID WHERE losses = {query}")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
    cursor.execute("SELECT School, Mascot, wins, losses, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID")
    data = cursor.fetchall()
    cursor.close()
    return render_template('show-team.html', data=data)

@app.route('/players', methods=['GET', 'POST'])
def showPlayers():
    if session["loggedin"] == False:
        return redirect("/login")
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
    if session["loggedin"]:
        return redirect("/")
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
    session["loggedin"] = False
    session.pop("username", None)
    return redirect("/")


@app.route('/register', methods=['GET', 'POST'])
def register():
    if session["loggedin"] == True:
        return redirect("/")
    if request.method == 'POST':
        username = request.form['username']
        password = generate_password_hash(request.form['password'])
        cur = mysql.connection.cursor()
        cur.execute(f"INSERT INTO useraccounts(UserName, password) VALUES ('{username}', '{password}')")
        mysql.connection.commit()
        cur.close()
        return redirect("/login")
    return render_template('register.html')

@app.route('/addTeam', methods=['GET', 'POST'])
def addTeam():
    if request.method == 'POST':
        School = request.form['School']
        Mascot = request.form['Mascot']
        Wins = request.form['Wins']
        Losses = request.form['Losses']
        cursor = mysql.connection.cursor()
        cursor.execute(f"INSERT INTO team(School,Mascot,wins,losses) VALUES ('{School}','{Mascot}','{Wins}','{Losses}')")
        mysql.connection.commit()
        cursor.close()
        return redirect("/teams")
    return render_template("add-team.html")

@app.route('/addPlayer', methods=['GET', 'POST'])
def addPlayer():
    cursor = mysql.connection.cursor()
    if request.method == 'POST':
        Name = request.form['PlayerName']
        Number = request.form['Number']
        teamID = request.form['School']
        Height = request.form['Height']
        Weight = request.form['Weight']
        Year = request.form['Year']
        cursor.execute(f"INSERT INTO player(Player_Name, Player_No, Team_ID, Height, Weight, Year_In_School) VALUES ('{Name}','{Number}','{teamID}','{Height}','{Weight}','{Year}')")
        mysql.connection.commit()
        cursor.close()
        return redirect("/players")
    cursor.execute("SELECT Team_ID, School FROM team")
    list = cursor.fetchall()
    cursor.close()
    return render_template("add-player.html", list=list)

@app.route("/addToTeam", methods=['GET'])
def customStarter():
    if session["loggedin"] == False:
        return redirect("/players")
    cursor = mysql.connection.cursor()
    cursor.execute(f"SELECT Team_Name FROM custom_starter WHERE UserName = '{session['username']}'")
    team = cursor.fetchone()
    if not team:
        cursor.close()
        return redirect("/players")
    PlayerID = request.args.get('id', default=1, type=int)
    cursor.execute(f"INSERT INTO contains_player(Team_Name, Player_ID) VALUES('{team[0]}',{PlayerID})")
    mysql.connection.commit()
    cursor.close()
    return redirect("/customTeam")

@app.route("/createTeam", methods=['GET','POST'])
def addCustom():
    if not session['loggedin']:
        return redirect("/")
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        cursor.execute(f"SELECT UserName FROM custom_starter WHERE UserName = '{session['username']}'")
        team = cursor.fetchone()
        if team:
            cursor.close()
            return redirect("/customTeam")
        name = request.form['name']
        cursor.execute(f"INSERT INTO custom_starter(Team_Name, UserName, Ranking) VALUES ('{name}','{session['username']}',0)")
        mysql.connection.commit()
        cursor.close()
        return redirect("/customTeam")
    return render_template("make-custom-team.html")

@app.route("/customTeam", methods=['GET','POST'])
def customTeam():
    if session['loggedin'] == False:
        return redirect("/")
    cursor = mysql.connection.cursor()
    cursor.execute(f"SELECT Team_Name, Ranking FROM custom_starter WHERE UserName = '{session['username']}'")
    team = cursor.fetchone()
    if not team:
        return redirect("/createTeam")
    cursor.execute(f"SELECT p.Player_Name, p.Player_ID FROM custom_starter AS cs INNER JOIN contains_player as pc ON cs.Team_Name = pc.Team_Name INNER JOIN player AS p ON p.Player_ID = pc.Player_ID WHERE cs.UserName = '{session['username']}'")
    roster = cursor.fetchall()
    return render_template("custom-team.html", team=team, roster=roster)

@app.route("/removeCustom", methods=['GET'])
def removeCustom():
    playerID = request.args.get('id', default=1, type=int)
    cursor = mysql.connection.cursor()
    cursor.execute(f"DELETE FROM contains_player WHERE Player_ID = {playerID}")
    mysql.connection.commit()
    cursor.close()
    return redirect("/customTeam")

if __name__ == '__main__':
    app.run(debug=True)