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
		starting_time datetime,
		end_time datetime,
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
		birth_date Date,
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
		Match_id INT not null ,
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
	
	create table Ticket_purchase(
		id INT IDENTITY ,
		Ticket_id INT ,
		Fan_id VARCHAR(20) ,

		CONSTRAINT Tp_Pk PRIMARY KEY(id),
		CONSTRAINT Tp_ti_Fk FOREIGN KEY (Ticket_id) REFERENCES  Ticket (id)
		ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT Tp_fi_Fk FOREIGN KEY (Fan_id) REFERENCES Fan  (national_id)
		ON DELETE CASCADE ON UPDATE CASCADE  
	);
GO

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
	@start_time datetime, @end_time datetime AS

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
	declare @stadium_id INT = (SELECT id from Stadium where name = @stadium);
	
	DELETE FROM Match WHERE stadium_id = @stadium_id;
GO

CREATE PROCEDURE addClub 
	@cname VARCHAR(20), @clocation VARCHAR(20) AS
    
    INSERT INTO Club VALUES 
	(@cname, @clocation);
GO
CREATE PROCEDURE addTicket 
	@host_club VARCHAR(20), @guest_club VARCHAR(20), @time datetime AS

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

CREATE PROCEDURE addFan
	@name varchar(20), @username varchar(20), @password varchar(20),
	@national_id varchar(20), @birth_dath datetime,
	@address varchar(20), @phone int AS

    INSERT INTO SystemUser VALUES
	(@name, @username, @password);
	INSERT INTO Fan VALUES
	(@national_id, @username, @birth_dath, @address, @phone, 1);
GO

CREATE FUNCTION upcomingMatchesOfClub AS
    SELECT *
    FROM;
GO

CREATE FUNCTION availableMatchesToAttend AS
    SELECT *
    FROM;
GO

CREATE PROCEDURE purchaseTicket (
@nationalID varchar(20),
@h_clubName varchar(20),
@g_clubName varchar(20),
@startTime datetime
) AS
declare @matchID int ;
select @matchID=m.id from Match m 
where m.guest_club =@g_clubName and m.host_club=@h_clubName
and m.starting_time =@startTime;

declare @TicketId int ;
select @TicketId=t.id
from Ticket t
where t.Match_id =@matchID and t.is_available =1;

if @ticketId IS NOT NULL
begin 
update Ticket  set is_available = 0 where id = @ticketId;
insert into Ticket_purchase values(@TicketId,@nationalID);
end 

GO



CREATE PROCEDURE updateMatchHost AS
    SELECT *
    FROM;
GO

CREATE VIEW matchesPerTeam AS
    SELECT *
    FROM;
GO
*/



GO
CREATE VIEW clubsNeverMatched AS
    SELECT hc.name , gc.name 
    FROM Club hc full join  Club gc
	on hc.id <> gc.id
	where not exists (
	select * from Match M where M.host_club = hc.id and M.guest_club = gc.id 
	)
GO


------------------------------------------------
CREATE FUNCTION clubsNeverPlayed 
(@club varchar(20))
returns @RET TABLE(
club int )
AS
begin 


declare @club_id int ;
select @club_id =c.id from club c where c.name = @club ;

insert into @RET 

select C.name as club 
--start of Clubs 
from (

select C0.id
from club C0 
except 
(

select   M.host_club  
from Match M  where M.guest_club = @club_id and M.starting_time < CURRENT_TIMESTAMP 
union 
select M.guest_club
from Match M  where  M.host_club = @club_id and M.starting_time < CURRENT_TIMESTAMP

)


) as Clubs
--end of Clubs
join Club C
	on C.id = Clubs.id

return 
end
GO
------------------------------------------------

CREATE FUNCTION matchWithHighestAttendance ()
RETURNS Table 

AS

return (
select top(1)
hc.name as host_Club , gc.name as guest_club 
from Ticket_purchase TP 
join  Ticket T 
	on T.id = TP.Ticket_id
join Match M 
	on M.id = T.Match_id
join Club hc 
	on hc.id = M.host_club
join Club gc 
	on gc.id = M.guest_club
	group by hc.name , gc.name ,M.id
order by sum(T.id) desc

);

go


CREATE FUNCTION matchesRankedByAttendance ()
RETURNS Table 

AS

return (
select 
hc.name as host_Club , gc.name as guest_club 
from Ticket_purchase TP 
join  Ticket T 
	on T.id = TP.Ticket_id
join Match M 
	on M.id = T.Match_id
join Club hc 
	on hc.id = M.host_club
join Club gc 
	on gc.id = M.guest_club
	group by hc.name , gc.name , M.id
order by sum(T.id) desc
);


GO

 
GO
Create FUNCTION RequestsFromClub

(@stadium varchar(20) , @club varchar(20))

RETURNS Table
AS
return (
select  
@club as  Host_club ,C.name as Guest_Club 
from Request RE 
join Match M 
	on M.id=RE.Match_id AND  M.host_club = (select c.id from club c where c.name=@club)
join Stadium S 
	on S.id = M.stadium_id AND s. name =@stadium
join Club C 
	on M.guest_club =c.id 
	);
GO


