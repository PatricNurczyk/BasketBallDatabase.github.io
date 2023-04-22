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
    cursor.execute("SELECT UserName, Team_Name, Ranking FROM basketball_database.custom_starter ORDER BY Ranking")
    team = cursor.fetchall()
    cursor.close()
    return render_template('test.html', data=data, team=team)


@app.route('/teams', methods=['GET', 'POST'])
def showTeams():
    if session["loggedin"] == False:
        return redirect("/login")
    cursor = mysql.connection.cursor()
    if request.method == 'POST':
        type = request.form['type']
        query = request.form['query']
        if len(query) == 0:
            cursor.execute(
                "SELECT team.Team_ID, School, Mascot, wins, losses, Ranking, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'School':
            query.lower()
            cursor.execute(
                f"SELECT team.Team_ID, School, Mascot, wins, losses, Ranking,  COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID WHERE LOWER(team.School) LIKE '%{query}%' GROUP BY team.Team_ID")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Mascot':
            cursor.execute(
                f"SELECT team.Team_ID, School, Mascot, wins, losses, Ranking,  COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID  WHERE LOWER(team.Mascot) LIKE '%{query}%' GROUP BY team.Team_ID")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Wins':
            cursor.execute(
                f"SELECT team.Team_ID, School, Mascot, wins, losses, Ranking,  COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID  WHERE team.wins = {query} GROUP BY team.Team_ID")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
        elif type == 'Loss':
            cursor.execute(
                f"SELECT team.Team_ID, School, Mascot, wins, losses, Ranking, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID WHERE team.losses = {query} GROUP BY team.Team_ID")
            data = cursor.fetchall()
            cursor.close()
            return render_template('show-team.html', data=data)
    cursor.execute(
        "SELECT team.Team_ID, School, Mascot, wins, losses, Ranking, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID")
    data = cursor.fetchall()
    cursor.close()
    return render_template('show-team.html', data=data)

@app.route('/orderTeams', methods=['GET'])
def teamOrdered():
    if session["loggedin"] == False:
        return redirect("/login")
    cursor = mysql.connection.cursor()
    cursor.execute(
        "SELECT team.Team_ID, School, Mascot, wins, losses, Ranking, COUNT(player.Team_ID) FROM team INNER JOIN player ON team.Team_ID = player.Team_ID GROUP BY team.Team_ID ORDER BY Ranking")
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
    cursor.execute(
        f"SELECT * FROM player INNER JOIN team ON player.Team_ID = team.Team_ID WHERE player.Player_ID = {PlayerID}")
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


@app.route("/login", methods=['GET', 'POST'])
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
        cursor.execute(
            f"INSERT INTO team(School,Mascot,wins,losses) VALUES ('{School}','{Mascot}','{Wins}','{Losses}')")
        mysql.connection.commit()
        cursor.close()
        return redirect("/teams")
    return render_template("add-team.html")


@app.route('/addPlayer', methods=['GET', 'POST'])
def addPlayer():
    if session['username'] != 'admin':
        redirect("/players")
    cursor = mysql.connection.cursor()
    if request.method == 'POST':
        Name = request.form['PlayerName']
        Number = request.form['Number']
        teamID = request.form['School']
        Height = request.form['Height']
        Weight = request.form['Weight']
        Year = request.form['Year']
        cursor.execute(
            f"INSERT INTO player(Player_Name, Player_No, Team_ID, Height, Weight, Year_In_School) VALUES ('{Name}','{Number}','{teamID}','{Height}','{Weight}','{Year}')")
        mysql.connection.commit()
        cursor.close()
        return redirect("/players")
    cursor.execute("SELECT Team_ID, School FROM team")
    list = cursor.fetchall()
    cursor.close()
    return render_template("add-player.html", list=list)

@app.route("/removePlayer", methods=['GET'])
def removePlayer():
    PlayerID = request.args.get('id', default=1, type=int)
    cursor = mysql.connection.cursor()
    cursor.execute(f"DELETE FROM player WHERE Player_ID = {PlayerID}")
    mysql.connection.commit()
    cursor.close()
    return redirect("/teams")

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
    cursor.execute(f"SELECT COUNT(*), custom_starter.Team_Name FROM custom_starter INNER JOIN contains_player ON custom_starter.Team_Name = contains_player.Team_Name WHERE custom_starter.Team_Name = '{team[0]}' GROUP BY Team_Name")
    playerCount = cursor.fetchone()
    if playerCount:
        if int(playerCount[0]) == 5:
            cursor.close()
            return redirect("/players")
        PlayerID = request.args.get('id', default=1, type=int)
        cursor.execute(f"INSERT INTO contains_player(Team_Name, Player_ID) VALUES('{team[0]}',{PlayerID})")
        mysql.connection.commit()
        cursor.close()
        return redirect("/customTeam")
    else:
        PlayerID = request.args.get('id', default=1, type=int)
        cursor.execute(f"INSERT INTO contains_player(Team_Name, Player_ID) VALUES('{team[0]}',{PlayerID})")
        mysql.connection.commit()
        cursor.close()
        return redirect("/customTeam")



@app.route("/createTeam", methods=['GET', 'POST'])
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
        cursor.execute(
            f"INSERT INTO custom_starter(Team_Name, UserName, Ranking) VALUES ('{name}','{session['username']}',0)")
        mysql.connection.commit()
        cursor.close()
        return redirect("/customTeam")
    return render_template("make-custom-team.html")


@app.route("/customTeam", methods=['GET', 'POST'])
def customTeam():
    if session['loggedin'] == False:
        return redirect("/")
    cursor = mysql.connection.cursor()
    cursor.execute(f"SELECT Team_Name, Ranking FROM custom_starter WHERE UserName = '{session['username']}'")
    team = cursor.fetchone()
    if not team:
        return redirect("/createTeam")
    cursor.execute(
        f"SELECT p.Player_Name, p.Player_ID FROM custom_starter AS cs INNER JOIN contains_player as pc ON cs.Team_Name = pc.Team_Name INNER JOIN player AS p ON p.Player_ID = pc.Player_ID WHERE cs.UserName = '{session['username']}'")
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


@app.route("/updateStats", methods=['GET', 'POST'])
def updateStats():
    if session['username'] != 'admin':
        return redirect("/teams")
    cursor = mysql.connection.cursor()
    msg = ""
    if request.method == 'POST':
        WinnerID = request.form['Winner']
        LooserID = request.form['Looser']
        if WinnerID == LooserID:
            msg = "Winner and Looser Must be different."
            cursor.execute("SELECT Team_ID, School FROM team")
            list = cursor.fetchall()
            cursor.close()
            return render_template("update-team.html", list=list, msg=msg)
        if int(WinnerID) > 0:
            cursor.execute(f"SELECT wins, losses FROM team WHERE Team_ID = '{WinnerID}'")
            WinStats = cursor.fetchone()
            cursor.execute(f"UPDATE team SET wins = {WinStats[0] + 1} WHERE Team_ID = '{WinnerID}'")
            mysql.connection.commit()
        if int(LooserID) > 0:
            cursor.execute(f"SELECT wins, losses FROM team WHERE Team_ID = '{LooserID}'")
            LooseStats = cursor.fetchone()
            cursor.execute(f"UPDATE team SET losses = {LooseStats[1] + 1} WHERE Team_ID = '{LooserID}'")
            mysql.connection.commit()
        cursor.close()
        return redirect("/changeRank")
    cursor.execute("SELECT Team_ID, School FROM team")
    list = cursor.fetchall()
    cursor.close()
    return render_template("update-team.html", list=list)

@app.route("/changeRank", methods=['GET'])
def changeRank():
    if session['username'] != 'admin':
        return redirect("/teams")
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Team_ID, wins, losses FROM team")
    teams = cursor.fetchall()
    Ratios = []
    for team in teams:
        if (team[1] + team[2]) == 0:
            winLose = 0
        else:
            winLose = team[1]/(team[1] + team[2])
        Ratios.append([team[0], winLose])
    Ratios.sort(key=lambda x: x[1], reverse=True)
    lastRatio = -1.0
    lastRank = 1
    for rank, team in enumerate(Ratios):
        if team[1] == lastRatio:
            cursor.execute(f"UPDATE team SET Ranking = {lastRank} WHERE Team_ID = {team[0]}")
            mysql.connection.commit()
        else:
            cursor.execute(f"UPDATE team SET Ranking = {rank + 1} WHERE Team_ID = {team[0]}")
            mysql.connection.commit()
            lastRatio = team[1]
            lastRank = rank + 1
    cursor.close()
    return redirect("/customRank")

@app.route("/customRank", methods=['GET'])
def customRank():
    if session['username'] != 'admin':
        return redirect("/teams")
    cursor = mysql.connection.cursor()
    cursor.execute("UPDATE custom_starter SET Ranking = 0 WHERE Team_Name IS NOT NULL")
    mysql.connection.commit()
    cursor.execute("SELECT pc.Team_Name,team.Ranking, player.Player_Name FROM custom_starter AS cs INNER JOIN contains_player AS pc ON cs.Team_Name = pc.Team_Name INNER JOIN player ON pc.Player_ID = player.Player_ID INNER JOIN team ON player.Team_ID = team.Team_ID WHERE cs.Team_Name IN (SELECT Team_Name FROM (SELECT custom_starter.Team_Name, COUNT(custom_starter.Team_Name) AS players FROM custom_starter INNER JOIN contains_player ON custom_starter.Team_Name = contains_player.Team_Name GROUP BY Team_Name) as countteam WHERE players = 5)")
    teamList = cursor.fetchall()
    currentTeam = ""
    totalRank = 0
    rankList = []
    for teamName, rank, pName in teamList:
        if teamName == currentTeam:
            totalRank += rank
        #FIRST ENTRY
        elif currentTeam == "":
            currentTeam = teamName
            totalRank = int(rank)
        #SWAP TO NEW TEAM
        else:
            rankList.append([currentTeam, totalRank])
            currentTeam = teamName
            totalRank = int(rank)
    if totalRank > 0:
        rankList.append([currentTeam, totalRank])
    sorted_lst = sorted(rankList, key=lambda x: x[1])
    lastAmount = -1
    lastRank = 1
    for rank, team in enumerate(sorted_lst):
        if team[1] == lastAmount:
            cursor.execute(f"UPDATE custom_starter SET Ranking = {lastRank} WHERE Team_Name = '{team[0]}'")
            mysql.connection.commit()
        else:
            cursor.execute(f"UPDATE custom_starter SET Ranking = {rank + 1} WHERE Team_Name = '{team[0]}'")
            mysql.connection.commit()
            lastAmount = team[1]
            lastRank = rank + 1
    return redirect("/teams")

if __name__ == '__main__':
    app.run(debug=True)
