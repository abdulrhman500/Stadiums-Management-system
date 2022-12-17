/*
EXEC dropAllTABLEs;
EXEC createAllTABLEs;

EXEC dropAllProceduresFunctionsViews;
DROP PROC dropAllProceduresFunctionsViews;
*/

--CREATE DATABASE DBProject;
--USE DBProject;
GO
CREATE PROC createAllTABLEs AS

	CREATE TABLE SystemUser (
		name VARCHAR(20),
		username VARCHAR(20),
		password VARCHAR(20),

		CONSTRAINT SyU_PK PRIMARY KEY(username)
	)	

	CREATE TABLE Stadium (
		id INT IDENTITY,
		name VARCHAR(20) UNIQUE,
		location VARCHAR(20),
		capacity INT,
		is_available BIT DEFAULT 1,

		CONSTRAINT St_PK PRIMARY KEY(id)
	)

	CREATE TABLE Club (
		id INT IDENTITY,
		name VARCHAR(20) UNIQUE,
		location VARCHAR(20),

		CONSTRAINT cl_PK PRIMARY KEY(id)
	)

	CREATE TABLE Match (
		id INT IDENTITY,
		guest_club INT,
		host_club INT ,
		starting_time DATETIME,
		end_time DATETIME,
		stadium_id INT,
	
		CONSTRAINT Ma_PK PRIMARY KEY (id),
		CONSTRAINT Ma_GC_FK FOREIGN KEY(guest_club) REFERENCES Club(id),
		CONSTRAINT Ma_HC_FK FOREIGN KEY(host_club) REFERENCES Club(id),
		CONSTRAINT Ma_si_FK FOREIGN KEY(stadium_id) REFERENCES stadium(id)
		ON UPDATE CASCADE ON DELETE CASCADE

	)
	
	CREATE TABLE Fan (
		national_id VARCHAR(20),
		username VARCHAR(20),
		birth_date DATETIME,
		fan_address VARCHAR(20),
		phone_no INT,
		not_blocked BIT DEFAULT 1,

		CONSTRAINT Fa_PK PRIMARY KEY (national_id),
		CONSTRAINT Fa_un_Fk FOREIGN KEY (username) REFERENCES SystemUser (username)
		)
	
	CREATE TABLE Stadium_Manager (
		id INT IDENTITY ,
		username VARCHAR(20),
		stadium_id INT,

		CONSTRAINT sm_PK PRIMARY KEY (id),
		CONSTRAINT sm_un_FK FOREIGN KEY (username) REFERENCES SystemUser(username) ,
		CONSTRAINT sm_si_FK FOREIGN KEY (stadium_id) REFERENCES stadium(id) 

	)

	CREATE TABLE Club_Representative (
		id INT IDENTITY,
		username VARCHAR(20),
		club_id INT,
		
		CONSTRAINT cr_PK PRIMARY KEY (id),
		CONSTRAINT cr_un_FK FOREIGN KEY (username) REFERENCES SystemUser(username),
		CONSTRAINT cr_ci_FK FOREIGN KEY (club_id) REFERENCES Club(id) 

	)

	CREATE TABLE Sports_Association_Manager (
		id INT IDENTITY ,
		username VARCHAR(20),

		CONSTRAINT SAM_PK PRIMARY KEY (id),
		CONSTRAINT SAM_un_FK FOREIGN KEY (username) REFERENCES SystemUser(username) 
	)

	CREATE TABLE System_Admin (
		id INT IDENTITY ,
		username VARCHAR(20),

		CONSTRAINT SA_PK PRIMARY KEY (id),
		CONSTRAINT SA_un_FK FOREIGN KEY (username) REFERENCES SystemUser(username)
	)

	CREATE TABLE Ticket (
		id INT IDENTITY,
		Match_id INT NOT null ,
		is_available BIT ,
	
		CONSTRAINT Ti_PK PRIMARY KEY(id),
		CONSTRAINT Ti_mi_FK FOREIGN KEY(Match_id) REFERENCES Match(id)
		ON UPDATE CASCADE ON DELETE CASCADE
	)

	CREATE TABLE Request (
		id INT IDENTITY ,
		is_approved BIT,
		Match_id INT ,
		Stadium_Manager_id INT ,
		Club_Representative_id INT ,

		CONSTRAINT Re_Pk PRIMARY KEY(id),
		CONSTRAINT Re_mi_Fk FOREIGN KEY (Match_id) REFERENCES Match(id)
		ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT Re_cri_Fk FOREIGN KEY (Club_Representative_id) REFERENCES Club_Representative(id) 
		ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT Re_smi_FK FOREIGN KEY (Stadium_Manager_id) REFERENCES Stadium_Manager(id) 
		ON UPDATE CASCADE ON DELETE CASCADE
	
	)
	
	create TABLE Ticket_purchase(
		id INT IDENTITY ,
		Ticket_id INT ,
		Fan_id VARCHAR(20) ,

		CONSTRAINT Tp_Pk PRIMARY KEY(id),
		CONSTRAINT Tp_ti_Fk FOREIGN KEY (Ticket_id) REFERENCES Ticket(id)
		ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT Tp_fi_Fk FOREIGN KEY (Fan_id) REFERENCES Fan(national_id)
		ON DELETE CASCADE ON UPDATE CASCADE  
	);
GO

CREATE PROC dropAllTABLEs AS
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
	
	DROP PROC IF EXISTS createAllTABLEs, dropAllTABLEs, clearAllTABLEs,
	addAssociationManager, addNewMatch, deleteMatch, deleteMatchesOnStadium,
	addClub, addTicket, deleteClub, addStadium, deleteStadium, blockFan,
	unblockFan, addRepresentative, addHostRequest, addStadiumManager,
	acceptRequest, rejectRequest, addFan, purchaSETicket, UPDATEMatchHost,
	deleteMatchesOnStadium;
	DROP VIEW IF EXISTS allAssocManagers, allClubRepresentatives,
	allStadiumManagers, allFans, allMatches, allTickets, allCLubs,
	allStadiums, allRequests, clubsWithNoMatches,
	matchesPerTeam, clubsNeverMatched;
	DROP FUNCTION IF EXISTS allUnassignedMatches, viewAvailableStadiumsOn, 
	allPendingRequests,upcomingMatchesOfClub, availableMatchesToAttendk,
	clubsNeverPlayed, matchWithHighestAttendance, matchesRankedByAttendance,
	requestsFROMClub;
	GO
GO
CREATE PROC clearAllTABLEs AS
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

GO

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
    SELECT SU.name, F.National_id, F.birth_date, F.not_blocked
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
	@uname VARCHAR(20), @username VARCHAR(20), @password VARCHAR(20) AS

	INSERT INTO SystemUser VALUES 
	(@uname, @username, @password);
	INSERT INTO Sports_Association_Manager VALUES
	(@username);
GO

CREATE PROCEDURE addNewMatch
	@host_club VARCHAR(20), @guest_club VARCHAR(20),
	@start_time DATETIME, @end_time DATETIME AS

    INSERT INTO Match VALUES
	(@guest_club, @host_club,@start_time,@end_time, null);
GO

CREATE VIEW clubsWithNoMatches AS
    SELECT c.name FROM Club C
	EXCEPT
	SELECT DISTINCT g1.host_club FROM Match g1
	EXCEPT
	SELECT DISTINCT g2.guest_club FROM Match g2;

GO
CREATE PROCEDURE deleteMatch 
	@host_club VARCHAR(20), @guest_club VARCHAR(20) AS
    DELETE FROM Match WHERE host_club = @host_club AND guest_club = @guest_club

GO
CREATE PROCEDURE deleteMatchesOnStadium 
	@stadium VARCHAR(20) AS
	DECLARE @stadium_id INT = (SELECT id FROM Stadium WHERE name = @stadium);
	
	DELETE FROM Match WHERE stadium_id = @stadium_id;
GO

CREATE PROCEDURE addClub 
	@cname VARCHAR(20), @clocation VARCHAR(20) AS
    
    INSERT INTO Club VALUES 
	(@cname, @clocation);
GO
CREATE PROCEDURE addTicket 
	@host_club VARCHAR(20), @guest_club VARCHAR(20), @time DATETIME AS

    DECLARE @Match_id INT = (SELECT id FROM Match 
					WHERE (host_club = @host_club) AND guest_club = @guest_club AND starting_time = @time);
    INSERT INTO Ticket VALUES 
	(@Match_id, 1);
GO

CREATE PROCEDURE deleteClub 
	@cname VARCHAR(20) AS
    
	DELETE FROM Match WHERE guest_club = @cname OR host_club = @cname;
	DELETE FROM Club WHERE name = @cname;
GO

CREATE PROCEDURE addStadium 
	@sname VARCHAR(20), @slocation VARCHAR(20), @capacity INT AS
    
	INSERT INTO Stadium VALUES
	(@sname, @slocation, @capacity, 1);
GO

CREATE PROCEDURE deleteStadium 
	@sname VARCHAR(20) AS
    
	DELETE FROM Stadium WHERE name = @sname;

GO
CREATE PROCEDURE blockFan 
	@id VARCHAR(20) AS
	
	UPDATE Fan SET not_blocked = 0 
	WHERE National_id = @id;

GO
CREATE PROCEDURE unblockFan 
	@id VARCHAR(20) AS
	
	UPDATE Fan SET not_blocked = 1
	WHERE National_id = @id;
GO

CREATE PROCEDURE addRepresentative 
	@uname VARCHAR(20), @cname VARCHAR(20), @username VARCHAR(20),
	@password VARCHAR(20) AS
    
	INSERT INTO SystemUser VALUES
	(@uname, @username, @password);
	DECLARE @club_id INT = (SELECT id FROM Club WHERE name = @cname);
	INSERT INTO Club_Representative VALUES
	(@username, @club_id);

GO
CREATE FUNCTION viewAvailableStadiumsOn 
	(@time DATETIME)
	RETURNS TABLE

	RETURN (SELECT s.name, s.location, s.capacity
			FROM Stadium s
			WHERE NOT EXISTS (SELECT g.id
								FROM Match g	
								WHERE s.id = g.stadium_id
								AND g.starting_time <=  @time
								AND g.end_time >= @time
								))
GO

--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
----------------------------------------------------------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------


CREATE PROCEDURE addHostRequest
@club_name VARCHAR(20), @stad_name VARCHAR(20),
@date DATETIME
AS

	DECLARE @Match_id INT = (SELECT m.id FROM Match m, Club c
									  WHERE c.id = m.host_club AND c.name = @club_name AND m.starting_time = @date);
	DECLARE @Manager_id INT = (SELECT sm.id FROM Stadium s, Stadium_Manager sm 
							   WHERE s.name = @stad_name AND s.id = sm.stadium_id);
	DECLARE @Representative_id INT = (SELECT s.id FROM Club c, Club_Representative cr
									  WHERE c.name = @club_name AND c.id = cr.club_id);

	INSERT INTO Request VALUES (null, @Match_id,@Manager_id,@Representative_id);
GO


CREATE FUNCTION allUnassignedMatches 
   (@cname VARCHAR(20)) 
   RETURNS TABLE 
   
   RETURN (SELECT c2.name, m.starting_time
             FROM Match m
			 JOIN Club c1 ON m.host_club = c1.id AND c1.name = @cname
			 JOIN Club c2 ON m.guest_club = c2.id
			 WHERE m.stadium_id is null );
GO

CREATE PROC addStadiumManager
	@name VARCHAR(20), @stadium_name VARCHAR(20),
	@username VARCHAR(20), @password VARCHAR(20) AS

	DECLARE @stadium_id INT = (SELECT s.id FROM Stadium s
						   WHERE s.name = @stadium_name);
	 INSERT INTO SystemUser VALUES
	(@name, @username, @password);
	INSERT INTO Stadium_Manager VALUES
	(@username, @stadium_id);
GO

CREATE FUNCTION allPendingRequests 
(@sm_username VARCHAR(20))
RETURNS @RET TABLE(
	Club_Representative VARCHAR(20),
	guest_club VARCHAR(20),
	starting_time DATETIME
 ) AS
BEGIN 

DECLARE @sm_ID INT = (SELECT sm.id FROM Stadium_Manager sm 
					  WHERE sm.username = @sm_username);

INSERT INTO @RET
    SELECT su.name, gc.name, m.starting_time
    FROM Request re
	JOIN Match m ON m.id = re.Match_id
	JOIN club c ON c.id = m.guest_club
	JOIN Club_Representative cr ON cr.id = re.Club_Representative_id
	JOIN SystemUser su ON su.username = cr.username
	WHERE Stadium_Manager_id = @ManID AND re.is_approved is null

RETURN 
END
GO

-- ADD THE SEQUENCES ON Tickets and stadium
CREATE PROCEDURE acceptRequest
@sm_username VARCHAR(20),@host_club VARCHAR(20),
@guest_club VARCHAR(20), @time DATETIME
AS

DECLARE @sm_ID INT = (SELECT sm.id FROM Stadium_Manager sm 
					  WHERE sm.username = @sm_username);

DECLARE @MatchID INT = (SELECT m.id 
						FROM Match m
						JOIN Club c1 ON c1.id = m.host_club AND c1.name = @host_club
						JOIN Club c2 ON c2.id = m.guest_club AND c2.name = @guest_club
					    WHERE m.starting_time = @time)

UPDATE Request SET is_approved = 1 
WHERE Request.Match_id = @MatchID
AND Request.Stadium_Manager_id = @sm_ID;
GO

CREATE PROCEDURE rejectRequest
@sm_username VARCHAR(20),@host_club VARCHAR(20),
@guest_club VARCHAR(20), @time DATETIME
AS

DECLARE @sm_ID INT = (SELECT sm.id FROM Stadium_Manager sm 
					  WHERE sm.username = @sm_username);

DECLARE @MatchID INT = (SELECT m.id 
						FROM match m
						JOIN Club c1 ON c1.id = m.host_club AND c1.name = @host_club
						JOIN Club c2 ON c2.id = m.guest_club AND c2.name = @guest_club
					   WHERE m.starting_time = @time)

UPDATE Request SET is_approved = 0 
WHERE Request.Match_id = @MatchID
AND Request.Stadium_Manager_id = @sm_ID;
GO


CREATE PROCEDURE addFan
	@name VARCHAR(20), @username VARCHAR(20), @password VARCHAR(20),
	@national_id VARCHAR(20), @birth_dath DATETIME,
	@address VARCHAR(20), @phone INT AS

    INSERT INTO SystemUser VALUES
	(@name, @username, @password);
	INSERT INTO Fan VALUES
	(@national_id, @username, @birth_dath, @address, @phone, 1);
GO


CREATE FUNCTION upcomingMatchesOfClub 
(@club_name VARCHAR(20)) 
 RETURNS TABLE 
AS
   RETURN (
	SELECT @club_name, m1.guest_club, m1.starting_time, s1.name
    FROM Stadium s1
	JOIN Match m1 ON m1.stadium_id = s1.id
	JOIN Club c1 ON c1.id = m1.host_club 
	WHERE m1.starting_time > CURRENT_TIMESTAMP 
	AND c1.name = @club_name
	UNION
	SELECT @club_name, m2.host_club, m2.starting_time, s2.name
    FROM Stadium s2
	JOIN Match m2 ON m2.stadium_id = s2.id
	JOIN Club c2 ON c2.id = m2.guest_club 
	WHERE m2.starting_time > CURRENT_TIMESTAMP 
	AND c2.name = @club_name
	)
GO

CREATE FUNCTION availableMatchesToAttend 
(@time DATETIME)
RETURNS TABLE
AS
    RETURN (SELECT c1.name, c2.name, m.starting_time, s.name
			FROM Match m 
			JOIN Ticket t ON m.id = t.Match_id
			JOIN Club c1 ON c1.id = m.host_club
			JOIN Club c2 ON c2.id = m.guest_club
			JOIN Stadium s ON s.id = m.stadium_id
			WHERE t.is_available = 1 AND m.starting_time >= @time
	)
GO

-- SEQUENCES
CREATE PROCEDURE purchaseTicket (
@nationalID VARCHAR(20), @h_clubName VARCHAR(20),
@g_clubName VARCHAR(20), @startTime DATETIME
) AS

DECLARE @matchID INT ;
SELECT @matchID=m.id FROM Match m 
WHERE m.guest_club =@g_clubName AND m.host_club=@h_clubName
AND m.starting_time =@startTime;

DECLARE @TicketId INT ;
SELECT @TicketId=t.id
FROM Ticket t
WHERE t.Match_id =@matchID AND t.is_available =1;

if @ticketId IS NOT NULL
BEGIN 
UPDATE Ticket  SET is_available = 0 WHERE id = @ticketId;
INSERT INTO Ticket_purchase VALUES(@TicketId,@nationalID);
end 
GO

---needs a Check --------
CREATE PROCEDURE UPDATEMatchHost 
@hostclubname VARCHAR(20), @guestclubname VARCHAR(20),@starttime DATETIME
AS
DECLARE @match_id INT = (SELECT m.host_club FROM Match m 
						 JOIN Club c1 ON c1.id = m.host_club
						 JOIN Club c2 ON c2.id = m.guest_club
						 WHERE c1.name = @hostclubname
						 AND c2.name = @guestclubname
						 AND m.starting_time = @starttime);
DECLARE @hostclub INT = (SELECT host_club FROM Match
					 WHERE id = @match_id);
DECLARE @guestclub INT = (SELECT guest_club FROM Match
					 WHERE id = @match_id);
 UPDATE Match 
 SET host_club = @guestclub ,guest_club = @hostclub
 WHERE id = @match_id
GO

CREATE VIEW matchesPerTeam AS
    SELECT c.name, COUNT(*) AS matchesPerTeam
    FROM Match m
	JOIN Club c ON c.id = m.host_club OR c.id = m.guest_club
	WHERE m.starting_time < CURRENT_TIMESTAMP
	GROUP BY c.name;
GO


CREATE VIEW clubsNeverMatched AS
    SELECT hc.name , gc.name 
    FROM Club hc full JOIN  Club gc
	on hc.id > gc.id
	WHERE NOT EXISTS (
	SELECT * FROM Match M WHERE M.host_club = hc.id AND M.guest_club = gc.id and m.starting_time < CURRENT_TIMESTAMP 
	UNION 
	SELECT * FROM Match m WHERE m.host_club = gc.id AND M.guest_club = hc.id AND m.starting_time < CURRENT_TIMESTAMP 
	)
GO


------------------------------------------------
CREATE FUNCTION clubsNeverPlayed 
(@club VARCHAR(20))
RETURNs @RET TABLE(
club INT )
AS
BEGIN 


DECLARE @club_id INT ;
SELECT @club_id =c.id FROM club c WHERE c.name = @club ;

INSERT INTO @RET 

SELECT C.name as club 
--start of Clubs 
FROM (

SELECT C0.id
FROM club C0 
EXCEPT 
(

SELECT   M.host_club  
FROM Match M  WHERE M.guest_club = @club_id AND M.starting_time < CURRENT_TIMESTAMP 
UNION 
SELECT M.guest_club
FROM Match M  WHERE  M.host_club = @club_id AND M.starting_time < CURRENT_TIMESTAMP

)


) as Clubs
--end of Clubs
JOIN Club C
	on C.id = Clubs.id

RETURN 
end
GO
------------------------------------------------

CREATE FUNCTION matchWithHighestAttendance ()
RETURNS TABLE 

AS

RETURN (
SELECT top(1)
hc.name as host_Club , gc.name as guest_club 
FROM Ticket_purchase TP 
JOIN  Ticket T 
	on T.id = TP.Ticket_id
JOIN Match M 
	on M.id = T.Match_id
JOIN Club hc 
	on hc.id = M.host_club
JOIN Club gc 
	on gc.id = M.guest_club
	GROUP BY hc.name , gc.name ,M.id
ORDER BY sum(T.id) desc

);

go


CREATE FUNCTION matchesRankedByAttendance()
RETURNS TABLE 
AS

RETURN (
SELECT hc.name as host_Club , gc.name as guest_club 
FROM Ticket_purchase TP 
JOIN Ticket T ON T.id = TP.Ticket_id
JOIN Match M ON M.id = T.Match_id
JOIN Club hc ON hc.id = M.host_club
JOIN Club gc ON gc.id = M.guest_club
GROUP BY hc.name, gc.name, M.id
ORDER BY sum(T.id) DESC
);


GO

 

------------------------------------------------
go
create  FUNCTION RequestsFromClub (@stadium VARCHAR(20) , @club VARCHAR(20))
RETURNs @RET TABLE(
host varchar(20),
guest varchar(20)
)
AS
BEGIN 

declare @smID int ;
select @smID=sm.id from Stadium_Manager  sm
join Stadium s 
	on  sm.stadium_id = s.id and s.name = @stadium;

declare @crID int ;
select @crID = cr.id from Club_Representative  cr
join club c
	on  c.id=cr.club_id and c.name = @club;

insert into @RET
select hc.name as host , gc.name as guest from Request re 
join Match m 
	on m.id = re.Match_id 
	and re.Club_Representative_id =@crID
	and @smID  = re.Stadium_Manager_id	
join Club hc 
	on m.host_club = hc.id
join club gc 
	on m.guest_club = gc.id

return 
end 
go



/*

GO
Create FUNCTION RequestsFromClub
(@stadium VARCHAR(20) , @club VARCHAR(20))
RETURNS TABLE
AS

RETURN (
SELECT @club as Host_club ,C.name as Guest_Club 
FROM Request RE 
JOIN Match M 
	on M.id = RE.Match_id AND M.host_club = (SELECT c.id FROM club c WHERE c.name=@club)

JOIN Club C
	on M.guest_club = c.id 
	where re.Stadium_Manager_id =@smID
	
	);
GO
select * from dbo.RequestsFromClub('San Siro','Roma');

*/