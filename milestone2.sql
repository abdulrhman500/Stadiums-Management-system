
--CREATE DATABASE Project;


CREATE Proc createAllTables AS

	CREATE TABLE Stadium (
		id int Primary Key Identity,
		sname VARCHAR(60),
		slocation VARCHAR(60),
		capacity int,
		is_available BIT,
	)

	CREATE TABLE Club (
		id int Primary Key Identity,
		clocation VARCHAR(60),
		cname VARCHAR(60),
	)

	CREATE TABLE Game (
		id int Primary Key Identity,
		starting_time date,
		end_time date,
		allowed_attendees int,
		stadium_id int FOREIGN KEY REFERENCES Stadium(id),
		guest_id int FOREIGN KEY REFERENCES Club(id),
		hoster_id int FOREIGN KEY REFERENCES Club(id)
	)

	CREATE TABLE SystemUser (
		id int Primary Key Identity,
		username VARCHAR(60),
		uname VARCHAR(60),
		upassword VARCHAR(60),
		urole VARCHAR(60),
	)	

	CREATE TABLE Fan (
		id int Primary Key Identity,
		phone_number int,
		birth_date Date,
		fan_address VARCHAR(60),
		is_blocked BIT,
		FOREIGN KEY (fan_user_id) REFERENCES SystemUser(id)
		)

	CREATE TABLE Manager (
		id int FOREIGN KEY REFERENCES SystemUser(id),
		stadium_id int FOREIGN KEY REFERENCES Stadium(id),
		Primary Key (manager_user_id, stadium_id)
	)

	CREATE TABLE Sports_Association_Manager (
		id int FOREIGN KEY REFERENCES SystemUser(id),
		Primary Key (smanager_user_id)
	)

	CREATE TABLE Representative (
		id int FOREIGN KEY REFERENCES SystemUser(id),
		club_id int FOREIGN KEY REFERENCES Club(id),
		Primary Key (representative_id, club_id)
	)

	CREATE TABLE System_Admin (
		id int FOREIGN KEY REFERENCES SystemUser(id),
		Primary Key (id)
	)

	CREATE TABLE Ticket (
		id int Primary Key Identity,
		is_available BIT,
		fan_id int FOREIGN KEY REFERENCES Fan(id),
	)

	CREATE TABLE Game_Ticket (
		game_id int FOREIGN KEY REFERENCES Game(id),
		ticket_id int FOREIGN KEY REFERENCES Ticket(id),
		Primary KEY (game_id, ticket_id)
	)

	CREATE TABLE Permission (
		id int Primary Key,
		is_approved BIT,
		representative_id int FOREIGN KEY REFERENCES Representative(id),
		manager_id int FOREIGN KEY REFERENCES Manager(id),
		game_id int FOREIGN KEY REFERENCES Game(id),
	)

	
	GO