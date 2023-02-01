/*
CREATE DATABASE DBProject;
USE DBProject;
EXEC createAllTables;
*/
/*
Instructions:
	1. Run the first two commented queries.
	2. Run the whole file.
	3. Run The third commented query.
	4. Run the whole file.
*/

CREATE or ALTER PROC createAllTables AS

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

		CONSTRAINT St_PK PRIMARY KEY(id),
		CONSTRAINT St_Uniq Unique(name, location, capacity, is_available)
	)

	CREATE TABLE Club (
		id INT IDENTITY,
		name VARCHAR(20) UNIQUE,
		location VARCHAR(20),

		CONSTRAINT cl_PK PRIMARY KEY(id),
		CONSTRAINT cl_Uniq Unique(name, location)
	)

	CREATE TABLE Match (
		id INT IDENTITY,
		guest_club INT,
		host_club INT ,
		starting_time DATETIME,
		END_time DATETIME,
		stadium_id INT,
	
		CONSTRAINT Ma_PK PRIMARY KEY (id),
		CONSTRAINT Ma_GC_FK FOREIGN KEY(guest_club) REFERENCES Club(id),
		CONSTRAINT Ma_HC_FK FOREIGN KEY(host_club) REFERENCES Club(id),
		CONSTRAINT Ma_si_FK FOREIGN KEY(stadium_id) REFERENCES stadium(id)
		ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT Ma_Uniq Unique(guest_club, host_club, starting_time)

	)
	
	CREATE TABLE Fan (
		national_id VARCHAR(20),
		username VARCHAR(20),
		birth_date DATE,
		fan_address VARCHAR(20),
		phone_no INT,
		NOT_blocked BIT DEFAULT 1,

		CONSTRAINT Fa_PK PRIMARY KEY (national_id),
		CONSTRAINT Fa_un_Fk FOREIGN KEY (username) REFERENCES SystemUser (username),
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

	CREATE TABLE Sports_ASsociation_Manager (
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
		Match_id INT NOT NULL ,
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
		ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT Re_Uniq Unique(is_approved, Match_id, Stadium_Manager_id, Club_Representative_id)

	)
	
	CREATE TABLE Ticket_purchASe(
		id INT IDENTITY ,
		Ticket_id INT ,
		Fan_id VARCHAR(20) ,

		CONSTRAINT Tp_Pk PRIMARY KEY(id),
		CONSTRAINT Tp_ti_Fk FOREIGN KEY (Ticket_id) REFERENCES Ticket(id)
		ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT Tp_fi_Fk FOREIGN KEY (Fan_id) REFERENCES Fan(national_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT Tp_Uniq Unique(Ticket_id, Fan_id)

	);
GO


CREATE OR ALTER PROC dropAllTABLEs AS
	DROP TABLE IF EXISTS 
	Request,
	Ticket_purchASe,
	Ticket,
	Club_Representative,
	Sports_ASsociation_Manager, 
	Stadium_Manager,
	Fan,
	System_Admin,
	SystemUser,
	Match,
	Club,
	Stadium ;
GO


CREATE OR ALTER PROC dropAllProceduresFunctionsViews AS
	
	DECLARE @ProcSQL VARCHAR(MAX) = 'DROP PROC IF EXISTS createAllTables';
	SELECT @ProcSQL += ', [dbo].[' + [name] + ']'
	FROM sys.procedures
	WHERE [type] = 'P' AND is_ms_shipped = 0 AND [name] <> 'dropAllProceduresFunctionsViews';	

	DECLARE @ViewSQL VARCHAR(MAX) = 'DROP VIEW IF EXISTS allASsocManagers';
	SELECT @ViewSQL += ', [dbo].[' + [name] + ']'
	FROM sys.views
	WHERE is_ms_shipped = 0;
	
	DECLARE @FunctionSQL VARCHAR(MAX) = 'DROP FUNCTION IF EXISTS allUnASsignedMatches';
	SELECT @FunctionSQL += ', [dbo].[' + [name] + ']'
	FROM sys.procedures
	WHERE [type] IN ('FN', 'IF', 'TF', 'FS', 'FT') AND is_ms_shipped = 0;	

	EXEC (@ProcSQL);
	EXEC (@ViewSQL); 
	EXEC (@FunctionSQL);
GO


CREATE OR ALTER PROC clearAllTABLEs AS
	EXEC dropAllTABLEs;
	EXEC createAllTables;	
GO


CREATE OR ALTER VIEW allASsocManagers AS
    SELECT SU.username, SU.name
    FROM Sports_ASsociation_Manager SAM
    JOIN SystemUser SU ON SU.username = SAM.username;
GO


CREATE OR ALTER VIEW allClubRepresentatives AS
    SELECT su.username, su.name, c.name AS club_Name
    FROM Club_Representative R
    JOIN SystemUser SU ON SU.username = R.username
	JOIN Club C ON C.id = r.id;
GO


CREATE OR ALTER VIEW allStadiumManagers AS
    SELECT su.username, su.name, S.name AS stadium
    FROM Stadium_Manager M
    JOIN SystemUser SU ON SU.username = M.username
	JOIN Stadium S ON S.id = M.stadium_id;
GO


CREATE OR ALTER VIEW allFans AS
    SELECT SU.name, F.username, F.National_id, F.birth_date, F.NOT_blocked
    FROM Fan F
    JOIN SystemUser SU ON SU.username = F.username;
GO


CREATE OR ALTER VIEW allMatches AS
    SELECT M.host_club, M.guest_club, M.starting_time 
    FROM Match M
GO


CREATE OR ALTER VIEW allTickets AS
    SELECT T.id, M.host_club, M.guest_club, S.name, M.starting_time
    FROM Ticket T
	JOIN Match M ON T.Match_id = M.id
	JOIN Stadium S ON S.id = M.stadium_id;
GO


CREATE OR ALTER VIEW allCLubs AS
    SELECT name, location
    FROM Club;
GO


CREATE OR ALTER VIEW allStadiums AS
    SELECT name, location, capacity, is_available
    FROM Stadium S;
GO


CREATE OR ALTER VIEW allRequests AS
    SELECT Re.Match_id, R.username AS Club_Representative, M.username AS Stadium_Manager, RE.is_approved
    FROM Request Re
	JOIN Club_Representative R ON Re.Club_Representative_id = R.id
	JOIN Stadium_Manager M ON RE.Stadium_Manager_id = M.id;
GO


CREATE OR ALTER PROCEDURE addASsociationManager 
	@uname VARCHAR(20), @username VARCHAR(20), @pASsword VARCHAR(20) AS

	INSERT INTO SystemUser VALUES 
	(@uname, @username, @pASsword);
	INSERT INTO Sports_ASsociation_Manager VALUES
	(@username);
GO


CREATE OR ALTER PROCEDURE addNewMatch
	@host_club VARCHAR(20), @guest_club VARCHAR(20),
	@start_time DATETIME, @END_time DATETIME AS

	DECLARE @hID INT = (SELECT c.id FROM club c WHERE c.name = @host_club); 
	DECLARE @gID INT = (SELECT c.id FROM club c WHERE c.name = @guest_club); 
	DECLARE @MatchExist INT = (SELECT COUNT(*) FROM Match
								WHERE host_club = @hID AND guest_club = @gID AND starting_time = @start_time);

	IF @MatchExist = 0
	BEGIN
    INSERT INTO Match VALUES
	(@gID, @hID,@start_time,@END_time, NULL);
	END
GO


CREATE OR ALTER VIEW clubsWithNoMatches AS
    SELECT c.name FROM Club C
	EXCEPT
	SELECT DISTINCT g1.host_club FROM Match g1
	EXCEPT
	SELECT DISTINCT g2.guest_club FROM Match g2;

GO


CREATE OR ALTER PROCEDURE DELETEMatch 
	@host_club VARCHAR(20), @guest_club VARCHAR(20) AS

	DECLARE @hID INT = (SELECT c.id FROM club c WHERE c.name = @host_club); 
	DECLARE @gID INT = (SELECT c.id FROM club c WHERE c.name = @guest_club);
	DECLARE @MatchIDs TABLE (id INT);
	INSERT INTO @MatchIDs SELECT id FROM Match WHERE host_club = @hID AND guest_club = @gID;

	DELETE FROM Request WHERE Match_id IN (SELECT * FROM @MatchIDs);
	DELETE FROM Ticket WHERE Match_id IN (SELECT * FROM @MatchIDs);
    DELETE FROM Match WHERE ID IN (SELECT * FROM @MatchIDs);

GO


CREATE OR ALTER PROCEDURE DELETEMatchesOnStadium 
	@stadium VARCHAR(20) AS

	DECLARE @stadium_id INT = (SELECT id FROM Stadium WHERE name = @stadium);
	DECLARE @MatchIDs TABLE (id INT);
	INSERT INTO @MatchIDs SELECT id FROM Match WHERE @stadium_id = @stadium_id;

	DELETE FROM Request WHERE Match_id IN (SELECT * FROM @MatchIDs);
	DELETE FROM Ticket WHERE Match_id IN (SELECT * FROM @MatchIDs);
	DELETE FROM Match WHERE stadium_id = @stadium_id;
GO


CREATE OR ALTER PROCEDURE addClub 
	@cname VARCHAR(20), @clocation VARCHAR(20) AS
    
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM Club 
						  WHERE name = @cname);
	if @COUNT = 0 
	BEGIN
    INSERT INTO Club VALUES 
	(@cname, @clocation);
	END
GO


CREATE OR ALTER PROCEDURE addTicket 
	@host_club VARCHAR(20), @guest_club VARCHAR(20), @time DATETIME AS

	DECLARE @hID INT = (SELECT c.id FROM club c WHERE c.name = @host_club); 
	DECLARE @gID INT = (SELECT c.id FROM club c WHERE c.name = @guest_club); 
    DECLARE @Match_id INT = (SELECT id FROM Match
					WHERE (host_club = @hID) AND guest_club = @gID AND starting_time = @time);

	DECLARE @capacity INT = (SELECT capacity FROM Stadium s, Match m WHERE m.id = @Match_id AND s.id = m.stadium_id)
	DECLARE @cnt INT = 0;

	while @cnt < @capacity
	BEGIN
    INSERT INTO Ticket VALUES 
	(@Match_id, 1);
	SET @cnt = @cnt + 1;
	END
GO


CREATE OR ALTER PROCEDURE DELETEClub 
	@cname VARCHAR(20) AS

    DECLARE @clubID INT = (SELECT c.id FROM club c WHERE c.name = @cname); 

	DELETE FROM Match WHERE guest_club = @clubID OR host_club = @clubID;
	DELETE FROM Club_Representative WHERE club_id = @clubID;
	DELETE FROM Club WHERE name = @cname;
GO


CREATE OR ALTER PROCEDURE addStadium 
	@sname VARCHAR(20), @slocation VARCHAR(20), @capacity INT AS
    
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM Stadium 
						  WHERE name = @sname);
	if @COUNT = 0 
	BEGIN
	INSERT INTO Stadium VALUES
	(@sname, @slocation, @capacity, 1);
	END
GO


CREATE OR ALTER PROCEDURE DELETEStadium 
	@sname VARCHAR(20) AS

    DECLARE @sid INT =(SELECT s.id FROM Stadium s WHERE s.name =@sname);

	DELETE FROM Match WHERE stadium_id = @sid;
	DELETE FROM Stadium_Manager WHERE stadium_id = @sid;
	DELETE FROM Stadium WHERE name = @sname;
GO


CREATE OR ALTER PROCEDURE blockFan 
	@id VARCHAR(20) AS
	
	UPDATE Fan SET NOT_blocked = 0 
	WHERE National_id = @id;
GO


CREATE OR ALTER PROCEDURE unblockFan 
	@id VARCHAR(20) AS
	
	UPDATE Fan SET NOT_blocked = 1
	WHERE National_id = @id;
GO


CREATE OR ALTER PROCEDURE addRepresentative 
	@uname VARCHAR(20), @cname VARCHAR(20), @username VARCHAR(20),
	@pASsword VARCHAR(20) AS

    DECLARE @club_id INT = (SELECT id FROM Club WHERE name = @cname);
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM Club_Representative cr 
						  WHERE cr.club_id = @club_id );

	IF @club_id IS NOT NULL AND @COUNT = 0 
	BEGIN 
	INSERT INTO SystemUser VALUES
	(@uname, @username, @pASsword);
	INSERT INTO Club_Representative VALUES
	(@username, @club_id);
	END 
GO


CREATE OR ALTER FUNCTION viewAvailableStadiumsOn 
	(@time DATETIME)
	RETURNS TABLE

	RETURN (SELECT s.name, s.location, s.capacity
			FROM Stadium s
			WHERE NOT EXISTS (SELECT g.id
								FROM Match g	
								WHERE s.id = g.stadium_id
								AND g.starting_time <=  @time
								AND g.END_time >= @time
								))
GO


CREATE OR ALTER PROCEDURE addHostRequest
@club_name VARCHAR(20), @stad_name VARCHAR(20),
@date DATETIME
AS

	DECLARE @Match_id INT = (SELECT m.id FROM Match m, Club c
							WHERE c.id = m.host_club AND c.name = @club_name 
							AND m.starting_time = @date);
	DECLARE @Manager_id INT = (SELECT sm.id FROM Stadium s, Stadium_Manager sm 
							   WHERE s.name = @stad_name AND s.id = sm.stadium_id);
	DECLARE @Representative_id INT = (SELECT cr.id FROM Club c, Club_Representative cr
									  WHERE c.name = @club_name AND c.id = cr.club_id);
	
	if (@Manager_id is NOT NULL AND @Representative_id is NOT NULL AND @Match_id is NOT NULL)
	BEGIN;
	INSERT INTO Request VALUES (NULL, @Match_id, @Manager_id, @Representative_id);
	END;
GO


CREATE OR ALTER FUNCTION allUnASsignedMatches 
   (@cname VARCHAR(20)) 
   RETURNS TABLE 
   
   RETURN (SELECT c2.name, m.starting_time
             FROM Match m
			 JOIN Club c1 ON m.host_club = c1.id AND c1.name = @cname
			 JOIN Club c2 ON m.guest_club = c2.id
			 WHERE m.stadium_id is NULL);
GO


CREATE OR ALTER PROC addStadiumManager
	@name VARCHAR(20), @stadium_name VARCHAR(20),
	@username VARCHAR(20), @pASsword VARCHAR(20) AS

	DECLARE @stadium_id INT = (SELECT s.id FROM Stadium s
						   WHERE s.name = @stadium_name);
	DECLARE @COUNT INT = ( SELECT COUNT(*) FROM Stadium_Manager sm 
							WHERE sm.stadium_id = @stadium_id  );

	if @stadium_id is NOT NULL AND @COUNT = 0
		BEGIN
		INSERT INTO SystemUser VALUES
		(@name, @username, @pASsword);
		INSERT INTO Stadium_Manager VALUES
		(@username, @stadium_id);
		END 
GO


CREATE OR ALTER FUNCTION allPENDingRequests 
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
		SELECT su.username, c.name, m.starting_time
		FROM Request re
		JOIN Match m ON m.id = re.Match_id
		JOIN club c ON c.id = m.guest_club
		JOIN Club_Representative cr ON cr.id = re.Club_Representative_id
		JOIN SystemUser su ON su.username = cr.username
		WHERE Stadium_Manager_id = @sm_ID AND re.is_approved is NULL

	RETURN 
END
GO


CREATE OR ALTER PROCEDURE acceptRequest 
@sm_username VARCHAR(20),@host_club VARCHAR(20),
@guest_club VARCHAR(20), @time DATETIME
AS

	DECLARE @sm_ID INT = (SELECT sm.id FROM Stadium_Manager sm 
						  WHERE sm.username = @sm_username);
	DECLARE @s_ID INT = (SELECT sm.stadium_id FROM Stadium_Manager sm 
						  WHERE sm.username = @sm_username);
	DECLARE @matchesONStadium INT  = (SELECT COUNT(*) FROM Match m
									  WHERE m.stadium_id = @s_id
									  AND m.starting_time <= @time AND m.END_time >=@time)
	DECLARE @stadiumAvailable BIT = (SELECT is_available FROM Stadium 
									 WHERE id = @s_ID);

	IF @matchesONStadium = 0 AND @stadiumAvailable = 1 
	BEGIN 
		UPDATE Request SET is_approved = 1 
		WHERE Request.Match_id IN (SELECT m.id FROM Match m
									JOIN Club c1 ON c1.id = m.host_club AND c1.name = @host_club
									JOIN Club c2 ON c2.id = m.guest_club AND c2.name = @guest_club
									WHERE m.starting_time = @time)
		AND Request.Stadium_Manager_id = @sm_ID;

		UPDATE Match SET stadium_id = @s_ID 
		WHERE id IN (SELECT m.id FROM Match m
									JOIN Club c1 ON c1.id = m.host_club AND c1.name = @host_club
									JOIN Club c2 ON c2.id = m.guest_club AND c2.name = @guest_club
									WHERE m.starting_time = @time)

	END 
GO


CREATE OR ALTER  PROCEDURE rejectRequest  
@sm_username VARCHAR(20),@host_club VARCHAR(20),
@guest_club VARCHAR(20), @time DATETIME
AS

	DECLARE @sm_ID INT = (SELECT sm.id FROM Stadium_Manager sm 
						  WHERE sm.username = @sm_username);
	DECLARE @MatchIDs TABLE (id INT);
	INSERT INTO @MatchIDs SELECT m.id FROM Match m
							JOIN Club c1 ON c1.id = m.host_club AND c1.name = @host_club
							JOIN Club c2 ON c2.id = m.guest_club AND c2.name = @guest_club
							WHERE m.starting_time = @time;

	UPDATE Request SET is_approved = 0 
	WHERE Request.Match_id IN (SELECT * FROM @MatchIDs)
	AND Request.Stadium_Manager_id = @sm_ID;
GO


CREATE OR ALTER PROCEDURE addFan
	@name VARCHAR(20), @username VARCHAR(20), @pASsword VARCHAR(20),
	@national_id VARCHAR(20), @birth_dath DATETIME,
	@address VARCHAR(20), @phone INT AS

	DECLARE @FanExists INT = (SELECT COUNT(*) FROM Fan WHERE national_id = @national_id);

	IF @FanExists = 0
	BEGIN
    INSERT INTO SystemUser VALUES
	(@name, @username, @pASsword);
	INSERT INTO Fan VALUES
	(@national_id, @username, @birth_dath, @address, @phone, 1);
	END
GO


-- Check Later
-- Use Outer Join to show matches with null stadiums
CREATE OR ALTER FUNCTION upcomingMatchesOfClub 
(@club_name VARCHAR(20)) 
RETURNs @RET TABLE(
club VARCHAR(20), 
club_against VARCHAR(20),
time DATETIME,
stadium VARCHAR(20)
)
AS
BEGIN 

	DECLARE @club_id INT = (SELECT c.id FROM club c WHERE c.name = @club_name);

	INSERT INTo @RET
	   SELECT @club_name, c1.name, m1.starting_time, s1.name
		FROM Match m1
		LEFT OUTER JOIN Stadium s1 ON m1.stadium_id = s1.id
		JOIN Club c1 ON c1.id = m1.guest_club
		JOIN Club c2 ON c2.id = m1.host_club
		WHERE m1.starting_time > CURRENT_TIMESTAMP
		AND (m1.host_club = @club_id OR m1.guest_club = @club_id)

	RETURN 
END 
GO


CREATE OR ALTER FUNCTION availableMatchesToAttEND 
(@time DATETIME)
RETURNS TABLE
AS
    RETURN (SELECT distinct c1.name AS Host, c2.name AS Guest , m.starting_time AS Start_Time, s.name AS Stadium
			FROM Match m 
			JOIN Ticket t ON m.id = t.Match_id
			JOIN Club c1 ON c1.id = m.host_club
			JOIN Club c2 ON c2.id = m.guest_club
			JOIN Stadium s ON s.id = m.stadium_id
			WHERE t.is_available = 1 AND m.starting_time >= @time
	)
GO


CREATE OR ALTER PROCEDURE purchaseTicket (
@nationalID VARCHAR(20), @h_clubName VARCHAR(20),
@g_clubName VARCHAR(20), @startTime DATETIME
) AS

	DECLARE @hc INT = (SELECT c.id FROM club c WHERE c.name = @h_clubName);
	DECLARE @gc INT = (SELECT c.id FROM club c WHERE c.name = @g_clubName);
	DECLARE @matchID INT = (SELECT m.id FROM Match m 
							WHERE m.guest_club = @gc AND m.host_club = @hc
							AND m.starting_time = @startTime ); 

	DECLARE @TicketId INT = (SELECT TOP(1) t.id FROM Ticket t
							WHERE t.Match_id = @matchID AND t.is_available = 1);
	DECLARE @fan_NOTBlocked BIT = (SELECT NOT_blocked FROM Fan 
								   WHERE national_id = @nationalID);

	if @ticketId IS NOT NULL AND @fan_NOTBlocked = 1
	BEGIN 
	UPDATE Ticket SET is_available = 0 WHERE id = @ticketId;
	INSERT INTO Ticket_purchASe VALUES(@TicketId, @nationalID);
	END 
GO


CREATE OR ALTER PROCEDURE UPDATEMatchHost 
@hostclubname VARCHAR(20), @guestclubname VARCHAR(20),@starttime DATETIME
AS
	DECLARE @match_id INT = (SELECT m.id FROM Match m 
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
	 SET host_club = @guestclub, guest_club = @hostclub
	 WHERE id = @match_id
GO


CREATE OR ALTER VIEW matchesPerTeam AS
    SELECT c.name, COUNT(c.name) AS matchesPerTeam
    FROM Match m
	JOIN Club c ON c.id = m.host_club OR c.id = m.guest_club
	WHERE m.starting_time < CURRENT_TIMESTAMP
	GROUP BY c.name;
GO



CREATE OR ALTER VIEW clubsNeverMatched AS
    SELECT c1.name AS First_Club, c2.name AS Second_Club
    FROM Club c1
	JOIN Club c2 ON c1.id > c2.id
	WHERE NOT EXISTS (
		SELECT * FROM Match M1 WHERE M1.host_club = c1.id AND M1.guest_club = c2.id AND m1.starting_time < CURRENT_TIMESTAMP 
		UNION 
		SELECT * FROM Match m2 WHERE m2.host_club = c2.id AND M2.guest_club = c1.id AND m2.starting_time < CURRENT_TIMESTAMP 
	)
GO


CREATE OR ALTER FUNCTION clubsNeverPlayed 
(@club_name VARCHAR(20))
RETURNS @RET TABLE(
club VARCHAR(20))
AS
BEGIN 
	DECLARE @club_id INT = (SELECT c.id FROM club c WHERE c.name = @club_name);

	DECLARE @HostIDs TABLE (host_club INT);
	INSERT INTO @HostIDs SELECT host_club FROM Match
						 WHERE guest_club = @club_id AND starting_time < CURRENT_TIMESTAMP;

	DECLARE @GuestIDs TABLE (guest_club INT);
	INSERT INTO @GuestIDs SELECT guest_club FROM Match
						  WHERE host_club = @club_id AND starting_time < CURRENT_TIMESTAMP;

	INSERT INTO @RET SELECT name Club FROM Club
					 WHERE id NOT IN (SELECT host_club FROM @HostIDs) AND id NOT IN (SELECT guest_club FROM @GuestIDs);

	RETURN 
 
END
GO


CREATE OR ALTER FUNCTION matchesRankedByAttendance()
RETURNS TABLE AS

RETURN (
	SELECT hc.name AS Host_Club, gc.name AS Guest_club, sum(T.id) AS Attendencse 
	FROM Ticket_purchASe TP 
	JOIN Ticket T ON T.id = TP.Ticket_id
	JOIN Match M ON M.id = T.Match_id
	JOIN Club hc ON hc.id = M.host_club
	JOIN Club gc ON gc.id = M.guest_club
	WHERE M.starting_time < CURRENT_TIMESTAMP
	GROUP BY hc.name, gc.name, M.id
	ORDER BY sum(T.id) DESC
	OFFSET 0 ROWS 
);
GO


CREATE OR ALTER FUNCTION PurchasedTicketsMatches
(@username VARCHAR(20))
RETURNS TABLE AS

RETURN (
	SELECT T.id Ticket_ID, C1.name Host, C2.name Guest, M.starting_time, S.name Stadium
	FROM Ticket_purchASe TP
	JOIN Ticket T ON TP.Ticket_id = T.id
	JOIN Match M ON T.Match_id = M.id
	JOIN Club C1 ON M.host_club = C1.id
	JOIN Club C2 ON M.guest_club = C2.id
	JOIN Stadium S ON M.stadium_id = S.id
	WHERE TP.Fan_id = (SELECT F.national_id FROM Fan F
						WHERE F.username = @username)
);
GO


CREATE OR ALTER FUNCTION RequestsFROMClub 
(@stadium VARCHAR(20) , @club VARCHAR(20))
RETURNs @RET TABLE(
host varchar(20),
guest varchar(20)
)
AS
BEGIN 

	DECLARE @smID int = (SELECT sm.id
						FROM Stadium_Manager sm
						JOIN Stadium s ON sm.stadium_id = s.id AND s.name = @stadium);
	DECLARE @crID int = (SELECT cr.id 
						FROM Club_Representative cr
						JOIN club c ON c.id=cr.club_id AND c.name = @club);

	INSERT INTO @RET
	SELECT hc.name AS Host, gc.name AS Guest FROM Request re 
	JOIN Match m ON m.id = re.Match_id 
				 AND re.Club_Representative_id = @crID
				 AND re.Stadium_Manager_id = @smID
	JOIN Club hc ON m.host_club = hc.id
	JOIN club gc ON m.guest_club = gc.id

	RETURN 
END 
GO


