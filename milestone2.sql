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

	CREATE TABLE SystemUser (
		username VARCHAR(20),
		name VARCHAR(20),
		password VARCHAR(20),

		constraint SyU_PK primary key(username)
	)	

	CREATE TABLE Stadium (
		id int Identity,
		name VARCHAR(20) UNIQUE,
		location VARCHAR(20),
		capacity int,
		is_available BIT DEFAULT 1,

		constraint St_PK primary key(id)
	)

	CREATE TABLE Club (
		id int Identity,
		name VARCHAR(20) UNIQUE,
		location VARCHAR(20),

		constraint cl_PK primary key(id)
	)

	CREATE TABLE Match (
		id int Identity,
		guest_club int,
		host_club int ,
		starting_time datetime,
		end_time datetime,
		stadium_id int ,
	
		constraint Ma_PK primary key (id),
		constraint Ma_GC_FK FOREIGN KEY(guest_club) REFERENCES Club(id) on update cascade ,
		constraint Ma_HC_FK FOREIGN KEY(host_club) REFERENCES Club(id) on delete set null ,
		constraint Ma_si_FK FOREIGN KEY(stadium_id) REFERENCES stadium(id) on update cascade on delete set null

	)
	


	CREATE TABLE Fan (
		National_id varchar(20),
		username varchar(20),
		phone_no int,
		birth_date Date,
		fan_address VARCHAR(20),
		is_blocked BIT DEFAULT 0,
		constraint Fa_PK primary  KEY (National_id),
		constraint Fa_un_Fk Foreign key (username) REFERENCES SystemUser (username) on delete set null
		)
	
	CREATE TABLE Stadium_Manager (
		id int identity ,
		username varchar(20),
		stadium_id int ,

		constraint sm_PK primary key (id),
		constraint sm_un_FK Foreign key (username) references SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		constraint sm_si_FK Foreign key (stadium_id) references stadium(id) ON DELETE CASCADE ON UPDATE CASCADE

	)

	CREATE TABLE Club_Representative (
		id int identity,
		username varchar(20),
		club_id int ,
		
		constraint sm_PK primary key (id),
		constraint sm_un_FK Foreign key (username) references SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		constraint sm_ci_FK Foreign key (club_id) references club(id) ON DELETE CASCADE ON UPDATE CASCADE

	)

	CREATE TABLE Sports_Association_Manager (
		id int identity ,
		username varchar(20),

		constraint SAM_PK primary key (id),
		constraint SAM_un_FK Foreign key (username) references SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
	
	)

	CREATE TABLE System_Admin (
		id int identity ,
		username varchar(20),

		constraint SA_PK primary key (id),
		constraint SA_un_FK Foreign key (username) references SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
	
	)

	CREATE TABLE Ticket (
		id int Identity,
		Match_id int ,
		is_available BIT ,
	
	constraint Ti_PK primary key(id),
	constraint Ti_mi_FK foreign key(Match_id) references Match(id) on update cascade ON DELETE CASCADE


	)

	CREATE TABLE Request (
		id int identity ,
		is_approved BIT,
		Match_id int ,
		Stadium_Manager_id int ,
		Club_Representative_id int ,

		constraint Re_Pk primary key(id),
		constraint Re_mi_Fk foreign key (Match_id) references  Match (id) on update cascade on delete cascade ,
		constraint Re_cri_Fk foreign key (Club_Representative_id) references Club_Representative  (id)  on update cascade on delete cascade ,
		constraint Re_smi_FK foreign key (Stadium_Manager_id) references Stadium_Manager (id) on update cascade on delete cascade ,
	
	)
	
	create table Ticket_purchase(
		id int identity ,
		Ticket_id int ,
		Fan_id int ,

		constraint Tp_Pk primary key(id),
		constraint Tp_ti_Fk foreign key (Ticket_id) references  Ticket (id) on update cascade on delete cascade ,
		constraint Tp_fi_Fk foreign key (Fan_id) references Fan  (id)  on update cascade on delete cascade 
	);
	GO

CREATE PROC dropAllTables AS
	DROP TABLE IF EXISTS Request, Ticket, System_Admin,
	Club_Representative, Sports_Association_Manager, Stadium_Manager,
	Fan, SystemUser, Match, Club, Stadium;
GO


CREATE PROC dropAllProceduresFunctionsViews AS
	DROP PROC IF EXISTS createAllTables, dropAllTables, clearAllTables,
	addAssociationStadium_Manager, addNewMatch, deleteMatch, deleteMatchesOnStadium,
	addClub, addTicket, deleteClub, addStadium, deleteStadium, blockFan,
	unblockFan, addRepresentative, addHostRequest, addStadiumStadium_Manager,
	acceptRequest, rejectRequest, addFan, purchaseTicket, updateMatchHost,
	deleteMatchesOnStadium;
	DROP VIEW IF EXISTS allAssocStadium_Managers, allClubRepresentatives,
	allStadiumStadium_Managers, allFans, allMatches, allTickets, allCLubs,
	allStadiums, allRequests, clubsWithNoMatches,
	matchesPerTeam, clubsNeverMatched;
	DROP FUNCTION IF EXISTS allUnassignedMatches, viewAvailableStadiumsOn, 
	allPendingRequests,upcomingMatchesOfClub, availableMatchesToAttend
	,clubsNeverPlayed, matchWithHighestAttendance, matchesRankedByAttendance
	,requestsFromClub;
	GO

CREATE PROC clearAllTables AS
    TRUNCATE TABLE Request;
	TRUNCATE TABLE System_Admin;
	TRUNCATE TABLE Ticket;
	TRUNCATE TABLE Sports_Association_Manager;
	TRUNCATE TABLE Club_Representative;
	TRUNCATE TABLE Fan;
	TRUNCATE TABLE Stadium_Manager;
	TRUNCATE TABLE SystemUser;
	TRUNCATE TABLE Match;
	TRUNCATE TABLE Club;
	TRUNCATE TABLE Stadium;
	GO

CREATE VIEW allAssocStadium_Managers AS
    SELECT SU.username, SU.uname
    FROM Sports_Association_Manager SAM
    JOIN SystemUser SU ON SU.id = SAM.id;
GO

CREATE VIEW allClubRepresentatives AS
    SELECT su.username, su.uname, c.cname
    FROM Club_Representative R
    JOIN SystemUser SU ON SU.id = R.id
	JOIN Club C ON C.cname = r.cname;
GO

CREATE VIEW allStadiumStadium_Managers AS
    SELECT su.username, su.uname, S.sname
    FROM Stadium_Manager M
    JOIN SystemUser SU ON SU.id = M.id
	JOIN Stadium S ON S.sname = M.sname;
GO

CREATE VIEW allFans AS
    SELECT SU.uname, F.id, F.birth_date, F.is_blocked
    FROM Fan F
    JOIN SystemUser SU ON SU.id = F.id;
GO

CREATE VIEW allMatches AS
    SELECT f_club, s_club, h_club, starting_time
    FROM Match G
GO

CREATE VIEW allTickets AS
    SELECT g.f_club, g.s_club, S.sname, g.starting_time
    FROM Ticket T
	JOIN Match G ON T.Match_id = G.id
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
	JOIN Club_Representative R ON R.id = Re.id
	JOIN SystemUser SU1 ON SU1.id = R.id
	JOIN Stadium_Manager M ON RE.Stadium_Manager_id = M.id
	JOIN SystemUser SU2 ON SU2.id = RE.id;
GO

CREATE PROCEDURE addAssociationStadium_Manager 
	@uname varchar(20), @username varchar(20), @password varchar(20) AS

	INSERT INTO SystemUser VALUES 
	(@uname, @username, @password, 'AStadium_Manager');
	DECLARE @id int = (SELECT su.id FROM SystemUser su
					WHERE su.uname = @uname AND su.username = @username);
    INSERT INTO Sports_Association_Manager VALUES
	(@id);
GO

CREATE PROCEDURE addNewMatch
	@f_club varchar(20), @s_club varchar(20), @h_club varchar(20),
	@time datetime AS

    INSERT INTO Match VALUES
	(@f_club, @s_club, @h_club, @time, null);
GO

CREATE VIEW clubsWithNoMatches AS
    SELECT c.cname FROM Club C
	EXCEPT
	SELECT g1.f_club FROM Match g1
	EXCEPT
	SELECT g2.s_club FROM Match g2;
GO

CREATE PROCEDURE deleteMatch 
	@f_club varchar(20), @s_club varchar(20), @h_club varchar(20) AS

    DELETE Match WHERE f_club = @f_club AND s_club = @s_club
	AND h_club = @h_club;
GO

CREATE PROCEDURE deleteMatchesOnStadium 
	@stadium varchar(20) AS

    DELETE FROM Match WHERE sname = @stadium;
GO

CREATE PROCEDURE addClub 
	@cname varchar(20), @clocation varchar(20) AS
    
    INSERT INTO Club VALUES 
	(@cname, @clocation);
GO

CREATE PROCEDURE addTicket 
	@h_club varchar(20), @c_club varchar(20), @time datetime AS
    DECLARE @Match_id int = (SELECT id FROM Match 
					WHERE (h_club = @h_club) AND (f_club = @c_club OR s_club = @c_club));
    INSERT INTO Ticket (Match_id) VALUES 
	(@Match_id);
GO

CREATE PROCEDURE deleteClub 
	@cname varchar(20) AS
    
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
	@id varchar(20) AS
	
	UPDATE Fan SET is_blocked = 1 
	WHERE id = Cast(@id AS int);
GO

CREATE PROCEDURE unblockFan 
	@id varchar(20) AS
	
	UPDATE Fan SET is_blocked = 0
	WHERE id = Cast(@id AS int);
GO

CREATE PROCEDURE addRepresentative 
	@uname varchar(20), @cname varchar(20), @username varchar(20),
	@password varchar(20) AS
    
	INSERT INTO SystemUser VALUES
	(@uname, @username, @password, 'Club_Representative');
	DECLARE @id int = (SELECT su.id FROM SystemUser su
					WHERE su.uname = @uname AND su.username = @username);
	INSERT INTO Club_Representative VALUES
	(@id, @cname);
GO


CREATE FUNCTION viewAvailableStadiumsOn 
	(@time DATETIME)
	RETURNS TABLE

	RETURN (SELECT s.sname, s.slocation, s.capacity
			FROM Stadium s
			WHERE s.is_available = 1 
			AND NOT s.sname IN (SELECT g.sname
								FROM Match g	
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

CREATE PROCEDURE addStadiumStadium_Manager AS
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

CREATE PROCEDURE addFan AS
    SELECT *
    FROM;
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

CREATE PROCEDURE deleteMatchesOnStadium AS
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