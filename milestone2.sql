
--CREATE DATABASE Project;
--USE	Project;

GO
CREATE PROC createAllTables AS

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
		FOREIGN KEY (id) REFERENCES SystemUser(id)
		)

	CREATE TABLE Manager (
		id int Primary Key Identity,
		stadium_id int FOREIGN KEY REFERENCES Stadium(id),
		FOREIGN KEY (id) REFERENCES SystemUser(id),
	)

	CREATE TABLE Representative (
		id int Primary Key Identity,
		club_id int FOREIGN KEY REFERENCES Club(id),
		FOREIGN KEY (id) REFERENCES SystemUser(id),
	)

	CREATE TABLE Sports_Association_Manager (
		id int Primary Key Identity,
		FOREIGN KEY (id) REFERENCES SystemUser(id),
	)

	CREATE TABLE System_Admin (
		id int Primary Key Identity,
		FOREIGN KEY (id) REFERENCES SystemUser(id)
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
		game_id int FOREIGN KEY REFERENCES Game(id),
		manager_id int FOREIGN KEY REFERENCES Manager(id),
		representative_id int FOREIGN KEY REFERENCES Representative(id),
	);
	GO

EXEC createAllTables;

GO
CREATE PROC dropAllTables AS
	DROP TABLE IF EXISTS Permission, Game_Ticket, Ticket, System_Admin,
	Representative, Sports_Association_Manager, Manager,
	Fan, SystemUser, Game, Club, Stadium;
GO

EXEC dropAllTables;