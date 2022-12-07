
--CREATE DATABASE Project;
--USE	Project;

GO
CREATE PROC createAllTables AS

	CREATE TABLE Stadium (
		id int Primary Key Identity,
		sname VARCHAR(20),
		slocation VARCHAR(20),
		capacity int,
		is_available BIT,
	)

	CREATE TABLE Club (
		id int Primary Key Identity,
		cname VARCHAR(20),
		clocation VARCHAR(20),
	)

	CREATE TABLE Game (
		id int Primary Key Identity,
		f_club VARCHAR(20) FOREIGN KEY REFERENCES Club(id),
		s_club VARCHAR(20) FOREIGN KEY REFERENCES Club(id),
		h_club VARCHAR(20),
		starting_time date,
--		end_time date,
		stadium_id int FOREIGN KEY REFERENCES Stadium(id),
	)

	CREATE TABLE SystemUser (
		id int Primary Key Identity,
		uname VARCHAR(20),
		username VARCHAR(20),
		upassword VARCHAR(20),
		urole VARCHAR(20),
	)	

	CREATE TABLE Fan (
		id int Primary Key,
		phone_number int,
		birth_date Date,
		fan_address VARCHAR(100),
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
		game_id int FOREIGN KEY REFERENCES Game(id),
		fan_id int FOREIGN KEY REFERENCES Fan(id),
		is_available BIT,
	)

	CREATE TABLE Request (
		id int Primary Key,
		is_approved BIT,
		game_id int FOREIGN KEY REFERENCES Game(id),
		manager_id int FOREIGN KEY REFERENCES Manager(id),
		representative_id int FOREIGN KEY REFERENCES Representative(id),
	);
	GO

--EXEC createAllTables;

CREATE PROC dropAllTables AS
	DROP TABLE IF EXISTS Request, Ticket, System_Admin,
	Representative, Sports_Association_Manager, Manager,
	Fan, SystemUser, Game, Club, Stadium;
GO

--EXEC dropAllTables;

CREATE PROC dropAllProceduresFunctionsViews AS
	DROP PROC IF EXISTS createAllTables, dropAllTables, clearAllTables,
	addAssociationManager, addNewMatch, deleteMatch, deleteMatchesOnStadium,
	addClub, addTicket, deleteClub, addStadium, deleteStadium, blockFan,
	unblockFan, addRepresentative, addHostRequest, addStadiumManager,
	acceptRequest, rejectRequest, addFan, purchaseTicket, updateMatchHost,
	deleteMatchesOnStadium;
	DROP VIEW IF EXISTS allAssocManagers, allClubRepresentatives,
	allStadiumManagers, allFans, allMatches, allTickets, allCLubs,
	allStadiums, allRequests, clubsWithNoMatches, viewAvailableStadiumsOn
	, matchesPerTeam, clubsNeverMatched;
	DROP FUNCTION IF EXISTS allUnassignedMatches, allPendingRequests,
	upcomingMatchesOfClub, availableMatchesToAttend, clubsNeverPlayed,
	matchWithHighestAttendance, matchesRankedByAttendance, requestsFromClub;
	GO

CREATE PROC clearAllTables AS
    TRUNCATE TABLE Request;
	TRUNCATE TABLE System_Admin;
	TRUNCATE TABLE Ticket;
	TRUNCATE TABLE Sports_Association_Manager;
	TRUNCATE TABLE Representative;
	TRUNCATE TABLE Fan;
	TRUNCATE TABLE Manager;
	TRUNCATE TABLE SystemUser;
	TRUNCATE TABLE Game;
	TRUNCATE TABLE Club;
	TRUNCATE TABLE Stadium;
	GO

CREATE VIEW allAssocManagers AS
    SELECT SU.username, SU.uname
    FROM Sports_Association_Manager SAM
    JOIN SystemUser SU ON SU.id = SAM.id;
GO

CREATE VIEW allClubRepresentatives AS
    SELECT su.username, su.uname, c.cname
    FROM Representative R
    JOIN SystemUser SU ON SU.id = R.id
	JOIN Club C ON C.id = r.club_id;
GO

CREATE VIEW allStadiumManagers AS
    SELECT su.username, su.uname, S.sname
    FROM Manager M
    JOIN SystemUser SU ON SU.id = M.id
	JOIN Stadium S ON S.id = M.stadium_id;
GO

CREATE VIEW allFans AS
    SELECT SU.uname, F.id, F.birth_date, F.is_blocked
    FROM Fan F
    JOIN SystemUser SU ON SU.id = F.id;
GO

CREATE VIEW allMatches AS
    SELECT f_club, s_club, host_club, starting_time
    FROM Game G
GO

CREATE VIEW allTickets AS
    SELECT g.f_club, g.s_club, S.sname, g.starting_time
    FROM Ticket T
	JOIN Game G ON T.game_id = G.id
	JOIN Stadium S ON S.id = G.stadium_id;
GO

CREATE VIEW allCLubs AS
    SELECT cname, clocation
    FROM Club;
GO

CREATE VIEW allStadiums AS
    SELECT sname, slocation, capacity, is_available
    FROM Stadium S;
GO

CREATE VIEW allRequests AS
    SELECT SU1.uname, SU2.uname,P.is_approved
    FROM Request Re
	JOIN Representative R ON R.representative_id = Re.id
	JOIN SystemUser SU1 ON SU1.id = R.id
	JOIN Manager M ON RE.manager_id = M.id
	JOIN SystemUser SU2 ON SU2.id = P.id;
GO
