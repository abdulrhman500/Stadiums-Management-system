/*
EXEC dropAllTables;
EXEC createAllTables;

EXEC dropAllProceduresFunctionsViews;
DROP PROC dropAllProceduresFunctionsViews;
*/



--CREATE DATABASE DBProject;
--USE DBProject;

GO
CREATE PROC createAllTables AS

	CREATE TABLE Stadium (
		id int Primary Key Identity,
		sname VARCHAR(20) UNIQUE,
		slocation VARCHAR(20),
		capacity int,
		is_available BIT DEFAULT 1
	)

	CREATE TABLE Club (
		id int Primary Key Identity,
		cname VARCHAR(20) UNIQUE,
		clocation VARCHAR(20),
	)

	CREATE TABLE Game (
		id int Primary Key Identity,
		f_club VARCHAR(20) FOREIGN KEY REFERENCES Club(cname),
		s_club VARCHAR(20) FOREIGN KEY REFERENCES Club(cname),
		h_club VARCHAR(20) FOREIGN KEY REFERENCES Club(cname),
		starting_time datetime,
--		end_time datetime,
		sname VARCHAR(20) FOREIGN KEY REFERENCES Stadium(sname) ON UPDATE CASCADE,
	)

	CREATE TABLE SystemUser (
		id int Primary Key Identity,
		uname VARCHAR(20),
		username VARCHAR(20),
		upassword VARCHAR(20),
	)	

	CREATE TABLE Fan (
		national_id int Primary Key,
		birth_date Date,
		fan_address VARCHAR(100),
		phone_number int,
		is_blocked BIT DEFAULT 0,
		FOREIGN KEY (national_id) REFERENCES SystemUser(id)
		ON DELETE CASCADE ON UPDATE CASCADE,
		)
	
	CREATE TABLE Manager (
		id int Primary Key,
		sname VARCHAR(20) FOREIGN KEY REFERENCES Stadium(sname)
		ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY (id) REFERENCES SystemUser(id)
		ON DELETE CASCADE ON UPDATE CASCADE
	)

	CREATE TABLE Representative (
		id int Primary Key,
		cname VARCHAR(20) FOREIGN KEY REFERENCES Club(cname)
		ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY (id) REFERENCES SystemUser(id)
		ON DELETE CASCADE ON UPDATE CASCADE
	)

	CREATE TABLE Sports_Association_Manager (
		id int Primary Key,
		FOREIGN KEY (id) REFERENCES SystemUser(id)
		ON DELETE CASCADE ON UPDATE CASCADE
	)

	CREATE TABLE System_Admin (
		id int Primary Key,
		FOREIGN KEY (id) REFERENCES SystemUser(id)
		ON DELETE CASCADE ON UPDATE CASCADE
	)

	CREATE TABLE Ticket (
		id int Primary Key Identity,
		game_id int FOREIGN KEY REFERENCES Game(id) ON DELETE CASCADE,
		fan_id int FOREIGN KEY REFERENCES Fan(national_id) ON UPDATE CASCADE,
		is_available BIT,
	)

	CREATE TABLE Request (
		id int Primary Key,
		is_approved BIT,
		game_id int FOREIGN KEY REFERENCES Game(id) ON DELETE CASCADE,
		manager_id int FOREIGN KEY REFERENCES Manager(id),
		representative_id int FOREIGN KEY REFERENCES Representative(id)
	);
	GO

CREATE PROC dropAllTables AS
	DROP TABLE IF EXISTS Request, Ticket, System_Admin,
	Representative, Sports_Association_Manager, Manager,
	Fan, SystemUser, Game, Club, Stadium;
GO

CREATE PROC dropAllProceduresFunctionsViews AS
	DROP PROC IF EXISTS createAllTables, dropAllTables, clearAllTables,
	addAssociationManager, addNewMatch, deleteMatch, deleteMatchesOnStadium,
	addClub, addTicket, deleteClub, addStadium, deleteStadium, blockFan,
	unblockFan, addRepresentative, addHostRequest, addStadiumManager,
	acceptRequest, rejectRequest, addFan, purchaseTicket, updateMatchHost,
	deleteMatchesOnStadium;
	DROP VIEW IF EXISTS allAssocManagers, allClubRepresentatives,
	allStadiumManagers, allFans, allMatches, allTickets, allCLubs,
	allStadiums, allRequests, clubsWithNoMatches,
	matchesPerTeam, clubsNeverMatched;
	DROP FUNCTION IF EXISTS allUnassignedMatches, viewAvailableStadiumsOn, 
	allPendingRequests,upcomingMatchesOfClub, availableMatchesToAttend
	,clubsNeverPlayed, matchWithHighestAttendance, matchesRankedByAttendance
	,requestsFromClub;
	GO

/*
INSERT INTO SystemUser VALUES 
('sss', 'ssss', 'sssss');
DELETE FROM SystemUser;
SELECT * FROM SystemUser;
INSERT INTO Sports_Association_Manager VALUES
	(3);
DELETE FROM Sports_Association_Manager;
SELECT * FROM Sports_Association_Manager;
	*/

GO
CREATE PROC clearAllTables AS
    DELETE FROM Request;
	DELETE FROM Ticket;
	DELETE FROM SystemUser;
	DELETE FROM Game;
	DELETE FROM Club;
	DELETE FROM Stadium;
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
	JOIN Club C ON C.cname = r.cname;
GO

CREATE VIEW allStadiumManagers AS
    SELECT su.username, su.uname, S.sname
    FROM Manager M
    JOIN SystemUser SU ON SU.id = M.id
	JOIN Stadium S ON S.sname = M.sname;
GO

CREATE VIEW allFans AS
    SELECT SU.uname, F.national_id, F.birth_date, F.is_blocked
    FROM Fan F
    JOIN SystemUser SU ON SU.id = F.national_id;
GO

CREATE VIEW allMatches AS
    SELECT f_club, s_club, h_club, starting_time
    FROM Game G
GO

CREATE VIEW allTickets AS
    SELECT g.f_club, g.s_club, S.sname, g.starting_time
    FROM Ticket T
	JOIN Game G ON T.game_id = G.id
	JOIN Stadium S ON S.sname = G.sname;
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
    SELECT SU1.uname User1, SU2.uname User2, RE.is_approved
    FROM Request Re
	JOIN Representative R ON R.id = Re.id
	JOIN SystemUser SU1 ON SU1.id = R.id
	JOIN Manager M ON RE.manager_id = M.id
	JOIN SystemUser SU2 ON SU2.id = RE.id;
GO

CREATE PROCEDURE addAssociationManager 
	@uname varchar(20), @username varchar(20), @password varchar(20) AS

	INSERT INTO SystemUser VALUES 
	(@uname, @username, @password);
	DECLARE @id int = (SELECT su.id FROM SystemUser su
					WHERE su.uname = @uname AND su.username = @username);
    INSERT INTO Sports_Association_Manager VALUES
	(@id);
GO

CREATE PROCEDURE addNewMatch
	@f_club varchar(20), @s_club varchar(20), @h_club varchar(20),
	@time datetime AS

    INSERT INTO Game VALUES
	(@f_club, @s_club, @h_club, @time, null);
GO

CREATE VIEW clubsWithNoMatches AS
    SELECT c.cname FROM Club C
	EXCEPT
	SELECT g1.f_club FROM Game g1
	EXCEPT
	SELECT g2.s_club FROM Game g2;
GO

CREATE PROCEDURE deleteMatch 
	@f_club varchar(20), @s_club varchar(20), @h_club varchar(20) AS

    DELETE Game WHERE f_club = @f_club AND s_club = @s_club
	AND h_club = @h_club;
GO

CREATE PROCEDURE deleteMatchesOnStadium 
	@stadium varchar(20) AS

    DELETE FROM Game WHERE sname = @stadium;
GO

CREATE PROCEDURE addClub 
	@cname varchar(20), @clocation varchar(20) AS
    
    INSERT INTO Club VALUES 
	(@cname, @clocation);
GO

CREATE PROCEDURE addTicket 
	@h_club varchar(20), @c_club varchar(20), @time datetime AS
    DECLARE @game_id int = (SELECT id FROM Game 
					WHERE (h_club = @h_club) AND (f_club = @c_club OR s_club = @c_club));
    INSERT INTO Ticket (game_id) VALUES 
	(@game_id);
GO

CREATE PROCEDURE deleteClub 
	@cname varchar(20) AS
        DELETE FROM Game WHERE f_club = @cname OR s_club = @cname;
	DELETE FROM Club WHERE cname = @cname;
GO

CREATE PROCEDURE addStadium 
	@sname varchar(20), @slocation varchar(20), @capacity int AS
    
	INSERT INTO Stadium VALUES
	(@sname, @slocation, @capacity, 1);
GO

CREATE PROCEDURE deleteStadium 
	@sname varchar(20) AS
    
	DELETE FROM Stadium WHERE sname = @sname;
GO

CREATE PROCEDURE blockFan 
	@national_id varchar(20) AS
	
	UPDATE Fan SET is_blocked = 1 
	WHERE national_id = Cast(@national_id AS int);
GO

CREATE PROCEDURE unblockFan 
	@national_id varchar(20) AS
	
	UPDATE Fan SET is_blocked = 0
	WHERE national_id = Cast(@national_id AS int);
GO

CREATE PROCEDURE addRepresentative 
	@uname varchar(20), @cname varchar(20), @username varchar(20),
	@password varchar(20) AS
    
	INSERT INTO SystemUser VALUES
	(@uname, @username, @password);
	DECLARE @id int = (SELECT su.id FROM SystemUser su
					WHERE su.uname = @uname AND su.username = @username);
	INSERT INTO Representative VALUES
	(@id, @cname);
GO


CREATE FUNCTION viewAvailableStadiumsOn 
	(@time DATETIME)
	RETURNS TABLE

	RETURN (SELECT s.sname, s.slocation, s.capacity
			FROM Stadium s
			WHERE s.is_available = 1 
			AND NOT s.sname IN (SELECT g.sname
								FROM Game g	
								WHERE s.sname = g.sname
								AND g.starting_time = @time))
GO

/*
CREATE PROCEDURE addHostRequest AS
    SELECT *
    FROM;
GO

CREATE FUNCTION allUnassignedMatches AS
    SELECT *
    FROM;
GO

CREATE PROCEDURE addStadiumManager AS
    SELECT *
    FROM;
GO

CREATE FUNCTION allPendingRequests AS
    SELECT *
    FROM;
GO

CREATE PROCEDURE acceptRequest AS
    SELECT *
    FROM;
GO

CREATE PROCEDURE rejectRequest AS
    SELECT *
    FROM;
GO

CREATE PROCEDURE addFan
	@uname varchar(20), @national_id varchar(20), @time datetime,
	@address varchar(20), @phone int AS

	SET IDENTITY_INSERT SystemUser ON;
    INSERT INTO SystemUser VALUES
	(CAST(@national_id AS INT), @uname, null, null);
	INSERT INTO Fan VALUES
	(CAST(@national_id AS INT), @time, @address, @phone, 0);
	SET IDENTITY_INSERT SystemUser OFF;
GO

CREATE FUNCTION upcomingMatchesOfClub AS
    SELECT *
    FROM;
GO

CREATE FUNCTION availableMatchesToAttend AS
    SELECT *
    FROM;
GO

CREATE PROCEDURE purchaseTicket AS
    SELECT *
    FROM;
GO

CREATE PROCEDURE updateMatchHost AS
    SELECT *
    FROM;
GO

CREATE VIEW matchesPerTeam AS
    SELECT *
    FROM;
GO

CREATE VIEW clubsNeverMatched AS
    SELECT *
    FROM;
GO

CREATE FUNCTION clubsNeverPlayed AS
    SELECT *
    FROM;
GO

CREATE FUNCTION matchWithHighestAttendance AS
    SELECT *
    FROM;
GO

CREATE FUNCTION matchesRankedByAttendance AS
    SELECT *
    FROM;
GO

CREATE FUNCTION requestsFromClub AS
    SELECT *
    FROM;
GO

*/
