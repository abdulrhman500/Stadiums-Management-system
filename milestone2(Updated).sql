/*
drop proc dropAllTables;
EXEC dropAllTables;
EXEC createAllTables;

EXEC dropAllProceduresFunctionsViews;
DROP PROC dropAllProceduresFunctionsViews;
DROP PROC createAllTables;
drop database DBProject

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
		constraint Ma_HC_FK FOREIGN KEY(host_club) REFERENCES Club(id) on delete cascade ,
		constraint Ma_si_FK FOREIGN KEY(stadium_id) REFERENCES stadium(id) on update cascade on delete cascade

	)
	


	CREATE TABLE Fan (
		National_id varchar(20),
		username varchar(20),
		phone_no int,
		birth_date Date,
		fan_address VARCHAR(20),
		is_blocked BIT DEFAULT 0,

		constraint Fa_PK primary  KEY (National_id),
		constraint Fa_un_Fk Foreign key (username) REFERENCES SystemUser (username) on delete cascade
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
		
		constraint cr_PK primary key (id),
		constraint cr_un_FK Foreign key (username) references SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		constraint cr_ci_FK Foreign key (club_id) references club(id) ON DELETE CASCADE ON UPDATE CASCADE

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
		Match_id int not null ,
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
		constraint Re_cri_Fk foreign key (Club_Representative_id) references Club_Representative  (id)  ,
		constraint Re_smi_FK foreign key (Stadium_Manager_id) references Stadium_Manager (id)  ,
	
	)
	
	create table Ticket_purchase(
		id int identity ,
		Ticket_id int ,
		Fan_id varchar(20) ,

		constraint Tp_Pk primary key(id),
		constraint Tp_ti_Fk foreign key (Ticket_id) references  Ticket (id) on update cascade on delete cascade ,
		constraint Tp_fi_Fk foreign key (Fan_id) references Fan  (national_id)  on delete cascade on update cascade  
	);


Go
CREATE PROC dropAllTables AS
	DROP TABLE IF EXISTS 
	Request,
	Ticket_purchase,
	Ticket,
	Club_Representative,
	Sports_Association_Manager, 
	Stadium_Manager,
	Fan,
	System_Admin,
	SystemUser,
	Match,
	Club,
	Stadium ;
	







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
GO
CREATE PROC clearAllTables AS
    DELETE FROM Request;
	DELETE FROM Ticket_purchase;
	DELETE FROM Ticket;
	DELETE FROM Club_Representative;
	DELETE FROM Sports_Association_Manager;
	DELETE FROM Stadium_Manager;
	DELETE FROM Fan;
	DELETE FROM System_Admin;
	DELETE FROM SystemUser;
	DELETE FROM Match;
	DELETE FROM Club;
	DELETE FROM Stadium;
	
GO
CREATE VIEW allAssocManagers AS
    SELECT SU.username, SU.name
    FROM Sports_Association_Manager SAM
    JOIN SystemUser SU ON SU.username = SAM.username;

--select * from allAssocManagers;

GO
--#Edited#
CREATE VIEW allClubRepresentatives AS
    SELECT su.username, su.name, c.name as club_Name
    FROM Club_Representative R
    JOIN SystemUser SU ON SU.username = R.username
	JOIN Club C ON C.id = r.id;
GO
CREATE VIEW allStadiumManagers AS
    SELECT su.username, su.name, S.name as stadium
    FROM Stadium_Manager M
    JOIN SystemUser SU ON SU.username = M.username
	JOIN Stadium S ON S.id = M.stadium_id;
GO
CREATE VIEW allFans AS
    SELECT SU.name, F.National_id, F.birth_date, F.is_blocked
    FROM Fan F
    JOIN SystemUser SU ON SU.username = F.username;


GO
CREATE VIEW allMatches AS
    SELECT M.host_club, M.guest_club, M.starting_time 
    FROM Match M


GO
CREATE VIEW allTickets AS
    SELECT M.host_club, M.guest_club, S.name, M.starting_time
    FROM Ticket T
	JOIN Match M ON T.Match_id = M.id
	JOIN Stadium S ON S.id = M.stadium_id;
GO

CREATE VIEW allCLubs AS
    SELECT name, location
    FROM Club;
GO

CREATE VIEW allStadiums AS
    SELECT name, location, capacity, is_available
    FROM Stadium S;
GO

CREATE VIEW allRequests AS
    SELECT R.username as Club_Representative, M.username as Stadium_Manager, RE.is_approved
    FROM Request Re
	JOIN Club_Representative R ON Re.Club_Representative_id = R.id
	JOIN Stadium_Manager M ON RE.Stadium_Manager_id = M.id;

GO
CREATE PROCEDURE addAssociationManager 
	@uname varchar(20), @username varchar(20), @password varchar(20) AS

	INSERT INTO SystemUser VALUES 
	(@username, @uname, @password);
	INSERT INTO Sports_Association_Manager VALUES
	(@username);
GO

CREATE PROCEDURE addNewMatch
	@host_club varchar(20), @guest_club varchar(20),
	@start_time datetime, @end_time datetime AS

    INSERT INTO Match VALUES
	(@guest_club, @host_club,@starting_time,@end_time, null);
GO
--#Need to be checked ?#
CREATE VIEW clubsWithNoMatches AS
    SELECT c.name FROM Club C
	EXCEPT
	(
	SELECT g1.host_club FROM Match g1
	union
	SELECT g2.guest_club FROM Match g2
	);
GO
CREATE PROCEDURE deleteMatch 
	@host_club varchar(20), @guest_club varchar(20) AS
    DELETE FROM Match WHERE host_club = @host_club AND guest_club = @guest_club


GO
CREATE PROCEDURE deleteMatchesOnStadium 
	@stadium varchar(20) AS
	declare @stadium_id  as int ;
	
	select  @stadium_id = id from Stadium where name = @stadium; 
	
	DELETE FROM Match WHERE stadium_id = @stadium_id;
GO

CREATE PROCEDURE addClub 
	@cname varchar(20), @clocation varchar(20) AS
    
    INSERT INTO Club VALUES 
	(@cname, @clocation);
GO
CREATE PROCEDURE addTicket 
	@host_club varchar(20), @guest_club varchar(20), @time datetime AS
    DECLARE @Match_id int = (SELECT id FROM Match 
					WHERE (host_club = @host_club) AND guest_club = @guest_club AND starting_time = @time);
    INSERT INTO Ticket VALUES 
	(@Match_id,1);
GO

CREATE PROCEDURE deleteClub 

	@cname varchar(20) AS
    
	DELETE FROM Club WHERE name = @cname;
GO

CREATE PROCEDURE addStadium 
	@sname varchar(20), @slocation varchar(20), @capacity int AS
    
	INSERT INTO Stadium VALUES
	(@sname, @slocation, @capacity, 1);
GO

CREATE PROCEDURE deleteStadium 
	@sname varchar(20) AS
    
	DELETE FROM Stadium WHERE name = @sname;


GO
CREATE PROCEDURE blockFan 
	@id varchar(20) AS
	
	UPDATE Fan SET is_blocked = 1 
	WHERE National_id = @id;


GO
CREATE PROCEDURE unblockFan 
	@id varchar(20) AS
	
	UPDATE Fan SET is_blocked = 0
	WHERE National_id = @id;
GO

CREATE PROCEDURE addRepresentative 
	@uname varchar(20), @cname varchar(20), @username varchar(20),
	@password varchar(20) AS
    
	INSERT INTO SystemUser VALUES
	( @username,@uname, @password);
	INSERT INTO Club_Representative VALUES
	(@username, null);



GO
CREATE FUNCTION viewAvailableStadiumsOn 
	(@time DATETIME)
	RETURNS TABLE

	RETURN (SELECT s.name, s.location, s.capacity
			FROM Stadium s
			WHERE NOT EXISTS (SELECT g.id
								FROM Match g	
								WHERE s.id = g.stadium_id
								AND g.starting_time >=  @time
								AND g.end_time <= @time
								))
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
