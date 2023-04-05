CREATE DATABASE basketball_database;
CREATE TABLE Team(
	Team_ID INT NOT NULL AUTO_INCREMENT,
    School VARCHAR(64),
    Mascot VARCHAR(64),
    Win_Loss_Ratio decimal(4,2),
    Ranking INT,
    primary key(Team_ID)
    );
CREATE TABLE Player(
	Player_ID INT NOT NULL AUTO_INCREMENT,
    Player_No INT,
    Team_ID INT,
    Height DECIMAL(4,1),
    Weight DECIMAL(4,1),
    Year_In_School INT,
    primary key(Player_ID),
    foreign key(Team_ID) REFERENCES Team(Team_ID)
    );
    
CREATE TABLE UserAccounts(
	UserName Varchar(64),
    Password Varchar(64),
    Primary Key(UserName)
    );

CREATE TABLE Custom_Starter(
	Team_Name Varchar(64),
    UserName varchar(64),
    Ranking INT,
    Primary key(Team_Name, UserName),
    foreign key(UserName) references UserAccounts(UserName)
    );
    
CREATE TABLE Contains_Player(
	Team_Name varchar(64),
    Player_ID INT,
    primary key(Team_Name, Player_ID),
    foreign key(Team_Name) references Custom_Starter(Team_Name),
    foreign key(Player_ID) references Player(Player_ID)
    );