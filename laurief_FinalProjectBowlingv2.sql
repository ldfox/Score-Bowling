-- Name: Laurie Fox
-- Class: IT-112-400 SQL 2
-- Abstract: Final Project - Bowling
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- Use dbSQL database for all assignments and set nocount on  
-- --------------------------------------------------------------------------------
USE dbSQL1			-- Get out of Master database
SET NOCOUNT ON      -- Report only errors

	-- Drop table if table IS NOT NULL
	-- Drop stored procedure if procedure IS NOT NULL
	-- Drop view if view IS NOT NULL

IF OBJECT_ID( 'VTopTenPlayers' )									IS NOT NULL DROP VIEW  VTopTenPlayers
IF OBJECT_ID( 'VGameFinalScore' )									IS NOT NULL DROP VIEW  VGameFinalScore
IF OBJECT_ID( 'VGameStrikeInNinthNextThrowStrike')					IS NOT NULL DROP VIEW  VGameStrikeInNinthNextThrowStrike
IF OBJECT_ID( 'VGameStrikeNextThrowStrikePlusNextThrow' )			IS NOT NULL DROP VIEW  VGameStrikeNextThrowStrikePlusNextThrow
IF OBJECT_ID( 'VGameStrikeNextThrowNoStrike' )						IS NOT NULL DROP VIEW  VGameStrikeNextThrowNoStrike
IF OBJECT_ID( 'VGameSpareScore' )									IS NOT NULL DROP VIEW  VGameSpareScore
IF OBJECT_ID( 'VGamePinCountScore' )								IS NOT NULL DROP VIEW  VGamePinCountScore

IF OBJECT_ID( 'uspSP4_EditPlayerScoreInAFrameOfAGame' )				IS NOT NULL DROP PROCEDURE	uspSP4_EditPlayerScoreInAFrameOfAGame
IF OBJECT_ID( 'uspSP3_AddLeague' )									IS NOT NULL DROP PROCEDURE	uspSP3_AddLeague
IF OBJECT_ID( 'uspSP2_AddTeamAndPlayers' )							IS NOT NULL DROP PROCEDURE	uspSP2_AddTeamAndPlayers
IF OBJECT_ID( 'uspSP1_AddPlayerAndAssignToATeam' )					IS NOT NULL DROP PROCEDURE	uspSP1_AddPlayerAndAssignToATeam

IF OBJECT_ID( 'TPlayerGameFrameThrows' )							IS NOT NULL DROP TABLE	TPlayerGameFrameThrows
IF OBJECT_ID( 'TPlayerGameFrames' )									IS NOT NULL DROP TABLE	TPlayerGameFrames
IF OBJECT_ID( 'TPlayerGames' )										IS NOT NULL DROP TABLE	TPlayerGames
IF OBJECT_ID( 'TYearLeagueTeamGames' )								IS NOT NULL DROP TABLE	TYearLeagueTeamGames
IF OBJECT_ID( 'TYearLeagueTeamPlayers' )							IS NOT NULL DROP TABLE	TYearLeagueTeamPlayers
IF OBJECT_ID( 'TPlayers' )											IS NOT NULL DROP TABLE	TPlayers
IF OBJECT_ID( 'TYearLeagueTeams' )									IS NOT NULL DROP TABLE	TYearLeagueTeams
IF OBJECT_ID( 'TTeams' )											IS NOT NULL DROP TABLE	TTeams
IF OBJECT_ID( 'TYearLeagues' )										IS NOT NULL DROP TABLE	TYearLeagues
IF OBJECT_ID( 'TLeagues' )											IS NOT NULL DROP TABLE	TLeagues
IF OBJECT_ID( 'TYears' )											IS NOT NULL DROP TABLE	TYears

-- --------------------------------------------------------------------------------
-- Create statements
-- --------------------------------------------------------------------------------
CREATE TABLE TYears
(
	 intYearID                      INTEGER			NOT NULL
	,strYear                        VARCHAR(50)     NOT NULL
	CONSTRAINT TYears_PK PRIMARY KEY ( intYearID )
)

CREATE TABLE TLeagues
(
	 intLeagueID                    INTEGER         NOT NULL
	,strLeague                      VARCHAR(50)     NOT NULL			
	CONSTRAINT TLeagues_PK PRIMARY KEY ( intLeagueID )
)

CREATE TABLE TYearLeagues
(
	 intYearID						INTEGER         NOT NULL
	,intLeagueID                    INTEGER         NOT NULL
	,intLeaguePresidentID           INTEGER         NOT NULL
	CONSTRAINT TYearLeagues_PK PRIMARY KEY ( intYearID, intLeagueID )
)

CREATE TABLE TTeams
(
	 intTeamID						INTEGER         NOT NULL
	,strTeam                        VARCHAR(50)     NOT NULL
	CONSTRAINT TTeams_PK PRIMARY KEY ( intTeamID )
)

CREATE TABLE TPlayers
(
	 intPlayerID					INTEGER         NOT NULL
	,strFirstName                   VARCHAR(50)     NOT NULL
	,strLastName                    VARCHAR(50)     NOT NULL
	,strPhoneNumber                 VARCHAR(50)     NOT NULL
	,strAddress						VARCHAR(100)	NOT NULL
	CONSTRAINT TPlayers_PK PRIMARY KEY ( intPlayerID )
)

CREATE TABLE TYearLeagueTeams
(
	 intYearID						INTEGER         NOT NULL
	,intLeagueID                    INTEGER         NOT NULL
	,intTeamID                      INTEGER         NOT NULL
	,intTeamCaptainID               INTEGER         NOT NULL
	CONSTRAINT TYearLeagueTeams_PK PRIMARY KEY ( intYearID, intLeagueID, intTeamID )
)

CREATE TABLE TYearLeagueTeamPlayers
(
	 intYearID						INTEGER         NOT NULL
	,intLeagueID                    INTEGER         NOT NULL
	,intTeamID                      INTEGER         NOT NULL
	,intPlayerID                    INTEGER         NOT NULL
	CONSTRAINT TYearLeagueTeamPlayers_PK PRIMARY KEY ( intYearID, intLeagueID, intTeamID, intPlayerID  )
)

CREATE TABLE TYearLeagueTeamGames
(
	 intYearID						INTEGER         NOT NULL
	,intLeagueID                    INTEGER         NOT NULL
	,intTeamID                      INTEGER         NOT NULL
	,intGameIndex                   INTEGER         NOT NULL
	,intWeekIndex					INTEGER         NOT NULL
	,strVenue						VARCHAR(50)		NOT NULL
	CONSTRAINT TYearLeagueTeamGames_PK PRIMARY KEY ( intYearID, intLeagueID, intTeamID, intGameIndex, intWeekIndex )
)

CREATE TABLE TPlayerGames
(
	 intYearID						INTEGER         NOT NULL
	,intLeagueID                    INTEGER         NOT NULL
	,intTeamID                      INTEGER         NOT NULL
	,intPlayerID                    INTEGER         NOT NULL
	,intGameIndex                   INTEGER         NOT NULL
	,intWeekIndex					INTEGER         NOT NULL
	CONSTRAINT TPlayerGames_PK PRIMARY KEY ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex )
)

CREATE TABLE TPlayerGameFrames
(
	 intYearID						INTEGER         NOT NULL
	,intLeagueID                    INTEGER         NOT NULL
	,intTeamID                      INTEGER         NOT NULL
	,intPlayerID                    INTEGER         NOT NULL
	,intGameIndex                   INTEGER         NOT NULL
	,intWeekIndex					INTEGER         NOT NULL
	,intFrameIndex                  INTEGER         NOT NULL
	CONSTRAINT TPlayerGameFrames_PK PRIMARY KEY ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )
)

CREATE TABLE TPlayerGameFrameThrows
(
	 intYearID						INTEGER         NOT NULL
	,intLeagueID                    INTEGER         NOT NULL
	,intTeamID                      INTEGER         NOT NULL
	,intPlayerID                    INTEGER         NOT NULL
	,intGameIndex                   INTEGER         NOT NULL
	,intWeekIndex					INTEGER         NOT NULL
	,intFrameIndex                  INTEGER         NOT NULL
	,intThrowIndex                  INTEGER         NOT NULL
	,intPinCount					INTEGER         NOT NULL
	CONSTRAINT TPlayerGameFrameThrows_PK PRIMARY KEY ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex, intThrowIndex )
)

-- --------------------------------------------------------------------------------
-- Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------

-- #		Child							Parent					Columns
-- -		-----							------					-------
-- 1		TYearLeagues					TYears					intYearID 
-- 2		TYearLeagues					TLeagues				intLeagueID 
-- 3		TYearLeagueTeams				TYearLeagues			intYearID, intLeagueID 
-- 4		TYearLeagueTeams				TTeams					intTeamID 
-- 5		TYearLeagueTeamPlayers			TYearLeagueTeams		intYearID, intLeagueID, intTeamID
-- 6		TYearLeagueTeamGames			TYearLeagueTeams		intYearID, intLeagueID, intTeamID
-- 7		TPlayerGames					TYearLeagueTeamGames	intYearID, intLeagueID, intTeamID, intGameIndex, intWeekIndex
-- 8		TPlayerGames					TYearLeagueTeamPlayers	intYearID, intLeagueID, intTeamID, intPlayerID
-- 9		TPlayerGameFrames				TPlayerGames			intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex
-- 10		TYearLeagueTeamPlayers			TPlayers				intPlayerID
-- 11		TPlayerGameFrameThrows			TPlayerGameFrames		intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex

-- ALTER TABLE <child> ADD CONSTRAINT <child>_<parent>_FK
-- FOREIGN KEY ( <child table column(s)> ) REFERENCES <parent table>( <parent table column(s)> )

-- 1
ALTER TABLE TYearLeagues ADD CONSTRAINT TYearLeagues_TYears_FK1
FOREIGN KEY( intYearID ) REFERENCES TYears ( intYearID )

-- 2
ALTER TABLE TYearLeagues ADD CONSTRAINT TYearLeagues_TLeagues_FK1
FOREIGN KEY( intLeagueID ) REFERENCES TLeagues ( intLeagueID )

-- 3
ALTER TABLE TYearLeagueTeams ADD CONSTRAINT TYearLeagueTeams_TYearLeagues_FK1
FOREIGN KEY( intYearID, intLeagueID  ) REFERENCES TYearLeagues ( intYearID, intLeagueID  )

-- 4
ALTER TABLE TYearLeagueTeams ADD CONSTRAINT TYearLeagueTeams_TTeams_FK1
FOREIGN KEY( intTeamID ) REFERENCES TTeams ( intTeamID )

-- 5
ALTER TABLE TYearLeagueTeamPlayers ADD CONSTRAINT TYearLeagueTeamPlayers_TYearLeagueTeams_FK1
FOREIGN KEY( intYearID, intLeagueID, intTeamID ) REFERENCES TYearLeagueTeams ( intYearID, intLeagueID, intTeamID )

-- 6
ALTER TABLE TYearLeagueTeamGames ADD CONSTRAINT TYearLeagueTeamGames_TYearLeagueTeams_FK1
FOREIGN KEY( intYearID, intLeagueID, intTeamID ) REFERENCES TYearLeagueTeams ( intYearID, intLeagueID, intTeamID )

-- 7
ALTER TABLE TPlayerGames ADD CONSTRAINT TPlayerGames_TYearLeagueTeamGames_FK1
FOREIGN KEY( intYearID, intLeagueID, intTeamID, intGameIndex,intWeekIndex ) 
REFERENCES TYearLeagueTeamGames ( intYearID, intLeagueID, intTeamID, intGameIndex, intWeekIndex )

-- 8
ALTER TABLE TPlayerGames ADD CONSTRAINT TPlayerGames_TYearLeagueTeamPlayers_FK1
FOREIGN KEY( intYearID, intLeagueID, intTeamID, intPlayerID ) 
REFERENCES TYearLeagueTeamPlayers ( intYearID, intLeagueID, intTeamID, intPlayerID )

-- 9
ALTER TABLE TPlayerGameFrames ADD CONSTRAINT TPlayerGameFrames_TPlayerGames_FK1
FOREIGN KEY( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex ) 
REFERENCES TPlayerGames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex )

-- 10
ALTER TABLE TYearLeagueTeamPlayers ADD CONSTRAINT TYearLeagueTeamPlayers_TPlayers_FK1
FOREIGN KEY( intPlayerID ) REFERENCES TPlayers ( intPlayerID )

-- 11
ALTER TABLE TPlayerGameFrameThrows ADD CONSTRAINT TPlayerGameFrameThrows_TPlayerGameFrames_FK1
FOREIGN KEY( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex ) 
REFERENCES TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )

-- --------------------------------------------------------------------------------
-- Unique constraint - same player may not be duplicated on any team for the same
-- year in the same league.
-- --------------------------------------------------------------------------------
ALTER TABLE TYearLeagueTeamPlayers ADD CONSTRAINT TYearLeagueTeamPlayers_intYearID_intLeagueID_intPlayerID
UNIQUE ( intYearID, intLeagueID, intPlayerID )

-- --------------------------------------------------------------------------------
-- Add Sample data 
-- --------------------------------------------------------------------------------

INSERT INTO TYears ( intYearID, strYear )				
VALUES	 ( 1, '2011' )			
		,( 2, '2012' )									-- Sample data for yearID and year
		,( 3, '2013' )		
		,( 4, '2014' )		

INSERT INTO TLeagues ( intLeagueID, strLeague )					
VALUES	 ( 1, 'League A (singles)' )				
		,( 2, 'League B (singles)' )					-- Sample data for leagueID and League
		,( 3, 'League C (singles)' )			
		,( 4, 'League D (couples)' )			

INSERT INTO TYearLeagues (intYearID, intLeagueID, intLeaguePresidentID )				
VALUES	 ( 1, 1, 2 )			
		,( 1, 2, 2 )									-- Sample data for year, league, league presidentID = player ID
		,( 1, 3, 2 )		
		,( 1, 4, 2 )		
	
		
INSERT INTO TTeams (intTeamID, strTeam )						
VALUES	 ( 1, 'Database Destroyers' )					
		,( 2, 'Julies Strikers' )				-- List of teams
		,( 3, 'Pats Scripters' )				
		,( 4, 'Bobs Bowlers' )				
		,( 5, 'Rays Bombers' )				
		,( 6, 'Bowling Strikes' )				
		,( 7, 'Alley Cats' )				
		,( 8, 'Gutter Balls' )				
		,( 9, 'The Last Frame' )				
		,( 10, 'Ten Pins' )				
		,( 11, 'SQL Superstars' )				
		,( 12, 'Catching Spares' )				
		,( 13, 'Star Bowlers' )					-- Available Teams
		,( 14, 'Trek Favorites' )				
		,( 15, 'Spare Frames' )										

INSERT INTO TPlayers ( intPlayerID, strFirstName, strLastName, strPhoneNumber, strAddress )								
VALUES	 ( 1, 'FName01', 'LName01', '(513)555-1201', 'Address01' )							
		,( 2, 'FName02', 'LName02', '(513)555-1202', 'Address02' )						-- Auto generated list of player sample data
		,( 3, 'FName03', 'LName03', '(513)555-1203', 'Address03' )						
		,( 4, 'FName04', 'LName04', '(513)555-1204', 'Address04' )						
		,( 5, 'FName05', 'LName05', '(513)555-1205', 'Address05' )						
		,( 6, 'FName06', 'LName06', '(513)555-1206', 'Address06' )						
		,( 7, 'FName07', 'LName07', '(513)555-1207', 'Address07' )						
		,( 8, 'FName08', 'LName08', '(513)555-1208', 'Address08' )						
		,( 9, 'FName09', 'LName09', '(513)555-1209', 'Address09' )						
		,( 10, 'FName10', 'LName10', '(513)555-1210', 'Address10' )						
		,( 11, 'FName11', 'LName11', '(513)555-1211', 'Address11' )						
		,( 12, 'FName12', 'LName12', '(513)555-1212', 'Address12' )						
		,( 13, 'FName13', 'LName13', '(513)555-1213', 'Address13' )						
		,( 14, 'FName14', 'LName14', '(513)555-1214', 'Address14' )						
		,( 15, 'FName15', 'LName15', '(513)555-1215', 'Address15' )						
		,( 16, 'FName16', 'LName16', '(513)555-1216', 'Address16' )						
		,( 17, 'FName17', 'LName17', '(513)555-1217', 'Address17' )						
		,( 18, 'FName18', 'LName18', '(513)555-1218', 'Address18' )						
		,( 19, 'FName19', 'LName19', '(513)555-1219', 'Address19' )						
		,( 20, 'FName20', 'LName20', '(513)555-1220', 'Address20' )						
		,( 21, 'FName21', 'LName21', '(513)555-1221', 'Address21' )						
		,( 22, 'FName22', 'LName22', '(513)555-1222', 'Address22' )						
		,( 23, 'FName23', 'LName23', '(513)555-1223', 'Address23' )						
		,( 24, 'FName24', 'LName24', '(513)555-1223', 'Address24' )						
		,( 25, 'FName25', 'LName25', '(513)555-1225', 'Address25' )						
		,( 26, 'FName26', 'LName26', '(513)555-1226', 'Address26' )						
		,( 27, 'FName27', 'LName27', '(513)555-1227', 'Address27' )						
		,( 28, 'FName28', 'LName28', '(513)555-1228', 'Address28' )						
		,( 29, 'FName29', 'LName29', '(513)555-1229', 'Address29' )						
		,( 30, 'FName30', 'LName30', '(513)555-1230', 'Address30' )						
		,( 31, 'FName31', 'LName31', '(513)555-1231', 'Address31' )						
		,( 32, 'FName32', 'LName32', '(513)555-1232', 'Address32' )						
		,( 33, 'FName33', 'LName33', '(513)555-1233', 'Address33' )						
		,( 34, 'FName34', 'LName34', '(513)555-1234', 'Address34' )						
		,( 35, 'FName35', 'LName35', '(513)555-1235', 'Address35' )						
		,( 36, 'FName36', 'LName36', '(513)555-1236', 'Address36' )						
		,( 37, 'FName37', 'LName37', '(513)555-1237', 'Address37' )						
		,( 38, 'FName38', 'LName38', '(513)555-1238', 'Address38' )						
		,( 39, 'FName39', 'LName39', '(513)555-1239', 'Address39' )						
		,( 40, 'FName40', 'LName40', '(513)555-1240', 'Address40' )						
		,( 41, 'FName41', 'LName41', '(513)555-1241', 'Address41' )						
		,( 42, 'FName42', 'LName42', '(513)555-1242', 'Address42' )						
		,( 43, 'FName43', 'LName43', '(513)555-1243', 'Address43' )						
		,( 44, 'FName44', 'LName44', '(513)555-1244', 'Address44' )						
		,( 45, 'FName45', 'LName45', '(513)555-1245', 'Address45' )						
		,( 46, 'FName46', 'LName46', '(513)555-1246', 'Address46' )						
		,( 47, 'FName47', 'LName47', '(513)555-1247', 'Address47' )						
		,( 48, 'FName48', 'LName48', '(513)555-1248', 'Address48' )						
		,( 49, 'Joe', 'Crab', '(513)555-1249', '67 Walnut' )						-- Available players
		,( 50, 'Pete', 'Abred', '(513)555-1250', '76 Oak' )						
		,( 51, 'Bill', 'Ding', '(513)55-1251', '87 Sycamore' )						
		,( 52, 'Sue', 'Flay', '(513)555-1252', '78 Pine' )	
									
INSERT INTO TYearLeagueTeams ( intYearID, intLeagueID, intTeamID, intTeamCaptainID )					
VALUES	 ( 1, 1, 1, 4 )				
		,( 1, 1, 2, 7 )				-- Year 2011, Leagues 1 thru 4: Teams: 1 thru 12, Team Captain ID = playerID
		,( 1, 1, 3, 11 )			
		,( 1, 2, 4, 15 )			
		,( 1, 2, 5, 19 )			
		,( 1, 2, 6, 23 )			
		,( 1, 3, 7, 27 )			
		,( 1, 3, 8, 31 )			
		,( 1, 3, 9, 35 )			
		,( 1, 4, 10, 38 )			
		,( 1, 4, 11, 43 )			
		,( 1, 4, 12, 47 )			
	

INSERT INTO TYearLeagueTeamPlayers ( intYearID, intLeagueID, intTeamID, intPlayerID )						
VALUES	 ( 1, 1, 1, 1 )					
		,( 1, 1, 1, 2 )				-- Year 2011, League, Team & Player ID's
		,( 1, 1, 1, 3 )				
		,( 1, 1, 1, 4 )				
		,( 1, 1, 2, 5 )				
		,( 1, 1, 2, 6 )				
		,( 1, 1, 2, 7 )				
		,( 1, 1, 2, 8 )				
		,( 1, 1, 3, 9 )				
		,( 1, 1, 3, 10 )				
		,( 1, 1, 3, 11 )				
		,( 1, 1, 3, 12 )				
		,( 1, 2, 4, 13 )				
		,( 1, 2, 4, 14 )				
		,( 1, 2, 4, 15 )				
		,( 1, 2, 4, 16 )				
		,( 1, 2, 5, 17 )				
		,( 1, 2, 5, 18 )				
		,( 1, 2, 5, 19 )				
		,( 1, 2, 5, 20 )				
		,( 1, 2, 6, 21 )				
		,( 1, 2, 6, 22 )				
		,( 1, 2, 6, 23 )				
		,( 1, 2, 6, 24 )				
		,( 1, 3, 7, 25 )				
		,( 1, 3, 7, 26 )				
		,( 1, 3, 7, 27 )				
		,( 1, 3, 7, 28 )				
		,( 1, 3, 8, 29 )				
		,( 1, 3, 8, 30 )				
		,( 1, 3, 8, 31 )				
		,( 1, 3, 8, 32 )				
		,( 1, 3, 9, 33 )				
		,( 1, 3, 9, 34 )				
		,( 1, 3, 9, 35 )				
		,( 1, 3, 9, 36 )				
		,( 1, 4, 10, 1 )				
		,( 1, 4, 10, 38 )				
		,( 1, 4, 10, 39 )				
		,( 1, 4, 10, 40 )				
		,( 1, 4, 11, 41 )				
		,( 1, 4, 11, 42 )				
		,( 1, 4, 11, 43 )				
		,( 1, 4, 11, 44 )				
		,( 1, 4, 12, 45 )				
		,( 1, 4, 12, 46 )				
		,( 1, 4, 12, 47 )				
		,( 1, 4, 12, 48 )				
			
INSERT INTO TYearLeagueTeamGames ( intYearID, intLeagueID, intTeamID, intGameIndex, intWeekIndex, strVenue )
VALUES	 ( 1, 1, 1, 1, 1, 'Western Bowl' )						
		,( 1, 1, 1, 2, 1, 'Durbin Bowl' )					-- Year 2011, League: 1,Teams: 1 - 3, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 1, 1, 3, 1, 'Harrison Bowl' )					
		,( 1, 1, 1, 4, 2, 'Western Bowl' )					
		,( 1, 1, 1, 5, 2, 'Durbin Bowl' )					
		,( 1, 1, 1, 6, 2, 'Harrison Bowl' )					
		,( 1, 1, 1, 7, 3, 'Western Bowl' )					
		,( 1, 1, 1, 8, 3, 'Durbin Bowl' )					
		,( 1, 1, 1, 9, 3, 'Harrison Bowl' )					
		,( 1, 1, 1, 10, 4, 'Western Bowl' )					
		,( 1, 1, 1, 11, 4, 'Durbin Bowl' )					
		,( 1, 1, 1, 12, 4, 'Harrison Bowl' )					
		,( 1, 1, 1, 13, 5, 'Western Bowl' )					
		,( 1, 1, 1, 14, 5, 'Durbin Bowl' )					
		,( 1, 1, 1, 15, 5, 'Harrison Bowl' )					
		,( 1, 1, 1, 16, 6, 'Western Bowl' )					
		,( 1, 1, 1, 17, 6, 'Durbin Bowl' )					
		,( 1, 1, 1, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 1, 2, 1, 1, 'Western Bowl' )					
		,( 1, 1, 2, 2, 1, 'Durbin Bowl' )					
		,( 1, 1, 2, 3, 1, 'Harrison Bowl' )					
		,( 1, 1, 2, 4, 2, 'Western Bowl' )					
		,( 1, 1, 2, 5, 2, 'Durbin Bowl' )					
		,( 1, 1, 2, 6, 2, 'Harrison Bowl' )					
		,( 1, 1, 2, 7, 3, 'Western Bowl' )					
		,( 1, 1, 2, 8, 3, 'Durbin Bowl' )					
		,( 1, 1, 2, 9, 3, 'Harrison Bowl' )					
		,( 1, 1, 2, 10, 4, 'Western Bowl' )					
		,( 1, 1, 2, 11, 4, 'Durbin Bowl' )					
		,( 1, 1, 2, 12, 4, 'Harrison Bowl' )					
		,( 1, 1, 2, 13, 5, 'Western Bowl' )					
		,( 1, 1, 2, 14, 5, 'Durbin Bowl' )					
		,( 1, 1, 2, 15, 5, 'Harrison Bowl' )					
		,( 1, 1, 2, 16, 6, 'Western Bowl' )					
		,( 1, 1, 2, 17, 6, 'Durbin Bowl' )					
		,( 1, 1, 2, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 1, 3, 1, 1, 'Western Bowl' )					
		,( 1, 1, 3, 2, 1, 'Durbin Bowl' )					
		,( 1, 1, 3, 3, 1, 'Harrison Bowl' )					
		,( 1, 1, 3, 4, 2, 'Western Bowl' )					
		,( 1, 1, 3, 5, 2, 'Durbin Bowl' )					
		,( 1, 1, 3, 6, 2, 'Harrison Bowl' )					
		,( 1, 1, 3, 7, 3, 'Western Bowl' )					
		,( 1, 1, 3, 8, 3, 'Durbin Bowl' )					
		,( 1, 1, 3, 9, 3, 'Harrison Bowl' )					
		,( 1, 1, 3, 10, 4, 'Western Bowl' )					
		,( 1, 1, 3, 11, 4, 'Durbin Bowl' )					
		,( 1, 1, 3, 12, 4, 'Harrison Bowl' )					
		,( 1, 1, 3, 13, 5, 'Western Bowl' )					
		,( 1, 1, 3, 14, 5, 'Durbin Bowl' )					
		,( 1, 1, 3, 15, 5, 'Harrison Bowl' )					
		,( 1, 1, 3, 16, 6, 'Western Bowl' )					
		,( 1, 1, 3, 17, 6, 'Durbin Bowl' )					
		,( 1, 1, 3, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 2, 4, 1, 1, 'Western Bowl' )					
		,( 1, 2, 4, 2, 1, 'Durbin Bowl' )					-- Year 2011, League: 2,Teams: 4 - 6, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 2, 4, 3, 1, 'Harrison Bowl' )					
		,( 1, 2, 4, 4, 2, 'Western Bowl' )					
		,( 1, 2, 4, 5, 2, 'Durbin Bowl' )					
		,( 1, 2, 4, 6, 2, 'Harrison Bowl' )					
		,( 1, 2, 4, 7, 3, 'Western Bowl' )					
		,( 1, 2, 4, 8, 3, 'Durbin Bowl' )					
		,( 1, 2, 4, 9, 3, 'Harrison Bowl' )					
		,( 1, 2, 4, 10, 4, 'Western Bowl' )					
		,( 1, 2, 4, 11, 4, 'Durbin Bowl' )					
		,( 1, 2, 4, 12, 4, 'Harrison Bowl' )					
		,( 1, 2, 4, 13, 5, 'Western Bowl' )					
		,( 1, 2, 4, 14, 5, 'Durbin Bowl' )					
		,( 1, 2, 4, 15, 5, 'Harrison Bowl' )					
		,( 1, 2, 4, 16, 6, 'Western Bowl' )					
		,( 1, 2, 4, 17, 6, 'Durbin Bowl' )					
		,( 1, 2, 4, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 2, 5, 1, 1, 'Western Bowl' )					
		,( 1, 2, 5, 2, 1, 'Durbin Bowl' )					
		,( 1, 2, 5, 3, 1, 'Harrison Bowl' )					
		,( 1, 2, 5, 4, 2, 'Western Bowl' )					
		,( 1, 2, 5, 5, 2, 'Durbin Bowl' )					
		,( 1, 2, 5, 6, 2, 'Harrison Bowl' )					
		,( 1, 2, 5, 7, 3, 'Western Bowl' )					
		,( 1, 2, 5, 8, 3, 'Durbin Bowl' )					
		,( 1, 2, 5, 9, 3, 'Harrison Bowl' )					
		,( 1, 2, 5, 10, 4, 'Western Bowl' )					
		,( 1, 2, 5, 11, 4, 'Durbin Bowl' )					
		,( 1, 2, 5, 12, 4, 'Harrison Bowl' )					
		,( 1, 2, 5, 13, 5, 'Western Bowl' )					
		,( 1, 2, 5, 14, 5, 'Durbin Bowl' )					
		,( 1, 2, 5, 15, 5, 'Harrison Bowl' )					
		,( 1, 2, 5, 16, 6, 'Western Bowl' )					
		,( 1, 2, 5, 17, 6, 'Durbin Bowl' )					
		,( 1, 2, 5, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 2, 6, 1, 1, 'Western Bowl' )					
		,( 1, 2, 6, 2, 1, 'Durbin Bowl' )					
		,( 1, 2, 6, 3, 1, 'Harrison Bowl' )					
		,( 1, 2, 6, 4, 2, 'Western Bowl' )					
		,( 1, 2, 6, 5, 2, 'Durbin Bowl' )					
		,( 1, 2, 6, 6, 2, 'Harrison Bowl' )					
		,( 1, 2, 6, 7, 3, 'Western Bowl' )					
		,( 1, 2, 6, 8, 3, 'Durbin Bowl' )					
		,( 1, 2, 6, 9, 3, 'Harrison Bowl' )					
		,( 1, 2, 6, 10, 4, 'Western Bowl' )					
		,( 1, 2, 6, 11, 4, 'Durbin Bowl' )					
		,( 1, 2, 6, 12, 4, 'Harrison Bowl' )					
		,( 1, 2, 6, 13, 5, 'Western Bowl' )					
		,( 1, 2, 6, 14, 5, 'Durbin Bowl' )					
		,( 1, 2, 6, 15, 5, 'Harrison Bowl' )					
		,( 1, 2, 6, 16, 6, 'Western Bowl' )					
		,( 1, 2, 6, 17, 6, 'Durbin Bowl' )					
		,( 1, 2, 6, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 3, 7, 1, 1, 'Western Bowl' )					
		,( 1, 3, 7, 2, 1, 'Durbin Bowl' )					-- Year 2011, League: 3,Teams: 7 - 9, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 3, 7, 3, 1, 'Harrison Bowl' )					
		,( 1, 3, 7, 4, 2, 'Western Bowl' )					
		,( 1, 3, 7, 5, 2, 'Durbin Bowl' )					
		,( 1, 3, 7, 6, 2, 'Harrison Bowl' )					
		,( 1, 3, 7, 7, 3, 'Western Bowl' )					
		,( 1, 3, 7, 8, 3, 'Durbin Bowl' )					
		,( 1, 3, 7, 9, 3, 'Harrison Bowl' )					
		,( 1, 3, 7, 10, 4, 'Western Bowl' )					
		,( 1, 3, 7, 11, 4, 'Durbin Bowl' )					
		,( 1, 3, 7, 12, 4, 'Harrison Bowl' )					
		,( 1, 3, 7, 13, 5, 'Western Bowl' )					
		,( 1, 3, 7, 14, 5, 'Durbin Bowl' )					
		,( 1, 3, 7, 15, 5, 'Harrison Bowl' )					
		,( 1, 3, 7, 16, 6, 'Western Bowl' )					
		,( 1, 3, 7, 17, 6, 'Durbin Bowl' )					
		,( 1, 3, 7, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 3, 8, 1, 1, 'Western Bowl' )					
		,( 1, 3, 8, 2, 1, 'Durbin Bowl' )					
		,( 1, 3, 8, 3, 1, 'Harrison Bowl' )					
		,( 1, 3, 8, 4, 2, 'Western Bowl' )					
		,( 1, 3, 8, 5, 2, 'Durbin Bowl' )					
		,( 1, 3, 8, 6, 2, 'Harrison Bowl' )					
		,( 1, 3, 8, 7, 3, 'Western Bowl' )					
		,( 1, 3, 8, 8, 3, 'Durbin Bowl' )					
		,( 1, 3, 8, 9, 3, 'Harrison Bowl' )					
		,( 1, 3, 8, 10, 4, 'Western Bowl' )					
		,( 1, 3, 8, 11, 4, 'Durbin Bowl' )					
		,( 1, 3, 8, 12, 4, 'Harrison Bowl' )					
		,( 1, 3, 8, 13, 5, 'Western Bowl' )					
		,( 1, 3, 8, 14, 5, 'Durbin Bowl' )					
		,( 1, 3, 8, 15, 5, 'Harrison Bowl' )					
		,( 1, 3, 8, 16, 6, 'Western Bowl' )					
		,( 1, 3, 8, 17, 6, 'Durbin Bowl' )					
		,( 1, 3, 8, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 3, 9, 1, 1, 'Western Bowl' )					
		,( 1, 3, 9, 2, 1, 'Durbin Bowl' )					
		,( 1, 3, 9, 3, 1, 'Harrison Bowl' )					
		,( 1, 3, 9, 4, 2, 'Western Bowl' )					
		,( 1, 3, 9, 5, 2, 'Durbin Bowl' )					
		,( 1, 3, 9, 6, 2, 'Harrison Bowl' )					
		,( 1, 3, 9, 7, 3, 'Western Bowl' )					
		,( 1, 3, 9, 8, 3, 'Durbin Bowl' )					
		,( 1, 3, 9, 9, 3, 'Harrison Bowl' )					
		,( 1, 3, 9, 10, 4, 'Western Bowl' )					
		,( 1, 3, 9, 11, 4, 'Durbin Bowl' )					
		,( 1, 3, 9, 12, 4, 'Harrison Bowl' )					
		,( 1, 3, 9, 13, 5, 'Western Bowl' )					
		,( 1, 3, 9, 14, 5, 'Durbin Bowl' )					
		,( 1, 3, 9, 15, 5, 'Harrison Bowl' )					
		,( 1, 3, 9, 16, 6, 'Western Bowl' )					
		,( 1, 3, 9, 17, 6, 'Durbin Bowl' )					
		,( 1, 3, 9, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 4, 10, 1, 1, 'Western Bowl' )					
		,( 1, 4, 10, 2, 1, 'Durbin Bowl' )					-- Year 2011, League: 4,Teams: 10 - 12, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 4, 10, 3, 1, 'Harrison Bowl' )					
		,( 1, 4, 10, 4, 2, 'Western Bowl' )					
		,( 1, 4, 10, 5, 2, 'Durbin Bowl' )					
		,( 1, 4, 10, 6, 2, 'Harrison Bowl' )					
		,( 1, 4, 10, 7, 3, 'Western Bowl' )					
		,( 1, 4, 10, 8, 3, 'Durbin Bowl' )					
		,( 1, 4, 10, 9, 3, 'Harrison Bowl' )					
		,( 1, 4, 10, 10, 4, 'Western Bowl' )					
		,( 1, 4, 10, 11, 4, 'Durbin Bowl' )					
		,( 1, 4, 10, 12, 4, 'Harrison Bowl' )					
		,( 1, 4, 10, 13, 5, 'Western Bowl' )					
		,( 1, 4, 10, 14, 5, 'Durbin Bowl' )					
		,( 1, 4, 10, 15, 5, 'Harrison Bowl' )					
		,( 1, 4, 10, 16, 6, 'Western Bowl' )					
		,( 1, 4, 10, 17, 6, 'Durbin Bowl' )					
		,( 1, 4, 10, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 4, 11, 1, 1, 'Western Bowl' )					
		,( 1, 4, 11, 2, 1, 'Durbin Bowl' )					
		,( 1, 4, 11, 3, 1, 'Harrison Bowl' )					
		,( 1, 4, 11, 4, 2, 'Western Bowl' )					
		,( 1, 4, 11, 5, 2, 'Durbin Bowl' )					
		,( 1, 4, 11, 6, 2, 'Harrison Bowl' )					
		,( 1, 4, 11, 7, 3, 'Western Bowl' )					
		,( 1, 4, 11, 8, 3, 'Durbin Bowl' )					
		,( 1, 4, 11, 9, 3, 'Harrison Bowl' )					
		,( 1, 4, 11, 10, 4, 'Western Bowl' )					
		,( 1, 4, 11, 11, 4, 'Durbin Bowl' )					
		,( 1, 4, 11, 12, 4, 'Harrison Bowl' )					
		,( 1, 4, 11, 13, 5, 'Western Bowl' )					
		,( 1, 4, 11, 14, 5, 'Durbin Bowl' )					
		,( 1, 4, 11, 15, 5, 'Harrison Bowl' )					
		,( 1, 4, 11, 16, 6, 'Western Bowl' )					
		,( 1, 4, 11, 17, 6, 'Durbin Bowl' )					
		,( 1, 4, 11, 18, 6, 'Harrison Bowl' )					
							
		,( 1, 4, 12, 1, 1, 'Western Bowl' )					
		,( 1, 4, 12, 2, 1, 'Durbin Bowl' )					
		,( 1, 4, 12, 3, 1, 'Harrison Bowl' )					
		,( 1, 4, 12, 4, 2, 'Western Bowl' )					
		,( 1, 4, 12, 5, 2, 'Durbin Bowl' )					
		,( 1, 4, 12, 6, 2, 'Harrison Bowl' )					
		,( 1, 4, 12, 7, 3, 'Western Bowl' )					
		,( 1, 4, 12, 8, 3, 'Durbin Bowl' )					
		,( 1, 4, 12, 9, 3, 'Harrison Bowl' )					
		,( 1, 4, 12, 10, 4, 'Western Bowl' )					
		,( 1, 4, 12, 11, 4, 'Durbin Bowl' )					
		,( 1, 4, 12, 12, 4, 'Harrison Bowl' )					
		,( 1, 4, 12, 13, 5, 'Western Bowl' )					
		,( 1, 4, 12, 14, 5, 'Durbin Bowl' )					
		,( 1, 4, 12, 15, 5, 'Harrison Bowl' )					
		,( 1, 4, 12, 16, 6, 'Western Bowl' )					
		,( 1, 4, 12, 17, 6, 'Durbin Bowl' )					
		,( 1, 4, 12, 18, 6, 'Harrison Bowl' )													

INSERT INTO TPlayerGames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex )						
VALUES	 ( 1, 1, 1, 1, 1, 1 )					
		,( 1, 1, 1, 1, 2, 1 )				-- Year 2011, League: 1,Team: 1, Players: 1 - 4, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 1, 1, 1, 3, 1 )				
		,( 1, 1, 1, 1, 4, 2 )				
		,( 1, 1, 1, 1, 5, 2 )				
		,( 1, 1, 1, 1, 6, 2 )				
		,( 1, 1, 1, 1, 7, 3 )				
		,( 1, 1, 1, 1, 8, 3 )				
		,( 1, 1, 1, 1, 9, 3 )				
		,( 1, 1, 1, 1, 10, 4 )				
		,( 1, 1, 1, 1, 11, 4 )				
		,( 1, 1, 1, 1, 12, 4 )				
		,( 1, 1, 1, 1, 13, 5 )				
		,( 1, 1, 1, 1, 14, 5 )				
		,( 1, 1, 1, 1, 15, 5 )				
		,( 1, 1, 1, 1, 16, 6 )				
		,( 1, 1, 1, 1, 17, 6 )				
		,( 1, 1, 1, 1, 18, 6 )				
						
		,( 1, 1, 1, 2, 1, 1 )				
		,( 1, 1, 1, 2, 2, 1 )				
		,( 1, 1, 1, 2, 3, 1 )				
		,( 1, 1, 1, 2, 4, 2 )				
		,( 1, 1, 1, 2, 5, 2 )				
		,( 1, 1, 1, 2, 6, 2 )				
		,( 1, 1, 1, 2, 7, 3 )				
		,( 1, 1, 1, 2, 8, 3 )				
		,( 1, 1, 1, 2, 9, 3 )				
		,( 1, 1, 1, 2, 10, 4 )				
		,( 1, 1, 1, 2, 11, 4 )				
		,( 1, 1, 1, 2, 12, 4 )				
		,( 1, 1, 1, 2, 13, 5 )				
		,( 1, 1, 1, 2, 14, 5 )				
		,( 1, 1, 1, 2, 15, 5 )				
		,( 1, 1, 1, 2, 16, 6 )				
		,( 1, 1, 1, 2, 17, 6 )				
		,( 1, 1, 1, 2, 18, 6 )				
						
		,( 1, 1, 1, 3, 1, 1 )				
		,( 1, 1, 1, 3, 2, 1 )				
		,( 1, 1, 1, 3, 3, 1 )				
		,( 1, 1, 1, 3, 4, 2 )				
		,( 1, 1, 1, 3, 5, 2 )				
		,( 1, 1, 1, 3, 6, 2 )				
		,( 1, 1, 1, 3, 7, 3 )				
		,( 1, 1, 1, 3, 8, 3 )				
		,( 1, 1, 1, 3, 9, 3 )				
		,( 1, 1, 1, 3, 10, 4 )				
		,( 1, 1, 1, 3, 11, 4 )				
		,( 1, 1, 1, 3, 12, 4 )				
		,( 1, 1, 1, 3, 13, 5 )				
		,( 1, 1, 1, 3, 14, 5 )				
		,( 1, 1, 1, 3, 15, 5 )				
		,( 1, 1, 1, 3, 16, 6 )				
		,( 1, 1, 1, 3, 17, 6 )				
		,( 1, 1, 1, 3, 18, 6 )				
						
		,( 1, 1, 1, 4, 1, 1 )				
		,( 1, 1, 1, 4, 2, 1 )				
		,( 1, 1, 1, 4, 3, 1 )				
		,( 1, 1, 1, 4, 4, 2 )				
		,( 1, 1, 1, 4, 5, 2 )				
		,( 1, 1, 1, 4, 6, 2 )				
		,( 1, 1, 1, 4, 7, 3 )				
		,( 1, 1, 1, 4, 8, 3 )				
		,( 1, 1, 1, 4, 9, 3 )				
		,( 1, 1, 1, 4, 10, 4 )				
		,( 1, 1, 1, 4, 11, 4 )				
		,( 1, 1, 1, 4, 12, 4 )				
		,( 1, 1, 1, 4, 13, 5 )				
		,( 1, 1, 1, 4, 14, 5 )				
		,( 1, 1, 1, 4, 15, 5 )				
		,( 1, 1, 1, 4, 16, 6 )				
		,( 1, 1, 1, 4, 17, 6 )				
		,( 1, 1, 1, 4, 18, 6 )				
						
		,( 1, 1, 2, 5, 1, 1 )				
		,( 1, 1, 2, 5, 2, 1 )				-- Year 2011, League: 1,Team: 2, Players: 5 - 8, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 1, 2, 5, 3, 1 )				
		,( 1, 1, 2, 5, 4, 2 )				
		,( 1, 1, 2, 5, 5, 2 )				
		,( 1, 1, 2, 5, 6, 2 )				
		,( 1, 1, 2, 5, 7, 3 )				
		,( 1, 1, 2, 5, 8, 3 )				
		,( 1, 1, 2, 5, 9, 3 )				
		,( 1, 1, 2, 5, 10, 4 )				
		,( 1, 1, 2, 5, 11, 4 )				
		,( 1, 1, 2, 5, 12, 4 )				
		,( 1, 1, 2, 5, 13, 5 )				
		,( 1, 1, 2, 5, 14, 5 )				
		,( 1, 1, 2, 5, 15, 5 )				
		,( 1, 1, 2, 5, 16, 6 )				
		,( 1, 1, 2, 5, 17, 6 )				
		,( 1, 1, 2, 5, 18, 6 )				
						
		,( 1, 1, 2, 6, 1, 1 )				
		,( 1, 1, 2, 6, 2, 1 )				
		,( 1, 1, 2, 6, 3, 1 )				
		,( 1, 1, 2, 6, 4, 2 )				
		,( 1, 1, 2, 6, 5, 2 )				
		,( 1, 1, 2, 6, 6, 2 )				
		,( 1, 1, 2, 6, 7, 3 )				
		,( 1, 1, 2, 6, 8, 3 )				
		,( 1, 1, 2, 6, 9, 3 )				
		,( 1, 1, 2, 6, 10, 4 )				
		,( 1, 1, 2, 6, 11, 4 )				
		,( 1, 1, 2, 6, 12, 4 )				
		,( 1, 1, 2, 6, 13, 5 )				
		,( 1, 1, 2, 6, 14, 5 )				
		,( 1, 1, 2, 6, 15, 5 )				
		,( 1, 1, 2, 6, 16, 6 )				
		,( 1, 1, 2, 6, 17, 6 )				
		,( 1, 1, 2, 6, 18, 6 )				
						
		,( 1, 1, 2, 7, 1, 1 )				
		,( 1, 1, 2, 7, 2, 1 )				
		,( 1, 1, 2, 7, 3, 1 )				
		,( 1, 1, 2, 7, 4, 2 )				
		,( 1, 1, 2, 7, 5, 2 )				
		,( 1, 1, 2, 7, 6, 2 )				
		,( 1, 1, 2, 7, 7, 3 )				
		,( 1, 1, 2, 7, 8, 3 )				
		,( 1, 1, 2, 7, 9, 3 )				
		,( 1, 1, 2, 7, 10, 4 )				
		,( 1, 1, 2, 7, 11, 4 )				
		,( 1, 1, 2, 7, 12, 4 )				
		,( 1, 1, 2, 7, 13, 5 )				
		,( 1, 1, 2, 7, 14, 5 )				
		,( 1, 1, 2, 7, 15, 5 )				
		,( 1, 1, 2, 7, 16, 6 )				
		,( 1, 1, 2, 7, 17, 6 )				
		,( 1, 1, 2, 7, 18, 6 )				
						
		,( 1, 1, 2, 8, 1, 1 )				
		,( 1, 1, 2, 8, 2, 1 )				
		,( 1, 1, 2, 8, 3, 1 )				
		,( 1, 1, 2, 8, 4, 2 )				
		,( 1, 1, 2, 8, 5, 2 )				
		,( 1, 1, 2, 8, 6, 2 )				
		,( 1, 1, 2, 8, 7, 3 )				
		,( 1, 1, 2, 8, 8, 3 )				
		,( 1, 1, 2, 8, 9, 3 )				
		,( 1, 1, 2, 8, 10, 4 )				
		,( 1, 1, 2, 8, 11, 4 )				
		,( 1, 1, 2, 8, 12, 4 )				
		,( 1, 1, 2, 8, 13, 5 )				
		,( 1, 1, 2, 8, 14, 5 )				
		,( 1, 1, 2, 8, 15, 5 )				
		,( 1, 1, 2, 8, 16, 6 )				
		,( 1, 1, 2, 8, 17, 6 )				
		,( 1, 1, 2, 8, 18, 6 )				
						
		,( 1, 1, 3, 9, 1, 1 )				
		,( 1, 1, 3, 9, 2, 1 )				-- Year 2011, League: 1,Team: 3, Players: 9 - 12, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 1, 3, 9, 3, 1 )				
		,( 1, 1, 3, 9, 4, 2 )				
		,( 1, 1, 3, 9, 5, 2 )				
		,( 1, 1, 3, 9, 6, 2 )				
		,( 1, 1, 3, 9, 7, 3 )				
		,( 1, 1, 3, 9, 8, 3 )				
		,( 1, 1, 3, 9, 9, 3 )				
		,( 1, 1, 3, 9, 10, 4 )				
		,( 1, 1, 3, 9, 11, 4 )				
		,( 1, 1, 3, 9, 12, 4 )				
		,( 1, 1, 3, 9, 13, 5 )				
		,( 1, 1, 3, 9, 14, 5 )				
		,( 1, 1, 3, 9, 15, 5 )				
		,( 1, 1, 3, 9, 16, 6 )				
		,( 1, 1, 3, 9, 17, 6 )				
		,( 1, 1, 3, 9, 18, 6 )				
						
		,( 1, 1, 3, 10, 1, 1 )				
		,( 1, 1, 3, 10, 2, 1 )				
		,( 1, 1, 3, 10, 3, 1 )				
		,( 1, 1, 3, 10, 4, 2 )				
		,( 1, 1, 3, 10, 5, 2 )				
		,( 1, 1, 3, 10, 6, 2 )				
		,( 1, 1, 3, 10, 7, 3 )				
		,( 1, 1, 3, 10, 8, 3 )				
		,( 1, 1, 3, 10, 9, 3 )				
		,( 1, 1, 3, 10, 10, 4 )				
		,( 1, 1, 3, 10, 11, 4 )				
		,( 1, 1, 3, 10, 12, 4 )				
		,( 1, 1, 3, 10, 13, 5 )				
		,( 1, 1, 3, 10, 14, 5 )				
		,( 1, 1, 3, 10, 15, 5 )				
		,( 1, 1, 3, 10, 16, 6 )				
		,( 1, 1, 3, 10, 17, 6 )				
		,( 1, 1, 3, 10, 18, 6 )				
						
		,( 1, 1, 3, 11, 1, 1 )				
		,( 1, 1, 3, 11, 2, 1 )				
		,( 1, 1, 3, 11, 3, 1 )				
		,( 1, 1, 3, 11, 4, 2 )				
		,( 1, 1, 3, 11, 5, 2 )				
		,( 1, 1, 3, 11, 6, 2 )				
		,( 1, 1, 3, 11, 7, 3 )				
		,( 1, 1, 3, 11, 8, 3 )				
		,( 1, 1, 3, 11, 9, 3 )				
		,( 1, 1, 3, 11, 10, 4 )				
		,( 1, 1, 3, 11, 11, 4 )				
		,( 1, 1, 3, 11, 12, 4 )				
		,( 1, 1, 3, 11, 13, 5 )				
		,( 1, 1, 3, 11, 14, 5 )				
		,( 1, 1, 3, 11, 15, 5 )				
		,( 1, 1, 3, 11, 16, 6 )				
		,( 1, 1, 3, 11, 17, 6 )				
		,( 1, 1, 3, 11, 18, 6 )				
						
		,( 1, 1, 3, 12, 1, 1 )				
		,( 1, 1, 3, 12, 2, 1 )				
		,( 1, 1, 3, 12, 3, 1 )				
		,( 1, 1, 3, 12, 4, 2 )				
		,( 1, 1, 3, 12, 5, 2 )				
		,( 1, 1, 3, 12, 6, 2 )				
		,( 1, 1, 3, 12, 7, 3 )				
		,( 1, 1, 3, 12, 8, 3 )				
		,( 1, 1, 3, 12, 9, 3 )				
		,( 1, 1, 3, 12, 10, 4 )				
		,( 1, 1, 3, 12, 11, 4 )				
		,( 1, 1, 3, 12, 12, 4 )				
		,( 1, 1, 3, 12, 13, 5 )				
		,( 1, 1, 3, 12, 14, 5 )				
		,( 1, 1, 3, 12, 15, 5 )				
		,( 1, 1, 3, 12, 16, 6 )				
		,( 1, 1, 3, 12, 17, 6 )				
		,( 1, 1, 3, 12, 18, 6 )				
						
INSERT INTO TPlayerGames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex )						
VALUES	 ( 1, 2, 4, 13, 1, 1 )					
		,( 1, 2, 4, 13, 2, 1 )				-- Year 2011, League: 2,Team: 4, Players: 13 - 16, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 2, 4, 13, 3, 1 )				
		,( 1, 2, 4, 13, 4, 2 )				
		,( 1, 2, 4, 13, 5, 2 )				
		,( 1, 2, 4, 13, 6, 2 )				
		,( 1, 2, 4, 13, 7, 3 )				
		,( 1, 2, 4, 13, 8, 3 )				
		,( 1, 2, 4, 13, 9, 3 )				
		,( 1, 2, 4, 13, 10, 4 )				
		,( 1, 2, 4, 13, 11, 4 )				
		,( 1, 2, 4, 13, 12, 4 )				
		,( 1, 2, 4, 13, 13, 5 )				
		,( 1, 2, 4, 13, 14, 5 )				
		,( 1, 2, 4, 13, 15, 5 )				
		,( 1, 2, 4, 13, 16, 6 )				
		,( 1, 2, 4, 13, 17, 6 )				
		,( 1, 2, 4, 13, 18, 6 )				
						
		,( 1, 2, 4, 14, 1, 1 )				
		,( 1, 2, 4, 14, 2, 1 )				
		,( 1, 2, 4, 14, 3, 1 )				
		,( 1, 2, 4, 14, 4, 2 )				
		,( 1, 2, 4, 14, 5, 2 )				
		,( 1, 2, 4, 14, 6, 2 )				
		,( 1, 2, 4, 14, 7, 3 )				
		,( 1, 2, 4, 14, 8, 3 )				
		,( 1, 2, 4, 14, 9, 3 )				
		,( 1, 2, 4, 14, 10, 4 )				
		,( 1, 2, 4, 14, 11, 4 )				
		,( 1, 2, 4, 14, 12, 4 )				
		,( 1, 2, 4, 14, 13, 5 )				
		,( 1, 2, 4, 14, 14, 5 )				
		,( 1, 2, 4, 14, 15, 5 )				
		,( 1, 2, 4, 14, 16, 6 )				
		,( 1, 2, 4, 14, 17, 6 )				
		,( 1, 2, 4, 14, 18, 6 )				
						
		,( 1, 2, 4, 15, 1, 1 )				
		,( 1, 2, 4, 15, 2, 1 )				
		,( 1, 2, 4, 15, 3, 1 )				
		,( 1, 2, 4, 15, 4, 2 )				
		,( 1, 2, 4, 15, 5, 2 )				
		,( 1, 2, 4, 15, 6, 2 )				
		,( 1, 2, 4, 15, 7, 3 )				
		,( 1, 2, 4, 15, 8, 3 )				
		,( 1, 2, 4, 15, 9, 3 )				
		,( 1, 2, 4, 15, 10, 4 )				
		,( 1, 2, 4, 15, 11, 4 )				
		,( 1, 2, 4, 15, 12, 4 )				
		,( 1, 2, 4, 15, 13, 5 )				
		,( 1, 2, 4, 15, 14, 5 )				
		,( 1, 2, 4, 15, 15, 5 )				
		,( 1, 2, 4, 15, 16, 6 )				
		,( 1, 2, 4, 15, 17, 6 )				
		,( 1, 2, 4, 15, 18, 6 )				
						
		,( 1, 2, 4, 16, 1, 1 )				
		,( 1, 2, 4, 16, 2, 1 )				
		,( 1, 2, 4, 16, 3, 1 )				
		,( 1, 2, 4, 16, 4, 2 )				
		,( 1, 2, 4, 16, 5, 2 )				
		,( 1, 2, 4, 16, 6, 2 )				
		,( 1, 2, 4, 16, 7, 3 )				
		,( 1, 2, 4, 16, 8, 3 )				
		,( 1, 2, 4, 16, 9, 3 )				
		,( 1, 2, 4, 16, 10, 4 )				
		,( 1, 2, 4, 16, 11, 4 )				
		,( 1, 2, 4, 16, 12, 4 )				
		,( 1, 2, 4, 16, 13, 5 )				
		,( 1, 2, 4, 16, 14, 5 )				
		,( 1, 2, 4, 16, 15, 5 )				
		,( 1, 2, 4, 16, 16, 6 )				
		,( 1, 2, 4, 16, 17, 6 )				
		,( 1, 2, 4, 16, 18, 6 )				
						
		,( 1, 2, 5, 17, 1, 1 )				
		,( 1, 2, 5, 17, 2, 1 )				-- Year 2011, League: 2,Team: 5, Players: 17 - 20, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 2, 5, 17, 3, 1 )				
		,( 1, 2, 5, 17, 4, 2 )				
		,( 1, 2, 5, 17, 5, 2 )				
		,( 1, 2, 5, 17, 6, 2 )				
		,( 1, 2, 5, 17, 7, 3 )				
		,( 1, 2, 5, 17, 8, 3 )				
		,( 1, 2, 5, 17, 9, 3 )				
		,( 1, 2, 5, 17, 10, 4 )				
		,( 1, 2, 5, 17, 11, 4 )				
		,( 1, 2, 5, 17, 12, 4 )				
		,( 1, 2, 5, 17, 13, 5 )				
		,( 1, 2, 5, 17, 14, 5 )				
		,( 1, 2, 5, 17, 15, 5 )				
		,( 1, 2, 5, 17, 16, 6 )				
		,( 1, 2, 5, 17, 17, 6 )				
		,( 1, 2, 5, 17, 18, 6 )				
						
		,( 1, 2, 5, 18, 1, 1 )				
		,( 1, 2, 5, 18, 2, 1 )				
		,( 1, 2, 5, 18, 3, 1 )				
		,( 1, 2, 5, 18, 4, 2 )				
		,( 1, 2, 5, 18, 5, 2 )				
		,( 1, 2, 5, 18, 6, 2 )				
		,( 1, 2, 5, 18, 7, 3 )				
		,( 1, 2, 5, 18, 8, 3 )				
		,( 1, 2, 5, 18, 9, 3 )				
		,( 1, 2, 5, 18, 10, 4 )				
		,( 1, 2, 5, 18, 11, 4 )				
		,( 1, 2, 5, 18, 12, 4 )				
		,( 1, 2, 5, 18, 13, 5 )				
		,( 1, 2, 5, 18, 14, 5 )				
		,( 1, 2, 5, 18, 15, 5 )				
		,( 1, 2, 5, 18, 16, 6 )				
		,( 1, 2, 5, 18, 17, 6 )				
		,( 1, 2, 5, 18, 18, 6 )				
						
		,( 1, 2, 5, 19, 1, 1 )				
		,( 1, 2, 5, 19, 2, 1 )				
		,( 1, 2, 5, 19, 3, 1 )				
		,( 1, 2, 5, 19, 4, 2 )				
		,( 1, 2, 5, 19, 5, 2 )				
		,( 1, 2, 5, 19, 6, 2 )				
		,( 1, 2, 5, 19, 7, 3 )				
		,( 1, 2, 5, 19, 8, 3 )				
		,( 1, 2, 5, 19, 9, 3 )				
		,( 1, 2, 5, 19, 10, 4 )				
		,( 1, 2, 5, 19, 11, 4 )				
		,( 1, 2, 5, 19, 12, 4 )				
		,( 1, 2, 5, 19, 13, 5 )				
		,( 1, 2, 5, 19, 14, 5 )				
		,( 1, 2, 5, 19, 15, 5 )				
		,( 1, 2, 5, 19, 16, 6 )				
		,( 1, 2, 5, 19, 17, 6 )				
		,( 1, 2, 5, 19, 18, 6 )				
						
		,( 1, 2, 5, 20, 1, 1 )				
		,( 1, 2, 5, 20, 2, 1 )				
		,( 1, 2, 5, 20, 3, 1 )				
		,( 1, 2, 5, 20, 4, 2 )				
		,( 1, 2, 5, 20, 5, 2 )				
		,( 1, 2, 5, 20, 6, 2 )				
		,( 1, 2, 5, 20, 7, 3 )				
		,( 1, 2, 5, 20, 8, 3 )				
		,( 1, 2, 5, 20, 9, 3 )				
		,( 1, 2, 5, 20, 10, 4 )				
		,( 1, 2, 5, 20, 11, 4 )				
		,( 1, 2, 5, 20, 12, 4 )				
		,( 1, 2, 5, 20, 13, 5 )				
		,( 1, 2, 5, 20, 14, 5 )				
		,( 1, 2, 5, 20, 15, 5 )				
		,( 1, 2, 5, 20, 16, 6 )				
		,( 1, 2, 5, 20, 17, 6 )				
		,( 1, 2, 5, 20, 18, 6 )				
						
		,( 1, 2, 6, 21, 1, 1 )				
		,( 1, 2, 6, 21, 2, 1 )				-- Year 2011, League: 2,Team: 6, Players: 21 - 24, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 2, 6, 21, 3, 1 )				
		,( 1, 2, 6, 21, 4, 2 )				
		,( 1, 2, 6, 21, 5, 2 )				
		,( 1, 2, 6, 21, 6, 2 )				
		,( 1, 2, 6, 21, 7, 3 )				
		,( 1, 2, 6, 21, 8, 3 )				
		,( 1, 2, 6, 21, 9, 3 )				
		,( 1, 2, 6, 21, 10, 4 )				
		,( 1, 2, 6, 21, 11, 4 )				
		,( 1, 2, 6, 21, 12, 4 )				
		,( 1, 2, 6, 21, 13, 5 )				
		,( 1, 2, 6, 21, 14, 5 )				
		,( 1, 2, 6, 21, 15, 5 )				
		,( 1, 2, 6, 21, 16, 6 )				
		,( 1, 2, 6, 21, 17, 6 )				
		,( 1, 2, 6, 21, 18, 6 )				
						
		,( 1, 2, 6, 22, 1, 1 )				
		,( 1, 2, 6, 22, 2, 1 )				
		,( 1, 2, 6, 22, 3, 1 )				
		,( 1, 2, 6, 22, 4, 2 )				
		,( 1, 2, 6, 22, 5, 2 )				
		,( 1, 2, 6, 22, 6, 2 )				
		,( 1, 2, 6, 22, 7, 3 )				
		,( 1, 2, 6, 22, 8, 3 )				
		,( 1, 2, 6, 22, 9, 3 )				
		,( 1, 2, 6, 22, 10, 4 )				
		,( 1, 2, 6, 22, 11, 4 )				
		,( 1, 2, 6, 22, 12, 4 )				
		,( 1, 2, 6, 22, 13, 5 )				
		,( 1, 2, 6, 22, 14, 5 )				
		,( 1, 2, 6, 22, 15, 5 )				
		,( 1, 2, 6, 22, 16, 6 )				
		,( 1, 2, 6, 22, 17, 6 )				
		,( 1, 2, 6, 22, 18, 6 )				
						
		,( 1, 2, 6, 23, 1, 1 )				
		,( 1, 2, 6, 23, 2, 1 )				
		,( 1, 2, 6, 23, 3, 1 )				
		,( 1, 2, 6, 23, 4, 2 )				
		,( 1, 2, 6, 23, 5, 2 )				
		,( 1, 2, 6, 23, 6, 2 )				
		,( 1, 2, 6, 23, 7, 3 )				
		,( 1, 2, 6, 23, 8, 3 )				
		,( 1, 2, 6, 23, 9, 3 )				
		,( 1, 2, 6, 23, 10, 4 )				
		,( 1, 2, 6, 23, 11, 4 )				
		,( 1, 2, 6, 23, 12, 4 )				
		,( 1, 2, 6, 23, 13, 5 )				
		,( 1, 2, 6, 23, 14, 5 )				
		,( 1, 2, 6, 23, 15, 5 )				
		,( 1, 2, 6, 23, 16, 6 )				
		,( 1, 2, 6, 23, 17, 6 )				
		,( 1, 2, 6, 23, 18, 6 )				
						
		,( 1, 2, 6, 24, 1, 1 )				
		,( 1, 2, 6, 24, 2, 1 )				
		,( 1, 2, 6, 24, 3, 1 )				
		,( 1, 2, 6, 24, 4, 2 )				
		,( 1, 2, 6, 24, 5, 2 )				
		,( 1, 2, 6, 24, 6, 2 )				
		,( 1, 2, 6, 24, 7, 3 )				
		,( 1, 2, 6, 24, 8, 3 )				
		,( 1, 2, 6, 24, 9, 3 )				
		,( 1, 2, 6, 24, 10, 4 )				
		,( 1, 2, 6, 24, 11, 4 )				
		,( 1, 2, 6, 24, 12, 4 )				
		,( 1, 2, 6, 24, 13, 5 )				
		,( 1, 2, 6, 24, 14, 5 )				
		,( 1, 2, 6, 24, 15, 5 )				
		,( 1, 2, 6, 24, 16, 6 )				
		,( 1, 2, 6, 24, 17, 6 )				
		,( 1, 2, 6, 24, 18, 6 )				
						
INSERT INTO TPlayerGames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex )						
VALUES	 ( 1, 3, 7, 25, 1, 1 )					
		,( 1, 3, 7, 25, 2, 1 )				-- Year 2011, League: 3,Team: 7, Players: 25 - 28, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 3, 7, 25, 3, 1 )				
		,( 1, 3, 7, 25, 4, 2 )				
		,( 1, 3, 7, 25, 5, 2 )				
		,( 1, 3, 7, 25, 6, 2 )				
		,( 1, 3, 7, 25, 7, 3 )				
		,( 1, 3, 7, 25, 8, 3 )				
		,( 1, 3, 7, 25, 9, 3 )				
		,( 1, 3, 7, 25, 10, 4 )				
		,( 1, 3, 7, 25, 11, 4 )				
		,( 1, 3, 7, 25, 12, 4 )				
		,( 1, 3, 7, 25, 13, 5 )				
		,( 1, 3, 7, 25, 14, 5 )				
		,( 1, 3, 7, 25, 15, 5 )				
		,( 1, 3, 7, 25, 16, 6 )				
		,( 1, 3, 7, 25, 17, 6 )				
		,( 1, 3, 7, 25, 18, 6 )				
						
		,( 1, 3, 7, 26, 1, 1 )				
		,( 1, 3, 7, 26, 2, 1 )				
		,( 1, 3, 7, 26, 3, 1 )				
		,( 1, 3, 7, 26, 4, 2 )				
		,( 1, 3, 7, 26, 5, 2 )				
		,( 1, 3, 7, 26, 6, 2 )				
		,( 1, 3, 7, 26, 7, 3 )				
		,( 1, 3, 7, 26, 8, 3 )				
		,( 1, 3, 7, 26, 9, 3 )				
		,( 1, 3, 7, 26, 10, 4 )				
		,( 1, 3, 7, 26, 11, 4 )				
		,( 1, 3, 7, 26, 12, 4 )				
		,( 1, 3, 7, 26, 13, 5 )				
		,( 1, 3, 7, 26, 14, 5 )				
		,( 1, 3, 7, 26, 15, 5 )				
		,( 1, 3, 7, 26, 16, 6 )				
		,( 1, 3, 7, 26, 17, 6 )				
		,( 1, 3, 7, 26, 18, 6 )				
						
		,( 1, 3, 7, 27, 1, 1 )				
		,( 1, 3, 7, 27, 2, 1 )				
		,( 1, 3, 7, 27, 3, 1 )				
		,( 1, 3, 7, 27, 4, 2 )				
		,( 1, 3, 7, 27, 5, 2 )				
		,( 1, 3, 7, 27, 6, 2 )				
		,( 1, 3, 7, 27, 7, 3 )				
		,( 1, 3, 7, 27, 8, 3 )				
		,( 1, 3, 7, 27, 9, 3 )				
		,( 1, 3, 7, 27, 10, 4 )				
		,( 1, 3, 7, 27, 11, 4 )				
		,( 1, 3, 7, 27, 12, 4 )				
		,( 1, 3, 7, 27, 13, 5 )				
		,( 1, 3, 7, 27, 14, 5 )				
		,( 1, 3, 7, 27, 15, 5 )				
		,( 1, 3, 7, 27, 16, 6 )				
		,( 1, 3, 7, 27, 17, 6 )				
		,( 1, 3, 7, 27, 18, 6 )				
						
		,( 1, 3, 7, 28, 1, 1 )				
		,( 1, 3, 7, 28, 2, 1 )				
		,( 1, 3, 7, 28, 3, 1 )				
		,( 1, 3, 7, 28, 4, 2 )				
		,( 1, 3, 7, 28, 5, 2 )				
		,( 1, 3, 7, 28, 6, 2 )				
		,( 1, 3, 7, 28, 7, 3 )				
		,( 1, 3, 7, 28, 8, 3 )				
		,( 1, 3, 7, 28, 9, 3 )				
		,( 1, 3, 7, 28, 10, 4 )				
		,( 1, 3, 7, 28, 11, 4 )				
		,( 1, 3, 7, 28, 12, 4 )				
		,( 1, 3, 7, 28, 13, 5 )				
		,( 1, 3, 7, 28, 14, 5 )				
		,( 1, 3, 7, 28, 15, 5 )				
		,( 1, 3, 7, 28, 16, 6 )				
		,( 1, 3, 7, 28, 17, 6 )				
		,( 1, 3, 7, 28, 18, 6 )				
						
		,( 1, 3, 8, 29, 1, 1 )				
		,( 1, 3, 8, 29, 2, 1 )				-- Year 2011, League: 3,Team: 8, Players: 29 - 32, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 3, 8, 29, 3, 1 )				
		,( 1, 3, 8, 29, 4, 2 )				
		,( 1, 3, 8, 29, 5, 2 )				
		,( 1, 3, 8, 29, 6, 2 )				
		,( 1, 3, 8, 29, 7, 3 )				
		,( 1, 3, 8, 29, 8, 3 )				
		,( 1, 3, 8, 29, 9, 3 )				
		,( 1, 3, 8, 29, 10, 4 )				
		,( 1, 3, 8, 29, 11, 4 )				
		,( 1, 3, 8, 29, 12, 4 )				
		,( 1, 3, 8, 29, 13, 5 )				
		,( 1, 3, 8, 29, 14, 5 )				
		,( 1, 3, 8, 29, 15, 5 )				
		,( 1, 3, 8, 29, 16, 6 )				
		,( 1, 3, 8, 29, 17, 6 )				
		,( 1, 3, 8, 29, 18, 6 )				
						
		,( 1, 3, 8, 30, 1, 1 )				
		,( 1, 3, 8, 30, 2, 1 )				
		,( 1, 3, 8, 30, 3, 1 )				
		,( 1, 3, 8, 30, 4, 2 )				
		,( 1, 3, 8, 30, 5, 2 )				
		,( 1, 3, 8, 30, 6, 2 )				
		,( 1, 3, 8, 30, 7, 3 )				
		,( 1, 3, 8, 30, 8, 3 )				
		,( 1, 3, 8, 30, 9, 3 )				
		,( 1, 3, 8, 30, 10, 4 )				
		,( 1, 3, 8, 30, 11, 4 )				
		,( 1, 3, 8, 30, 12, 4 )				
		,( 1, 3, 8, 30, 13, 5 )				
		,( 1, 3, 8, 30, 14, 5 )				
		,( 1, 3, 8, 30, 15, 5 )				
		,( 1, 3, 8, 30, 16, 6 )				
		,( 1, 3, 8, 30, 17, 6 )				
		,( 1, 3, 8, 30, 18, 6 )				
						
		,( 1, 3, 8, 31, 1, 1 )				
		,( 1, 3, 8, 31, 2, 1 )				
		,( 1, 3, 8, 31, 3, 1 )				
		,( 1, 3, 8, 31, 4, 2 )				
		,( 1, 3, 8, 31, 5, 2 )				
		,( 1, 3, 8, 31, 6, 2 )				
		,( 1, 3, 8, 31, 7, 3 )				
		,( 1, 3, 8, 31, 8, 3 )				
		,( 1, 3, 8, 31, 9, 3 )				
		,( 1, 3, 8, 31, 10, 4 )				
		,( 1, 3, 8, 31, 11, 4 )				
		,( 1, 3, 8, 31, 12, 4 )				
		,( 1, 3, 8, 31, 13, 5 )				
		,( 1, 3, 8, 31, 14, 5 )				
		,( 1, 3, 8, 31, 15, 5 )				
		,( 1, 3, 8, 31, 16, 6 )				
		,( 1, 3, 8, 31, 17, 6 )				
		,( 1, 3, 8, 31, 18, 6 )				
						
		,( 1, 3, 8, 32, 1, 1 )				
		,( 1, 3, 8, 32, 2, 1 )				
		,( 1, 3, 8, 32, 3, 1 )				
		,( 1, 3, 8, 32, 4, 2 )				
		,( 1, 3, 8, 32, 5, 2 )				
		,( 1, 3, 8, 32, 6, 2 )				
		,( 1, 3, 8, 32, 7, 3 )				
		,( 1, 3, 8, 32, 8, 3 )				
		,( 1, 3, 8, 32, 9, 3 )				
		,( 1, 3, 8, 32, 10, 4 )				
		,( 1, 3, 8, 32, 11, 4 )				
		,( 1, 3, 8, 32, 12, 4 )				
		,( 1, 3, 8, 32, 13, 5 )				
		,( 1, 3, 8, 32, 14, 5 )				
		,( 1, 3, 8, 32, 15, 5 )				
		,( 1, 3, 8, 32, 16, 6 )				
		,( 1, 3, 8, 32, 17, 6 )				
		,( 1, 3, 8, 32, 18, 6 )				
						
		,( 1, 3, 9, 33, 1, 1 )				
		,( 1, 3, 9, 33, 2, 1 )				-- Year 2011, League: 3,Team: 9, Players: 33 - 36, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 3, 9, 33, 3, 1 )				
		,( 1, 3, 9, 33, 4, 2 )				
		,( 1, 3, 9, 33, 5, 2 )				
		,( 1, 3, 9, 33, 6, 2 )				
		,( 1, 3, 9, 33, 7, 3 )				
		,( 1, 3, 9, 33, 8, 3 )				
		,( 1, 3, 9, 33, 9, 3 )				
		,( 1, 3, 9, 33, 10, 4 )				
		,( 1, 3, 9, 33, 11, 4 )				
		,( 1, 3, 9, 33, 12, 4 )				
		,( 1, 3, 9, 33, 13, 5 )				
		,( 1, 3, 9, 33, 14, 5 )				
		,( 1, 3, 9, 33, 15, 5 )				
		,( 1, 3, 9, 33, 16, 6 )				
		,( 1, 3, 9, 33, 17, 6 )				
		,( 1, 3, 9, 33, 18, 6 )				
						
		,( 1, 3, 9, 34, 1, 1 )				
		,( 1, 3, 9, 34, 2, 1 )				
		,( 1, 3, 9, 34, 3, 1 )				
		,( 1, 3, 9, 34, 4, 2 )				
		,( 1, 3, 9, 34, 5, 2 )				
		,( 1, 3, 9, 34, 6, 2 )				
		,( 1, 3, 9, 34, 7, 3 )				
		,( 1, 3, 9, 34, 8, 3 )				
		,( 1, 3, 9, 34, 9, 3 )				
		,( 1, 3, 9, 34, 10, 4 )				
		,( 1, 3, 9, 34, 11, 4 )				
		,( 1, 3, 9, 34, 12, 4 )				
		,( 1, 3, 9, 34, 13, 5 )				
		,( 1, 3, 9, 34, 14, 5 )				
		,( 1, 3, 9, 34, 15, 5 )				
		,( 1, 3, 9, 34, 16, 6 )				
		,( 1, 3, 9, 34, 17, 6 )				
		,( 1, 3, 9, 34, 18, 6 )				
						
		,( 1, 3, 9, 35, 1, 1 )				
		,( 1, 3, 9, 35, 2, 1 )				
		,( 1, 3, 9, 35, 3, 1 )				
		,( 1, 3, 9, 35, 4, 2 )				
		,( 1, 3, 9, 35, 5, 2 )				
		,( 1, 3, 9, 35, 6, 2 )				
		,( 1, 3, 9, 35, 7, 3 )				
		,( 1, 3, 9, 35, 8, 3 )				
		,( 1, 3, 9, 35, 9, 3 )				
		,( 1, 3, 9, 35, 10, 4 )				
		,( 1, 3, 9, 35, 11, 4 )				
		,( 1, 3, 9, 35, 12, 4 )				
		,( 1, 3, 9, 35, 13, 5 )				
		,( 1, 3, 9, 35, 14, 5 )				
		,( 1, 3, 9, 35, 15, 5 )				
		,( 1, 3, 9, 35, 16, 6 )				
		,( 1, 3, 9, 35, 17, 6 )				
		,( 1, 3, 9, 35, 18, 6 )				
						
		,( 1, 3, 9, 36, 1, 1 )				
		,( 1, 3, 9, 36, 2, 1 )				
		,( 1, 3, 9, 36, 3, 1 )				
		,( 1, 3, 9, 36, 4, 2 )				
		,( 1, 3, 9, 36, 5, 2 )				
		,( 1, 3, 9, 36, 6, 2 )				
		,( 1, 3, 9, 36, 7, 3 )				
		,( 1, 3, 9, 36, 8, 3 )				
		,( 1, 3, 9, 36, 9, 3 )				
		,( 1, 3, 9, 36, 10, 4 )				
		,( 1, 3, 9, 36, 11, 4 )				
		,( 1, 3, 9, 36, 12, 4 )				
		,( 1, 3, 9, 36, 13, 5 )				
		,( 1, 3, 9, 36, 14, 5 )				
		,( 1, 3, 9, 36, 15, 5 )				
		,( 1, 3, 9, 36, 16, 6 )				
		,( 1, 3, 9, 36, 17, 6 )				
		,( 1, 3, 9, 36, 18, 6 )				
						
INSERT INTO TPlayerGames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex )						
VALUES	 ( 1, 4, 10, 1, 1, 1 )					
		,( 1, 4, 10, 1, 2, 1 )				-- Year 2011, League: 4,Team: 10, Players: 1 & 38 - 40, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 4, 10, 1, 3, 1 )				
		,( 1, 4, 10, 1, 4, 2 )				
		,( 1, 4, 10, 1, 5, 2 )				
		,( 1, 4, 10, 1, 6, 2 )				
		,( 1, 4, 10, 1, 7, 3 )				
		,( 1, 4, 10, 1, 8, 3 )				
		,( 1, 4, 10, 1, 9, 3 )				
		,( 1, 4, 10, 1, 10, 4 )				
		,( 1, 4, 10, 1, 11, 4 )				
		,( 1, 4, 10, 1, 12, 4 )				
		,( 1, 4, 10, 1, 13, 5 )				
		,( 1, 4, 10, 1, 14, 5 )				
		,( 1, 4, 10, 1, 15, 5 )				
		,( 1, 4, 10, 1, 16, 6 )				
		,( 1, 4, 10, 1, 17, 6 )				
		,( 1, 4, 10, 1, 18, 6 )				
						
		,( 1, 4, 10, 38, 1, 1 )				
		,( 1, 4, 10, 38, 2, 1 )				
		,( 1, 4, 10, 38, 3, 1 )				
		,( 1, 4, 10, 38, 4, 2 )				
		,( 1, 4, 10, 38, 5, 2 )				
		,( 1, 4, 10, 38, 6, 2 )				
		,( 1, 4, 10, 38, 7, 3 )				
		,( 1, 4, 10, 38, 8, 3 )				
		,( 1, 4, 10, 38, 9, 3 )				
		,( 1, 4, 10, 38, 10, 4 )				
		,( 1, 4, 10, 38, 11, 4 )				
		,( 1, 4, 10, 38, 12, 4 )				
		,( 1, 4, 10, 38, 13, 5 )				
		,( 1, 4, 10, 38, 14, 5 )				
		,( 1, 4, 10, 38, 15, 5 )				
		,( 1, 4, 10, 38, 16, 6 )				
		,( 1, 4, 10, 38, 17, 6 )				
		,( 1, 4, 10, 38, 18, 6 )				
						
		,( 1, 4, 10, 39, 1, 1 )				
		,( 1, 4, 10, 39, 2, 1 )				
		,( 1, 4, 10, 39, 3, 1 )				
		,( 1, 4, 10, 39, 4, 2 )				
		,( 1, 4, 10, 39, 5, 2 )				
		,( 1, 4, 10, 39, 6, 2 )				
		,( 1, 4, 10, 39, 7, 3 )				
		,( 1, 4, 10, 39, 8, 3 )				
		,( 1, 4, 10, 39, 9, 3 )				
		,( 1, 4, 10, 39, 10, 4 )				
		,( 1, 4, 10, 39, 11, 4 )				
		,( 1, 4, 10, 39, 12, 4 )				
		,( 1, 4, 10, 39, 13, 5 )				
		,( 1, 4, 10, 39, 14, 5 )				
		,( 1, 4, 10, 39, 15, 5 )				
		,( 1, 4, 10, 39, 16, 6 )				
		,( 1, 4, 10, 39, 17, 6 )				
		,( 1, 4, 10, 39, 18, 6 )				
						
		,( 1, 4, 10, 40, 1, 1 )				
		,( 1, 4, 10, 40, 2, 1 )				
		,( 1, 4, 10, 40, 3, 1 )				
		,( 1, 4, 10, 40, 4, 2 )				
		,( 1, 4, 10, 40, 5, 2 )				
		,( 1, 4, 10, 40, 6, 2 )				
		,( 1, 4, 10, 40, 7, 3 )				
		,( 1, 4, 10, 40, 8, 3 )				
		,( 1, 4, 10, 40, 9, 3 )				
		,( 1, 4, 10, 40, 10, 4 )				
		,( 1, 4, 10, 40, 11, 4 )				
		,( 1, 4, 10, 40, 12, 4 )				
		,( 1, 4, 10, 40, 13, 5 )				
		,( 1, 4, 10, 40, 14, 5 )				
		,( 1, 4, 10, 40, 15, 5 )				
		,( 1, 4, 10, 40, 16, 6 )				
		,( 1, 4, 10, 40, 17, 6 )				
		,( 1, 4, 10, 40, 18, 6 )				
						
		,( 1, 4, 11, 41, 1, 1 )				
		,( 1, 4, 11, 41, 2, 1 )				-- Year 2011, League: 4,Team: 11, Players: 41 - 44, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 4, 11, 41, 3, 1 )				
		,( 1, 4, 11, 41, 4, 2 )				
		,( 1, 4, 11, 41, 5, 2 )				
		,( 1, 4, 11, 41, 6, 2 )				
		,( 1, 4, 11, 41, 7, 3 )				
		,( 1, 4, 11, 41, 8, 3 )				
		,( 1, 4, 11, 41, 9, 3 )				
		,( 1, 4, 11, 41, 10, 4 )				
		,( 1, 4, 11, 41, 11, 4 )				
		,( 1, 4, 11, 41, 12, 4 )				
		,( 1, 4, 11, 41, 13, 5 )				
		,( 1, 4, 11, 41, 14, 5 )				
		,( 1, 4, 11, 41, 15, 5 )				
		,( 1, 4, 11, 41, 16, 6 )				
		,( 1, 4, 11, 41, 17, 6 )				
		,( 1, 4, 11, 41, 18, 6 )				
						
		,( 1, 4, 11, 42, 1, 1 )				
		,( 1, 4, 11, 42, 2, 1 )				
		,( 1, 4, 11, 42, 3, 1 )				
		,( 1, 4, 11, 42, 4, 2 )				
		,( 1, 4, 11, 42, 5, 2 )				
		,( 1, 4, 11, 42, 6, 2 )				
		,( 1, 4, 11, 42, 7, 3 )				
		,( 1, 4, 11, 42, 8, 3 )				
		,( 1, 4, 11, 42, 9, 3 )				
		,( 1, 4, 11, 42, 10, 4 )				
		,( 1, 4, 11, 42, 11, 4 )				
		,( 1, 4, 11, 42, 12, 4 )				
		,( 1, 4, 11, 42, 13, 5 )				
		,( 1, 4, 11, 42, 14, 5 )				
		,( 1, 4, 11, 42, 15, 5 )				
		,( 1, 4, 11, 42, 16, 6 )				
		,( 1, 4, 11, 42, 17, 6 )				
		,( 1, 4, 11, 42, 18, 6 )				
						
		,( 1, 4, 11, 43, 1, 1 )				
		,( 1, 4, 11, 43, 2, 1 )				
		,( 1, 4, 11, 43, 3, 1 )				
		,( 1, 4, 11, 43, 4, 2 )				
		,( 1, 4, 11, 43, 5, 2 )				
		,( 1, 4, 11, 43, 6, 2 )				
		,( 1, 4, 11, 43, 7, 3 )				
		,( 1, 4, 11, 43, 8, 3 )				
		,( 1, 4, 11, 43, 9, 3 )				
		,( 1, 4, 11, 43, 10, 4 )				
		,( 1, 4, 11, 43, 11, 4 )				
		,( 1, 4, 11, 43, 12, 4 )				
		,( 1, 4, 11, 43, 13, 5 )				
		,( 1, 4, 11, 43, 14, 5 )				
		,( 1, 4, 11, 43, 15, 5 )				
		,( 1, 4, 11, 43, 16, 6 )				
		,( 1, 4, 11, 43, 17, 6 )				
		,( 1, 4, 11, 43, 18, 6 )				
						
		,( 1, 4, 11, 44, 1, 1 )				
		,( 1, 4, 11, 44, 2, 1 )				
		,( 1, 4, 11, 44, 3, 1 )				
		,( 1, 4, 11, 44, 4, 2 )				
		,( 1, 4, 11, 44, 5, 2 )				
		,( 1, 4, 11, 44, 6, 2 )				
		,( 1, 4, 11, 44, 7, 3 )				
		,( 1, 4, 11, 44, 8, 3 )				
		,( 1, 4, 11, 44, 9, 3 )				
		,( 1, 4, 11, 44, 10, 4 )				
		,( 1, 4, 11, 44, 11, 4 )				
		,( 1, 4, 11, 44, 12, 4 )				
		,( 1, 4, 11, 44, 13, 5 )				
		,( 1, 4, 11, 44, 14, 5 )				
		,( 1, 4, 11, 44, 15, 5 )				
		,( 1, 4, 11, 44, 16, 6 )				
		,( 1, 4, 11, 44, 17, 6 )				
		,( 1, 4, 11, 44, 18, 6 )				
						
		,( 1, 4, 12, 45, 1, 1 )				
		,( 1, 4, 12, 45, 2, 1 )				-- Year 2011, League: 4,Team: 12, Players: 45 - 48, Games: 1 - 18, Weeks: 1 - 6
		,( 1, 4, 12, 45, 3, 1 )				
		,( 1, 4, 12, 45, 4, 2 )				
		,( 1, 4, 12, 45, 5, 2 )				
		,( 1, 4, 12, 45, 6, 2 )				
		,( 1, 4, 12, 45, 7, 3 )				
		,( 1, 4, 12, 45, 8, 3 )				
		,( 1, 4, 12, 45, 9, 3 )				
		,( 1, 4, 12, 45, 10, 4 )				
		,( 1, 4, 12, 45, 11, 4 )				
		,( 1, 4, 12, 45, 12, 4 )				
		,( 1, 4, 12, 45, 13, 5 )				
		,( 1, 4, 12, 45, 14, 5 )				
		,( 1, 4, 12, 45, 15, 5 )				
		,( 1, 4, 12, 45, 16, 6 )				
		,( 1, 4, 12, 45, 17, 6 )				
		,( 1, 4, 12, 45, 18, 6 )				
						
		,( 1, 4, 12, 46, 1, 1 )				
		,( 1, 4, 12, 46, 2, 1 )				
		,( 1, 4, 12, 46, 3, 1 )				
		,( 1, 4, 12, 46, 4, 2 )				
		,( 1, 4, 12, 46, 5, 2 )				
		,( 1, 4, 12, 46, 6, 2 )				
		,( 1, 4, 12, 46, 7, 3 )				
		,( 1, 4, 12, 46, 8, 3 )				
		,( 1, 4, 12, 46, 9, 3 )				
		,( 1, 4, 12, 46, 10, 4 )				
		,( 1, 4, 12, 46, 11, 4 )				
		,( 1, 4, 12, 46, 12, 4 )				
		,( 1, 4, 12, 46, 13, 5 )				
		,( 1, 4, 12, 46, 14, 5 )				
		,( 1, 4, 12, 46, 15, 5 )				
		,( 1, 4, 12, 46, 16, 6 )				
		,( 1, 4, 12, 46, 17, 6 )				
		,( 1, 4, 12, 46, 18, 6 )				
						
		,( 1, 4, 12, 47, 1, 1 )				
		,( 1, 4, 12, 47, 2, 1 )				
		,( 1, 4, 12, 47, 3, 1 )				
		,( 1, 4, 12, 47, 4, 2 )				
		,( 1, 4, 12, 47, 5, 2 )				
		,( 1, 4, 12, 47, 6, 2 )				
		,( 1, 4, 12, 47, 7, 3 )				
		,( 1, 4, 12, 47, 8, 3 )				
		,( 1, 4, 12, 47, 9, 3 )				
		,( 1, 4, 12, 47, 10, 4 )				
		,( 1, 4, 12, 47, 11, 4 )				
		,( 1, 4, 12, 47, 12, 4 )				
		,( 1, 4, 12, 47, 13, 5 )				
		,( 1, 4, 12, 47, 14, 5 )				
		,( 1, 4, 12, 47, 15, 5 )				
		,( 1, 4, 12, 47, 16, 6 )				
		,( 1, 4, 12, 47, 17, 6 )				
		,( 1, 4, 12, 47, 18, 6 )				
						
		,( 1, 4, 12, 48, 1, 1 )				
		,( 1, 4, 12, 48, 2, 1 )				
		,( 1, 4, 12, 48, 3, 1 )				
		,( 1, 4, 12, 48, 4, 2 )				
		,( 1, 4, 12, 48, 5, 2 )				
		,( 1, 4, 12, 48, 6, 2 )				
		,( 1, 4, 12, 48, 7, 3 )				
		,( 1, 4, 12, 48, 8, 3 )				
		,( 1, 4, 12, 48, 9, 3 )				
		,( 1, 4, 12, 48, 10, 4 )				
		,( 1, 4, 12, 48, 11, 4 )				
		,( 1, 4, 12, 48, 12, 4 )				
		,( 1, 4, 12, 48, 13, 5 )				
		,( 1, 4, 12, 48, 14, 5 )				
		,( 1, 4, 12, 48, 15, 5 )				
		,( 1, 4, 12, 48, 16, 6 )				
		,( 1, 4, 12, 48, 17, 6 )				
		,( 1, 4, 12, 48, 18, 6 )				
						
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 1, 1, 1, 1 )				
		,( 1, 1, 1, 1, 1, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 1, Games: 1, Week: 1
		,( 1, 1, 1, 1, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 1, 1, 1, 1, 4 )			
		,( 1, 1, 1, 1, 1, 1, 5 )			
		,( 1, 1, 1, 1, 1, 1, 6 )			
		,( 1, 1, 1, 1, 1, 1, 7 )			
		,( 1, 1, 1, 1, 1, 1, 8 )			
		,( 1, 1, 1, 1, 1, 1, 9 )			
		,( 1, 1, 1, 1, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 1, 2, 1, 1 )				
		,( 1, 1, 1, 1, 2, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game: 2, Week: 1
		,( 1, 1, 1, 1, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 1, 1, 2, 1, 4 )			
		,( 1, 1, 1, 1, 2, 1, 5 )			
		,( 1, 1, 1, 1, 2, 1, 6 )			
		,( 1, 1, 1, 1, 2, 1, 7 )			
		,( 1, 1, 1, 1, 2, 1, 8 )			
		,( 1, 1, 1, 1, 2, 1, 9 )			
		,( 1, 1, 1, 1, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 1, 3, 1, 1 )				
		,( 1, 1, 1, 1, 3, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game: 3, Week: 1
		,( 1, 1, 1, 1, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 1, 1, 3, 1, 4 )			
		,( 1, 1, 1, 1, 3, 1, 5 )			
		,( 1, 1, 1, 1, 3, 1, 6 )			
		,( 1, 1, 1, 1, 3, 1, 7 )			
		,( 1, 1, 1, 1, 3, 1, 8 )			
		,( 1, 1, 1, 1, 3, 1, 9 )			
		,( 1, 1, 1, 1, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 1, 4, 2, 1 )				
		,( 1, 1, 1, 1, 4, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game:4, Week: 2
		,( 1, 1, 1, 1, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 1, 1, 4, 2, 4 )			
		,( 1, 1, 1, 1, 4, 2, 5 )			
		,( 1, 1, 1, 1, 4, 2, 6 )			
		,( 1, 1, 1, 1, 4, 2, 7 )			
		,( 1, 1, 1, 1, 4, 2, 8 )			
		,( 1, 1, 1, 1, 4, 2, 9 )			
		,( 1, 1, 1, 1, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 1, 5, 2, 1 )				
		,( 1, 1, 1, 1, 5, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game:5, Week: 2
		,( 1, 1, 1, 1, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 1, 1, 5, 2, 4 )			
		,( 1, 1, 1, 1, 5, 2, 5 )			
		,( 1, 1, 1, 1, 5, 2, 6 )			
		,( 1, 1, 1, 1, 5, 2, 7 )			
		,( 1, 1, 1, 1, 5, 2, 8 )			
		,( 1, 1, 1, 1, 5, 2, 9 )			
		,( 1, 1, 1, 1, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 1, 6, 2, 1 )				
		,( 1, 1, 1, 1, 6, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game: 6, Week: 2
		,( 1, 1, 1, 1, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 1, 1, 6, 2, 4 )			
		,( 1, 1, 1, 1, 6, 2, 5 )			
		,( 1, 1, 1, 1, 6, 2, 6 )			
		,( 1, 1, 1, 1, 6, 2, 7 )			
		,( 1, 1, 1, 1, 6, 2, 8 )			
		,( 1, 1, 1, 1, 6, 2, 9 )			
		,( 1, 1, 1, 1, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 2, 1, 1, 1 )				
		,( 1, 1, 1, 2, 1, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 1, Week: 1
		,( 1, 1, 1, 2, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 1, 2, 1, 1, 4 )			
		,( 1, 1, 1, 2, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 1, 1, 2, 1, 1, 6 )			-- different player same everything else
		,( 1, 1, 1, 2, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 1, 1, 2, 1, 1, 8 )			
		,( 1, 1, 1, 2, 1, 1, 9 )			
		,( 1, 1, 1, 2, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 2, 2, 1, 1 )				
		,( 1, 1, 1, 2, 2, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 2, Week: 1
		,( 1, 1, 1, 2, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 1, 2, 2, 1, 4 )			
		,( 1, 1, 1, 2, 2, 1, 5 )			
		,( 1, 1, 1, 2, 2, 1, 6 )			
		,( 1, 1, 1, 2, 2, 1, 7 )			
		,( 1, 1, 1, 2, 2, 1, 8 )			
		,( 1, 1, 1, 2, 2, 1, 9 )			
		,( 1, 1, 1, 2, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 2, 3, 1, 1 )				
		,( 1, 1, 1, 2, 3, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 3, Week: 1
		,( 1, 1, 1, 2, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 1, 2, 3, 1, 4 )			
		,( 1, 1, 1, 2, 3, 1, 5 )			
		,( 1, 1, 1, 2, 3, 1, 6 )			
		,( 1, 1, 1, 2, 3, 1, 7 )			
		,( 1, 1, 1, 2, 3, 1, 8 )			
		,( 1, 1, 1, 2, 3, 1, 9 )			
		,( 1, 1, 1, 2, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 2, 4, 2, 1 )				
		,( 1, 1, 1, 2, 4, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game:4, Week: 2
		,( 1, 1, 1, 2, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 1, 2, 4, 2, 4 )			
		,( 1, 1, 1, 2, 4, 2, 5 )			
		,( 1, 1, 1, 2, 4, 2, 6 )			
		,( 1, 1, 1, 2, 4, 2, 7 )			
		,( 1, 1, 1, 2, 4, 2, 8 )			
		,( 1, 1, 1, 2, 4, 2, 9 )			
		,( 1, 1, 1, 2, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 2, 5, 2, 1 )				
		,( 1, 1, 1, 2, 5, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 5, Week: 2
		,( 1, 1, 1, 2, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 1, 2, 5, 2, 4 )			
		,( 1, 1, 1, 2, 5, 2, 5 )			
		,( 1, 1, 1, 2, 5, 2, 6 )			
		,( 1, 1, 1, 2, 5, 2, 7 )			
		,( 1, 1, 1, 2, 5, 2, 8 )			
		,( 1, 1, 1, 2, 5, 2, 9 )			
		,( 1, 1, 1, 2, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 2, 6, 2, 1 )				
		,( 1, 1, 1, 2, 6, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 6, Week: 2
		,( 1, 1, 1, 2, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 1, 2, 6, 2, 4 )			
		,( 1, 1, 1, 2, 6, 2, 5 )			
		,( 1, 1, 1, 2, 6, 2, 6 )			
		,( 1, 1, 1, 2, 6, 2, 7 )			
		,( 1, 1, 1, 2, 6, 2, 8 )			
		,( 1, 1, 1, 2, 6, 2, 9 )			
		,( 1, 1, 1, 2, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 3, 1, 1, 1 )				
		,( 1, 1, 1, 3, 1, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 1, Week: 1
		,( 1, 1, 1, 3, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 1, 3, 1, 1, 4 )			
		,( 1, 1, 1, 3, 1, 1, 5 )			
		,( 1, 1, 1, 3, 1, 1, 6 )			
		,( 1, 1, 1, 3, 1, 1, 7 )			
		,( 1, 1, 1, 3, 1, 1, 8 )			
		,( 1, 1, 1, 3, 1, 1, 9 )			
		,( 1, 1, 1, 3, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 3, 2, 1, 1 )				
		,( 1, 1, 1, 3, 2, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 2, Week: 1
		,( 1, 1, 1, 3, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 1, 3, 2, 1, 4 )			
		,( 1, 1, 1, 3, 2, 1, 5 )			
		,( 1, 1, 1, 3, 2, 1, 6 )			
		,( 1, 1, 1, 3, 2, 1, 7 )			
		,( 1, 1, 1, 3, 2, 1, 8 )			
		,( 1, 1, 1, 3, 2, 1, 9 )			
		,( 1, 1, 1, 3, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 3, 3, 1, 1 )				
		,( 1, 1, 1, 3, 3, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 3, Week: 1
		,( 1, 1, 1, 3, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 1, 3, 3, 1, 4 )			
		,( 1, 1, 1, 3, 3, 1, 5 )			
		,( 1, 1, 1, 3, 3, 1, 6 )			
		,( 1, 1, 1, 3, 3, 1, 7 )			
		,( 1, 1, 1, 3, 3, 1, 8 )			
		,( 1, 1, 1, 3, 3, 1, 9 )			
		,( 1, 1, 1, 3, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 3, 4, 2, 1 )				
		,( 1, 1, 1, 3, 4, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game:4, Week: 2
		,( 1, 1, 1, 3, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 1, 3, 4, 2, 4 )			
		,( 1, 1, 1, 3, 4, 2, 5 )			
		,( 1, 1, 1, 3, 4, 2, 6 )			
		,( 1, 1, 1, 3, 4, 2, 7 )			
		,( 1, 1, 1, 3, 4, 2, 8 )			
		,( 1, 1, 1, 3, 4, 2, 9 )			
		,( 1, 1, 1, 3, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 3, 5, 2, 1 )				
		,( 1, 1, 1, 3, 5, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 5, Week: 2
		,( 1, 1, 1, 3, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 1, 3, 5, 2, 4 )			
		,( 1, 1, 1, 3, 5, 2, 5 )			
		,( 1, 1, 1, 3, 5, 2, 6 )			
		,( 1, 1, 1, 3, 5, 2, 7 )			
		,( 1, 1, 1, 3, 5, 2, 8 )			
		,( 1, 1, 1, 3, 5, 2, 9 )			
		,( 1, 1, 1, 3, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 3, 6, 2, 1 )				
		,( 1, 1, 1, 3, 6, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 6, Week: 2
		,( 1, 1, 1, 3, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 1, 3, 6, 2, 4 )			
		,( 1, 1, 1, 3, 6, 2, 5 )			
		,( 1, 1, 1, 3, 6, 2, 6 )			
		,( 1, 1, 1, 3, 6, 2, 7 )			
		,( 1, 1, 1, 3, 6, 2, 8 )			
		,( 1, 1, 1, 3, 6, 2, 9 )			
		,( 1, 1, 1, 3, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 4, 1, 1, 1 )				
		,( 1, 1, 1, 4, 1, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 1, Week: 1
		,( 1, 1, 1, 4, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 1, 4, 1, 1, 4 )			
		,( 1, 1, 1, 4, 1, 1, 5 )			
		,( 1, 1, 1, 4, 1, 1, 6 )			
		,( 1, 1, 1, 4, 1, 1, 7 )			
		,( 1, 1, 1, 4, 1, 1, 8 )			
		,( 1, 1, 1, 4, 1, 1, 9 )			
		,( 1, 1, 1, 4, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 4, 2, 1, 1 )				
		,( 1, 1, 1, 4, 2, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 2, Week: 1
		,( 1, 1, 1, 4, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 1, 4, 2, 1, 4 )			
		,( 1, 1, 1, 4, 2, 1, 5 )			
		,( 1, 1, 1, 4, 2, 1, 6 )			
		,( 1, 1, 1, 4, 2, 1, 7 )			
		,( 1, 1, 1, 4, 2, 1, 8 )			
		,( 1, 1, 1, 4, 2, 1, 9 )			
		,( 1, 1, 1, 4, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 4, 3, 1, 1 )				
		,( 1, 1, 1, 4, 3, 1, 2 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 3, Week: 1
		,( 1, 1, 1, 4, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 1, 4, 3, 1, 4 )			
		,( 1, 1, 1, 4, 3, 1, 5 )			
		,( 1, 1, 1, 4, 3, 1, 6 )			
		,( 1, 1, 1, 4, 3, 1, 7 )			
		,( 1, 1, 1, 4, 3, 1, 8 )			
		,( 1, 1, 1, 4, 3, 1, 9 )			
		,( 1, 1, 1, 4, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 4, 4, 2, 1 )				
		,( 1, 1, 1, 4, 4, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game:4, Week: 2
		,( 1, 1, 1, 4, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 1, 4, 4, 2, 4 )			
		,( 1, 1, 1, 4, 4, 2, 5 )			
		,( 1, 1, 1, 4, 4, 2, 6 )			
		,( 1, 1, 1, 4, 4, 2, 7 )			
		,( 1, 1, 1, 4, 4, 2, 8 )			
		,( 1, 1, 1, 4, 4, 2, 9 )			
		,( 1, 1, 1, 4, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 4, 5, 2, 1 )				
		,( 1, 1, 1, 4, 5, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 5, Week: 2
		,( 1, 1, 1, 4, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 1, 4, 5, 2, 4 )			
		,( 1, 1, 1, 4, 5, 2, 5 )			
		,( 1, 1, 1, 4, 5, 2, 6 )			
		,( 1, 1, 1, 4, 5, 2, 7 )			
		,( 1, 1, 1, 4, 5, 2, 8 )			
		,( 1, 1, 1, 4, 5, 2, 9 )			
		,( 1, 1, 1, 4, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 1, 4, 6, 2, 1 )				
		,( 1, 1, 1, 4, 6, 2, 2 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 6, Week: 2
		,( 1, 1, 1, 4, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 1, 4, 6, 2, 4 )			
		,( 1, 1, 1, 4, 6, 2, 5 )			
		,( 1, 1, 1, 4, 6, 2, 6 )			
		,( 1, 1, 1, 4, 6, 2, 7 )			
		,( 1, 1, 1, 4, 6, 2, 8 )			
		,( 1, 1, 1, 4, 6, 2, 9 )			
		,( 1, 1, 1, 4, 6, 2, 10 )					
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 5, 1, 1, 1 )				
		,( 1, 1, 2, 5, 1, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 5, Games: 1, Week: 1
		,( 1, 1, 2, 5, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 2, 5, 1, 1, 4 )			
		,( 1, 1, 2, 5, 1, 1, 5 )			-- Same as #1 BUT
		,( 1, 1, 2, 5, 1, 1, 6 )			-- different team, different player
		,( 1, 1, 2, 5, 1, 1, 7 )			-- This will test to make sure our scoring works on the team level
		,( 1, 1, 2, 5, 1, 1, 8 )			
		,( 1, 1, 2, 5, 1, 1, 9 )			
		,( 1, 1, 2, 5, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 5, 2, 1, 1 )				
		,( 1, 1, 2, 5, 2, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game: 2, Week: 1
		,( 1, 1, 2, 5, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 2, 5, 2, 1, 4 )			
		,( 1, 1, 2, 5, 2, 1, 5 )			
		,( 1, 1, 2, 5, 2, 1, 6 )			
		,( 1, 1, 2, 5, 2, 1, 7 )			
		,( 1, 1, 2, 5, 2, 1, 8 )			
		,( 1, 1, 2, 5, 2, 1, 9 )			
		,( 1, 1, 2, 5, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 5, 3, 1, 1 )				
		,( 1, 1, 2, 5, 3, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game: 3, Week: 1
		,( 1, 1, 2, 5, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 2, 5, 3, 1, 4 )			
		,( 1, 1, 2, 5, 3, 1, 5 )			
		,( 1, 1, 2, 5, 3, 1, 6 )			
		,( 1, 1, 2, 5, 3, 1, 7 )			
		,( 1, 1, 2, 5, 3, 1, 8 )			
		,( 1, 1, 2, 5, 3, 1, 9 )			
		,( 1, 1, 2, 5, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 5, 4, 2, 1 )				
		,( 1, 1, 2, 5, 4, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game:4, Week: 2
		,( 1, 1, 2, 5, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 2, 5, 4, 2, 4 )			
		,( 1, 1, 2, 5, 4, 2, 5 )			
		,( 1, 1, 2, 5, 4, 2, 6 )			
		,( 1, 1, 2, 5, 4, 2, 7 )			
		,( 1, 1, 2, 5, 4, 2, 8 )			
		,( 1, 1, 2, 5, 4, 2, 9 )			
		,( 1, 1, 2, 5, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 5, 5, 2, 1 )				
		,( 1, 1, 2, 5, 5, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game:5, Week: 2
		,( 1, 1, 2, 5, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 2, 5, 5, 2, 4 )			
		,( 1, 1, 2, 5, 5, 2, 5 )			
		,( 1, 1, 2, 5, 5, 2, 6 )			
		,( 1, 1, 2, 5, 5, 2, 7 )			
		,( 1, 1, 2, 5, 5, 2, 8 )			
		,( 1, 1, 2, 5, 5, 2, 9 )			
		,( 1, 1, 2, 5, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 5, 6, 2, 1 )				
		,( 1, 1, 2, 5, 6, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game: 6, Week: 2
		,( 1, 1, 2, 5, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 2, 5, 6, 2, 4 )			
		,( 1, 1, 2, 5, 6, 2, 5 )			
		,( 1, 1, 2, 5, 6, 2, 6 )			
		,( 1, 1, 2, 5, 6, 2, 7 )			
		,( 1, 1, 2, 5, 6, 2, 8 )			
		,( 1, 1, 2, 5, 6, 2, 9 )			
		,( 1, 1, 2, 5, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 6, 1, 1, 1 )				
		,( 1, 1, 2, 6, 1, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 1, Week: 1
		,( 1, 1, 2, 6, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 2, 6, 1, 1, 4 )			
		,( 1, 1, 2, 6, 1, 1, 5 )			
		,( 1, 1, 2, 6, 1, 1, 6 )			
		,( 1, 1, 2, 6, 1, 1, 7 )			
		,( 1, 1, 2, 6, 1, 1, 8 )			
		,( 1, 1, 2, 6, 1, 1, 9 )			
		,( 1, 1, 2, 6, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 6, 2, 1, 1 )				
		,( 1, 1, 2, 6, 2, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 2, Week: 1
		,( 1, 1, 2, 6, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 2, 6, 2, 1, 4 )			
		,( 1, 1, 2, 6, 2, 1, 5 )			
		,( 1, 1, 2, 6, 2, 1, 6 )			
		,( 1, 1, 2, 6, 2, 1, 7 )			
		,( 1, 1, 2, 6, 2, 1, 8 )			
		,( 1, 1, 2, 6, 2, 1, 9 )			
		,( 1, 1, 2, 6, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 6, 3, 1, 1 )				
		,( 1, 1, 2, 6, 3, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 3, Week: 1
		,( 1, 1, 2, 6, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 2, 6, 3, 1, 4 )			
		,( 1, 1, 2, 6, 3, 1, 5 )			
		,( 1, 1, 2, 6, 3, 1, 6 )			
		,( 1, 1, 2, 6, 3, 1, 7 )			
		,( 1, 1, 2, 6, 3, 1, 8 )			
		,( 1, 1, 2, 6, 3, 1, 9 )			
		,( 1, 1, 2, 6, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 6, 4, 2, 1 )				
		,( 1, 1, 2, 6, 4, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game:4, Week: 2
		,( 1, 1, 2, 6, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 2, 6, 4, 2, 4 )			
		,( 1, 1, 2, 6, 4, 2, 5 )			
		,( 1, 1, 2, 6, 4, 2, 6 )			
		,( 1, 1, 2, 6, 4, 2, 7 )			
		,( 1, 1, 2, 6, 4, 2, 8 )			
		,( 1, 1, 2, 6, 4, 2, 9 )			
		,( 1, 1, 2, 6, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 6, 5, 2, 1 )				
		,( 1, 1, 2, 6, 5, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 5, Week: 2
		,( 1, 1, 2, 6, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 2, 6, 5, 2, 4 )			
		,( 1, 1, 2, 6, 5, 2, 5 )			
		,( 1, 1, 2, 6, 5, 2, 6 )			
		,( 1, 1, 2, 6, 5, 2, 7 )			
		,( 1, 1, 2, 6, 5, 2, 8 )			
		,( 1, 1, 2, 6, 5, 2, 9 )			
		,( 1, 1, 2, 6, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 6, 6, 2, 1 )				
		,( 1, 1, 2, 6, 6, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 6, Week: 2
		,( 1, 1, 2, 6, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 2, 6, 6, 2, 4 )			
		,( 1, 1, 2, 6, 6, 2, 5 )			
		,( 1, 1, 2, 6, 6, 2, 6 )			
		,( 1, 1, 2, 6, 6, 2, 7 )			
		,( 1, 1, 2, 6, 6, 2, 8 )			
		,( 1, 1, 2, 6, 6, 2, 9 )			
		,( 1, 1, 2, 6, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 7, 1, 1, 1 )				
		,( 1, 1, 2, 7, 1, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 1, Week: 1
		,( 1, 1, 2, 7, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 2, 7, 1, 1, 4 )			
		,( 1, 1, 2, 7, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 1, 2, 7, 1, 1, 6 )			-- different player same everything else
		,( 1, 1, 2, 7, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 1, 2, 7, 1, 1, 8 )			
		,( 1, 1, 2, 7, 1, 1, 9 )			
		,( 1, 1, 2, 7, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 7, 2, 1, 1 )				
		,( 1, 1, 2, 7, 2, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 2, Week: 1
		,( 1, 1, 2, 7, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 2, 7, 2, 1, 4 )			
		,( 1, 1, 2, 7, 2, 1, 5 )			
		,( 1, 1, 2, 7, 2, 1, 6 )			
		,( 1, 1, 2, 7, 2, 1, 7 )			
		,( 1, 1, 2, 7, 2, 1, 8 )			
		,( 1, 1, 2, 7, 2, 1, 9 )			
		,( 1, 1, 2, 7, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 7, 3, 1, 1 )				
		,( 1, 1, 2, 7, 3, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 3, Week: 1
		,( 1, 1, 2, 7, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 2, 7, 3, 1, 4 )			
		,( 1, 1, 2, 7, 3, 1, 5 )			
		,( 1, 1, 2, 7, 3, 1, 6 )			
		,( 1, 1, 2, 7, 3, 1, 7 )			
		,( 1, 1, 2, 7, 3, 1, 8 )			
		,( 1, 1, 2, 7, 3, 1, 9 )			
		,( 1, 1, 2, 7, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 7, 4, 2, 1 )				
		,( 1, 1, 2, 7, 4, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game:4, Week: 2
		,( 1, 1, 2, 7, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 2, 7, 4, 2, 4 )			
		,( 1, 1, 2, 7, 4, 2, 5 )			
		,( 1, 1, 2, 7, 4, 2, 6 )			
		,( 1, 1, 2, 7, 4, 2, 7 )			
		,( 1, 1, 2, 7, 4, 2, 8 )			
		,( 1, 1, 2, 7, 4, 2, 9 )			
		,( 1, 1, 2, 7, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 7, 5, 2, 1 )				
		,( 1, 1, 2, 7, 5, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 5, Week: 2
		,( 1, 1, 2, 7, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 2, 7, 5, 2, 4 )			
		,( 1, 1, 2, 7, 5, 2, 5 )			
		,( 1, 1, 2, 7, 5, 2, 6 )			
		,( 1, 1, 2, 7, 5, 2, 7 )			
		,( 1, 1, 2, 7, 5, 2, 8 )			
		,( 1, 1, 2, 7, 5, 2, 9 )			
		,( 1, 1, 2, 7, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 7, 6, 2, 1 )				
		,( 1, 1, 2, 7, 6, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 6, Week: 2
		,( 1, 1, 2, 7, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 2, 7, 6, 2, 4 )			
		,( 1, 1, 2, 7, 6, 2, 5 )			
		,( 1, 1, 2, 7, 6, 2, 6 )			
		,( 1, 1, 2, 7, 6, 2, 7 )			
		,( 1, 1, 2, 7, 6, 2, 8 )			
		,( 1, 1, 2, 7, 6, 2, 9 )			
		,( 1, 1, 2, 7, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 8, 1, 1, 1 )				
		,( 1, 1, 2, 8, 1, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 1, Week: 1
		,( 1, 1, 2, 8, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 2, 8, 1, 1, 4 )			
		,( 1, 1, 2, 8, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 1, 2, 8, 1, 1, 6 )			-- different player same everything else
		,( 1, 1, 2, 8, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 1, 2, 8, 1, 1, 8 )			
		,( 1, 1, 2, 8, 1, 1, 9 )			
		,( 1, 1, 2, 8, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 8, 2, 1, 1 )				
		,( 1, 1, 2, 8, 2, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 2, Week: 1
		,( 1, 1, 2, 8, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 2, 8, 2, 1, 4 )			
		,( 1, 1, 2, 8, 2, 1, 5 )			
		,( 1, 1, 2, 8, 2, 1, 6 )			
		,( 1, 1, 2, 8, 2, 1, 7 )			
		,( 1, 1, 2, 8, 2, 1, 8 )			
		,( 1, 1, 2, 8, 2, 1, 9 )			
		,( 1, 1, 2, 8, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 8, 3, 1, 1 )				
		,( 1, 1, 2, 8, 3, 1, 2 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 3, Week: 1
		,( 1, 1, 2, 8, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 2, 8, 3, 1, 4 )			
		,( 1, 1, 2, 8, 3, 1, 5 )			
		,( 1, 1, 2, 8, 3, 1, 6 )			
		,( 1, 1, 2, 8, 3, 1, 7 )			
		,( 1, 1, 2, 8, 3, 1, 8 )			
		,( 1, 1, 2, 8, 3, 1, 9 )			
		,( 1, 1, 2, 8, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 8, 4, 2, 1 )				
		,( 1, 1, 2, 8, 4, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game:4, Week: 2
		,( 1, 1, 2, 8, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 2, 8, 4, 2, 4 )			
		,( 1, 1, 2, 8, 4, 2, 5 )			
		,( 1, 1, 2, 8, 4, 2, 6 )			
		,( 1, 1, 2, 8, 4, 2, 7 )			
		,( 1, 1, 2, 8, 4, 2, 8 )			
		,( 1, 1, 2, 8, 4, 2, 9 )			
		,( 1, 1, 2, 8, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 8, 5, 2, 1 )				
		,( 1, 1, 2, 8, 5, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 5, Week: 2
		,( 1, 1, 2, 8, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 2, 8, 5, 2, 4 )			
		,( 1, 1, 2, 8, 5, 2, 5 )			
		,( 1, 1, 2, 8, 5, 2, 6 )			
		,( 1, 1, 2, 8, 5, 2, 7 )			
		,( 1, 1, 2, 8, 5, 2, 8 )			
		,( 1, 1, 2, 8, 5, 2, 9 )			
		,( 1, 1, 2, 8, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 2, 8, 6, 2, 1 )				
		,( 1, 1, 2, 8, 6, 2, 2 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 6, Week: 2
		,( 1, 1, 2, 8, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 2, 8, 6, 2, 4 )			
		,( 1, 1, 2, 8, 6, 2, 5 )			
		,( 1, 1, 2, 8, 6, 2, 6 )			
		,( 1, 1, 2, 8, 6, 2, 7 )			
		,( 1, 1, 2, 8, 6, 2, 8 )			
		,( 1, 1, 2, 8, 6, 2, 9 )			
		,( 1, 1, 2, 8, 6, 2, 10 )			
			
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 9, 1, 1, 1 )				
		,( 1, 1, 3, 9, 1, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 9, Games: 1, Week: 1
		,( 1, 1, 3, 9, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 3, 9, 1, 1, 4 )			
		,( 1, 1, 3, 9, 1, 1, 5 )			
		,( 1, 1, 3, 9, 1, 1, 6 )			
		,( 1, 1, 3, 9, 1, 1, 7 )			
		,( 1, 1, 3, 9, 1, 1, 8 )			
		,( 1, 1, 3, 9, 1, 1, 9 )			
		,( 1, 1, 3, 9, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 9, 2, 1, 1 )				
		,( 1, 1, 3, 9, 2, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game: 2, Week: 1
		,( 1, 1, 3, 9, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 3, 9, 2, 1, 4 )			
		,( 1, 1, 3, 9, 2, 1, 5 )			
		,( 1, 1, 3, 9, 2, 1, 6 )			
		,( 1, 1, 3, 9, 2, 1, 7 )			
		,( 1, 1, 3, 9, 2, 1, 8 )			
		,( 1, 1, 3, 9, 2, 1, 9 )			
		,( 1, 1, 3, 9, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 9, 3, 1, 1 )				
		,( 1, 1, 3, 9, 3, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game: 3, Week: 1
		,( 1, 1, 3, 9, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 3, 9, 3, 1, 4 )			
		,( 1, 1, 3, 9, 3, 1, 5 )			
		,( 1, 1, 3, 9, 3, 1, 6 )			
		,( 1, 1, 3, 9, 3, 1, 7 )			
		,( 1, 1, 3, 9, 3, 1, 8 )			
		,( 1, 1, 3, 9, 3, 1, 9 )			
		,( 1, 1, 3, 9, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 9, 4, 2, 1 )				
		,( 1, 1, 3, 9, 4, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game:4, Week: 2
		,( 1, 1, 3, 9, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 3, 9, 4, 2, 4 )			
		,( 1, 1, 3, 9, 4, 2, 5 )			
		,( 1, 1, 3, 9, 4, 2, 6 )			
		,( 1, 1, 3, 9, 4, 2, 7 )			
		,( 1, 1, 3, 9, 4, 2, 8 )			
		,( 1, 1, 3, 9, 4, 2, 9 )			
		,( 1, 1, 3, 9, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 9, 5, 2, 1 )				
		,( 1, 1, 3, 9, 5, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game:5, Week: 2
		,( 1, 1, 3, 9, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 3, 9, 5, 2, 4 )			
		,( 1, 1, 3, 9, 5, 2, 5 )			
		,( 1, 1, 3, 9, 5, 2, 6 )			
		,( 1, 1, 3, 9, 5, 2, 7 )			
		,( 1, 1, 3, 9, 5, 2, 8 )			
		,( 1, 1, 3, 9, 5, 2, 9 )			
		,( 1, 1, 3, 9, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 9, 6, 2, 1 )				
		,( 1, 1, 3, 9, 6, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game: 6, Week: 2
		,( 1, 1, 3, 9, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 3, 9, 6, 2, 4 )			
		,( 1, 1, 3, 9, 6, 2, 5 )			
		,( 1, 1, 3, 9, 6, 2, 6 )			
		,( 1, 1, 3, 9, 6, 2, 7 )			
		,( 1, 1, 3, 9, 6, 2, 8 )			
		,( 1, 1, 3, 9, 6, 2, 9 )			
		,( 1, 1, 3, 9, 6, 2, 10 )			
				
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 10, 1, 1, 1 )				
		,( 1, 1, 3, 10, 1, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 1, Week: 1
		,( 1, 1, 3, 10, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 3, 10, 1, 1, 4 )			
		,( 1, 1, 3, 10, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 1, 3, 10, 1, 1, 6 )			-- different player same everything else
		,( 1, 1, 3, 10, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 1, 3, 10, 1, 1, 8 )			
		,( 1, 1, 3, 10, 1, 1, 9 )			
		,( 1, 1, 3, 10, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 10, 2, 1, 1 )				
		,( 1, 1, 3, 10, 2, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 2, Week: 1
		,( 1, 1, 3, 10, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 3, 10, 2, 1, 4 )			
		,( 1, 1, 3, 10, 2, 1, 5 )			
		,( 1, 1, 3, 10, 2, 1, 6 )			
		,( 1, 1, 3, 10, 2, 1, 7 )			
		,( 1, 1, 3, 10, 2, 1, 8 )			
		,( 1, 1, 3, 10, 2, 1, 9 )			
		,( 1, 1, 3, 10, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 10, 3, 1, 1 )				
		,( 1, 1, 3, 10, 3, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 3, Week: 1
		,( 1, 1, 3, 10, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 3, 10, 3, 1, 4 )			
		,( 1, 1, 3, 10, 3, 1, 5 )			
		,( 1, 1, 3, 10, 3, 1, 6 )			
		,( 1, 1, 3, 10, 3, 1, 7 )			
		,( 1, 1, 3, 10, 3, 1, 8 )			
		,( 1, 1, 3, 10, 3, 1, 9 )			
		,( 1, 1, 3, 10, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 10, 4, 2, 1 )				
		,( 1, 1, 3, 10, 4, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game:4, Week: 2
		,( 1, 1, 3, 10, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 3, 10, 4, 2, 4 )			
		,( 1, 1, 3, 10, 4, 2, 5 )			
		,( 1, 1, 3, 10, 4, 2, 6 )			
		,( 1, 1, 3, 10, 4, 2, 7 )			
		,( 1, 1, 3, 10, 4, 2, 8 )			
		,( 1, 1, 3, 10, 4, 2, 9 )			
		,( 1, 1, 3, 10, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 10, 5, 2, 1 )				
		,( 1, 1, 3, 10, 5, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 5, Week: 2
		,( 1, 1, 3, 10, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 3, 10, 5, 2, 4 )			
		,( 1, 1, 3, 10, 5, 2, 5 )			
		,( 1, 1, 3, 10, 5, 2, 6 )			
		,( 1, 1, 3, 10, 5, 2, 7 )			
		,( 1, 1, 3, 10, 5, 2, 8 )			
		,( 1, 1, 3, 10, 5, 2, 9 )			
		,( 1, 1, 3, 10, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 10, 6, 2, 1 )				
		,( 1, 1, 3, 10, 6, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 6, Week: 2
		,( 1, 1, 3, 10, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 3, 10, 6, 2, 4 )			
		,( 1, 1, 3, 10, 6, 2, 5 )			
		,( 1, 1, 3, 10, 6, 2, 6 )			
		,( 1, 1, 3, 10, 6, 2, 7 )			
		,( 1, 1, 3, 10, 6, 2, 8 )			
		,( 1, 1, 3, 10, 6, 2, 9 )			
		,( 1, 1, 3, 10, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 11, 1, 1, 1 )				
		,( 1, 1, 3, 11, 1, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 1, Week: 1
		,( 1, 1, 3, 11, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 3, 11, 1, 1, 4 )			
		,( 1, 1, 3, 11, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 1, 3, 11, 1, 1, 6 )			-- different player same everything else
		,( 1, 1, 3, 11, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 1, 3, 11, 1, 1, 8 )			
		,( 1, 1, 3, 11, 1, 1, 9 )			
		,( 1, 1, 3, 11, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 11, 2, 1, 1 )				
		,( 1, 1, 3, 11, 2, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 2, Week: 1
		,( 1, 1, 3, 11, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 3, 11, 2, 1, 4 )			
		,( 1, 1, 3, 11, 2, 1, 5 )			
		,( 1, 1, 3, 11, 2, 1, 6 )			
		,( 1, 1, 3, 11, 2, 1, 7 )			
		,( 1, 1, 3, 11, 2, 1, 8 )			
		,( 1, 1, 3, 11, 2, 1, 9 )			
		,( 1, 1, 3, 11, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 11, 3, 1, 1 )				
		,( 1, 1, 3, 11, 3, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 3, Week: 1
		,( 1, 1, 3, 11, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 3, 11, 3, 1, 4 )			
		,( 1, 1, 3, 11, 3, 1, 5 )			
		,( 1, 1, 3, 11, 3, 1, 6 )			
		,( 1, 1, 3, 11, 3, 1, 7 )			
		,( 1, 1, 3, 11, 3, 1, 8 )			
		,( 1, 1, 3, 11, 3, 1, 9 )			
		,( 1, 1, 3, 11, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 11, 4, 2, 1 )				
		,( 1, 1, 3, 11, 4, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game:4, Week: 2
		,( 1, 1, 3, 11, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 3, 11, 4, 2, 4 )			
		,( 1, 1, 3, 11, 4, 2, 5 )			
		,( 1, 1, 3, 11, 4, 2, 6 )			
		,( 1, 1, 3, 11, 4, 2, 7 )			
		,( 1, 1, 3, 11, 4, 2, 8 )			
		,( 1, 1, 3, 11, 4, 2, 9 )			
		,( 1, 1, 3, 11, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 11, 5, 2, 1 )				
		,( 1, 1, 3, 11, 5, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 5, Week: 2
		,( 1, 1, 3, 11, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 3, 11, 5, 2, 4 )			
		,( 1, 1, 3, 11, 5, 2, 5 )			
		,( 1, 1, 3, 11, 5, 2, 6 )			
		,( 1, 1, 3, 11, 5, 2, 7 )			
		,( 1, 1, 3, 11, 5, 2, 8 )			
		,( 1, 1, 3, 11, 5, 2, 9 )			
		,( 1, 1, 3, 11, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 11, 6, 2, 1 )				
		,( 1, 1, 3, 11, 6, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 6, Week: 2
		,( 1, 1, 3, 11, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 3, 11, 6, 2, 4 )			
		,( 1, 1, 3, 11, 6, 2, 5 )			
		,( 1, 1, 3, 11, 6, 2, 6 )			
		,( 1, 1, 3, 11, 6, 2, 7 )			
		,( 1, 1, 3, 11, 6, 2, 8 )			
		,( 1, 1, 3, 11, 6, 2, 9 )			
		,( 1, 1, 3, 11, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 12, 1, 1, 1 )				
		,( 1, 1, 3, 12, 1, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 1, Week: 1
		,( 1, 1, 3, 12, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 1, 3, 12, 1, 1, 4 )			
		,( 1, 1, 3, 12, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 1, 3, 12, 1, 1, 6 )			-- different player same everything else
		,( 1, 1, 3, 12, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 1, 3, 12, 1, 1, 8 )			
		,( 1, 1, 3, 12, 1, 1, 9 )			
		,( 1, 1, 3, 12, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 12, 2, 1, 1 )				
		,( 1, 1, 3, 12, 2, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 2, Week: 1
		,( 1, 1, 3, 12, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 1, 3, 12, 2, 1, 4 )			
		,( 1, 1, 3, 12, 2, 1, 5 )			
		,( 1, 1, 3, 12, 2, 1, 6 )			
		,( 1, 1, 3, 12, 2, 1, 7 )			
		,( 1, 1, 3, 12, 2, 1, 8 )			
		,( 1, 1, 3, 12, 2, 1, 9 )			
		,( 1, 1, 3, 12, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 12, 3, 1, 1 )				
		,( 1, 1, 3, 12, 3, 1, 2 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 3, Week: 1
		,( 1, 1, 3, 12, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 1, 3, 12, 3, 1, 4 )			
		,( 1, 1, 3, 12, 3, 1, 5 )			
		,( 1, 1, 3, 12, 3, 1, 6 )			
		,( 1, 1, 3, 12, 3, 1, 7 )			
		,( 1, 1, 3, 12, 3, 1, 8 )			
		,( 1, 1, 3, 12, 3, 1, 9 )			
		,( 1, 1, 3, 12, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 12, 4, 2, 1 )				
		,( 1, 1, 3, 12, 4, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game:4, Week: 2
		,( 1, 1, 3, 12, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 1, 3, 12, 4, 2, 4 )			
		,( 1, 1, 3, 12, 4, 2, 5 )			
		,( 1, 1, 3, 12, 4, 2, 6 )			
		,( 1, 1, 3, 12, 4, 2, 7 )			
		,( 1, 1, 3, 12, 4, 2, 8 )			
		,( 1, 1, 3, 12, 4, 2, 9 )			
		,( 1, 1, 3, 12, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 12, 5, 2, 1 )				
		,( 1, 1, 3, 12, 5, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 5, Week: 2
		,( 1, 1, 3, 12, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 1, 3, 12, 5, 2, 4 )			
		,( 1, 1, 3, 12, 5, 2, 5 )			
		,( 1, 1, 3, 12, 5, 2, 6 )			
		,( 1, 1, 3, 12, 5, 2, 7 )			
		,( 1, 1, 3, 12, 5, 2, 8 )			
		,( 1, 1, 3, 12, 5, 2, 9 )			
		,( 1, 1, 3, 12, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 1, 3, 12, 6, 2, 1 )				
		,( 1, 1, 3, 12, 6, 2, 2 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 6, Week: 2
		,( 1, 1, 3, 12, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 1, 3, 12, 6, 2, 4 )			
		,( 1, 1, 3, 12, 6, 2, 5 )			
		,( 1, 1, 3, 12, 6, 2, 6 )			
		,( 1, 1, 3, 12, 6, 2, 7 )			
		,( 1, 1, 3, 12, 6, 2, 8 )			
		,( 1, 1, 3, 12, 6, 2, 9 )			
		,( 1, 1, 3, 12, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 13, 1, 1, 1 )				
		,( 1, 2, 4, 13, 1, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 13, Games: 1, Week: 1
		,( 1, 2, 4, 13, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 4, 13, 1, 1, 4 )			
		,( 1, 2, 4, 13, 1, 1, 5 )			-- Same as #1 BUT
		,( 1, 2, 4, 13, 1, 1, 6 )			-- different league, different player
		,( 1, 2, 4, 13, 1, 1, 7 )			-- This will test league scoring
		,( 1, 2, 4, 13, 1, 1, 8 )			
		,( 1, 2, 4, 13, 1, 1, 9 )			
		,( 1, 2, 4, 13, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 13, 2, 1, 1 )				
		,( 1, 2, 4, 13, 2, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game: 2, Week: 1
		,( 1, 2, 4, 13, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 4, 13, 2, 1, 4 )			
		,( 1, 2, 4, 13, 2, 1, 5 )			
		,( 1, 2, 4, 13, 2, 1, 6 )			
		,( 1, 2, 4, 13, 2, 1, 7 )			
		,( 1, 2, 4, 13, 2, 1, 8 )			
		,( 1, 2, 4, 13, 2, 1, 9 )			
		,( 1, 2, 4, 13, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 13, 3, 1, 1 )				
		,( 1, 2, 4, 13, 3, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game: 3, Week: 1
		,( 1, 2, 4, 13, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 4, 13, 3, 1, 4 )			
		,( 1, 2, 4, 13, 3, 1, 5 )			
		,( 1, 2, 4, 13, 3, 1, 6 )			
		,( 1, 2, 4, 13, 3, 1, 7 )			
		,( 1, 2, 4, 13, 3, 1, 8 )			
		,( 1, 2, 4, 13, 3, 1, 9 )			
		,( 1, 2, 4, 13, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 13, 4, 2, 1 )				
		,( 1, 2, 4, 13, 4, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game:4, Week: 2
		,( 1, 2, 4, 13, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 4, 13, 4, 2, 4 )			
		,( 1, 2, 4, 13, 4, 2, 5 )			
		,( 1, 2, 4, 13, 4, 2, 6 )			
		,( 1, 2, 4, 13, 4, 2, 7 )			
		,( 1, 2, 4, 13, 4, 2, 8 )			
		,( 1, 2, 4, 13, 4, 2, 9 )			
		,( 1, 2, 4, 13, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 13, 5, 2, 1 )				
		,( 1, 2, 4, 13, 5, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game:5, Week: 2
		,( 1, 2, 4, 13, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 4, 13, 5, 2, 4 )			
		,( 1, 2, 4, 13, 5, 2, 5 )			
		,( 1, 2, 4, 13, 5, 2, 6 )			
		,( 1, 2, 4, 13, 5, 2, 7 )			
		,( 1, 2, 4, 13, 5, 2, 8 )			
		,( 1, 2, 4, 13, 5, 2, 9 )			
		,( 1, 2, 4, 13, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 13, 6, 2, 1 )				
		,( 1, 2, 4, 13, 6, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game: 6, Week: 2
		,( 1, 2, 4, 13, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 4, 13, 6, 2, 4 )			
		,( 1, 2, 4, 13, 6, 2, 5 )			
		,( 1, 2, 4, 13, 6, 2, 6 )			
		,( 1, 2, 4, 13, 6, 2, 7 )			
		,( 1, 2, 4, 13, 6, 2, 8 )			
		,( 1, 2, 4, 13, 6, 2, 9 )			
		,( 1, 2, 4, 13, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 14, 1, 1, 1 )				
		,( 1, 2, 4, 14, 1, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 1, Week: 1
		,( 1, 2, 4, 14, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 4, 14, 1, 1, 4 )			
		,( 1, 2, 4, 14, 1, 1, 5 )			
		,( 1, 2, 4, 14, 1, 1, 6 )			
		,( 1, 2, 4, 14, 1, 1, 7 )			
		,( 1, 2, 4, 14, 1, 1, 8 )			
		,( 1, 2, 4, 14, 1, 1, 9 )			
		,( 1, 2, 4, 14, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 14, 2, 1, 1 )				
		,( 1, 2, 4, 14, 2, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 2, Week: 1
		,( 1, 2, 4, 14, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 4, 14, 2, 1, 4 )			
		,( 1, 2, 4, 14, 2, 1, 5 )			
		,( 1, 2, 4, 14, 2, 1, 6 )			
		,( 1, 2, 4, 14, 2, 1, 7 )			
		,( 1, 2, 4, 14, 2, 1, 8 )			
		,( 1, 2, 4, 14, 2, 1, 9 )			
		,( 1, 2, 4, 14, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 14, 3, 1, 1 )				
		,( 1, 2, 4, 14, 3, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 3, Week: 1
		,( 1, 2, 4, 14, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 4, 14, 3, 1, 4 )			
		,( 1, 2, 4, 14, 3, 1, 5 )			
		,( 1, 2, 4, 14, 3, 1, 6 )			
		,( 1, 2, 4, 14, 3, 1, 7 )			
		,( 1, 2, 4, 14, 3, 1, 8 )			
		,( 1, 2, 4, 14, 3, 1, 9 )			
		,( 1, 2, 4, 14, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 14, 4, 2, 1 )				
		,( 1, 2, 4, 14, 4, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game:4, Week: 2
		,( 1, 2, 4, 14, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 4, 14, 4, 2, 4 )			
		,( 1, 2, 4, 14, 4, 2, 5 )			
		,( 1, 2, 4, 14, 4, 2, 6 )			
		,( 1, 2, 4, 14, 4, 2, 7 )			
		,( 1, 2, 4, 14, 4, 2, 8 )			
		,( 1, 2, 4, 14, 4, 2, 9 )			
		,( 1, 2, 4, 14, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 14, 5, 2, 1 )				
		,( 1, 2, 4, 14, 5, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 5, Week: 2
		,( 1, 2, 4, 14, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 4, 14, 5, 2, 4 )			
		,( 1, 2, 4, 14, 5, 2, 5 )			
		,( 1, 2, 4, 14, 5, 2, 6 )			
		,( 1, 2, 4, 14, 5, 2, 7 )			
		,( 1, 2, 4, 14, 5, 2, 8 )			
		,( 1, 2, 4, 14, 5, 2, 9 )			
		,( 1, 2, 4, 14, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 14, 6, 2, 1 )				
		,( 1, 2, 4, 14, 6, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 6, Week: 2
		,( 1, 2, 4, 14, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 4, 14, 6, 2, 4 )			
		,( 1, 2, 4, 14, 6, 2, 5 )			
		,( 1, 2, 4, 14, 6, 2, 6 )			
		,( 1, 2, 4, 14, 6, 2, 7 )			
		,( 1, 2, 4, 14, 6, 2, 8 )			
		,( 1, 2, 4, 14, 6, 2, 9 )			
		,( 1, 2, 4, 14, 6, 2, 10 )			
			
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 15, 1, 1, 1 )				
		,( 1, 2, 4, 15, 1, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 1, Week: 1
		,( 1, 2, 4, 15, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 4, 15, 1, 1, 4 )			
		,( 1, 2, 4, 15, 1, 1, 5 )			
		,( 1, 2, 4, 15, 1, 1, 6 )			
		,( 1, 2, 4, 15, 1, 1, 7 )			
		,( 1, 2, 4, 15, 1, 1, 8 )			
		,( 1, 2, 4, 15, 1, 1, 9 )			
		,( 1, 2, 4, 15, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 15, 2, 1, 1 )				
		,( 1, 2, 4, 15, 2, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 2, Week: 1
		,( 1, 2, 4, 15, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 4, 15, 2, 1, 4 )			
		,( 1, 2, 4, 15, 2, 1, 5 )			
		,( 1, 2, 4, 15, 2, 1, 6 )			
		,( 1, 2, 4, 15, 2, 1, 7 )			
		,( 1, 2, 4, 15, 2, 1, 8 )			
		,( 1, 2, 4, 15, 2, 1, 9 )			
		,( 1, 2, 4, 15, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 15, 3, 1, 1 )				
		,( 1, 2, 4, 15, 3, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 3, Week: 1
		,( 1, 2, 4, 15, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 4, 15, 3, 1, 4 )			
		,( 1, 2, 4, 15, 3, 1, 5 )			
		,( 1, 2, 4, 15, 3, 1, 6 )			
		,( 1, 2, 4, 15, 3, 1, 7 )			
		,( 1, 2, 4, 15, 3, 1, 8 )			
		,( 1, 2, 4, 15, 3, 1, 9 )			
		,( 1, 2, 4, 15, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 15, 4, 2, 1 )				
		,( 1, 2, 4, 15, 4, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game:4, Week: 2
		,( 1, 2, 4, 15, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 4, 15, 4, 2, 4 )			
		,( 1, 2, 4, 15, 4, 2, 5 )			
		,( 1, 2, 4, 15, 4, 2, 6 )			
		,( 1, 2, 4, 15, 4, 2, 7 )			
		,( 1, 2, 4, 15, 4, 2, 8 )			
		,( 1, 2, 4, 15, 4, 2, 9 )			
		,( 1, 2, 4, 15, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 15, 5, 2, 1 )				
		,( 1, 2, 4, 15, 5, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 5, Week: 2
		,( 1, 2, 4, 15, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 4, 15, 5, 2, 4 )			
		,( 1, 2, 4, 15, 5, 2, 5 )			
		,( 1, 2, 4, 15, 5, 2, 6 )			
		,( 1, 2, 4, 15, 5, 2, 7 )			
		,( 1, 2, 4, 15, 5, 2, 8 )			
		,( 1, 2, 4, 15, 5, 2, 9 )			
		,( 1, 2, 4, 15, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 15, 6, 2, 1 )				
		,( 1, 2, 4, 15, 6, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 6, Week: 2
		,( 1, 2, 4, 15, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 4, 15, 6, 2, 4 )			
		,( 1, 2, 4, 15, 6, 2, 5 )			
		,( 1, 2, 4, 15, 6, 2, 6 )			
		,( 1, 2, 4, 15, 6, 2, 7 )			
		,( 1, 2, 4, 15, 6, 2, 8 )			
		,( 1, 2, 4, 15, 6, 2, 9 )			
		,( 1, 2, 4, 15, 6, 2, 10 )			
			
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 16, 1, 1, 1 )				
		,( 1, 2, 4, 16, 1, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 1, Week: 1
		,( 1, 2, 4, 16, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 4, 16, 1, 1, 4 )			
		,( 1, 2, 4, 16, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 2, 4, 16, 1, 1, 6 )			-- different player same everything else
		,( 1, 2, 4, 16, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 2, 4, 16, 1, 1, 8 )			
		,( 1, 2, 4, 16, 1, 1, 9 )			
		,( 1, 2, 4, 16, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 16, 2, 1, 1 )				
		,( 1, 2, 4, 16, 2, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 2, Week: 1
		,( 1, 2, 4, 16, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 4, 16, 2, 1, 4 )			
		,( 1, 2, 4, 16, 2, 1, 5 )			
		,( 1, 2, 4, 16, 2, 1, 6 )			
		,( 1, 2, 4, 16, 2, 1, 7 )			
		,( 1, 2, 4, 16, 2, 1, 8 )			
		,( 1, 2, 4, 16, 2, 1, 9 )			
		,( 1, 2, 4, 16, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 16, 3, 1, 1 )				
		,( 1, 2, 4, 16, 3, 1, 2 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 3, Week: 1
		,( 1, 2, 4, 16, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 4, 16, 3, 1, 4 )			
		,( 1, 2, 4, 16, 3, 1, 5 )			
		,( 1, 2, 4, 16, 3, 1, 6 )			
		,( 1, 2, 4, 16, 3, 1, 7 )			
		,( 1, 2, 4, 16, 3, 1, 8 )			
		,( 1, 2, 4, 16, 3, 1, 9 )			
		,( 1, 2, 4, 16, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 16, 4, 2, 1 )				
		,( 1, 2, 4, 16, 4, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game:4, Week: 2
		,( 1, 2, 4, 16, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 4, 16, 4, 2, 4 )			
		,( 1, 2, 4, 16, 4, 2, 5 )			
		,( 1, 2, 4, 16, 4, 2, 6 )			
		,( 1, 2, 4, 16, 4, 2, 7 )			
		,( 1, 2, 4, 16, 4, 2, 8 )			
		,( 1, 2, 4, 16, 4, 2, 9 )			
		,( 1, 2, 4, 16, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 16, 5, 2, 1 )				
		,( 1, 2, 4, 16, 5, 2, 2 )			-- Year 2011, League:2, Team: 4, Player: 16, Game: 5, Week: 2
		,( 1, 2, 4, 16, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 4, 16, 5, 2, 4 )			
		,( 1, 2, 4, 16, 5, 2, 5 )			
		,( 1, 2, 4, 16, 5, 2, 6 )			
		,( 1, 2, 4, 16, 5, 2, 7 )			
		,( 1, 2, 4, 16, 5, 2, 8 )			
		,( 1, 2, 4, 16, 5, 2, 9 )			
		,( 1, 2, 4, 16, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 4, 16, 6, 2, 1 )				
		,( 1, 2, 4, 16, 6, 2, 2 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 6, Week: 2
		,( 1, 2, 4, 16, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 4, 16, 6, 2, 4 )			
		,( 1, 2, 4, 16, 6, 2, 5 )			
		,( 1, 2, 4, 16, 6, 2, 6 )			
		,( 1, 2, 4, 16, 6, 2, 7 )			
		,( 1, 2, 4, 16, 6, 2, 8 )			
		,( 1, 2, 4, 16, 6, 2, 9 )			
		,( 1, 2, 4, 16, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 17, 1, 1, 1 )				
		,( 1, 2, 5, 17, 1, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 17, Games: 1, Week: 1
		,( 1, 2, 5, 17, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 5, 17, 1, 1, 4 )			
		,( 1, 2, 5, 17, 1, 1, 5 )			
		,( 1, 2, 5, 17, 1, 1, 6 )			
		,( 1, 2, 5, 17, 1, 1, 7 )			
		,( 1, 2, 5, 17, 1, 1, 8 )			
		,( 1, 2, 5, 17, 1, 1, 9 )			
		,( 1, 2, 5, 17, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 17, 2, 1, 1 )				
		,( 1, 2, 5, 17, 2, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game: 2, Week: 1
		,( 1, 2, 5, 17, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 5, 17, 2, 1, 4 )			
		,( 1, 2, 5, 17, 2, 1, 5 )			
		,( 1, 2, 5, 17, 2, 1, 6 )			
		,( 1, 2, 5, 17, 2, 1, 7 )			
		,( 1, 2, 5, 17, 2, 1, 8 )			
		,( 1, 2, 5, 17, 2, 1, 9 )			
		,( 1, 2, 5, 17, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 17, 3, 1, 1 )				
		,( 1, 2, 5, 17, 3, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game: 3, Week: 1
		,( 1, 2, 5, 17, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 5, 17, 3, 1, 4 )			
		,( 1, 2, 5, 17, 3, 1, 5 )			
		,( 1, 2, 5, 17, 3, 1, 6 )			
		,( 1, 2, 5, 17, 3, 1, 7 )			
		,( 1, 2, 5, 17, 3, 1, 8 )			
		,( 1, 2, 5, 17, 3, 1, 9 )			
		,( 1, 2, 5, 17, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 17, 4, 2, 1 )				
		,( 1, 2, 5, 17, 4, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game:4, Week: 2
		,( 1, 2, 5, 17, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 5, 17, 4, 2, 4 )			
		,( 1, 2, 5, 17, 4, 2, 5 )			
		,( 1, 2, 5, 17, 4, 2, 6 )			
		,( 1, 2, 5, 17, 4, 2, 7 )			
		,( 1, 2, 5, 17, 4, 2, 8 )			
		,( 1, 2, 5, 17, 4, 2, 9 )			
		,( 1, 2, 5, 17, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 17, 5, 2, 1 )				
		,( 1, 2, 5, 17, 5, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game:5, Week: 2
		,( 1, 2, 5, 17, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 5, 17, 5, 2, 4 )			
		,( 1, 2, 5, 17, 5, 2, 5 )			
		,( 1, 2, 5, 17, 5, 2, 6 )			
		,( 1, 2, 5, 17, 5, 2, 7 )			
		,( 1, 2, 5, 17, 5, 2, 8 )			
		,( 1, 2, 5, 17, 5, 2, 9 )			
		,( 1, 2, 5, 17, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 17, 6, 2, 1 )				
		,( 1, 2, 5, 17, 6, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game: 6, Week: 2
		,( 1, 2, 5, 17, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 5, 17, 6, 2, 4 )			
		,( 1, 2, 5, 17, 6, 2, 5 )			
		,( 1, 2, 5, 17, 6, 2, 6 )			
		,( 1, 2, 5, 17, 6, 2, 7 )			
		,( 1, 2, 5, 17, 6, 2, 8 )			
		,( 1, 2, 5, 17, 6, 2, 9 )			
		,( 1, 2, 5, 17, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 18, 1, 1, 1 )				
		,( 1, 2, 5, 18, 1, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 1, Week: 1
		,( 1, 2, 5, 18, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 5, 18, 1, 1, 4 )			
		,( 1, 2, 5, 18, 1, 1, 5 )			
		,( 1, 2, 5, 18, 1, 1, 6 )			
		,( 1, 2, 5, 18, 1, 1, 7 )			
		,( 1, 2, 5, 18, 1, 1, 8 )			
		,( 1, 2, 5, 18, 1, 1, 9 )			
		,( 1, 2, 5, 18, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 18, 2, 1, 1 )				
		,( 1, 2, 5, 18, 2, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 2, Week: 1
		,( 1, 2, 5, 18, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 5, 18, 2, 1, 4 )			
		,( 1, 2, 5, 18, 2, 1, 5 )			
		,( 1, 2, 5, 18, 2, 1, 6 )			
		,( 1, 2, 5, 18, 2, 1, 7 )			
		,( 1, 2, 5, 18, 2, 1, 8 )			
		,( 1, 2, 5, 18, 2, 1, 9 )			
		,( 1, 2, 5, 18, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 18, 3, 1, 1 )				
		,( 1, 2, 5, 18, 3, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 3, Week: 1
		,( 1, 2, 5, 18, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 5, 18, 3, 1, 4 )			
		,( 1, 2, 5, 18, 3, 1, 5 )			
		,( 1, 2, 5, 18, 3, 1, 6 )			
		,( 1, 2, 5, 18, 3, 1, 7 )			
		,( 1, 2, 5, 18, 3, 1, 8 )			
		,( 1, 2, 5, 18, 3, 1, 9 )			
		,( 1, 2, 5, 18, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 18, 4, 2, 1 )				
		,( 1, 2, 5, 18, 4, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game:4, Week: 2
		,( 1, 2, 5, 18, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 5, 18, 4, 2, 4 )			
		,( 1, 2, 5, 18, 4, 2, 5 )			
		,( 1, 2, 5, 18, 4, 2, 6 )			
		,( 1, 2, 5, 18, 4, 2, 7 )			
		,( 1, 2, 5, 18, 4, 2, 8 )			
		,( 1, 2, 5, 18, 4, 2, 9 )			
		,( 1, 2, 5, 18, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 18, 5, 2, 1 )				
		,( 1, 2, 5, 18, 5, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 5, Week: 2
		,( 1, 2, 5, 18, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 5, 18, 5, 2, 4 )			
		,( 1, 2, 5, 18, 5, 2, 5 )			
		,( 1, 2, 5, 18, 5, 2, 6 )			
		,( 1, 2, 5, 18, 5, 2, 7 )			
		,( 1, 2, 5, 18, 5, 2, 8 )			
		,( 1, 2, 5, 18, 5, 2, 9 )			
		,( 1, 2, 5, 18, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 18, 6, 2, 1 )				
		,( 1, 2, 5, 18, 6, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 6, Week: 2
		,( 1, 2, 5, 18, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 5, 18, 6, 2, 4 )			
		,( 1, 2, 5, 18, 6, 2, 5 )			
		,( 1, 2, 5, 18, 6, 2, 6 )			
		,( 1, 2, 5, 18, 6, 2, 7 )			
		,( 1, 2, 5, 18, 6, 2, 8 )			
		,( 1, 2, 5, 18, 6, 2, 9 )			
		,( 1, 2, 5, 18, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 19, 1, 1, 1 )				
		,( 1, 2, 5, 19, 1, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 1, Week: 1
		,( 1, 2, 5, 19, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 5, 19, 1, 1, 4 )			
		,( 1, 2, 5, 19, 1, 1, 5 )			
		,( 1, 2, 5, 19, 1, 1, 6 )			
		,( 1, 2, 5, 19, 1, 1, 7 )			
		,( 1, 2, 5, 19, 1, 1, 8 )			
		,( 1, 2, 5, 19, 1, 1, 9 )			
		,( 1, 2, 5, 19, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 19, 2, 1, 1 )				
		,( 1, 2, 5, 19, 2, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 2, Week: 1
		,( 1, 2, 5, 19, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 5, 19, 2, 1, 4 )			
		,( 1, 2, 5, 19, 2, 1, 5 )			
		,( 1, 2, 5, 19, 2, 1, 6 )			
		,( 1, 2, 5, 19, 2, 1, 7 )			
		,( 1, 2, 5, 19, 2, 1, 8 )			
		,( 1, 2, 5, 19, 2, 1, 9 )			
		,( 1, 2, 5, 19, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 19, 3, 1, 1 )				
		,( 1, 2, 5, 19, 3, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 3, Week: 1
		,( 1, 2, 5, 19, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 5, 19, 3, 1, 4 )			
		,( 1, 2, 5, 19, 3, 1, 5 )			
		,( 1, 2, 5, 19, 3, 1, 6 )			
		,( 1, 2, 5, 19, 3, 1, 7 )			
		,( 1, 2, 5, 19, 3, 1, 8 )			
		,( 1, 2, 5, 19, 3, 1, 9 )			
		,( 1, 2, 5, 19, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 19, 4, 2, 1 )				
		,( 1, 2, 5, 19, 4, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game:4, Week: 2
		,( 1, 2, 5, 19, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 5, 19, 4, 2, 4 )			
		,( 1, 2, 5, 19, 4, 2, 5 )			
		,( 1, 2, 5, 19, 4, 2, 6 )			
		,( 1, 2, 5, 19, 4, 2, 7 )			
		,( 1, 2, 5, 19, 4, 2, 8 )			
		,( 1, 2, 5, 19, 4, 2, 9 )			
		,( 1, 2, 5, 19, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 19, 5, 2, 1 )				
		,( 1, 2, 5, 19, 5, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 5, Week: 2
		,( 1, 2, 5, 19, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 5, 19, 5, 2, 4 )			
		,( 1, 2, 5, 19, 5, 2, 5 )			
		,( 1, 2, 5, 19, 5, 2, 6 )			
		,( 1, 2, 5, 19, 5, 2, 7 )			
		,( 1, 2, 5, 19, 5, 2, 8 )			
		,( 1, 2, 5, 19, 5, 2, 9 )			
		,( 1, 2, 5, 19, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 19, 6, 2, 1 )				
		,( 1, 2, 5, 19, 6, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 6, Week: 2
		,( 1, 2, 5, 19, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 5, 19, 6, 2, 4 )			
		,( 1, 2, 5, 19, 6, 2, 5 )			
		,( 1, 2, 5, 19, 6, 2, 6 )			
		,( 1, 2, 5, 19, 6, 2, 7 )			
		,( 1, 2, 5, 19, 6, 2, 8 )			
		,( 1, 2, 5, 19, 6, 2, 9 )			
		,( 1, 2, 5, 19, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 20, 1, 1, 1 )				
		,( 1, 2, 5, 20, 1, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 1, Week: 1
		,( 1, 2, 5, 20, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 5, 20, 1, 1, 4 )			
		,( 1, 2, 5, 20, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 2, 5, 20, 1, 1, 6 )			-- different player same everything else
		,( 1, 2, 5, 20, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 2, 5, 20, 1, 1, 8 )			
		,( 1, 2, 5, 20, 1, 1, 9 )			
		,( 1, 2, 5, 20, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 20, 2, 1, 1 )				
		,( 1, 2, 5, 20, 2, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 2, Week: 1
		,( 1, 2, 5, 20, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 5, 20, 2, 1, 4 )			
		,( 1, 2, 5, 20, 2, 1, 5 )			
		,( 1, 2, 5, 20, 2, 1, 6 )			
		,( 1, 2, 5, 20, 2, 1, 7 )			
		,( 1, 2, 5, 20, 2, 1, 8 )			
		,( 1, 2, 5, 20, 2, 1, 9 )			
		,( 1, 2, 5, 20, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 20, 3, 1, 1 )				
		,( 1, 2, 5, 20, 3, 1, 2 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 3, Week: 1
		,( 1, 2, 5, 20, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 5, 20, 3, 1, 4 )			
		,( 1, 2, 5, 20, 3, 1, 5 )			
		,( 1, 2, 5, 20, 3, 1, 6 )			
		,( 1, 2, 5, 20, 3, 1, 7 )			
		,( 1, 2, 5, 20, 3, 1, 8 )			
		,( 1, 2, 5, 20, 3, 1, 9 )			
		,( 1, 2, 5, 20, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 20, 4, 2, 1 )				
		,( 1, 2, 5, 20, 4, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 4, Week: 2
		,( 1, 2, 5, 20, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 5, 20, 4, 2, 4 )			
		,( 1, 2, 5, 20, 4, 2, 5 )			
		,( 1, 2, 5, 20, 4, 2, 6 )			
		,( 1, 2, 5, 20, 4, 2, 7 )			
		,( 1, 2, 5, 20, 4, 2, 8 )			
		,( 1, 2, 5, 20, 4, 2, 9 )			
		,( 1, 2, 5, 20, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 20, 5, 2, 1 )				
		,( 1, 2, 5, 20, 5, 2, 2 )			-- Year 2011, League:2, Team: 5, Player: 20, Game: 5, Week: 2
		,( 1, 2, 5, 20, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 5, 20, 5, 2, 4 )			
		,( 1, 2, 5, 20, 5, 2, 5 )			
		,( 1, 2, 5, 20, 5, 2, 6 )			
		,( 1, 2, 5, 20, 5, 2, 7 )			
		,( 1, 2, 5, 20, 5, 2, 8 )			
		,( 1, 2, 5, 20, 5, 2, 9 )			
		,( 1, 2, 5, 20, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 5, 20, 6, 2, 1 )				
		,( 1, 2, 5, 20, 6, 2, 2 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 6, Week: 2
		,( 1, 2, 5, 20, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 5, 20, 6, 2, 4 )			
		,( 1, 2, 5, 20, 6, 2, 5 )			
		,( 1, 2, 5, 20, 6, 2, 6 )			
		,( 1, 2, 5, 20, 6, 2, 7 )			
		,( 1, 2, 5, 20, 6, 2, 8 )			
		,( 1, 2, 5, 20, 6, 2, 9 )			
		,( 1, 2, 5, 20, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 21, 1, 1, 1 )				
		,( 1, 2, 6, 21, 1, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 1, Week: 1
		,( 1, 2, 6, 21, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 6, 21, 1, 1, 4 )			
		,( 1, 2, 6, 21, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 2, 6, 21, 1, 1, 6 )			-- different player same everything else
		,( 1, 2, 6, 21, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 2, 6, 21, 1, 1, 8 )			
		,( 1, 2, 6, 21, 1, 1, 9 )			
		,( 1, 2, 6, 21, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 21, 2, 1, 1 )				
		,( 1, 2, 6, 21, 2, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 2, Week: 1
		,( 1, 2, 6, 21, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 6, 21, 2, 1, 4 )			
		,( 1, 2, 6, 21, 2, 1, 5 )			
		,( 1, 2, 6, 21, 2, 1, 6 )			
		,( 1, 2, 6, 21, 2, 1, 7 )			
		,( 1, 2, 6, 21, 2, 1, 8 )			
		,( 1, 2, 6, 21, 2, 1, 9 )			
		,( 1, 2, 6, 21, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 21, 3, 1, 1 )				
		,( 1, 2, 6, 21, 3, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 3, Week: 1
		,( 1, 2, 6, 21, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 6, 21, 3, 1, 4 )			
		,( 1, 2, 6, 21, 3, 1, 5 )			
		,( 1, 2, 6, 21, 3, 1, 6 )			
		,( 1, 2, 6, 21, 3, 1, 7 )			
		,( 1, 2, 6, 21, 3, 1, 8 )			
		,( 1, 2, 6, 21, 3, 1, 9 )			
		,( 1, 2, 6, 21, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 21, 4, 2, 1 )				
		,( 1, 2, 6, 21, 4, 2, 2 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 4, Week: 2
		,( 1, 2, 6, 21, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 6, 21, 4, 2, 4 )			
		,( 1, 2, 6, 21, 4, 2, 5 )			
		,( 1, 2, 6, 21, 4, 2, 6 )			
		,( 1, 2, 6, 21, 4, 2, 7 )			
		,( 1, 2, 6, 21, 4, 2, 8 )			
		,( 1, 2, 6, 21, 4, 2, 9 )			
		,( 1, 2, 6, 21, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 21, 5, 2, 1 )				
		,( 1, 2, 6, 21, 5, 2, 2 )			-- Year 2011, League:2, Team: 6, Player: 21, Game: 5, Week: 2
		,( 1, 2, 6, 21, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 6, 21, 5, 2, 4 )			
		,( 1, 2, 6, 21, 5, 2, 5 )			
		,( 1, 2, 6, 21, 5, 2, 6 )			
		,( 1, 2, 6, 21, 5, 2, 7 )			
		,( 1, 2, 6, 21, 5, 2, 8 )			
		,( 1, 2, 6, 21, 5, 2, 9 )			
		,( 1, 2, 6, 21, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 21, 6, 2, 1 )				
		,( 1, 2, 6, 21, 6, 2, 2 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 6, Week: 2
		,( 1, 2, 6, 21, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 6, 21, 6, 2, 4 )			
		,( 1, 2, 6, 21, 6, 2, 5 )			
		,( 1, 2, 6, 21, 6, 2, 6 )			
		,( 1, 2, 6, 21, 6, 2, 7 )			
		,( 1, 2, 6, 21, 6, 2, 8 )			
		,( 1, 2, 6, 21, 6, 2, 9 )			
		,( 1, 2, 6, 21, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 22, 1, 1, 1 )				
		,( 1, 2, 6, 22, 1, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 1, Week: 1
		,( 1, 2, 6, 22, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 6, 22, 1, 1, 4 )			
		,( 1, 2, 6, 22, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 2, 6, 22, 1, 1, 6 )			-- different player same everything else
		,( 1, 2, 6, 22, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 2, 6, 22, 1, 1, 8 )			
		,( 1, 2, 6, 22, 1, 1, 9 )			
		,( 1, 2, 6, 22, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 22, 2, 1, 1 )				
		,( 1, 2, 6, 22, 2, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 2, Week: 1
		,( 1, 2, 6, 22, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 6, 22, 2, 1, 4 )			
		,( 1, 2, 6, 22, 2, 1, 5 )			
		,( 1, 2, 6, 22, 2, 1, 6 )			
		,( 1, 2, 6, 22, 2, 1, 7 )			
		,( 1, 2, 6, 22, 2, 1, 8 )			
		,( 1, 2, 6, 22, 2, 1, 9 )			
		,( 1, 2, 6, 22, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 22, 3, 1, 1 )				
		,( 1, 2, 6, 22, 3, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 3, Week: 1
		,( 1, 2, 6, 22, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 6, 22, 3, 1, 4 )			
		,( 1, 2, 6, 22, 3, 1, 5 )			
		,( 1, 2, 6, 22, 3, 1, 6 )			
		,( 1, 2, 6, 22, 3, 1, 7 )			
		,( 1, 2, 6, 22, 3, 1, 8 )			
		,( 1, 2, 6, 22, 3, 1, 9 )			
		,( 1, 2, 6, 22, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 22, 4, 2, 1 )				
		,( 1, 2, 6, 22, 4, 2, 2 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 4, Week: 2
		,( 1, 2, 6, 22, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 6, 22, 4, 2, 4 )			
		,( 1, 2, 6, 22, 4, 2, 5 )			
		,( 1, 2, 6, 22, 4, 2, 6 )			
		,( 1, 2, 6, 22, 4, 2, 7 )			
		,( 1, 2, 6, 22, 4, 2, 8 )			
		,( 1, 2, 6, 22, 4, 2, 9 )			
		,( 1, 2, 6, 22, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 22, 5, 2, 1 )				
		,( 1, 2, 6, 22, 5, 2, 2 )			-- Year 2011, League:2, Team: 6, Player: 22, Game: 5, Week: 2
		,( 1, 2, 6, 22, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 6, 22, 5, 2, 4 )			
		,( 1, 2, 6, 22, 5, 2, 5 )			
		,( 1, 2, 6, 22, 5, 2, 6 )			
		,( 1, 2, 6, 22, 5, 2, 7 )			
		,( 1, 2, 6, 22, 5, 2, 8 )			
		,( 1, 2, 6, 22, 5, 2, 9 )			
		,( 1, 2, 6, 22, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 22, 6, 2, 1 )				
		,( 1, 2, 6, 22, 6, 2, 2 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 6, Week: 2
		,( 1, 2, 6, 22, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 6, 22, 6, 2, 4 )			
		,( 1, 2, 6, 22, 6, 2, 5 )			
		,( 1, 2, 6, 22, 6, 2, 6 )			
		,( 1, 2, 6, 22, 6, 2, 7 )			
		,( 1, 2, 6, 22, 6, 2, 8 )			
		,( 1, 2, 6, 22, 6, 2, 9 )			
		,( 1, 2, 6, 22, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 23, 1, 1, 1 )				
		,( 1, 2, 6, 23, 1, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 1, Week: 1
		,( 1, 2, 6, 23, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 6, 23, 1, 1, 4 )			
		,( 1, 2, 6, 23, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 2, 6, 23, 1, 1, 6 )			-- different player same everything else
		,( 1, 2, 6, 23, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 2, 6, 23, 1, 1, 8 )			
		,( 1, 2, 6, 23, 1, 1, 9 )			
		,( 1, 2, 6, 23, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 23, 2, 1, 1 )				
		,( 1, 2, 6, 23, 2, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 2, Week: 1
		,( 1, 2, 6, 23, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 6, 23, 2, 1, 4 )			
		,( 1, 2, 6, 23, 2, 1, 5 )			
		,( 1, 2, 6, 23, 2, 1, 6 )			
		,( 1, 2, 6, 23, 2, 1, 7 )			
		,( 1, 2, 6, 23, 2, 1, 8 )			
		,( 1, 2, 6, 23, 2, 1, 9 )			
		,( 1, 2, 6, 23, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 23, 3, 1, 1 )				
		,( 1, 2, 6, 23, 3, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 3, Week: 1
		,( 1, 2, 6, 23, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 6, 23, 3, 1, 4 )			
		,( 1, 2, 6, 23, 3, 1, 5 )			
		,( 1, 2, 6, 23, 3, 1, 6 )			
		,( 1, 2, 6, 23, 3, 1, 7 )			
		,( 1, 2, 6, 23, 3, 1, 8 )			
		,( 1, 2, 6, 23, 3, 1, 9 )			
		,( 1, 2, 6, 23, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 23, 4, 2, 1 )				
		,( 1, 2, 6, 23, 4, 2, 2 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 4, Week: 2
		,( 1, 2, 6, 23, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 6, 23, 4, 2, 4 )			
		,( 1, 2, 6, 23, 4, 2, 5 )			
		,( 1, 2, 6, 23, 4, 2, 6 )			
		,( 1, 2, 6, 23, 4, 2, 7 )			
		,( 1, 2, 6, 23, 4, 2, 8 )			
		,( 1, 2, 6, 23, 4, 2, 9 )			
		,( 1, 2, 6, 23, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 23, 5, 2, 1 )				
		,( 1, 2, 6, 23, 5, 2, 2 )			-- Year 2011, League:2, Team: 6, Player: 23, Game: 5, Week: 2
		,( 1, 2, 6, 23, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 6, 23, 5, 2, 4 )			
		,( 1, 2, 6, 23, 5, 2, 5 )			
		,( 1, 2, 6, 23, 5, 2, 6 )			
		,( 1, 2, 6, 23, 5, 2, 7 )			
		,( 1, 2, 6, 23, 5, 2, 8 )			
		,( 1, 2, 6, 23, 5, 2, 9 )			
		,( 1, 2, 6, 23, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 23, 6, 2, 1 )				
		,( 1, 2, 6, 23, 6, 2, 2 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 6, Week: 2
		,( 1, 2, 6, 23, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 6, 23, 6, 2, 4 )			
		,( 1, 2, 6, 23, 6, 2, 5 )			
		,( 1, 2, 6, 23, 6, 2, 6 )			
		,( 1, 2, 6, 23, 6, 2, 7 )			
		,( 1, 2, 6, 23, 6, 2, 8 )			
		,( 1, 2, 6, 23, 6, 2, 9 )			
		,( 1, 2, 6, 23, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 24, 1, 1, 1 )				
		,( 1, 2, 6, 24, 1, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 1, Week: 1
		,( 1, 2, 6, 24, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 2, 6, 24, 1, 1, 4 )			
		,( 1, 2, 6, 24, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 2, 6, 24, 1, 1, 6 )			-- different player same everything else
		,( 1, 2, 6, 24, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 2, 6, 24, 1, 1, 8 )			
		,( 1, 2, 6, 24, 1, 1, 9 )			
		,( 1, 2, 6, 24, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 24, 2, 1, 1 )				
		,( 1, 2, 6, 24, 2, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 2, Week: 1
		,( 1, 2, 6, 24, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 2, 6, 24, 2, 1, 4 )			
		,( 1, 2, 6, 24, 2, 1, 5 )			
		,( 1, 2, 6, 24, 2, 1, 6 )			
		,( 1, 2, 6, 24, 2, 1, 7 )			
		,( 1, 2, 6, 24, 2, 1, 8 )			
		,( 1, 2, 6, 24, 2, 1, 9 )			
		,( 1, 2, 6, 24, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 24, 3, 1, 1 )				
		,( 1, 2, 6, 24, 3, 1, 2 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 3, Week: 1
		,( 1, 2, 6, 24, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 2, 6, 24, 3, 1, 4 )			
		,( 1, 2, 6, 24, 3, 1, 5 )			
		,( 1, 2, 6, 24, 3, 1, 6 )			
		,( 1, 2, 6, 24, 3, 1, 7 )			
		,( 1, 2, 6, 24, 3, 1, 8 )			
		,( 1, 2, 6, 24, 3, 1, 9 )			
		,( 1, 2, 6, 24, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 24, 4, 2, 1 )				
		,( 1, 2, 6, 24, 4, 2, 2 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 4, Week: 2
		,( 1, 2, 6, 24, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 2, 6, 24, 4, 2, 4 )			
		,( 1, 2, 6, 24, 4, 2, 5 )			
		,( 1, 2, 6, 24, 4, 2, 6 )			
		,( 1, 2, 6, 24, 4, 2, 7 )			
		,( 1, 2, 6, 24, 4, 2, 8 )			
		,( 1, 2, 6, 24, 4, 2, 9 )			
		,( 1, 2, 6, 24, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 24, 5, 2, 1 )				
		,( 1, 2, 6, 24, 5, 2, 2 )			-- Year 2011, League:2, Team: 6, Player: 24, Game: 5, Week: 2
		,( 1, 2, 6, 24, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 2, 6, 24, 5, 2, 4 )			
		,( 1, 2, 6, 24, 5, 2, 5 )			
		,( 1, 2, 6, 24, 5, 2, 6 )			
		,( 1, 2, 6, 24, 5, 2, 7 )			
		,( 1, 2, 6, 24, 5, 2, 8 )			
		,( 1, 2, 6, 24, 5, 2, 9 )			
		,( 1, 2, 6, 24, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 2, 6, 24, 6, 2, 1 )				
		,( 1, 2, 6, 24, 6, 2, 2 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 6, Week: 2
		,( 1, 2, 6, 24, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 2, 6, 24, 6, 2, 4 )			
		,( 1, 2, 6, 24, 6, 2, 5 )			
		,( 1, 2, 6, 24, 6, 2, 6 )			
		,( 1, 2, 6, 24, 6, 2, 7 )			
		,( 1, 2, 6, 24, 6, 2, 8 )			
		,( 1, 2, 6, 24, 6, 2, 9 )			
		,( 1, 2, 6, 24, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 25, 1, 1, 1 )				
		,( 1, 3, 7, 25, 1, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 1, Week: 1
		,( 1, 3, 7, 25, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 7, 25, 1, 1, 4 )			
		,( 1, 3, 7, 25, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 7, 25, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 7, 25, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 7, 25, 1, 1, 8 )			
		,( 1, 3, 7, 25, 1, 1, 9 )			
		,( 1, 3, 7, 25, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 25, 2, 1, 1 )				
		,( 1, 3, 7, 25, 2, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 2, Week: 1
		,( 1, 3, 7, 25, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 7, 25, 2, 1, 4 )			
		,( 1, 3, 7, 25, 2, 1, 5 )			
		,( 1, 3, 7, 25, 2, 1, 6 )			
		,( 1, 3, 7, 25, 2, 1, 7 )			
		,( 1, 3, 7, 25, 2, 1, 8 )			
		,( 1, 3, 7, 25, 2, 1, 9 )			
		,( 1, 3, 7, 25, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 25, 3, 1, 1 )				
		,( 1, 3, 7, 25, 3, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 3, Week: 1
		,( 1, 3, 7, 25, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 7, 25, 3, 1, 4 )			
		,( 1, 3, 7, 25, 3, 1, 5 )			
		,( 1, 3, 7, 25, 3, 1, 6 )			
		,( 1, 3, 7, 25, 3, 1, 7 )			
		,( 1, 3, 7, 25, 3, 1, 8 )			
		,( 1, 3, 7, 25, 3, 1, 9 )			
		,( 1, 3, 7, 25, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 25, 4, 2, 1 )				
		,( 1, 3, 7, 25, 4, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 4, Week: 2
		,( 1, 3, 7, 25, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 7, 25, 4, 2, 4 )			
		,( 1, 3, 7, 25, 4, 2, 5 )			
		,( 1, 3, 7, 25, 4, 2, 6 )			
		,( 1, 3, 7, 25, 4, 2, 7 )			
		,( 1, 3, 7, 25, 4, 2, 8 )			
		,( 1, 3, 7, 25, 4, 2, 9 )			
		,( 1, 3, 7, 25, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 25, 5, 2, 1 )				
		,( 1, 3, 7, 25, 5, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 5, Week: 2
		,( 1, 3, 7, 25, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 7, 25, 5, 2, 4 )			
		,( 1, 3, 7, 25, 5, 2, 5 )			
		,( 1, 3, 7, 25, 5, 2, 6 )			
		,( 1, 3, 7, 25, 5, 2, 7 )			
		,( 1, 3, 7, 25, 5, 2, 8 )			
		,( 1, 3, 7, 25, 5, 2, 9 )			
		,( 1, 3, 7, 25, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 25, 6, 2, 1 )				
		,( 1, 3, 7, 25, 6, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 6, Week: 2
		,( 1, 3, 7, 25, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 7, 25, 6, 2, 4 )			
		,( 1, 3, 7, 25, 6, 2, 5 )			
		,( 1, 3, 7, 25, 6, 2, 6 )			
		,( 1, 3, 7, 25, 6, 2, 7 )			
		,( 1, 3, 7, 25, 6, 2, 8 )			
		,( 1, 3, 7, 25, 6, 2, 9 )			
		,( 1, 3, 7, 25, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 26, 1, 1, 1 )				
		,( 1, 3, 7, 26, 1, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 1, Week: 1
		,( 1, 3, 7, 26, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 7, 26, 1, 1, 4 )			
		,( 1, 3, 7, 26, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 7, 26, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 7, 26, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 7, 26, 1, 1, 8 )			
		,( 1, 3, 7, 26, 1, 1, 9 )			
		,( 1, 3, 7, 26, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 26, 2, 1, 1 )				
		,( 1, 3, 7, 26, 2, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 2, Week: 1
		,( 1, 3, 7, 26, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 7, 26, 2, 1, 4 )			
		,( 1, 3, 7, 26, 2, 1, 5 )			
		,( 1, 3, 7, 26, 2, 1, 6 )			
		,( 1, 3, 7, 26, 2, 1, 7 )			
		,( 1, 3, 7, 26, 2, 1, 8 )			
		,( 1, 3, 7, 26, 2, 1, 9 )			
		,( 1, 3, 7, 26, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 26, 3, 1, 1 )				
		,( 1, 3, 7, 26, 3, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 3, Week: 1
		,( 1, 3, 7, 26, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 7, 26, 3, 1, 4 )			
		,( 1, 3, 7, 26, 3, 1, 5 )			
		,( 1, 3, 7, 26, 3, 1, 6 )			
		,( 1, 3, 7, 26, 3, 1, 7 )			
		,( 1, 3, 7, 26, 3, 1, 8 )			
		,( 1, 3, 7, 26, 3, 1, 9 )			
		,( 1, 3, 7, 26, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 26, 4, 2, 1 )				
		,( 1, 3, 7, 26, 4, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 4, Week: 2
		,( 1, 3, 7, 26, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 7, 26, 4, 2, 4 )			
		,( 1, 3, 7, 26, 4, 2, 5 )			
		,( 1, 3, 7, 26, 4, 2, 6 )			
		,( 1, 3, 7, 26, 4, 2, 7 )			
		,( 1, 3, 7, 26, 4, 2, 8 )			
		,( 1, 3, 7, 26, 4, 2, 9 )			
		,( 1, 3, 7, 26, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 26, 5, 2, 1 )				
		,( 1, 3, 7, 26, 5, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 5, Week: 2
		,( 1, 3, 7, 26, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 7, 26, 5, 2, 4 )			
		,( 1, 3, 7, 26, 5, 2, 5 )			
		,( 1, 3, 7, 26, 5, 2, 6 )			
		,( 1, 3, 7, 26, 5, 2, 7 )			
		,( 1, 3, 7, 26, 5, 2, 8 )			
		,( 1, 3, 7, 26, 5, 2, 9 )			
		,( 1, 3, 7, 26, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 26, 6, 2, 1 )				
		,( 1, 3, 7, 26, 6, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 6, Week: 2
		,( 1, 3, 7, 26, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 7, 26, 6, 2, 4 )			
		,( 1, 3, 7, 26, 6, 2, 5 )			
		,( 1, 3, 7, 26, 6, 2, 6 )			
		,( 1, 3, 7, 26, 6, 2, 7 )			
		,( 1, 3, 7, 26, 6, 2, 8 )			
		,( 1, 3, 7, 26, 6, 2, 9 )			
		,( 1, 3, 7, 26, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 27, 1, 1, 1 )				
		,( 1, 3, 7, 27, 1, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 1, Week: 1
		,( 1, 3, 7, 27, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 7, 27, 1, 1, 4 )			
		,( 1, 3, 7, 27, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 7, 27, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 7, 27, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 7, 27, 1, 1, 8 )			
		,( 1, 3, 7, 27, 1, 1, 9 )			
		,( 1, 3, 7, 27, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 27, 2, 1, 1 )				
		,( 1, 3, 7, 27, 2, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 2, Week: 1
		,( 1, 3, 7, 27, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 7, 27, 2, 1, 4 )			
		,( 1, 3, 7, 27, 2, 1, 5 )			
		,( 1, 3, 7, 27, 2, 1, 6 )			
		,( 1, 3, 7, 27, 2, 1, 7 )			
		,( 1, 3, 7, 27, 2, 1, 8 )			
		,( 1, 3, 7, 27, 2, 1, 9 )			
		,( 1, 3, 7, 27, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 27, 3, 1, 1 )				
		,( 1, 3, 7, 27, 3, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 3, Week: 1
		,( 1, 3, 7, 27, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 7, 27, 3, 1, 4 )			
		,( 1, 3, 7, 27, 3, 1, 5 )			
		,( 1, 3, 7, 27, 3, 1, 6 )			
		,( 1, 3, 7, 27, 3, 1, 7 )			
		,( 1, 3, 7, 27, 3, 1, 8 )			
		,( 1, 3, 7, 27, 3, 1, 9 )			
		,( 1, 3, 7, 27, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 27, 4, 2, 1 )				
		,( 1, 3, 7, 27, 4, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 4, Week: 2
		,( 1, 3, 7, 27, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 7, 27, 4, 2, 4 )			
		,( 1, 3, 7, 27, 4, 2, 5 )			
		,( 1, 3, 7, 27, 4, 2, 6 )			
		,( 1, 3, 7, 27, 4, 2, 7 )			
		,( 1, 3, 7, 27, 4, 2, 8 )			
		,( 1, 3, 7, 27, 4, 2, 9 )			
		,( 1, 3, 7, 27, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 27, 5, 2, 1 )				
		,( 1, 3, 7, 27, 5, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 5, Week: 2
		,( 1, 3, 7, 27, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 7, 27, 5, 2, 4 )			
		,( 1, 3, 7, 27, 5, 2, 5 )			
		,( 1, 3, 7, 27, 5, 2, 6 )			
		,( 1, 3, 7, 27, 5, 2, 7 )			
		,( 1, 3, 7, 27, 5, 2, 8 )			
		,( 1, 3, 7, 27, 5, 2, 9 )			
		,( 1, 3, 7, 27, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 27, 6, 2, 1 )				
		,( 1, 3, 7, 27, 6, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 6, Week: 2
		,( 1, 3, 7, 27, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 7, 27, 6, 2, 4 )			
		,( 1, 3, 7, 27, 6, 2, 5 )			
		,( 1, 3, 7, 27, 6, 2, 6 )			
		,( 1, 3, 7, 27, 6, 2, 7 )			
		,( 1, 3, 7, 27, 6, 2, 8 )			
		,( 1, 3, 7, 27, 6, 2, 9 )			
		,( 1, 3, 7, 27, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 28, 1, 1, 1 )				
		,( 1, 3, 7, 28, 1, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 1, Week: 1
		,( 1, 3, 7, 28, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 7, 28, 1, 1, 4 )			
		,( 1, 3, 7, 28, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 7, 28, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 7, 28, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 7, 28, 1, 1, 8 )			
		,( 1, 3, 7, 28, 1, 1, 9 )			
		,( 1, 3, 7, 28, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 28, 2, 1, 1 )				
		,( 1, 3, 7, 28, 2, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 2, Week: 1
		,( 1, 3, 7, 28, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 7, 28, 2, 1, 4 )			
		,( 1, 3, 7, 28, 2, 1, 5 )			
		,( 1, 3, 7, 28, 2, 1, 6 )			
		,( 1, 3, 7, 28, 2, 1, 7 )			
		,( 1, 3, 7, 28, 2, 1, 8 )			
		,( 1, 3, 7, 28, 2, 1, 9 )			
		,( 1, 3, 7, 28, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 28, 3, 1, 1 )				
		,( 1, 3, 7, 28, 3, 1, 2 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 3, Week: 1
		,( 1, 3, 7, 28, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 7, 28, 3, 1, 4 )			
		,( 1, 3, 7, 28, 3, 1, 5 )			
		,( 1, 3, 7, 28, 3, 1, 6 )			
		,( 1, 3, 7, 28, 3, 1, 7 )			
		,( 1, 3, 7, 28, 3, 1, 8 )			
		,( 1, 3, 7, 28, 3, 1, 9 )			
		,( 1, 3, 7, 28, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 28, 4, 2, 1 )				
		,( 1, 3, 7, 28, 4, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 4, Week: 2
		,( 1, 3, 7, 28, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 7, 28, 4, 2, 4 )			
		,( 1, 3, 7, 28, 4, 2, 5 )			
		,( 1, 3, 7, 28, 4, 2, 6 )			
		,( 1, 3, 7, 28, 4, 2, 7 )			
		,( 1, 3, 7, 28, 4, 2, 8 )			
		,( 1, 3, 7, 28, 4, 2, 9 )			
		,( 1, 3, 7, 28, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 28, 5, 2, 1 )				
		,( 1, 3, 7, 28, 5, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 5, Week: 2
		,( 1, 3, 7, 28, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 7, 28, 5, 2, 4 )			
		,( 1, 3, 7, 28, 5, 2, 5 )			
		,( 1, 3, 7, 28, 5, 2, 6 )			
		,( 1, 3, 7, 28, 5, 2, 7 )			
		,( 1, 3, 7, 28, 5, 2, 8 )			
		,( 1, 3, 7, 28, 5, 2, 9 )			
		,( 1, 3, 7, 28, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 7, 28, 6, 2, 1 )				
		,( 1, 3, 7, 28, 6, 2, 2 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 6, Week: 2
		,( 1, 3, 7, 28, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 7, 28, 6, 2, 4 )			
		,( 1, 3, 7, 28, 6, 2, 5 )			
		,( 1, 3, 7, 28, 6, 2, 6 )			
		,( 1, 3, 7, 28, 6, 2, 7 )			
		,( 1, 3, 7, 28, 6, 2, 8 )			
		,( 1, 3, 7, 28, 6, 2, 9 )			
		,( 1, 3, 7, 28, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 29, 1, 1, 1 )				
		,( 1, 3, 8, 29, 1, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 1, Week: 1
		,( 1, 3, 8, 29, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 8, 29, 1, 1, 4 )			
		,( 1, 3, 8, 29, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 8, 29, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 8, 29, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 8, 29, 1, 1, 8 )			
		,( 1, 3, 8, 29, 1, 1, 9 )			
		,( 1, 3, 8, 29, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 29, 2, 1, 1 )				
		,( 1, 3, 8, 29, 2, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 2, Week: 1
		,( 1, 3, 8, 29, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 8, 29, 2, 1, 4 )			
		,( 1, 3, 8, 29, 2, 1, 5 )			
		,( 1, 3, 8, 29, 2, 1, 6 )			
		,( 1, 3, 8, 29, 2, 1, 7 )			
		,( 1, 3, 8, 29, 2, 1, 8 )			
		,( 1, 3, 8, 29, 2, 1, 9 )			
		,( 1, 3, 8, 29, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 29, 3, 1, 1 )				
		,( 1, 3, 8, 29, 3, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 3, Week: 1
		,( 1, 3, 8, 29, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 8, 29, 3, 1, 4 )			
		,( 1, 3, 8, 29, 3, 1, 5 )			
		,( 1, 3, 8, 29, 3, 1, 6 )			
		,( 1, 3, 8, 29, 3, 1, 7 )			
		,( 1, 3, 8, 29, 3, 1, 8 )			
		,( 1, 3, 8, 29, 3, 1, 9 )			
		,( 1, 3, 8, 29, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 29, 4, 2, 1 )				
		,( 1, 3, 8, 29, 4, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 4, Week: 2
		,( 1, 3, 8, 29, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 8, 29, 4, 2, 4 )			
		,( 1, 3, 8, 29, 4, 2, 5 )			
		,( 1, 3, 8, 29, 4, 2, 6 )			
		,( 1, 3, 8, 29, 4, 2, 7 )			
		,( 1, 3, 8, 29, 4, 2, 8 )			
		,( 1, 3, 8, 29, 4, 2, 9 )			
		,( 1, 3, 8, 29, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 29, 5, 2, 1 )				
		,( 1, 3, 8, 29, 5, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 5, Week: 2
		,( 1, 3, 8, 29, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 8, 29, 5, 2, 4 )			
		,( 1, 3, 8, 29, 5, 2, 5 )			
		,( 1, 3, 8, 29, 5, 2, 6 )			
		,( 1, 3, 8, 29, 5, 2, 7 )			
		,( 1, 3, 8, 29, 5, 2, 8 )			
		,( 1, 3, 8, 29, 5, 2, 9 )			
		,( 1, 3, 8, 29, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 29, 6, 2, 1 )				
		,( 1, 3, 8, 29, 6, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 6, Week: 2
		,( 1, 3, 8, 29, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 8, 29, 6, 2, 4 )			
		,( 1, 3, 8, 29, 6, 2, 5 )			
		,( 1, 3, 8, 29, 6, 2, 6 )			
		,( 1, 3, 8, 29, 6, 2, 7 )			
		,( 1, 3, 8, 29, 6, 2, 8 )			
		,( 1, 3, 8, 29, 6, 2, 9 )			
		,( 1, 3, 8, 29, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 30, 1, 1, 1 )				
		,( 1, 3, 8, 30, 1, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 1, Week: 1
		,( 1, 3, 8, 30, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 8, 30, 1, 1, 4 )			
		,( 1, 3, 8, 30, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 8, 30, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 8, 30, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 8, 30, 1, 1, 8 )			
		,( 1, 3, 8, 30, 1, 1, 9 )			
		,( 1, 3, 8, 30, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 30, 2, 1, 1 )				
		,( 1, 3, 8, 30, 2, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 2, Week: 1
		,( 1, 3, 8, 30, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 8, 30, 2, 1, 4 )			
		,( 1, 3, 8, 30, 2, 1, 5 )			
		,( 1, 3, 8, 30, 2, 1, 6 )			
		,( 1, 3, 8, 30, 2, 1, 7 )			
		,( 1, 3, 8, 30, 2, 1, 8 )			
		,( 1, 3, 8, 30, 2, 1, 9 )			
		,( 1, 3, 8, 30, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 30, 3, 1, 1 )				
		,( 1, 3, 8, 30, 3, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 3, Week: 1
		,( 1, 3, 8, 30, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 8, 30, 3, 1, 4 )			
		,( 1, 3, 8, 30, 3, 1, 5 )			
		,( 1, 3, 8, 30, 3, 1, 6 )			
		,( 1, 3, 8, 30, 3, 1, 7 )			
		,( 1, 3, 8, 30, 3, 1, 8 )			
		,( 1, 3, 8, 30, 3, 1, 9 )			
		,( 1, 3, 8, 30, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 30, 4, 2, 1 )				
		,( 1, 3, 8, 30, 4, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 4, Week: 2
		,( 1, 3, 8, 30, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 8, 30, 4, 2, 4 )			
		,( 1, 3, 8, 30, 4, 2, 5 )			
		,( 1, 3, 8, 30, 4, 2, 6 )			
		,( 1, 3, 8, 30, 4, 2, 7 )			
		,( 1, 3, 8, 30, 4, 2, 8 )			
		,( 1, 3, 8, 30, 4, 2, 9 )			
		,( 1, 3, 8, 30, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 30, 5, 2, 1 )				
		,( 1, 3, 8, 30, 5, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 5, Week: 2
		,( 1, 3, 8, 30, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 8, 30, 5, 2, 4 )			
		,( 1, 3, 8, 30, 5, 2, 5 )			
		,( 1, 3, 8, 30, 5, 2, 6 )			
		,( 1, 3, 8, 30, 5, 2, 7 )			
		,( 1, 3, 8, 30, 5, 2, 8 )			
		,( 1, 3, 8, 30, 5, 2, 9 )			
		,( 1, 3, 8, 30, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 30, 6, 2, 1 )				
		,( 1, 3, 8, 30, 6, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 6, Week: 2
		,( 1, 3, 8, 30, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 8, 30, 6, 2, 4 )			
		,( 1, 3, 8, 30, 6, 2, 5 )			
		,( 1, 3, 8, 30, 6, 2, 6 )			
		,( 1, 3, 8, 30, 6, 2, 7 )			
		,( 1, 3, 8, 30, 6, 2, 8 )			
		,( 1, 3, 8, 30, 6, 2, 9 )			
		,( 1, 3, 8, 30, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 31, 1, 1, 1 )				
		,( 1, 3, 8, 31, 1, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 1, Week: 1
		,( 1, 3, 8, 31, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 8, 31, 1, 1, 4 )			
		,( 1, 3, 8, 31, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 8, 31, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 8, 31, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 8, 31, 1, 1, 8 )			
		,( 1, 3, 8, 31, 1, 1, 9 )			
		,( 1, 3, 8, 31, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 31, 2, 1, 1 )				
		,( 1, 3, 8, 31, 2, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 2, Week: 1
		,( 1, 3, 8, 31, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 8, 31, 2, 1, 4 )			
		,( 1, 3, 8, 31, 2, 1, 5 )			
		,( 1, 3, 8, 31, 2, 1, 6 )			
		,( 1, 3, 8, 31, 2, 1, 7 )			
		,( 1, 3, 8, 31, 2, 1, 8 )			
		,( 1, 3, 8, 31, 2, 1, 9 )			
		,( 1, 3, 8, 31, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 31, 3, 1, 1 )				
		,( 1, 3, 8, 31, 3, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 3, Week: 1
		,( 1, 3, 8, 31, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 8, 31, 3, 1, 4 )			
		,( 1, 3, 8, 31, 3, 1, 5 )			
		,( 1, 3, 8, 31, 3, 1, 6 )			
		,( 1, 3, 8, 31, 3, 1, 7 )			
		,( 1, 3, 8, 31, 3, 1, 8 )			
		,( 1, 3, 8, 31, 3, 1, 9 )			
		,( 1, 3, 8, 31, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 31, 4, 2, 1 )				
		,( 1, 3, 8, 31, 4, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 4, Week: 2
		,( 1, 3, 8, 31, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 8, 31, 4, 2, 4 )			
		,( 1, 3, 8, 31, 4, 2, 5 )			
		,( 1, 3, 8, 31, 4, 2, 6 )			
		,( 1, 3, 8, 31, 4, 2, 7 )			
		,( 1, 3, 8, 31, 4, 2, 8 )			
		,( 1, 3, 8, 31, 4, 2, 9 )			
		,( 1, 3, 8, 31, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 31, 5, 2, 1 )				
		,( 1, 3, 8, 31, 5, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 5, Week: 2
		,( 1, 3, 8, 31, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 8, 31, 5, 2, 4 )			
		,( 1, 3, 8, 31, 5, 2, 5 )			
		,( 1, 3, 8, 31, 5, 2, 6 )			
		,( 1, 3, 8, 31, 5, 2, 7 )			
		,( 1, 3, 8, 31, 5, 2, 8 )			
		,( 1, 3, 8, 31, 5, 2, 9 )			
		,( 1, 3, 8, 31, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 31, 6, 2, 1 )				
		,( 1, 3, 8, 31, 6, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 6, Week: 2
		,( 1, 3, 8, 31, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 8, 31, 6, 2, 4 )			
		,( 1, 3, 8, 31, 6, 2, 5 )			
		,( 1, 3, 8, 31, 6, 2, 6 )			
		,( 1, 3, 8, 31, 6, 2, 7 )			
		,( 1, 3, 8, 31, 6, 2, 8 )			
		,( 1, 3, 8, 31, 6, 2, 9 )			
		,( 1, 3, 8, 31, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 32, 1, 1, 1 )				
		,( 1, 3, 8, 32, 1, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 1, Week: 1
		,( 1, 3, 8, 32, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 8, 32, 1, 1, 4 )			
		,( 1, 3, 8, 32, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 8, 32, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 8, 32, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 8, 32, 1, 1, 8 )			
		,( 1, 3, 8, 32, 1, 1, 9 )			
		,( 1, 3, 8, 32, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 32, 2, 1, 1 )				
		,( 1, 3, 8, 32, 2, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 2, Week: 1
		,( 1, 3, 8, 32, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 8, 32, 2, 1, 4 )			
		,( 1, 3, 8, 32, 2, 1, 5 )			
		,( 1, 3, 8, 32, 2, 1, 6 )			
		,( 1, 3, 8, 32, 2, 1, 7 )			
		,( 1, 3, 8, 32, 2, 1, 8 )			
		,( 1, 3, 8, 32, 2, 1, 9 )			
		,( 1, 3, 8, 32, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 32, 3, 1, 1 )				
		,( 1, 3, 8, 32, 3, 1, 2 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 3, Week: 1
		,( 1, 3, 8, 32, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 8, 32, 3, 1, 4 )			
		,( 1, 3, 8, 32, 3, 1, 5 )			
		,( 1, 3, 8, 32, 3, 1, 6 )			
		,( 1, 3, 8, 32, 3, 1, 7 )			
		,( 1, 3, 8, 32, 3, 1, 8 )			
		,( 1, 3, 8, 32, 3, 1, 9 )			
		,( 1, 3, 8, 32, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 32, 4, 2, 1 )				
		,( 1, 3, 8, 32, 4, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 4, Week: 2
		,( 1, 3, 8, 32, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 8, 32, 4, 2, 4 )			
		,( 1, 3, 8, 32, 4, 2, 5 )			
		,( 1, 3, 8, 32, 4, 2, 6 )			
		,( 1, 3, 8, 32, 4, 2, 7 )			
		,( 1, 3, 8, 32, 4, 2, 8 )			
		,( 1, 3, 8, 32, 4, 2, 9 )			
		,( 1, 3, 8, 32, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 32, 5, 2, 1 )				
		,( 1, 3, 8, 32, 5, 2, 2 )			-- Year 2011, League:3, Team: 8, Player: 32, Game: 5, Week: 2
		,( 1, 3, 8, 32, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 8, 32, 5, 2, 4 )			
		,( 1, 3, 8, 32, 5, 2, 5 )			
		,( 1, 3, 8, 32, 5, 2, 6 )			
		,( 1, 3, 8, 32, 5, 2, 7 )			
		,( 1, 3, 8, 32, 5, 2, 8 )			
		,( 1, 3, 8, 32, 5, 2, 9 )			
		,( 1, 3, 8, 32, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 8, 32, 6, 2, 1 )				
		,( 1, 3, 8, 32, 6, 2, 2 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 6, Week: 2
		,( 1, 3, 8, 32, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 8, 32, 6, 2, 4 )			
		,( 1, 3, 8, 32, 6, 2, 5 )			
		,( 1, 3, 8, 32, 6, 2, 6 )			
		,( 1, 3, 8, 32, 6, 2, 7 )			
		,( 1, 3, 8, 32, 6, 2, 8 )			
		,( 1, 3, 8, 32, 6, 2, 9 )			
		,( 1, 3, 8, 32, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 33, 1, 1, 1 )				
		,( 1, 3, 9, 33, 1, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 1, Week: 1
		,( 1, 3, 9, 33, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 9, 33, 1, 1, 4 )			
		,( 1, 3, 9, 33, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 9, 33, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 9, 33, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 9, 33, 1, 1, 8 )			
		,( 1, 3, 9, 33, 1, 1, 9 )			
		,( 1, 3, 9, 33, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 33, 2, 1, 1 )				
		,( 1, 3, 9, 33, 2, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 2, Week: 1
		,( 1, 3, 9, 33, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 9, 33, 2, 1, 4 )			
		,( 1, 3, 9, 33, 2, 1, 5 )			
		,( 1, 3, 9, 33, 2, 1, 6 )			
		,( 1, 3, 9, 33, 2, 1, 7 )			
		,( 1, 3, 9, 33, 2, 1, 8 )			
		,( 1, 3, 9, 33, 2, 1, 9 )			
		,( 1, 3, 9, 33, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 33, 3, 1, 1 )				
		,( 1, 3, 9, 33, 3, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 3, Week: 1
		,( 1, 3, 9, 33, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 9, 33, 3, 1, 4 )			
		,( 1, 3, 9, 33, 3, 1, 5 )			
		,( 1, 3, 9, 33, 3, 1, 6 )			
		,( 1, 3, 9, 33, 3, 1, 7 )			
		,( 1, 3, 9, 33, 3, 1, 8 )			
		,( 1, 3, 9, 33, 3, 1, 9 )			
		,( 1, 3, 9, 33, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 33, 4, 2, 1 )				
		,( 1, 3, 9, 33, 4, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 4, Week: 2
		,( 1, 3, 9, 33, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 9, 33, 4, 2, 4 )			
		,( 1, 3, 9, 33, 4, 2, 5 )			
		,( 1, 3, 9, 33, 4, 2, 6 )			
		,( 1, 3, 9, 33, 4, 2, 7 )			
		,( 1, 3, 9, 33, 4, 2, 8 )			
		,( 1, 3, 9, 33, 4, 2, 9 )			
		,( 1, 3, 9, 33, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 33, 5, 2, 1 )				
		,( 1, 3, 9, 33, 5, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 5, Week: 2
		,( 1, 3, 9, 33, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 9, 33, 5, 2, 4 )			
		,( 1, 3, 9, 33, 5, 2, 5 )			
		,( 1, 3, 9, 33, 5, 2, 6 )			
		,( 1, 3, 9, 33, 5, 2, 7 )			
		,( 1, 3, 9, 33, 5, 2, 8 )			
		,( 1, 3, 9, 33, 5, 2, 9 )			
		,( 1, 3, 9, 33, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 33, 6, 2, 1 )				
		,( 1, 3, 9, 33, 6, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 6, Week: 2
		,( 1, 3, 9, 33, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 9, 33, 6, 2, 4 )			
		,( 1, 3, 9, 33, 6, 2, 5 )			
		,( 1, 3, 9, 33, 6, 2, 6 )			
		,( 1, 3, 9, 33, 6, 2, 7 )			
		,( 1, 3, 9, 33, 6, 2, 8 )			
		,( 1, 3, 9, 33, 6, 2, 9 )			
		,( 1, 3, 9, 33, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 34, 1, 1, 1 )				
		,( 1, 3, 9, 34, 1, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 1, Week: 1
		,( 1, 3, 9, 34, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 9, 34, 1, 1, 4 )			
		,( 1, 3, 9, 34, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 9, 34, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 9, 34, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 9, 34, 1, 1, 8 )			
		,( 1, 3, 9, 34, 1, 1, 9 )			
		,( 1, 3, 9, 34, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 34, 2, 1, 1 )				
		,( 1, 3, 9, 34, 2, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 2, Week: 1
		,( 1, 3, 9, 34, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 9, 34, 2, 1, 4 )			
		,( 1, 3, 9, 34, 2, 1, 5 )			
		,( 1, 3, 9, 34, 2, 1, 6 )			
		,( 1, 3, 9, 34, 2, 1, 7 )			
		,( 1, 3, 9, 34, 2, 1, 8 )			
		,( 1, 3, 9, 34, 2, 1, 9 )			
		,( 1, 3, 9, 34, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 34, 3, 1, 1 )				
		,( 1, 3, 9, 34, 3, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 3, Week: 1
		,( 1, 3, 9, 34, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 9, 34, 3, 1, 4 )			
		,( 1, 3, 9, 34, 3, 1, 5 )			
		,( 1, 3, 9, 34, 3, 1, 6 )			
		,( 1, 3, 9, 34, 3, 1, 7 )			
		,( 1, 3, 9, 34, 3, 1, 8 )			
		,( 1, 3, 9, 34, 3, 1, 9 )			
		,( 1, 3, 9, 34, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 34, 4, 2, 1 )				
		,( 1, 3, 9, 34, 4, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 4, Week: 2
		,( 1, 3, 9, 34, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 9, 34, 4, 2, 4 )			
		,( 1, 3, 9, 34, 4, 2, 5 )			
		,( 1, 3, 9, 34, 4, 2, 6 )			
		,( 1, 3, 9, 34, 4, 2, 7 )			
		,( 1, 3, 9, 34, 4, 2, 8 )			
		,( 1, 3, 9, 34, 4, 2, 9 )			
		,( 1, 3, 9, 34, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 34, 5, 2, 1 )				
		,( 1, 3, 9, 34, 5, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 5, Week: 2
		,( 1, 3, 9, 34, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 9, 34, 5, 2, 4 )			
		,( 1, 3, 9, 34, 5, 2, 5 )			
		,( 1, 3, 9, 34, 5, 2, 6 )			
		,( 1, 3, 9, 34, 5, 2, 7 )			
		,( 1, 3, 9, 34, 5, 2, 8 )			
		,( 1, 3, 9, 34, 5, 2, 9 )			
		,( 1, 3, 9, 34, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 34, 6, 2, 1 )				
		,( 1, 3, 9, 34, 6, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 6, Week: 2
		,( 1, 3, 9, 34, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 9, 34, 6, 2, 4 )			
		,( 1, 3, 9, 34, 6, 2, 5 )			
		,( 1, 3, 9, 34, 6, 2, 6 )			
		,( 1, 3, 9, 34, 6, 2, 7 )			
		,( 1, 3, 9, 34, 6, 2, 8 )			
		,( 1, 3, 9, 34, 6, 2, 9 )			
		,( 1, 3, 9, 34, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 35, 1, 1, 1 )				
		,( 1, 3, 9, 35, 1, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 1, Week: 1
		,( 1, 3, 9, 35, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 9, 35, 1, 1, 4 )			
		,( 1, 3, 9, 35, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 9, 35, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 9, 35, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 9, 35, 1, 1, 8 )			
		,( 1, 3, 9, 35, 1, 1, 9 )			
		,( 1, 3, 9, 35, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 35, 2, 1, 1 )				
		,( 1, 3, 9, 35, 2, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 2, Week: 1
		,( 1, 3, 9, 35, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 9, 35, 2, 1, 4 )			
		,( 1, 3, 9, 35, 2, 1, 5 )			
		,( 1, 3, 9, 35, 2, 1, 6 )			
		,( 1, 3, 9, 35, 2, 1, 7 )			
		,( 1, 3, 9, 35, 2, 1, 8 )			
		,( 1, 3, 9, 35, 2, 1, 9 )			
		,( 1, 3, 9, 35, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 35, 3, 1, 1 )				
		,( 1, 3, 9, 35, 3, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 3, Week: 1
		,( 1, 3, 9, 35, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 9, 35, 3, 1, 4 )			
		,( 1, 3, 9, 35, 3, 1, 5 )			
		,( 1, 3, 9, 35, 3, 1, 6 )			
		,( 1, 3, 9, 35, 3, 1, 7 )			
		,( 1, 3, 9, 35, 3, 1, 8 )			
		,( 1, 3, 9, 35, 3, 1, 9 )			
		,( 1, 3, 9, 35, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 35, 4, 2, 1 )				
		,( 1, 3, 9, 35, 4, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 4, Week: 2
		,( 1, 3, 9, 35, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 9, 35, 4, 2, 4 )			
		,( 1, 3, 9, 35, 4, 2, 5 )			
		,( 1, 3, 9, 35, 4, 2, 6 )			
		,( 1, 3, 9, 35, 4, 2, 7 )			
		,( 1, 3, 9, 35, 4, 2, 8 )			
		,( 1, 3, 9, 35, 4, 2, 9 )			
		,( 1, 3, 9, 35, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 35, 5, 2, 1 )				
		,( 1, 3, 9, 35, 5, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 5, Week: 2
		,( 1, 3, 9, 35, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 9, 35, 5, 2, 4 )			
		,( 1, 3, 9, 35, 5, 2, 5 )			
		,( 1, 3, 9, 35, 5, 2, 6 )			
		,( 1, 3, 9, 35, 5, 2, 7 )			
		,( 1, 3, 9, 35, 5, 2, 8 )			
		,( 1, 3, 9, 35, 5, 2, 9 )			
		,( 1, 3, 9, 35, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 35, 6, 2, 1 )				
		,( 1, 3, 9, 35, 6, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 6, Week: 2
		,( 1, 3, 9, 35, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 9, 35, 6, 2, 4 )			
		,( 1, 3, 9, 35, 6, 2, 5 )			
		,( 1, 3, 9, 35, 6, 2, 6 )			
		,( 1, 3, 9, 35, 6, 2, 7 )			
		,( 1, 3, 9, 35, 6, 2, 8 )			
		,( 1, 3, 9, 35, 6, 2, 9 )			
		,( 1, 3, 9, 35, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 36, 1, 1, 1 )				
		,( 1, 3, 9, 36, 1, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 1, Week: 1
		,( 1, 3, 9, 36, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 3, 9, 36, 1, 1, 4 )			
		,( 1, 3, 9, 36, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 3, 9, 36, 1, 1, 6 )			-- different player same everything else
		,( 1, 3, 9, 36, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 3, 9, 36, 1, 1, 8 )			
		,( 1, 3, 9, 36, 1, 1, 9 )			
		,( 1, 3, 9, 36, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 36, 2, 1, 1 )				
		,( 1, 3, 9, 36, 2, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 2, Week: 1
		,( 1, 3, 9, 36, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 3, 9, 36, 2, 1, 4 )			
		,( 1, 3, 9, 36, 2, 1, 5 )			
		,( 1, 3, 9, 36, 2, 1, 6 )			
		,( 1, 3, 9, 36, 2, 1, 7 )			
		,( 1, 3, 9, 36, 2, 1, 8 )			
		,( 1, 3, 9, 36, 2, 1, 9 )			
		,( 1, 3, 9, 36, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 36, 3, 1, 1 )				
		,( 1, 3, 9, 36, 3, 1, 2 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 3, Week: 1
		,( 1, 3, 9, 36, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 3, 9, 36, 3, 1, 4 )			
		,( 1, 3, 9, 36, 3, 1, 5 )			
		,( 1, 3, 9, 36, 3, 1, 6 )			
		,( 1, 3, 9, 36, 3, 1, 7 )			
		,( 1, 3, 9, 36, 3, 1, 8 )			
		,( 1, 3, 9, 36, 3, 1, 9 )			
		,( 1, 3, 9, 36, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 36, 4, 2, 1 )				
		,( 1, 3, 9, 36, 4, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 4, Week: 2
		,( 1, 3, 9, 36, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 3, 9, 36, 4, 2, 4 )			
		,( 1, 3, 9, 36, 4, 2, 5 )			
		,( 1, 3, 9, 36, 4, 2, 6 )			
		,( 1, 3, 9, 36, 4, 2, 7 )			
		,( 1, 3, 9, 36, 4, 2, 8 )			
		,( 1, 3, 9, 36, 4, 2, 9 )			
		,( 1, 3, 9, 36, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 36, 5, 2, 1 )				
		,( 1, 3, 9, 36, 5, 2, 2 )			-- Year 2011, League:3, Team: 9, Player: 36, Game: 5, Week: 2
		,( 1, 3, 9, 36, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 3, 9, 36, 5, 2, 4 )			
		,( 1, 3, 9, 36, 5, 2, 5 )			
		,( 1, 3, 9, 36, 5, 2, 6 )			
		,( 1, 3, 9, 36, 5, 2, 7 )			
		,( 1, 3, 9, 36, 5, 2, 8 )			
		,( 1, 3, 9, 36, 5, 2, 9 )			
		,( 1, 3, 9, 36, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 3, 9, 36, 6, 2, 1 )				
		,( 1, 3, 9, 36, 6, 2, 2 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 6, Week: 2
		,( 1, 3, 9, 36, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 3, 9, 36, 6, 2, 4 )			
		,( 1, 3, 9, 36, 6, 2, 5 )			
		,( 1, 3, 9, 36, 6, 2, 6 )			
		,( 1, 3, 9, 36, 6, 2, 7 )			
		,( 1, 3, 9, 36, 6, 2, 8 )			
		,( 1, 3, 9, 36, 6, 2, 9 )			
		,( 1, 3, 9, 36, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 1, 1, 1, 1 )				
		,( 1, 4, 10, 1, 1, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 1, Week: 1
		,( 1, 4, 10, 1, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 10, 1, 1, 1, 4 )			
		,( 1, 4, 10, 1, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 4, 10, 1, 1, 1, 6 )			-- different player same everything else
		,( 1, 4, 10, 1, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 4, 10, 1, 1, 1, 8 )			
		,( 1, 4, 10, 1, 1, 1, 9 )			
		,( 1, 4, 10, 1, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 1, 2, 1, 1 )				
		,( 1, 4, 10, 1, 2, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 2, Week: 1
		,( 1, 4, 10, 1, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 10, 1, 2, 1, 4 )			
		,( 1, 4, 10, 1, 2, 1, 5 )			
		,( 1, 4, 10, 1, 2, 1, 6 )			
		,( 1, 4, 10, 1, 2, 1, 7 )			
		,( 1, 4, 10, 1, 2, 1, 8 )			
		,( 1, 4, 10, 1, 2, 1, 9 )			
		,( 1, 4, 10, 1, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 1, 3, 1, 1 )				
		,( 1, 4, 10, 1, 3, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 3, Week: 1
		,( 1, 4, 10, 1, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 10, 1, 3, 1, 4 )			
		,( 1, 4, 10, 1, 3, 1, 5 )			
		,( 1, 4, 10, 1, 3, 1, 6 )			
		,( 1, 4, 10, 1, 3, 1, 7 )			
		,( 1, 4, 10, 1, 3, 1, 8 )			
		,( 1, 4, 10, 1, 3, 1, 9 )			
		,( 1, 4, 10, 1, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 1, 4, 2, 1 )				
		,( 1, 4, 10, 1, 4, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 4, Week: 2
		,( 1, 4, 10, 1, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 10, 1, 4, 2, 4 )			
		,( 1, 4, 10, 1, 4, 2, 5 )			
		,( 1, 4, 10, 1, 4, 2, 6 )			
		,( 1, 4, 10, 1, 4, 2, 7 )			
		,( 1, 4, 10, 1, 4, 2, 8 )			
		,( 1, 4, 10, 1, 4, 2, 9 )			
		,( 1, 4, 10, 1, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 1, 5, 2, 1 )				
		,( 1, 4, 10, 1, 5, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 5, Week: 2
		,( 1, 4, 10, 1, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 10, 1, 5, 2, 4 )			
		,( 1, 4, 10, 1, 5, 2, 5 )			
		,( 1, 4, 10, 1, 5, 2, 6 )			
		,( 1, 4, 10, 1, 5, 2, 7 )			
		,( 1, 4, 10, 1, 5, 2, 8 )			
		,( 1, 4, 10, 1, 5, 2, 9 )			
		,( 1, 4, 10, 1, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 1, 6, 2, 1 )				
		,( 1, 4, 10, 1, 6, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 6, Week: 2
		,( 1, 4, 10, 1, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 10, 1, 6, 2, 4 )			
		,( 1, 4, 10, 1, 6, 2, 5 )			
		,( 1, 4, 10, 1, 6, 2, 6 )			
		,( 1, 4, 10, 1, 6, 2, 7 )			
		,( 1, 4, 10, 1, 6, 2, 8 )			
		,( 1, 4, 10, 1, 6, 2, 9 )			
		,( 1, 4, 10, 1, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 38, 1, 1, 1 )				
		,( 1, 4, 10, 38, 1, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 1, Week: 1
		,( 1, 4, 10, 38, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 10, 38, 1, 1, 4 )			
		,( 1, 4, 10, 38, 1, 1, 5 )			
		,( 1, 4, 10, 38, 1, 1, 6 )			
		,( 1, 4, 10, 38, 1, 1, 7 )			
		,( 1, 4, 10, 38, 1, 1, 8 )			
		,( 1, 4, 10, 38, 1, 1, 9 )			
		,( 1, 4, 10, 38, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 38, 2, 1, 1 )				
		,( 1, 4, 10, 38, 2, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 2, Week: 1
		,( 1, 4, 10, 38, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 10, 38, 2, 1, 4 )			
		,( 1, 4, 10, 38, 2, 1, 5 )			
		,( 1, 4, 10, 38, 2, 1, 6 )			
		,( 1, 4, 10, 38, 2, 1, 7 )			
		,( 1, 4, 10, 38, 2, 1, 8 )			
		,( 1, 4, 10, 38, 2, 1, 9 )			
		,( 1, 4, 10, 38, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 38, 3, 1, 1 )				
		,( 1, 4, 10, 38, 3, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 3, Week: 1
		,( 1, 4, 10, 38, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 10, 38, 3, 1, 4 )			
		,( 1, 4, 10, 38, 3, 1, 5 )			
		,( 1, 4, 10, 38, 3, 1, 6 )			
		,( 1, 4, 10, 38, 3, 1, 7 )			
		,( 1, 4, 10, 38, 3, 1, 8 )			
		,( 1, 4, 10, 38, 3, 1, 9 )			
		,( 1, 4, 10, 38, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 38, 4, 2, 1 )				
		,( 1, 4, 10, 38, 4, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 4, Week: 2
		,( 1, 4, 10, 38, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 10, 38, 4, 2, 4 )			
		,( 1, 4, 10, 38, 4, 2, 5 )			
		,( 1, 4, 10, 38, 4, 2, 6 )			
		,( 1, 4, 10, 38, 4, 2, 7 )			
		,( 1, 4, 10, 38, 4, 2, 8 )			
		,( 1, 4, 10, 38, 4, 2, 9 )			
		,( 1, 4, 10, 38, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 38, 5, 2, 1 )				
		,( 1, 4, 10, 38, 5, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 5, Week: 2
		,( 1, 4, 10, 38, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 10, 38, 5, 2, 4 )			
		,( 1, 4, 10, 38, 5, 2, 5 )			
		,( 1, 4, 10, 38, 5, 2, 6 )			
		,( 1, 4, 10, 38, 5, 2, 7 )			
		,( 1, 4, 10, 38, 5, 2, 8 )			
		,( 1, 4, 10, 38, 5, 2, 9 )			
		,( 1, 4, 10, 38, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 38, 6, 2, 1 )				
		,( 1, 4, 10, 38, 6, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 6, Week: 2
		,( 1, 4, 10, 38, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 10, 38, 6, 2, 4 )			
		,( 1, 4, 10, 38, 6, 2, 5 )			
		,( 1, 4, 10, 38, 6, 2, 6 )			
		,( 1, 4, 10, 38, 6, 2, 7 )			
		,( 1, 4, 10, 38, 6, 2, 8 )			
		,( 1, 4, 10, 38, 6, 2, 9 )			
		,( 1, 4, 10, 38, 6, 2, 10 )			
			
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 39, 1, 1, 1 )				
		,( 1, 4, 10, 39, 1, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 1, Week: 1
		,( 1, 4, 10, 39, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 10, 39, 1, 1, 4 )			
		,( 1, 4, 10, 39, 1, 1, 5 )			
		,( 1, 4, 10, 39, 1, 1, 6 )			
		,( 1, 4, 10, 39, 1, 1, 7 )			
		,( 1, 4, 10, 39, 1, 1, 8 )			
		,( 1, 4, 10, 39, 1, 1, 9 )			
		,( 1, 4, 10, 39, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 39, 2, 1, 1 )				
		,( 1, 4, 10, 39, 2, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 2, Week: 1
		,( 1, 4, 10, 39, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 10, 39, 2, 1, 4 )			
		,( 1, 4, 10, 39, 2, 1, 5 )			
		,( 1, 4, 10, 39, 2, 1, 6 )			
		,( 1, 4, 10, 39, 2, 1, 7 )			
		,( 1, 4, 10, 39, 2, 1, 8 )			
		,( 1, 4, 10, 39, 2, 1, 9 )			
		,( 1, 4, 10, 39, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 39, 3, 1, 1 )				
		,( 1, 4, 10, 39, 3, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 3, Week: 1
		,( 1, 4, 10, 39, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 10, 39, 3, 1, 4 )			
		,( 1, 4, 10, 39, 3, 1, 5 )			
		,( 1, 4, 10, 39, 3, 1, 6 )			
		,( 1, 4, 10, 39, 3, 1, 7 )			
		,( 1, 4, 10, 39, 3, 1, 8 )			
		,( 1, 4, 10, 39, 3, 1, 9 )			
		,( 1, 4, 10, 39, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 39, 4, 2, 1 )				
		,( 1, 4, 10, 39, 4, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 4, Week: 2
		,( 1, 4, 10, 39, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 10, 39, 4, 2, 4 )			
		,( 1, 4, 10, 39, 4, 2, 5 )			
		,( 1, 4, 10, 39, 4, 2, 6 )			
		,( 1, 4, 10, 39, 4, 2, 7 )			
		,( 1, 4, 10, 39, 4, 2, 8 )			
		,( 1, 4, 10, 39, 4, 2, 9 )			
		,( 1, 4, 10, 39, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 39, 5, 2, 1 )				
		,( 1, 4, 10, 39, 5, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 5, Week: 2
		,( 1, 4, 10, 39, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 10, 39, 5, 2, 4 )			
		,( 1, 4, 10, 39, 5, 2, 5 )			
		,( 1, 4, 10, 39, 5, 2, 6 )			
		,( 1, 4, 10, 39, 5, 2, 7 )			
		,( 1, 4, 10, 39, 5, 2, 8 )			
		,( 1, 4, 10, 39, 5, 2, 9 )			
		,( 1, 4, 10, 39, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 39, 6, 2, 1 )				
		,( 1, 4, 10, 39, 6, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 6, Week: 2
		,( 1, 4, 10, 39, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 10, 39, 6, 2, 4 )			
		,( 1, 4, 10, 39, 6, 2, 5 )			
		,( 1, 4, 10, 39, 6, 2, 6 )			
		,( 1, 4, 10, 39, 6, 2, 7 )			
		,( 1, 4, 10, 39, 6, 2, 8 )			
		,( 1, 4, 10, 39, 6, 2, 9 )			
		,( 1, 4, 10, 39, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 40, 1, 1, 1 )				
		,( 1, 4, 10, 40, 1, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 1, Week: 1
		,( 1, 4, 10, 40, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 10, 40, 1, 1, 4 )			
		,( 1, 4, 10, 40, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 4, 10, 40, 1, 1, 6 )			-- different player same everything else
		,( 1, 4, 10, 40, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 4, 10, 40, 1, 1, 8 )			
		,( 1, 4, 10, 40, 1, 1, 9 )			
		,( 1, 4, 10, 40, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 40, 2, 1, 1 )				
		,( 1, 4, 10, 40, 2, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 2, Week: 1
		,( 1, 4, 10, 40, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 10, 40, 2, 1, 4 )			
		,( 1, 4, 10, 40, 2, 1, 5 )			
		,( 1, 4, 10, 40, 2, 1, 6 )			
		,( 1, 4, 10, 40, 2, 1, 7 )			
		,( 1, 4, 10, 40, 2, 1, 8 )			
		,( 1, 4, 10, 40, 2, 1, 9 )			
		,( 1, 4, 10, 40, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 40, 3, 1, 1 )				
		,( 1, 4, 10, 40, 3, 1, 2 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 3, Week: 1
		,( 1, 4, 10, 40, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 10, 40, 3, 1, 4 )			
		,( 1, 4, 10, 40, 3, 1, 5 )			
		,( 1, 4, 10, 40, 3, 1, 6 )			
		,( 1, 4, 10, 40, 3, 1, 7 )			
		,( 1, 4, 10, 40, 3, 1, 8 )			
		,( 1, 4, 10, 40, 3, 1, 9 )			
		,( 1, 4, 10, 40, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 40, 4, 2, 1 )				
		,( 1, 4, 10, 40, 4, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 4, Week: 2
		,( 1, 4, 10, 40, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 10, 40, 4, 2, 4 )			
		,( 1, 4, 10, 40, 4, 2, 5 )			
		,( 1, 4, 10, 40, 4, 2, 6 )			
		,( 1, 4, 10, 40, 4, 2, 7 )			
		,( 1, 4, 10, 40, 4, 2, 8 )			
		,( 1, 4, 10, 40, 4, 2, 9 )			
		,( 1, 4, 10, 40, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 40, 5, 2, 1 )				
		,( 1, 4, 10, 40, 5, 2, 2 )			-- Year 2011, League:4, Team: 10, Player: 40, Game: 5, Week: 2
		,( 1, 4, 10, 40, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 10, 40, 5, 2, 4 )			
		,( 1, 4, 10, 40, 5, 2, 5 )			
		,( 1, 4, 10, 40, 5, 2, 6 )			
		,( 1, 4, 10, 40, 5, 2, 7 )			
		,( 1, 4, 10, 40, 5, 2, 8 )			
		,( 1, 4, 10, 40, 5, 2, 9 )			
		,( 1, 4, 10, 40, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 10, 40, 6, 2, 1 )				
		,( 1, 4, 10, 40, 6, 2, 2 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 6, Week: 2
		,( 1, 4, 10, 40, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 10, 40, 6, 2, 4 )			
		,( 1, 4, 10, 40, 6, 2, 5 )			
		,( 1, 4, 10, 40, 6, 2, 6 )			
		,( 1, 4, 10, 40, 6, 2, 7 )			
		,( 1, 4, 10, 40, 6, 2, 8 )			
		,( 1, 4, 10, 40, 6, 2, 9 )			
		,( 1, 4, 10, 40, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 41, 1, 1, 1 )				
		,( 1, 4, 11, 41, 1, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 1, Week: 1
		,( 1, 4, 11, 41, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 11, 41, 1, 1, 4 )			
		,( 1, 4, 11, 41, 1, 1, 5 )			
		,( 1, 4, 11, 41, 1, 1, 6 )			
		,( 1, 4, 11, 41, 1, 1, 7 )			
		,( 1, 4, 11, 41, 1, 1, 8 )			
		,( 1, 4, 11, 41, 1, 1, 9 )			
		,( 1, 4, 11, 41, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 41, 2, 1, 1 )				
		,( 1, 4, 11, 41, 2, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 2, Week: 1
		,( 1, 4, 11, 41, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 11, 41, 2, 1, 4 )			
		,( 1, 4, 11, 41, 2, 1, 5 )			
		,( 1, 4, 11, 41, 2, 1, 6 )			
		,( 1, 4, 11, 41, 2, 1, 7 )			
		,( 1, 4, 11, 41, 2, 1, 8 )			
		,( 1, 4, 11, 41, 2, 1, 9 )			
		,( 1, 4, 11, 41, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 41, 3, 1, 1 )				
		,( 1, 4, 11, 41, 3, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 3, Week: 1
		,( 1, 4, 11, 41, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 11, 41, 3, 1, 4 )			
		,( 1, 4, 11, 41, 3, 1, 5 )			
		,( 1, 4, 11, 41, 3, 1, 6 )			
		,( 1, 4, 11, 41, 3, 1, 7 )			
		,( 1, 4, 11, 41, 3, 1, 8 )			
		,( 1, 4, 11, 41, 3, 1, 9 )			
		,( 1, 4, 11, 41, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 41, 4, 2, 1 )				
		,( 1, 4, 11, 41, 4, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 4, Week: 2
		,( 1, 4, 11, 41, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 11, 41, 4, 2, 4 )			
		,( 1, 4, 11, 41, 4, 2, 5 )			
		,( 1, 4, 11, 41, 4, 2, 6 )			
		,( 1, 4, 11, 41, 4, 2, 7 )			
		,( 1, 4, 11, 41, 4, 2, 8 )			
		,( 1, 4, 11, 41, 4, 2, 9 )			
		,( 1, 4, 11, 41, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 41, 5, 2, 1 )				
		,( 1, 4, 11, 41, 5, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 5, Week: 2
		,( 1, 4, 11, 41, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 11, 41, 5, 2, 4 )			
		,( 1, 4, 11, 41, 5, 2, 5 )			
		,( 1, 4, 11, 41, 5, 2, 6 )			
		,( 1, 4, 11, 41, 5, 2, 7 )			
		,( 1, 4, 11, 41, 5, 2, 8 )			
		,( 1, 4, 11, 41, 5, 2, 9 )			
		,( 1, 4, 11, 41, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 41, 6, 2, 1 )				
		,( 1, 4, 11, 41, 6, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 6, Week: 2
		,( 1, 4, 11, 41, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 11, 41, 6, 2, 4 )			
		,( 1, 4, 11, 41, 6, 2, 5 )			
		,( 1, 4, 11, 41, 6, 2, 6 )			
		,( 1, 4, 11, 41, 6, 2, 7 )			
		,( 1, 4, 11, 41, 6, 2, 8 )			
		,( 1, 4, 11, 41, 6, 2, 9 )			
		,( 1, 4, 11, 41, 6, 2, 10 )			
		
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 42, 1, 1, 1 )				
		,( 1, 4, 11, 42, 1, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 1, Week: 1
		,( 1, 4, 11, 42, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 11, 42, 1, 1, 4 )			
		,( 1, 4, 11, 42, 1, 1, 5 )			
		,( 1, 4, 11, 42, 1, 1, 6 )			
		,( 1, 4, 11, 42, 1, 1, 7 )			
		,( 1, 4, 11, 42, 1, 1, 8 )			
		,( 1, 4, 11, 42, 1, 1, 9 )			
		,( 1, 4, 11, 42, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 42, 2, 1, 1 )				
		,( 1, 4, 11, 42, 2, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 2, Week: 1
		,( 1, 4, 11, 42, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 11, 42, 2, 1, 4 )			
		,( 1, 4, 11, 42, 2, 1, 5 )			
		,( 1, 4, 11, 42, 2, 1, 6 )			
		,( 1, 4, 11, 42, 2, 1, 7 )			
		,( 1, 4, 11, 42, 2, 1, 8 )			
		,( 1, 4, 11, 42, 2, 1, 9 )			
		,( 1, 4, 11, 42, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 42, 3, 1, 1 )				
		,( 1, 4, 11, 42, 3, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 3, Week: 1
		,( 1, 4, 11, 42, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 11, 42, 3, 1, 4 )			
		,( 1, 4, 11, 42, 3, 1, 5 )			
		,( 1, 4, 11, 42, 3, 1, 6 )			
		,( 1, 4, 11, 42, 3, 1, 7 )			
		,( 1, 4, 11, 42, 3, 1, 8 )			
		,( 1, 4, 11, 42, 3, 1, 9 )			
		,( 1, 4, 11, 42, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 42, 4, 2, 1 )				
		,( 1, 4, 11, 42, 4, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 4, Week: 2
		,( 1, 4, 11, 42, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 11, 42, 4, 2, 4 )			
		,( 1, 4, 11, 42, 4, 2, 5 )			
		,( 1, 4, 11, 42, 4, 2, 6 )			
		,( 1, 4, 11, 42, 4, 2, 7 )			
		,( 1, 4, 11, 42, 4, 2, 8 )			
		,( 1, 4, 11, 42, 4, 2, 9 )			
		,( 1, 4, 11, 42, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 42, 5, 2, 1 )				
		,( 1, 4, 11, 42, 5, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 5, Week: 2
		,( 1, 4, 11, 42, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 11, 42, 5, 2, 4 )			
		,( 1, 4, 11, 42, 5, 2, 5 )			
		,( 1, 4, 11, 42, 5, 2, 6 )			
		,( 1, 4, 11, 42, 5, 2, 7 )			
		,( 1, 4, 11, 42, 5, 2, 8 )			
		,( 1, 4, 11, 42, 5, 2, 9 )			
		,( 1, 4, 11, 42, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 42, 6, 2, 1 )				
		,( 1, 4, 11, 42, 6, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 6, Week: 2
		,( 1, 4, 11, 42, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 11, 42, 6, 2, 4 )			
		,( 1, 4, 11, 42, 6, 2, 5 )			
		,( 1, 4, 11, 42, 6, 2, 6 )			
		,( 1, 4, 11, 42, 6, 2, 7 )			
		,( 1, 4, 11, 42, 6, 2, 8 )			
		,( 1, 4, 11, 42, 6, 2, 9 )			
		,( 1, 4, 11, 42, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 43, 1, 1, 1 )				
		,( 1, 4, 11, 43, 1, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 1, Week: 1
		,( 1, 4, 11, 43, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 11, 43, 1, 1, 4 )			
		,( 1, 4, 11, 43, 1, 1, 5 )			
		,( 1, 4, 11, 43, 1, 1, 6 )			
		,( 1, 4, 11, 43, 1, 1, 7 )			
		,( 1, 4, 11, 43, 1, 1, 8 )			
		,( 1, 4, 11, 43, 1, 1, 9 )			
		,( 1, 4, 11, 43, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 43, 2, 1, 1 )				
		,( 1, 4, 11, 43, 2, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 2, Week: 1
		,( 1, 4, 11, 43, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 11, 43, 2, 1, 4 )			
		,( 1, 4, 11, 43, 2, 1, 5 )			
		,( 1, 4, 11, 43, 2, 1, 6 )			
		,( 1, 4, 11, 43, 2, 1, 7 )			
		,( 1, 4, 11, 43, 2, 1, 8 )			
		,( 1, 4, 11, 43, 2, 1, 9 )			
		,( 1, 4, 11, 43, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 43, 3, 1, 1 )				
		,( 1, 4, 11, 43, 3, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 3, Week: 1
		,( 1, 4, 11, 43, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 11, 43, 3, 1, 4 )			
		,( 1, 4, 11, 43, 3, 1, 5 )			
		,( 1, 4, 11, 43, 3, 1, 6 )			
		,( 1, 4, 11, 43, 3, 1, 7 )			
		,( 1, 4, 11, 43, 3, 1, 8 )			
		,( 1, 4, 11, 43, 3, 1, 9 )			
		,( 1, 4, 11, 43, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 43, 4, 2, 1 )				
		,( 1, 4, 11, 43, 4, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 4, Week: 2
		,( 1, 4, 11, 43, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 11, 43, 4, 2, 4 )			
		,( 1, 4, 11, 43, 4, 2, 5 )			
		,( 1, 4, 11, 43, 4, 2, 6 )			
		,( 1, 4, 11, 43, 4, 2, 7 )			
		,( 1, 4, 11, 43, 4, 2, 8 )			
		,( 1, 4, 11, 43, 4, 2, 9 )			
		,( 1, 4, 11, 43, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 43, 5, 2, 1 )				
		,( 1, 4, 11, 43, 5, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 5, Week: 2
		,( 1, 4, 11, 43, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 11, 43, 5, 2, 4 )			
		,( 1, 4, 11, 43, 5, 2, 5 )			
		,( 1, 4, 11, 43, 5, 2, 6 )			
		,( 1, 4, 11, 43, 5, 2, 7 )			
		,( 1, 4, 11, 43, 5, 2, 8 )			
		,( 1, 4, 11, 43, 5, 2, 9 )			
		,( 1, 4, 11, 43, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 43, 6, 2, 1 )				
		,( 1, 4, 11, 43, 6, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 6, Week: 2
		,( 1, 4, 11, 43, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 11, 43, 6, 2, 4 )			
		,( 1, 4, 11, 43, 6, 2, 5 )			
		,( 1, 4, 11, 43, 6, 2, 6 )			
		,( 1, 4, 11, 43, 6, 2, 7 )			
		,( 1, 4, 11, 43, 6, 2, 8 )			
		,( 1, 4, 11, 43, 6, 2, 9 )			
		,( 1, 4, 11, 43, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 44, 1, 1, 1 )				
		,( 1, 4, 11, 44, 1, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 1, Week: 1
		,( 1, 4, 11, 44, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 11, 44, 1, 1, 4 )			
		,( 1, 4, 11, 44, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 4, 11, 44, 1, 1, 6 )			-- different player same everything else
		,( 1, 4, 11, 44, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 4, 11, 44, 1, 1, 8 )			
		,( 1, 4, 11, 44, 1, 1, 9 )			
		,( 1, 4, 11, 44, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 44, 2, 1, 1 )				
		,( 1, 4, 11, 44, 2, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 2, Week: 1
		,( 1, 4, 11, 44, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 11, 44, 2, 1, 4 )			
		,( 1, 4, 11, 44, 2, 1, 5 )			
		,( 1, 4, 11, 44, 2, 1, 6 )			
		,( 1, 4, 11, 44, 2, 1, 7 )			
		,( 1, 4, 11, 44, 2, 1, 8 )			
		,( 1, 4, 11, 44, 2, 1, 9 )			
		,( 1, 4, 11, 44, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 44, 3, 1, 1 )				
		,( 1, 4, 11, 44, 3, 1, 2 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 3, Week: 1
		,( 1, 4, 11, 44, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 11, 44, 3, 1, 4 )			
		,( 1, 4, 11, 44, 3, 1, 5 )			
		,( 1, 4, 11, 44, 3, 1, 6 )			
		,( 1, 4, 11, 44, 3, 1, 7 )			
		,( 1, 4, 11, 44, 3, 1, 8 )			
		,( 1, 4, 11, 44, 3, 1, 9 )			
		,( 1, 4, 11, 44, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 44, 4, 2, 1 )				
		,( 1, 4, 11, 44, 4, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 4, Week: 2
		,( 1, 4, 11, 44, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 11, 44, 4, 2, 4 )			
		,( 1, 4, 11, 44, 4, 2, 5 )			
		,( 1, 4, 11, 44, 4, 2, 6 )			
		,( 1, 4, 11, 44, 4, 2, 7 )			
		,( 1, 4, 11, 44, 4, 2, 8 )			
		,( 1, 4, 11, 44, 4, 2, 9 )			
		,( 1, 4, 11, 44, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 44, 5, 2, 1 )				
		,( 1, 4, 11, 44, 5, 2, 2 )			-- Year 2011, League:4, Team: 11, Player: 44, Game: 5, Week: 2
		,( 1, 4, 11, 44, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 11, 44, 5, 2, 4 )			
		,( 1, 4, 11, 44, 5, 2, 5 )			
		,( 1, 4, 11, 44, 5, 2, 6 )			
		,( 1, 4, 11, 44, 5, 2, 7 )			
		,( 1, 4, 11, 44, 5, 2, 8 )			
		,( 1, 4, 11, 44, 5, 2, 9 )			
		,( 1, 4, 11, 44, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 11, 44, 6, 2, 1 )				
		,( 1, 4, 11, 44, 6, 2, 2 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 6, Week: 2
		,( 1, 4, 11, 44, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 11, 44, 6, 2, 4 )			
		,( 1, 4, 11, 44, 6, 2, 5 )			
		,( 1, 4, 11, 44, 6, 2, 6 )			
		,( 1, 4, 11, 44, 6, 2, 7 )			
		,( 1, 4, 11, 44, 6, 2, 8 )			
		,( 1, 4, 11, 44, 6, 2, 9 )			
		,( 1, 4, 11, 44, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 45, 1, 1, 1 )				
		,( 1, 4, 12, 45, 1, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 1, Week: 1
		,( 1, 4, 12, 45, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 12, 45, 1, 1, 4 )			
		,( 1, 4, 12, 45, 1, 1, 5 )			
		,( 1, 4, 12, 45, 1, 1, 6 )			
		,( 1, 4, 12, 45, 1, 1, 7 )			
		,( 1, 4, 12, 45, 1, 1, 8 )			
		,( 1, 4, 12, 45, 1, 1, 9 )			
		,( 1, 4, 12, 45, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 45, 2, 1, 1 )				
		,( 1, 4, 12, 45, 2, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 2, Week: 1
		,( 1, 4, 12, 45, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 12, 45, 2, 1, 4 )			
		,( 1, 4, 12, 45, 2, 1, 5 )			
		,( 1, 4, 12, 45, 2, 1, 6 )			
		,( 1, 4, 12, 45, 2, 1, 7 )			
		,( 1, 4, 12, 45, 2, 1, 8 )			
		,( 1, 4, 12, 45, 2, 1, 9 )			
		,( 1, 4, 12, 45, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 45, 3, 1, 1 )				
		,( 1, 4, 12, 45, 3, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 3, Week: 1
		,( 1, 4, 12, 45, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 12, 45, 3, 1, 4 )			
		,( 1, 4, 12, 45, 3, 1, 5 )			
		,( 1, 4, 12, 45, 3, 1, 6 )			
		,( 1, 4, 12, 45, 3, 1, 7 )			
		,( 1, 4, 12, 45, 3, 1, 8 )			
		,( 1, 4, 12, 45, 3, 1, 9 )			
		,( 1, 4, 12, 45, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 45, 4, 2, 1 )				
		,( 1, 4, 12, 45, 4, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 4, Week: 2
		,( 1, 4, 12, 45, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 12, 45, 4, 2, 4 )			
		,( 1, 4, 12, 45, 4, 2, 5 )			
		,( 1, 4, 12, 45, 4, 2, 6 )			
		,( 1, 4, 12, 45, 4, 2, 7 )			
		,( 1, 4, 12, 45, 4, 2, 8 )			
		,( 1, 4, 12, 45, 4, 2, 9 )			
		,( 1, 4, 12, 45, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 45, 5, 2, 1 )				
		,( 1, 4, 12, 45, 5, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 5, Week: 2
		,( 1, 4, 12, 45, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 12, 45, 5, 2, 4 )			
		,( 1, 4, 12, 45, 5, 2, 5 )			
		,( 1, 4, 12, 45, 5, 2, 6 )			
		,( 1, 4, 12, 45, 5, 2, 7 )			
		,( 1, 4, 12, 45, 5, 2, 8 )			
		,( 1, 4, 12, 45, 5, 2, 9 )			
		,( 1, 4, 12, 45, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 45, 6, 2, 1 )				
		,( 1, 4, 12, 45, 6, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 6, Week: 2
		,( 1, 4, 12, 45, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 12, 45, 6, 2, 4 )			
		,( 1, 4, 12, 45, 6, 2, 5 )			
		,( 1, 4, 12, 45, 6, 2, 6 )			
		,( 1, 4, 12, 45, 6, 2, 7 )			
		,( 1, 4, 12, 45, 6, 2, 8 )			
		,( 1, 4, 12, 45, 6, 2, 9 )			
		,( 1, 4, 12, 45, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 46, 1, 1, 1 )				
		,( 1, 4, 12, 46, 1, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 1, Week: 1
		,( 1, 4, 12, 46, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 12, 46, 1, 1, 4 )			
		,( 1, 4, 12, 46, 1, 1, 5 )			
		,( 1, 4, 12, 46, 1, 1, 6 )			
		,( 1, 4, 12, 46, 1, 1, 7 )			
		,( 1, 4, 12, 46, 1, 1, 8 )			
		,( 1, 4, 12, 46, 1, 1, 9 )			
		,( 1, 4, 12, 46, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 46, 2, 1, 1 )				
		,( 1, 4, 12, 46, 2, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 2, Week: 1
		,( 1, 4, 12, 46, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 12, 46, 2, 1, 4 )			
		,( 1, 4, 12, 46, 2, 1, 5 )			
		,( 1, 4, 12, 46, 2, 1, 6 )			
		,( 1, 4, 12, 46, 2, 1, 7 )			
		,( 1, 4, 12, 46, 2, 1, 8 )			
		,( 1, 4, 12, 46, 2, 1, 9 )			
		,( 1, 4, 12, 46, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 46, 3, 1, 1 )				
		,( 1, 4, 12, 46, 3, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 3, Week: 1
		,( 1, 4, 12, 46, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 12, 46, 3, 1, 4 )			
		,( 1, 4, 12, 46, 3, 1, 5 )			
		,( 1, 4, 12, 46, 3, 1, 6 )			
		,( 1, 4, 12, 46, 3, 1, 7 )			
		,( 1, 4, 12, 46, 3, 1, 8 )			
		,( 1, 4, 12, 46, 3, 1, 9 )			
		,( 1, 4, 12, 46, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 46, 4, 2, 1 )				
		,( 1, 4, 12, 46, 4, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 4, Week: 2
		,( 1, 4, 12, 46, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 12, 46, 4, 2, 4 )			
		,( 1, 4, 12, 46, 4, 2, 5 )			
		,( 1, 4, 12, 46, 4, 2, 6 )			
		,( 1, 4, 12, 46, 4, 2, 7 )			
		,( 1, 4, 12, 46, 4, 2, 8 )			
		,( 1, 4, 12, 46, 4, 2, 9 )			
		,( 1, 4, 12, 46, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 46, 5, 2, 1 )				
		,( 1, 4, 12, 46, 5, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 5, Week: 2
		,( 1, 4, 12, 46, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 12, 46, 5, 2, 4 )			
		,( 1, 4, 12, 46, 5, 2, 5 )			
		,( 1, 4, 12, 46, 5, 2, 6 )			
		,( 1, 4, 12, 46, 5, 2, 7 )			
		,( 1, 4, 12, 46, 5, 2, 8 )			
		,( 1, 4, 12, 46, 5, 2, 9 )			
		,( 1, 4, 12, 46, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 46, 6, 2, 1 )				
		,( 1, 4, 12, 46, 6, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 6, Week: 2
		,( 1, 4, 12, 46, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 12, 46, 6, 2, 4 )			
		,( 1, 4, 12, 46, 6, 2, 5 )			
		,( 1, 4, 12, 46, 6, 2, 6 )			
		,( 1, 4, 12, 46, 6, 2, 7 )			
		,( 1, 4, 12, 46, 6, 2, 8 )			
		,( 1, 4, 12, 46, 6, 2, 9 )			
		,( 1, 4, 12, 46, 6, 2, 10 )			

INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 47, 1, 1, 1 )				
		,( 1, 4, 12, 47, 1, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 1, Week: 1
		,( 1, 4, 12, 47, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 12, 47, 1, 1, 4 )			
		,( 1, 4, 12, 47, 1, 1, 5 )			
		,( 1, 4, 12, 47, 1, 1, 6 )			
		,( 1, 4, 12, 47, 1, 1, 7 )			
		,( 1, 4, 12, 47, 1, 1, 8 )			
		,( 1, 4, 12, 47, 1, 1, 9 )			
		,( 1, 4, 12, 47, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 47, 2, 1, 1 )				
		,( 1, 4, 12, 47, 2, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 2, Week: 1
		,( 1, 4, 12, 47, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 12, 47, 2, 1, 4 )			
		,( 1, 4, 12, 47, 2, 1, 5 )			
		,( 1, 4, 12, 47, 2, 1, 6 )			
		,( 1, 4, 12, 47, 2, 1, 7 )			
		,( 1, 4, 12, 47, 2, 1, 8 )			
		,( 1, 4, 12, 47, 2, 1, 9 )			
		,( 1, 4, 12, 47, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 47, 3, 1, 1 )				
		,( 1, 4, 12, 47, 3, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 3, Week: 1
		,( 1, 4, 12, 47, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 12, 47, 3, 1, 4 )			
		,( 1, 4, 12, 47, 3, 1, 5 )			
		,( 1, 4, 12, 47, 3, 1, 6 )			
		,( 1, 4, 12, 47, 3, 1, 7 )			
		,( 1, 4, 12, 47, 3, 1, 8 )			
		,( 1, 4, 12, 47, 3, 1, 9 )			
		,( 1, 4, 12, 47, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 47, 4, 2, 1 )				
		,( 1, 4, 12, 47, 4, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 4, Week: 2
		,( 1, 4, 12, 47, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 12, 47, 4, 2, 4 )			
		,( 1, 4, 12, 47, 4, 2, 5 )			
		,( 1, 4, 12, 47, 4, 2, 6 )			
		,( 1, 4, 12, 47, 4, 2, 7 )			
		,( 1, 4, 12, 47, 4, 2, 8 )			
		,( 1, 4, 12, 47, 4, 2, 9 )			
		,( 1, 4, 12, 47, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 47, 5, 2, 1 )				
		,( 1, 4, 12, 47, 5, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 5, Week: 2
		,( 1, 4, 12, 47, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 12, 47, 5, 2, 4 )			
		,( 1, 4, 12, 47, 5, 2, 5 )			
		,( 1, 4, 12, 47, 5, 2, 6 )			
		,( 1, 4, 12, 47, 5, 2, 7 )			
		,( 1, 4, 12, 47, 5, 2, 8 )			
		,( 1, 4, 12, 47, 5, 2, 9 )			
		,( 1, 4, 12, 47, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 47, 6, 2, 1 )				
		,( 1, 4, 12, 47, 6, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 6, Week: 2
		,( 1, 4, 12, 47, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 12, 47, 6, 2, 4 )			
		,( 1, 4, 12, 47, 6, 2, 5 )			
		,( 1, 4, 12, 47, 6, 2, 6 )			
		,( 1, 4, 12, 47, 6, 2, 7 )			
		,( 1, 4, 12, 47, 6, 2, 8 )			
		,( 1, 4, 12, 47, 6, 2, 9 )			
		,( 1, 4, 12, 47, 6, 2, 10 )			
	
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 48, 1, 1, 1 )				
		,( 1, 4, 12, 48, 1, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 1, Week: 1
		,( 1, 4, 12, 48, 1, 1, 3 )			-- No spares and no strikes
		,( 1, 4, 12, 48, 1, 1, 4 )			
		,( 1, 4, 12, 48, 1, 1, 5 )			-- Repeat of above BUT
		,( 1, 4, 12, 48, 1, 1, 6 )			-- different player same everything else
		,( 1, 4, 12, 48, 1, 1, 7 )			-- This will test to make sure our scoring works on the player level
		,( 1, 4, 12, 48, 1, 1, 8 )			
		,( 1, 4, 12, 48, 1, 1, 9 )			
		,( 1, 4, 12, 48, 1, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 48, 2, 1, 1 )				
		,( 1, 4, 12, 48, 2, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 2, Week: 1
		,( 1, 4, 12, 48, 2, 1, 3 )			-- Some spares and no strikes
		,( 1, 4, 12, 48, 2, 1, 4 )			
		,( 1, 4, 12, 48, 2, 1, 5 )			
		,( 1, 4, 12, 48, 2, 1, 6 )			
		,( 1, 4, 12, 48, 2, 1, 7 )			
		,( 1, 4, 12, 48, 2, 1, 8 )			
		,( 1, 4, 12, 48, 2, 1, 9 )			
		,( 1, 4, 12, 48, 2, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 48, 3, 1, 1 )				
		,( 1, 4, 12, 48, 3, 1, 2 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 3, Week: 1
		,( 1, 4, 12, 48, 3, 1, 3 )			-- All spares and no strikes
		,( 1, 4, 12, 48, 3, 1, 4 )			
		,( 1, 4, 12, 48, 3, 1, 5 )			
		,( 1, 4, 12, 48, 3, 1, 6 )			
		,( 1, 4, 12, 48, 3, 1, 7 )			
		,( 1, 4, 12, 48, 3, 1, 8 )			
		,( 1, 4, 12, 48, 3, 1, 9 )			
		,( 1, 4, 12, 48, 3, 1, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 48, 4, 2, 1 )				
		,( 1, 4, 12, 48, 4, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 4, Week: 2
		,( 1, 4, 12, 48, 4, 2, 3 )			-- No spares and some strikes
		,( 1, 4, 12, 48, 4, 2, 4 )			
		,( 1, 4, 12, 48, 4, 2, 5 )			
		,( 1, 4, 12, 48, 4, 2, 6 )			
		,( 1, 4, 12, 48, 4, 2, 7 )			
		,( 1, 4, 12, 48, 4, 2, 8 )			
		,( 1, 4, 12, 48, 4, 2, 9 )			
		,( 1, 4, 12, 48, 4, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 48, 5, 2, 1 )				
		,( 1, 4, 12, 48, 5, 2, 2 )			-- Year 2011, League:4, Team: 12, Player: 48, Game: 5, Week: 2
		,( 1, 4, 12, 48, 5, 2, 3 )			-- No spares and all strikes
		,( 1, 4, 12, 48, 5, 2, 4 )			
		,( 1, 4, 12, 48, 5, 2, 5 )			
		,( 1, 4, 12, 48, 5, 2, 6 )			
		,( 1, 4, 12, 48, 5, 2, 7 )			
		,( 1, 4, 12, 48, 5, 2, 8 )			
		,( 1, 4, 12, 48, 5, 2, 9 )			
		,( 1, 4, 12, 48, 5, 2, 10 )			
					
INSERT INTO TPlayerGameFrames ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameIndex )					
VALUES	 ( 1, 4, 12, 48, 6, 2, 1 )				
		,( 1, 4, 12, 48, 6, 2, 2 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 6, Week: 2
		,( 1, 4, 12, 48, 6, 2, 3 )			-- Some spares and some strikes
		,( 1, 4, 12, 48, 6, 2, 4 )			
		,( 1, 4, 12, 48, 6, 2, 5 )			
		,( 1, 4, 12, 48, 6, 2, 6 )			
		,( 1, 4, 12, 48, 6, 2, 7 )			
		,( 1, 4, 12, 48, 6, 2, 8 )			
		,( 1, 4, 12, 48, 6, 2, 9 )			
		,( 1, 4, 12, 48, 6, 2, 10 )			


					
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 1, 1, 1, 1, 1, 3 )					
		,( 1, 1, 1, 1, 1, 1, 1, 2, 4 )				
		,( 1, 1, 1, 1, 1, 1, 2, 1, 3 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 1, 1, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 1, 1, 1, 1, 1, 3, 1, 3 )				
		,( 1, 1, 1, 1, 1, 1, 3, 2, 4 )				
		,( 1, 1, 1, 1, 1, 1, 4, 1, 3 )				
		,( 1, 1, 1, 1, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 1, 1, 1, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 1, 1, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 1, 1, 1, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 1, 1, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 1, 1, 1, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 1, 1, 1, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 1, 1, 1, 1, 1, 8, 1, 3 )				 
		,( 1, 1, 1, 1, 1, 1, 8, 2, 4 )				
		,( 1, 1, 1, 1, 1, 1, 9, 1, 3 )				
		,( 1, 1, 1, 1, 1, 1, 9, 2, 4 )				
		,( 1, 1, 1, 1, 1, 1, 10, 1, 3 )				
		,( 1, 1, 1, 1, 1, 1, 10, 2, 4 )				
		,( 1, 1, 1, 1, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 1, 2, 1, 1, 1, 3 )					
		,( 1, 1, 1, 1, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 1, 1, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 1, 1, 2, 1, 2, 2, 2 )				
		,( 1, 1, 1, 1, 2, 1, 3, 1, 3 )				
		,( 1, 1, 1, 1, 2, 1, 3, 2, 7 )				
		,( 1, 1, 1, 1, 2, 1, 4, 1, 3 )				
		,( 1, 1, 1, 1, 2, 1, 4, 2, 2 )				
		,( 1, 1, 1, 1, 2, 1, 5, 1, 3 )				
		,( 1, 1, 1, 1, 2, 1, 5, 2, '' )				
		,( 1, 1, 1, 1, 2, 1, 6, 1, 6 )				
		,( 1, 1, 1, 1, 2, 1, 6, 2, 4 )				
		,( 1, 1, 1, 1, 2, 1, 7, 1, 3 )				
		,( 1, 1, 1, 1, 2, 1, 7, 2, 4 )				
		,( 1, 1, 1, 1, 2, 1, 8, 1, '' )				
		,( 1, 1, 1, 1, 2, 1, 8, 2, 4 )				
		,( 1, 1, 1, 1, 2, 1, 9, 1, 3 )				
		,( 1, 1, 1, 1, 2, 1, 9, 2, 7 )				
		,( 1, 1, 1, 1, 2, 1, 10, 1, 1 )				
		,( 1, 1, 1, 1, 2, 1, 10, 2, 1 )				
		,( 1, 1, 1, 1, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 1, 3, 1, 1, 1, 3 )					
		,( 1, 1, 1, 1, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game: 3, Week: 1,Total score: 128	
		,( 1, 1, 1, 1, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 1, 1, 3, 1, 2, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 3, 1, 3 )				
		,( 1, 1, 1, 1, 3, 1, 3, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 4, 1, 3 )				
		,( 1, 1, 1, 1, 3, 1, 4, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 5, 1, 3 )				
		,( 1, 1, 1, 1, 3, 1, 5, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 6, 1, 3 )				
		,( 1, 1, 1, 1, 3, 1, 6, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 7, 1, 3 )				
		,( 1, 1, 1, 1, 3, 1, 7, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 8, 1, 3 )				
		,( 1, 1, 1, 1, 3, 1, 8, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 9, 1, 3 )				
		,( 1, 1, 1, 1, 3, 1, 9, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 10, 1, 3 )				
		,( 1, 1, 1, 1, 3, 1, 10, 2, 7 )				
		,( 1, 1, 1, 1, 3, 1, 10, 3, 1 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 1, 4, 2, 1, 1, 10 )					
		,( 1, 1, 1, 1, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 1, Player: 1, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 1, 1, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 1, 1, 4, 2, 2, 2, 5 )				
		,( 1, 1, 1, 1, 4, 2, 3, 1, 10 )				
		,( 1, 1, 1, 1, 4, 2, 3, 2, '' )				
		,( 1, 1, 1, 1, 4, 2, 4, 1, 5 )				
		,( 1, 1, 1, 1, 4, 2, 4, 2, 3 )				
		,( 1, 1, 1, 1, 4, 2, 5, 1, 2 )				
		,( 1, 1, 1, 1, 4, 2, 5, 2, '' )				
		,( 1, 1, 1, 1, 4, 2, 6, 1, 3 )				
		,( 1, 1, 1, 1, 4, 2, 6, 2, 2 )				
		,( 1, 1, 1, 1, 4, 2, 7, 1, 10 )				
		,( 1, 1, 1, 1, 4, 2, 7, 2, '' )				
		,( 1, 1, 1, 1, 4, 2, 8, 1, '' )				
		,( 1, 1, 1, 1, 4, 2, 8, 2, '' )				
		,( 1, 1, 1, 1, 4, 2, 9, 1, '' )				
		,( 1, 1, 1, 1, 4, 2, 9, 2, '' )				
		,( 1, 1, 1, 1, 4, 2, 10, 1, 4 )				
		,( 1, 1, 1, 1, 4, 2, 10, 2, 6 )				
		,( 1, 1, 1, 1, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 1, 5, 2, 1, 1, 10 )					
		,( 1, 1, 1, 1, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 1, Player: 1, Game:5, Week: 2,Total score: 300	
		,( 1, 1, 1, 1, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 1, 1, 5, 2, 2, 2, '' )				
		,( 1, 1, 1, 1, 5, 2, 3, 1, 10 )				
		,( 1, 1, 1, 1, 5, 2, 3, 2, '' )				
 		,( 1, 1, 1, 1, 5, 2, 4, 1, 10 )				
		,( 1, 1, 1, 1, 5, 2, 4, 2, '' )				
		,( 1, 1, 1, 1, 5, 2, 5, 1, 10 )				
		,( 1, 1, 1, 1, 5, 2, 5, 2, '' )				
		,( 1, 1, 1, 1, 5, 2, 6, 1, 10 )				
		,( 1, 1, 1, 1, 5, 2, 6, 2, '' )				
		,( 1, 1, 1, 1, 5, 2, 7, 1, 10 )				
		,( 1, 1, 1, 1, 5, 2, 7, 2, '' )				
		,( 1, 1, 1, 1, 5, 2, 8, 1, 10 )				
		,( 1, 1, 1, 1, 5, 2, 8, 2, '' )				
		,( 1, 1, 1, 1, 5, 2, 9, 1, 10 )				
		,( 1, 1, 1, 1, 5, 2, 9, 2, '' )				
		,( 1, 1, 1, 1, 5, 2, 10, 1, 10 )				
		,( 1, 1, 1, 1, 5, 2, 10, 2, 10 )				
		,( 1, 1, 1, 1, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 1, 6, 2, 1, 1, 3 )					
		,( 1, 1, 1, 1, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 1, Player: 1, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 1, 1, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 1, 1, 6, 2, 2, 2, 7 )				
		,( 1, 1, 1, 1, 6, 2, 3, 1, 3 )				
		,( 1, 1, 1, 1, 6, 2, 3, 2, 7 )				
		,( 1, 1, 1, 1, 6, 2, 4, 1, 1 )				
		,( 1, 1, 1, 1, 6, 2, 4, 2, 2 )				
		,( 1, 1, 1, 1, 6, 2, 5, 1, 10 )				
		,( 1, 1, 1, 1, 6, 2, 5, 2, '' )				
		,( 1, 1, 1, 1, 6, 2, 6, 1, 10 )				
		,( 1, 1, 1, 1, 6, 2, 6, 2, '' )				
		,( 1, 1, 1, 1, 6, 2, 7, 1, 3 )				
		,( 1, 1, 1, 1, 6, 2, 7, 2, 7 )				
		,( 1, 1, 1, 1, 6, 2, 8, 1, 3 )				
		,( 1, 1, 1, 1, 6, 2, 8, 2, 7 )				
		,( 1, 1, 1, 1, 6, 2, 9, 1, 3 )				
		,( 1, 1, 1, 1, 6, 2, 9, 2, 6 )				
		,( 1, 1, 1, 1, 6, 2, 10, 1, 10 )				
		,( 1, 1, 1, 1, 6, 2, 10, 2, 10 )				
		,( 1, 1, 1, 1, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 2, 1, 1, 1, 1, 3 )					
		,( 1, 1, 1, 2, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 1, 2, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 1, 2, 1, 1, 2, 2, 4 )				
		,( 1, 1, 1, 2, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 1, 2, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 1, 2, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 1, 2, 1, 1, 4, 2, 4 )				
		,( 1, 1, 1, 2, 1, 1, 5, 1, 3 )				
		,( 1, 1, 1, 2, 1, 1, 5, 2, 4 )				
		,( 1, 1, 1, 2, 1, 1, 6, 1, 3 )				
		,( 1, 1, 1, 2, 1, 1, 6, 2, 4 )				
		,( 1, 1, 1, 2, 1, 1, 7, 1, 3 )				
		,( 1, 1, 1, 2, 1, 1, 7, 2, 4 )				
		,( 1, 1, 1, 2, 1, 1, 8, 1, 3 )				
		,( 1, 1, 1, 2, 1, 1, 8, 2, 4 )				
		,( 1, 1, 1, 2, 1, 1, 9, 1, 3 )				
		,( 1, 1, 1, 2, 1, 1, 9, 2, 4 )				
		,( 1, 1, 1, 2, 1, 1, 10, 1, 3 )				
		,( 1, 1, 1, 2, 1, 1, 10, 2, 4 )				
		,( 1, 1, 1, 2, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 2, 2, 1, 1, 1, 3 )					
		,( 1, 1, 1, 2, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 1, 2, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 1, 2, 2, 1, 2, 2, 2 )				
		,( 1, 1, 1, 2, 2, 1, 3, 1, 3 )				
		,( 1, 1, 1, 2, 2, 1, 3, 2, 7 )				
		,( 1, 1, 1, 2, 2, 1, 4, 1, 3 )				
		,( 1, 1, 1, 2, 2, 1, 4, 2, 2 )				
		,( 1, 1, 1, 2, 2, 1, 5, 1, 3 )				
		,( 1, 1, 1, 2, 2, 1, 5, 2, '' )				
		,( 1, 1, 1, 2, 2, 1, 6, 1, 6 )				
		,( 1, 1, 1, 2, 2, 1, 6, 2, 4 )				
		,( 1, 1, 1, 2, 2, 1, 7, 1, 3 )				
		,( 1, 1, 1, 2, 2, 1, 7, 2, 4 )				
		,( 1, 1, 1, 2, 2, 1, 8, 1, '' )				
		,( 1, 1, 1, 2, 2, 1, 8, 2, 4 )				
		,( 1, 1, 1, 2, 2, 1, 9, 1, 3 )				
		,( 1, 1, 1, 2, 2, 1, 9, 2, 7 )				
		,( 1, 1, 1, 2, 2, 1, 10, 1, 1 )				
		,( 1, 1, 1, 2, 2, 1, 10, 2, 1 )				
		,( 1, 1, 1, 2, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 2, 3, 1, 1, 1, 3 )					
		,( 1, 1, 1, 2, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 3, Week: 1,Total score: 130	
		,( 1, 1, 1, 2, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 1, 2, 3, 1, 2, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 3, 1, 3 )				
		,( 1, 1, 1, 2, 3, 1, 3, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 4, 1, 3 )				
		,( 1, 1, 1, 2, 3, 1, 4, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 5, 1, 3 )				
		,( 1, 1, 1, 2, 3, 1, 5, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 6, 1, 3 )				
		,( 1, 1, 1, 2, 3, 1, 6, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 7, 1, 3 )				
		,( 1, 1, 1, 2, 3, 1, 7, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 8, 1, 3 )				
		,( 1, 1, 1, 2, 3, 1, 8, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 9, 1, 3 )				
		,( 1, 1, 1, 2, 3, 1, 9, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 10, 1, 3 )				
		,( 1, 1, 1, 2, 3, 1, 10, 2, 7 )				
		,( 1, 1, 1, 2, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 2, 4, 2, 1, 1, 10 )					
		,( 1, 1, 1, 2, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 1, Player: 2, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 1, 2, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 1, 2, 4, 2, 2, 2, 5 )				
		,( 1, 1, 1, 2, 4, 2, 3, 1, 10 )				
		,( 1, 1, 1, 2, 4, 2, 3, 2, '' )				
		,( 1, 1, 1, 2, 4, 2, 4, 1, 5 )				
		,( 1, 1, 1, 2, 4, 2, 4, 2, 3 )				
		,( 1, 1, 1, 2, 4, 2, 5, 1, 2 )				
		,( 1, 1, 1, 2, 4, 2, 5, 2, '' )				
		,( 1, 1, 1, 2, 4, 2, 6, 1, 3 )				
		,( 1, 1, 1, 2, 4, 2, 6, 2, 2 )				
		,( 1, 1, 1, 2, 4, 2, 7, 1, 10 )				
		,( 1, 1, 1, 2, 4, 2, 7, 2, '' )				
		,( 1, 1, 1, 2, 4, 2, 8, 1, '' )				
		,( 1, 1, 1, 2, 4, 2, 8, 2, '' )				
		,( 1, 1, 1, 2, 4, 2, 9, 1, '' )				
		,( 1, 1, 1, 2, 4, 2, 9, 2, '' )				
		,( 1, 1, 1, 2, 4, 2, 10, 1, 4 )				
		,( 1, 1, 1, 2, 4, 2, 10, 2, 6 )				
		,( 1, 1, 1, 2, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 2, 5, 2, 1, 1, 10 )					
		,( 1, 1, 1, 2, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 1, 2, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 1, 2, 5, 2, 2, 2, '' )				
		,( 1, 1, 1, 2, 5, 2, 3, 1, 10 )				
		,( 1, 1, 1, 2, 5, 2, 3, 2, '' )				
		,( 1, 1, 1, 2, 5, 2, 4, 1, 10 )				
		,( 1, 1, 1, 2, 5, 2, 4, 2, '' )				
		,( 1, 1, 1, 2, 5, 2, 5, 1, 10 )				
		,( 1, 1, 1, 2, 5, 2, 5, 2, '' )				
		,( 1, 1, 1, 2, 5, 2, 6, 1, 10 )				
		,( 1, 1, 1, 2, 5, 2, 6, 2, '' )				
		,( 1, 1, 1, 2, 5, 2, 7, 1, 10 )				
		,( 1, 1, 1, 2, 5, 2, 7, 2, '' )				
		,( 1, 1, 1, 2, 5, 2, 8, 1, 10 )				
		,( 1, 1, 1, 2, 5, 2, 8, 2, '' )				
		,( 1, 1, 1, 2, 5, 2, 9, 1, 10 )				
		,( 1, 1, 1, 2, 5, 2, 9, 2, '' )				
		,( 1, 1, 1, 2, 5, 2, 10, 1, 10 )				
		,( 1, 1, 1, 2, 5, 2, 10, 2, 10 )				
		,( 1, 1, 1, 2, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 2, 6, 2, 1, 1, 3 )					
		,( 1, 1, 1, 2, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 1, Player: 2, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 1, 2, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 1, 2, 6, 2, 2, 2, 7 )				
		,( 1, 1, 1, 2, 6, 2, 3, 1, 3 )				
		,( 1, 1, 1, 2, 6, 2, 3, 2, 7 )				
		,( 1, 1, 1, 2, 6, 2, 4, 1, 1 )				
		,( 1, 1, 1, 2, 6, 2, 4, 2, 2 )				
		,( 1, 1, 1, 2, 6, 2, 5, 1, 10 )				
		,( 1, 1, 1, 2, 6, 2, 5, 2, '' )				
		,( 1, 1, 1, 2, 6, 2, 6, 1, 10 )				
		,( 1, 1, 1, 2, 6, 2, 6, 2, '' )				
		,( 1, 1, 1, 2, 6, 2, 7, 1, 3 )				
		,( 1, 1, 1, 2, 6, 2, 7, 2, 7 )				
		,( 1, 1, 1, 2, 6, 2, 8, 1, 3 )				
		,( 1, 1, 1, 2, 6, 2, 8, 2, 7 )				
		,( 1, 1, 1, 2, 6, 2, 9, 1, 3 )				
		,( 1, 1, 1, 2, 6, 2, 9, 2, 6 )				
		,( 1, 1, 1, 2, 6, 2, 10, 1, 10 )				
		,( 1, 1, 1, 2, 6, 2, 10, 2, 10 )				
		,( 1, 1, 1, 2, 6, 2, 10, 3, 10 )				
	
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 3, 1, 1, 1, 1, 3 )					
		,( 1, 1, 1, 3, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 1, 3, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 1, 3, 1, 1, 2, 2, 4 )				
		,( 1, 1, 1, 3, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 1, 3, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 1, 3, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 1, 3, 1, 1, 4, 2, 4 )				
		,( 1, 1, 1, 3, 1, 1, 5, 1, 3 )				
		,( 1, 1, 1, 3, 1, 1, 5, 2, 4 )				
		,( 1, 1, 1, 3, 1, 1, 6, 1, 3 )				
		,( 1, 1, 1, 3, 1, 1, 6, 2, 4 )				
		,( 1, 1, 1, 3, 1, 1, 7, 1, 3 )				
		,( 1, 1, 1, 3, 1, 1, 7, 2, 4 )				
		,( 1, 1, 1, 3, 1, 1, 8, 1, 3 )				
		,( 1, 1, 1, 3, 1, 1, 8, 2, 4 )				
		,( 1, 1, 1, 3, 1, 1, 9, 1, 3 )				
		,( 1, 1, 1, 3, 1, 1, 9, 2, 4 )				
		,( 1, 1, 1, 3, 1, 1, 10, 1, 3 )				
		,( 1, 1, 1, 3, 1, 1, 10, 2, 4 )				
		,( 1, 1, 1, 3, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 3, 2, 1, 1, 1, 3 )					
		,( 1, 1, 1, 3, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 1, 3, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 1, 3, 2, 1, 2, 2, 2 )				
		,( 1, 1, 1, 3, 2, 1, 3, 1, 3 )				
		,( 1, 1, 1, 3, 2, 1, 3, 2, 7 )				
		,( 1, 1, 1, 3, 2, 1, 4, 1, 3 )				
		,( 1, 1, 1, 3, 2, 1, 4, 2, 2 )				
		,( 1, 1, 1, 3, 2, 1, 5, 1, 3 )				
		,( 1, 1, 1, 3, 2, 1, 5, 2, '' )				
		,( 1, 1, 1, 3, 2, 1, 6, 1, 6 )				
		,( 1, 1, 1, 3, 2, 1, 6, 2, 4 )				
		,( 1, 1, 1, 3, 2, 1, 7, 1, 3 )				
		,( 1, 1, 1, 3, 2, 1, 7, 2, 4 )				
		,( 1, 1, 1, 3, 2, 1, 8, 1, '' )				
		,( 1, 1, 1, 3, 2, 1, 8, 2, 4 )				
		,( 1, 1, 1, 3, 2, 1, 9, 1, 3 )				
		,( 1, 1, 1, 3, 2, 1, 9, 2, 7 )				
		,( 1, 1, 1, 3, 2, 1, 10, 1, 1 )				
		,( 1, 1, 1, 3, 2, 1, 10, 2, 1 )				
		,( 1, 1, 1, 3, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 3, 3, 1, 1, 1, 3 )					
		,( 1, 1, 1, 3, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 3, Week: 1,Total score: 131	
		,( 1, 1, 1, 3, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 1, 3, 3, 1, 2, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 3, 1, 3 )				
		,( 1, 1, 1, 3, 3, 1, 3, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 4, 1, 3 )				
		,( 1, 1, 1, 3, 3, 1, 4, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 5, 1, 3 )				
		,( 1, 1, 1, 3, 3, 1, 5, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 6, 1, 3 )				
		,( 1, 1, 1, 3, 3, 1, 6, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 7, 1, 3 )				
		,( 1, 1, 1, 3, 3, 1, 7, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 8, 1, 3 )				
		,( 1, 1, 1, 3, 3, 1, 8, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 9, 1, 3 )				
		,( 1, 1, 1, 3, 3, 1, 9, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 10, 1, 3 )				
		,( 1, 1, 1, 3, 3, 1, 10, 2, 7 )				
		,( 1, 1, 1, 3, 3, 1, 10, 3, 4 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 3, 4, 2, 1, 1, 10 )					
		,( 1, 1, 1, 3, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 1, Player: 3, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 1, 3, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 1, 3, 4, 2, 2, 2, 5 )				
		,( 1, 1, 1, 3, 4, 2, 3, 1, 10 )				
		,( 1, 1, 1, 3, 4, 2, 3, 2, '' )				
		,( 1, 1, 1, 3, 4, 2, 4, 1, 5 )				
		,( 1, 1, 1, 3, 4, 2, 4, 2, 3 )				
		,( 1, 1, 1, 3, 4, 2, 5, 1, 2 )				
		,( 1, 1, 1, 3, 4, 2, 5, 2, '' )				
		,( 1, 1, 1, 3, 4, 2, 6, 1, 3 )				
		,( 1, 1, 1, 3, 4, 2, 6, 2, 2 )				
		,( 1, 1, 1, 3, 4, 2, 7, 1, 10 )				
		,( 1, 1, 1, 3, 4, 2, 7, 2, '' )				
		,( 1, 1, 1, 3, 4, 2, 8, 1, '' )				
		,( 1, 1, 1, 3, 4, 2, 8, 2, '' )				
		,( 1, 1, 1, 3, 4, 2, 9, 1, '' )				
		,( 1, 1, 1, 3, 4, 2, 9, 2, '' )				
		,( 1, 1, 1, 3, 4, 2, 10, 1, 4 )				
		,( 1, 1, 1, 3, 4, 2, 10, 2, 6 )				
		,( 1, 1, 1, 3, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 3, 5, 2, 1, 1, 10 )					
		,( 1, 1, 1, 3, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 1, 3, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 1, 3, 5, 2, 2, 2, '' )				
		,( 1, 1, 1, 3, 5, 2, 3, 1, 10 )				
		,( 1, 1, 1, 3, 5, 2, 3, 2, '' )				
		,( 1, 1, 1, 3, 5, 2, 4, 1, 10 )				
		,( 1, 1, 1, 3, 5, 2, 4, 2, '' )				
		,( 1, 1, 1, 3, 5, 2, 5, 1, 10 )				
		,( 1, 1, 1, 3, 5, 2, 5, 2, '' )				
		,( 1, 1, 1, 3, 5, 2, 6, 1, 10 )				
		,( 1, 1, 1, 3, 5, 2, 6, 2, '' )				
		,( 1, 1, 1, 3, 5, 2, 7, 1, 10 )				
		,( 1, 1, 1, 3, 5, 2, 7, 2, '' )				
		,( 1, 1, 1, 3, 5, 2, 8, 1, 10 )				
		,( 1, 1, 1, 3, 5, 2, 8, 2, '' )				
		,( 1, 1, 1, 3, 5, 2, 9, 1, 10 )				
		,( 1, 1, 1, 3, 5, 2, 9, 2, '' )				
		,( 1, 1, 1, 3, 5, 2, 10, 1, 10 )				
		,( 1, 1, 1, 3, 5, 2, 10, 2, 10 )				
		,( 1, 1, 1, 3, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 3, 6, 2, 1, 1, 3 )					
		,( 1, 1, 1, 3, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 1, Player: 3, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 1, 3, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 1, 3, 6, 2, 2, 2, 7 )				
		,( 1, 1, 1, 3, 6, 2, 3, 1, 3 )				
		,( 1, 1, 1, 3, 6, 2, 3, 2, 7 )				
		,( 1, 1, 1, 3, 6, 2, 4, 1, 1 )				
		,( 1, 1, 1, 3, 6, 2, 4, 2, 2 )				
		,( 1, 1, 1, 3, 6, 2, 5, 1, 10 )				
		,( 1, 1, 1, 3, 6, 2, 5, 2, '' )				
		,( 1, 1, 1, 3, 6, 2, 6, 1, 10 )				
		,( 1, 1, 1, 3, 6, 2, 6, 2, '' )				
		,( 1, 1, 1, 3, 6, 2, 7, 1, 3 )				
		,( 1, 1, 1, 3, 6, 2, 7, 2, 7 )				
		,( 1, 1, 1, 3, 6, 2, 8, 1, 3 )				
		,( 1, 1, 1, 3, 6, 2, 8, 2, 7 )				
		,( 1, 1, 1, 3, 6, 2, 9, 1, 3 )				
		,( 1, 1, 1, 3, 6, 2, 9, 2, 6 )				
		,( 1, 1, 1, 3, 6, 2, 10, 1, 10 )				
		,( 1, 1, 1, 3, 6, 2, 10, 2, 10 )				
		,( 1, 1, 1, 3, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 4, 1, 1, 1, 1, 3 )					
		,( 1, 1, 1, 4, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 1, 4, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 1, 4, 1, 1, 2, 2, 4 )				
		,( 1, 1, 1, 4, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 1, 4, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 1, 4, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 1, 4, 1, 1, 4, 2, 4 )				
		,( 1, 1, 1, 4, 1, 1, 5, 1, 3 )				
		,( 1, 1, 1, 4, 1, 1, 5, 2, 4 )				
		,( 1, 1, 1, 4, 1, 1, 6, 1, 3 )				
		,( 1, 1, 1, 4, 1, 1, 6, 2, 4 )				
		,( 1, 1, 1, 4, 1, 1, 7, 1, 3 )				
		,( 1, 1, 1, 4, 1, 1, 7, 2, 4 )				
		,( 1, 1, 1, 4, 1, 1, 8, 1, 3 )				
		,( 1, 1, 1, 4, 1, 1, 8, 2, 4 )				
		,( 1, 1, 1, 4, 1, 1, 9, 1, 3 )				
		,( 1, 1, 1, 4, 1, 1, 9, 2, 4 )				
		,( 1, 1, 1, 4, 1, 1, 10, 1, 3 )				
		,( 1, 1, 1, 4, 1, 1, 10, 2, 4 )				
		,( 1, 1, 1, 4, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 4, 2, 1, 1, 1, 3 )					
		,( 1, 1, 1, 4, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 1, 4, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 1, 4, 2, 1, 2, 2, 2 )				
		,( 1, 1, 1, 4, 2, 1, 3, 1, 3 )				
		,( 1, 1, 1, 4, 2, 1, 3, 2, 7 )				
		,( 1, 1, 1, 4, 2, 1, 4, 1, 3 )				
		,( 1, 1, 1, 4, 2, 1, 4, 2, 2 )				
		,( 1, 1, 1, 4, 2, 1, 5, 1, 3 )				
		,( 1, 1, 1, 4, 2, 1, 5, 2, '' )				
		,( 1, 1, 1, 4, 2, 1, 6, 1, 6 )				
		,( 1, 1, 1, 4, 2, 1, 6, 2, 4 )				
		,( 1, 1, 1, 4, 2, 1, 7, 1, 3 )				
		,( 1, 1, 1, 4, 2, 1, 7, 2, 4 )				
		,( 1, 1, 1, 4, 2, 1, 8, 1, '' )				
		,( 1, 1, 1, 4, 2, 1, 8, 2, 4 )				
		,( 1, 1, 1, 4, 2, 1, 9, 1, 3 )				
		,( 1, 1, 1, 4, 2, 1, 9, 2, 7 )				
		,( 1, 1, 1, 4, 2, 1, 10, 1, 1 )				
		,( 1, 1, 1, 4, 2, 1, 10, 2, 1 )				
		,( 1, 1, 1, 4, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 4, 3, 1, 1, 1, 3 )					
		,( 1, 1, 1, 4, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 3, Week: 1,Total score: 131	
		,( 1, 1, 1, 4, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 1, 4, 3, 1, 2, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 3, 1, 3 )				
		,( 1, 1, 1, 4, 3, 1, 3, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 4, 1, 3 )				
		,( 1, 1, 1, 4, 3, 1, 4, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 5, 1, 3 )				
		,( 1, 1, 1, 4, 3, 1, 5, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 6, 1, 3 )				
		,( 1, 1, 1, 4, 3, 1, 6, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 7, 1, 3 )				
		,( 1, 1, 1, 4, 3, 1, 7, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 8, 1, 3 )				
		,( 1, 1, 1, 4, 3, 1, 8, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 9, 1, 3 )				
		,( 1, 1, 1, 4, 3, 1, 9, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 10, 1, 3 )				
		,( 1, 1, 1, 4, 3, 1, 10, 2, 7 )				
		,( 1, 1, 1, 4, 3, 1, 10, 3, 4 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 4, 4, 2, 1, 1, 10 )					
		,( 1, 1, 1, 4, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 1, Player: 4, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 1, 4, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 1, 4, 4, 2, 2, 2, 5 )				
		,( 1, 1, 1, 4, 4, 2, 3, 1, 10 )				
		,( 1, 1, 1, 4, 4, 2, 3, 2, '' )				
		,( 1, 1, 1, 4, 4, 2, 4, 1, 5 )				
		,( 1, 1, 1, 4, 4, 2, 4, 2, 3 )				
		,( 1, 1, 1, 4, 4, 2, 5, 1, 2 )				
		,( 1, 1, 1, 4, 4, 2, 5, 2, '' )				
		,( 1, 1, 1, 4, 4, 2, 6, 1, 3 )				
		,( 1, 1, 1, 4, 4, 2, 6, 2, 2 )				
		,( 1, 1, 1, 4, 4, 2, 7, 1, 10 )				
		,( 1, 1, 1, 4, 4, 2, 7, 2, '' )				
		,( 1, 1, 1, 4, 4, 2, 8, 1, '' )				
		,( 1, 1, 1, 4, 4, 2, 8, 2, '' )				
		,( 1, 1, 1, 4, 4, 2, 9, 1, '' )				
		,( 1, 1, 1, 4, 4, 2, 9, 2, '' )				
		,( 1, 1, 1, 4, 4, 2, 10, 1, 4 )				
		,( 1, 1, 1, 4, 4, 2, 10, 2, 6 )				
		,( 1, 1, 1, 4, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 4, 5, 2, 1, 1, 10 )					
		,( 1, 1, 1, 4, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 1, 4, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 1, 4, 5, 2, 2, 2, '' )				
		,( 1, 1, 1, 4, 5, 2, 3, 1, 10 )				
		,( 1, 1, 1, 4, 5, 2, 3, 2, '' )				
		,( 1, 1, 1, 4, 5, 2, 4, 1, 10 )				
		,( 1, 1, 1, 4, 5, 2, 4, 2, '' )				
		,( 1, 1, 1, 4, 5, 2, 5, 1, 10 )				
		,( 1, 1, 1, 4, 5, 2, 5, 2, '' )				
		,( 1, 1, 1, 4, 5, 2, 6, 1, 10 )				
		,( 1, 1, 1, 4, 5, 2, 6, 2, '' )				
		,( 1, 1, 1, 4, 5, 2, 7, 1, 10 )				
		,( 1, 1, 1, 4, 5, 2, 7, 2, '' )				
		,( 1, 1, 1, 4, 5, 2, 8, 1, 10 )				
		,( 1, 1, 1, 4, 5, 2, 8, 2, '' )				
		,( 1, 1, 1, 4, 5, 2, 9, 1, 10 )				
		,( 1, 1, 1, 4, 5, 2, 9, 2, '' )				
		,( 1, 1, 1, 4, 5, 2, 10, 1, 10 )				
		,( 1, 1, 1, 4, 5, 2, 10, 2, 10 )				
		,( 1, 1, 1, 4, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 1, 4, 6, 2, 1, 1, 3 )					
		,( 1, 1, 1, 4, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 1, Player: 4, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 1, 4, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 1, 4, 6, 2, 2, 2, 7 )				
		,( 1, 1, 1, 4, 6, 2, 3, 1, 3 )				
		,( 1, 1, 1, 4, 6, 2, 3, 2, 7 )				
		,( 1, 1, 1, 4, 6, 2, 4, 1, 1 )				
		,( 1, 1, 1, 4, 6, 2, 4, 2, 2 )				
		,( 1, 1, 1, 4, 6, 2, 5, 1, 10 )				
		,( 1, 1, 1, 4, 6, 2, 5, 2, '' )				
		,( 1, 1, 1, 4, 6, 2, 6, 1, 10 )				
		,( 1, 1, 1, 4, 6, 2, 6, 2, '' )				
		,( 1, 1, 1, 4, 6, 2, 7, 1, 3 )				
		,( 1, 1, 1, 4, 6, 2, 7, 2, 7 )				
		,( 1, 1, 1, 4, 6, 2, 8, 1, 3 )				
		,( 1, 1, 1, 4, 6, 2, 8, 2, 7 )				
		,( 1, 1, 1, 4, 6, 2, 9, 1, 3 )				
		,( 1, 1, 1, 4, 6, 2, 9, 2, 6 )				
		,( 1, 1, 1, 4, 6, 2, 10, 1, 10 )				
		,( 1, 1, 1, 4, 6, 2, 10, 2, 10 )				
		,( 1, 1, 1, 4, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 5, 1, 1, 1, 1, 3 )					
		,( 1, 1, 2, 5, 1, 1, 1, 2, 4 )				
		,( 1, 1, 2, 5, 1, 1, 2, 1, 3 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 2, 5, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 1, 2, 5, 1, 1, 3, 1, 3 )				
		,( 1, 1, 2, 5, 1, 1, 3, 2, 4 )				
		,( 1, 1, 2, 5, 1, 1, 4, 1, 3 )				
		,( 1, 1, 2, 5, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 1, 2, 5, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 2, 5, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 1, 2, 5, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 2, 5, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 1, 2, 5, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 1, 2, 5, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 1, 2, 5, 1, 1, 8, 1, 3 )				 
		,( 1, 1, 2, 5, 1, 1, 8, 2, 4 )				
		,( 1, 1, 2, 5, 1, 1, 9, 1, 3 )				
		,( 1, 1, 2, 5, 1, 1, 9, 2, 4 )				
		,( 1, 1, 2, 5, 1, 1, 10, 1, 3 )				
		,( 1, 1, 2, 5, 1, 1, 10, 2, 4 )				
		,( 1, 1, 2, 5, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 5, 2, 1, 1, 1, 3 )					
		,( 1, 1, 2, 5, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 2, 5, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 2, 5, 2, 1, 2, 2, 2 )				
		,( 1, 1, 2, 5, 2, 1, 3, 1, 3 )				
		,( 1, 1, 2, 5, 2, 1, 3, 2, 7 )				
		,( 1, 1, 2, 5, 2, 1, 4, 1, 3 )				
		,( 1, 1, 2, 5, 2, 1, 4, 2, 2 )				
		,( 1, 1, 2, 5, 2, 1, 5, 1, 3 )				
		,( 1, 1, 2, 5, 2, 1, 5, 2, '' )				
		,( 1, 1, 2, 5, 2, 1, 6, 1, 6 )				
		,( 1, 1, 2, 5, 2, 1, 6, 2, 4 )				
		,( 1, 1, 2, 5, 2, 1, 7, 1, 3 )				
		,( 1, 1, 2, 5, 2, 1, 7, 2, 4 )				
		,( 1, 1, 2, 5, 2, 1, 8, 1, '' )				
		,( 1, 1, 2, 5, 2, 1, 8, 2, 4 )				
		,( 1, 1, 2, 5, 2, 1, 9, 1, 3 )				
		,( 1, 1, 2, 5, 2, 1, 9, 2, 7 )				
		,( 1, 1, 2, 5, 2, 1, 10, 1, 1 )				
		,( 1, 1, 2, 5, 2, 1, 10, 2, 1 )				
		,( 1, 1, 2, 5, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 5, 3, 1, 1, 1, 3 )					
		,( 1, 1, 2, 5, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game: 3, Week: 1,Total score: 131	
		,( 1, 1, 2, 5, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 2, 5, 3, 1, 2, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 3, 1, 3 )				
		,( 1, 1, 2, 5, 3, 1, 3, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 4, 1, 3 )				
		,( 1, 1, 2, 5, 3, 1, 4, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 5, 1, 3 )				
		,( 1, 1, 2, 5, 3, 1, 5, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 6, 1, 3 )				
		,( 1, 1, 2, 5, 3, 1, 6, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 7, 1, 3 )				
		,( 1, 1, 2, 5, 3, 1, 7, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 8, 1, 3 )				
		,( 1, 1, 2, 5, 3, 1, 8, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 9, 1, 3 )				
		,( 1, 1, 2, 5, 3, 1, 9, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 10, 1, 3 )				
		,( 1, 1, 2, 5, 3, 1, 10, 2, 7 )				
		,( 1, 1, 2, 5, 3, 1, 10, 3, 4 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 5, 4, 2, 1, 1, 10 )					
		,( 1, 1, 2, 5, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 2, Player: 5, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 2, 5, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 2, 5, 4, 2, 2, 2, 5 )				
		,( 1, 1, 2, 5, 4, 2, 3, 1, 10 )				
		,( 1, 1, 2, 5, 4, 2, 3, 2, '' )				
		,( 1, 1, 2, 5, 4, 2, 4, 1, 5 )				
		,( 1, 1, 2, 5, 4, 2, 4, 2, 3 )				
		,( 1, 1, 2, 5, 4, 2, 5, 1, 2 )				
		,( 1, 1, 2, 5, 4, 2, 5, 2, '' )				
		,( 1, 1, 2, 5, 4, 2, 6, 1, 3 )				
		,( 1, 1, 2, 5, 4, 2, 6, 2, 2 )				
		,( 1, 1, 2, 5, 4, 2, 7, 1, 10 )				
		,( 1, 1, 2, 5, 4, 2, 7, 2, '' )				
		,( 1, 1, 2, 5, 4, 2, 8, 1, '' )				
		,( 1, 1, 2, 5, 4, 2, 8, 2, '' )				
		,( 1, 1, 2, 5, 4, 2, 9, 1, '' )				
		,( 1, 1, 2, 5, 4, 2, 9, 2, '' )				
		,( 1, 1, 2, 5, 4, 2, 10, 1, 4 )				
		,( 1, 1, 2, 5, 4, 2, 10, 2, 6 )				
		,( 1, 1, 2, 5, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 5, 5, 2, 1, 1, 10 )					
		,( 1, 1, 2, 5, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 2, Player: 5, Game:5, Week: 2,Total score: 300	
		,( 1, 1, 2, 5, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 2, 5, 5, 2, 2, 2, '' )				
		,( 1, 1, 2, 5, 5, 2, 3, 1, 10 )				
		,( 1, 1, 2, 5, 5, 2, 3, 2, '' )			-- Same as #1 BUT	
 		,( 1, 1, 2, 5, 5, 2, 4, 1, 10 )			-- different team, different player	
		,( 1, 1, 2, 5, 5, 2, 4, 2, '' )			-- This will test to make sure our scoring works on the team level	
		,( 1, 1, 2, 5, 5, 2, 5, 1, 10 )				
		,( 1, 1, 2, 5, 5, 2, 5, 2, '' )				
		,( 1, 1, 2, 5, 5, 2, 6, 1, 10 )				
		,( 1, 1, 2, 5, 5, 2, 6, 2, '' )				
		,( 1, 1, 2, 5, 5, 2, 7, 1, 10 )				
		,( 1, 1, 2, 5, 5, 2, 7, 2, '' )				
		,( 1, 1, 2, 5, 5, 2, 8, 1, 10 )				
		,( 1, 1, 2, 5, 5, 2, 8, 2, '' )				
		,( 1, 1, 2, 5, 5, 2, 9, 1, 10 )				
		,( 1, 1, 2, 5, 5, 2, 9, 2, '' )				
		,( 1, 1, 2, 5, 5, 2, 10, 1, 10 )				
		,( 1, 1, 2, 5, 5, 2, 10, 2, 10 )				
		,( 1, 1, 2, 5, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 5, 6, 2, 1, 1, 3 )					
		,( 1, 1, 2, 5, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 2, Player: 5, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 2, 5, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 2, 5, 6, 2, 2, 2, 7 )				
		,( 1, 1, 2, 5, 6, 2, 3, 1, 3 )				
		,( 1, 1, 2, 5, 6, 2, 3, 2, 7 )				
		,( 1, 1, 2, 5, 6, 2, 4, 1, 1 )				
		,( 1, 1, 2, 5, 6, 2, 4, 2, 2 )				
		,( 1, 1, 2, 5, 6, 2, 5, 1, 10 )				
		,( 1, 1, 2, 5, 6, 2, 5, 2, '' )				
		,( 1, 1, 2, 5, 6, 2, 6, 1, 10 )				
		,( 1, 1, 2, 5, 6, 2, 6, 2, '' )				
		,( 1, 1, 2, 5, 6, 2, 7, 1, 3 )				
		,( 1, 1, 2, 5, 6, 2, 7, 2, 7 )				
		,( 1, 1, 2, 5, 6, 2, 8, 1, 3 )				
		,( 1, 1, 2, 5, 6, 2, 8, 2, 7 )				
		,( 1, 1, 2, 5, 6, 2, 9, 1, 3 )				
		,( 1, 1, 2, 5, 6, 2, 9, 2, 6 )				
		,( 1, 1, 2, 5, 6, 2, 10, 1, 10 )				
		,( 1, 1, 2, 5, 6, 2, 10, 2, 10 )				
		,( 1, 1, 2, 5, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 6, 1, 1, 1, 1, 3 )					
		,( 1, 1, 2, 6, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 2, 6, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 2, 6, 1, 1, 2, 2, 4 )				
		,( 1, 1, 2, 6, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 2, 6, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 2, 6, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 2, 6, 1, 1, 4, 2, 4 )				
		,( 1, 1, 2, 6, 1, 1, 5, 1, 3 )				
		,( 1, 1, 2, 6, 1, 1, 5, 2, 4 )				
		,( 1, 1, 2, 6, 1, 1, 6, 1, 3 )				
		,( 1, 1, 2, 6, 1, 1, 6, 2, 4 )				
		,( 1, 1, 2, 6, 1, 1, 7, 1, 3 )				
		,( 1, 1, 2, 6, 1, 1, 7, 2, 4 )				
		,( 1, 1, 2, 6, 1, 1, 8, 1, 3 )				
		,( 1, 1, 2, 6, 1, 1, 8, 2, 4 )				
		,( 1, 1, 2, 6, 1, 1, 9, 1, 3 )				
		,( 1, 1, 2, 6, 1, 1, 9, 2, 4 )				
		,( 1, 1, 2, 6, 1, 1, 10, 1, 3 )				
		,( 1, 1, 2, 6, 1, 1, 10, 2, 4 )				
		,( 1, 1, 2, 6, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 6, 2, 1, 1, 1, 3 )					
		,( 1, 1, 2, 6, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 2, 6, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 2, 6, 2, 1, 2, 2, 2 )				
		,( 1, 1, 2, 6, 2, 1, 3, 1, 3 )				
		,( 1, 1, 2, 6, 2, 1, 3, 2, 7 )				
		,( 1, 1, 2, 6, 2, 1, 4, 1, 3 )				
		,( 1, 1, 2, 6, 2, 1, 4, 2, 2 )				
		,( 1, 1, 2, 6, 2, 1, 5, 1, 3 )				
		,( 1, 1, 2, 6, 2, 1, 5, 2, '' )				
		,( 1, 1, 2, 6, 2, 1, 6, 1, 6 )				
		,( 1, 1, 2, 6, 2, 1, 6, 2, 4 )				
		,( 1, 1, 2, 6, 2, 1, 7, 1, 3 )				
		,( 1, 1, 2, 6, 2, 1, 7, 2, 4 )				
		,( 1, 1, 2, 6, 2, 1, 8, 1, '' )				
		,( 1, 1, 2, 6, 2, 1, 8, 2, 4 )				
		,( 1, 1, 2, 6, 2, 1, 9, 1, 3 )				
		,( 1, 1, 2, 6, 2, 1, 9, 2, 7 )				
		,( 1, 1, 2, 6, 2, 1, 10, 1, 1 )				
		,( 1, 1, 2, 6, 2, 1, 10, 2, 1 )				
		,( 1, 1, 2, 6, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 6, 3, 1, 1, 1, 3 )					
		,( 1, 1, 2, 6, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 3, Week: 1,Total score: 128	
		,( 1, 1, 2, 6, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 2, 6, 3, 1, 2, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 3, 1, 3 )				
		,( 1, 1, 2, 6, 3, 1, 3, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 4, 1, 3 )				
		,( 1, 1, 2, 6, 3, 1, 4, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 5, 1, 3 )				
		,( 1, 1, 2, 6, 3, 1, 5, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 6, 1, 3 )				
		,( 1, 1, 2, 6, 3, 1, 6, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 7, 1, 3 )				
		,( 1, 1, 2, 6, 3, 1, 7, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 8, 1, 3 )				
		,( 1, 1, 2, 6, 3, 1, 8, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 9, 1, 3 )				
		,( 1, 1, 2, 6, 3, 1, 9, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 10, 1, 3 )				
		,( 1, 1, 2, 6, 3, 1, 10, 2, 7 )				
		,( 1, 1, 2, 6, 3, 1, 10, 3, 1 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 6, 4, 2, 1, 1, 10 )					
		,( 1, 1, 2, 6, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 2, Player: 6, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 2, 6, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 2, 6, 4, 2, 2, 2, 5 )				
		,( 1, 1, 2, 6, 4, 2, 3, 1, 10 )				
		,( 1, 1, 2, 6, 4, 2, 3, 2, '' )				
		,( 1, 1, 2, 6, 4, 2, 4, 1, 5 )				
		,( 1, 1, 2, 6, 4, 2, 4, 2, 3 )				
		,( 1, 1, 2, 6, 4, 2, 5, 1, 2 )				
		,( 1, 1, 2, 6, 4, 2, 5, 2, '' )				
		,( 1, 1, 2, 6, 4, 2, 6, 1, 3 )				
		,( 1, 1, 2, 6, 4, 2, 6, 2, 2 )				
		,( 1, 1, 2, 6, 4, 2, 7, 1, 10 )				
		,( 1, 1, 2, 6, 4, 2, 7, 2, '' )				
		,( 1, 1, 2, 6, 4, 2, 8, 1, '' )				
		,( 1, 1, 2, 6, 4, 2, 8, 2, '' )				
		,( 1, 1, 2, 6, 4, 2, 9, 1, '' )				
		,( 1, 1, 2, 6, 4, 2, 9, 2, '' )				
		,( 1, 1, 2, 6, 4, 2, 10, 1, 4 )				
		,( 1, 1, 2, 6, 4, 2, 10, 2, 6 )				
		,( 1, 1, 2, 6, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 6, 5, 2, 1, 1, 10 )					
		,( 1, 1, 2, 6, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 2, 6, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 2, 6, 5, 2, 2, 2, '' )				
		,( 1, 1, 2, 6, 5, 2, 3, 1, 10 )				
		,( 1, 1, 2, 6, 5, 2, 3, 2, '' )				
		,( 1, 1, 2, 6, 5, 2, 4, 1, 10 )				
		,( 1, 1, 2, 6, 5, 2, 4, 2, '' )				
		,( 1, 1, 2, 6, 5, 2, 5, 1, 10 )				
		,( 1, 1, 2, 6, 5, 2, 5, 2, '' )				
		,( 1, 1, 2, 6, 5, 2, 6, 1, 10 )				
		,( 1, 1, 2, 6, 5, 2, 6, 2, '' )				
		,( 1, 1, 2, 6, 5, 2, 7, 1, 10 )				
		,( 1, 1, 2, 6, 5, 2, 7, 2, '' )				
		,( 1, 1, 2, 6, 5, 2, 8, 1, 10 )				
		,( 1, 1, 2, 6, 5, 2, 8, 2, '' )				
		,( 1, 1, 2, 6, 5, 2, 9, 1, 10 )				
		,( 1, 1, 2, 6, 5, 2, 9, 2, '' )				
		,( 1, 1, 2, 6, 5, 2, 10, 1, 10 )				
		,( 1, 1, 2, 6, 5, 2, 10, 2, 10 )				
		,( 1, 1, 2, 6, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 6, 6, 2, 1, 1, 3 )					
		,( 1, 1, 2, 6, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 2, Player: 6, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 2, 6, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 2, 6, 6, 2, 2, 2, 7 )				
		,( 1, 1, 2, 6, 6, 2, 3, 1, 3 )				
		,( 1, 1, 2, 6, 6, 2, 3, 2, 7 )				
		,( 1, 1, 2, 6, 6, 2, 4, 1, 1 )				
		,( 1, 1, 2, 6, 6, 2, 4, 2, 2 )				
		,( 1, 1, 2, 6, 6, 2, 5, 1, 10 )				
		,( 1, 1, 2, 6, 6, 2, 5, 2, '' )				
		,( 1, 1, 2, 6, 6, 2, 6, 1, 10 )				
		,( 1, 1, 2, 6, 6, 2, 6, 2, '' )				
		,( 1, 1, 2, 6, 6, 2, 7, 1, 3 )				
		,( 1, 1, 2, 6, 6, 2, 7, 2, 7 )				
		,( 1, 1, 2, 6, 6, 2, 8, 1, 3 )				
		,( 1, 1, 2, 6, 6, 2, 8, 2, 7 )				
		,( 1, 1, 2, 6, 6, 2, 9, 1, 3 )				
		,( 1, 1, 2, 6, 6, 2, 9, 2, 6 )				
		,( 1, 1, 2, 6, 6, 2, 10, 1, 10 )				
		,( 1, 1, 2, 6, 6, 2, 10, 2, 10 )				
		,( 1, 1, 2, 6, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 7, 1, 1, 1, 1, 3 )					
		,( 1, 1, 2, 7, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 2, 7, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 2, 7, 1, 1, 2, 2, 4 )				
		,( 1, 1, 2, 7, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 2, 7, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 2, 7, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 2, 7, 1, 1, 4, 2, 4 )				
		,( 1, 1, 2, 7, 1, 1, 5, 1, 3 )				
		,( 1, 1, 2, 7, 1, 1, 5, 2, 4 )				
		,( 1, 1, 2, 7, 1, 1, 6, 1, 3 )				
		,( 1, 1, 2, 7, 1, 1, 6, 2, 4 )				
		,( 1, 1, 2, 7, 1, 1, 7, 1, 3 )				
		,( 1, 1, 2, 7, 1, 1, 7, 2, 4 )				
		,( 1, 1, 2, 7, 1, 1, 8, 1, 3 )				
		,( 1, 1, 2, 7, 1, 1, 8, 2, 4 )				
		,( 1, 1, 2, 7, 1, 1, 9, 1, 3 )				
		,( 1, 1, 2, 7, 1, 1, 9, 2, 4 )				
		,( 1, 1, 2, 7, 1, 1, 10, 1, 3 )				
		,( 1, 1, 2, 7, 1, 1, 10, 2, 4 )				
		,( 1, 1, 2, 7, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 7, 2, 1, 1, 1, 3 )					
		,( 1, 1, 2, 7, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 2, 7, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 2, 7, 2, 1, 2, 2, 2 )				
		,( 1, 1, 2, 7, 2, 1, 3, 1, 3 )				
		,( 1, 1, 2, 7, 2, 1, 3, 2, 7 )				
		,( 1, 1, 2, 7, 2, 1, 4, 1, 3 )				
		,( 1, 1, 2, 7, 2, 1, 4, 2, 2 )				
		,( 1, 1, 2, 7, 2, 1, 5, 1, 3 )				
		,( 1, 1, 2, 7, 2, 1, 5, 2, '' )				
		,( 1, 1, 2, 7, 2, 1, 6, 1, 6 )				
		,( 1, 1, 2, 7, 2, 1, 6, 2, 4 )				
		,( 1, 1, 2, 7, 2, 1, 7, 1, 3 )				
		,( 1, 1, 2, 7, 2, 1, 7, 2, 4 )				
		,( 1, 1, 2, 7, 2, 1, 8, 1, '' )				
		,( 1, 1, 2, 7, 2, 1, 8, 2, 4 )				
		,( 1, 1, 2, 7, 2, 1, 9, 1, 3 )				
		,( 1, 1, 2, 7, 2, 1, 9, 2, 7 )				
		,( 1, 1, 2, 7, 2, 1, 10, 1, 1 )				
		,( 1, 1, 2, 7, 2, 1, 10, 2, 1 )				
		,( 1, 1, 2, 7, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 7, 3, 1, 1, 1, 3 )					
		,( 1, 1, 2, 7, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 3, Week: 1,Total score: 131	
		,( 1, 1, 2, 7, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 2, 7, 3, 1, 2, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 3, 1, 3 )				
		,( 1, 1, 2, 7, 3, 1, 3, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 4, 1, 3 )				
		,( 1, 1, 2, 7, 3, 1, 4, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 5, 1, 3 )				
		,( 1, 1, 2, 7, 3, 1, 5, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 6, 1, 3 )				
		,( 1, 1, 2, 7, 3, 1, 6, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 7, 1, 3 )				
		,( 1, 1, 2, 7, 3, 1, 7, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 8, 1, 3 )				
		,( 1, 1, 2, 7, 3, 1, 8, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 9, 1, 3 )				
		,( 1, 1, 2, 7, 3, 1, 9, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 10, 1, 3 )				
		,( 1, 1, 2, 7, 3, 1, 10, 2, 7 )				
		,( 1, 1, 2, 7, 3, 1, 10, 3, 4 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 7, 4, 2, 1, 1, 10 )					
		,( 1, 1, 2, 7, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 2, Player: 7, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 2, 7, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 2, 7, 4, 2, 2, 2, 5 )				
		,( 1, 1, 2, 7, 4, 2, 3, 1, 10 )				
		,( 1, 1, 2, 7, 4, 2, 3, 2, '' )				
		,( 1, 1, 2, 7, 4, 2, 4, 1, 5 )				
		,( 1, 1, 2, 7, 4, 2, 4, 2, 3 )				
		,( 1, 1, 2, 7, 4, 2, 5, 1, 2 )				
		,( 1, 1, 2, 7, 4, 2, 5, 2, '' )				
		,( 1, 1, 2, 7, 4, 2, 6, 1, 3 )				
		,( 1, 1, 2, 7, 4, 2, 6, 2, 2 )				
		,( 1, 1, 2, 7, 4, 2, 7, 1, 10 )				
		,( 1, 1, 2, 7, 4, 2, 7, 2, '' )				
		,( 1, 1, 2, 7, 4, 2, 8, 1, '' )				
		,( 1, 1, 2, 7, 4, 2, 8, 2, '' )				
		,( 1, 1, 2, 7, 4, 2, 9, 1, '' )				
		,( 1, 1, 2, 7, 4, 2, 9, 2, '' )				
		,( 1, 1, 2, 7, 4, 2, 10, 1, 4 )				
		,( 1, 1, 2, 7, 4, 2, 10, 2, 6 )				
		,( 1, 1, 2, 7, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 7, 5, 2, 1, 1, 10 )					
		,( 1, 1, 2, 7, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 2, 7, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 2, 7, 5, 2, 2, 2, '' )				
		,( 1, 1, 2, 7, 5, 2, 3, 1, 10 )				
		,( 1, 1, 2, 7, 5, 2, 3, 2, '' )				
		,( 1, 1, 2, 7, 5, 2, 4, 1, 10 )				
		,( 1, 1, 2, 7, 5, 2, 4, 2, '' )				
		,( 1, 1, 2, 7, 5, 2, 5, 1, 10 )				
		,( 1, 1, 2, 7, 5, 2, 5, 2, '' )				
		,( 1, 1, 2, 7, 5, 2, 6, 1, 10 )				
		,( 1, 1, 2, 7, 5, 2, 6, 2, '' )				
		,( 1, 1, 2, 7, 5, 2, 7, 1, 10 )				
		,( 1, 1, 2, 7, 5, 2, 7, 2, '' )				
		,( 1, 1, 2, 7, 5, 2, 8, 1, 10 )				
		,( 1, 1, 2, 7, 5, 2, 8, 2, '' )				
		,( 1, 1, 2, 7, 5, 2, 9, 1, 10 )				
		,( 1, 1, 2, 7, 5, 2, 9, 2, '' )				
		,( 1, 1, 2, 7, 5, 2, 10, 1, 10 )				
		,( 1, 1, 2, 7, 5, 2, 10, 2, 10 )				
		,( 1, 1, 2, 7, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 7, 6, 2, 1, 1, 3 )					
		,( 1, 1, 2, 7, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 2, Player: 7, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 2, 7, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 2, 7, 6, 2, 2, 2, 7 )				
		,( 1, 1, 2, 7, 6, 2, 3, 1, 3 )				
		,( 1, 1, 2, 7, 6, 2, 3, 2, 7 )				
		,( 1, 1, 2, 7, 6, 2, 4, 1, 1 )				
		,( 1, 1, 2, 7, 6, 2, 4, 2, 2 )				
		,( 1, 1, 2, 7, 6, 2, 5, 1, 10 )				
		,( 1, 1, 2, 7, 6, 2, 5, 2, '' )				
		,( 1, 1, 2, 7, 6, 2, 6, 1, 10 )				
		,( 1, 1, 2, 7, 6, 2, 6, 2, '' )				
		,( 1, 1, 2, 7, 6, 2, 7, 1, 3 )				
		,( 1, 1, 2, 7, 6, 2, 7, 2, 7 )				
		,( 1, 1, 2, 7, 6, 2, 8, 1, 3 )				
		,( 1, 1, 2, 7, 6, 2, 8, 2, 7 )				
		,( 1, 1, 2, 7, 6, 2, 9, 1, 3 )				
		,( 1, 1, 2, 7, 6, 2, 9, 2, 6 )				
		,( 1, 1, 2, 7, 6, 2, 10, 1, 10 )				
		,( 1, 1, 2, 7, 6, 2, 10, 2, 10 )				
		,( 1, 1, 2, 7, 6, 2, 10, 3, 10 )				
				
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 8, 1, 1, 1, 1, 3 )					
		,( 1, 1, 2, 8, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 2, 8, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 2, 8, 1, 1, 2, 2, 4 )				
		,( 1, 1, 2, 8, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 2, 8, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 2, 8, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 2, 8, 1, 1, 4, 2, 4 )				
		,( 1, 1, 2, 8, 1, 1, 5, 1, 3 )				
		,( 1, 1, 2, 8, 1, 1, 5, 2, 4 )				
		,( 1, 1, 2, 8, 1, 1, 6, 1, 3 )				
		,( 1, 1, 2, 8, 1, 1, 6, 2, 4 )				
		,( 1, 1, 2, 8, 1, 1, 7, 1, 3 )				
		,( 1, 1, 2, 8, 1, 1, 7, 2, 4 )				
		,( 1, 1, 2, 8, 1, 1, 8, 1, 3 )				
		,( 1, 1, 2, 8, 1, 1, 8, 2, 4 )				
		,( 1, 1, 2, 8, 1, 1, 9, 1, 3 )				
		,( 1, 1, 2, 8, 1, 1, 9, 2, 4 )				
		,( 1, 1, 2, 8, 1, 1, 10, 1, 3 )				
		,( 1, 1, 2, 8, 1, 1, 10, 2, 4 )				
		,( 1, 1, 2, 8, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 8, 2, 1, 1, 1, 3 )					
		,( 1, 1, 2, 8, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 2, 8, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 2, 8, 2, 1, 2, 2, 2 )				
		,( 1, 1, 2, 8, 2, 1, 3, 1, 3 )				
		,( 1, 1, 2, 8, 2, 1, 3, 2, 7 )				
		,( 1, 1, 2, 8, 2, 1, 4, 1, 3 )				
		,( 1, 1, 2, 8, 2, 1, 4, 2, 2 )				
		,( 1, 1, 2, 8, 2, 1, 5, 1, 3 )				
		,( 1, 1, 2, 8, 2, 1, 5, 2, '' )				
		,( 1, 1, 2, 8, 2, 1, 6, 1, 6 )				
		,( 1, 1, 2, 8, 2, 1, 6, 2, 4 )				
		,( 1, 1, 2, 8, 2, 1, 7, 1, 3 )				
		,( 1, 1, 2, 8, 2, 1, 7, 2, 4 )				
		,( 1, 1, 2, 8, 2, 1, 8, 1, '' )				
		,( 1, 1, 2, 8, 2, 1, 8, 2, 4 )				
		,( 1, 1, 2, 8, 2, 1, 9, 1, 3 )				
		,( 1, 1, 2, 8, 2, 1, 9, 2, 7 )				
		,( 1, 1, 2, 8, 2, 1, 10, 1, 1 )				
		,( 1, 1, 2, 8, 2, 1, 10, 2, 1 )				
		,( 1, 1, 2, 8, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 8, 3, 1, 1, 1, 3 )					
		,( 1, 1, 2, 8, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 3, Week: 1,Total score: 129	
		,( 1, 1, 2, 8, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 2, 8, 3, 1, 2, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 3, 1, 3 )				
		,( 1, 1, 2, 8, 3, 1, 3, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 4, 1, 3 )				
		,( 1, 1, 2, 8, 3, 1, 4, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 5, 1, 3 )				
		,( 1, 1, 2, 8, 3, 1, 5, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 6, 1, 3 )				
		,( 1, 1, 2, 8, 3, 1, 6, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 7, 1, 3 )				
		,( 1, 1, 2, 8, 3, 1, 7, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 8, 1, 3 )				
		,( 1, 1, 2, 8, 3, 1, 8, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 9, 1, 3 )				
		,( 1, 1, 2, 8, 3, 1, 9, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 10, 1, 3 )				
		,( 1, 1, 2, 8, 3, 1, 10, 2, 7 )				
		,( 1, 1, 2, 8, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 8, 4, 2, 1, 1, 10 )					
		,( 1, 1, 2, 8, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 2, Player: 8, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 2, 8, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 2, 8, 4, 2, 2, 2, 5 )				
		,( 1, 1, 2, 8, 4, 2, 3, 1, 10 )				
		,( 1, 1, 2, 8, 4, 2, 3, 2, '' )				
		,( 1, 1, 2, 8, 4, 2, 4, 1, 5 )				
		,( 1, 1, 2, 8, 4, 2, 4, 2, 3 )				
		,( 1, 1, 2, 8, 4, 2, 5, 1, 2 )				
		,( 1, 1, 2, 8, 4, 2, 5, 2, '' )				
		,( 1, 1, 2, 8, 4, 2, 6, 1, 3 )				
		,( 1, 1, 2, 8, 4, 2, 6, 2, 2 )				
		,( 1, 1, 2, 8, 4, 2, 7, 1, 10 )				
		,( 1, 1, 2, 8, 4, 2, 7, 2, '' )				
		,( 1, 1, 2, 8, 4, 2, 8, 1, '' )				
		,( 1, 1, 2, 8, 4, 2, 8, 2, '' )				
		,( 1, 1, 2, 8, 4, 2, 9, 1, '' )				
		,( 1, 1, 2, 8, 4, 2, 9, 2, '' )				
		,( 1, 1, 2, 8, 4, 2, 10, 1, 4 )				
		,( 1, 1, 2, 8, 4, 2, 10, 2, 6 )				
		,( 1, 1, 2, 8, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 8, 5, 2, 1, 1, 10 )					
		,( 1, 1, 2, 8, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 2, 8, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 2, 8, 5, 2, 2, 2, '' )				
		,( 1, 1, 2, 8, 5, 2, 3, 1, 10 )				
		,( 1, 1, 2, 8, 5, 2, 3, 2, '' )				
		,( 1, 1, 2, 8, 5, 2, 4, 1, 10 )				
		,( 1, 1, 2, 8, 5, 2, 4, 2, '' )				
		,( 1, 1, 2, 8, 5, 2, 5, 1, 10 )				
		,( 1, 1, 2, 8, 5, 2, 5, 2, '' )				
		,( 1, 1, 2, 8, 5, 2, 6, 1, 10 )				
		,( 1, 1, 2, 8, 5, 2, 6, 2, '' )				
		,( 1, 1, 2, 8, 5, 2, 7, 1, 10 )				
		,( 1, 1, 2, 8, 5, 2, 7, 2, '' )				
		,( 1, 1, 2, 8, 5, 2, 8, 1, 10 )				
		,( 1, 1, 2, 8, 5, 2, 8, 2, '' )				
		,( 1, 1, 2, 8, 5, 2, 9, 1, 10 )				
		,( 1, 1, 2, 8, 5, 2, 9, 2, '' )				
		,( 1, 1, 2, 8, 5, 2, 10, 1, 10 )				
		,( 1, 1, 2, 8, 5, 2, 10, 2, 10 )				
		,( 1, 1, 2, 8, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 2, 8, 6, 2, 1, 1, 3 )					
		,( 1, 1, 2, 8, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 2, Player: 8, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 2, 8, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 2, 8, 6, 2, 2, 2, 7 )				
		,( 1, 1, 2, 8, 6, 2, 3, 1, 3 )				
		,( 1, 1, 2, 8, 6, 2, 3, 2, 7 )				
		,( 1, 1, 2, 8, 6, 2, 4, 1, 1 )				
		,( 1, 1, 2, 8, 6, 2, 4, 2, 2 )				
		,( 1, 1, 2, 8, 6, 2, 5, 1, 10 )				
		,( 1, 1, 2, 8, 6, 2, 5, 2, '' )				
		,( 1, 1, 2, 8, 6, 2, 6, 1, 10 )				
		,( 1, 1, 2, 8, 6, 2, 6, 2, '' )				
		,( 1, 1, 2, 8, 6, 2, 7, 1, 3 )				
		,( 1, 1, 2, 8, 6, 2, 7, 2, 7 )				
		,( 1, 1, 2, 8, 6, 2, 8, 1, 3 )				
		,( 1, 1, 2, 8, 6, 2, 8, 2, 7 )				
		,( 1, 1, 2, 8, 6, 2, 9, 1, 3 )				
		,( 1, 1, 2, 8, 6, 2, 9, 2, 6 )				
		,( 1, 1, 2, 8, 6, 2, 10, 1, 10 )				
		,( 1, 1, 2, 8, 6, 2, 10, 2, 10 )				
		,( 1, 1, 2, 8, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 9, 1, 1, 1, 1, 3 )					
		,( 1, 1, 3, 9, 1, 1, 1, 2, 4 )				
		,( 1, 1, 3, 9, 1, 1, 2, 1, 3 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 3, 9, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 1, 3, 9, 1, 1, 3, 1, 3 )				
		,( 1, 1, 3, 9, 1, 1, 3, 2, 4 )				
		,( 1, 1, 3, 9, 1, 1, 4, 1, 3 )				
		,( 1, 1, 3, 9, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 1, 3, 9, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 3, 9, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 1, 3, 9, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 3, 9, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 1, 3, 9, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 1, 3, 9, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 1, 3, 9, 1, 1, 8, 1, 3 )				
		,( 1, 1, 3, 9, 1, 1, 8, 2, 4 )				
		,( 1, 1, 3, 9, 1, 1, 9, 1, 3 )				
		,( 1, 1, 3, 9, 1, 1, 9, 2, 4 )				
		,( 1, 1, 3, 9, 1, 1, 10, 1, 3 )				
		,( 1, 1, 3, 9, 1, 1, 10, 2, 4 )				
		,( 1, 1, 3, 9, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 9, 2, 1, 1, 1, 3 )					
		,( 1, 1, 3, 9, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 3, 9, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 3, 9, 2, 1, 2, 2, 2 )				
		,( 1, 1, 3, 9, 2, 1, 3, 1, 3 )				
		,( 1, 1, 3, 9, 2, 1, 3, 2, 7 )				
		,( 1, 1, 3, 9, 2, 1, 4, 1, 3 )				
		,( 1, 1, 3, 9, 2, 1, 4, 2, 2 )				
		,( 1, 1, 3, 9, 2, 1, 5, 1, 3 )				
		,( 1, 1, 3, 9, 2, 1, 5, 2, '' )				
		,( 1, 1, 3, 9, 2, 1, 6, 1, 6 )				
		,( 1, 1, 3, 9, 2, 1, 6, 2, 4 )				
		,( 1, 1, 3, 9, 2, 1, 7, 1, 3 )				
		,( 1, 1, 3, 9, 2, 1, 7, 2, 4 )				
		,( 1, 1, 3, 9, 2, 1, 8, 1, '' )				
		,( 1, 1, 3, 9, 2, 1, 8, 2, 4 )				
		,( 1, 1, 3, 9, 2, 1, 9, 1, 3 )				
		,( 1, 1, 3, 9, 2, 1, 9, 2, 7 )				
		,( 1, 1, 3, 9, 2, 1, 10, 1, 1 )				
		,( 1, 1, 3, 9, 2, 1, 10, 2, 1 )				
		,( 1, 1, 3, 9, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 9, 3, 1, 1, 1, 3 )					
		,( 1, 1, 3, 9, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game: 3, Week: 1,Total score: 132	
		,( 1, 1, 3, 9, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 3, 9, 3, 1, 2, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 3, 1, 3 )				
		,( 1, 1, 3, 9, 3, 1, 3, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 4, 1, 3 )				
		,( 1, 1, 3, 9, 3, 1, 4, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 5, 1, 3 )				
		,( 1, 1, 3, 9, 3, 1, 5, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 6, 1, 3 )				
		,( 1, 1, 3, 9, 3, 1, 6, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 7, 1, 3 )				
		,( 1, 1, 3, 9, 3, 1, 7, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 8, 1, 3 )				
		,( 1, 1, 3, 9, 3, 1, 8, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 9, 1, 3 )				
		,( 1, 1, 3, 9, 3, 1, 9, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 10, 1, 3 )				
		,( 1, 1, 3, 9, 3, 1, 10, 2, 7 )				
		,( 1, 1, 3, 9, 3, 1, 10, 3, 5 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 9, 4, 2, 1, 1, 10 )					
		,( 1, 1, 3, 9, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 3, Player: 9, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 3, 9, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 3, 9, 4, 2, 2, 2, 5 )				
		,( 1, 1, 3, 9, 4, 2, 3, 1, 10 )				
		,( 1, 1, 3, 9, 4, 2, 3, 2, '' )				
		,( 1, 1, 3, 9, 4, 2, 4, 1, 5 )				
		,( 1, 1, 3, 9, 4, 2, 4, 2, 3 )				
		,( 1, 1, 3, 9, 4, 2, 5, 1, 2 )				
		,( 1, 1, 3, 9, 4, 2, 5, 2, '' )				
		,( 1, 1, 3, 9, 4, 2, 6, 1, 3 )				
		,( 1, 1, 3, 9, 4, 2, 6, 2, 2 )				
		,( 1, 1, 3, 9, 4, 2, 7, 1, 10 )				
		,( 1, 1, 3, 9, 4, 2, 7, 2, '' )				
		,( 1, 1, 3, 9, 4, 2, 8, 1, '' )				
		,( 1, 1, 3, 9, 4, 2, 8, 2, '' )				
		,( 1, 1, 3, 9, 4, 2, 9, 1, '' )				
		,( 1, 1, 3, 9, 4, 2, 9, 2, '' )				
		,( 1, 1, 3, 9, 4, 2, 10, 1, 4 )				
		,( 1, 1, 3, 9, 4, 2, 10, 2, 6 )				
		,( 1, 1, 3, 9, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 9, 5, 2, 1, 1, 10 )					
		,( 1, 1, 3, 9, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 3, Player: 9, Game:5, Week: 2,Total score: 300	
		,( 1, 1, 3, 9, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 3, 9, 5, 2, 2, 2, '' )				
		,( 1, 1, 3, 9, 5, 2, 3, 1, 10 )				
		,( 1, 1, 3, 9, 5, 2, 3, 2, '' )				
 		,( 1, 1, 3, 9, 5, 2, 4, 1, 10 )				
		,( 1, 1, 3, 9, 5, 2, 4, 2, '' )				
		,( 1, 1, 3, 9, 5, 2, 5, 1, 10 )				
		,( 1, 1, 3, 9, 5, 2, 5, 2, '' )				
		,( 1, 1, 3, 9, 5, 2, 6, 1, 10 )				
		,( 1, 1, 3, 9, 5, 2, 6, 2, '' )				
		,( 1, 1, 3, 9, 5, 2, 7, 1, 10 )				
		,( 1, 1, 3, 9, 5, 2, 7, 2, '' )				
		,( 1, 1, 3, 9, 5, 2, 8, 1, 10 )				
		,( 1, 1, 3, 9, 5, 2, 8, 2, '' )				
		,( 1, 1, 3, 9, 5, 2, 9, 1, 10 )				
		,( 1, 1, 3, 9, 5, 2, 9, 2, '' )				
		,( 1, 1, 3, 9, 5, 2, 10, 1, 10 )				
		,( 1, 1, 3, 9, 5, 2, 10, 2, 10 )				
		,( 1, 1, 3, 9, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 9, 6, 2, 1, 1, 3 )					
		,( 1, 1, 3, 9, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 3, Player: 9, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 3, 9, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 3, 9, 6, 2, 2, 2, 7 )				
		,( 1, 1, 3, 9, 6, 2, 3, 1, 3 )				
		,( 1, 1, 3, 9, 6, 2, 3, 2, 7 )				
		,( 1, 1, 3, 9, 6, 2, 4, 1, 1 )				
		,( 1, 1, 3, 9, 6, 2, 4, 2, 2 )				
		,( 1, 1, 3, 9, 6, 2, 5, 1, 10 )				
		,( 1, 1, 3, 9, 6, 2, 5, 2, '' )				
		,( 1, 1, 3, 9, 6, 2, 6, 1, 10 )				
		,( 1, 1, 3, 9, 6, 2, 6, 2, '' )				
		,( 1, 1, 3, 9, 6, 2, 7, 1, 3 )				
		,( 1, 1, 3, 9, 6, 2, 7, 2, 7 )				
		,( 1, 1, 3, 9, 6, 2, 8, 1, 3 )				
		,( 1, 1, 3, 9, 6, 2, 8, 2, 7 )				
		,( 1, 1, 3, 9, 6, 2, 9, 1, 3 )				
		,( 1, 1, 3, 9, 6, 2, 9, 2, 6 )				
		,( 1, 1, 3, 9, 6, 2, 10, 1, 10 )				
		,( 1, 1, 3, 9, 6, 2, 10, 2, 10 )				
		,( 1, 1, 3, 9, 6, 2, 10, 3, 10 )				
		
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 10, 1, 1, 1, 1, 3 )					
		,( 1, 1, 3, 10, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 3, 10, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 3, 10, 1, 1, 2, 2, 4 )				
		,( 1, 1, 3, 10, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 3, 10, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 3, 10, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 3, 10, 1, 1, 4, 2, 4 )				
		,( 1, 1, 3, 10, 1, 1, 5, 1, 3 )				
		,( 1, 1, 3, 10, 1, 1, 5, 2, 4 )				
		,( 1, 1, 3, 10, 1, 1, 6, 1, 3 )				
		,( 1, 1, 3, 10, 1, 1, 6, 2, 4 )				
		,( 1, 1, 3, 10, 1, 1, 7, 1, 3 )				
		,( 1, 1, 3, 10, 1, 1, 7, 2, 4 )				
		,( 1, 1, 3, 10, 1, 1, 8, 1, 3 )				
		,( 1, 1, 3, 10, 1, 1, 8, 2, 4 )				
		,( 1, 1, 3, 10, 1, 1, 9, 1, 3 )				
		,( 1, 1, 3, 10, 1, 1, 9, 2, 4 )				
		,( 1, 1, 3, 10, 1, 1, 10, 1, 3 )				
		,( 1, 1, 3, 10, 1, 1, 10, 2, 4 )				
		,( 1, 1, 3, 10, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 10, 2, 1, 1, 1, 3 )					
		,( 1, 1, 3, 10, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 3, 10, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 3, 10, 2, 1, 2, 2, 2 )				
		,( 1, 1, 3, 10, 2, 1, 3, 1, 3 )				
		,( 1, 1, 3, 10, 2, 1, 3, 2, 7 )				
		,( 1, 1, 3, 10, 2, 1, 4, 1, 3 )				
		,( 1, 1, 3, 10, 2, 1, 4, 2, 2 )				
		,( 1, 1, 3, 10, 2, 1, 5, 1, 3 )				
		,( 1, 1, 3, 10, 2, 1, 5, 2, '' )				
		,( 1, 1, 3, 10, 2, 1, 6, 1, 6 )				
		,( 1, 1, 3, 10, 2, 1, 6, 2, 4 )				
		,( 1, 1, 3, 10, 2, 1, 7, 1, 3 )				
		,( 1, 1, 3, 10, 2, 1, 7, 2, 4 )				
		,( 1, 1, 3, 10, 2, 1, 8, 1, '' )				
		,( 1, 1, 3, 10, 2, 1, 8, 2, 4 )				
		,( 1, 1, 3, 10, 2, 1, 9, 1, 3 )				
		,( 1, 1, 3, 10, 2, 1, 9, 2, 7 )				
		,( 1, 1, 3, 10, 2, 1, 10, 1, 1 )				
		,( 1, 1, 3, 10, 2, 1, 10, 2, 1 )				
		,( 1, 1, 3, 10, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 10, 3, 1, 1, 1, 3 )					
		,( 1, 1, 3, 10, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 3, Week: 1,Total score: 128	
		,( 1, 1, 3, 10, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 3, 10, 3, 1, 2, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 3, 1, 3 )				
		,( 1, 1, 3, 10, 3, 1, 3, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 4, 1, 3 )				
		,( 1, 1, 3, 10, 3, 1, 4, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 5, 1, 3 )				
		,( 1, 1, 3, 10, 3, 1, 5, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 6, 1, 3 )				
		,( 1, 1, 3, 10, 3, 1, 6, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 7, 1, 3 )				
		,( 1, 1, 3, 10, 3, 1, 7, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 8, 1, 3 )				
		,( 1, 1, 3, 10, 3, 1, 8, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 9, 1, 3 )				
		,( 1, 1, 3, 10, 3, 1, 9, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 10, 1, 3 )				
		,( 1, 1, 3, 10, 3, 1, 10, 2, 7 )				
		,( 1, 1, 3, 10, 3, 1, 10, 3, 1 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 10, 4, 2, 1, 1, 10 )					
		,( 1, 1, 3, 10, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 3, Player: 10, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 3, 10, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 3, 10, 4, 2, 2, 2, 5 )				
		,( 1, 1, 3, 10, 4, 2, 3, 1, 10 )				
		,( 1, 1, 3, 10, 4, 2, 3, 2, '' )				
		,( 1, 1, 3, 10, 4, 2, 4, 1, 5 )				
		,( 1, 1, 3, 10, 4, 2, 4, 2, 3 )				
		,( 1, 1, 3, 10, 4, 2, 5, 1, 2 )				
		,( 1, 1, 3, 10, 4, 2, 5, 2, '' )				
		,( 1, 1, 3, 10, 4, 2, 6, 1, 3 )				
		,( 1, 1, 3, 10, 4, 2, 6, 2, 2 )				
		,( 1, 1, 3, 10, 4, 2, 7, 1, 10 )				
		,( 1, 1, 3, 10, 4, 2, 7, 2, '' )				
		,( 1, 1, 3, 10, 4, 2, 8, 1, '' )				
		,( 1, 1, 3, 10, 4, 2, 8, 2, '' )				
		,( 1, 1, 3, 10, 4, 2, 9, 1, '' )				
		,( 1, 1, 3, 10, 4, 2, 9, 2, '' )				
		,( 1, 1, 3, 10, 4, 2, 10, 1, 4 )				
		,( 1, 1, 3, 10, 4, 2, 10, 2, 6 )				
		,( 1, 1, 3, 10, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 10, 5, 2, 1, 1, 10 )					
		,( 1, 1, 3, 10, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 3, 10, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 3, 10, 5, 2, 2, 2, '' )				
		,( 1, 1, 3, 10, 5, 2, 3, 1, 10 )				
		,( 1, 1, 3, 10, 5, 2, 3, 2, '' )				
		,( 1, 1, 3, 10, 5, 2, 4, 1, 10 )				
		,( 1, 1, 3, 10, 5, 2, 4, 2, '' )				
		,( 1, 1, 3, 10, 5, 2, 5, 1, 10 )				
		,( 1, 1, 3, 10, 5, 2, 5, 2, '' )				
		,( 1, 1, 3, 10, 5, 2, 6, 1, 10 )				
		,( 1, 1, 3, 10, 5, 2, 6, 2, '' )				
		,( 1, 1, 3, 10, 5, 2, 7, 1, 10 )				
		,( 1, 1, 3, 10, 5, 2, 7, 2, '' )				
		,( 1, 1, 3, 10, 5, 2, 8, 1, 10 )				
		,( 1, 1, 3, 10, 5, 2, 8, 2, '' )				
		,( 1, 1, 3, 10, 5, 2, 9, 1, 10 )				
		,( 1, 1, 3, 10, 5, 2, 9, 2, '' )				
		,( 1, 1, 3, 10, 5, 2, 10, 1, 10 )				
		,( 1, 1, 3, 10, 5, 2, 10, 2, 10 )				
		,( 1, 1, 3, 10, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 10, 6, 2, 1, 1, 3 )					
		,( 1, 1, 3, 10, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 3, Player: 10, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 3, 10, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 3, 10, 6, 2, 2, 2, 7 )				
		,( 1, 1, 3, 10, 6, 2, 3, 1, 3 )				
		,( 1, 1, 3, 10, 6, 2, 3, 2, 7 )				
		,( 1, 1, 3, 10, 6, 2, 4, 1, 1 )				
		,( 1, 1, 3, 10, 6, 2, 4, 2, 2 )				
		,( 1, 1, 3, 10, 6, 2, 5, 1, 10 )				
		,( 1, 1, 3, 10, 6, 2, 5, 2, '' )				
		,( 1, 1, 3, 10, 6, 2, 6, 1, 10 )				
		,( 1, 1, 3, 10, 6, 2, 6, 2, '' )				
		,( 1, 1, 3, 10, 6, 2, 7, 1, 3 )				
		,( 1, 1, 3, 10, 6, 2, 7, 2, 7 )				
		,( 1, 1, 3, 10, 6, 2, 8, 1, 3 )				
		,( 1, 1, 3, 10, 6, 2, 8, 2, 7 )				
		,( 1, 1, 3, 10, 6, 2, 9, 1, 3 )				
		,( 1, 1, 3, 10, 6, 2, 9, 2, 6 )				
		,( 1, 1, 3, 10, 6, 2, 10, 1, 10 )				
		,( 1, 1, 3, 10, 6, 2, 10, 2, 10 )				
		,( 1, 1, 3, 10, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 11, 1, 1, 1, 1, 3 )					
		,( 1, 1, 3, 11, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 3, 11, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 3, 11, 1, 1, 2, 2, 4 )				
		,( 1, 1, 3, 11, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 3, 11, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 3, 11, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 3, 11, 1, 1, 4, 2, 4 )				
		,( 1, 1, 3, 11, 1, 1, 5, 1, 3 )				
		,( 1, 1, 3, 11, 1, 1, 5, 2, 4 )				
		,( 1, 1, 3, 11, 1, 1, 6, 1, 3 )				
		,( 1, 1, 3, 11, 1, 1, 6, 2, 4 )				
		,( 1, 1, 3, 11, 1, 1, 7, 1, 3 )				
		,( 1, 1, 3, 11, 1, 1, 7, 2, 4 )				
		,( 1, 1, 3, 11, 1, 1, 8, 1, 3 )				
		,( 1, 1, 3, 11, 1, 1, 8, 2, 4 )				
		,( 1, 1, 3, 11, 1, 1, 9, 1, 3 )				
		,( 1, 1, 3, 11, 1, 1, 9, 2, 4 )				
		,( 1, 1, 3, 11, 1, 1, 10, 1, 3 )				
		,( 1, 1, 3, 11, 1, 1, 10, 2, 4 )				
		,( 1, 1, 3, 11, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 11, 2, 1, 1, 1, 3 )					
		,( 1, 1, 3, 11, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 3, 11, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 3, 11, 2, 1, 2, 2, 2 )				
		,( 1, 1, 3, 11, 2, 1, 3, 1, 3 )				
		,( 1, 1, 3, 11, 2, 1, 3, 2, 7 )				
		,( 1, 1, 3, 11, 2, 1, 4, 1, 3 )				
		,( 1, 1, 3, 11, 2, 1, 4, 2, 2 )				
		,( 1, 1, 3, 11, 2, 1, 5, 1, 3 )				
		,( 1, 1, 3, 11, 2, 1, 5, 2, '' )				
		,( 1, 1, 3, 11, 2, 1, 6, 1, 6 )				
		,( 1, 1, 3, 11, 2, 1, 6, 2, 4 )				
		,( 1, 1, 3, 11, 2, 1, 7, 1, 3 )				
		,( 1, 1, 3, 11, 2, 1, 7, 2, 4 )				
		,( 1, 1, 3, 11, 2, 1, 8, 1, '' )				
		,( 1, 1, 3, 11, 2, 1, 8, 2, 4 )				
		,( 1, 1, 3, 11, 2, 1, 9, 1, 3 )				
		,( 1, 1, 3, 11, 2, 1, 9, 2, 7 )				
		,( 1, 1, 3, 11, 2, 1, 10, 1, 1 )				
		,( 1, 1, 3, 11, 2, 1, 10, 2, 1 )				
		,( 1, 1, 3, 11, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 11, 3, 1, 1, 1, 3 )					
		,( 1, 1, 3, 11, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 3, Week: 1,Total score: 133	
		,( 1, 1, 3, 11, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 3, 11, 3, 1, 2, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 3, 1, 3 )				
		,( 1, 1, 3, 11, 3, 1, 3, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 4, 1, 3 )				
		,( 1, 1, 3, 11, 3, 1, 4, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 5, 1, 3 )				
		,( 1, 1, 3, 11, 3, 1, 5, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 6, 1, 3 )				
		,( 1, 1, 3, 11, 3, 1, 6, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 7, 1, 3 )				
		,( 1, 1, 3, 11, 3, 1, 7, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 8, 1, 3 )				
		,( 1, 1, 3, 11, 3, 1, 8, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 9, 1, 3 )				
		,( 1, 1, 3, 11, 3, 1, 9, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 10, 1, 3 )				
		,( 1, 1, 3, 11, 3, 1, 10, 2, 7 )				
		,( 1, 1, 3, 11, 3, 1, 10, 3, 6 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 11, 4, 2, 1, 1, 10 )					
		,( 1, 1, 3, 11, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 3, Player: 11, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 3, 11, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 3, 11, 4, 2, 2, 2, 5 )				
		,( 1, 1, 3, 11, 4, 2, 3, 1, 10 )				
		,( 1, 1, 3, 11, 4, 2, 3, 2, '' )				
		,( 1, 1, 3, 11, 4, 2, 4, 1, 5 )				
		,( 1, 1, 3, 11, 4, 2, 4, 2, 3 )				
		,( 1, 1, 3, 11, 4, 2, 5, 1, 2 )				
		,( 1, 1, 3, 11, 4, 2, 5, 2, '' )				
		,( 1, 1, 3, 11, 4, 2, 6, 1, 3 )				
		,( 1, 1, 3, 11, 4, 2, 6, 2, 2 )				
		,( 1, 1, 3, 11, 4, 2, 7, 1, 10 )				
		,( 1, 1, 3, 11, 4, 2, 7, 2, '' )				
		,( 1, 1, 3, 11, 4, 2, 8, 1, '' )				
		,( 1, 1, 3, 11, 4, 2, 8, 2, '' )				
		,( 1, 1, 3, 11, 4, 2, 9, 1, '' )				
		,( 1, 1, 3, 11, 4, 2, 9, 2, '' )				
		,( 1, 1, 3, 11, 4, 2, 10, 1, 4 )				
		,( 1, 1, 3, 11, 4, 2, 10, 2, 6 )				
		,( 1, 1, 3, 11, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 11, 5, 2, 1, 1, 10 )					
		,( 1, 1, 3, 11, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 3, 11, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 3, 11, 5, 2, 2, 2, '' )				
		,( 1, 1, 3, 11, 5, 2, 3, 1, 10 )				
		,( 1, 1, 3, 11, 5, 2, 3, 2, '' )				
		,( 1, 1, 3, 11, 5, 2, 4, 1, 10 )				
		,( 1, 1, 3, 11, 5, 2, 4, 2, '' )				
		,( 1, 1, 3, 11, 5, 2, 5, 1, 10 )				
		,( 1, 1, 3, 11, 5, 2, 5, 2, '' )				
		,( 1, 1, 3, 11, 5, 2, 6, 1, 10 )				
		,( 1, 1, 3, 11, 5, 2, 6, 2, '' )				
		,( 1, 1, 3, 11, 5, 2, 7, 1, 10 )				
		,( 1, 1, 3, 11, 5, 2, 7, 2, '' )				
		,( 1, 1, 3, 11, 5, 2, 8, 1, 10 )				
		,( 1, 1, 3, 11, 5, 2, 8, 2, '' )				
		,( 1, 1, 3, 11, 5, 2, 9, 1, 10 )				
		,( 1, 1, 3, 11, 5, 2, 9, 2, '' )				
		,( 1, 1, 3, 11, 5, 2, 10, 1, 10 )				
		,( 1, 1, 3, 11, 5, 2, 10, 2, 10 )				
		,( 1, 1, 3, 11, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 11, 6, 2, 1, 1, 3 )					
		,( 1, 1, 3, 11, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 3, Player: 11, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 3, 11, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 3, 11, 6, 2, 2, 2, 7 )				
		,( 1, 1, 3, 11, 6, 2, 3, 1, 3 )				
		,( 1, 1, 3, 11, 6, 2, 3, 2, 7 )				
		,( 1, 1, 3, 11, 6, 2, 4, 1, 1 )				
		,( 1, 1, 3, 11, 6, 2, 4, 2, 2 )				
		,( 1, 1, 3, 11, 6, 2, 5, 1, 10 )				
		,( 1, 1, 3, 11, 6, 2, 5, 2, '' )				
		,( 1, 1, 3, 11, 6, 2, 6, 1, 10 )				
		,( 1, 1, 3, 11, 6, 2, 6, 2, '' )				
		,( 1, 1, 3, 11, 6, 2, 7, 1, 3 )				
		,( 1, 1, 3, 11, 6, 2, 7, 2, 7 )				
		,( 1, 1, 3, 11, 6, 2, 8, 1, 3 )				
		,( 1, 1, 3, 11, 6, 2, 8, 2, 7 )				
		,( 1, 1, 3, 11, 6, 2, 9, 1, 3 )				
		,( 1, 1, 3, 11, 6, 2, 9, 2, 6 )				
		,( 1, 1, 3, 11, 6, 2, 10, 1, 10 )				
		,( 1, 1, 3, 11, 6, 2, 10, 2, 10 )				
		,( 1, 1, 3, 11, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 12, 1, 1, 1, 1, 3 )					
		,( 1, 1, 3, 12, 1, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 1, Week: 1,Total score: 70	
		,( 1, 1, 3, 12, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 1, 3, 12, 1, 1, 2, 2, 4 )				
		,( 1, 1, 3, 12, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 1, 3, 12, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 1, 3, 12, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 1, 3, 12, 1, 1, 4, 2, 4 )				
		,( 1, 1, 3, 12, 1, 1, 5, 1, 3 )				
		,( 1, 1, 3, 12, 1, 1, 5, 2, 4 )				
		,( 1, 1, 3, 12, 1, 1, 6, 1, 3 )				
		,( 1, 1, 3, 12, 1, 1, 6, 2, 4 )				
		,( 1, 1, 3, 12, 1, 1, 7, 1, 3 )				
		,( 1, 1, 3, 12, 1, 1, 7, 2, 4 )				
		,( 1, 1, 3, 12, 1, 1, 8, 1, 3 )				
		,( 1, 1, 3, 12, 1, 1, 8, 2, 4 )				
		,( 1, 1, 3, 12, 1, 1, 9, 1, 3 )				
		,( 1, 1, 3, 12, 1, 1, 9, 2, 4 )				
		,( 1, 1, 3, 12, 1, 1, 10, 1, 3 )				
		,( 1, 1, 3, 12, 1, 1, 10, 2, 4 )				
		,( 1, 1, 3, 12, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 12, 2, 1, 1, 1, 3 )					
		,( 1, 1, 3, 12, 2, 1, 1, 2, 4 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 2, Week: 1,Total score: 70	
		,( 1, 1, 3, 12, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 1, 3, 12, 2, 1, 2, 2, 2 )				
		,( 1, 1, 3, 12, 2, 1, 3, 1, 3 )				
		,( 1, 1, 3, 12, 2, 1, 3, 2, 7 )				
		,( 1, 1, 3, 12, 2, 1, 4, 1, 3 )				
		,( 1, 1, 3, 12, 2, 1, 4, 2, 2 )				
		,( 1, 1, 3, 12, 2, 1, 5, 1, 3 )				
		,( 1, 1, 3, 12, 2, 1, 5, 2, '' )				
		,( 1, 1, 3, 12, 2, 1, 6, 1, 6 )				
		,( 1, 1, 3, 12, 2, 1, 6, 2, 4 )				
		,( 1, 1, 3, 12, 2, 1, 7, 1, 3 )				
		,( 1, 1, 3, 12, 2, 1, 7, 2, 4 )				
		,( 1, 1, 3, 12, 2, 1, 8, 1, '' )				
		,( 1, 1, 3, 12, 2, 1, 8, 2, 4 )				
		,( 1, 1, 3, 12, 2, 1, 9, 1, 3 )				
		,( 1, 1, 3, 12, 2, 1, 9, 2, 7 )				
		,( 1, 1, 3, 12, 2, 1, 10, 1, 1 )				
		,( 1, 1, 3, 12, 2, 1, 10, 2, 1 )				
		,( 1, 1, 3, 12, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 12, 3, 1, 1, 1, 3 )					
		,( 1, 1, 3, 12, 3, 1, 1, 2, 7 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 3, Week: 1,Total score: 129	
		,( 1, 1, 3, 12, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 1, 3, 12, 3, 1, 2, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 3, 1, 3 )				
		,( 1, 1, 3, 12, 3, 1, 3, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 4, 1, 3 )				
		,( 1, 1, 3, 12, 3, 1, 4, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 5, 1, 3 )				
		,( 1, 1, 3, 12, 3, 1, 5, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 6, 1, 3 )				
		,( 1, 1, 3, 12, 3, 1, 6, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 7, 1, 3 )				
		,( 1, 1, 3, 12, 3, 1, 7, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 8, 1, 3 )				
		,( 1, 1, 3, 12, 3, 1, 8, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 9, 1, 3 )				
		,( 1, 1, 3, 12, 3, 1, 9, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 10, 1, 3 )				
		,( 1, 1, 3, 12, 3, 1, 10, 2, 7 )				
		,( 1, 1, 3, 12, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 12, 4, 2, 1, 1, 10 )					
		,( 1, 1, 3, 12, 4, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 3, Player: 12, Game:4, Week: 2,Total score: 70	
		,( 1, 1, 3, 12, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 1, 3, 12, 4, 2, 2, 2, 5 )				
		,( 1, 1, 3, 12, 4, 2, 3, 1, 10 )				
		,( 1, 1, 3, 12, 4, 2, 3, 2, '' )				
		,( 1, 1, 3, 12, 4, 2, 4, 1, 5 )				
		,( 1, 1, 3, 12, 4, 2, 4, 2, 3 )				
		,( 1, 1, 3, 12, 4, 2, 5, 1, 2 )				
		,( 1, 1, 3, 12, 4, 2, 5, 2, '' )				
		,( 1, 1, 3, 12, 4, 2, 6, 1, 3 )				
		,( 1, 1, 3, 12, 4, 2, 6, 2, 2 )				
		,( 1, 1, 3, 12, 4, 2, 7, 1, 10 )				
		,( 1, 1, 3, 12, 4, 2, 7, 2, '' )				
		,( 1, 1, 3, 12, 4, 2, 8, 1, '' )				
		,( 1, 1, 3, 12, 4, 2, 8, 2, '' )				
		,( 1, 1, 3, 12, 4, 2, 9, 1, '' )				
		,( 1, 1, 3, 12, 4, 2, 9, 2, '' )				
		,( 1, 1, 3, 12, 4, 2, 10, 1, 4 )				
		,( 1, 1, 3, 12, 4, 2, 10, 2, 6 )				
		,( 1, 1, 3, 12, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 12, 5, 2, 1, 1, 10 )					
		,( 1, 1, 3, 12, 5, 2, 1, 2, '' )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 5, Week: 2,Total score: 300	
		,( 1, 1, 3, 12, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 1, 3, 12, 5, 2, 2, 2, '' )				
		,( 1, 1, 3, 12, 5, 2, 3, 1, 10 )				
		,( 1, 1, 3, 12, 5, 2, 3, 2, '' )				
		,( 1, 1, 3, 12, 5, 2, 4, 1, 10 )				
		,( 1, 1, 3, 12, 5, 2, 4, 2, '' )				
		,( 1, 1, 3, 12, 5, 2, 5, 1, 10 )				
		,( 1, 1, 3, 12, 5, 2, 5, 2, '' )				
		,( 1, 1, 3, 12, 5, 2, 6, 1, 10 )				
		,( 1, 1, 3, 12, 5, 2, 6, 2, '' )				
		,( 1, 1, 3, 12, 5, 2, 7, 1, 10 )				
		,( 1, 1, 3, 12, 5, 2, 7, 2, '' )				
		,( 1, 1, 3, 12, 5, 2, 8, 1, 10 )				
		,( 1, 1, 3, 12, 5, 2, 8, 2, '' )				
		,( 1, 1, 3, 12, 5, 2, 9, 1, 10 )				
		,( 1, 1, 3, 12, 5, 2, 9, 2, '' )				
		,( 1, 1, 3, 12, 5, 2, 10, 1, 10 )				
		,( 1, 1, 3, 12, 5, 2, 10, 2, 10 )				
		,( 1, 1, 3, 12, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 1, 3, 12, 6, 2, 1, 1, 3 )					
		,( 1, 1, 3, 12, 6, 2, 1, 2, 7 )			-- Year 2011, League: 1, Team: 3, Player: 12, Game: 6, Week: 2,Total score: 148	
		,( 1, 1, 3, 12, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 1, 3, 12, 6, 2, 2, 2, 7 )				
		,( 1, 1, 3, 12, 6, 2, 3, 1, 3 )				
		,( 1, 1, 3, 12, 6, 2, 3, 2, 7 )				
		,( 1, 1, 3, 12, 6, 2, 4, 1, 1 )				
		,( 1, 1, 3, 12, 6, 2, 4, 2, 2 )				
		,( 1, 1, 3, 12, 6, 2, 5, 1, 10 )				
		,( 1, 1, 3, 12, 6, 2, 5, 2, '' )				
		,( 1, 1, 3, 12, 6, 2, 6, 1, 10 )				
		,( 1, 1, 3, 12, 6, 2, 6, 2, '' )				
		,( 1, 1, 3, 12, 6, 2, 7, 1, 3 )				
		,( 1, 1, 3, 12, 6, 2, 7, 2, 7 )				
		,( 1, 1, 3, 12, 6, 2, 8, 1, 3 )				
		,( 1, 1, 3, 12, 6, 2, 8, 2, 7 )				
		,( 1, 1, 3, 12, 6, 2, 9, 1, 3 )				
		,( 1, 1, 3, 12, 6, 2, 9, 2, 6 )				
		,( 1, 1, 3, 12, 6, 2, 10, 1, 10 )				
		,( 1, 1, 3, 12, 6, 2, 10, 2, 10 )				
		,( 1, 1, 3, 12, 6, 2, 10, 3, 10 )				
								
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 13, 1, 1, 1, 1, 3 )					
		,( 1, 2, 4, 13, 1, 1, 1, 2, 4 )				
		,( 1, 2, 4, 13, 1, 1, 2, 1, 3 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 4, 13, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 2, 4, 13, 1, 1, 3, 1, 3 )				
		,( 1, 2, 4, 13, 1, 1, 3, 2, 4 )				
		,( 1, 2, 4, 13, 1, 1, 4, 1, 3 )				
		,( 1, 2, 4, 13, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 2, 4, 13, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 4, 13, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 2, 4, 13, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 4, 13, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 2, 4, 13, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 2, 4, 13, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 2, 4, 13, 1, 1, 8, 1, 3 )				
		,( 1, 2, 4, 13, 1, 1, 8, 2, 4 )				
		,( 1, 2, 4, 13, 1, 1, 9, 1, 3 )				
		,( 1, 2, 4, 13, 1, 1, 9, 2, 4 )				
		,( 1, 2, 4, 13, 1, 1, 10, 1, 3 )				
		,( 1, 2, 4, 13, 1, 1, 10, 2, 4 )				
		,( 1, 2, 4, 13, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 13, 2, 1, 1, 1, 3 )					
		,( 1, 2, 4, 13, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 4, 13, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 4, 13, 2, 1, 2, 2, 2 )				
		,( 1, 2, 4, 13, 2, 1, 3, 1, 3 )				
		,( 1, 2, 4, 13, 2, 1, 3, 2, 7 )				
		,( 1, 2, 4, 13, 2, 1, 4, 1, 3 )				
		,( 1, 2, 4, 13, 2, 1, 4, 2, 2 )				
		,( 1, 2, 4, 13, 2, 1, 5, 1, 3 )				
		,( 1, 2, 4, 13, 2, 1, 5, 2, '' )				
		,( 1, 2, 4, 13, 2, 1, 6, 1, 6 )				
		,( 1, 2, 4, 13, 2, 1, 6, 2, 4 )				
		,( 1, 2, 4, 13, 2, 1, 7, 1, 3 )				
		,( 1, 2, 4, 13, 2, 1, 7, 2, 4 )				
		,( 1, 2, 4, 13, 2, 1, 8, 1, '' )				
		,( 1, 2, 4, 13, 2, 1, 8, 2, 4 )				
		,( 1, 2, 4, 13, 2, 1, 9, 1, 3 )				
		,( 1, 2, 4, 13, 2, 1, 9, 2, 7 )				
		,( 1, 2, 4, 13, 2, 1, 10, 1, 1 )				
		,( 1, 2, 4, 13, 2, 1, 10, 2, 1 )				
		,( 1, 2, 4, 13, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 13, 3, 1, 1, 1, 3 )					
		,( 1, 2, 4, 13, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game: 3, Week: 1,Total score: 132	
		,( 1, 2, 4, 13, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 4, 13, 3, 1, 2, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 3, 1, 3 )				
		,( 1, 2, 4, 13, 3, 1, 3, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 4, 1, 3 )				
		,( 1, 2, 4, 13, 3, 1, 4, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 5, 1, 3 )				
		,( 1, 2, 4, 13, 3, 1, 5, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 6, 1, 3 )				
		,( 1, 2, 4, 13, 3, 1, 6, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 7, 1, 3 )				
		,( 1, 2, 4, 13, 3, 1, 7, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 8, 1, 3 )				
		,( 1, 2, 4, 13, 3, 1, 8, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 9, 1, 3 )				
		,( 1, 2, 4, 13, 3, 1, 9, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 10, 1, 3 )				
		,( 1, 2, 4, 13, 3, 1, 10, 2, 7 )				
		,( 1, 2, 4, 13, 3, 1, 10, 3, 5 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 13, 4, 2, 1, 1, 10 )					
		,( 1, 2, 4, 13, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 4, Player: 13, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 4, 13, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 4, 13, 4, 2, 2, 2, 5 )				
		,( 1, 2, 4, 13, 4, 2, 3, 1, 10 )				
		,( 1, 2, 4, 13, 4, 2, 3, 2, '' )				
		,( 1, 2, 4, 13, 4, 2, 4, 1, 5 )				
		,( 1, 2, 4, 13, 4, 2, 4, 2, 3 )				
		,( 1, 2, 4, 13, 4, 2, 5, 1, 2 )				
		,( 1, 2, 4, 13, 4, 2, 5, 2, '' )				
		,( 1, 2, 4, 13, 4, 2, 6, 1, 3 )				
		,( 1, 2, 4, 13, 4, 2, 6, 2, 2 )				
		,( 1, 2, 4, 13, 4, 2, 7, 1, 10 )				
		,( 1, 2, 4, 13, 4, 2, 7, 2, '' )				
		,( 1, 2, 4, 13, 4, 2, 8, 1, '' )				
		,( 1, 2, 4, 13, 4, 2, 8, 2, '' )				
		,( 1, 2, 4, 13, 4, 2, 9, 1, '' )				
		,( 1, 2, 4, 13, 4, 2, 9, 2, '' )				
		,( 1, 2, 4, 13, 4, 2, 10, 1, 4 )				
		,( 1, 2, 4, 13, 4, 2, 10, 2, 6 )				
		,( 1, 2, 4, 13, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 13, 5, 2, 1, 1, 10 )					
		,( 1, 2, 4, 13, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 4, Player: 13, Game:5, Week: 2,Total score: 300	
		,( 1, 2, 4, 13, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 4, 13, 5, 2, 2, 2, '' )				
		,( 1, 2, 4, 13, 5, 2, 3, 1, 10 )				
		,( 1, 2, 4, 13, 5, 2, 3, 2, '' )				
 		,( 1, 2, 4, 13, 5, 2, 4, 1, 10 )				
		,( 1, 2, 4, 13, 5, 2, 4, 2, '' )				
		,( 1, 2, 4, 13, 5, 2, 5, 1, 10 )				
		,( 1, 2, 4, 13, 5, 2, 5, 2, '' )				
		,( 1, 2, 4, 13, 5, 2, 6, 1, 10 )				
		,( 1, 2, 4, 13, 5, 2, 6, 2, '' )				
		,( 1, 2, 4, 13, 5, 2, 7, 1, 10 )				
		,( 1, 2, 4, 13, 5, 2, 7, 2, '' )				
		,( 1, 2, 4, 13, 5, 2, 8, 1, 10 )				
		,( 1, 2, 4, 13, 5, 2, 8, 2, '' )				
		,( 1, 2, 4, 13, 5, 2, 9, 1, 10 )				
		,( 1, 2, 4, 13, 5, 2, 9, 2, '' )				
		,( 1, 2, 4, 13, 5, 2, 10, 1, 10 )				
		,( 1, 2, 4, 13, 5, 2, 10, 2, 10 )				
		,( 1, 2, 4, 13, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 13, 6, 2, 1, 1, 3 )					
		,( 1, 2, 4, 13, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 4, Player: 13, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 4, 13, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 4, 13, 6, 2, 2, 2, 7 )				
		,( 1, 2, 4, 13, 6, 2, 3, 1, 3 )				
		,( 1, 2, 4, 13, 6, 2, 3, 2, 7 )				
		,( 1, 2, 4, 13, 6, 2, 4, 1, 1 )				
		,( 1, 2, 4, 13, 6, 2, 4, 2, 2 )				
		,( 1, 2, 4, 13, 6, 2, 5, 1, 10 )				
		,( 1, 2, 4, 13, 6, 2, 5, 2, '' )				
		,( 1, 2, 4, 13, 6, 2, 6, 1, 10 )				
		,( 1, 2, 4, 13, 6, 2, 6, 2, '' )				
		,( 1, 2, 4, 13, 6, 2, 7, 1, 3 )				
		,( 1, 2, 4, 13, 6, 2, 7, 2, 7 )				
		,( 1, 2, 4, 13, 6, 2, 8, 1, 3 )				
		,( 1, 2, 4, 13, 6, 2, 8, 2, 7 )				
		,( 1, 2, 4, 13, 6, 2, 9, 1, 3 )				
		,( 1, 2, 4, 13, 6, 2, 9, 2, 6 )				
		,( 1, 2, 4, 13, 6, 2, 10, 1, 10 )				
		,( 1, 2, 4, 13, 6, 2, 10, 2, 10 )				
		,( 1, 2, 4, 13, 6, 2, 10, 3, 10 )				
										
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 14, 1, 1, 1, 1, 3 )					
		,( 1, 2, 4, 14, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 4, 14, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 4, 14, 1, 1, 2, 2, 4 )				
		,( 1, 2, 4, 14, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 4, 14, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 4, 14, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 4, 14, 1, 1, 4, 2, 4 )				
		,( 1, 2, 4, 14, 1, 1, 5, 1, 3 )				
		,( 1, 2, 4, 14, 1, 1, 5, 2, 4 )				
		,( 1, 2, 4, 14, 1, 1, 6, 1, 3 )				
		,( 1, 2, 4, 14, 1, 1, 6, 2, 4 )				
		,( 1, 2, 4, 14, 1, 1, 7, 1, 3 )				
		,( 1, 2, 4, 14, 1, 1, 7, 2, 4 )				
		,( 1, 2, 4, 14, 1, 1, 8, 1, 3 )				
		,( 1, 2, 4, 14, 1, 1, 8, 2, 4 )				
		,( 1, 2, 4, 14, 1, 1, 9, 1, 3 )				
		,( 1, 2, 4, 14, 1, 1, 9, 2, 4 )				
		,( 1, 2, 4, 14, 1, 1, 10, 1, 3 )				
		,( 1, 2, 4, 14, 1, 1, 10, 2, 4 )				
		,( 1, 2, 4, 14, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 14, 2, 1, 1, 1, 3 )					
		,( 1, 2, 4, 14, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 4, 14, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 4, 14, 2, 1, 2, 2, 2 )				
		,( 1, 2, 4, 14, 2, 1, 3, 1, 3 )				
		,( 1, 2, 4, 14, 2, 1, 3, 2, 7 )				
		,( 1, 2, 4, 14, 2, 1, 4, 1, 3 )				
		,( 1, 2, 4, 14, 2, 1, 4, 2, 2 )				
		,( 1, 2, 4, 14, 2, 1, 5, 1, 3 )				
		,( 1, 2, 4, 14, 2, 1, 5, 2, '' )				
		,( 1, 2, 4, 14, 2, 1, 6, 1, 6 )				
		,( 1, 2, 4, 14, 2, 1, 6, 2, 4 )				
		,( 1, 2, 4, 14, 2, 1, 7, 1, 3 )				
		,( 1, 2, 4, 14, 2, 1, 7, 2, 4 )				
		,( 1, 2, 4, 14, 2, 1, 8, 1, '' )				
		,( 1, 2, 4, 14, 2, 1, 8, 2, 4 )				
		,( 1, 2, 4, 14, 2, 1, 9, 1, 3 )				
		,( 1, 2, 4, 14, 2, 1, 9, 2, 7 )				
		,( 1, 2, 4, 14, 2, 1, 10, 1, 1 )				
		,( 1, 2, 4, 14, 2, 1, 10, 2, 1 )				
		,( 1, 2, 4, 14, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 14, 3, 1, 1, 1, 3 )					
		,( 1, 2, 4, 14, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 3, Week: 1,Total score: 128	
		,( 1, 2, 4, 14, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 4, 14, 3, 1, 2, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 3, 1, 3 )				
		,( 1, 2, 4, 14, 3, 1, 3, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 4, 1, 3 )				
		,( 1, 2, 4, 14, 3, 1, 4, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 5, 1, 3 )				
		,( 1, 2, 4, 14, 3, 1, 5, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 6, 1, 3 )				
		,( 1, 2, 4, 14, 3, 1, 6, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 7, 1, 3 )				
		,( 1, 2, 4, 14, 3, 1, 7, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 8, 1, 3 )				
		,( 1, 2, 4, 14, 3, 1, 8, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 9, 1, 3 )				
		,( 1, 2, 4, 14, 3, 1, 9, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 10, 1, 3 )				
		,( 1, 2, 4, 14, 3, 1, 10, 2, 7 )				
		,( 1, 2, 4, 14, 3, 1, 10, 3, 1 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 14, 4, 2, 1, 1, 10 )					
		,( 1, 2, 4, 14, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 4, Player: 14, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 4, 14, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 4, 14, 4, 2, 2, 2, 5 )				
		,( 1, 2, 4, 14, 4, 2, 3, 1, 10 )				
		,( 1, 2, 4, 14, 4, 2, 3, 2, '' )				
		,( 1, 2, 4, 14, 4, 2, 4, 1, 5 )				
		,( 1, 2, 4, 14, 4, 2, 4, 2, 3 )				
		,( 1, 2, 4, 14, 4, 2, 5, 1, 2 )				
		,( 1, 2, 4, 14, 4, 2, 5, 2, '' )				
		,( 1, 2, 4, 14, 4, 2, 6, 1, 3 )				
		,( 1, 2, 4, 14, 4, 2, 6, 2, 2 )				
		,( 1, 2, 4, 14, 4, 2, 7, 1, 10 )				
		,( 1, 2, 4, 14, 4, 2, 7, 2, '' )				
		,( 1, 2, 4, 14, 4, 2, 8, 1, '' )				
		,( 1, 2, 4, 14, 4, 2, 8, 2, '' )				
		,( 1, 2, 4, 14, 4, 2, 9, 1, '' )				
		,( 1, 2, 4, 14, 4, 2, 9, 2, '' )				
		,( 1, 2, 4, 14, 4, 2, 10, 1, 4 )				
		,( 1, 2, 4, 14, 4, 2, 10, 2, 6 )				
		,( 1, 2, 4, 14, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 14, 5, 2, 1, 1, 10 )					
		,( 1, 2, 4, 14, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 4, 14, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 4, 14, 5, 2, 2, 2, '' )				
		,( 1, 2, 4, 14, 5, 2, 3, 1, 10 )				
		,( 1, 2, 4, 14, 5, 2, 3, 2, '' )				
		,( 1, 2, 4, 14, 5, 2, 4, 1, 10 )				
		,( 1, 2, 4, 14, 5, 2, 4, 2, '' )				
		,( 1, 2, 4, 14, 5, 2, 5, 1, 10 )				
		,( 1, 2, 4, 14, 5, 2, 5, 2, '' )				
		,( 1, 2, 4, 14, 5, 2, 6, 1, 10 )				
		,( 1, 2, 4, 14, 5, 2, 6, 2, '' )				
		,( 1, 2, 4, 14, 5, 2, 7, 1, 10 )				
		,( 1, 2, 4, 14, 5, 2, 7, 2, '' )				
		,( 1, 2, 4, 14, 5, 2, 8, 1, 10 )				
		,( 1, 2, 4, 14, 5, 2, 8, 2, '' )				
		,( 1, 2, 4, 14, 5, 2, 9, 1, 10 )				
		,( 1, 2, 4, 14, 5, 2, 9, 2, '' )				
		,( 1, 2, 4, 14, 5, 2, 10, 1, 10 )				
		,( 1, 2, 4, 14, 5, 2, 10, 2, 10 )				
		,( 1, 2, 4, 14, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 14, 6, 2, 1, 1, 3 )					
		,( 1, 2, 4, 14, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 4, Player: 14, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 4, 14, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 4, 14, 6, 2, 2, 2, 7 )				
		,( 1, 2, 4, 14, 6, 2, 3, 1, 3 )				
		,( 1, 2, 4, 14, 6, 2, 3, 2, 7 )				
		,( 1, 2, 4, 14, 6, 2, 4, 1, 1 )				
		,( 1, 2, 4, 14, 6, 2, 4, 2, 2 )				
		,( 1, 2, 4, 14, 6, 2, 5, 1, 10 )				
		,( 1, 2, 4, 14, 6, 2, 5, 2, '' )				
		,( 1, 2, 4, 14, 6, 2, 6, 1, 10 )				
		,( 1, 2, 4, 14, 6, 2, 6, 2, '' )				
		,( 1, 2, 4, 14, 6, 2, 7, 1, 3 )				
		,( 1, 2, 4, 14, 6, 2, 7, 2, 7 )				
		,( 1, 2, 4, 14, 6, 2, 8, 1, 3 )				
		,( 1, 2, 4, 14, 6, 2, 8, 2, 7 )				
		,( 1, 2, 4, 14, 6, 2, 9, 1, 3 )				
		,( 1, 2, 4, 14, 6, 2, 9, 2, 6 )				
		,( 1, 2, 4, 14, 6, 2, 10, 1, 10 )				
		,( 1, 2, 4, 14, 6, 2, 10, 2, 10 )				
		,( 1, 2, 4, 14, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 15, 1, 1, 1, 1, 3 )					
		,( 1, 2, 4, 15, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 4, 15, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 4, 15, 1, 1, 2, 2, 4 )				
		,( 1, 2, 4, 15, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 4, 15, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 4, 15, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 4, 15, 1, 1, 4, 2, 4 )				
		,( 1, 2, 4, 15, 1, 1, 5, 1, 3 )				
		,( 1, 2, 4, 15, 1, 1, 5, 2, 4 )				
		,( 1, 2, 4, 15, 1, 1, 6, 1, 3 )				
		,( 1, 2, 4, 15, 1, 1, 6, 2, 4 )				
		,( 1, 2, 4, 15, 1, 1, 7, 1, 3 )				
		,( 1, 2, 4, 15, 1, 1, 7, 2, 4 )				
		,( 1, 2, 4, 15, 1, 1, 8, 1, 3 )				
		,( 1, 2, 4, 15, 1, 1, 8, 2, 4 )				
		,( 1, 2, 4, 15, 1, 1, 9, 1, 3 )				
		,( 1, 2, 4, 15, 1, 1, 9, 2, 4 )				
		,( 1, 2, 4, 15, 1, 1, 10, 1, 3 )				
		,( 1, 2, 4, 15, 1, 1, 10, 2, 4 )				
		,( 1, 2, 4, 15, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 15, 2, 1, 1, 1, 3 )					
		,( 1, 2, 4, 15, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 4, 15, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 4, 15, 2, 1, 2, 2, 2 )				
		,( 1, 2, 4, 15, 2, 1, 3, 1, 3 )				
		,( 1, 2, 4, 15, 2, 1, 3, 2, 7 )				
		,( 1, 2, 4, 15, 2, 1, 4, 1, 3 )				
		,( 1, 2, 4, 15, 2, 1, 4, 2, 2 )				
		,( 1, 2, 4, 15, 2, 1, 5, 1, 3 )				
		,( 1, 2, 4, 15, 2, 1, 5, 2, '' )				
		,( 1, 2, 4, 15, 2, 1, 6, 1, 6 )				
		,( 1, 2, 4, 15, 2, 1, 6, 2, 4 )				
		,( 1, 2, 4, 15, 2, 1, 7, 1, 3 )				
		,( 1, 2, 4, 15, 2, 1, 7, 2, 4 )				
		,( 1, 2, 4, 15, 2, 1, 8, 1, '' )				
		,( 1, 2, 4, 15, 2, 1, 8, 2, 4 )				
		,( 1, 2, 4, 15, 2, 1, 9, 1, 3 )				
		,( 1, 2, 4, 15, 2, 1, 9, 2, 7 )				
		,( 1, 2, 4, 15, 2, 1, 10, 1, 1 )				
		,( 1, 2, 4, 15, 2, 1, 10, 2, 1 )				
		,( 1, 2, 4, 15, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 15, 3, 1, 1, 1, 3 )					
		,( 1, 2, 4, 15, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 3, Week: 1,Total score: 133	
		,( 1, 2, 4, 15, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 4, 15, 3, 1, 2, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 3, 1, 3 )				
		,( 1, 2, 4, 15, 3, 1, 3, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 4, 1, 3 )				
		,( 1, 2, 4, 15, 3, 1, 4, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 5, 1, 3 )				
		,( 1, 2, 4, 15, 3, 1, 5, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 6, 1, 3 )				
		,( 1, 2, 4, 15, 3, 1, 6, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 7, 1, 3 )				
		,( 1, 2, 4, 15, 3, 1, 7, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 8, 1, 3 )				
		,( 1, 2, 4, 15, 3, 1, 8, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 9, 1, 3 )				
		,( 1, 2, 4, 15, 3, 1, 9, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 10, 1, 3 )				
		,( 1, 2, 4, 15, 3, 1, 10, 2, 7 )				
		,( 1, 2, 4, 15, 3, 1, 10, 3, 6 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 15, 4, 2, 1, 1, 10 )					
		,( 1, 2, 4, 15, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 4, Player: 15, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 4, 15, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 4, 15, 4, 2, 2, 2, 5 )				
		,( 1, 2, 4, 15, 4, 2, 3, 1, 10 )				
		,( 1, 2, 4, 15, 4, 2, 3, 2, '' )				
		,( 1, 2, 4, 15, 4, 2, 4, 1, 5 )				
		,( 1, 2, 4, 15, 4, 2, 4, 2, 3 )				
		,( 1, 2, 4, 15, 4, 2, 5, 1, 2 )				
		,( 1, 2, 4, 15, 4, 2, 5, 2, '' )				
		,( 1, 2, 4, 15, 4, 2, 6, 1, 3 )				
		,( 1, 2, 4, 15, 4, 2, 6, 2, 2 )				
		,( 1, 2, 4, 15, 4, 2, 7, 1, 10 )				
		,( 1, 2, 4, 15, 4, 2, 7, 2, '' )				
		,( 1, 2, 4, 15, 4, 2, 8, 1, '' )				
		,( 1, 2, 4, 15, 4, 2, 8, 2, '' )				
		,( 1, 2, 4, 15, 4, 2, 9, 1, '' )				
		,( 1, 2, 4, 15, 4, 2, 9, 2, '' )				
		,( 1, 2, 4, 15, 4, 2, 10, 1, 4 )				
		,( 1, 2, 4, 15, 4, 2, 10, 2, 6 )				
		,( 1, 2, 4, 15, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 15, 5, 2, 1, 1, 10 )					
		,( 1, 2, 4, 15, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 4, 15, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 4, 15, 5, 2, 2, 2, '' )				
		,( 1, 2, 4, 15, 5, 2, 3, 1, 10 )				
		,( 1, 2, 4, 15, 5, 2, 3, 2, '' )				
		,( 1, 2, 4, 15, 5, 2, 4, 1, 10 )				
		,( 1, 2, 4, 15, 5, 2, 4, 2, '' )				
		,( 1, 2, 4, 15, 5, 2, 5, 1, 10 )				
		,( 1, 2, 4, 15, 5, 2, 5, 2, '' )				
		,( 1, 2, 4, 15, 5, 2, 6, 1, 10 )				
		,( 1, 2, 4, 15, 5, 2, 6, 2, '' )				
		,( 1, 2, 4, 15, 5, 2, 7, 1, 10 )				
		,( 1, 2, 4, 15, 5, 2, 7, 2, '' )				
		,( 1, 2, 4, 15, 5, 2, 8, 1, 10 )				
		,( 1, 2, 4, 15, 5, 2, 8, 2, '' )				
		,( 1, 2, 4, 15, 5, 2, 9, 1, 10 )				
		,( 1, 2, 4, 15, 5, 2, 9, 2, '' )				
		,( 1, 2, 4, 15, 5, 2, 10, 1, 10 )				
		,( 1, 2, 4, 15, 5, 2, 10, 2, 10 )				
		,( 1, 2, 4, 15, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 15, 6, 2, 1, 1, 3 )					
		,( 1, 2, 4, 15, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 4, Player: 15, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 4, 15, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 4, 15, 6, 2, 2, 2, 7 )				
		,( 1, 2, 4, 15, 6, 2, 3, 1, 3 )				
		,( 1, 2, 4, 15, 6, 2, 3, 2, 7 )				
		,( 1, 2, 4, 15, 6, 2, 4, 1, 1 )				
		,( 1, 2, 4, 15, 6, 2, 4, 2, 2 )				
		,( 1, 2, 4, 15, 6, 2, 5, 1, 10 )				
		,( 1, 2, 4, 15, 6, 2, 5, 2, '' )				
		,( 1, 2, 4, 15, 6, 2, 6, 1, 10 )				
		,( 1, 2, 4, 15, 6, 2, 6, 2, '' )				
		,( 1, 2, 4, 15, 6, 2, 7, 1, 3 )				
		,( 1, 2, 4, 15, 6, 2, 7, 2, 7 )				
		,( 1, 2, 4, 15, 6, 2, 8, 1, 3 )				
		,( 1, 2, 4, 15, 6, 2, 8, 2, 7 )				
		,( 1, 2, 4, 15, 6, 2, 9, 1, 3 )				
		,( 1, 2, 4, 15, 6, 2, 9, 2, 6 )				
		,( 1, 2, 4, 15, 6, 2, 10, 1, 10 )				
		,( 1, 2, 4, 15, 6, 2, 10, 2, 10 )				
		,( 1, 2, 4, 15, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 16, 1, 1, 1, 1, 3 )					
		,( 1, 2, 4, 16, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 4, 16, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 4, 16, 1, 1, 2, 2, 4 )				
		,( 1, 2, 4, 16, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 4, 16, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 4, 16, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 4, 16, 1, 1, 4, 2, 4 )				
		,( 1, 2, 4, 16, 1, 1, 5, 1, 3 )				
		,( 1, 2, 4, 16, 1, 1, 5, 2, 4 )				
		,( 1, 2, 4, 16, 1, 1, 6, 1, 3 )				
		,( 1, 2, 4, 16, 1, 1, 6, 2, 4 )				
		,( 1, 2, 4, 16, 1, 1, 7, 1, 3 )				
		,( 1, 2, 4, 16, 1, 1, 7, 2, 4 )				
		,( 1, 2, 4, 16, 1, 1, 8, 1, 3 )				
		,( 1, 2, 4, 16, 1, 1, 8, 2, 4 )				
		,( 1, 2, 4, 16, 1, 1, 9, 1, 3 )				
		,( 1, 2, 4, 16, 1, 1, 9, 2, 4 )				
		,( 1, 2, 4, 16, 1, 1, 10, 1, 3 )				
		,( 1, 2, 4, 16, 1, 1, 10, 2, 4 )				
		,( 1, 2, 4, 16, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 16, 2, 1, 1, 1, 3 )					
		,( 1, 2, 4, 16, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 4, 16, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 4, 16, 2, 1, 2, 2, 2 )				
		,( 1, 2, 4, 16, 2, 1, 3, 1, 3 )				
		,( 1, 2, 4, 16, 2, 1, 3, 2, 7 )				
		,( 1, 2, 4, 16, 2, 1, 4, 1, 3 )				
		,( 1, 2, 4, 16, 2, 1, 4, 2, 2 )				
		,( 1, 2, 4, 16, 2, 1, 5, 1, 3 )				
		,( 1, 2, 4, 16, 2, 1, 5, 2, '' )				
		,( 1, 2, 4, 16, 2, 1, 6, 1, 6 )				
		,( 1, 2, 4, 16, 2, 1, 6, 2, 4 )				
		,( 1, 2, 4, 16, 2, 1, 7, 1, 3 )				
		,( 1, 2, 4, 16, 2, 1, 7, 2, 4 )				
		,( 1, 2, 4, 16, 2, 1, 8, 1, '' )				
		,( 1, 2, 4, 16, 2, 1, 8, 2, 4 )				
		,( 1, 2, 4, 16, 2, 1, 9, 1, 3 )				
		,( 1, 2, 4, 16, 2, 1, 9, 2, 7 )				
		,( 1, 2, 4, 16, 2, 1, 10, 1, 1 )				
		,( 1, 2, 4, 16, 2, 1, 10, 2, 1 )				
		,( 1, 2, 4, 16, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 16, 3, 1, 1, 1, 3 )					
		,( 1, 2, 4, 16, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 3, Week: 1,Total score: 131	
		,( 1, 2, 4, 16, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 4, 16, 3, 1, 2, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 3, 1, 3 )				
		,( 1, 2, 4, 16, 3, 1, 3, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 4, 1, 3 )				
		,( 1, 2, 4, 16, 3, 1, 4, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 5, 1, 3 )				
		,( 1, 2, 4, 16, 3, 1, 5, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 6, 1, 3 )				
		,( 1, 2, 4, 16, 3, 1, 6, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 7, 1, 3 )				
		,( 1, 2, 4, 16, 3, 1, 7, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 8, 1, 3 )				
		,( 1, 2, 4, 16, 3, 1, 8, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 9, 1, 3 )				
		,( 1, 2, 4, 16, 3, 1, 9, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 10, 1, 3 )				
		,( 1, 2, 4, 16, 3, 1, 10, 2, 7 )				
		,( 1, 2, 4, 16, 3, 1, 10, 3, 4 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 16, 4, 2, 1, 1, 10 )					
		,( 1, 2, 4, 16, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 4, Player: 16, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 4, 16, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 4, 16, 4, 2, 2, 2, 5 )				
		,( 1, 2, 4, 16, 4, 2, 3, 1, 10 )				
		,( 1, 2, 4, 16, 4, 2, 3, 2, '' )				
		,( 1, 2, 4, 16, 4, 2, 4, 1, 5 )				
		,( 1, 2, 4, 16, 4, 2, 4, 2, 3 )				
		,( 1, 2, 4, 16, 4, 2, 5, 1, 2 )				
		,( 1, 2, 4, 16, 4, 2, 5, 2, '' )				
		,( 1, 2, 4, 16, 4, 2, 6, 1, 3 )				
		,( 1, 2, 4, 16, 4, 2, 6, 2, 2 )				
		,( 1, 2, 4, 16, 4, 2, 7, 1, 10 )				
		,( 1, 2, 4, 16, 4, 2, 7, 2, '' )				
		,( 1, 2, 4, 16, 4, 2, 8, 1, '' )				
		,( 1, 2, 4, 16, 4, 2, 8, 2, '' )				
		,( 1, 2, 4, 16, 4, 2, 9, 1, '' )				
		,( 1, 2, 4, 16, 4, 2, 9, 2, '' )				
		,( 1, 2, 4, 16, 4, 2, 10, 1, 4 )				
		,( 1, 2, 4, 16, 4, 2, 10, 2, 6 )				
		,( 1, 2, 4, 16, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 16, 5, 2, 1, 1, 10 )					
		,( 1, 2, 4, 16, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 4, 16, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 4, 16, 5, 2, 2, 2, '' )				
		,( 1, 2, 4, 16, 5, 2, 3, 1, 10 )				
		,( 1, 2, 4, 16, 5, 2, 3, 2, '' )				
		,( 1, 2, 4, 16, 5, 2, 4, 1, 10 )				
		,( 1, 2, 4, 16, 5, 2, 4, 2, '' )				
		,( 1, 2, 4, 16, 5, 2, 5, 1, 10 )				
		,( 1, 2, 4, 16, 5, 2, 5, 2, '' )				
		,( 1, 2, 4, 16, 5, 2, 6, 1, 10 )				
		,( 1, 2, 4, 16, 5, 2, 6, 2, '' )				
		,( 1, 2, 4, 16, 5, 2, 7, 1, 10 )				
		,( 1, 2, 4, 16, 5, 2, 7, 2, '' )				
		,( 1, 2, 4, 16, 5, 2, 8, 1, 10 )				
		,( 1, 2, 4, 16, 5, 2, 8, 2, '' )				
		,( 1, 2, 4, 16, 5, 2, 9, 1, 10 )				
		,( 1, 2, 4, 16, 5, 2, 9, 2, '' )				
		,( 1, 2, 4, 16, 5, 2, 10, 1, 10 )				
		,( 1, 2, 4, 16, 5, 2, 10, 2, 10 )				
		,( 1, 2, 4, 16, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 4, 16, 6, 2, 1, 1, 3 )					
		,( 1, 2, 4, 16, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 4, Player: 16, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 4, 16, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 4, 16, 6, 2, 2, 2, 7 )				
		,( 1, 2, 4, 16, 6, 2, 3, 1, 3 )				
		,( 1, 2, 4, 16, 6, 2, 3, 2, 7 )				
		,( 1, 2, 4, 16, 6, 2, 4, 1, 1 )				
		,( 1, 2, 4, 16, 6, 2, 4, 2, 2 )				
		,( 1, 2, 4, 16, 6, 2, 5, 1, 10 )				
		,( 1, 2, 4, 16, 6, 2, 5, 2, '' )				
		,( 1, 2, 4, 16, 6, 2, 6, 1, 10 )				
		,( 1, 2, 4, 16, 6, 2, 6, 2, '' )				
		,( 1, 2, 4, 16, 6, 2, 7, 1, 3 )				
		,( 1, 2, 4, 16, 6, 2, 7, 2, 7 )				
		,( 1, 2, 4, 16, 6, 2, 8, 1, 3 )				
		,( 1, 2, 4, 16, 6, 2, 8, 2, 7 )				
		,( 1, 2, 4, 16, 6, 2, 9, 1, 3 )				
		,( 1, 2, 4, 16, 6, 2, 9, 2, 6 )				
		,( 1, 2, 4, 16, 6, 2, 10, 1, 10 )				
		,( 1, 2, 4, 16, 6, 2, 10, 2, 10 )				
		,( 1, 2, 4, 16, 6, 2, 10, 3, 10 )				
		
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 17, 1, 1, 1, 1, 3 )					
		,( 1, 2, 5, 17, 1, 1, 1, 2, 4 )				
		,( 1, 2, 5, 17, 1, 1, 2, 1, 3 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 5, 17, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 2, 5, 17, 1, 1, 3, 1, 3 )				
		,( 1, 2, 5, 17, 1, 1, 3, 2, 4 )				
		,( 1, 2, 5, 17, 1, 1, 4, 1, 3 )				
		,( 1, 2, 5, 17, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 2, 5, 17, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 5, 17, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 2, 5, 17, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 5, 17, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 2, 5, 17, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 2, 5, 17, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 2, 5, 17, 1, 1, 8, 1, 3 )				
		,( 1, 2, 5, 17, 1, 1, 8, 2, 4 )				
		,( 1, 2, 5, 17, 1, 1, 9, 1, 3 )				
		,( 1, 2, 5, 17, 1, 1, 9, 2, 4 )				
		,( 1, 2, 5, 17, 1, 1, 10, 1, 3 )				
		,( 1, 2, 5, 17, 1, 1, 10, 2, 4 )				
		,( 1, 2, 5, 17, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 17, 2, 1, 1, 1, 3 )					
		,( 1, 2, 5, 17, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 5, 17, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 5, 17, 2, 1, 2, 2, 2 )				
		,( 1, 2, 5, 17, 2, 1, 3, 1, 3 )				
		,( 1, 2, 5, 17, 2, 1, 3, 2, 7 )				
		,( 1, 2, 5, 17, 2, 1, 4, 1, 3 )				
		,( 1, 2, 5, 17, 2, 1, 4, 2, 2 )				
		,( 1, 2, 5, 17, 2, 1, 5, 1, 3 )				
		,( 1, 2, 5, 17, 2, 1, 5, 2, '' )				
		,( 1, 2, 5, 17, 2, 1, 6, 1, 6 )				
		,( 1, 2, 5, 17, 2, 1, 6, 2, 4 )				
		,( 1, 2, 5, 17, 2, 1, 7, 1, 3 )				
		,( 1, 2, 5, 17, 2, 1, 7, 2, 4 )				
		,( 1, 2, 5, 17, 2, 1, 8, 1, '' )				
		,( 1, 2, 5, 17, 2, 1, 8, 2, 4 )				
		,( 1, 2, 5, 17, 2, 1, 9, 1, 3 )				
		,( 1, 2, 5, 17, 2, 1, 9, 2, 7 )				
		,( 1, 2, 5, 17, 2, 1, 10, 1, 1 )				
		,( 1, 2, 5, 17, 2, 1, 10, 2, 1 )				
		,( 1, 2, 5, 17, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 17, 3, 1, 1, 1, 3 )					
		,( 1, 2, 5, 17, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game: 3, Week: 1,Total score: 132	
		,( 1, 2, 5, 17, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 5, 17, 3, 1, 2, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 3, 1, 3 )				
		,( 1, 2, 5, 17, 3, 1, 3, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 4, 1, 3 )				
		,( 1, 2, 5, 17, 3, 1, 4, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 5, 1, 3 )				
		,( 1, 2, 5, 17, 3, 1, 5, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 6, 1, 3 )				
		,( 1, 2, 5, 17, 3, 1, 6, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 7, 1, 3 )				
		,( 1, 2, 5, 17, 3, 1, 7, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 8, 1, 3 )				
		,( 1, 2, 5, 17, 3, 1, 8, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 9, 1, 3 )				
		,( 1, 2, 5, 17, 3, 1, 9, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 10, 1, 3 )				
		,( 1, 2, 5, 17, 3, 1, 10, 2, 7 )				
		,( 1, 2, 5, 17, 3, 1, 10, 3, 5 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 17, 4, 2, 1, 1, 10 )					
		,( 1, 2, 5, 17, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 5, Player: 17, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 5, 17, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 5, 17, 4, 2, 2, 2, 5 )				
		,( 1, 2, 5, 17, 4, 2, 3, 1, 10 )				
		,( 1, 2, 5, 17, 4, 2, 3, 2, '' )				
		,( 1, 2, 5, 17, 4, 2, 4, 1, 5 )				
		,( 1, 2, 5, 17, 4, 2, 4, 2, 3 )				
		,( 1, 2, 5, 17, 4, 2, 5, 1, 2 )				
		,( 1, 2, 5, 17, 4, 2, 5, 2, '' )				
		,( 1, 2, 5, 17, 4, 2, 6, 1, 3 )				
		,( 1, 2, 5, 17, 4, 2, 6, 2, 2 )				
		,( 1, 2, 5, 17, 4, 2, 7, 1, 10 )				
		,( 1, 2, 5, 17, 4, 2, 7, 2, '' )				
		,( 1, 2, 5, 17, 4, 2, 8, 1, '' )				
		,( 1, 2, 5, 17, 4, 2, 8, 2, '' )				
		,( 1, 2, 5, 17, 4, 2, 9, 1, '' )				
		,( 1, 2, 5, 17, 4, 2, 9, 2, '' )				
		,( 1, 2, 5, 17, 4, 2, 10, 1, 4 )				
		,( 1, 2, 5, 17, 4, 2, 10, 2, 6 )				
		,( 1, 2, 5, 17, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 17, 5, 2, 1, 1, 10 )					
		,( 1, 2, 5, 17, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 5, Player: 17, Game:5, Week: 2,Total score: 300	
		,( 1, 2, 5, 17, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 5, 17, 5, 2, 2, 2, '' )				
		,( 1, 2, 5, 17, 5, 2, 3, 1, 10 )				
		,( 1, 2, 5, 17, 5, 2, 3, 2, '' )				
 		,( 1, 2, 5, 17, 5, 2, 4, 1, 10 )				
		,( 1, 2, 5, 17, 5, 2, 4, 2, '' )				
		,( 1, 2, 5, 17, 5, 2, 5, 1, 10 )				
		,( 1, 2, 5, 17, 5, 2, 5, 2, '' )				
		,( 1, 2, 5, 17, 5, 2, 6, 1, 10 )				
		,( 1, 2, 5, 17, 5, 2, 6, 2, '' )				
		,( 1, 2, 5, 17, 5, 2, 7, 1, 10 )				
		,( 1, 2, 5, 17, 5, 2, 7, 2, '' )				
		,( 1, 2, 5, 17, 5, 2, 8, 1, 10 )				
		,( 1, 2, 5, 17, 5, 2, 8, 2, '' )				
		,( 1, 2, 5, 17, 5, 2, 9, 1, 10 )				
		,( 1, 2, 5, 17, 5, 2, 9, 2, '' )				
		,( 1, 2, 5, 17, 5, 2, 10, 1, 10 )				
		,( 1, 2, 5, 17, 5, 2, 10, 2, 10 )				
		,( 1, 2, 5, 17, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 17, 6, 2, 1, 1, 3 )					
		,( 1, 2, 5, 17, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 5, Player: 17, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 5, 17, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 5, 17, 6, 2, 2, 2, 7 )				
		,( 1, 2, 5, 17, 6, 2, 3, 1, 3 )				
		,( 1, 2, 5, 17, 6, 2, 3, 2, 7 )				
		,( 1, 2, 5, 17, 6, 2, 4, 1, 1 )				
		,( 1, 2, 5, 17, 6, 2, 4, 2, 2 )				
		,( 1, 2, 5, 17, 6, 2, 5, 1, 10 )				
		,( 1, 2, 5, 17, 6, 2, 5, 2, '' )				
		,( 1, 2, 5, 17, 6, 2, 6, 1, 10 )				
		,( 1, 2, 5, 17, 6, 2, 6, 2, '' )				
		,( 1, 2, 5, 17, 6, 2, 7, 1, 3 )				
		,( 1, 2, 5, 17, 6, 2, 7, 2, 7 )				
		,( 1, 2, 5, 17, 6, 2, 8, 1, 3 )				
		,( 1, 2, 5, 17, 6, 2, 8, 2, 7 )				
		,( 1, 2, 5, 17, 6, 2, 9, 1, 3 )				
		,( 1, 2, 5, 17, 6, 2, 9, 2, 6 )				
		,( 1, 2, 5, 17, 6, 2, 10, 1, 10 )				
		,( 1, 2, 5, 17, 6, 2, 10, 2, 10 )				
		,( 1, 2, 5, 17, 6, 2, 10, 3, 10 )				
	
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 18, 1, 1, 1, 1, 3 )					
		,( 1, 2, 5, 18, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 5, 18, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 5, 18, 1, 1, 2, 2, 4 )				
		,( 1, 2, 5, 18, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 5, 18, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 5, 18, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 5, 18, 1, 1, 4, 2, 4 )				
		,( 1, 2, 5, 18, 1, 1, 5, 1, 3 )				
		,( 1, 2, 5, 18, 1, 1, 5, 2, 4 )				
		,( 1, 2, 5, 18, 1, 1, 6, 1, 3 )				
		,( 1, 2, 5, 18, 1, 1, 6, 2, 4 )				
		,( 1, 2, 5, 18, 1, 1, 7, 1, 3 )				
		,( 1, 2, 5, 18, 1, 1, 7, 2, 4 )				
		,( 1, 2, 5, 18, 1, 1, 8, 1, 3 )				
		,( 1, 2, 5, 18, 1, 1, 8, 2, 4 )				
		,( 1, 2, 5, 18, 1, 1, 9, 1, 3 )				
		,( 1, 2, 5, 18, 1, 1, 9, 2, 4 )				
		,( 1, 2, 5, 18, 1, 1, 10, 1, 3 )				
		,( 1, 2, 5, 18, 1, 1, 10, 2, 4 )				
		,( 1, 2, 5, 18, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 18, 2, 1, 1, 1, 3 )					
		,( 1, 2, 5, 18, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 5, 18, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 5, 18, 2, 1, 2, 2, 2 )				
		,( 1, 2, 5, 18, 2, 1, 3, 1, 3 )				
		,( 1, 2, 5, 18, 2, 1, 3, 2, 7 )				
		,( 1, 2, 5, 18, 2, 1, 4, 1, 3 )				
		,( 1, 2, 5, 18, 2, 1, 4, 2, 2 )				
		,( 1, 2, 5, 18, 2, 1, 5, 1, 3 )				
		,( 1, 2, 5, 18, 2, 1, 5, 2, '' )				
		,( 1, 2, 5, 18, 2, 1, 6, 1, 6 )				
		,( 1, 2, 5, 18, 2, 1, 6, 2, 4 )				
		,( 1, 2, 5, 18, 2, 1, 7, 1, 3 )				
		,( 1, 2, 5, 18, 2, 1, 7, 2, 4 )				
		,( 1, 2, 5, 18, 2, 1, 8, 1, '' )				
		,( 1, 2, 5, 18, 2, 1, 8, 2, 4 )				
		,( 1, 2, 5, 18, 2, 1, 9, 1, 3 )				
		,( 1, 2, 5, 18, 2, 1, 9, 2, 7 )				
		,( 1, 2, 5, 18, 2, 1, 10, 1, 1 )				
		,( 1, 2, 5, 18, 2, 1, 10, 2, 1 )				
		,( 1, 2, 5, 18, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 18, 3, 1, 1, 1, 3 )					
		,( 1, 2, 5, 18, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 3, Week: 1,Total score: 129	
		,( 1, 2, 5, 18, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 5, 18, 3, 1, 2, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 3, 1, 3 )				
		,( 1, 2, 5, 18, 3, 1, 3, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 4, 1, 3 )				
		,( 1, 2, 5, 18, 3, 1, 4, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 5, 1, 3 )				
		,( 1, 2, 5, 18, 3, 1, 5, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 6, 1, 3 )				
		,( 1, 2, 5, 18, 3, 1, 6, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 7, 1, 3 )				
		,( 1, 2, 5, 18, 3, 1, 7, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 8, 1, 3 )				
		,( 1, 2, 5, 18, 3, 1, 8, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 9, 1, 3 )				
		,( 1, 2, 5, 18, 3, 1, 9, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 10, 1, 3 )				
		,( 1, 2, 5, 18, 3, 1, 10, 2, 7 )				
		,( 1, 2, 5, 18, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 18, 4, 2, 1, 1, 10 )					
		,( 1, 2, 5, 18, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 5, Player: 18, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 5, 18, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 5, 18, 4, 2, 2, 2, 5 )				
		,( 1, 2, 5, 18, 4, 2, 3, 1, 10 )				
		,( 1, 2, 5, 18, 4, 2, 3, 2, '' )				
		,( 1, 2, 5, 18, 4, 2, 4, 1, 5 )				
		,( 1, 2, 5, 18, 4, 2, 4, 2, 3 )				
		,( 1, 2, 5, 18, 4, 2, 5, 1, 2 )				
		,( 1, 2, 5, 18, 4, 2, 5, 2, '' )				
		,( 1, 2, 5, 18, 4, 2, 6, 1, 3 )				
		,( 1, 2, 5, 18, 4, 2, 6, 2, 2 )				
		,( 1, 2, 5, 18, 4, 2, 7, 1, 10 )				
		,( 1, 2, 5, 18, 4, 2, 7, 2, '' )				
		,( 1, 2, 5, 18, 4, 2, 8, 1, '' )				
		,( 1, 2, 5, 18, 4, 2, 8, 2, '' )				
		,( 1, 2, 5, 18, 4, 2, 9, 1, '' )				
		,( 1, 2, 5, 18, 4, 2, 9, 2, '' )				
		,( 1, 2, 5, 18, 4, 2, 10, 1, 4 )				
		,( 1, 2, 5, 18, 4, 2, 10, 2, 6 )				
		,( 1, 2, 5, 18, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 18, 5, 2, 1, 1, 10 )					
		,( 1, 2, 5, 18, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 5, 18, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 5, 18, 5, 2, 2, 2, '' )				
		,( 1, 2, 5, 18, 5, 2, 3, 1, 10 )				
		,( 1, 2, 5, 18, 5, 2, 3, 2, '' )				
		,( 1, 2, 5, 18, 5, 2, 4, 1, 10 )				
		,( 1, 2, 5, 18, 5, 2, 4, 2, '' )				
		,( 1, 2, 5, 18, 5, 2, 5, 1, 10 )				
		,( 1, 2, 5, 18, 5, 2, 5, 2, '' )				
		,( 1, 2, 5, 18, 5, 2, 6, 1, 10 )				
		,( 1, 2, 5, 18, 5, 2, 6, 2, '' )				
		,( 1, 2, 5, 18, 5, 2, 7, 1, 10 )				
		,( 1, 2, 5, 18, 5, 2, 7, 2, '' )				
		,( 1, 2, 5, 18, 5, 2, 8, 1, 10 )				
		,( 1, 2, 5, 18, 5, 2, 8, 2, '' )				
		,( 1, 2, 5, 18, 5, 2, 9, 1, 10 )				
		,( 1, 2, 5, 18, 5, 2, 9, 2, '' )				
		,( 1, 2, 5, 18, 5, 2, 10, 1, 10 )				
		,( 1, 2, 5, 18, 5, 2, 10, 2, 10 )				
		,( 1, 2, 5, 18, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 18, 6, 2, 1, 1, 3 )					
		,( 1, 2, 5, 18, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 5, Player: 18, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 5, 18, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 5, 18, 6, 2, 2, 2, 7 )				
		,( 1, 2, 5, 18, 6, 2, 3, 1, 3 )				
		,( 1, 2, 5, 18, 6, 2, 3, 2, 7 )				
		,( 1, 2, 5, 18, 6, 2, 4, 1, 1 )				
		,( 1, 2, 5, 18, 6, 2, 4, 2, 2 )				
		,( 1, 2, 5, 18, 6, 2, 5, 1, 10 )				
		,( 1, 2, 5, 18, 6, 2, 5, 2, '' )				
		,( 1, 2, 5, 18, 6, 2, 6, 1, 10 )				
		,( 1, 2, 5, 18, 6, 2, 6, 2, '' )				
		,( 1, 2, 5, 18, 6, 2, 7, 1, 3 )				
		,( 1, 2, 5, 18, 6, 2, 7, 2, 7 )				
		,( 1, 2, 5, 18, 6, 2, 8, 1, 3 )				
		,( 1, 2, 5, 18, 6, 2, 8, 2, 7 )				
		,( 1, 2, 5, 18, 6, 2, 9, 1, 3 )				
		,( 1, 2, 5, 18, 6, 2, 9, 2, 6 )				
		,( 1, 2, 5, 18, 6, 2, 10, 1, 10 )				
		,( 1, 2, 5, 18, 6, 2, 10, 2, 10 )				
		,( 1, 2, 5, 18, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 19, 1, 1, 1, 1, 3 )					
		,( 1, 2, 5, 19, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 5, 19, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 5, 19, 1, 1, 2, 2, 4 )				
		,( 1, 2, 5, 19, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 5, 19, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 5, 19, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 5, 19, 1, 1, 4, 2, 4 )				
		,( 1, 2, 5, 19, 1, 1, 5, 1, 3 )				
		,( 1, 2, 5, 19, 1, 1, 5, 2, 4 )				
		,( 1, 2, 5, 19, 1, 1, 6, 1, 3 )				
		,( 1, 2, 5, 19, 1, 1, 6, 2, 4 )				
		,( 1, 2, 5, 19, 1, 1, 7, 1, 3 )				
		,( 1, 2, 5, 19, 1, 1, 7, 2, 4 )				
		,( 1, 2, 5, 19, 1, 1, 8, 1, 3 )				
		,( 1, 2, 5, 19, 1, 1, 8, 2, 4 )				
		,( 1, 2, 5, 19, 1, 1, 9, 1, 3 )				
		,( 1, 2, 5, 19, 1, 1, 9, 2, 4 )				
		,( 1, 2, 5, 19, 1, 1, 10, 1, 3 )				
		,( 1, 2, 5, 19, 1, 1, 10, 2, 4 )				
		,( 1, 2, 5, 19, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 19, 2, 1, 1, 1, 3 )					
		,( 1, 2, 5, 19, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 5, 19, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 5, 19, 2, 1, 2, 2, 2 )				
		,( 1, 2, 5, 19, 2, 1, 3, 1, 3 )				
		,( 1, 2, 5, 19, 2, 1, 3, 2, 7 )				
		,( 1, 2, 5, 19, 2, 1, 4, 1, 3 )				
		,( 1, 2, 5, 19, 2, 1, 4, 2, 2 )				
		,( 1, 2, 5, 19, 2, 1, 5, 1, 3 )				
		,( 1, 2, 5, 19, 2, 1, 5, 2, '' )				
		,( 1, 2, 5, 19, 2, 1, 6, 1, 6 )				
		,( 1, 2, 5, 19, 2, 1, 6, 2, 4 )				
		,( 1, 2, 5, 19, 2, 1, 7, 1, 3 )				
		,( 1, 2, 5, 19, 2, 1, 7, 2, 4 )				
		,( 1, 2, 5, 19, 2, 1, 8, 1, '' )				
		,( 1, 2, 5, 19, 2, 1, 8, 2, 4 )				
		,( 1, 2, 5, 19, 2, 1, 9, 1, 3 )				
		,( 1, 2, 5, 19, 2, 1, 9, 2, 7 )				
		,( 1, 2, 5, 19, 2, 1, 10, 1, 1 )				
		,( 1, 2, 5, 19, 2, 1, 10, 2, 1 )				
		,( 1, 2, 5, 19, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 19, 3, 1, 1, 1, 3 )					
		,( 1, 2, 5, 19, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 3, Week: 1,Total score: 134	
		,( 1, 2, 5, 19, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 5, 19, 3, 1, 2, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 3, 1, 3 )				
		,( 1, 2, 5, 19, 3, 1, 3, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 4, 1, 3 )				
		,( 1, 2, 5, 19, 3, 1, 4, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 5, 1, 3 )				
		,( 1, 2, 5, 19, 3, 1, 5, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 6, 1, 3 )				
		,( 1, 2, 5, 19, 3, 1, 6, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 7, 1, 3 )				
		,( 1, 2, 5, 19, 3, 1, 7, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 8, 1, 3 )				
		,( 1, 2, 5, 19, 3, 1, 8, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 9, 1, 3 )				
		,( 1, 2, 5, 19, 3, 1, 9, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 10, 1, 3 )				
		,( 1, 2, 5, 19, 3, 1, 10, 2, 7 )				
		,( 1, 2, 5, 19, 3, 1, 10, 3, 7 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 19, 4, 2, 1, 1, 10 )					
		,( 1, 2, 5, 19, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 5, Player: 19, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 5, 19, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 5, 19, 4, 2, 2, 2, 5 )				
		,( 1, 2, 5, 19, 4, 2, 3, 1, 10 )				
		,( 1, 2, 5, 19, 4, 2, 3, 2, '' )				
		,( 1, 2, 5, 19, 4, 2, 4, 1, 5 )				
		,( 1, 2, 5, 19, 4, 2, 4, 2, 3 )				
		,( 1, 2, 5, 19, 4, 2, 5, 1, 2 )				
		,( 1, 2, 5, 19, 4, 2, 5, 2, '' )				
		,( 1, 2, 5, 19, 4, 2, 6, 1, 3 )				
		,( 1, 2, 5, 19, 4, 2, 6, 2, 2 )				
		,( 1, 2, 5, 19, 4, 2, 7, 1, 10 )				
		,( 1, 2, 5, 19, 4, 2, 7, 2, '' )				
		,( 1, 2, 5, 19, 4, 2, 8, 1, '' )				
		,( 1, 2, 5, 19, 4, 2, 8, 2, '' )				
		,( 1, 2, 5, 19, 4, 2, 9, 1, '' )				
		,( 1, 2, 5, 19, 4, 2, 9, 2, '' )				
		,( 1, 2, 5, 19, 4, 2, 10, 1, 4 )				
		,( 1, 2, 5, 19, 4, 2, 10, 2, 6 )				
		,( 1, 2, 5, 19, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 19, 5, 2, 1, 1, 10 )					
		,( 1, 2, 5, 19, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 5, 19, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 5, 19, 5, 2, 2, 2, '' )				
		,( 1, 2, 5, 19, 5, 2, 3, 1, 10 )				
		,( 1, 2, 5, 19, 5, 2, 3, 2, '' )				
		,( 1, 2, 5, 19, 5, 2, 4, 1, 10 )				
		,( 1, 2, 5, 19, 5, 2, 4, 2, '' )				
		,( 1, 2, 5, 19, 5, 2, 5, 1, 10 )				
		,( 1, 2, 5, 19, 5, 2, 5, 2, '' )				
		,( 1, 2, 5, 19, 5, 2, 6, 1, 10 )				
		,( 1, 2, 5, 19, 5, 2, 6, 2, '' )				
		,( 1, 2, 5, 19, 5, 2, 7, 1, 10 )				
		,( 1, 2, 5, 19, 5, 2, 7, 2, '' )				
		,( 1, 2, 5, 19, 5, 2, 8, 1, 10 )				
		,( 1, 2, 5, 19, 5, 2, 8, 2, '' )				
		,( 1, 2, 5, 19, 5, 2, 9, 1, 10 )				
		,( 1, 2, 5, 19, 5, 2, 9, 2, '' )				
		,( 1, 2, 5, 19, 5, 2, 10, 1, 10 )				
		,( 1, 2, 5, 19, 5, 2, 10, 2, 10 )				
		,( 1, 2, 5, 19, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 19, 6, 2, 1, 1, 3 )					
		,( 1, 2, 5, 19, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 5, Player: 19, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 5, 19, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 5, 19, 6, 2, 2, 2, 7 )				
		,( 1, 2, 5, 19, 6, 2, 3, 1, 3 )				
		,( 1, 2, 5, 19, 6, 2, 3, 2, 7 )				
		,( 1, 2, 5, 19, 6, 2, 4, 1, 1 )				
		,( 1, 2, 5, 19, 6, 2, 4, 2, 2 )				
		,( 1, 2, 5, 19, 6, 2, 5, 1, 10 )				
		,( 1, 2, 5, 19, 6, 2, 5, 2, '' )				
		,( 1, 2, 5, 19, 6, 2, 6, 1, 10 )				
		,( 1, 2, 5, 19, 6, 2, 6, 2, '' )				
		,( 1, 2, 5, 19, 6, 2, 7, 1, 3 )				
		,( 1, 2, 5, 19, 6, 2, 7, 2, 7 )				
		,( 1, 2, 5, 19, 6, 2, 8, 1, 3 )				
		,( 1, 2, 5, 19, 6, 2, 8, 2, 7 )				
		,( 1, 2, 5, 19, 6, 2, 9, 1, 3 )				
		,( 1, 2, 5, 19, 6, 2, 9, 2, 6 )				
		,( 1, 2, 5, 19, 6, 2, 10, 1, 10 )				
		,( 1, 2, 5, 19, 6, 2, 10, 2, 10 )				
		,( 1, 2, 5, 19, 6, 2, 10, 3, 10 )				
				
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 20, 1, 1, 1, 1, 3 )					
		,( 1, 2, 5, 20, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 5, 20, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 5, 20, 1, 1, 2, 2, 4 )				
		,( 1, 2, 5, 20, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 5, 20, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 5, 20, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 5, 20, 1, 1, 4, 2, 4 )				
		,( 1, 2, 5, 20, 1, 1, 5, 1, 3 )				
		,( 1, 2, 5, 20, 1, 1, 5, 2, 4 )				
		,( 1, 2, 5, 20, 1, 1, 6, 1, 3 )				
		,( 1, 2, 5, 20, 1, 1, 6, 2, 4 )				
		,( 1, 2, 5, 20, 1, 1, 7, 1, 3 )				
		,( 1, 2, 5, 20, 1, 1, 7, 2, 4 )				
		,( 1, 2, 5, 20, 1, 1, 8, 1, 3 )				
		,( 1, 2, 5, 20, 1, 1, 8, 2, 4 )				
		,( 1, 2, 5, 20, 1, 1, 9, 1, 3 )				
		,( 1, 2, 5, 20, 1, 1, 9, 2, 4 )				
		,( 1, 2, 5, 20, 1, 1, 10, 1, 3 )				
		,( 1, 2, 5, 20, 1, 1, 10, 2, 4 )				
		,( 1, 2, 5, 20, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 20, 2, 1, 1, 1, 3 )					
		,( 1, 2, 5, 20, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 5, 20, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 5, 20, 2, 1, 2, 2, 2 )				
		,( 1, 2, 5, 20, 2, 1, 3, 1, 3 )				
		,( 1, 2, 5, 20, 2, 1, 3, 2, 7 )				
		,( 1, 2, 5, 20, 2, 1, 4, 1, 3 )				
		,( 1, 2, 5, 20, 2, 1, 4, 2, 2 )				
		,( 1, 2, 5, 20, 2, 1, 5, 1, 3 )				
		,( 1, 2, 5, 20, 2, 1, 5, 2, '' )				
		,( 1, 2, 5, 20, 2, 1, 6, 1, 6 )				
		,( 1, 2, 5, 20, 2, 1, 6, 2, 4 )				
		,( 1, 2, 5, 20, 2, 1, 7, 1, 3 )				
		,( 1, 2, 5, 20, 2, 1, 7, 2, 4 )				
		,( 1, 2, 5, 20, 2, 1, 8, 1, '' )				
		,( 1, 2, 5, 20, 2, 1, 8, 2, 4 )				
		,( 1, 2, 5, 20, 2, 1, 9, 1, 3 )				
		,( 1, 2, 5, 20, 2, 1, 9, 2, 7 )				
		,( 1, 2, 5, 20, 2, 1, 10, 1, 1 )				
		,( 1, 2, 5, 20, 2, 1, 10, 2, 1 )				
		,( 1, 2, 5, 20, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 20, 3, 1, 1, 1, 3 )					
		,( 1, 2, 5, 20, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 3, Week: 1,Total score: 133	
		,( 1, 2, 5, 20, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 5, 20, 3, 1, 2, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 3, 1, 3 )				
		,( 1, 2, 5, 20, 3, 1, 3, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 4, 1, 3 )				
		,( 1, 2, 5, 20, 3, 1, 4, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 5, 1, 3 )				
		,( 1, 2, 5, 20, 3, 1, 5, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 6, 1, 3 )				
		,( 1, 2, 5, 20, 3, 1, 6, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 7, 1, 3 )				
		,( 1, 2, 5, 20, 3, 1, 7, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 8, 1, 3 )				
		,( 1, 2, 5, 20, 3, 1, 8, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 9, 1, 3 )				
		,( 1, 2, 5, 20, 3, 1, 9, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 10, 1, 3 )				
		,( 1, 2, 5, 20, 3, 1, 10, 2, 7 )				
		,( 1, 2, 5, 20, 3, 1, 10, 3, 6 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 20, 4, 2, 1, 1, 10 )					
		,( 1, 2, 5, 20, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 5, Player: 20, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 5, 20, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 5, 20, 4, 2, 2, 2, 5 )				
		,( 1, 2, 5, 20, 4, 2, 3, 1, 10 )				
		,( 1, 2, 5, 20, 4, 2, 3, 2, '' )				
		,( 1, 2, 5, 20, 4, 2, 4, 1, 5 )				
		,( 1, 2, 5, 20, 4, 2, 4, 2, 3 )				
		,( 1, 2, 5, 20, 4, 2, 5, 1, 2 )				
		,( 1, 2, 5, 20, 4, 2, 5, 2, '' )				
		,( 1, 2, 5, 20, 4, 2, 6, 1, 3 )				
		,( 1, 2, 5, 20, 4, 2, 6, 2, 2 )				
		,( 1, 2, 5, 20, 4, 2, 7, 1, 10 )				
		,( 1, 2, 5, 20, 4, 2, 7, 2, '' )				
		,( 1, 2, 5, 20, 4, 2, 8, 1, '' )				
		,( 1, 2, 5, 20, 4, 2, 8, 2, '' )				
		,( 1, 2, 5, 20, 4, 2, 9, 1, '' )				
		,( 1, 2, 5, 20, 4, 2, 9, 2, '' )				
		,( 1, 2, 5, 20, 4, 2, 10, 1, 4 )				
		,( 1, 2, 5, 20, 4, 2, 10, 2, 6 )				
		,( 1, 2, 5, 20, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 20, 5, 2, 1, 1, 10 )					
		,( 1, 2, 5, 20, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 5, 20, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 5, 20, 5, 2, 2, 2, '' )				
		,( 1, 2, 5, 20, 5, 2, 3, 1, 10 )				
		,( 1, 2, 5, 20, 5, 2, 3, 2, '' )				
		,( 1, 2, 5, 20, 5, 2, 4, 1, 10 )				
		,( 1, 2, 5, 20, 5, 2, 4, 2, '' )				
		,( 1, 2, 5, 20, 5, 2, 5, 1, 10 )				
		,( 1, 2, 5, 20, 5, 2, 5, 2, '' )				
		,( 1, 2, 5, 20, 5, 2, 6, 1, 10 )				
		,( 1, 2, 5, 20, 5, 2, 6, 2, '' )				
		,( 1, 2, 5, 20, 5, 2, 7, 1, 10 )				
		,( 1, 2, 5, 20, 5, 2, 7, 2, '' )				
		,( 1, 2, 5, 20, 5, 2, 8, 1, 10 )				
		,( 1, 2, 5, 20, 5, 2, 8, 2, '' )				
		,( 1, 2, 5, 20, 5, 2, 9, 1, 10 )				
		,( 1, 2, 5, 20, 5, 2, 9, 2, '' )				
		,( 1, 2, 5, 20, 5, 2, 10, 1, 10 )				
		,( 1, 2, 5, 20, 5, 2, 10, 2, 10 )				
		,( 1, 2, 5, 20, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 5, 20, 6, 2, 1, 1, 3 )					
		,( 1, 2, 5, 20, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 5, Player: 20, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 5, 20, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 5, 20, 6, 2, 2, 2, 7 )				
		,( 1, 2, 5, 20, 6, 2, 3, 1, 3 )				
		,( 1, 2, 5, 20, 6, 2, 3, 2, 7 )				
		,( 1, 2, 5, 20, 6, 2, 4, 1, 1 )				
		,( 1, 2, 5, 20, 6, 2, 4, 2, 2 )				
		,( 1, 2, 5, 20, 6, 2, 5, 1, 10 )				
		,( 1, 2, 5, 20, 6, 2, 5, 2, '' )				
		,( 1, 2, 5, 20, 6, 2, 6, 1, 10 )				
		,( 1, 2, 5, 20, 6, 2, 6, 2, '' )				
		,( 1, 2, 5, 20, 6, 2, 7, 1, 3 )				
		,( 1, 2, 5, 20, 6, 2, 7, 2, 7 )				
		,( 1, 2, 5, 20, 6, 2, 8, 1, 3 )				
		,( 1, 2, 5, 20, 6, 2, 8, 2, 7 )				
		,( 1, 2, 5, 20, 6, 2, 9, 1, 3 )				
		,( 1, 2, 5, 20, 6, 2, 9, 2, 6 )				
		,( 1, 2, 5, 20, 6, 2, 10, 1, 10 )				
		,( 1, 2, 5, 20, 6, 2, 10, 2, 10 )				
		,( 1, 2, 5, 20, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 21, 1, 1, 1, 1, 3 )					
		,( 1, 2, 6, 21, 1, 1, 1, 2, 4 )				
		,( 1, 2, 6, 21, 1, 1, 2, 1, 3 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 6, 21, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 2, 6, 21, 1, 1, 3, 1, 3 )				
		,( 1, 2, 6, 21, 1, 1, 3, 2, 4 )				
		,( 1, 2, 6, 21, 1, 1, 4, 1, 3 )				
		,( 1, 2, 6, 21, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 2, 6, 21, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 6, 21, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 2, 6, 21, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 6, 21, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 2, 6, 21, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 2, 6, 21, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 2, 6, 21, 1, 1, 8, 1, 3 )				
		,( 1, 2, 6, 21, 1, 1, 8, 2, 4 )				
		,( 1, 2, 6, 21, 1, 1, 9, 1, 3 )				
		,( 1, 2, 6, 21, 1, 1, 9, 2, 4 )				
		,( 1, 2, 6, 21, 1, 1, 10, 1, 3 )				
		,( 1, 2, 6, 21, 1, 1, 10, 2, 4 )				
		,( 1, 2, 6, 21, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 21, 2, 1, 1, 1, 3 )					
		,( 1, 2, 6, 21, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 6, 21, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 6, 21, 2, 1, 2, 2, 2 )				
		,( 1, 2, 6, 21, 2, 1, 3, 1, 3 )				
		,( 1, 2, 6, 21, 2, 1, 3, 2, 7 )				
		,( 1, 2, 6, 21, 2, 1, 4, 1, 3 )				
		,( 1, 2, 6, 21, 2, 1, 4, 2, 2 )				
		,( 1, 2, 6, 21, 2, 1, 5, 1, 3 )				
		,( 1, 2, 6, 21, 2, 1, 5, 2, '' )				
		,( 1, 2, 6, 21, 2, 1, 6, 1, 6 )				
		,( 1, 2, 6, 21, 2, 1, 6, 2, 4 )				
		,( 1, 2, 6, 21, 2, 1, 7, 1, 3 )				
		,( 1, 2, 6, 21, 2, 1, 7, 2, 4 )				
		,( 1, 2, 6, 21, 2, 1, 8, 1, '' )				
		,( 1, 2, 6, 21, 2, 1, 8, 2, 4 )				
		,( 1, 2, 6, 21, 2, 1, 9, 1, 3 )				
		,( 1, 2, 6, 21, 2, 1, 9, 2, 7 )				
		,( 1, 2, 6, 21, 2, 1, 10, 1, 1 )				
		,( 1, 2, 6, 21, 2, 1, 10, 2, 1 )				
		,( 1, 2, 6, 21, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 21, 3, 1, 1, 1, 3 )					
		,( 1, 2, 6, 21, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 3, Week: 1,Total score: 127	
		,( 1, 2, 6, 21, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 6, 21, 3, 1, 2, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 3, 1, 3 )				
		,( 1, 2, 6, 21, 3, 1, 3, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 4, 1, 3 )				
		,( 1, 2, 6, 21, 3, 1, 4, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 5, 1, 3 )				
		,( 1, 2, 6, 21, 3, 1, 5, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 6, 1, 3 )				
		,( 1, 2, 6, 21, 3, 1, 6, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 7, 1, 3 )				
		,( 1, 2, 6, 21, 3, 1, 7, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 8, 1, 3 )				
		,( 1, 2, 6, 21, 3, 1, 8, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 9, 1, 3 )				
		,( 1, 2, 6, 21, 3, 1, 9, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 10, 1, 3 )				
		,( 1, 2, 6, 21, 3, 1, 10, 2, 7 )				
		,( 1, 2, 6, 21, 3, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 21, 4, 2, 1, 1, 10 )					
		,( 1, 2, 6, 21, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 6, Player: 21, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 6, 21, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 6, 21, 4, 2, 2, 2, 5 )				
		,( 1, 2, 6, 21, 4, 2, 3, 1, 10 )				
		,( 1, 2, 6, 21, 4, 2, 3, 2, '' )				
		,( 1, 2, 6, 21, 4, 2, 4, 1, 5 )				
		,( 1, 2, 6, 21, 4, 2, 4, 2, 3 )				
		,( 1, 2, 6, 21, 4, 2, 5, 1, 2 )				
		,( 1, 2, 6, 21, 4, 2, 5, 2, '' )				
		,( 1, 2, 6, 21, 4, 2, 6, 1, 3 )				
		,( 1, 2, 6, 21, 4, 2, 6, 2, 2 )				
		,( 1, 2, 6, 21, 4, 2, 7, 1, 10 )				
		,( 1, 2, 6, 21, 4, 2, 7, 2, '' )				
		,( 1, 2, 6, 21, 4, 2, 8, 1, '' )				
		,( 1, 2, 6, 21, 4, 2, 8, 2, '' )				
		,( 1, 2, 6, 21, 4, 2, 9, 1, '' )				
		,( 1, 2, 6, 21, 4, 2, 9, 2, '' )				
		,( 1, 2, 6, 21, 4, 2, 10, 1, 4 )				
		,( 1, 2, 6, 21, 4, 2, 10, 2, 6 )				
		,( 1, 2, 6, 21, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 21, 5, 2, 1, 1, 10 )					
		,( 1, 2, 6, 21, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 6, Player: 21, Game:5, Week: 2,Total score: 300	
		,( 1, 2, 6, 21, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 6, 21, 5, 2, 2, 2, '' )				
		,( 1, 2, 6, 21, 5, 2, 3, 1, 10 )				
		,( 1, 2, 6, 21, 5, 2, 3, 2, '' )				
 		,( 1, 2, 6, 21, 5, 2, 4, 1, 10 )				
		,( 1, 2, 6, 21, 5, 2, 4, 2, '' )				
		,( 1, 2, 6, 21, 5, 2, 5, 1, 10 )				
		,( 1, 2, 6, 21, 5, 2, 5, 2, '' )				
		,( 1, 2, 6, 21, 5, 2, 6, 1, 10 )				
		,( 1, 2, 6, 21, 5, 2, 6, 2, '' )				
		,( 1, 2, 6, 21, 5, 2, 7, 1, 10 )				
		,( 1, 2, 6, 21, 5, 2, 7, 2, '' )				
		,( 1, 2, 6, 21, 5, 2, 8, 1, 10 )				
		,( 1, 2, 6, 21, 5, 2, 8, 2, '' )				
		,( 1, 2, 6, 21, 5, 2, 9, 1, 10 )				
		,( 1, 2, 6, 21, 5, 2, 9, 2, '' )				
		,( 1, 2, 6, 21, 5, 2, 10, 1, 10 )				
		,( 1, 2, 6, 21, 5, 2, 10, 2, 10 )				
		,( 1, 2, 6, 21, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 21, 6, 2, 1, 1, 3 )					
		,( 1, 2, 6, 21, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 6, Player: 21, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 6, 21, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 6, 21, 6, 2, 2, 2, 7 )				
		,( 1, 2, 6, 21, 6, 2, 3, 1, 3 )				
		,( 1, 2, 6, 21, 6, 2, 3, 2, 7 )				
		,( 1, 2, 6, 21, 6, 2, 4, 1, 1 )				
		,( 1, 2, 6, 21, 6, 2, 4, 2, 2 )				
		,( 1, 2, 6, 21, 6, 2, 5, 1, 10 )				
		,( 1, 2, 6, 21, 6, 2, 5, 2, '' )				
		,( 1, 2, 6, 21, 6, 2, 6, 1, 10 )				
		,( 1, 2, 6, 21, 6, 2, 6, 2, '' )				
		,( 1, 2, 6, 21, 6, 2, 7, 1, 3 )				
		,( 1, 2, 6, 21, 6, 2, 7, 2, 7 )				
		,( 1, 2, 6, 21, 6, 2, 8, 1, 3 )				
		,( 1, 2, 6, 21, 6, 2, 8, 2, 7 )				
		,( 1, 2, 6, 21, 6, 2, 9, 1, 3 )				
		,( 1, 2, 6, 21, 6, 2, 9, 2, 6 )				
		,( 1, 2, 6, 21, 6, 2, 10, 1, 10 )				
		,( 1, 2, 6, 21, 6, 2, 10, 2, 10 )				
		,( 1, 2, 6, 21, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 22, 1, 1, 1, 1, 3 )					
		,( 1, 2, 6, 22, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 6, 22, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 6, 22, 1, 1, 2, 2, 4 )				
		,( 1, 2, 6, 22, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 6, 22, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 6, 22, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 6, 22, 1, 1, 4, 2, 4 )				
		,( 1, 2, 6, 22, 1, 1, 5, 1, 3 )				
		,( 1, 2, 6, 22, 1, 1, 5, 2, 4 )				
		,( 1, 2, 6, 22, 1, 1, 6, 1, 3 )				
		,( 1, 2, 6, 22, 1, 1, 6, 2, 4 )				
		,( 1, 2, 6, 22, 1, 1, 7, 1, 3 )				
		,( 1, 2, 6, 22, 1, 1, 7, 2, 4 )				
		,( 1, 2, 6, 22, 1, 1, 8, 1, 3 )				
		,( 1, 2, 6, 22, 1, 1, 8, 2, 4 )				
		,( 1, 2, 6, 22, 1, 1, 9, 1, 3 )				
		,( 1, 2, 6, 22, 1, 1, 9, 2, 4 )				
		,( 1, 2, 6, 22, 1, 1, 10, 1, 3 )				
		,( 1, 2, 6, 22, 1, 1, 10, 2, 4 )				
		,( 1, 2, 6, 22, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 22, 2, 1, 1, 1, 3 )					
		,( 1, 2, 6, 22, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 6, 22, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 6, 22, 2, 1, 2, 2, 2 )				
		,( 1, 2, 6, 22, 2, 1, 3, 1, 3 )				
		,( 1, 2, 6, 22, 2, 1, 3, 2, 7 )				
		,( 1, 2, 6, 22, 2, 1, 4, 1, 3 )				
		,( 1, 2, 6, 22, 2, 1, 4, 2, 2 )				
		,( 1, 2, 6, 22, 2, 1, 5, 1, 3 )				
		,( 1, 2, 6, 22, 2, 1, 5, 2, '' )				
		,( 1, 2, 6, 22, 2, 1, 6, 1, 6 )				
		,( 1, 2, 6, 22, 2, 1, 6, 2, 4 )				
		,( 1, 2, 6, 22, 2, 1, 7, 1, 3 )				
		,( 1, 2, 6, 22, 2, 1, 7, 2, 4 )				
		,( 1, 2, 6, 22, 2, 1, 8, 1, '' )				
		,( 1, 2, 6, 22, 2, 1, 8, 2, 4 )				
		,( 1, 2, 6, 22, 2, 1, 9, 1, 3 )				
		,( 1, 2, 6, 22, 2, 1, 9, 2, 7 )				
		,( 1, 2, 6, 22, 2, 1, 10, 1, 1 )				
		,( 1, 2, 6, 22, 2, 1, 10, 2, 1 )				
		,( 1, 2, 6, 22, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 22, 3, 1, 1, 1, 3 )					
		,( 1, 2, 6, 22, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 3, Week: 1,Total score: 129	
		,( 1, 2, 6, 22, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 6, 22, 3, 1, 2, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 3, 1, 3 )				
		,( 1, 2, 6, 22, 3, 1, 3, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 4, 1, 3 )				
		,( 1, 2, 6, 22, 3, 1, 4, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 5, 1, 3 )				
		,( 1, 2, 6, 22, 3, 1, 5, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 6, 1, 3 )				
		,( 1, 2, 6, 22, 3, 1, 6, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 7, 1, 3 )				
		,( 1, 2, 6, 22, 3, 1, 7, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 8, 1, 3 )				
		,( 1, 2, 6, 22, 3, 1, 8, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 9, 1, 3 )				
		,( 1, 2, 6, 22, 3, 1, 9, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 10, 1, 3 )				
		,( 1, 2, 6, 22, 3, 1, 10, 2, 7 )				
		,( 1, 2, 6, 22, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 22, 4, 2, 1, 1, 10 )					
		,( 1, 2, 6, 22, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 6, Player: 22, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 6, 22, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 6, 22, 4, 2, 2, 2, 5 )				
		,( 1, 2, 6, 22, 4, 2, 3, 1, 10 )				
		,( 1, 2, 6, 22, 4, 2, 3, 2, '' )				
		,( 1, 2, 6, 22, 4, 2, 4, 1, 5 )				
		,( 1, 2, 6, 22, 4, 2, 4, 2, 3 )				
		,( 1, 2, 6, 22, 4, 2, 5, 1, 2 )				
		,( 1, 2, 6, 22, 4, 2, 5, 2, '' )				
		,( 1, 2, 6, 22, 4, 2, 6, 1, 3 )				
		,( 1, 2, 6, 22, 4, 2, 6, 2, 2 )				
		,( 1, 2, 6, 22, 4, 2, 7, 1, 10 )				
		,( 1, 2, 6, 22, 4, 2, 7, 2, '' )				
		,( 1, 2, 6, 22, 4, 2, 8, 1, '' )				
		,( 1, 2, 6, 22, 4, 2, 8, 2, '' )				
		,( 1, 2, 6, 22, 4, 2, 9, 1, '' )				
		,( 1, 2, 6, 22, 4, 2, 9, 2, '' )				
		,( 1, 2, 6, 22, 4, 2, 10, 1, 4 )				
		,( 1, 2, 6, 22, 4, 2, 10, 2, 6 )				
		,( 1, 2, 6, 22, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 22, 5, 2, 1, 1, 10 )					
		,( 1, 2, 6, 22, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 6, 22, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 6, 22, 5, 2, 2, 2, '' )				
		,( 1, 2, 6, 22, 5, 2, 3, 1, 10 )				
		,( 1, 2, 6, 22, 5, 2, 3, 2, '' )				
		,( 1, 2, 6, 22, 5, 2, 4, 1, 10 )				
		,( 1, 2, 6, 22, 5, 2, 4, 2, '' )				
		,( 1, 2, 6, 22, 5, 2, 5, 1, 10 )				
		,( 1, 2, 6, 22, 5, 2, 5, 2, '' )				
		,( 1, 2, 6, 22, 5, 2, 6, 1, 10 )				
		,( 1, 2, 6, 22, 5, 2, 6, 2, '' )				
		,( 1, 2, 6, 22, 5, 2, 7, 1, 10 )				
		,( 1, 2, 6, 22, 5, 2, 7, 2, '' )				
		,( 1, 2, 6, 22, 5, 2, 8, 1, 10 )				
		,( 1, 2, 6, 22, 5, 2, 8, 2, '' )				
		,( 1, 2, 6, 22, 5, 2, 9, 1, 10 )				
		,( 1, 2, 6, 22, 5, 2, 9, 2, '' )				
		,( 1, 2, 6, 22, 5, 2, 10, 1, 10 )				
		,( 1, 2, 6, 22, 5, 2, 10, 2, 10 )				
		,( 1, 2, 6, 22, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 22, 6, 2, 1, 1, 3 )					
		,( 1, 2, 6, 22, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 6, Player: 22, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 6, 22, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 6, 22, 6, 2, 2, 2, 7 )				
		,( 1, 2, 6, 22, 6, 2, 3, 1, 3 )				
		,( 1, 2, 6, 22, 6, 2, 3, 2, 7 )				
		,( 1, 2, 6, 22, 6, 2, 4, 1, 1 )				
		,( 1, 2, 6, 22, 6, 2, 4, 2, 2 )				
		,( 1, 2, 6, 22, 6, 2, 5, 1, 10 )				
		,( 1, 2, 6, 22, 6, 2, 5, 2, '' )				
		,( 1, 2, 6, 22, 6, 2, 6, 1, 10 )				
		,( 1, 2, 6, 22, 6, 2, 6, 2, '' )				
		,( 1, 2, 6, 22, 6, 2, 7, 1, 3 )				
		,( 1, 2, 6, 22, 6, 2, 7, 2, 7 )				
		,( 1, 2, 6, 22, 6, 2, 8, 1, 3 )				
		,( 1, 2, 6, 22, 6, 2, 8, 2, 7 )				
		,( 1, 2, 6, 22, 6, 2, 9, 1, 3 )				
		,( 1, 2, 6, 22, 6, 2, 9, 2, 6 )				
		,( 1, 2, 6, 22, 6, 2, 10, 1, 10 )				
		,( 1, 2, 6, 22, 6, 2, 10, 2, 10 )				
		,( 1, 2, 6, 22, 6, 2, 10, 3, 10 )				
		
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 23, 1, 1, 1, 1, 3 )					
		,( 1, 2, 6, 23, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 6, 23, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 6, 23, 1, 1, 2, 2, 4 )				
		,( 1, 2, 6, 23, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 6, 23, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 6, 23, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 6, 23, 1, 1, 4, 2, 4 )				
		,( 1, 2, 6, 23, 1, 1, 5, 1, 3 )				
		,( 1, 2, 6, 23, 1, 1, 5, 2, 4 )				
		,( 1, 2, 6, 23, 1, 1, 6, 1, 3 )				
		,( 1, 2, 6, 23, 1, 1, 6, 2, 4 )				
		,( 1, 2, 6, 23, 1, 1, 7, 1, 3 )				
		,( 1, 2, 6, 23, 1, 1, 7, 2, 4 )				
		,( 1, 2, 6, 23, 1, 1, 8, 1, 3 )				
		,( 1, 2, 6, 23, 1, 1, 8, 2, 4 )				
		,( 1, 2, 6, 23, 1, 1, 9, 1, 3 )				
		,( 1, 2, 6, 23, 1, 1, 9, 2, 4 )				
		,( 1, 2, 6, 23, 1, 1, 10, 1, 3 )				
		,( 1, 2, 6, 23, 1, 1, 10, 2, 4 )				
		,( 1, 2, 6, 23, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 23, 2, 1, 1, 1, 3 )					
		,( 1, 2, 6, 23, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 6, 23, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 6, 23, 2, 1, 2, 2, 2 )				
		,( 1, 2, 6, 23, 2, 1, 3, 1, 3 )				
		,( 1, 2, 6, 23, 2, 1, 3, 2, 7 )				
		,( 1, 2, 6, 23, 2, 1, 4, 1, 3 )				
		,( 1, 2, 6, 23, 2, 1, 4, 2, 2 )				
		,( 1, 2, 6, 23, 2, 1, 5, 1, 3 )				
		,( 1, 2, 6, 23, 2, 1, 5, 2, '' )				
		,( 1, 2, 6, 23, 2, 1, 6, 1, 6 )				
		,( 1, 2, 6, 23, 2, 1, 6, 2, 4 )				
		,( 1, 2, 6, 23, 2, 1, 7, 1, 3 )				
		,( 1, 2, 6, 23, 2, 1, 7, 2, 4 )				
		,( 1, 2, 6, 23, 2, 1, 8, 1, '' )				
		,( 1, 2, 6, 23, 2, 1, 8, 2, 4 )				
		,( 1, 2, 6, 23, 2, 1, 9, 1, 3 )				
		,( 1, 2, 6, 23, 2, 1, 9, 2, 7 )				
		,( 1, 2, 6, 23, 2, 1, 10, 1, 1 )				
		,( 1, 2, 6, 23, 2, 1, 10, 2, 1 )				
		,( 1, 2, 6, 23, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 23, 3, 1, 1, 1, 3 )					
		,( 1, 2, 6, 23, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 3, Week: 1,Total score: 128	
		,( 1, 2, 6, 23, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 6, 23, 3, 1, 2, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 3, 1, 3 )				
		,( 1, 2, 6, 23, 3, 1, 3, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 4, 1, 3 )				
		,( 1, 2, 6, 23, 3, 1, 4, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 5, 1, 3 )				
		,( 1, 2, 6, 23, 3, 1, 5, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 6, 1, 3 )				
		,( 1, 2, 6, 23, 3, 1, 6, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 7, 1, 3 )				
		,( 1, 2, 6, 23, 3, 1, 7, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 8, 1, 3 )				
		,( 1, 2, 6, 23, 3, 1, 8, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 9, 1, 3 )				
		,( 1, 2, 6, 23, 3, 1, 9, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 10, 1, 3 )				
		,( 1, 2, 6, 23, 3, 1, 10, 2, 7 )				
		,( 1, 2, 6, 23, 3, 1, 10, 3, 1 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 23, 4, 2, 1, 1, 10 )					
		,( 1, 2, 6, 23, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 6, Player: 23, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 6, 23, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 6, 23, 4, 2, 2, 2, 5 )				
		,( 1, 2, 6, 23, 4, 2, 3, 1, 10 )				
		,( 1, 2, 6, 23, 4, 2, 3, 2, '' )				
		,( 1, 2, 6, 23, 4, 2, 4, 1, 5 )				
		,( 1, 2, 6, 23, 4, 2, 4, 2, 3 )				
		,( 1, 2, 6, 23, 4, 2, 5, 1, 2 )				
		,( 1, 2, 6, 23, 4, 2, 5, 2, '' )				
		,( 1, 2, 6, 23, 4, 2, 6, 1, 3 )				
		,( 1, 2, 6, 23, 4, 2, 6, 2, 2 )				
		,( 1, 2, 6, 23, 4, 2, 7, 1, 10 )				
		,( 1, 2, 6, 23, 4, 2, 7, 2, '' )				
		,( 1, 2, 6, 23, 4, 2, 8, 1, '' )				
		,( 1, 2, 6, 23, 4, 2, 8, 2, '' )				
		,( 1, 2, 6, 23, 4, 2, 9, 1, '' )				
		,( 1, 2, 6, 23, 4, 2, 9, 2, '' )				
		,( 1, 2, 6, 23, 4, 2, 10, 1, 4 )				
		,( 1, 2, 6, 23, 4, 2, 10, 2, 6 )				
		,( 1, 2, 6, 23, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 23, 5, 2, 1, 1, 10 )					
		,( 1, 2, 6, 23, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 6, 23, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 6, 23, 5, 2, 2, 2, '' )				
		,( 1, 2, 6, 23, 5, 2, 3, 1, 10 )				
		,( 1, 2, 6, 23, 5, 2, 3, 2, '' )				
		,( 1, 2, 6, 23, 5, 2, 4, 1, 10 )				
		,( 1, 2, 6, 23, 5, 2, 4, 2, '' )				
		,( 1, 2, 6, 23, 5, 2, 5, 1, 10 )				
		,( 1, 2, 6, 23, 5, 2, 5, 2, '' )				
		,( 1, 2, 6, 23, 5, 2, 6, 1, 10 )				
		,( 1, 2, 6, 23, 5, 2, 6, 2, '' )				
		,( 1, 2, 6, 23, 5, 2, 7, 1, 10 )				
		,( 1, 2, 6, 23, 5, 2, 7, 2, '' )				
		,( 1, 2, 6, 23, 5, 2, 8, 1, 10 )				
		,( 1, 2, 6, 23, 5, 2, 8, 2, '' )				
		,( 1, 2, 6, 23, 5, 2, 9, 1, 10 )				
		,( 1, 2, 6, 23, 5, 2, 9, 2, '' )				
		,( 1, 2, 6, 23, 5, 2, 10, 1, 10 )				
		,( 1, 2, 6, 23, 5, 2, 10, 2, 10 )				
		,( 1, 2, 6, 23, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 23, 6, 2, 1, 1, 3 )					
		,( 1, 2, 6, 23, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 6, Player: 23, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 6, 23, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 6, 23, 6, 2, 2, 2, 7 )				
		,( 1, 2, 6, 23, 6, 2, 3, 1, 3 )				
		,( 1, 2, 6, 23, 6, 2, 3, 2, 7 )				
		,( 1, 2, 6, 23, 6, 2, 4, 1, 1 )				
		,( 1, 2, 6, 23, 6, 2, 4, 2, 2 )				
		,( 1, 2, 6, 23, 6, 2, 5, 1, 10 )				
		,( 1, 2, 6, 23, 6, 2, 5, 2, '' )				
		,( 1, 2, 6, 23, 6, 2, 6, 1, 10 )				
		,( 1, 2, 6, 23, 6, 2, 6, 2, '' )				
		,( 1, 2, 6, 23, 6, 2, 7, 1, 3 )				
		,( 1, 2, 6, 23, 6, 2, 7, 2, 7 )				
		,( 1, 2, 6, 23, 6, 2, 8, 1, 3 )				
		,( 1, 2, 6, 23, 6, 2, 8, 2, 7 )				
		,( 1, 2, 6, 23, 6, 2, 9, 1, 3 )				
		,( 1, 2, 6, 23, 6, 2, 9, 2, 6 )				
		,( 1, 2, 6, 23, 6, 2, 10, 1, 10 )				
		,( 1, 2, 6, 23, 6, 2, 10, 2, 10 )				
		,( 1, 2, 6, 23, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 24, 1, 1, 1, 1, 3 )					
		,( 1, 2, 6, 24, 1, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 1, Week: 1,Total score: 70	
		,( 1, 2, 6, 24, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 2, 6, 24, 1, 1, 2, 2, 4 )				
		,( 1, 2, 6, 24, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 2, 6, 24, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 2, 6, 24, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 2, 6, 24, 1, 1, 4, 2, 4 )				
		,( 1, 2, 6, 24, 1, 1, 5, 1, 3 )				
		,( 1, 2, 6, 24, 1, 1, 5, 2, 4 )				
		,( 1, 2, 6, 24, 1, 1, 6, 1, 3 )				
		,( 1, 2, 6, 24, 1, 1, 6, 2, 4 )				
		,( 1, 2, 6, 24, 1, 1, 7, 1, 3 )				
		,( 1, 2, 6, 24, 1, 1, 7, 2, 4 )				
		,( 1, 2, 6, 24, 1, 1, 8, 1, 3 )				
		,( 1, 2, 6, 24, 1, 1, 8, 2, 4 )				
		,( 1, 2, 6, 24, 1, 1, 9, 1, 3 )				
		,( 1, 2, 6, 24, 1, 1, 9, 2, 4 )				
		,( 1, 2, 6, 24, 1, 1, 10, 1, 3 )				
		,( 1, 2, 6, 24, 1, 1, 10, 2, 4 )				
		,( 1, 2, 6, 24, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 24, 2, 1, 1, 1, 3 )					
		,( 1, 2, 6, 24, 2, 1, 1, 2, 4 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 2, Week: 1,Total score: 70	
		,( 1, 2, 6, 24, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 2, 6, 24, 2, 1, 2, 2, 2 )				
		,( 1, 2, 6, 24, 2, 1, 3, 1, 3 )				
		,( 1, 2, 6, 24, 2, 1, 3, 2, 7 )				
		,( 1, 2, 6, 24, 2, 1, 4, 1, 3 )				
		,( 1, 2, 6, 24, 2, 1, 4, 2, 2 )				
		,( 1, 2, 6, 24, 2, 1, 5, 1, 3 )				
		,( 1, 2, 6, 24, 2, 1, 5, 2, '' )				
		,( 1, 2, 6, 24, 2, 1, 6, 1, 6 )				
		,( 1, 2, 6, 24, 2, 1, 6, 2, 4 )				
		,( 1, 2, 6, 24, 2, 1, 7, 1, 3 )				
		,( 1, 2, 6, 24, 2, 1, 7, 2, 4 )				
		,( 1, 2, 6, 24, 2, 1, 8, 1, '' )				
		,( 1, 2, 6, 24, 2, 1, 8, 2, 4 )				
		,( 1, 2, 6, 24, 2, 1, 9, 1, 3 )				
		,( 1, 2, 6, 24, 2, 1, 9, 2, 7 )				
		,( 1, 2, 6, 24, 2, 1, 10, 1, 1 )				
		,( 1, 2, 6, 24, 2, 1, 10, 2, 1 )				
		,( 1, 2, 6, 24, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 24, 3, 1, 1, 1, 3 )					
		,( 1, 2, 6, 24, 3, 1, 1, 2, 7 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 3, Week: 1,Total score: 135	
		,( 1, 2, 6, 24, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 2, 6, 24, 3, 1, 2, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 3, 1, 3 )				
		,( 1, 2, 6, 24, 3, 1, 3, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 4, 1, 3 )				
		,( 1, 2, 6, 24, 3, 1, 4, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 5, 1, 3 )				
		,( 1, 2, 6, 24, 3, 1, 5, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 6, 1, 3 )				
		,( 1, 2, 6, 24, 3, 1, 6, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 7, 1, 3 )				
		,( 1, 2, 6, 24, 3, 1, 7, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 8, 1, 3 )				
		,( 1, 2, 6, 24, 3, 1, 8, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 9, 1, 3 )				
		,( 1, 2, 6, 24, 3, 1, 9, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 10, 1, 3 )				
		,( 1, 2, 6, 24, 3, 1, 10, 2, 7 )				
		,( 1, 2, 6, 24, 3, 1, 10, 3, 8 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 24, 4, 2, 1, 1, 10 )					
		,( 1, 2, 6, 24, 4, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 6, Player: 24, Game:4, Week: 2,Total score: 70	
		,( 1, 2, 6, 24, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 2, 6, 24, 4, 2, 2, 2, 5 )				
		,( 1, 2, 6, 24, 4, 2, 3, 1, 10 )				
		,( 1, 2, 6, 24, 4, 2, 3, 2, '' )				
		,( 1, 2, 6, 24, 4, 2, 4, 1, 5 )				
		,( 1, 2, 6, 24, 4, 2, 4, 2, 3 )				
		,( 1, 2, 6, 24, 4, 2, 5, 1, 2 )				
		,( 1, 2, 6, 24, 4, 2, 5, 2, '' )				
		,( 1, 2, 6, 24, 4, 2, 6, 1, 3 )				
		,( 1, 2, 6, 24, 4, 2, 6, 2, 2 )				
		,( 1, 2, 6, 24, 4, 2, 7, 1, 10 )				
		,( 1, 2, 6, 24, 4, 2, 7, 2, '' )				
		,( 1, 2, 6, 24, 4, 2, 8, 1, '' )				
		,( 1, 2, 6, 24, 4, 2, 8, 2, '' )				
		,( 1, 2, 6, 24, 4, 2, 9, 1, '' )				
		,( 1, 2, 6, 24, 4, 2, 9, 2, '' )				
		,( 1, 2, 6, 24, 4, 2, 10, 1, 4 )				
		,( 1, 2, 6, 24, 4, 2, 10, 2, 6 )				
		,( 1, 2, 6, 24, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 24, 5, 2, 1, 1, 10 )					
		,( 1, 2, 6, 24, 5, 2, 1, 2, '' )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 5, Week: 2,Total score: 300	
		,( 1, 2, 6, 24, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 2, 6, 24, 5, 2, 2, 2, '' )				
		,( 1, 2, 6, 24, 5, 2, 3, 1, 10 )				
		,( 1, 2, 6, 24, 5, 2, 3, 2, '' )				
		,( 1, 2, 6, 24, 5, 2, 4, 1, 10 )				
		,( 1, 2, 6, 24, 5, 2, 4, 2, '' )				
		,( 1, 2, 6, 24, 5, 2, 5, 1, 10 )				
		,( 1, 2, 6, 24, 5, 2, 5, 2, '' )				
		,( 1, 2, 6, 24, 5, 2, 6, 1, 10 )				
		,( 1, 2, 6, 24, 5, 2, 6, 2, '' )				
		,( 1, 2, 6, 24, 5, 2, 7, 1, 10 )				
		,( 1, 2, 6, 24, 5, 2, 7, 2, '' )				
		,( 1, 2, 6, 24, 5, 2, 8, 1, 10 )				
		,( 1, 2, 6, 24, 5, 2, 8, 2, '' )				
		,( 1, 2, 6, 24, 5, 2, 9, 1, 10 )				
		,( 1, 2, 6, 24, 5, 2, 9, 2, '' )				
		,( 1, 2, 6, 24, 5, 2, 10, 1, 10 )				
		,( 1, 2, 6, 24, 5, 2, 10, 2, 10 )				
		,( 1, 2, 6, 24, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 2, 6, 24, 6, 2, 1, 1, 3 )					
		,( 1, 2, 6, 24, 6, 2, 1, 2, 7 )			-- Year 2011, League: 2, Team: 6, Player: 24, Game: 6, Week: 2,Total score: 148	
		,( 1, 2, 6, 24, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 2, 6, 24, 6, 2, 2, 2, 7 )				
		,( 1, 2, 6, 24, 6, 2, 3, 1, 3 )				
		,( 1, 2, 6, 24, 6, 2, 3, 2, 7 )				
		,( 1, 2, 6, 24, 6, 2, 4, 1, 1 )				
		,( 1, 2, 6, 24, 6, 2, 4, 2, 2 )				
		,( 1, 2, 6, 24, 6, 2, 5, 1, 10 )				
		,( 1, 2, 6, 24, 6, 2, 5, 2, '' )				
		,( 1, 2, 6, 24, 6, 2, 6, 1, 10 )				
		,( 1, 2, 6, 24, 6, 2, 6, 2, '' )				
		,( 1, 2, 6, 24, 6, 2, 7, 1, 3 )				
		,( 1, 2, 6, 24, 6, 2, 7, 2, 7 )				
		,( 1, 2, 6, 24, 6, 2, 8, 1, 3 )				
		,( 1, 2, 6, 24, 6, 2, 8, 2, 7 )				
		,( 1, 2, 6, 24, 6, 2, 9, 1, 3 )				
		,( 1, 2, 6, 24, 6, 2, 9, 2, 6 )				
		,( 1, 2, 6, 24, 6, 2, 10, 1, 10 )				
		,( 1, 2, 6, 24, 6, 2, 10, 2, 10 )				
		,( 1, 2, 6, 24, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 25, 1, 1, 1, 1, 3 )					
		,( 1, 3, 7, 25, 1, 1, 1, 2, 4 )				
		,( 1, 3, 7, 25, 1, 1, 2, 1, 3 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 7, 25, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 3, 7, 25, 1, 1, 3, 1, 3 )				
		,( 1, 3, 7, 25, 1, 1, 3, 2, 4 )				
		,( 1, 3, 7, 25, 1, 1, 4, 1, 3 )				
		,( 1, 3, 7, 25, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 3, 7, 25, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 7, 25, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 3, 7, 25, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 7, 25, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 3, 7, 25, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 3, 7, 25, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 3, 7, 25, 1, 1, 8, 1, 3 )				
		,( 1, 3, 7, 25, 1, 1, 8, 2, 4 )				
		,( 1, 3, 7, 25, 1, 1, 9, 1, 3 )				
		,( 1, 3, 7, 25, 1, 1, 9, 2, 4 )				
		,( 1, 3, 7, 25, 1, 1, 10, 1, 3 )				
		,( 1, 3, 7, 25, 1, 1, 10, 2, 4 )				
		,( 1, 3, 7, 25, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 25, 2, 1, 1, 1, 3 )					
		,( 1, 3, 7, 25, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 7, 25, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 7, 25, 2, 1, 2, 2, 2 )				
		,( 1, 3, 7, 25, 2, 1, 3, 1, 3 )				
		,( 1, 3, 7, 25, 2, 1, 3, 2, 7 )				
		,( 1, 3, 7, 25, 2, 1, 4, 1, 3 )				
		,( 1, 3, 7, 25, 2, 1, 4, 2, 2 )				
		,( 1, 3, 7, 25, 2, 1, 5, 1, 3 )				
		,( 1, 3, 7, 25, 2, 1, 5, 2, '' )				
		,( 1, 3, 7, 25, 2, 1, 6, 1, 6 )				
		,( 1, 3, 7, 25, 2, 1, 6, 2, 4 )				
		,( 1, 3, 7, 25, 2, 1, 7, 1, 3 )				
		,( 1, 3, 7, 25, 2, 1, 7, 2, 4 )				
		,( 1, 3, 7, 25, 2, 1, 8, 1, '' )				
		,( 1, 3, 7, 25, 2, 1, 8, 2, 4 )				
		,( 1, 3, 7, 25, 2, 1, 9, 1, 3 )				
		,( 1, 3, 7, 25, 2, 1, 9, 2, 7 )				
		,( 1, 3, 7, 25, 2, 1, 10, 1, 1 )				
		,( 1, 3, 7, 25, 2, 1, 10, 2, 1 )				
		,( 1, 3, 7, 25, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 25, 3, 1, 1, 1, 3 )					
		,( 1, 3, 7, 25, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 3, Week: 1,Total score: 135	
		,( 1, 3, 7, 25, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 7, 25, 3, 1, 2, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 3, 1, 3 )				
		,( 1, 3, 7, 25, 3, 1, 3, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 4, 1, 3 )				
		,( 1, 3, 7, 25, 3, 1, 4, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 5, 1, 3 )				
		,( 1, 3, 7, 25, 3, 1, 5, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 6, 1, 3 )				
		,( 1, 3, 7, 25, 3, 1, 6, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 7, 1, 3 )				
		,( 1, 3, 7, 25, 3, 1, 7, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 8, 1, 3 )				
		,( 1, 3, 7, 25, 3, 1, 8, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 9, 1, 3 )				
		,( 1, 3, 7, 25, 3, 1, 9, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 10, 1, 3 )				
		,( 1, 3, 7, 25, 3, 1, 10, 2, 7 )				
		,( 1, 3, 7, 25, 3, 1, 10, 3, 8 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 25, 4, 2, 1, 1, 10 )					
		,( 1, 3, 7, 25, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 7, Player: 25, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 7, 25, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 7, 25, 4, 2, 2, 2, 5 )				
		,( 1, 3, 7, 25, 4, 2, 3, 1, 10 )				
		,( 1, 3, 7, 25, 4, 2, 3, 2, '' )				
		,( 1, 3, 7, 25, 4, 2, 4, 1, 5 )				
		,( 1, 3, 7, 25, 4, 2, 4, 2, 3 )				
		,( 1, 3, 7, 25, 4, 2, 5, 1, 2 )				
		,( 1, 3, 7, 25, 4, 2, 5, 2, '' )				
		,( 1, 3, 7, 25, 4, 2, 6, 1, 3 )				
		,( 1, 3, 7, 25, 4, 2, 6, 2, 2 )				
		,( 1, 3, 7, 25, 4, 2, 7, 1, 10 )				
		,( 1, 3, 7, 25, 4, 2, 7, 2, '' )				
		,( 1, 3, 7, 25, 4, 2, 8, 1, '' )				
		,( 1, 3, 7, 25, 4, 2, 8, 2, '' )				
		,( 1, 3, 7, 25, 4, 2, 9, 1, '' )				
		,( 1, 3, 7, 25, 4, 2, 9, 2, '' )				
		,( 1, 3, 7, 25, 4, 2, 10, 1, 4 )				
		,( 1, 3, 7, 25, 4, 2, 10, 2, 6 )				
		,( 1, 3, 7, 25, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 25, 5, 2, 1, 1, 10 )					
		,( 1, 3, 7, 25, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 7, Player: 25, Game:5, Week: 2,Total score: 300	
		,( 1, 3, 7, 25, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 7, 25, 5, 2, 2, 2, '' )				
		,( 1, 3, 7, 25, 5, 2, 3, 1, 10 )				
		,( 1, 3, 7, 25, 5, 2, 3, 2, '' )				
 		,( 1, 3, 7, 25, 5, 2, 4, 1, 10 )				
		,( 1, 3, 7, 25, 5, 2, 4, 2, '' )				
		,( 1, 3, 7, 25, 5, 2, 5, 1, 10 )				
		,( 1, 3, 7, 25, 5, 2, 5, 2, '' )				
		,( 1, 3, 7, 25, 5, 2, 6, 1, 10 )				
		,( 1, 3, 7, 25, 5, 2, 6, 2, '' )				
		,( 1, 3, 7, 25, 5, 2, 7, 1, 10 )				
		,( 1, 3, 7, 25, 5, 2, 7, 2, '' )				
		,( 1, 3, 7, 25, 5, 2, 8, 1, 10 )				
		,( 1, 3, 7, 25, 5, 2, 8, 2, '' )				
		,( 1, 3, 7, 25, 5, 2, 9, 1, 10 )				
		,( 1, 3, 7, 25, 5, 2, 9, 2, '' )				
		,( 1, 3, 7, 25, 5, 2, 10, 1, 10 )				
		,( 1, 3, 7, 25, 5, 2, 10, 2, 10 )				
		,( 1, 3, 7, 25, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 25, 6, 2, 1, 1, 3 )					
		,( 1, 3, 7, 25, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 7, Player: 25, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 7, 25, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 7, 25, 6, 2, 2, 2, 7 )				
		,( 1, 3, 7, 25, 6, 2, 3, 1, 3 )				
		,( 1, 3, 7, 25, 6, 2, 3, 2, 7 )				
		,( 1, 3, 7, 25, 6, 2, 4, 1, 1 )				
		,( 1, 3, 7, 25, 6, 2, 4, 2, 2 )				
		,( 1, 3, 7, 25, 6, 2, 5, 1, 10 )				
		,( 1, 3, 7, 25, 6, 2, 5, 2, '' )				
		,( 1, 3, 7, 25, 6, 2, 6, 1, 10 )				
		,( 1, 3, 7, 25, 6, 2, 6, 2, '' )				
		,( 1, 3, 7, 25, 6, 2, 7, 1, 3 )				
		,( 1, 3, 7, 25, 6, 2, 7, 2, 7 )				
		,( 1, 3, 7, 25, 6, 2, 8, 1, 3 )				
		,( 1, 3, 7, 25, 6, 2, 8, 2, 7 )				
		,( 1, 3, 7, 25, 6, 2, 9, 1, 3 )				
		,( 1, 3, 7, 25, 6, 2, 9, 2, 6 )				
		,( 1, 3, 7, 25, 6, 2, 10, 1, 10 )				
		,( 1, 3, 7, 25, 6, 2, 10, 2, 10 )				
		,( 1, 3, 7, 25, 6, 2, 10, 3, 10 )				
		
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 26, 1, 1, 1, 1, 3 )					
		,( 1, 3, 7, 26, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 7, 26, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 7, 26, 1, 1, 2, 2, 4 )				
		,( 1, 3, 7, 26, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 7, 26, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 7, 26, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 7, 26, 1, 1, 4, 2, 4 )				
		,( 1, 3, 7, 26, 1, 1, 5, 1, 3 )				
		,( 1, 3, 7, 26, 1, 1, 5, 2, 4 )				
		,( 1, 3, 7, 26, 1, 1, 6, 1, 3 )				
		,( 1, 3, 7, 26, 1, 1, 6, 2, 4 )				
		,( 1, 3, 7, 26, 1, 1, 7, 1, 3 )				
		,( 1, 3, 7, 26, 1, 1, 7, 2, 4 )				
		,( 1, 3, 7, 26, 1, 1, 8, 1, 3 )				
		,( 1, 3, 7, 26, 1, 1, 8, 2, 4 )				
		,( 1, 3, 7, 26, 1, 1, 9, 1, 3 )				
		,( 1, 3, 7, 26, 1, 1, 9, 2, 4 )				
		,( 1, 3, 7, 26, 1, 1, 10, 1, 3 )				
		,( 1, 3, 7, 26, 1, 1, 10, 2, 4 )				
		,( 1, 3, 7, 26, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 26, 2, 1, 1, 1, 3 )					
		,( 1, 3, 7, 26, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 7, 26, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 7, 26, 2, 1, 2, 2, 2 )				
		,( 1, 3, 7, 26, 2, 1, 3, 1, 3 )				
		,( 1, 3, 7, 26, 2, 1, 3, 2, 7 )				
		,( 1, 3, 7, 26, 2, 1, 4, 1, 3 )				
		,( 1, 3, 7, 26, 2, 1, 4, 2, 2 )				
		,( 1, 3, 7, 26, 2, 1, 5, 1, 3 )				
		,( 1, 3, 7, 26, 2, 1, 5, 2, '' )				
		,( 1, 3, 7, 26, 2, 1, 6, 1, 6 )				
		,( 1, 3, 7, 26, 2, 1, 6, 2, 4 )				
		,( 1, 3, 7, 26, 2, 1, 7, 1, 3 )				
		,( 1, 3, 7, 26, 2, 1, 7, 2, 4 )				
		,( 1, 3, 7, 26, 2, 1, 8, 1, '' )				
		,( 1, 3, 7, 26, 2, 1, 8, 2, 4 )				
		,( 1, 3, 7, 26, 2, 1, 9, 1, 3 )				
		,( 1, 3, 7, 26, 2, 1, 9, 2, 7 )				
		,( 1, 3, 7, 26, 2, 1, 10, 1, 1 )				
		,( 1, 3, 7, 26, 2, 1, 10, 2, 1 )				
		,( 1, 3, 7, 26, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 26, 3, 1, 1, 1, 3 )					
		,( 1, 3, 7, 26, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 3, Week: 1,Total score: 129	
		,( 1, 3, 7, 26, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 7, 26, 3, 1, 2, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 3, 1, 3 )				
		,( 1, 3, 7, 26, 3, 1, 3, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 4, 1, 3 )				
		,( 1, 3, 7, 26, 3, 1, 4, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 5, 1, 3 )				
		,( 1, 3, 7, 26, 3, 1, 5, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 6, 1, 3 )				
		,( 1, 3, 7, 26, 3, 1, 6, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 7, 1, 3 )				
		,( 1, 3, 7, 26, 3, 1, 7, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 8, 1, 3 )				
		,( 1, 3, 7, 26, 3, 1, 8, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 9, 1, 3 )				
		,( 1, 3, 7, 26, 3, 1, 9, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 10, 1, 3 )				
		,( 1, 3, 7, 26, 3, 1, 10, 2, 7 )				
		,( 1, 3, 7, 26, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 26, 4, 2, 1, 1, 10 )					
		,( 1, 3, 7, 26, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 7, Player: 26, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 7, 26, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 7, 26, 4, 2, 2, 2, 5 )				
		,( 1, 3, 7, 26, 4, 2, 3, 1, 10 )				
		,( 1, 3, 7, 26, 4, 2, 3, 2, '' )				
		,( 1, 3, 7, 26, 4, 2, 4, 1, 5 )				
		,( 1, 3, 7, 26, 4, 2, 4, 2, 3 )				
		,( 1, 3, 7, 26, 4, 2, 5, 1, 2 )				
		,( 1, 3, 7, 26, 4, 2, 5, 2, '' )				
		,( 1, 3, 7, 26, 4, 2, 6, 1, 3 )				
		,( 1, 3, 7, 26, 4, 2, 6, 2, 2 )				
		,( 1, 3, 7, 26, 4, 2, 7, 1, 10 )				
		,( 1, 3, 7, 26, 4, 2, 7, 2, '' )				
		,( 1, 3, 7, 26, 4, 2, 8, 1, '' )				
		,( 1, 3, 7, 26, 4, 2, 8, 2, '' )				
		,( 1, 3, 7, 26, 4, 2, 9, 1, '' )				
		,( 1, 3, 7, 26, 4, 2, 9, 2, '' )				
		,( 1, 3, 7, 26, 4, 2, 10, 1, 4 )				
		,( 1, 3, 7, 26, 4, 2, 10, 2, 6 )				
		,( 1, 3, 7, 26, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 26, 5, 2, 1, 1, 10 )					
		,( 1, 3, 7, 26, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 7, 26, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 7, 26, 5, 2, 2, 2, '' )				
		,( 1, 3, 7, 26, 5, 2, 3, 1, 10 )				
		,( 1, 3, 7, 26, 5, 2, 3, 2, '' )				
		,( 1, 3, 7, 26, 5, 2, 4, 1, 10 )				
		,( 1, 3, 7, 26, 5, 2, 4, 2, '' )				
		,( 1, 3, 7, 26, 5, 2, 5, 1, 10 )				
		,( 1, 3, 7, 26, 5, 2, 5, 2, '' )				
		,( 1, 3, 7, 26, 5, 2, 6, 1, 10 )				
		,( 1, 3, 7, 26, 5, 2, 6, 2, '' )				
		,( 1, 3, 7, 26, 5, 2, 7, 1, 10 )				
		,( 1, 3, 7, 26, 5, 2, 7, 2, '' )				
		,( 1, 3, 7, 26, 5, 2, 8, 1, 10 )				
		,( 1, 3, 7, 26, 5, 2, 8, 2, '' )				
		,( 1, 3, 7, 26, 5, 2, 9, 1, 10 )				
		,( 1, 3, 7, 26, 5, 2, 9, 2, '' )				
		,( 1, 3, 7, 26, 5, 2, 10, 1, 10 )				
		,( 1, 3, 7, 26, 5, 2, 10, 2, 10 )				
		,( 1, 3, 7, 26, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 26, 6, 2, 1, 1, 3 )					
		,( 1, 3, 7, 26, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 7, Player: 26, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 7, 26, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 7, 26, 6, 2, 2, 2, 7 )				
		,( 1, 3, 7, 26, 6, 2, 3, 1, 3 )				
		,( 1, 3, 7, 26, 6, 2, 3, 2, 7 )				
		,( 1, 3, 7, 26, 6, 2, 4, 1, 1 )				
		,( 1, 3, 7, 26, 6, 2, 4, 2, 2 )				
		,( 1, 3, 7, 26, 6, 2, 5, 1, 10 )				
		,( 1, 3, 7, 26, 6, 2, 5, 2, '' )				
		,( 1, 3, 7, 26, 6, 2, 6, 1, 10 )				
		,( 1, 3, 7, 26, 6, 2, 6, 2, '' )				
		,( 1, 3, 7, 26, 6, 2, 7, 1, 3 )				
		,( 1, 3, 7, 26, 6, 2, 7, 2, 7 )				
		,( 1, 3, 7, 26, 6, 2, 8, 1, 3 )				
		,( 1, 3, 7, 26, 6, 2, 8, 2, 7 )				
		,( 1, 3, 7, 26, 6, 2, 9, 1, 3 )				
		,( 1, 3, 7, 26, 6, 2, 9, 2, 6 )				
		,( 1, 3, 7, 26, 6, 2, 10, 1, 10 )				
		,( 1, 3, 7, 26, 6, 2, 10, 2, 10 )				
		,( 1, 3, 7, 26, 6, 2, 10, 3, 10 )				

INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 27, 1, 1, 1, 1, 3 )					
		,( 1, 3, 7, 27, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 7, 27, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 7, 27, 1, 1, 2, 2, 4 )				
		,( 1, 3, 7, 27, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 7, 27, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 7, 27, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 7, 27, 1, 1, 4, 2, 4 )				
		,( 1, 3, 7, 27, 1, 1, 5, 1, 3 )				
		,( 1, 3, 7, 27, 1, 1, 5, 2, 4 )				
		,( 1, 3, 7, 27, 1, 1, 6, 1, 3 )				
		,( 1, 3, 7, 27, 1, 1, 6, 2, 4 )				
		,( 1, 3, 7, 27, 1, 1, 7, 1, 3 )				
		,( 1, 3, 7, 27, 1, 1, 7, 2, 4 )				
		,( 1, 3, 7, 27, 1, 1, 8, 1, 3 )				
		,( 1, 3, 7, 27, 1, 1, 8, 2, 4 )				
		,( 1, 3, 7, 27, 1, 1, 9, 1, 3 )				
		,( 1, 3, 7, 27, 1, 1, 9, 2, 4 )				
		,( 1, 3, 7, 27, 1, 1, 10, 1, 3 )				
		,( 1, 3, 7, 27, 1, 1, 10, 2, 4 )				
		,( 1, 3, 7, 27, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 27, 2, 1, 1, 1, 3 )					
		,( 1, 3, 7, 27, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 7, 27, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 7, 27, 2, 1, 2, 2, 2 )				
		,( 1, 3, 7, 27, 2, 1, 3, 1, 3 )				
		,( 1, 3, 7, 27, 2, 1, 3, 2, 7 )				
		,( 1, 3, 7, 27, 2, 1, 4, 1, 3 )				
		,( 1, 3, 7, 27, 2, 1, 4, 2, 2 )				
		,( 1, 3, 7, 27, 2, 1, 5, 1, 3 )				
		,( 1, 3, 7, 27, 2, 1, 5, 2, '' )				
		,( 1, 3, 7, 27, 2, 1, 6, 1, 6 )				
		,( 1, 3, 7, 27, 2, 1, 6, 2, 4 )				
		,( 1, 3, 7, 27, 2, 1, 7, 1, 3 )				
		,( 1, 3, 7, 27, 2, 1, 7, 2, 4 )				
		,( 1, 3, 7, 27, 2, 1, 8, 1, '' )				
		,( 1, 3, 7, 27, 2, 1, 8, 2, 4 )				
		,( 1, 3, 7, 27, 2, 1, 9, 1, 3 )				
		,( 1, 3, 7, 27, 2, 1, 9, 2, 7 )				
		,( 1, 3, 7, 27, 2, 1, 10, 1, 1 )				
		,( 1, 3, 7, 27, 2, 1, 10, 2, 1 )				
		,( 1, 3, 7, 27, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 27, 3, 1, 1, 1, 3 )					
		,( 1, 3, 7, 27, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 3, Week: 1,Total score: 130	
		,( 1, 3, 7, 27, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 7, 27, 3, 1, 2, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 3, 1, 3 )				
		,( 1, 3, 7, 27, 3, 1, 3, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 4, 1, 3 )				
		,( 1, 3, 7, 27, 3, 1, 4, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 5, 1, 3 )				
		,( 1, 3, 7, 27, 3, 1, 5, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 6, 1, 3 )				
		,( 1, 3, 7, 27, 3, 1, 6, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 7, 1, 3 )				
		,( 1, 3, 7, 27, 3, 1, 7, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 8, 1, 3 )				
		,( 1, 3, 7, 27, 3, 1, 8, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 9, 1, 3 )				
		,( 1, 3, 7, 27, 3, 1, 9, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 10, 1, 3 )				
		,( 1, 3, 7, 27, 3, 1, 10, 2, 7 )				
		,( 1, 3, 7, 27, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 27, 4, 2, 1, 1, 10 )					
		,( 1, 3, 7, 27, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 7, Player: 27, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 7, 27, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 7, 27, 4, 2, 2, 2, 5 )				
		,( 1, 3, 7, 27, 4, 2, 3, 1, 10 )				
		,( 1, 3, 7, 27, 4, 2, 3, 2, '' )				
		,( 1, 3, 7, 27, 4, 2, 4, 1, 5 )				
		,( 1, 3, 7, 27, 4, 2, 4, 2, 3 )				
		,( 1, 3, 7, 27, 4, 2, 5, 1, 2 )				
		,( 1, 3, 7, 27, 4, 2, 5, 2, '' )				
		,( 1, 3, 7, 27, 4, 2, 6, 1, 3 )				
		,( 1, 3, 7, 27, 4, 2, 6, 2, 2 )				
		,( 1, 3, 7, 27, 4, 2, 7, 1, 10 )				
		,( 1, 3, 7, 27, 4, 2, 7, 2, '' )				
		,( 1, 3, 7, 27, 4, 2, 8, 1, '' )				
		,( 1, 3, 7, 27, 4, 2, 8, 2, '' )				
		,( 1, 3, 7, 27, 4, 2, 9, 1, '' )				
		,( 1, 3, 7, 27, 4, 2, 9, 2, '' )				
		,( 1, 3, 7, 27, 4, 2, 10, 1, 4 )				
		,( 1, 3, 7, 27, 4, 2, 10, 2, 6 )				
		,( 1, 3, 7, 27, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 27, 5, 2, 1, 1, 10 )					
		,( 1, 3, 7, 27, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 7, 27, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 7, 27, 5, 2, 2, 2, '' )				
		,( 1, 3, 7, 27, 5, 2, 3, 1, 10 )				
		,( 1, 3, 7, 27, 5, 2, 3, 2, '' )				
		,( 1, 3, 7, 27, 5, 2, 4, 1, 10 )				
		,( 1, 3, 7, 27, 5, 2, 4, 2, '' )				
		,( 1, 3, 7, 27, 5, 2, 5, 1, 10 )				
		,( 1, 3, 7, 27, 5, 2, 5, 2, '' )				
		,( 1, 3, 7, 27, 5, 2, 6, 1, 10 )				
		,( 1, 3, 7, 27, 5, 2, 6, 2, '' )				
		,( 1, 3, 7, 27, 5, 2, 7, 1, 10 )				
		,( 1, 3, 7, 27, 5, 2, 7, 2, '' )				
		,( 1, 3, 7, 27, 5, 2, 8, 1, 10 )				
		,( 1, 3, 7, 27, 5, 2, 8, 2, '' )				
		,( 1, 3, 7, 27, 5, 2, 9, 1, 10 )				
		,( 1, 3, 7, 27, 5, 2, 9, 2, '' )				
		,( 1, 3, 7, 27, 5, 2, 10, 1, 10 )				
		,( 1, 3, 7, 27, 5, 2, 10, 2, 10 )				
		,( 1, 3, 7, 27, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 27, 6, 2, 1, 1, 3 )					
		,( 1, 3, 7, 27, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 7, Player: 27, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 7, 27, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 7, 27, 6, 2, 2, 2, 7 )				
		,( 1, 3, 7, 27, 6, 2, 3, 1, 3 )				
		,( 1, 3, 7, 27, 6, 2, 3, 2, 7 )				
		,( 1, 3, 7, 27, 6, 2, 4, 1, 1 )				
		,( 1, 3, 7, 27, 6, 2, 4, 2, 2 )				
		,( 1, 3, 7, 27, 6, 2, 5, 1, 10 )				
		,( 1, 3, 7, 27, 6, 2, 5, 2, '' )				
		,( 1, 3, 7, 27, 6, 2, 6, 1, 10 )				
		,( 1, 3, 7, 27, 6, 2, 6, 2, '' )				
		,( 1, 3, 7, 27, 6, 2, 7, 1, 3 )				
		,( 1, 3, 7, 27, 6, 2, 7, 2, 7 )				
		,( 1, 3, 7, 27, 6, 2, 8, 1, 3 )				
		,( 1, 3, 7, 27, 6, 2, 8, 2, 7 )				
		,( 1, 3, 7, 27, 6, 2, 9, 1, 3 )				
		,( 1, 3, 7, 27, 6, 2, 9, 2, 6 )				
		,( 1, 3, 7, 27, 6, 2, 10, 1, 10 )				
		,( 1, 3, 7, 27, 6, 2, 10, 2, 10 )				
		,( 1, 3, 7, 27, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 28, 1, 1, 1, 1, 3 )					
		,( 1, 3, 7, 28, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 7, 28, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 7, 28, 1, 1, 2, 2, 4 )				
		,( 1, 3, 7, 28, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 7, 28, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 7, 28, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 7, 28, 1, 1, 4, 2, 4 )				
		,( 1, 3, 7, 28, 1, 1, 5, 1, 3 )				
		,( 1, 3, 7, 28, 1, 1, 5, 2, 4 )				
		,( 1, 3, 7, 28, 1, 1, 6, 1, 3 )				
		,( 1, 3, 7, 28, 1, 1, 6, 2, 4 )				
		,( 1, 3, 7, 28, 1, 1, 7, 1, 3 )				
		,( 1, 3, 7, 28, 1, 1, 7, 2, 4 )				
		,( 1, 3, 7, 28, 1, 1, 8, 1, 3 )				
		,( 1, 3, 7, 28, 1, 1, 8, 2, 4 )				
		,( 1, 3, 7, 28, 1, 1, 9, 1, 3 )				
		,( 1, 3, 7, 28, 1, 1, 9, 2, 4 )				
		,( 1, 3, 7, 28, 1, 1, 10, 1, 3 )				
		,( 1, 3, 7, 28, 1, 1, 10, 2, 4 )				
		,( 1, 3, 7, 28, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 28, 2, 1, 1, 1, 3 )					
		,( 1, 3, 7, 28, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 7, 28, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 7, 28, 2, 1, 2, 2, 2 )				
		,( 1, 3, 7, 28, 2, 1, 3, 1, 3 )				
		,( 1, 3, 7, 28, 2, 1, 3, 2, 7 )				
		,( 1, 3, 7, 28, 2, 1, 4, 1, 3 )				
		,( 1, 3, 7, 28, 2, 1, 4, 2, 2 )				
		,( 1, 3, 7, 28, 2, 1, 5, 1, 3 )				
		,( 1, 3, 7, 28, 2, 1, 5, 2, '' )				
		,( 1, 3, 7, 28, 2, 1, 6, 1, 6 )				
		,( 1, 3, 7, 28, 2, 1, 6, 2, 4 )				
		,( 1, 3, 7, 28, 2, 1, 7, 1, 3 )				
		,( 1, 3, 7, 28, 2, 1, 7, 2, 4 )				
		,( 1, 3, 7, 28, 2, 1, 8, 1, '' )				
		,( 1, 3, 7, 28, 2, 1, 8, 2, 4 )				
		,( 1, 3, 7, 28, 2, 1, 9, 1, 3 )				
		,( 1, 3, 7, 28, 2, 1, 9, 2, 7 )				
		,( 1, 3, 7, 28, 2, 1, 10, 1, 1 )				
		,( 1, 3, 7, 28, 2, 1, 10, 2, 1 )				
		,( 1, 3, 7, 28, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 28, 3, 1, 1, 1, 3 )					
		,( 1, 3, 7, 28, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 3, Week: 1,Total score: 132	
		,( 1, 3, 7, 28, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 7, 28, 3, 1, 2, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 3, 1, 3 )				
		,( 1, 3, 7, 28, 3, 1, 3, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 4, 1, 3 )				
		,( 1, 3, 7, 28, 3, 1, 4, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 5, 1, 3 )				
		,( 1, 3, 7, 28, 3, 1, 5, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 6, 1, 3 )				
		,( 1, 3, 7, 28, 3, 1, 6, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 7, 1, 3 )				
		,( 1, 3, 7, 28, 3, 1, 7, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 8, 1, 3 )				
		,( 1, 3, 7, 28, 3, 1, 8, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 9, 1, 3 )				
		,( 1, 3, 7, 28, 3, 1, 9, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 10, 1, 3 )				
		,( 1, 3, 7, 28, 3, 1, 10, 2, 7 )				
		,( 1, 3, 7, 28, 3, 1, 10, 3, 5 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 28, 4, 2, 1, 1, 10 )					
		,( 1, 3, 7, 28, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 7, Player: 28, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 7, 28, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 7, 28, 4, 2, 2, 2, 5 )				
		,( 1, 3, 7, 28, 4, 2, 3, 1, 10 )				
		,( 1, 3, 7, 28, 4, 2, 3, 2, '' )				
		,( 1, 3, 7, 28, 4, 2, 4, 1, 5 )				
		,( 1, 3, 7, 28, 4, 2, 4, 2, 3 )				
		,( 1, 3, 7, 28, 4, 2, 5, 1, 2 )				
		,( 1, 3, 7, 28, 4, 2, 5, 2, '' )				
		,( 1, 3, 7, 28, 4, 2, 6, 1, 3 )				
		,( 1, 3, 7, 28, 4, 2, 6, 2, 2 )				
		,( 1, 3, 7, 28, 4, 2, 7, 1, 10 )				
		,( 1, 3, 7, 28, 4, 2, 7, 2, '' )				
		,( 1, 3, 7, 28, 4, 2, 8, 1, '' )				
		,( 1, 3, 7, 28, 4, 2, 8, 2, '' )				
		,( 1, 3, 7, 28, 4, 2, 9, 1, '' )				
		,( 1, 3, 7, 28, 4, 2, 9, 2, '' )				
		,( 1, 3, 7, 28, 4, 2, 10, 1, 4 )				
		,( 1, 3, 7, 28, 4, 2, 10, 2, 6 )				
		,( 1, 3, 7, 28, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 28, 5, 2, 1, 1, 10 )					
		,( 1, 3, 7, 28, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 7, 28, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 7, 28, 5, 2, 2, 2, '' )				
		,( 1, 3, 7, 28, 5, 2, 3, 1, 10 )				
		,( 1, 3, 7, 28, 5, 2, 3, 2, '' )				
		,( 1, 3, 7, 28, 5, 2, 4, 1, 10 )				
		,( 1, 3, 7, 28, 5, 2, 4, 2, '' )				
		,( 1, 3, 7, 28, 5, 2, 5, 1, 10 )				
		,( 1, 3, 7, 28, 5, 2, 5, 2, '' )				
		,( 1, 3, 7, 28, 5, 2, 6, 1, 10 )				
		,( 1, 3, 7, 28, 5, 2, 6, 2, '' )				
		,( 1, 3, 7, 28, 5, 2, 7, 1, 10 )				
		,( 1, 3, 7, 28, 5, 2, 7, 2, '' )				
		,( 1, 3, 7, 28, 5, 2, 8, 1, 10 )				
		,( 1, 3, 7, 28, 5, 2, 8, 2, '' )				
		,( 1, 3, 7, 28, 5, 2, 9, 1, 10 )				
		,( 1, 3, 7, 28, 5, 2, 9, 2, '' )				
		,( 1, 3, 7, 28, 5, 2, 10, 1, 10 )				
		,( 1, 3, 7, 28, 5, 2, 10, 2, 10 )				
		,( 1, 3, 7, 28, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 7, 28, 6, 2, 1, 1, 3 )					
		,( 1, 3, 7, 28, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 7, Player: 28, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 7, 28, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 7, 28, 6, 2, 2, 2, 7 )				
		,( 1, 3, 7, 28, 6, 2, 3, 1, 3 )				
		,( 1, 3, 7, 28, 6, 2, 3, 2, 7 )				
		,( 1, 3, 7, 28, 6, 2, 4, 1, 1 )				
		,( 1, 3, 7, 28, 6, 2, 4, 2, 2 )				
		,( 1, 3, 7, 28, 6, 2, 5, 1, 10 )				
		,( 1, 3, 7, 28, 6, 2, 5, 2, '' )				
		,( 1, 3, 7, 28, 6, 2, 6, 1, 10 )				
		,( 1, 3, 7, 28, 6, 2, 6, 2, '' )				
		,( 1, 3, 7, 28, 6, 2, 7, 1, 3 )				
		,( 1, 3, 7, 28, 6, 2, 7, 2, 7 )				
		,( 1, 3, 7, 28, 6, 2, 8, 1, 3 )				
		,( 1, 3, 7, 28, 6, 2, 8, 2, 7 )				
		,( 1, 3, 7, 28, 6, 2, 9, 1, 3 )				
		,( 1, 3, 7, 28, 6, 2, 9, 2, 6 )				
		,( 1, 3, 7, 28, 6, 2, 10, 1, 10 )				
		,( 1, 3, 7, 28, 6, 2, 10, 2, 10 )				
		,( 1, 3, 7, 28, 6, 2, 10, 3, 10 )				
		
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 29, 1, 1, 1, 1, 3 )					
		,( 1, 3, 8, 29, 1, 1, 1, 2, 4 )				
		,( 1, 3, 8, 29, 1, 1, 2, 1, 3 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 8, 29, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 3, 8, 29, 1, 1, 3, 1, 3 )				
		,( 1, 3, 8, 29, 1, 1, 3, 2, 4 )				
		,( 1, 3, 8, 29, 1, 1, 4, 1, 3 )				
		,( 1, 3, 8, 29, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 3, 8, 29, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 8, 29, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 3, 8, 29, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 8, 29, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 3, 8, 29, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 3, 8, 29, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 3, 8, 29, 1, 1, 8, 1, 3 )				
		,( 1, 3, 8, 29, 1, 1, 8, 2, 4 )				
		,( 1, 3, 8, 29, 1, 1, 9, 1, 3 )				
		,( 1, 3, 8, 29, 1, 1, 9, 2, 4 )				
		,( 1, 3, 8, 29, 1, 1, 10, 1, 3 )				
		,( 1, 3, 8, 29, 1, 1, 10, 2, 4 )				
		,( 1, 3, 8, 29, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 29, 2, 1, 1, 1, 3 )					
		,( 1, 3, 8, 29, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 8, 29, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 8, 29, 2, 1, 2, 2, 2 )				
		,( 1, 3, 8, 29, 2, 1, 3, 1, 3 )				
		,( 1, 3, 8, 29, 2, 1, 3, 2, 7 )				
		,( 1, 3, 8, 29, 2, 1, 4, 1, 3 )				
		,( 1, 3, 8, 29, 2, 1, 4, 2, 2 )				
		,( 1, 3, 8, 29, 2, 1, 5, 1, 3 )				
		,( 1, 3, 8, 29, 2, 1, 5, 2, '' )				
		,( 1, 3, 8, 29, 2, 1, 6, 1, 6 )				
		,( 1, 3, 8, 29, 2, 1, 6, 2, 4 )				
		,( 1, 3, 8, 29, 2, 1, 7, 1, 3 )				
		,( 1, 3, 8, 29, 2, 1, 7, 2, 4 )				
		,( 1, 3, 8, 29, 2, 1, 8, 1, '' )				
		,( 1, 3, 8, 29, 2, 1, 8, 2, 4 )				
		,( 1, 3, 8, 29, 2, 1, 9, 1, 3 )				
		,( 1, 3, 8, 29, 2, 1, 9, 2, 7 )				
		,( 1, 3, 8, 29, 2, 1, 10, 1, 1 )				
		,( 1, 3, 8, 29, 2, 1, 10, 2, 1 )				
		,( 1, 3, 8, 29, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 29, 3, 1, 1, 1, 3 )					
		,( 1, 3, 8, 29, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 3, Week: 1,Total score: 129	
		,( 1, 3, 8, 29, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 8, 29, 3, 1, 2, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 3, 1, 3 )				
		,( 1, 3, 8, 29, 3, 1, 3, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 4, 1, 3 )				
		,( 1, 3, 8, 29, 3, 1, 4, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 5, 1, 3 )				
		,( 1, 3, 8, 29, 3, 1, 5, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 6, 1, 3 )				
		,( 1, 3, 8, 29, 3, 1, 6, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 7, 1, 3 )				
		,( 1, 3, 8, 29, 3, 1, 7, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 8, 1, 3 )				
		,( 1, 3, 8, 29, 3, 1, 8, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 9, 1, 3 )				
		,( 1, 3, 8, 29, 3, 1, 9, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 10, 1, 3 )				
		,( 1, 3, 8, 29, 3, 1, 10, 2, 7 )				
		,( 1, 3, 8, 29, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 29, 4, 2, 1, 1, 10 )					
		,( 1, 3, 8, 29, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 8, Player: 29, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 8, 29, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 8, 29, 4, 2, 2, 2, 5 )				
		,( 1, 3, 8, 29, 4, 2, 3, 1, 10 )				
		,( 1, 3, 8, 29, 4, 2, 3, 2, '' )				
		,( 1, 3, 8, 29, 4, 2, 4, 1, 5 )				
		,( 1, 3, 8, 29, 4, 2, 4, 2, 3 )				
		,( 1, 3, 8, 29, 4, 2, 5, 1, 2 )				
		,( 1, 3, 8, 29, 4, 2, 5, 2, '' )				
		,( 1, 3, 8, 29, 4, 2, 6, 1, 3 )				
		,( 1, 3, 8, 29, 4, 2, 6, 2, 2 )				
		,( 1, 3, 8, 29, 4, 2, 7, 1, 10 )				
		,( 1, 3, 8, 29, 4, 2, 7, 2, '' )				
		,( 1, 3, 8, 29, 4, 2, 8, 1, '' )				
		,( 1, 3, 8, 29, 4, 2, 8, 2, '' )				
		,( 1, 3, 8, 29, 4, 2, 9, 1, '' )				
		,( 1, 3, 8, 29, 4, 2, 9, 2, '' )				
		,( 1, 3, 8, 29, 4, 2, 10, 1, 4 )				
		,( 1, 3, 8, 29, 4, 2, 10, 2, 6 )				
		,( 1, 3, 8, 29, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 29, 5, 2, 1, 1, 10 )					
		,( 1, 3, 8, 29, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 8, Player: 29, Game:5, Week: 2,Total score: 300	
		,( 1, 3, 8, 29, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 8, 29, 5, 2, 2, 2, '' )				
		,( 1, 3, 8, 29, 5, 2, 3, 1, 10 )				
		,( 1, 3, 8, 29, 5, 2, 3, 2, '' )				
 		,( 1, 3, 8, 29, 5, 2, 4, 1, 10 )				
		,( 1, 3, 8, 29, 5, 2, 4, 2, '' )				
		,( 1, 3, 8, 29, 5, 2, 5, 1, 10 )				
		,( 1, 3, 8, 29, 5, 2, 5, 2, '' )				
		,( 1, 3, 8, 29, 5, 2, 6, 1, 10 )				
		,( 1, 3, 8, 29, 5, 2, 6, 2, '' )				
		,( 1, 3, 8, 29, 5, 2, 7, 1, 10 )				
		,( 1, 3, 8, 29, 5, 2, 7, 2, '' )				
		,( 1, 3, 8, 29, 5, 2, 8, 1, 10 )				
		,( 1, 3, 8, 29, 5, 2, 8, 2, '' )				
		,( 1, 3, 8, 29, 5, 2, 9, 1, 10 )				
		,( 1, 3, 8, 29, 5, 2, 9, 2, '' )				
		,( 1, 3, 8, 29, 5, 2, 10, 1, 10 )				
		,( 1, 3, 8, 29, 5, 2, 10, 2, 10 )				
		,( 1, 3, 8, 29, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 29, 6, 2, 1, 1, 3 )					
		,( 1, 3, 8, 29, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 8, Player: 29, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 8, 29, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 8, 29, 6, 2, 2, 2, 7 )				
		,( 1, 3, 8, 29, 6, 2, 3, 1, 3 )				
		,( 1, 3, 8, 29, 6, 2, 3, 2, 7 )				
		,( 1, 3, 8, 29, 6, 2, 4, 1, 1 )				
		,( 1, 3, 8, 29, 6, 2, 4, 2, 2 )				
		,( 1, 3, 8, 29, 6, 2, 5, 1, 10 )				
		,( 1, 3, 8, 29, 6, 2, 5, 2, '' )				
		,( 1, 3, 8, 29, 6, 2, 6, 1, 10 )				
		,( 1, 3, 8, 29, 6, 2, 6, 2, '' )				
		,( 1, 3, 8, 29, 6, 2, 7, 1, 3 )				
		,( 1, 3, 8, 29, 6, 2, 7, 2, 7 )				
		,( 1, 3, 8, 29, 6, 2, 8, 1, 3 )				
		,( 1, 3, 8, 29, 6, 2, 8, 2, 7 )				
		,( 1, 3, 8, 29, 6, 2, 9, 1, 3 )				
		,( 1, 3, 8, 29, 6, 2, 9, 2, 6 )				
		,( 1, 3, 8, 29, 6, 2, 10, 1, 10 )				
		,( 1, 3, 8, 29, 6, 2, 10, 2, 10 )				
		,( 1, 3, 8, 29, 6, 2, 10, 3, 10 )				
	
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 30, 1, 1, 1, 1, 3 )					
		,( 1, 3, 8, 30, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 8, 30, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 8, 30, 1, 1, 2, 2, 4 )				
		,( 1, 3, 8, 30, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 8, 30, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 8, 30, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 8, 30, 1, 1, 4, 2, 4 )				
		,( 1, 3, 8, 30, 1, 1, 5, 1, 3 )				
		,( 1, 3, 8, 30, 1, 1, 5, 2, 4 )				
		,( 1, 3, 8, 30, 1, 1, 6, 1, 3 )				
		,( 1, 3, 8, 30, 1, 1, 6, 2, 4 )				
		,( 1, 3, 8, 30, 1, 1, 7, 1, 3 )				
		,( 1, 3, 8, 30, 1, 1, 7, 2, 4 )				
		,( 1, 3, 8, 30, 1, 1, 8, 1, 3 )				
		,( 1, 3, 8, 30, 1, 1, 8, 2, 4 )				
		,( 1, 3, 8, 30, 1, 1, 9, 1, 3 )				
		,( 1, 3, 8, 30, 1, 1, 9, 2, 4 )				
		,( 1, 3, 8, 30, 1, 1, 10, 1, 3 )				
		,( 1, 3, 8, 30, 1, 1, 10, 2, 4 )				
		,( 1, 3, 8, 30, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 30, 2, 1, 1, 1, 3 )					
		,( 1, 3, 8, 30, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 8, 30, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 8, 30, 2, 1, 2, 2, 2 )				
		,( 1, 3, 8, 30, 2, 1, 3, 1, 3 )				
		,( 1, 3, 8, 30, 2, 1, 3, 2, 7 )				
		,( 1, 3, 8, 30, 2, 1, 4, 1, 3 )				
		,( 1, 3, 8, 30, 2, 1, 4, 2, 2 )				
		,( 1, 3, 8, 30, 2, 1, 5, 1, 3 )				
		,( 1, 3, 8, 30, 2, 1, 5, 2, '' )				
		,( 1, 3, 8, 30, 2, 1, 6, 1, 6 )				
		,( 1, 3, 8, 30, 2, 1, 6, 2, 4 )				
		,( 1, 3, 8, 30, 2, 1, 7, 1, 3 )				
		,( 1, 3, 8, 30, 2, 1, 7, 2, 4 )				
		,( 1, 3, 8, 30, 2, 1, 8, 1, '' )				
		,( 1, 3, 8, 30, 2, 1, 8, 2, 4 )				
		,( 1, 3, 8, 30, 2, 1, 9, 1, 3 )				
		,( 1, 3, 8, 30, 2, 1, 9, 2, 7 )				
		,( 1, 3, 8, 30, 2, 1, 10, 1, 1 )				
		,( 1, 3, 8, 30, 2, 1, 10, 2, 1 )				
		,( 1, 3, 8, 30, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 30, 3, 1, 1, 1, 3 )					
		,( 1, 3, 8, 30, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 3, Week: 1,Total score: 129	
		,( 1, 3, 8, 30, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 8, 30, 3, 1, 2, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 3, 1, 3 )				
		,( 1, 3, 8, 30, 3, 1, 3, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 4, 1, 3 )				
		,( 1, 3, 8, 30, 3, 1, 4, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 5, 1, 3 )				
		,( 1, 3, 8, 30, 3, 1, 5, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 6, 1, 3 )				
		,( 1, 3, 8, 30, 3, 1, 6, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 7, 1, 3 )				
		,( 1, 3, 8, 30, 3, 1, 7, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 8, 1, 3 )				
		,( 1, 3, 8, 30, 3, 1, 8, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 9, 1, 3 )				
		,( 1, 3, 8, 30, 3, 1, 9, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 10, 1, 3 )				
		,( 1, 3, 8, 30, 3, 1, 10, 2, 7 )				
		,( 1, 3, 8, 30, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 30, 4, 2, 1, 1, 10 )					
		,( 1, 3, 8, 30, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 8, Player: 30, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 8, 30, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 8, 30, 4, 2, 2, 2, 5 )				
		,( 1, 3, 8, 30, 4, 2, 3, 1, 10 )				
		,( 1, 3, 8, 30, 4, 2, 3, 2, '' )				
		,( 1, 3, 8, 30, 4, 2, 4, 1, 5 )				
		,( 1, 3, 8, 30, 4, 2, 4, 2, 3 )				
		,( 1, 3, 8, 30, 4, 2, 5, 1, 2 )				
		,( 1, 3, 8, 30, 4, 2, 5, 2, '' )				
		,( 1, 3, 8, 30, 4, 2, 6, 1, 3 )				
		,( 1, 3, 8, 30, 4, 2, 6, 2, 2 )				
		,( 1, 3, 8, 30, 4, 2, 7, 1, 10 )				
		,( 1, 3, 8, 30, 4, 2, 7, 2, '' )				
		,( 1, 3, 8, 30, 4, 2, 8, 1, '' )				
		,( 1, 3, 8, 30, 4, 2, 8, 2, '' )				
		,( 1, 3, 8, 30, 4, 2, 9, 1, '' )				
		,( 1, 3, 8, 30, 4, 2, 9, 2, '' )				
		,( 1, 3, 8, 30, 4, 2, 10, 1, 4 )				
		,( 1, 3, 8, 30, 4, 2, 10, 2, 6 )				
		,( 1, 3, 8, 30, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 30, 5, 2, 1, 1, 10 )					
		,( 1, 3, 8, 30, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 8, 30, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 8, 30, 5, 2, 2, 2, '' )				
		,( 1, 3, 8, 30, 5, 2, 3, 1, 10 )				
		,( 1, 3, 8, 30, 5, 2, 3, 2, '' )				
		,( 1, 3, 8, 30, 5, 2, 4, 1, 10 )				
		,( 1, 3, 8, 30, 5, 2, 4, 2, '' )				
		,( 1, 3, 8, 30, 5, 2, 5, 1, 10 )				
		,( 1, 3, 8, 30, 5, 2, 5, 2, '' )				
		,( 1, 3, 8, 30, 5, 2, 6, 1, 10 )				
		,( 1, 3, 8, 30, 5, 2, 6, 2, '' )				
		,( 1, 3, 8, 30, 5, 2, 7, 1, 10 )				
		,( 1, 3, 8, 30, 5, 2, 7, 2, '' )				
		,( 1, 3, 8, 30, 5, 2, 8, 1, 10 )				
		,( 1, 3, 8, 30, 5, 2, 8, 2, '' )				
		,( 1, 3, 8, 30, 5, 2, 9, 1, 10 )				
		,( 1, 3, 8, 30, 5, 2, 9, 2, '' )				
		,( 1, 3, 8, 30, 5, 2, 10, 1, 10 )				
		,( 1, 3, 8, 30, 5, 2, 10, 2, 10 )				
		,( 1, 3, 8, 30, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 30, 6, 2, 1, 1, 3 )					
		,( 1, 3, 8, 30, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 8, Player: 30, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 8, 30, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 8, 30, 6, 2, 2, 2, 7 )				
		,( 1, 3, 8, 30, 6, 2, 3, 1, 3 )				
		,( 1, 3, 8, 30, 6, 2, 3, 2, 7 )				
		,( 1, 3, 8, 30, 6, 2, 4, 1, 1 )				
		,( 1, 3, 8, 30, 6, 2, 4, 2, 2 )				
		,( 1, 3, 8, 30, 6, 2, 5, 1, 10 )				
		,( 1, 3, 8, 30, 6, 2, 5, 2, '' )				
		,( 1, 3, 8, 30, 6, 2, 6, 1, 10 )				
		,( 1, 3, 8, 30, 6, 2, 6, 2, '' )				
		,( 1, 3, 8, 30, 6, 2, 7, 1, 3 )				
		,( 1, 3, 8, 30, 6, 2, 7, 2, 7 )				
		,( 1, 3, 8, 30, 6, 2, 8, 1, 3 )				
		,( 1, 3, 8, 30, 6, 2, 8, 2, 7 )				
		,( 1, 3, 8, 30, 6, 2, 9, 1, 3 )				
		,( 1, 3, 8, 30, 6, 2, 9, 2, 6 )				
		,( 1, 3, 8, 30, 6, 2, 10, 1, 10 )				
		,( 1, 3, 8, 30, 6, 2, 10, 2, 10 )				
		,( 1, 3, 8, 30, 6, 2, 10, 3, 10 )				

INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 31, 1, 1, 1, 1, 3 )					
		,( 1, 3, 8, 31, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 8, 31, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 8, 31, 1, 1, 2, 2, 4 )				
		,( 1, 3, 8, 31, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 8, 31, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 8, 31, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 8, 31, 1, 1, 4, 2, 4 )				
		,( 1, 3, 8, 31, 1, 1, 5, 1, 3 )				
		,( 1, 3, 8, 31, 1, 1, 5, 2, 4 )				
		,( 1, 3, 8, 31, 1, 1, 6, 1, 3 )				
		,( 1, 3, 8, 31, 1, 1, 6, 2, 4 )				
		,( 1, 3, 8, 31, 1, 1, 7, 1, 3 )				
		,( 1, 3, 8, 31, 1, 1, 7, 2, 4 )				
		,( 1, 3, 8, 31, 1, 1, 8, 1, 3 )				
		,( 1, 3, 8, 31, 1, 1, 8, 2, 4 )				
		,( 1, 3, 8, 31, 1, 1, 9, 1, 3 )				
		,( 1, 3, 8, 31, 1, 1, 9, 2, 4 )				
		,( 1, 3, 8, 31, 1, 1, 10, 1, 3 )				
		,( 1, 3, 8, 31, 1, 1, 10, 2, 4 )				
		,( 1, 3, 8, 31, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 31, 2, 1, 1, 1, 3 )					
		,( 1, 3, 8, 31, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 8, 31, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 8, 31, 2, 1, 2, 2, 2 )				
		,( 1, 3, 8, 31, 2, 1, 3, 1, 3 )				
		,( 1, 3, 8, 31, 2, 1, 3, 2, 7 )				
		,( 1, 3, 8, 31, 2, 1, 4, 1, 3 )				
		,( 1, 3, 8, 31, 2, 1, 4, 2, 2 )				
		,( 1, 3, 8, 31, 2, 1, 5, 1, 3 )				
		,( 1, 3, 8, 31, 2, 1, 5, 2, '' )				
		,( 1, 3, 8, 31, 2, 1, 6, 1, 6 )				
		,( 1, 3, 8, 31, 2, 1, 6, 2, 4 )				
		,( 1, 3, 8, 31, 2, 1, 7, 1, 3 )				
		,( 1, 3, 8, 31, 2, 1, 7, 2, 4 )				
		,( 1, 3, 8, 31, 2, 1, 8, 1, '' )				
		,( 1, 3, 8, 31, 2, 1, 8, 2, 4 )				
		,( 1, 3, 8, 31, 2, 1, 9, 1, 3 )				
		,( 1, 3, 8, 31, 2, 1, 9, 2, 7 )				
		,( 1, 3, 8, 31, 2, 1, 10, 1, 1 )				
		,( 1, 3, 8, 31, 2, 1, 10, 2, 1 )				
		,( 1, 3, 8, 31, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 31, 3, 1, 1, 1, 3 )					
		,( 1, 3, 8, 31, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 3, Week: 1,Total score: 130	
		,( 1, 3, 8, 31, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 8, 31, 3, 1, 2, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 3, 1, 3 )				
		,( 1, 3, 8, 31, 3, 1, 3, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 4, 1, 3 )				
		,( 1, 3, 8, 31, 3, 1, 4, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 5, 1, 3 )				
		,( 1, 3, 8, 31, 3, 1, 5, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 6, 1, 3 )				
		,( 1, 3, 8, 31, 3, 1, 6, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 7, 1, 3 )				
		,( 1, 3, 8, 31, 3, 1, 7, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 8, 1, 3 )				
		,( 1, 3, 8, 31, 3, 1, 8, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 9, 1, 3 )				
		,( 1, 3, 8, 31, 3, 1, 9, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 10, 1, 3 )				
		,( 1, 3, 8, 31, 3, 1, 10, 2, 7 )				
		,( 1, 3, 8, 31, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 31, 4, 2, 1, 1, 10 )					
		,( 1, 3, 8, 31, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 8, Player: 31, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 8, 31, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 8, 31, 4, 2, 2, 2, 5 )				
		,( 1, 3, 8, 31, 4, 2, 3, 1, 10 )				
		,( 1, 3, 8, 31, 4, 2, 3, 2, '' )				
		,( 1, 3, 8, 31, 4, 2, 4, 1, 5 )				
		,( 1, 3, 8, 31, 4, 2, 4, 2, 3 )				
		,( 1, 3, 8, 31, 4, 2, 5, 1, 2 )				
		,( 1, 3, 8, 31, 4, 2, 5, 2, '' )				
		,( 1, 3, 8, 31, 4, 2, 6, 1, 3 )				
		,( 1, 3, 8, 31, 4, 2, 6, 2, 2 )				
		,( 1, 3, 8, 31, 4, 2, 7, 1, 10 )				
		,( 1, 3, 8, 31, 4, 2, 7, 2, '' )				
		,( 1, 3, 8, 31, 4, 2, 8, 1, '' )				
		,( 1, 3, 8, 31, 4, 2, 8, 2, '' )				
		,( 1, 3, 8, 31, 4, 2, 9, 1, '' )				
		,( 1, 3, 8, 31, 4, 2, 9, 2, '' )				
		,( 1, 3, 8, 31, 4, 2, 10, 1, 4 )				
		,( 1, 3, 8, 31, 4, 2, 10, 2, 6 )				
		,( 1, 3, 8, 31, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 31, 5, 2, 1, 1, 10 )					
		,( 1, 3, 8, 31, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 8, 31, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 8, 31, 5, 2, 2, 2, '' )				
		,( 1, 3, 8, 31, 5, 2, 3, 1, 10 )				
		,( 1, 3, 8, 31, 5, 2, 3, 2, '' )				
		,( 1, 3, 8, 31, 5, 2, 4, 1, 10 )				
		,( 1, 3, 8, 31, 5, 2, 4, 2, '' )				
		,( 1, 3, 8, 31, 5, 2, 5, 1, 10 )				
		,( 1, 3, 8, 31, 5, 2, 5, 2, '' )				
		,( 1, 3, 8, 31, 5, 2, 6, 1, 10 )				
		,( 1, 3, 8, 31, 5, 2, 6, 2, '' )				
		,( 1, 3, 8, 31, 5, 2, 7, 1, 10 )				
		,( 1, 3, 8, 31, 5, 2, 7, 2, '' )				
		,( 1, 3, 8, 31, 5, 2, 8, 1, 10 )				
		,( 1, 3, 8, 31, 5, 2, 8, 2, '' )				
		,( 1, 3, 8, 31, 5, 2, 9, 1, 10 )				
		,( 1, 3, 8, 31, 5, 2, 9, 2, '' )				
		,( 1, 3, 8, 31, 5, 2, 10, 1, 10 )				
		,( 1, 3, 8, 31, 5, 2, 10, 2, 10 )				
		,( 1, 3, 8, 31, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 31, 6, 2, 1, 1, 3 )					
		,( 1, 3, 8, 31, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 8, Player: 31, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 8, 31, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 8, 31, 6, 2, 2, 2, 7 )				
		,( 1, 3, 8, 31, 6, 2, 3, 1, 3 )				
		,( 1, 3, 8, 31, 6, 2, 3, 2, 7 )				
		,( 1, 3, 8, 31, 6, 2, 4, 1, 1 )				
		,( 1, 3, 8, 31, 6, 2, 4, 2, 2 )				
		,( 1, 3, 8, 31, 6, 2, 5, 1, 10 )				
		,( 1, 3, 8, 31, 6, 2, 5, 2, '' )				
		,( 1, 3, 8, 31, 6, 2, 6, 1, 10 )				
		,( 1, 3, 8, 31, 6, 2, 6, 2, '' )				
		,( 1, 3, 8, 31, 6, 2, 7, 1, 3 )				
		,( 1, 3, 8, 31, 6, 2, 7, 2, 7 )				
		,( 1, 3, 8, 31, 6, 2, 8, 1, 3 )				
		,( 1, 3, 8, 31, 6, 2, 8, 2, 7 )				
		,( 1, 3, 8, 31, 6, 2, 9, 1, 3 )				
		,( 1, 3, 8, 31, 6, 2, 9, 2, 6 )				
		,( 1, 3, 8, 31, 6, 2, 10, 1, 10 )				
		,( 1, 3, 8, 31, 6, 2, 10, 2, 10 )				
		,( 1, 3, 8, 31, 6, 2, 10, 3, 10 )				
					
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 32, 1, 1, 1, 1, 3 )					
		,( 1, 3, 8, 32, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 8, 32, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 8, 32, 1, 1, 2, 2, 4 )				
		,( 1, 3, 8, 32, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 8, 32, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 8, 32, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 8, 32, 1, 1, 4, 2, 4 )				
		,( 1, 3, 8, 32, 1, 1, 5, 1, 3 )				
		,( 1, 3, 8, 32, 1, 1, 5, 2, 4 )				
		,( 1, 3, 8, 32, 1, 1, 6, 1, 3 )				
		,( 1, 3, 8, 32, 1, 1, 6, 2, 4 )				
		,( 1, 3, 8, 32, 1, 1, 7, 1, 3 )				
		,( 1, 3, 8, 32, 1, 1, 7, 2, 4 )				
		,( 1, 3, 8, 32, 1, 1, 8, 1, 3 )				
		,( 1, 3, 8, 32, 1, 1, 8, 2, 4 )				
		,( 1, 3, 8, 32, 1, 1, 9, 1, 3 )				
		,( 1, 3, 8, 32, 1, 1, 9, 2, 4 )				
		,( 1, 3, 8, 32, 1, 1, 10, 1, 3 )				
		,( 1, 3, 8, 32, 1, 1, 10, 2, 4 )				
		,( 1, 3, 8, 32, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 32, 2, 1, 1, 1, 3 )					
		,( 1, 3, 8, 32, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 8, 32, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 8, 32, 2, 1, 2, 2, 2 )				
		,( 1, 3, 8, 32, 2, 1, 3, 1, 3 )				
		,( 1, 3, 8, 32, 2, 1, 3, 2, 7 )				
		,( 1, 3, 8, 32, 2, 1, 4, 1, 3 )				
		,( 1, 3, 8, 32, 2, 1, 4, 2, 2 )				
		,( 1, 3, 8, 32, 2, 1, 5, 1, 3 )				
		,( 1, 3, 8, 32, 2, 1, 5, 2, '' )				
		,( 1, 3, 8, 32, 2, 1, 6, 1, 6 )				
		,( 1, 3, 8, 32, 2, 1, 6, 2, 4 )				
		,( 1, 3, 8, 32, 2, 1, 7, 1, 3 )				
		,( 1, 3, 8, 32, 2, 1, 7, 2, 4 )				
		,( 1, 3, 8, 32, 2, 1, 8, 1, '' )				
		,( 1, 3, 8, 32, 2, 1, 8, 2, 4 )				
		,( 1, 3, 8, 32, 2, 1, 9, 1, 3 )				
		,( 1, 3, 8, 32, 2, 1, 9, 2, 7 )				
		,( 1, 3, 8, 32, 2, 1, 10, 1, 1 )				
		,( 1, 3, 8, 32, 2, 1, 10, 2, 1 )				
		,( 1, 3, 8, 32, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 32, 3, 1, 1, 1, 3 )					
		,( 1, 3, 8, 32, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 3, Week: 1,Total score: 134	
		,( 1, 3, 8, 32, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 8, 32, 3, 1, 2, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 3, 1, 3 )				
		,( 1, 3, 8, 32, 3, 1, 3, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 4, 1, 3 )				
		,( 1, 3, 8, 32, 3, 1, 4, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 5, 1, 3 )				
		,( 1, 3, 8, 32, 3, 1, 5, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 6, 1, 3 )				
		,( 1, 3, 8, 32, 3, 1, 6, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 7, 1, 3 )				
		,( 1, 3, 8, 32, 3, 1, 7, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 8, 1, 3 )				
		,( 1, 3, 8, 32, 3, 1, 8, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 9, 1, 3 )				
		,( 1, 3, 8, 32, 3, 1, 9, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 10, 1, 3 )				
		,( 1, 3, 8, 32, 3, 1, 10, 2, 7 )				
		,( 1, 3, 8, 32, 3, 1, 10, 3, 7 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 32, 4, 2, 1, 1, 10 )					
		,( 1, 3, 8, 32, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 8, Player: 32, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 8, 32, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 8, 32, 4, 2, 2, 2, 5 )				
		,( 1, 3, 8, 32, 4, 2, 3, 1, 10 )				
		,( 1, 3, 8, 32, 4, 2, 3, 2, '' )				
		,( 1, 3, 8, 32, 4, 2, 4, 1, 5 )				
		,( 1, 3, 8, 32, 4, 2, 4, 2, 3 )				
		,( 1, 3, 8, 32, 4, 2, 5, 1, 2 )				
		,( 1, 3, 8, 32, 4, 2, 5, 2, '' )				
		,( 1, 3, 8, 32, 4, 2, 6, 1, 3 )				
		,( 1, 3, 8, 32, 4, 2, 6, 2, 2 )				
		,( 1, 3, 8, 32, 4, 2, 7, 1, 10 )				
		,( 1, 3, 8, 32, 4, 2, 7, 2, '' )				
		,( 1, 3, 8, 32, 4, 2, 8, 1, '' )				
		,( 1, 3, 8, 32, 4, 2, 8, 2, '' )				
		,( 1, 3, 8, 32, 4, 2, 9, 1, '' )				
		,( 1, 3, 8, 32, 4, 2, 9, 2, '' )				
		,( 1, 3, 8, 32, 4, 2, 10, 1, 4 )				
		,( 1, 3, 8, 32, 4, 2, 10, 2, 6 )				
		,( 1, 3, 8, 32, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 32, 5, 2, 1, 1, 10 )					
		,( 1, 3, 8, 32, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 8, 32, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 8, 32, 5, 2, 2, 2, '' )				
		,( 1, 3, 8, 32, 5, 2, 3, 1, 10 )				
		,( 1, 3, 8, 32, 5, 2, 3, 2, '' )				
		,( 1, 3, 8, 32, 5, 2, 4, 1, 10 )				
		,( 1, 3, 8, 32, 5, 2, 4, 2, '' )				
		,( 1, 3, 8, 32, 5, 2, 5, 1, 10 )				
		,( 1, 3, 8, 32, 5, 2, 5, 2, '' )				
		,( 1, 3, 8, 32, 5, 2, 6, 1, 10 )				
		,( 1, 3, 8, 32, 5, 2, 6, 2, '' )				
		,( 1, 3, 8, 32, 5, 2, 7, 1, 10 )				
		,( 1, 3, 8, 32, 5, 2, 7, 2, '' )				
		,( 1, 3, 8, 32, 5, 2, 8, 1, 10 )				
		,( 1, 3, 8, 32, 5, 2, 8, 2, '' )				
		,( 1, 3, 8, 32, 5, 2, 9, 1, 10 )				
		,( 1, 3, 8, 32, 5, 2, 9, 2, '' )				
		,( 1, 3, 8, 32, 5, 2, 10, 1, 10 )				
		,( 1, 3, 8, 32, 5, 2, 10, 2, 10 )				
		,( 1, 3, 8, 32, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 8, 32, 6, 2, 1, 1, 3 )					
		,( 1, 3, 8, 32, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 8, Player: 32, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 8, 32, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 8, 32, 6, 2, 2, 2, 7 )				
		,( 1, 3, 8, 32, 6, 2, 3, 1, 3 )				
		,( 1, 3, 8, 32, 6, 2, 3, 2, 7 )				
		,( 1, 3, 8, 32, 6, 2, 4, 1, 1 )				
		,( 1, 3, 8, 32, 6, 2, 4, 2, 2 )				
		,( 1, 3, 8, 32, 6, 2, 5, 1, 10 )				
		,( 1, 3, 8, 32, 6, 2, 5, 2, '' )				
		,( 1, 3, 8, 32, 6, 2, 6, 1, 10 )				
		,( 1, 3, 8, 32, 6, 2, 6, 2, '' )				
		,( 1, 3, 8, 32, 6, 2, 7, 1, 3 )				
		,( 1, 3, 8, 32, 6, 2, 7, 2, 7 )				
		,( 1, 3, 8, 32, 6, 2, 8, 1, 3 )				
		,( 1, 3, 8, 32, 6, 2, 8, 2, 7 )				
		,( 1, 3, 8, 32, 6, 2, 9, 1, 3 )				
		,( 1, 3, 8, 32, 6, 2, 9, 2, 6 )				
		,( 1, 3, 8, 32, 6, 2, 10, 1, 10 )				
		,( 1, 3, 8, 32, 6, 2, 10, 2, 10 )				
		,( 1, 3, 8, 32, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 33, 1, 1, 1, 1, 3 )					
		,( 1, 3, 9, 33, 1, 1, 1, 2, 4 )				
		,( 1, 3, 9, 33, 1, 1, 2, 1, 3 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 9, 33, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 3, 9, 33, 1, 1, 3, 1, 3 )				
		,( 1, 3, 9, 33, 1, 1, 3, 2, 4 )				
		,( 1, 3, 9, 33, 1, 1, 4, 1, 3 )				
		,( 1, 3, 9, 33, 1, 1, 4, 2, 4 )			-- Format:	
		,( 1, 3, 9, 33, 1, 1, 5, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 9, 33, 1, 1, 5, 2, 4 )			-- Some spares an no strikes	
		,( 1, 3, 9, 33, 1, 1, 6, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 9, 33, 1, 1, 6, 2, 4 )			-- No spares and some strikes	
		,( 1, 3, 9, 33, 1, 1, 7, 1, 3 )			-- No spares and all strikes	
		,( 1, 3, 9, 33, 1, 1, 7, 2, 4 )			-- Some spares and some strikes	
		,( 1, 3, 9, 33, 1, 1, 8, 1, 3 )				
		,( 1, 3, 9, 33, 1, 1, 8, 2, 4 )				
		,( 1, 3, 9, 33, 1, 1, 9, 1, 3 )				
		,( 1, 3, 9, 33, 1, 1, 9, 2, 4 )				
		,( 1, 3, 9, 33, 1, 1, 10, 1, 3 )				
		,( 1, 3, 9, 33, 1, 1, 10, 2, 4 )				
		,( 1, 3, 9, 33, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 33, 2, 1, 1, 1, 3 )					
		,( 1, 3, 9, 33, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 9, 33, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 9, 33, 2, 1, 2, 2, 2 )				
		,( 1, 3, 9, 33, 2, 1, 3, 1, 3 )				
		,( 1, 3, 9, 33, 2, 1, 3, 2, 7 )				
		,( 1, 3, 9, 33, 2, 1, 4, 1, 3 )				
		,( 1, 3, 9, 33, 2, 1, 4, 2, 2 )				
		,( 1, 3, 9, 33, 2, 1, 5, 1, 3 )				
		,( 1, 3, 9, 33, 2, 1, 5, 2, '' )				
		,( 1, 3, 9, 33, 2, 1, 6, 1, 6 )				
		,( 1, 3, 9, 33, 2, 1, 6, 2, 4 )				
		,( 1, 3, 9, 33, 2, 1, 7, 1, 3 )				
		,( 1, 3, 9, 33, 2, 1, 7, 2, 4 )				
		,( 1, 3, 9, 33, 2, 1, 8, 1, '' )				
		,( 1, 3, 9, 33, 2, 1, 8, 2, 4 )				
		,( 1, 3, 9, 33, 2, 1, 9, 1, 3 )				
		,( 1, 3, 9, 33, 2, 1, 9, 2, 7 )				
		,( 1, 3, 9, 33, 2, 1, 10, 1, 1 )				
		,( 1, 3, 9, 33, 2, 1, 10, 2, 1 )				
		,( 1, 3, 9, 33, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 33, 3, 1, 1, 1, 3 )					
		,( 1, 3, 9, 33, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 3, Week: 1,Total score: 128	
		,( 1, 3, 9, 33, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 9, 33, 3, 1, 2, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 3, 1, 3 )				
		,( 1, 3, 9, 33, 3, 1, 3, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 4, 1, 3 )				
		,( 1, 3, 9, 33, 3, 1, 4, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 5, 1, 3 )				
		,( 1, 3, 9, 33, 3, 1, 5, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 6, 1, 3 )				
		,( 1, 3, 9, 33, 3, 1, 6, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 7, 1, 3 )				
		,( 1, 3, 9, 33, 3, 1, 7, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 8, 1, 3 )				
		,( 1, 3, 9, 33, 3, 1, 8, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 9, 1, 3 )				
		,( 1, 3, 9, 33, 3, 1, 9, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 10, 1, 3 )				
		,( 1, 3, 9, 33, 3, 1, 10, 2, 7 )				
		,( 1, 3, 9, 33, 3, 1, 10, 3, 1 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 33, 4, 2, 1, 1, 10 )					
		,( 1, 3, 9, 33, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 9, Player: 33, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 9, 33, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 9, 33, 4, 2, 2, 2, 5 )				
		,( 1, 3, 9, 33, 4, 2, 3, 1, 10 )				
		,( 1, 3, 9, 33, 4, 2, 3, 2, '' )				
		,( 1, 3, 9, 33, 4, 2, 4, 1, 5 )				
		,( 1, 3, 9, 33, 4, 2, 4, 2, 3 )				
		,( 1, 3, 9, 33, 4, 2, 5, 1, 2 )				
		,( 1, 3, 9, 33, 4, 2, 5, 2, '' )				
		,( 1, 3, 9, 33, 4, 2, 6, 1, 3 )				
		,( 1, 3, 9, 33, 4, 2, 6, 2, 2 )				
		,( 1, 3, 9, 33, 4, 2, 7, 1, 10 )				
		,( 1, 3, 9, 33, 4, 2, 7, 2, '' )				
		,( 1, 3, 9, 33, 4, 2, 8, 1, '' )				
		,( 1, 3, 9, 33, 4, 2, 8, 2, '' )				
		,( 1, 3, 9, 33, 4, 2, 9, 1, '' )				
		,( 1, 3, 9, 33, 4, 2, 9, 2, '' )				
		,( 1, 3, 9, 33, 4, 2, 10, 1, 4 )				
		,( 1, 3, 9, 33, 4, 2, 10, 2, 6 )				
		,( 1, 3, 9, 33, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 33, 5, 2, 1, 1, 10 )					
		,( 1, 3, 9, 33, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 9, Player: 33, Game:5, Week: 2,Total score: 300	
		,( 1, 3, 9, 33, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 9, 33, 5, 2, 2, 2, '' )				
		,( 1, 3, 9, 33, 5, 2, 3, 1, 10 )				
		,( 1, 3, 9, 33, 5, 2, 3, 2, '' )				
 		,( 1, 3, 9, 33, 5, 2, 4, 1, 10 )				
		,( 1, 3, 9, 33, 5, 2, 4, 2, '' )				
		,( 1, 3, 9, 33, 5, 2, 5, 1, 10 )				
		,( 1, 3, 9, 33, 5, 2, 5, 2, '' )				
		,( 1, 3, 9, 33, 5, 2, 6, 1, 10 )				
		,( 1, 3, 9, 33, 5, 2, 6, 2, '' )				
		,( 1, 3, 9, 33, 5, 2, 7, 1, 10 )				
		,( 1, 3, 9, 33, 5, 2, 7, 2, '' )				
		,( 1, 3, 9, 33, 5, 2, 8, 1, 10 )				
		,( 1, 3, 9, 33, 5, 2, 8, 2, '' )				
		,( 1, 3, 9, 33, 5, 2, 9, 1, 10 )				
		,( 1, 3, 9, 33, 5, 2, 9, 2, '' )				
		,( 1, 3, 9, 33, 5, 2, 10, 1, 10 )				
		,( 1, 3, 9, 33, 5, 2, 10, 2, 10 )				
		,( 1, 3, 9, 33, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 33, 6, 2, 1, 1, 3 )					
		,( 1, 3, 9, 33, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 9, Player: 33, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 9, 33, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 9, 33, 6, 2, 2, 2, 7 )				
		,( 1, 3, 9, 33, 6, 2, 3, 1, 3 )				
		,( 1, 3, 9, 33, 6, 2, 3, 2, 7 )				
		,( 1, 3, 9, 33, 6, 2, 4, 1, 1 )				
		,( 1, 3, 9, 33, 6, 2, 4, 2, 2 )				
		,( 1, 3, 9, 33, 6, 2, 5, 1, 10 )				
		,( 1, 3, 9, 33, 6, 2, 5, 2, '' )				
		,( 1, 3, 9, 33, 6, 2, 6, 1, 10 )				
		,( 1, 3, 9, 33, 6, 2, 6, 2, '' )				
		,( 1, 3, 9, 33, 6, 2, 7, 1, 3 )				
		,( 1, 3, 9, 33, 6, 2, 7, 2, 7 )				
		,( 1, 3, 9, 33, 6, 2, 8, 1, 3 )				
		,( 1, 3, 9, 33, 6, 2, 8, 2, 7 )				
		,( 1, 3, 9, 33, 6, 2, 9, 1, 3 )				
		,( 1, 3, 9, 33, 6, 2, 9, 2, 6 )				
		,( 1, 3, 9, 33, 6, 2, 10, 1, 10 )				
		,( 1, 3, 9, 33, 6, 2, 10, 2, 10 )				
		,( 1, 3, 9, 33, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 34, 1, 1, 1, 1, 3 )					
		,( 1, 3, 9, 34, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 9, 34, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 9, 34, 1, 1, 2, 2, 4 )				
		,( 1, 3, 9, 34, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 9, 34, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 9, 34, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 9, 34, 1, 1, 4, 2, 4 )				
		,( 1, 3, 9, 34, 1, 1, 5, 1, 3 )				
		,( 1, 3, 9, 34, 1, 1, 5, 2, 4 )				
		,( 1, 3, 9, 34, 1, 1, 6, 1, 3 )				
		,( 1, 3, 9, 34, 1, 1, 6, 2, 4 )				
		,( 1, 3, 9, 34, 1, 1, 7, 1, 3 )				
		,( 1, 3, 9, 34, 1, 1, 7, 2, 4 )				
		,( 1, 3, 9, 34, 1, 1, 8, 1, 3 )				
		,( 1, 3, 9, 34, 1, 1, 8, 2, 4 )				
		,( 1, 3, 9, 34, 1, 1, 9, 1, 3 )				
		,( 1, 3, 9, 34, 1, 1, 9, 2, 4 )				
		,( 1, 3, 9, 34, 1, 1, 10, 1, 3 )				
		,( 1, 3, 9, 34, 1, 1, 10, 2, 4 )				
		,( 1, 3, 9, 34, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 34, 2, 1, 1, 1, 3 )					
		,( 1, 3, 9, 34, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 9, 34, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 9, 34, 2, 1, 2, 2, 2 )				
		,( 1, 3, 9, 34, 2, 1, 3, 1, 3 )				
		,( 1, 3, 9, 34, 2, 1, 3, 2, 7 )				
		,( 1, 3, 9, 34, 2, 1, 4, 1, 3 )				
		,( 1, 3, 9, 34, 2, 1, 4, 2, 2 )				
		,( 1, 3, 9, 34, 2, 1, 5, 1, 3 )				
		,( 1, 3, 9, 34, 2, 1, 5, 2, '' )				
		,( 1, 3, 9, 34, 2, 1, 6, 1, 6 )				
		,( 1, 3, 9, 34, 2, 1, 6, 2, 4 )				
		,( 1, 3, 9, 34, 2, 1, 7, 1, 3 )				
		,( 1, 3, 9, 34, 2, 1, 7, 2, 4 )				
		,( 1, 3, 9, 34, 2, 1, 8, 1, '' )				
		,( 1, 3, 9, 34, 2, 1, 8, 2, 4 )				
		,( 1, 3, 9, 34, 2, 1, 9, 1, 3 )				
		,( 1, 3, 9, 34, 2, 1, 9, 2, 7 )				
		,( 1, 3, 9, 34, 2, 1, 10, 1, 1 )				
		,( 1, 3, 9, 34, 2, 1, 10, 2, 1 )				
		,( 1, 3, 9, 34, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 34, 3, 1, 1, 1, 3 )					
		,( 1, 3, 9, 34, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 3, Week: 1,Total score: 128	
		,( 1, 3, 9, 34, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 9, 34, 3, 1, 2, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 3, 1, 3 )				
		,( 1, 3, 9, 34, 3, 1, 3, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 4, 1, 3 )				
		,( 1, 3, 9, 34, 3, 1, 4, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 5, 1, 3 )				
		,( 1, 3, 9, 34, 3, 1, 5, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 6, 1, 3 )				
		,( 1, 3, 9, 34, 3, 1, 6, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 7, 1, 3 )				
		,( 1, 3, 9, 34, 3, 1, 7, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 8, 1, 3 )				
		,( 1, 3, 9, 34, 3, 1, 8, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 9, 1, 3 )				
		,( 1, 3, 9, 34, 3, 1, 9, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 10, 1, 3 )				
		,( 1, 3, 9, 34, 3, 1, 10, 2, 7 )				
		,( 1, 3, 9, 34, 3, 1, 10, 3, 1 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 34, 4, 2, 1, 1, 10 )					
		,( 1, 3, 9, 34, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 9, Player: 34, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 9, 34, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 9, 34, 4, 2, 2, 2, 5 )				
		,( 1, 3, 9, 34, 4, 2, 3, 1, 10 )				
		,( 1, 3, 9, 34, 4, 2, 3, 2, '' )				
		,( 1, 3, 9, 34, 4, 2, 4, 1, 5 )				
		,( 1, 3, 9, 34, 4, 2, 4, 2, 3 )				
		,( 1, 3, 9, 34, 4, 2, 5, 1, 2 )				
		,( 1, 3, 9, 34, 4, 2, 5, 2, '' )				
		,( 1, 3, 9, 34, 4, 2, 6, 1, 3 )				
		,( 1, 3, 9, 34, 4, 2, 6, 2, 2 )				
		,( 1, 3, 9, 34, 4, 2, 7, 1, 10 )				
		,( 1, 3, 9, 34, 4, 2, 7, 2, '' )				
		,( 1, 3, 9, 34, 4, 2, 8, 1, '' )				
		,( 1, 3, 9, 34, 4, 2, 8, 2, '' )				
		,( 1, 3, 9, 34, 4, 2, 9, 1, '' )				
		,( 1, 3, 9, 34, 4, 2, 9, 2, '' )				
		,( 1, 3, 9, 34, 4, 2, 10, 1, 4 )				
		,( 1, 3, 9, 34, 4, 2, 10, 2, 6 )				
		,( 1, 3, 9, 34, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 34, 5, 2, 1, 1, 10 )					
		,( 1, 3, 9, 34, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 9, 34, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 9, 34, 5, 2, 2, 2, '' )				
		,( 1, 3, 9, 34, 5, 2, 3, 1, 10 )				
		,( 1, 3, 9, 34, 5, 2, 3, 2, '' )				
		,( 1, 3, 9, 34, 5, 2, 4, 1, 10 )				
		,( 1, 3, 9, 34, 5, 2, 4, 2, '' )				
		,( 1, 3, 9, 34, 5, 2, 5, 1, 10 )				
		,( 1, 3, 9, 34, 5, 2, 5, 2, '' )				
		,( 1, 3, 9, 34, 5, 2, 6, 1, 10 )				
		,( 1, 3, 9, 34, 5, 2, 6, 2, '' )				
		,( 1, 3, 9, 34, 5, 2, 7, 1, 10 )				
		,( 1, 3, 9, 34, 5, 2, 7, 2, '' )				
		,( 1, 3, 9, 34, 5, 2, 8, 1, 10 )				
		,( 1, 3, 9, 34, 5, 2, 8, 2, '' )				
		,( 1, 3, 9, 34, 5, 2, 9, 1, 10 )				
		,( 1, 3, 9, 34, 5, 2, 9, 2, '' )				
		,( 1, 3, 9, 34, 5, 2, 10, 1, 10 )				
		,( 1, 3, 9, 34, 5, 2, 10, 2, 10 )				
		,( 1, 3, 9, 34, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 34, 6, 2, 1, 1, 3 )					
		,( 1, 3, 9, 34, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 9, Player: 34, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 9, 34, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 9, 34, 6, 2, 2, 2, 7 )				
		,( 1, 3, 9, 34, 6, 2, 3, 1, 3 )				
		,( 1, 3, 9, 34, 6, 2, 3, 2, 7 )				
		,( 1, 3, 9, 34, 6, 2, 4, 1, 1 )				
		,( 1, 3, 9, 34, 6, 2, 4, 2, 2 )				
		,( 1, 3, 9, 34, 6, 2, 5, 1, 10 )				
		,( 1, 3, 9, 34, 6, 2, 5, 2, '' )				
		,( 1, 3, 9, 34, 6, 2, 6, 1, 10 )				
		,( 1, 3, 9, 34, 6, 2, 6, 2, '' )				
		,( 1, 3, 9, 34, 6, 2, 7, 1, 3 )				
		,( 1, 3, 9, 34, 6, 2, 7, 2, 7 )				
		,( 1, 3, 9, 34, 6, 2, 8, 1, 3 )				
		,( 1, 3, 9, 34, 6, 2, 8, 2, 7 )				
		,( 1, 3, 9, 34, 6, 2, 9, 1, 3 )				
		,( 1, 3, 9, 34, 6, 2, 9, 2, 6 )				
		,( 1, 3, 9, 34, 6, 2, 10, 1, 10 )				
		,( 1, 3, 9, 34, 6, 2, 10, 2, 10 )				
		,( 1, 3, 9, 34, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 35, 1, 1, 1, 1, 3 )					
		,( 1, 3, 9, 35, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 9, 35, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 9, 35, 1, 1, 2, 2, 4 )				
		,( 1, 3, 9, 35, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 9, 35, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 9, 35, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 9, 35, 1, 1, 4, 2, 4 )				
		,( 1, 3, 9, 35, 1, 1, 5, 1, 3 )				
		,( 1, 3, 9, 35, 1, 1, 5, 2, 4 )				
		,( 1, 3, 9, 35, 1, 1, 6, 1, 3 )				
		,( 1, 3, 9, 35, 1, 1, 6, 2, 4 )				
		,( 1, 3, 9, 35, 1, 1, 7, 1, 3 )				
		,( 1, 3, 9, 35, 1, 1, 7, 2, 4 )				
		,( 1, 3, 9, 35, 1, 1, 8, 1, 3 )				
		,( 1, 3, 9, 35, 1, 1, 8, 2, 4 )				
		,( 1, 3, 9, 35, 1, 1, 9, 1, 3 )				
		,( 1, 3, 9, 35, 1, 1, 9, 2, 4 )				
		,( 1, 3, 9, 35, 1, 1, 10, 1, 3 )				
		,( 1, 3, 9, 35, 1, 1, 10, 2, 4 )				
		,( 1, 3, 9, 35, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 35, 2, 1, 1, 1, 3 )					
		,( 1, 3, 9, 35, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 9, 35, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 9, 35, 2, 1, 2, 2, 2 )				
		,( 1, 3, 9, 35, 2, 1, 3, 1, 3 )				
		,( 1, 3, 9, 35, 2, 1, 3, 2, 7 )				
		,( 1, 3, 9, 35, 2, 1, 4, 1, 3 )				
		,( 1, 3, 9, 35, 2, 1, 4, 2, 2 )				
		,( 1, 3, 9, 35, 2, 1, 5, 1, 3 )				
		,( 1, 3, 9, 35, 2, 1, 5, 2, '' )				
		,( 1, 3, 9, 35, 2, 1, 6, 1, 6 )				
		,( 1, 3, 9, 35, 2, 1, 6, 2, 4 )				
		,( 1, 3, 9, 35, 2, 1, 7, 1, 3 )				
		,( 1, 3, 9, 35, 2, 1, 7, 2, 4 )				
		,( 1, 3, 9, 35, 2, 1, 8, 1, '' )				
		,( 1, 3, 9, 35, 2, 1, 8, 2, 4 )				
		,( 1, 3, 9, 35, 2, 1, 9, 1, 3 )				
		,( 1, 3, 9, 35, 2, 1, 9, 2, 7 )				
		,( 1, 3, 9, 35, 2, 1, 10, 1, 1 )				
		,( 1, 3, 9, 35, 2, 1, 10, 2, 1 )				
		,( 1, 3, 9, 35, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 35, 3, 1, 1, 1, 3 )					
		,( 1, 3, 9, 35, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 3, Week: 1,Total score: 130	
		,( 1, 3, 9, 35, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 9, 35, 3, 1, 2, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 3, 1, 3 )				
		,( 1, 3, 9, 35, 3, 1, 3, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 4, 1, 3 )				
		,( 1, 3, 9, 35, 3, 1, 4, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 5, 1, 3 )				
		,( 1, 3, 9, 35, 3, 1, 5, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 6, 1, 3 )				
		,( 1, 3, 9, 35, 3, 1, 6, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 7, 1, 3 )				
		,( 1, 3, 9, 35, 3, 1, 7, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 8, 1, 3 )				
		,( 1, 3, 9, 35, 3, 1, 8, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 9, 1, 3 )				
		,( 1, 3, 9, 35, 3, 1, 9, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 10, 1, 3 )				
		,( 1, 3, 9, 35, 3, 1, 10, 2, 7 )				
		,( 1, 3, 9, 35, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 35, 4, 2, 1, 1, 10 )					
		,( 1, 3, 9, 35, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 9, Player: 35, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 9, 35, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 9, 35, 4, 2, 2, 2, 5 )				
		,( 1, 3, 9, 35, 4, 2, 3, 1, 10 )				
		,( 1, 3, 9, 35, 4, 2, 3, 2, '' )				
		,( 1, 3, 9, 35, 4, 2, 4, 1, 5 )				
		,( 1, 3, 9, 35, 4, 2, 4, 2, 3 )				
		,( 1, 3, 9, 35, 4, 2, 5, 1, 2 )				
		,( 1, 3, 9, 35, 4, 2, 5, 2, '' )				
		,( 1, 3, 9, 35, 4, 2, 6, 1, 3 )				
		,( 1, 3, 9, 35, 4, 2, 6, 2, 2 )				
		,( 1, 3, 9, 35, 4, 2, 7, 1, 10 )				
		,( 1, 3, 9, 35, 4, 2, 7, 2, '' )				
		,( 1, 3, 9, 35, 4, 2, 8, 1, '' )				
		,( 1, 3, 9, 35, 4, 2, 8, 2, '' )				
		,( 1, 3, 9, 35, 4, 2, 9, 1, '' )				
		,( 1, 3, 9, 35, 4, 2, 9, 2, '' )				
		,( 1, 3, 9, 35, 4, 2, 10, 1, 4 )				
		,( 1, 3, 9, 35, 4, 2, 10, 2, 6 )				
		,( 1, 3, 9, 35, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 35, 5, 2, 1, 1, 10 )					
		,( 1, 3, 9, 35, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 9, 35, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 9, 35, 5, 2, 2, 2, '' )				
		,( 1, 3, 9, 35, 5, 2, 3, 1, 10 )				
		,( 1, 3, 9, 35, 5, 2, 3, 2, '' )				
		,( 1, 3, 9, 35, 5, 2, 4, 1, 10 )				
		,( 1, 3, 9, 35, 5, 2, 4, 2, '' )				
		,( 1, 3, 9, 35, 5, 2, 5, 1, 10 )				
		,( 1, 3, 9, 35, 5, 2, 5, 2, '' )				
		,( 1, 3, 9, 35, 5, 2, 6, 1, 10 )				
		,( 1, 3, 9, 35, 5, 2, 6, 2, '' )				
		,( 1, 3, 9, 35, 5, 2, 7, 1, 10 )				
		,( 1, 3, 9, 35, 5, 2, 7, 2, '' )				
		,( 1, 3, 9, 35, 5, 2, 8, 1, 10 )				
		,( 1, 3, 9, 35, 5, 2, 8, 2, '' )				
		,( 1, 3, 9, 35, 5, 2, 9, 1, 10 )				
		,( 1, 3, 9, 35, 5, 2, 9, 2, '' )				
		,( 1, 3, 9, 35, 5, 2, 10, 1, 10 )				
		,( 1, 3, 9, 35, 5, 2, 10, 2, 10 )				
		,( 1, 3, 9, 35, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 35, 6, 2, 1, 1, 3 )					
		,( 1, 3, 9, 35, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 9, Player: 35, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 9, 35, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 9, 35, 6, 2, 2, 2, 7 )				
		,( 1, 3, 9, 35, 6, 2, 3, 1, 3 )				
		,( 1, 3, 9, 35, 6, 2, 3, 2, 7 )				
		,( 1, 3, 9, 35, 6, 2, 4, 1, 1 )				
		,( 1, 3, 9, 35, 6, 2, 4, 2, 2 )				
		,( 1, 3, 9, 35, 6, 2, 5, 1, 10 )				
		,( 1, 3, 9, 35, 6, 2, 5, 2, '' )				
		,( 1, 3, 9, 35, 6, 2, 6, 1, 10 )				
		,( 1, 3, 9, 35, 6, 2, 6, 2, '' )				
		,( 1, 3, 9, 35, 6, 2, 7, 1, 3 )				
		,( 1, 3, 9, 35, 6, 2, 7, 2, 7 )				
		,( 1, 3, 9, 35, 6, 2, 8, 1, 3 )				
		,( 1, 3, 9, 35, 6, 2, 8, 2, 7 )				
		,( 1, 3, 9, 35, 6, 2, 9, 1, 3 )				
		,( 1, 3, 9, 35, 6, 2, 9, 2, 6 )				
		,( 1, 3, 9, 35, 6, 2, 10, 1, 10 )				
		,( 1, 3, 9, 35, 6, 2, 10, 2, 10 )				
		,( 1, 3, 9, 35, 6, 2, 10, 3, 10 )				
			
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 36, 1, 1, 1, 1, 3 )					
		,( 1, 3, 9, 36, 1, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 1, Week: 1,Total score: 70	
		,( 1, 3, 9, 36, 1, 1, 2, 1, 3 )			-- No spares and no strikes	
		,( 1, 3, 9, 36, 1, 1, 2, 2, 4 )				
		,( 1, 3, 9, 36, 1, 1, 3, 1, 3 )			-- Repeat of above BUT	
		,( 1, 3, 9, 36, 1, 1, 3, 2, 4 )			-- different player same everything else	
		,( 1, 3, 9, 36, 1, 1, 4, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 3, 9, 36, 1, 1, 4, 2, 4 )				
		,( 1, 3, 9, 36, 1, 1, 5, 1, 3 )				
		,( 1, 3, 9, 36, 1, 1, 5, 2, 4 )				
		,( 1, 3, 9, 36, 1, 1, 6, 1, 3 )				
		,( 1, 3, 9, 36, 1, 1, 6, 2, 4 )				
		,( 1, 3, 9, 36, 1, 1, 7, 1, 3 )				
		,( 1, 3, 9, 36, 1, 1, 7, 2, 4 )				
		,( 1, 3, 9, 36, 1, 1, 8, 1, 3 )				
		,( 1, 3, 9, 36, 1, 1, 8, 2, 4 )				
		,( 1, 3, 9, 36, 1, 1, 9, 1, 3 )				
		,( 1, 3, 9, 36, 1, 1, 9, 2, 4 )				
		,( 1, 3, 9, 36, 1, 1, 10, 1, 3 )				
		,( 1, 3, 9, 36, 1, 1, 10, 2, 4 )				
		,( 1, 3, 9, 36, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 36, 2, 1, 1, 1, 3 )					
		,( 1, 3, 9, 36, 2, 1, 1, 2, 4 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 2, Week: 1,Total score: 70	
		,( 1, 3, 9, 36, 2, 1, 2, 1, 3 )			-- Some spares and no strikes	
		,( 1, 3, 9, 36, 2, 1, 2, 2, 2 )				
		,( 1, 3, 9, 36, 2, 1, 3, 1, 3 )				
		,( 1, 3, 9, 36, 2, 1, 3, 2, 7 )				
		,( 1, 3, 9, 36, 2, 1, 4, 1, 3 )				
		,( 1, 3, 9, 36, 2, 1, 4, 2, 2 )				
		,( 1, 3, 9, 36, 2, 1, 5, 1, 3 )				
		,( 1, 3, 9, 36, 2, 1, 5, 2, '' )				
		,( 1, 3, 9, 36, 2, 1, 6, 1, 6 )				
		,( 1, 3, 9, 36, 2, 1, 6, 2, 4 )				
		,( 1, 3, 9, 36, 2, 1, 7, 1, 3 )				
		,( 1, 3, 9, 36, 2, 1, 7, 2, 4 )				
		,( 1, 3, 9, 36, 2, 1, 8, 1, '' )				
		,( 1, 3, 9, 36, 2, 1, 8, 2, 4 )				
		,( 1, 3, 9, 36, 2, 1, 9, 1, 3 )				
		,( 1, 3, 9, 36, 2, 1, 9, 2, 7 )				
		,( 1, 3, 9, 36, 2, 1, 10, 1, 1 )				
		,( 1, 3, 9, 36, 2, 1, 10, 2, 1 )				
		,( 1, 3, 9, 36, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 36, 3, 1, 1, 1, 3 )					
		,( 1, 3, 9, 36, 3, 1, 1, 2, 7 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 3, Week: 1,Total score: 128	
		,( 1, 3, 9, 36, 3, 1, 2, 1, 3 )			-- All spares and no strikes	
		,( 1, 3, 9, 36, 3, 1, 2, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 3, 1, 3 )				
		,( 1, 3, 9, 36, 3, 1, 3, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 4, 1, 3 )				
		,( 1, 3, 9, 36, 3, 1, 4, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 5, 1, 3 )				
		,( 1, 3, 9, 36, 3, 1, 5, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 6, 1, 3 )				
		,( 1, 3, 9, 36, 3, 1, 6, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 7, 1, 3 )				
		,( 1, 3, 9, 36, 3, 1, 7, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 8, 1, 3 )				
		,( 1, 3, 9, 36, 3, 1, 8, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 9, 1, 3 )				
		,( 1, 3, 9, 36, 3, 1, 9, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 10, 1, 3 )				
		,( 1, 3, 9, 36, 3, 1, 10, 2, 7 )				
		,( 1, 3, 9, 36, 3, 1, 10, 3, 1 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 36, 4, 2, 1, 1, 10 )					
		,( 1, 3, 9, 36, 4, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 9, Player: 36, Game:4, Week: 2,Total score: 70	
		,( 1, 3, 9, 36, 4, 2, 2, 1, '' )			-- No spares and some strikes	
		,( 1, 3, 9, 36, 4, 2, 2, 2, 5 )				
		,( 1, 3, 9, 36, 4, 2, 3, 1, 10 )				
		,( 1, 3, 9, 36, 4, 2, 3, 2, '' )				
		,( 1, 3, 9, 36, 4, 2, 4, 1, 5 )				
		,( 1, 3, 9, 36, 4, 2, 4, 2, 3 )				
		,( 1, 3, 9, 36, 4, 2, 5, 1, 2 )				
		,( 1, 3, 9, 36, 4, 2, 5, 2, '' )				
		,( 1, 3, 9, 36, 4, 2, 6, 1, 3 )				
		,( 1, 3, 9, 36, 4, 2, 6, 2, 2 )				
		,( 1, 3, 9, 36, 4, 2, 7, 1, 10 )				
		,( 1, 3, 9, 36, 4, 2, 7, 2, '' )				
		,( 1, 3, 9, 36, 4, 2, 8, 1, '' )				
		,( 1, 3, 9, 36, 4, 2, 8, 2, '' )				
		,( 1, 3, 9, 36, 4, 2, 9, 1, '' )				
		,( 1, 3, 9, 36, 4, 2, 9, 2, '' )				
		,( 1, 3, 9, 36, 4, 2, 10, 1, 4 )				
		,( 1, 3, 9, 36, 4, 2, 10, 2, 6 )				
		,( 1, 3, 9, 36, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 36, 5, 2, 1, 1, 10 )					
		,( 1, 3, 9, 36, 5, 2, 1, 2, '' )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 5, Week: 2,Total score: 300	
		,( 1, 3, 9, 36, 5, 2, 2, 1, 10 )			-- No spares and all strikes	
		,( 1, 3, 9, 36, 5, 2, 2, 2, '' )				
		,( 1, 3, 9, 36, 5, 2, 3, 1, 10 )				
		,( 1, 3, 9, 36, 5, 2, 3, 2, '' )				
		,( 1, 3, 9, 36, 5, 2, 4, 1, 10 )				
		,( 1, 3, 9, 36, 5, 2, 4, 2, '' )				
		,( 1, 3, 9, 36, 5, 2, 5, 1, 10 )				
		,( 1, 3, 9, 36, 5, 2, 5, 2, '' )				
		,( 1, 3, 9, 36, 5, 2, 6, 1, 10 )				
		,( 1, 3, 9, 36, 5, 2, 6, 2, '' )				
		,( 1, 3, 9, 36, 5, 2, 7, 1, 10 )				
		,( 1, 3, 9, 36, 5, 2, 7, 2, '' )				
		,( 1, 3, 9, 36, 5, 2, 8, 1, 10 )				
		,( 1, 3, 9, 36, 5, 2, 8, 2, '' )				
		,( 1, 3, 9, 36, 5, 2, 9, 1, 10 )				
		,( 1, 3, 9, 36, 5, 2, 9, 2, '' )				
		,( 1, 3, 9, 36, 5, 2, 10, 1, 10 )				
		,( 1, 3, 9, 36, 5, 2, 10, 2, 10 )				
		,( 1, 3, 9, 36, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 3, 9, 36, 6, 2, 1, 1, 3 )					
		,( 1, 3, 9, 36, 6, 2, 1, 2, 7 )			-- Year 2011, League: 3, Team: 9, Player: 36, Game: 6, Week: 2,Total score: 148	
		,( 1, 3, 9, 36, 6, 2, 2, 1, 3 )			-- Some spares and some strikes	
		,( 1, 3, 9, 36, 6, 2, 2, 2, 7 )				
		,( 1, 3, 9, 36, 6, 2, 3, 1, 3 )				
		,( 1, 3, 9, 36, 6, 2, 3, 2, 7 )				
		,( 1, 3, 9, 36, 6, 2, 4, 1, 1 )				
		,( 1, 3, 9, 36, 6, 2, 4, 2, 2 )				
		,( 1, 3, 9, 36, 6, 2, 5, 1, 10 )				
		,( 1, 3, 9, 36, 6, 2, 5, 2, '' )				
		,( 1, 3, 9, 36, 6, 2, 6, 1, 10 )				
		,( 1, 3, 9, 36, 6, 2, 6, 2, '' )				
		,( 1, 3, 9, 36, 6, 2, 7, 1, 3 )				
		,( 1, 3, 9, 36, 6, 2, 7, 2, 7 )				
		,( 1, 3, 9, 36, 6, 2, 8, 1, 3 )				
		,( 1, 3, 9, 36, 6, 2, 8, 2, 7 )				
		,( 1, 3, 9, 36, 6, 2, 9, 1, 3 )				
		,( 1, 3, 9, 36, 6, 2, 9, 2, 6 )				
		,( 1, 3, 9, 36, 6, 2, 10, 1, 10 )				
		,( 1, 3, 9, 36, 6, 2, 10, 2, 10 )				
		,( 1, 3, 9, 36, 6, 2, 10, 3, 10 )				
					
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 1, 1, 1, 1, 1, 3 )					
		,( 1, 4, 10, 1, 1, 1, 1, 2, 4 )				
		,( 1, 4, 10, 1, 1, 1, 2, 1, 3 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 10, 1, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 4, 10, 1, 1, 1, 3, 1, 3 )				
		,( 1, 4, 10, 1, 1, 1, 3, 2, 4 )			-- Same as #1 BUT	
		,( 1, 4, 10, 1, 1, 1, 4, 1, 3 )			-- different league, different player	
		,( 1, 4, 10, 1, 1, 1, 4, 2, 4 )			-- This will test league scoring	
		,( 1, 4, 10, 1, 1, 1, 5, 1, 3 )			-- Same player but now on couples league instead of singles	
		,( 1, 4, 10, 1, 1, 1, 5, 2, 4 )				
		,( 1, 4, 10, 1, 1, 1, 6, 1, 3 )				
		,( 1, 4, 10, 1, 1, 1, 6, 2, 4 )			-- Format:	
		,( 1, 4, 10, 1, 1, 1, 7, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 10, 1, 1, 1, 7, 2, 4 )			-- Some spares an no strikes	
		,( 1, 4, 10, 1, 1, 1, 8, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 10, 1, 1, 1, 8, 2, 4 )			-- No spares and some strikes	
		,( 1, 4, 10, 1, 1, 1, 9, 1, 3 )			-- No spares and all strikes	
		,( 1, 4, 10, 1, 1, 1, 9, 2, 4 )			-- Some spares and some strikes	
		,( 1, 4, 10, 1, 1, 1, 10, 1, 3 )				
		,( 1, 4, 10, 1, 1, 1, 10, 2, 4 )				
		,( 1, 4, 10, 1, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 1, 2, 1, 1, 1, 3 )					
		,( 1, 4, 10, 1, 2, 1, 1, 2, 4 )				
		,( 1, 4, 10, 1, 2, 1, 2, 1, 3 )				
		,( 1, 4, 10, 1, 2, 1, 2, 2, 2 )				
		,( 1, 4, 10, 1, 2, 1, 3, 1, 3 )				
		,( 1, 4, 10, 1, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 10, 1, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 10, 1, 2, 1, 4, 2, 2 )				
		,( 1, 4, 10, 1, 2, 1, 5, 1, 3 )				
		,( 1, 4, 10, 1, 2, 1, 5, 2, '' )				
		,( 1, 4, 10, 1, 2, 1, 6, 1, 6 )				
		,( 1, 4, 10, 1, 2, 1, 6, 2, 4 )				
		,( 1, 4, 10, 1, 2, 1, 7, 1, 3 )				
		,( 1, 4, 10, 1, 2, 1, 7, 2, 4 )				
		,( 1, 4, 10, 1, 2, 1, 8, 1, '' )				
		,( 1, 4, 10, 1, 2, 1, 8, 2, 4 )				
		,( 1, 4, 10, 1, 2, 1, 9, 1, 3 )				
		,( 1, 4, 10, 1, 2, 1, 9, 2, 7 )				
		,( 1, 4, 10, 1, 2, 1, 10, 1, 1 )				
		,( 1, 4, 10, 1, 2, 1, 10, 2, 1 )				
		,( 1, 4, 10, 1, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 1, 3, 1, 1, 1, 3 )					
		,( 1, 4, 10, 1, 3, 1, 1, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 2, 1, 3 )				
		,( 1, 4, 10, 1, 3, 1, 2, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 3, 1, 3 )				
		,( 1, 4, 10, 1, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 3, Week: 1,Total score: 129	
		,( 1, 4, 10, 1, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 10, 1, 3, 1, 4, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 5, 1, 3 )				
		,( 1, 4, 10, 1, 3, 1, 5, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 6, 1, 3 )				
		,( 1, 4, 10, 1, 3, 1, 6, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 7, 1, 3 )				
		,( 1, 4, 10, 1, 3, 1, 7, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 8, 1, 3 )				
		,( 1, 4, 10, 1, 3, 1, 8, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 9, 1, 3 )				
		,( 1, 4, 10, 1, 3, 1, 9, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 10, 1, 3 )				
		,( 1, 4, 10, 1, 3, 1, 10, 2, 7 )				
		,( 1, 4, 10, 1, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 1, 4, 2, 1, 1, 10 )					
		,( 1, 4, 10, 1, 4, 2, 1, 2, '' )				
		,( 1, 4, 10, 1, 4, 2, 2, 1, '' )				
		,( 1, 4, 10, 1, 4, 2, 2, 2, 5 )				
		,( 1, 4, 10, 1, 4, 2, 3, 1, 10 )				
		,( 1, 4, 10, 1, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 10, Player: 1, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 10, 1, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 10, 1, 4, 2, 4, 2, 3 )				
		,( 1, 4, 10, 1, 4, 2, 5, 1, 2 )				
		,( 1, 4, 10, 1, 4, 2, 5, 2, '' )				
		,( 1, 4, 10, 1, 4, 2, 6, 1, 3 )				
		,( 1, 4, 10, 1, 4, 2, 6, 2, 2 )				
		,( 1, 4, 10, 1, 4, 2, 7, 1, 10 )				
		,( 1, 4, 10, 1, 4, 2, 7, 2, '' )				
		,( 1, 4, 10, 1, 4, 2, 8, 1, '' )				
		,( 1, 4, 10, 1, 4, 2, 8, 2, '' )				
		,( 1, 4, 10, 1, 4, 2, 9, 1, '' )				
		,( 1, 4, 10, 1, 4, 2, 9, 2, '' )				
		,( 1, 4, 10, 1, 4, 2, 10, 1, 4 )				
		,( 1, 4, 10, 1, 4, 2, 10, 2, 6 )				
		,( 1, 4, 10, 1, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 1, 5, 2, 1, 1, 10 )					
		,( 1, 4, 10, 1, 5, 2, 1, 2, '' )				
		,( 1, 4, 10, 1, 5, 2, 2, 1, 10 )				
		,( 1, 4, 10, 1, 5, 2, 2, 2, '' )				
		,( 1, 4, 10, 1, 5, 2, 3, 1, 10 )				
		,( 1, 4, 10, 1, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 10, Player: 1, Game:5, Week: 2,Total score: 300	
 		,( 1, 4, 10, 1, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 10, 1, 5, 2, 4, 2, '' )				
		,( 1, 4, 10, 1, 5, 2, 5, 1, 10 )				
		,( 1, 4, 10, 1, 5, 2, 5, 2, '' )				
		,( 1, 4, 10, 1, 5, 2, 6, 1, 10 )				
		,( 1, 4, 10, 1, 5, 2, 6, 2, '' )				
		,( 1, 4, 10, 1, 5, 2, 7, 1, 10 )				
		,( 1, 4, 10, 1, 5, 2, 7, 2, '' )				
		,( 1, 4, 10, 1, 5, 2, 8, 1, 10 )				
		,( 1, 4, 10, 1, 5, 2, 8, 2, '' )				
		,( 1, 4, 10, 1, 5, 2, 9, 1, 10 )				
		,( 1, 4, 10, 1, 5, 2, 9, 2, '' )				
		,( 1, 4, 10, 1, 5, 2, 10, 1, 10 )				
		,( 1, 4, 10, 1, 5, 2, 10, 2, 10 )				
		,( 1, 4, 10, 1, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 1, 6, 2, 1, 1, 3 )					
		,( 1, 4, 10, 1, 6, 2, 1, 2, 7 )				
		,( 1, 4, 10, 1, 6, 2, 2, 1, 3 )				
		,( 1, 4, 10, 1, 6, 2, 2, 2, 7 )				
		,( 1, 4, 10, 1, 6, 2, 3, 1, 3 )				
		,( 1, 4, 10, 1, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 1, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 10, 1, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 10, 1, 6, 2, 4, 2, 2 )				
		,( 1, 4, 10, 1, 6, 2, 5, 1, 10 )				
		,( 1, 4, 10, 1, 6, 2, 5, 2, '' )				
		,( 1, 4, 10, 1, 6, 2, 6, 1, 10 )				
		,( 1, 4, 10, 1, 6, 2, 6, 2, '' )				
		,( 1, 4, 10, 1, 6, 2, 7, 1, 3 )				
		,( 1, 4, 10, 1, 6, 2, 7, 2, 7 )				
		,( 1, 4, 10, 1, 6, 2, 8, 1, 3 )				
		,( 1, 4, 10, 1, 6, 2, 8, 2, 7 )				
		,( 1, 4, 10, 1, 6, 2, 9, 1, 3 )				
		,( 1, 4, 10, 1, 6, 2, 9, 2, 6 )				
		,( 1, 4, 10, 1, 6, 2, 10, 1, 10 )				
		,( 1, 4, 10, 1, 6, 2, 10, 2, 10 )				
		,( 1, 4, 10, 1, 6, 2, 10, 3, 10 )				
					
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 38, 1, 1, 1, 1, 3 )					
		,( 1, 4, 10, 38, 1, 1, 1, 2, 4 )				
		,( 1, 4, 10, 38, 1, 1, 2, 1, 3 )				
		,( 1, 4, 10, 38, 1, 1, 2, 2, 4 )				
		,( 1, 4, 10, 38, 1, 1, 3, 1, 3 )				
		,( 1, 4, 10, 38, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 10, 38, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 10, 38, 1, 1, 4, 2, 4 )				
		,( 1, 4, 10, 38, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 10, 38, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 10, 38, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 10, 38, 1, 1, 6, 2, 4 )				
		,( 1, 4, 10, 38, 1, 1, 7, 1, 3 )				
		,( 1, 4, 10, 38, 1, 1, 7, 2, 4 )				
		,( 1, 4, 10, 38, 1, 1, 8, 1, 3 )				
		,( 1, 4, 10, 38, 1, 1, 8, 2, 4 )				
		,( 1, 4, 10, 38, 1, 1, 9, 1, 3 )				
		,( 1, 4, 10, 38, 1, 1, 9, 2, 4 )				
		,( 1, 4, 10, 38, 1, 1, 10, 1, 3 )				
		,( 1, 4, 10, 38, 1, 1, 10, 2, 4 )				
		,( 1, 4, 10, 38, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 38, 2, 1, 1, 1, 3 )					
		,( 1, 4, 10, 38, 2, 1, 1, 2, 4 )				
		,( 1, 4, 10, 38, 2, 1, 2, 1, 3 )				
		,( 1, 4, 10, 38, 2, 1, 2, 2, 2 )				
		,( 1, 4, 10, 38, 2, 1, 3, 1, 3 )				
		,( 1, 4, 10, 38, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 10, 38, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 10, 38, 2, 1, 4, 2, 2 )				
		,( 1, 4, 10, 38, 2, 1, 5, 1, 3 )				
		,( 1, 4, 10, 38, 2, 1, 5, 2, '' )				
		,( 1, 4, 10, 38, 2, 1, 6, 1, 6 )				
		,( 1, 4, 10, 38, 2, 1, 6, 2, 4 )				
		,( 1, 4, 10, 38, 2, 1, 7, 1, 3 )				
		,( 1, 4, 10, 38, 2, 1, 7, 2, 4 )				
		,( 1, 4, 10, 38, 2, 1, 8, 1, '' )				
		,( 1, 4, 10, 38, 2, 1, 8, 2, 4 )				
		,( 1, 4, 10, 38, 2, 1, 9, 1, 3 )				
		,( 1, 4, 10, 38, 2, 1, 9, 2, 7 )				
		,( 1, 4, 10, 38, 2, 1, 10, 1, 1 )				
		,( 1, 4, 10, 38, 2, 1, 10, 2, 1 )				
		,( 1, 4, 10, 38, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 38, 3, 1, 1, 1, 3 )					
		,( 1, 4, 10, 38, 3, 1, 1, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 2, 1, 3 )				
		,( 1, 4, 10, 38, 3, 1, 2, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 3, 1, 3 )				
		,( 1, 4, 10, 38, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 3, Week: 1,Total score: 129	
		,( 1, 4, 10, 38, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 10, 38, 3, 1, 4, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 5, 1, 3 )				
		,( 1, 4, 10, 38, 3, 1, 5, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 6, 1, 3 )				
		,( 1, 4, 10, 38, 3, 1, 6, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 7, 1, 3 )				
		,( 1, 4, 10, 38, 3, 1, 7, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 8, 1, 3 )				
		,( 1, 4, 10, 38, 3, 1, 8, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 9, 1, 3 )				
		,( 1, 4, 10, 38, 3, 1, 9, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 10, 1, 3 )				
		,( 1, 4, 10, 38, 3, 1, 10, 2, 7 )				
		,( 1, 4, 10, 38, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 38, 4, 2, 1, 1, 10 )					
		,( 1, 4, 10, 38, 4, 2, 1, 2, '' )				
		,( 1, 4, 10, 38, 4, 2, 2, 1, '' )				
		,( 1, 4, 10, 38, 4, 2, 2, 2, 5 )				
		,( 1, 4, 10, 38, 4, 2, 3, 1, 10 )				
		,( 1, 4, 10, 38, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 10, Player: 38, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 10, 38, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 10, 38, 4, 2, 4, 2, 3 )				
		,( 1, 4, 10, 38, 4, 2, 5, 1, 2 )				
		,( 1, 4, 10, 38, 4, 2, 5, 2, '' )				
		,( 1, 4, 10, 38, 4, 2, 6, 1, 3 )				
		,( 1, 4, 10, 38, 4, 2, 6, 2, 2 )				
		,( 1, 4, 10, 38, 4, 2, 7, 1, 10 )				
		,( 1, 4, 10, 38, 4, 2, 7, 2, '' )				
		,( 1, 4, 10, 38, 4, 2, 8, 1, '' )				
		,( 1, 4, 10, 38, 4, 2, 8, 2, '' )				
		,( 1, 4, 10, 38, 4, 2, 9, 1, '' )				
		,( 1, 4, 10, 38, 4, 2, 9, 2, '' )				
		,( 1, 4, 10, 38, 4, 2, 10, 1, 4 )				
		,( 1, 4, 10, 38, 4, 2, 10, 2, 6 )				
		,( 1, 4, 10, 38, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 38, 5, 2, 1, 1, 10 )					
		,( 1, 4, 10, 38, 5, 2, 1, 2, '' )				
		,( 1, 4, 10, 38, 5, 2, 2, 1, 10 )				
		,( 1, 4, 10, 38, 5, 2, 2, 2, '' )				
		,( 1, 4, 10, 38, 5, 2, 3, 1, 10 )				
		,( 1, 4, 10, 38, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 10, 38, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 10, 38, 5, 2, 4, 2, '' )				
		,( 1, 4, 10, 38, 5, 2, 5, 1, 10 )				
		,( 1, 4, 10, 38, 5, 2, 5, 2, '' )				
		,( 1, 4, 10, 38, 5, 2, 6, 1, 10 )				
		,( 1, 4, 10, 38, 5, 2, 6, 2, '' )				
		,( 1, 4, 10, 38, 5, 2, 7, 1, 10 )				
		,( 1, 4, 10, 38, 5, 2, 7, 2, '' )				
		,( 1, 4, 10, 38, 5, 2, 8, 1, 10 )				
		,( 1, 4, 10, 38, 5, 2, 8, 2, '' )				
		,( 1, 4, 10, 38, 5, 2, 9, 1, 10 )				
		,( 1, 4, 10, 38, 5, 2, 9, 2, '' )				
		,( 1, 4, 10, 38, 5, 2, 10, 1, 10 )				
		,( 1, 4, 10, 38, 5, 2, 10, 2, 10 )				
		,( 1, 4, 10, 38, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 38, 6, 2, 1, 1, 3 )					
		,( 1, 4, 10, 38, 6, 2, 1, 2, 7 )				
		,( 1, 4, 10, 38, 6, 2, 2, 1, 3 )				
		,( 1, 4, 10, 38, 6, 2, 2, 2, 7 )				
		,( 1, 4, 10, 38, 6, 2, 3, 1, 3 )				
		,( 1, 4, 10, 38, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 38, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 10, 38, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 10, 38, 6, 2, 4, 2, 2 )				
		,( 1, 4, 10, 38, 6, 2, 5, 1, 10 )				
		,( 1, 4, 10, 38, 6, 2, 5, 2, '' )				
		,( 1, 4, 10, 38, 6, 2, 6, 1, 10 )				
		,( 1, 4, 10, 38, 6, 2, 6, 2, '' )				
		,( 1, 4, 10, 38, 6, 2, 7, 1, 3 )				
		,( 1, 4, 10, 38, 6, 2, 7, 2, 7 )				
		,( 1, 4, 10, 38, 6, 2, 8, 1, 3 )				
		,( 1, 4, 10, 38, 6, 2, 8, 2, 7 )				
		,( 1, 4, 10, 38, 6, 2, 9, 1, 3 )				
		,( 1, 4, 10, 38, 6, 2, 9, 2, 6 )				
		,( 1, 4, 10, 38, 6, 2, 10, 1, 10 )				
		,( 1, 4, 10, 38, 6, 2, 10, 2, 10 )				
		,( 1, 4, 10, 38, 6, 2, 10, 3, 10 )							
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 39, 1, 1, 1, 1, 3 )					
		,( 1, 4, 10, 39, 1, 1, 1, 2, 4 )				
		,( 1, 4, 10, 39, 1, 1, 2, 1, 3 )				
		,( 1, 4, 10, 39, 1, 1, 2, 2, 4 )				
		,( 1, 4, 10, 39, 1, 1, 3, 1, 3 )				
		,( 1, 4, 10, 39, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 10, 39, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 10, 39, 1, 1, 4, 2, 4 )				
		,( 1, 4, 10, 39, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 10, 39, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 10, 39, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 10, 39, 1, 1, 6, 2, 4 )				
		,( 1, 4, 10, 39, 1, 1, 7, 1, 3 )				
		,( 1, 4, 10, 39, 1, 1, 7, 2, 4 )				
		,( 1, 4, 10, 39, 1, 1, 8, 1, 3 )				
		,( 1, 4, 10, 39, 1, 1, 8, 2, 4 )				
		,( 1, 4, 10, 39, 1, 1, 9, 1, 3 )				
		,( 1, 4, 10, 39, 1, 1, 9, 2, 4 )				
		,( 1, 4, 10, 39, 1, 1, 10, 1, 3 )				
		,( 1, 4, 10, 39, 1, 1, 10, 2, 4 )				
		,( 1, 4, 10, 39, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 39, 2, 1, 1, 1, 3 )					
		,( 1, 4, 10, 39, 2, 1, 1, 2, 4 )				
		,( 1, 4, 10, 39, 2, 1, 2, 1, 3 )				
		,( 1, 4, 10, 39, 2, 1, 2, 2, 2 )				
		,( 1, 4, 10, 39, 2, 1, 3, 1, 3 )				
		,( 1, 4, 10, 39, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 10, 39, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 10, 39, 2, 1, 4, 2, 2 )				
		,( 1, 4, 10, 39, 2, 1, 5, 1, 3 )				
		,( 1, 4, 10, 39, 2, 1, 5, 2, '' )				
		,( 1, 4, 10, 39, 2, 1, 6, 1, 6 )				
		,( 1, 4, 10, 39, 2, 1, 6, 2, 4 )				
		,( 1, 4, 10, 39, 2, 1, 7, 1, 3 )				
		,( 1, 4, 10, 39, 2, 1, 7, 2, 4 )				
		,( 1, 4, 10, 39, 2, 1, 8, 1, '' )				
		,( 1, 4, 10, 39, 2, 1, 8, 2, 4 )				
		,( 1, 4, 10, 39, 2, 1, 9, 1, 3 )				
		,( 1, 4, 10, 39, 2, 1, 9, 2, 7 )				
		,( 1, 4, 10, 39, 2, 1, 10, 1, 1 )				
		,( 1, 4, 10, 39, 2, 1, 10, 2, 1 )				
		,( 1, 4, 10, 39, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 39, 3, 1, 1, 1, 3 )					
		,( 1, 4, 10, 39, 3, 1, 1, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 2, 1, 3 )				
		,( 1, 4, 10, 39, 3, 1, 2, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 3, 1, 3 )				
		,( 1, 4, 10, 39, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 3, Week: 1,Total score: 130	
		,( 1, 4, 10, 39, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 10, 39, 3, 1, 4, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 5, 1, 3 )				
		,( 1, 4, 10, 39, 3, 1, 5, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 6, 1, 3 )				
		,( 1, 4, 10, 39, 3, 1, 6, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 7, 1, 3 )				
		,( 1, 4, 10, 39, 3, 1, 7, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 8, 1, 3 )				
		,( 1, 4, 10, 39, 3, 1, 8, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 9, 1, 3 )				
		,( 1, 4, 10, 39, 3, 1, 9, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 10, 1, 3 )				
		,( 1, 4, 10, 39, 3, 1, 10, 2, 7 )				
		,( 1, 4, 10, 39, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 39, 4, 2, 1, 1, 10 )					
		,( 1, 4, 10, 39, 4, 2, 1, 2, '' )				
		,( 1, 4, 10, 39, 4, 2, 2, 1, '' )				
		,( 1, 4, 10, 39, 4, 2, 2, 2, 5 )				
		,( 1, 4, 10, 39, 4, 2, 3, 1, 10 )				
		,( 1, 4, 10, 39, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 10, Player: 39, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 10, 39, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 10, 39, 4, 2, 4, 2, 3 )				
		,( 1, 4, 10, 39, 4, 2, 5, 1, 2 )				
		,( 1, 4, 10, 39, 4, 2, 5, 2, '' )				
		,( 1, 4, 10, 39, 4, 2, 6, 1, 3 )				
		,( 1, 4, 10, 39, 4, 2, 6, 2, 2 )				
		,( 1, 4, 10, 39, 4, 2, 7, 1, 10 )				
		,( 1, 4, 10, 39, 4, 2, 7, 2, '' )				
		,( 1, 4, 10, 39, 4, 2, 8, 1, '' )				
		,( 1, 4, 10, 39, 4, 2, 8, 2, '' )				
		,( 1, 4, 10, 39, 4, 2, 9, 1, '' )				
		,( 1, 4, 10, 39, 4, 2, 9, 2, '' )				
		,( 1, 4, 10, 39, 4, 2, 10, 1, 4 )				
		,( 1, 4, 10, 39, 4, 2, 10, 2, 6 )				
		,( 1, 4, 10, 39, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 39, 5, 2, 1, 1, 10 )					
		,( 1, 4, 10, 39, 5, 2, 1, 2, '' )				
		,( 1, 4, 10, 39, 5, 2, 2, 1, 10 )				
		,( 1, 4, 10, 39, 5, 2, 2, 2, '' )				
		,( 1, 4, 10, 39, 5, 2, 3, 1, 10 )				
		,( 1, 4, 10, 39, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 10, 39, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 10, 39, 5, 2, 4, 2, '' )				
		,( 1, 4, 10, 39, 5, 2, 5, 1, 10 )				
		,( 1, 4, 10, 39, 5, 2, 5, 2, '' )				
		,( 1, 4, 10, 39, 5, 2, 6, 1, 10 )				
		,( 1, 4, 10, 39, 5, 2, 6, 2, '' )				
		,( 1, 4, 10, 39, 5, 2, 7, 1, 10 )				
		,( 1, 4, 10, 39, 5, 2, 7, 2, '' )				
		,( 1, 4, 10, 39, 5, 2, 8, 1, 10 )				
		,( 1, 4, 10, 39, 5, 2, 8, 2, '' )				
		,( 1, 4, 10, 39, 5, 2, 9, 1, 10 )				
		,( 1, 4, 10, 39, 5, 2, 9, 2, '' )				
		,( 1, 4, 10, 39, 5, 2, 10, 1, 10 )				
		,( 1, 4, 10, 39, 5, 2, 10, 2, 10 )				
		,( 1, 4, 10, 39, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 39, 6, 2, 1, 1, 3 )					
		,( 1, 4, 10, 39, 6, 2, 1, 2, 7 )				
		,( 1, 4, 10, 39, 6, 2, 2, 1, 3 )				
		,( 1, 4, 10, 39, 6, 2, 2, 2, 7 )				
		,( 1, 4, 10, 39, 6, 2, 3, 1, 3 )				
		,( 1, 4, 10, 39, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 39, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 10, 39, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 10, 39, 6, 2, 4, 2, 2 )				
		,( 1, 4, 10, 39, 6, 2, 5, 1, 10 )				
		,( 1, 4, 10, 39, 6, 2, 5, 2, '' )				
		,( 1, 4, 10, 39, 6, 2, 6, 1, 10 )				
		,( 1, 4, 10, 39, 6, 2, 6, 2, '' )				
		,( 1, 4, 10, 39, 6, 2, 7, 1, 3 )				
		,( 1, 4, 10, 39, 6, 2, 7, 2, 7 )				
		,( 1, 4, 10, 39, 6, 2, 8, 1, 3 )				
		,( 1, 4, 10, 39, 6, 2, 8, 2, 7 )				
		,( 1, 4, 10, 39, 6, 2, 9, 1, 3 )				
		,( 1, 4, 10, 39, 6, 2, 9, 2, 6 )				
		,( 1, 4, 10, 39, 6, 2, 10, 1, 10 )				
		,( 1, 4, 10, 39, 6, 2, 10, 2, 10 )				
		,( 1, 4, 10, 39, 6, 2, 10, 3, 10 )				

INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 40, 1, 1, 1, 1, 3 )					
		,( 1, 4, 10, 40, 1, 1, 1, 2, 4 )				
		,( 1, 4, 10, 40, 1, 1, 2, 1, 3 )				
		,( 1, 4, 10, 40, 1, 1, 2, 2, 4 )				
		,( 1, 4, 10, 40, 1, 1, 3, 1, 3 )				
		,( 1, 4, 10, 40, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 10, 40, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 10, 40, 1, 1, 4, 2, 4 )				
		,( 1, 4, 10, 40, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 10, 40, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 10, 40, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 10, 40, 1, 1, 6, 2, 4 )				
		,( 1, 4, 10, 40, 1, 1, 7, 1, 3 )				
		,( 1, 4, 10, 40, 1, 1, 7, 2, 4 )				
		,( 1, 4, 10, 40, 1, 1, 8, 1, 3 )				
		,( 1, 4, 10, 40, 1, 1, 8, 2, 4 )				
		,( 1, 4, 10, 40, 1, 1, 9, 1, 3 )				
		,( 1, 4, 10, 40, 1, 1, 9, 2, 4 )				
		,( 1, 4, 10, 40, 1, 1, 10, 1, 3 )				
		,( 1, 4, 10, 40, 1, 1, 10, 2, 4 )				
		,( 1, 4, 10, 40, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 40, 2, 1, 1, 1, 3 )					
		,( 1, 4, 10, 40, 2, 1, 1, 2, 4 )				
		,( 1, 4, 10, 40, 2, 1, 2, 1, 3 )				
		,( 1, 4, 10, 40, 2, 1, 2, 2, 2 )				
		,( 1, 4, 10, 40, 2, 1, 3, 1, 3 )				
		,( 1, 4, 10, 40, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 10, 40, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 10, 40, 2, 1, 4, 2, 2 )				
		,( 1, 4, 10, 40, 2, 1, 5, 1, 3 )				
		,( 1, 4, 10, 40, 2, 1, 5, 2, '' )				
		,( 1, 4, 10, 40, 2, 1, 6, 1, 6 )				
		,( 1, 4, 10, 40, 2, 1, 6, 2, 4 )				
		,( 1, 4, 10, 40, 2, 1, 7, 1, 3 )				
		,( 1, 4, 10, 40, 2, 1, 7, 2, 4 )				
		,( 1, 4, 10, 40, 2, 1, 8, 1, '' )				
		,( 1, 4, 10, 40, 2, 1, 8, 2, 4 )				
		,( 1, 4, 10, 40, 2, 1, 9, 1, 3 )				
		,( 1, 4, 10, 40, 2, 1, 9, 2, 7 )				
		,( 1, 4, 10, 40, 2, 1, 10, 1, 1 )				
		,( 1, 4, 10, 40, 2, 1, 10, 2, 1 )				
		,( 1, 4, 10, 40, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 40, 3, 1, 1, 1, 3 )					
		,( 1, 4, 10, 40, 3, 1, 1, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 2, 1, 3 )				
		,( 1, 4, 10, 40, 3, 1, 2, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 3, 1, 3 )				
		,( 1, 4, 10, 40, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 3, Week: 1,Total score: 129	
		,( 1, 4, 10, 40, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 10, 40, 3, 1, 4, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 5, 1, 3 )				
		,( 1, 4, 10, 40, 3, 1, 5, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 6, 1, 3 )				
		,( 1, 4, 10, 40, 3, 1, 6, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 7, 1, 3 )				
		,( 1, 4, 10, 40, 3, 1, 7, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 8, 1, 3 )				
		,( 1, 4, 10, 40, 3, 1, 8, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 9, 1, 3 )				
		,( 1, 4, 10, 40, 3, 1, 9, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 10, 1, 3 )				
		,( 1, 4, 10, 40, 3, 1, 10, 2, 7 )				
		,( 1, 4, 10, 40, 3, 1, 10, 3, 2 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 40, 4, 2, 1, 1, 10 )					
		,( 1, 4, 10, 40, 4, 2, 1, 2, '' )				
		,( 1, 4, 10, 40, 4, 2, 2, 1, '' )				
		,( 1, 4, 10, 40, 4, 2, 2, 2, 5 )				
		,( 1, 4, 10, 40, 4, 2, 3, 1, 10 )				
		,( 1, 4, 10, 40, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 10, Player: 40, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 10, 40, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 10, 40, 4, 2, 4, 2, 3 )				
		,( 1, 4, 10, 40, 4, 2, 5, 1, 2 )				
		,( 1, 4, 10, 40, 4, 2, 5, 2, '' )				
		,( 1, 4, 10, 40, 4, 2, 6, 1, 3 )				
		,( 1, 4, 10, 40, 4, 2, 6, 2, 2 )				
		,( 1, 4, 10, 40, 4, 2, 7, 1, 10 )				
		,( 1, 4, 10, 40, 4, 2, 7, 2, '' )				
		,( 1, 4, 10, 40, 4, 2, 8, 1, '' )				
		,( 1, 4, 10, 40, 4, 2, 8, 2, '' )				
		,( 1, 4, 10, 40, 4, 2, 9, 1, '' )				
		,( 1, 4, 10, 40, 4, 2, 9, 2, '' )				
		,( 1, 4, 10, 40, 4, 2, 10, 1, 4 )				
		,( 1, 4, 10, 40, 4, 2, 10, 2, 6 )				
		,( 1, 4, 10, 40, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 40, 5, 2, 1, 1, 10 )					
		,( 1, 4, 10, 40, 5, 2, 1, 2, '' )				
		,( 1, 4, 10, 40, 5, 2, 2, 1, 10 )				
		,( 1, 4, 10, 40, 5, 2, 2, 2, '' )				
		,( 1, 4, 10, 40, 5, 2, 3, 1, 10 )				
		,( 1, 4, 10, 40, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 10, 40, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 10, 40, 5, 2, 4, 2, '' )				
		,( 1, 4, 10, 40, 5, 2, 5, 1, 10 )				
		,( 1, 4, 10, 40, 5, 2, 5, 2, '' )				
		,( 1, 4, 10, 40, 5, 2, 6, 1, 10 )				
		,( 1, 4, 10, 40, 5, 2, 6, 2, '' )				
		,( 1, 4, 10, 40, 5, 2, 7, 1, 10 )				
		,( 1, 4, 10, 40, 5, 2, 7, 2, '' )				
		,( 1, 4, 10, 40, 5, 2, 8, 1, 10 )				
		,( 1, 4, 10, 40, 5, 2, 8, 2, '' )				
		,( 1, 4, 10, 40, 5, 2, 9, 1, 10 )				
		,( 1, 4, 10, 40, 5, 2, 9, 2, '' )				
		,( 1, 4, 10, 40, 5, 2, 10, 1, 10 )				
		,( 1, 4, 10, 40, 5, 2, 10, 2, 10 )				
		,( 1, 4, 10, 40, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 10, 40, 6, 2, 1, 1, 3 )					
		,( 1, 4, 10, 40, 6, 2, 1, 2, 7 )				
		,( 1, 4, 10, 40, 6, 2, 2, 1, 3 )				
		,( 1, 4, 10, 40, 6, 2, 2, 2, 7 )				
		,( 1, 4, 10, 40, 6, 2, 3, 1, 3 )				
		,( 1, 4, 10, 40, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 10, Player: 40, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 10, 40, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 10, 40, 6, 2, 4, 2, 2 )				
		,( 1, 4, 10, 40, 6, 2, 5, 1, 10 )				
		,( 1, 4, 10, 40, 6, 2, 5, 2, '' )				
		,( 1, 4, 10, 40, 6, 2, 6, 1, 10 )				
		,( 1, 4, 10, 40, 6, 2, 6, 2, '' )				
		,( 1, 4, 10, 40, 6, 2, 7, 1, 3 )				
		,( 1, 4, 10, 40, 6, 2, 7, 2, 7 )				
		,( 1, 4, 10, 40, 6, 2, 8, 1, 3 )				
		,( 1, 4, 10, 40, 6, 2, 8, 2, 7 )				
		,( 1, 4, 10, 40, 6, 2, 9, 1, 3 )				
		,( 1, 4, 10, 40, 6, 2, 9, 2, 6 )				
		,( 1, 4, 10, 40, 6, 2, 10, 1, 10 )				
		,( 1, 4, 10, 40, 6, 2, 10, 2, 10 )				
		,( 1, 4, 10, 40, 6, 2, 10, 3, 10 )				

INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 41, 1, 1, 1, 1, 3 )					
		,( 1, 4, 11, 41, 1, 1, 1, 2, 4 )				
		,( 1, 4, 11, 41, 1, 1, 2, 1, 3 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 11, 41, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 4, 11, 41, 1, 1, 3, 1, 3 )				
		,( 1, 4, 11, 41, 1, 1, 3, 2, 4 )			-- Same as #1 BUT	
		,( 1, 4, 11, 41, 1, 1, 4, 1, 3 )			-- different league, different player	
		,( 1, 4, 11, 41, 1, 1, 4, 2, 4 )			-- This will test league scoring	
		,( 1, 4, 11, 41, 1, 1, 5, 1, 3 )			-- Same player but now on couples league instead of singles	
		,( 1, 4, 11, 41, 1, 1, 5, 2, 4 )				
		,( 1, 4, 11, 41, 1, 1, 6, 1, 3 )				
		,( 1, 4, 11, 41, 1, 1, 6, 2, 4 )			-- Format:	
		,( 1, 4, 11, 41, 1, 1, 7, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 11, 41, 1, 1, 7, 2, 4 )			-- Some spares an no strikes	
		,( 1, 4, 11, 41, 1, 1, 8, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 11, 41, 1, 1, 8, 2, 4 )			-- No spares and some strikes	
		,( 1, 4, 11, 41, 1, 1, 9, 1, 3 )			-- No spares and all strikes	
		,( 1, 4, 11, 41, 1, 1, 9, 2, 4 )			-- Some spares and some strikes	
		,( 1, 4, 11, 41, 1, 1, 10, 1, 3 )				
		,( 1, 4, 11, 41, 1, 1, 10, 2, 4 )				
		,( 1, 4, 11, 41, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 41, 2, 1, 1, 1, 3 )					
		,( 1, 4, 11, 41, 2, 1, 1, 2, 4 )				
		,( 1, 4, 11, 41, 2, 1, 2, 1, 3 )				
		,( 1, 4, 11, 41, 2, 1, 2, 2, 2 )				
		,( 1, 4, 11, 41, 2, 1, 3, 1, 3 )				
		,( 1, 4, 11, 41, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 11, 41, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 11, 41, 2, 1, 4, 2, 2 )				
		,( 1, 4, 11, 41, 2, 1, 5, 1, 3 )				
		,( 1, 4, 11, 41, 2, 1, 5, 2, '' )				
		,( 1, 4, 11, 41, 2, 1, 6, 1, 6 )				
		,( 1, 4, 11, 41, 2, 1, 6, 2, 4 )				
		,( 1, 4, 11, 41, 2, 1, 7, 1, 3 )				
		,( 1, 4, 11, 41, 2, 1, 7, 2, 4 )				
		,( 1, 4, 11, 41, 2, 1, 8, 1, '' )				
		,( 1, 4, 11, 41, 2, 1, 8, 2, 4 )				
		,( 1, 4, 11, 41, 2, 1, 9, 1, 3 )				
		,( 1, 4, 11, 41, 2, 1, 9, 2, 7 )				
		,( 1, 4, 11, 41, 2, 1, 10, 1, 1 )				
		,( 1, 4, 11, 41, 2, 1, 10, 2, 1 )				
		,( 1, 4, 11, 41, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 41, 3, 1, 1, 1, 3 )					
		,( 1, 4, 11, 41, 3, 1, 1, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 2, 1, 3 )				
		,( 1, 4, 11, 41, 3, 1, 2, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 3, 1, 3 )				
		,( 1, 4, 11, 41, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 3, Week: 1,Total score: 130	
		,( 1, 4, 11, 41, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 11, 41, 3, 1, 4, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 5, 1, 3 )				
		,( 1, 4, 11, 41, 3, 1, 5, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 6, 1, 3 )				
		,( 1, 4, 11, 41, 3, 1, 6, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 7, 1, 3 )				
		,( 1, 4, 11, 41, 3, 1, 7, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 8, 1, 3 )				
		,( 1, 4, 11, 41, 3, 1, 8, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 9, 1, 3 )				
		,( 1, 4, 11, 41, 3, 1, 9, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 10, 1, 3 )				
		,( 1, 4, 11, 41, 3, 1, 10, 2, 7 )				
		,( 1, 4, 11, 41, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 41, 4, 2, 1, 1, 10 )					
		,( 1, 4, 11, 41, 4, 2, 1, 2, '' )				
		,( 1, 4, 11, 41, 4, 2, 2, 1, '' )				
		,( 1, 4, 11, 41, 4, 2, 2, 2, 5 )				
		,( 1, 4, 11, 41, 4, 2, 3, 1, 10 )				
		,( 1, 4, 11, 41, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 11, Player: 41, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 11, 41, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 11, 41, 4, 2, 4, 2, 3 )				
		,( 1, 4, 11, 41, 4, 2, 5, 1, 2 )				
		,( 1, 4, 11, 41, 4, 2, 5, 2, '' )				
		,( 1, 4, 11, 41, 4, 2, 6, 1, 3 )				
		,( 1, 4, 11, 41, 4, 2, 6, 2, 2 )				
		,( 1, 4, 11, 41, 4, 2, 7, 1, 10 )				
		,( 1, 4, 11, 41, 4, 2, 7, 2, '' )				
		,( 1, 4, 11, 41, 4, 2, 8, 1, '' )				
		,( 1, 4, 11, 41, 4, 2, 8, 2, '' )				
		,( 1, 4, 11, 41, 4, 2, 9, 1, '' )				
		,( 1, 4, 11, 41, 4, 2, 9, 2, '' )				
		,( 1, 4, 11, 41, 4, 2, 10, 1, 4 )				
		,( 1, 4, 11, 41, 4, 2, 10, 2, 6 )				
		,( 1, 4, 11, 41, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 41, 5, 2, 1, 1, 10 )					
		,( 1, 4, 11, 41, 5, 2, 1, 2, '' )				
		,( 1, 4, 11, 41, 5, 2, 2, 1, 10 )				
		,( 1, 4, 11, 41, 5, 2, 2, 2, '' )				
		,( 1, 4, 11, 41, 5, 2, 3, 1, 10 )				
		,( 1, 4, 11, 41, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 11, Player: 41, Game:5, Week: 2,Total score: 300	
 		,( 1, 4, 11, 41, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 11, 41, 5, 2, 4, 2, '' )				
		,( 1, 4, 11, 41, 5, 2, 5, 1, 10 )				
		,( 1, 4, 11, 41, 5, 2, 5, 2, '' )				
		,( 1, 4, 11, 41, 5, 2, 6, 1, 10 )				
		,( 1, 4, 11, 41, 5, 2, 6, 2, '' )				
		,( 1, 4, 11, 41, 5, 2, 7, 1, 10 )				
		,( 1, 4, 11, 41, 5, 2, 7, 2, '' )				
		,( 1, 4, 11, 41, 5, 2, 8, 1, 10 )				
		,( 1, 4, 11, 41, 5, 2, 8, 2, '' )				
		,( 1, 4, 11, 41, 5, 2, 9, 1, 10 )				
		,( 1, 4, 11, 41, 5, 2, 9, 2, '' )				
		,( 1, 4, 11, 41, 5, 2, 10, 1, 10 )				
		,( 1, 4, 11, 41, 5, 2, 10, 2, 10 )				
		,( 1, 4, 11, 41, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 41, 6, 2, 1, 1, 3 )					
		,( 1, 4, 11, 41, 6, 2, 1, 2, 7 )				
		,( 1, 4, 11, 41, 6, 2, 2, 1, 3 )				
		,( 1, 4, 11, 41, 6, 2, 2, 2, 7 )				
		,( 1, 4, 11, 41, 6, 2, 3, 1, 3 )				
		,( 1, 4, 11, 41, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 41, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 11, 41, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 11, 41, 6, 2, 4, 2, 2 )				
		,( 1, 4, 11, 41, 6, 2, 5, 1, 10 )				
		,( 1, 4, 11, 41, 6, 2, 5, 2, '' )				
		,( 1, 4, 11, 41, 6, 2, 6, 1, 10 )				
		,( 1, 4, 11, 41, 6, 2, 6, 2, '' )				
		,( 1, 4, 11, 41, 6, 2, 7, 1, 3 )				
		,( 1, 4, 11, 41, 6, 2, 7, 2, 7 )				
		,( 1, 4, 11, 41, 6, 2, 8, 1, 3 )				
		,( 1, 4, 11, 41, 6, 2, 8, 2, 7 )				
		,( 1, 4, 11, 41, 6, 2, 9, 1, 3 )				
		,( 1, 4, 11, 41, 6, 2, 9, 2, 6 )				
		,( 1, 4, 11, 41, 6, 2, 10, 1, 10 )				
		,( 1, 4, 11, 41, 6, 2, 10, 2, 10 )				
		,( 1, 4, 11, 41, 6, 2, 10, 3, 10 )							
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 42, 1, 1, 1, 1, 3 )					
		,( 1, 4, 11, 42, 1, 1, 1, 2, 4 )				
		,( 1, 4, 11, 42, 1, 1, 2, 1, 3 )				
		,( 1, 4, 11, 42, 1, 1, 2, 2, 4 )				
		,( 1, 4, 11, 42, 1, 1, 3, 1, 3 )				
		,( 1, 4, 11, 42, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 11, 42, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 11, 42, 1, 1, 4, 2, 4 )				
		,( 1, 4, 11, 42, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 11, 42, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 11, 42, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 11, 42, 1, 1, 6, 2, 4 )				
		,( 1, 4, 11, 42, 1, 1, 7, 1, 3 )				
		,( 1, 4, 11, 42, 1, 1, 7, 2, 4 )				
		,( 1, 4, 11, 42, 1, 1, 8, 1, 3 )				
		,( 1, 4, 11, 42, 1, 1, 8, 2, 4 )				
		,( 1, 4, 11, 42, 1, 1, 9, 1, 3 )				
		,( 1, 4, 11, 42, 1, 1, 9, 2, 4 )				
		,( 1, 4, 11, 42, 1, 1, 10, 1, 3 )				
		,( 1, 4, 11, 42, 1, 1, 10, 2, 4 )				
		,( 1, 4, 11, 42, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 42, 2, 1, 1, 1, 3 )					
		,( 1, 4, 11, 42, 2, 1, 1, 2, 4 )				
		,( 1, 4, 11, 42, 2, 1, 2, 1, 3 )				
		,( 1, 4, 11, 42, 2, 1, 2, 2, 2 )				
		,( 1, 4, 11, 42, 2, 1, 3, 1, 3 )				
		,( 1, 4, 11, 42, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 11, 42, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 11, 42, 2, 1, 4, 2, 2 )				
		,( 1, 4, 11, 42, 2, 1, 5, 1, 3 )				
		,( 1, 4, 11, 42, 2, 1, 5, 2, '' )				
		,( 1, 4, 11, 42, 2, 1, 6, 1, 6 )				
		,( 1, 4, 11, 42, 2, 1, 6, 2, 4 )				
		,( 1, 4, 11, 42, 2, 1, 7, 1, 3 )				
		,( 1, 4, 11, 42, 2, 1, 7, 2, 4 )				
		,( 1, 4, 11, 42, 2, 1, 8, 1, '' )				
		,( 1, 4, 11, 42, 2, 1, 8, 2, 4 )				
		,( 1, 4, 11, 42, 2, 1, 9, 1, 3 )				
		,( 1, 4, 11, 42, 2, 1, 9, 2, 7 )				
		,( 1, 4, 11, 42, 2, 1, 10, 1, 1 )				
		,( 1, 4, 11, 42, 2, 1, 10, 2, 1 )				
		,( 1, 4, 11, 42, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 42, 3, 1, 1, 1, 3 )					
		,( 1, 4, 11, 42, 3, 1, 1, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 2, 1, 3 )				
		,( 1, 4, 11, 42, 3, 1, 2, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 3, 1, 3 )				
		,( 1, 4, 11, 42, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 3, Week: 1,Total score: 130	
		,( 1, 4, 11, 42, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 11, 42, 3, 1, 4, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 5, 1, 3 )				
		,( 1, 4, 11, 42, 3, 1, 5, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 6, 1, 3 )				
		,( 1, 4, 11, 42, 3, 1, 6, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 7, 1, 3 )				
		,( 1, 4, 11, 42, 3, 1, 7, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 8, 1, 3 )				
		,( 1, 4, 11, 42, 3, 1, 8, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 9, 1, 3 )				
		,( 1, 4, 11, 42, 3, 1, 9, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 10, 1, 3 )				
		,( 1, 4, 11, 42, 3, 1, 10, 2, 7 )				
		,( 1, 4, 11, 42, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 42, 4, 2, 1, 1, 10 )					
		,( 1, 4, 11, 42, 4, 2, 1, 2, '' )				
		,( 1, 4, 11, 42, 4, 2, 2, 1, '' )				
		,( 1, 4, 11, 42, 4, 2, 2, 2, 5 )				
		,( 1, 4, 11, 42, 4, 2, 3, 1, 10 )				
		,( 1, 4, 11, 42, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 11, Player: 42, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 11, 42, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 11, 42, 4, 2, 4, 2, 3 )				
		,( 1, 4, 11, 42, 4, 2, 5, 1, 2 )				
		,( 1, 4, 11, 42, 4, 2, 5, 2, '' )				
		,( 1, 4, 11, 42, 4, 2, 6, 1, 3 )				
		,( 1, 4, 11, 42, 4, 2, 6, 2, 2 )				
		,( 1, 4, 11, 42, 4, 2, 7, 1, 10 )				
		,( 1, 4, 11, 42, 4, 2, 7, 2, '' )				
		,( 1, 4, 11, 42, 4, 2, 8, 1, '' )				
		,( 1, 4, 11, 42, 4, 2, 8, 2, '' )				
		,( 1, 4, 11, 42, 4, 2, 9, 1, '' )				
		,( 1, 4, 11, 42, 4, 2, 9, 2, '' )				
		,( 1, 4, 11, 42, 4, 2, 10, 1, 4 )				
		,( 1, 4, 11, 42, 4, 2, 10, 2, 6 )				
		,( 1, 4, 11, 42, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 42, 5, 2, 1, 1, 10 )					
		,( 1, 4, 11, 42, 5, 2, 1, 2, '' )				
		,( 1, 4, 11, 42, 5, 2, 2, 1, 10 )				
		,( 1, 4, 11, 42, 5, 2, 2, 2, '' )				
		,( 1, 4, 11, 42, 5, 2, 3, 1, 10 )				
		,( 1, 4, 11, 42, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 11, 42, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 11, 42, 5, 2, 4, 2, '' )				
		,( 1, 4, 11, 42, 5, 2, 5, 1, 10 )				
		,( 1, 4, 11, 42, 5, 2, 5, 2, '' )				
		,( 1, 4, 11, 42, 5, 2, 6, 1, 10 )				
		,( 1, 4, 11, 42, 5, 2, 6, 2, '' )				
		,( 1, 4, 11, 42, 5, 2, 7, 1, 10 )				
		,( 1, 4, 11, 42, 5, 2, 7, 2, '' )				
		,( 1, 4, 11, 42, 5, 2, 8, 1, 10 )				
		,( 1, 4, 11, 42, 5, 2, 8, 2, '' )				
		,( 1, 4, 11, 42, 5, 2, 9, 1, 10 )				
		,( 1, 4, 11, 42, 5, 2, 9, 2, '' )				
		,( 1, 4, 11, 42, 5, 2, 10, 1, 10 )				
		,( 1, 4, 11, 42, 5, 2, 10, 2, 10 )				
		,( 1, 4, 11, 42, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 42, 6, 2, 1, 1, 3 )					
		,( 1, 4, 11, 42, 6, 2, 1, 2, 7 )				
		,( 1, 4, 11, 42, 6, 2, 2, 1, 3 )				
		,( 1, 4, 11, 42, 6, 2, 2, 2, 7 )				
		,( 1, 4, 11, 42, 6, 2, 3, 1, 3 )				
		,( 1, 4, 11, 42, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 42, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 11, 42, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 11, 42, 6, 2, 4, 2, 2 )				
		,( 1, 4, 11, 42, 6, 2, 5, 1, 10 )				
		,( 1, 4, 11, 42, 6, 2, 5, 2, '' )				
		,( 1, 4, 11, 42, 6, 2, 6, 1, 10 )				
		,( 1, 4, 11, 42, 6, 2, 6, 2, '' )				
		,( 1, 4, 11, 42, 6, 2, 7, 1, 3 )				
		,( 1, 4, 11, 42, 6, 2, 7, 2, 7 )				
		,( 1, 4, 11, 42, 6, 2, 8, 1, 3 )				
		,( 1, 4, 11, 42, 6, 2, 8, 2, 7 )				
		,( 1, 4, 11, 42, 6, 2, 9, 1, 3 )				
		,( 1, 4, 11, 42, 6, 2, 9, 2, 6 )				
		,( 1, 4, 11, 42, 6, 2, 10, 1, 10 )				
		,( 1, 4, 11, 42, 6, 2, 10, 2, 10 )				
		,( 1, 4, 11, 42, 6, 2, 10, 3, 10 )							
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 43, 1, 1, 1, 1, 3 )					
		,( 1, 4, 11, 43, 1, 1, 1, 2, 4 )				
		,( 1, 4, 11, 43, 1, 1, 2, 1, 3 )				
		,( 1, 4, 11, 43, 1, 1, 2, 2, 4 )				
		,( 1, 4, 11, 43, 1, 1, 3, 1, 3 )				
		,( 1, 4, 11, 43, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 11, 43, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 11, 43, 1, 1, 4, 2, 4 )				
		,( 1, 4, 11, 43, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 11, 43, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 11, 43, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 11, 43, 1, 1, 6, 2, 4 )				
		,( 1, 4, 11, 43, 1, 1, 7, 1, 3 )				
		,( 1, 4, 11, 43, 1, 1, 7, 2, 4 )				
		,( 1, 4, 11, 43, 1, 1, 8, 1, 3 )				
		,( 1, 4, 11, 43, 1, 1, 8, 2, 4 )				
		,( 1, 4, 11, 43, 1, 1, 9, 1, 3 )				
		,( 1, 4, 11, 43, 1, 1, 9, 2, 4 )				
		,( 1, 4, 11, 43, 1, 1, 10, 1, 3 )				
		,( 1, 4, 11, 43, 1, 1, 10, 2, 4 )				
		,( 1, 4, 11, 43, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 43, 2, 1, 1, 1, 3 )					
		,( 1, 4, 11, 43, 2, 1, 1, 2, 4 )				
		,( 1, 4, 11, 43, 2, 1, 2, 1, 3 )				
		,( 1, 4, 11, 43, 2, 1, 2, 2, 2 )				
		,( 1, 4, 11, 43, 2, 1, 3, 1, 3 )				
		,( 1, 4, 11, 43, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 11, 43, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 11, 43, 2, 1, 4, 2, 2 )				
		,( 1, 4, 11, 43, 2, 1, 5, 1, 3 )				
		,( 1, 4, 11, 43, 2, 1, 5, 2, '' )				
		,( 1, 4, 11, 43, 2, 1, 6, 1, 6 )				
		,( 1, 4, 11, 43, 2, 1, 6, 2, 4 )				
		,( 1, 4, 11, 43, 2, 1, 7, 1, 3 )				
		,( 1, 4, 11, 43, 2, 1, 7, 2, 4 )				
		,( 1, 4, 11, 43, 2, 1, 8, 1, '' )				
		,( 1, 4, 11, 43, 2, 1, 8, 2, 4 )				
		,( 1, 4, 11, 43, 2, 1, 9, 1, 3 )				
		,( 1, 4, 11, 43, 2, 1, 9, 2, 7 )				
		,( 1, 4, 11, 43, 2, 1, 10, 1, 1 )				
		,( 1, 4, 11, 43, 2, 1, 10, 2, 1 )				
		,( 1, 4, 11, 43, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 43, 3, 1, 1, 1, 3 )					
		,( 1, 4, 11, 43, 3, 1, 1, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 2, 1, 3 )				
		,( 1, 4, 11, 43, 3, 1, 2, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 3, 1, 3 )				
		,( 1, 4, 11, 43, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 3, Week: 1,Total score: 130	
		,( 1, 4, 11, 43, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 11, 43, 3, 1, 4, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 5, 1, 3 )				
		,( 1, 4, 11, 43, 3, 1, 5, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 6, 1, 3 )				
		,( 1, 4, 11, 43, 3, 1, 6, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 7, 1, 3 )				
		,( 1, 4, 11, 43, 3, 1, 7, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 8, 1, 3 )				
		,( 1, 4, 11, 43, 3, 1, 8, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 9, 1, 3 )				
		,( 1, 4, 11, 43, 3, 1, 9, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 10, 1, 3 )				
		,( 1, 4, 11, 43, 3, 1, 10, 2, 7 )				
		,( 1, 4, 11, 43, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 43, 4, 2, 1, 1, 10 )					
		,( 1, 4, 11, 43, 4, 2, 1, 2, '' )				
		,( 1, 4, 11, 43, 4, 2, 2, 1, '' )				
		,( 1, 4, 11, 43, 4, 2, 2, 2, 5 )				
		,( 1, 4, 11, 43, 4, 2, 3, 1, 10 )				
		,( 1, 4, 11, 43, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 11, Player: 43, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 11, 43, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 11, 43, 4, 2, 4, 2, 3 )				
		,( 1, 4, 11, 43, 4, 2, 5, 1, 2 )				
		,( 1, 4, 11, 43, 4, 2, 5, 2, '' )				
		,( 1, 4, 11, 43, 4, 2, 6, 1, 3 )				
		,( 1, 4, 11, 43, 4, 2, 6, 2, 2 )				
		,( 1, 4, 11, 43, 4, 2, 7, 1, 10 )				
		,( 1, 4, 11, 43, 4, 2, 7, 2, '' )				
		,( 1, 4, 11, 43, 4, 2, 8, 1, '' )				
		,( 1, 4, 11, 43, 4, 2, 8, 2, '' )				
		,( 1, 4, 11, 43, 4, 2, 9, 1, '' )				
		,( 1, 4, 11, 43, 4, 2, 9, 2, '' )				
		,( 1, 4, 11, 43, 4, 2, 10, 1, 4 )				
		,( 1, 4, 11, 43, 4, 2, 10, 2, 6 )				
		,( 1, 4, 11, 43, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 43, 5, 2, 1, 1, 10 )					
		,( 1, 4, 11, 43, 5, 2, 1, 2, '' )				
		,( 1, 4, 11, 43, 5, 2, 2, 1, 10 )				
		,( 1, 4, 11, 43, 5, 2, 2, 2, '' )				
		,( 1, 4, 11, 43, 5, 2, 3, 1, 10 )				
		,( 1, 4, 11, 43, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 11, 43, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 11, 43, 5, 2, 4, 2, '' )				
		,( 1, 4, 11, 43, 5, 2, 5, 1, 10 )				
		,( 1, 4, 11, 43, 5, 2, 5, 2, '' )				
		,( 1, 4, 11, 43, 5, 2, 6, 1, 10 )				
		,( 1, 4, 11, 43, 5, 2, 6, 2, '' )				
		,( 1, 4, 11, 43, 5, 2, 7, 1, 10 )				
		,( 1, 4, 11, 43, 5, 2, 7, 2, '' )				
		,( 1, 4, 11, 43, 5, 2, 8, 1, 10 )				
		,( 1, 4, 11, 43, 5, 2, 8, 2, '' )				
		,( 1, 4, 11, 43, 5, 2, 9, 1, 10 )				
		,( 1, 4, 11, 43, 5, 2, 9, 2, '' )				
		,( 1, 4, 11, 43, 5, 2, 10, 1, 10 )				
		,( 1, 4, 11, 43, 5, 2, 10, 2, 10 )				
		,( 1, 4, 11, 43, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 43, 6, 2, 1, 1, 3 )					
		,( 1, 4, 11, 43, 6, 2, 1, 2, 7 )				
		,( 1, 4, 11, 43, 6, 2, 2, 1, 3 )				
		,( 1, 4, 11, 43, 6, 2, 2, 2, 7 )				
		,( 1, 4, 11, 43, 6, 2, 3, 1, 3 )				
		,( 1, 4, 11, 43, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 43, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 11, 43, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 11, 43, 6, 2, 4, 2, 2 )				
		,( 1, 4, 11, 43, 6, 2, 5, 1, 10 )				
		,( 1, 4, 11, 43, 6, 2, 5, 2, '' )				
		,( 1, 4, 11, 43, 6, 2, 6, 1, 10 )				
		,( 1, 4, 11, 43, 6, 2, 6, 2, '' )				
		,( 1, 4, 11, 43, 6, 2, 7, 1, 3 )				
		,( 1, 4, 11, 43, 6, 2, 7, 2, 7 )				
		,( 1, 4, 11, 43, 6, 2, 8, 1, 3 )				
		,( 1, 4, 11, 43, 6, 2, 8, 2, 7 )				
		,( 1, 4, 11, 43, 6, 2, 9, 1, 3 )				
		,( 1, 4, 11, 43, 6, 2, 9, 2, 6 )				
		,( 1, 4, 11, 43, 6, 2, 10, 1, 10 )				
		,( 1, 4, 11, 43, 6, 2, 10, 2, 10 )				
		,( 1, 4, 11, 43, 6, 2, 10, 3, 10 )							
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 44, 1, 1, 1, 1, 3 )					
		,( 1, 4, 11, 44, 1, 1, 1, 2, 4 )				
		,( 1, 4, 11, 44, 1, 1, 2, 1, 3 )				
		,( 1, 4, 11, 44, 1, 1, 2, 2, 4 )				
		,( 1, 4, 11, 44, 1, 1, 3, 1, 3 )				
		,( 1, 4, 11, 44, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 11, 44, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 11, 44, 1, 1, 4, 2, 4 )				
		,( 1, 4, 11, 44, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 11, 44, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 11, 44, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 11, 44, 1, 1, 6, 2, 4 )				
		,( 1, 4, 11, 44, 1, 1, 7, 1, 3 )				
		,( 1, 4, 11, 44, 1, 1, 7, 2, 4 )				
		,( 1, 4, 11, 44, 1, 1, 8, 1, 3 )				
		,( 1, 4, 11, 44, 1, 1, 8, 2, 4 )				
		,( 1, 4, 11, 44, 1, 1, 9, 1, 3 )				
		,( 1, 4, 11, 44, 1, 1, 9, 2, 4 )				
		,( 1, 4, 11, 44, 1, 1, 10, 1, 3 )				
		,( 1, 4, 11, 44, 1, 1, 10, 2, 4 )				
		,( 1, 4, 11, 44, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 44, 2, 1, 1, 1, 3 )					
		,( 1, 4, 11, 44, 2, 1, 1, 2, 4 )				
		,( 1, 4, 11, 44, 2, 1, 2, 1, 3 )				
		,( 1, 4, 11, 44, 2, 1, 2, 2, 2 )				
		,( 1, 4, 11, 44, 2, 1, 3, 1, 3 )				
		,( 1, 4, 11, 44, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 11, 44, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 11, 44, 2, 1, 4, 2, 2 )				
		,( 1, 4, 11, 44, 2, 1, 5, 1, 3 )				
		,( 1, 4, 11, 44, 2, 1, 5, 2, '' )				
		,( 1, 4, 11, 44, 2, 1, 6, 1, 6 )				
		,( 1, 4, 11, 44, 2, 1, 6, 2, 4 )				
		,( 1, 4, 11, 44, 2, 1, 7, 1, 3 )				
		,( 1, 4, 11, 44, 2, 1, 7, 2, 4 )				
		,( 1, 4, 11, 44, 2, 1, 8, 1, '' )				
		,( 1, 4, 11, 44, 2, 1, 8, 2, 4 )				
		,( 1, 4, 11, 44, 2, 1, 9, 1, 3 )				
		,( 1, 4, 11, 44, 2, 1, 9, 2, 7 )				
		,( 1, 4, 11, 44, 2, 1, 10, 1, 1 )				
		,( 1, 4, 11, 44, 2, 1, 10, 2, 1 )				
		,( 1, 4, 11, 44, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 44, 3, 1, 1, 1, 3 )					
		,( 1, 4, 11, 44, 3, 1, 1, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 2, 1, 3 )				
		,( 1, 4, 11, 44, 3, 1, 2, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 3, 1, 3 )				
		,( 1, 4, 11, 44, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 3, Week: 1,Total score: 130	
		,( 1, 4, 11, 44, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 11, 44, 3, 1, 4, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 5, 1, 3 )				
		,( 1, 4, 11, 44, 3, 1, 5, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 6, 1, 3 )				
		,( 1, 4, 11, 44, 3, 1, 6, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 7, 1, 3 )				
		,( 1, 4, 11, 44, 3, 1, 7, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 8, 1, 3 )				
		,( 1, 4, 11, 44, 3, 1, 8, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 9, 1, 3 )				
		,( 1, 4, 11, 44, 3, 1, 9, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 10, 1, 3 )				
		,( 1, 4, 11, 44, 3, 1, 10, 2, 7 )				
		,( 1, 4, 11, 44, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 44, 4, 2, 1, 1, 10 )					
		,( 1, 4, 11, 44, 4, 2, 1, 2, '' )				
		,( 1, 4, 11, 44, 4, 2, 2, 1, '' )				
		,( 1, 4, 11, 44, 4, 2, 2, 2, 5 )				
		,( 1, 4, 11, 44, 4, 2, 3, 1, 10 )				
		,( 1, 4, 11, 44, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 11, Player: 44, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 11, 44, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 11, 44, 4, 2, 4, 2, 3 )				
		,( 1, 4, 11, 44, 4, 2, 5, 1, 2 )				
		,( 1, 4, 11, 44, 4, 2, 5, 2, '' )				
		,( 1, 4, 11, 44, 4, 2, 6, 1, 3 )				
		,( 1, 4, 11, 44, 4, 2, 6, 2, 2 )				
		,( 1, 4, 11, 44, 4, 2, 7, 1, 10 )				
		,( 1, 4, 11, 44, 4, 2, 7, 2, '' )				
		,( 1, 4, 11, 44, 4, 2, 8, 1, '' )				
		,( 1, 4, 11, 44, 4, 2, 8, 2, '' )				
		,( 1, 4, 11, 44, 4, 2, 9, 1, '' )				
		,( 1, 4, 11, 44, 4, 2, 9, 2, '' )				
		,( 1, 4, 11, 44, 4, 2, 10, 1, 4 )				
		,( 1, 4, 11, 44, 4, 2, 10, 2, 6 )				
		,( 1, 4, 11, 44, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 44, 5, 2, 1, 1, 10 )					
		,( 1, 4, 11, 44, 5, 2, 1, 2, '' )				
		,( 1, 4, 11, 44, 5, 2, 2, 1, 10 )				
		,( 1, 4, 11, 44, 5, 2, 2, 2, '' )				
		,( 1, 4, 11, 44, 5, 2, 3, 1, 10 )				
		,( 1, 4, 11, 44, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 11, 44, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 11, 44, 5, 2, 4, 2, '' )				
		,( 1, 4, 11, 44, 5, 2, 5, 1, 10 )				
		,( 1, 4, 11, 44, 5, 2, 5, 2, '' )				
		,( 1, 4, 11, 44, 5, 2, 6, 1, 10 )				
		,( 1, 4, 11, 44, 5, 2, 6, 2, '' )				
		,( 1, 4, 11, 44, 5, 2, 7, 1, 10 )				
		,( 1, 4, 11, 44, 5, 2, 7, 2, '' )				
		,( 1, 4, 11, 44, 5, 2, 8, 1, 10 )				
		,( 1, 4, 11, 44, 5, 2, 8, 2, '' )				
		,( 1, 4, 11, 44, 5, 2, 9, 1, 10 )				
		,( 1, 4, 11, 44, 5, 2, 9, 2, '' )				
		,( 1, 4, 11, 44, 5, 2, 10, 1, 10 )				
		,( 1, 4, 11, 44, 5, 2, 10, 2, 10 )				
		,( 1, 4, 11, 44, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 11, 44, 6, 2, 1, 1, 3 )					
		,( 1, 4, 11, 44, 6, 2, 1, 2, 7 )				
		,( 1, 4, 11, 44, 6, 2, 2, 1, 3 )				
		,( 1, 4, 11, 44, 6, 2, 2, 2, 7 )				
		,( 1, 4, 11, 44, 6, 2, 3, 1, 3 )				
		,( 1, 4, 11, 44, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 11, Player: 44, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 11, 44, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 11, 44, 6, 2, 4, 2, 2 )				
		,( 1, 4, 11, 44, 6, 2, 5, 1, 10 )				
		,( 1, 4, 11, 44, 6, 2, 5, 2, '' )				
		,( 1, 4, 11, 44, 6, 2, 6, 1, 10 )				
		,( 1, 4, 11, 44, 6, 2, 6, 2, '' )				
		,( 1, 4, 11, 44, 6, 2, 7, 1, 3 )				
		,( 1, 4, 11, 44, 6, 2, 7, 2, 7 )				
		,( 1, 4, 11, 44, 6, 2, 8, 1, 3 )				
		,( 1, 4, 11, 44, 6, 2, 8, 2, 7 )				
		,( 1, 4, 11, 44, 6, 2, 9, 1, 3 )				
		,( 1, 4, 11, 44, 6, 2, 9, 2, 6 )				
		,( 1, 4, 11, 44, 6, 2, 10, 1, 10 )				
		,( 1, 4, 11, 44, 6, 2, 10, 2, 10 )				
		,( 1, 4, 11, 44, 6, 2, 10, 3, 10 )						
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 45, 1, 1, 1, 1, 3 )					
		,( 1, 4, 12, 45, 1, 1, 1, 2, 4 )				
		,( 1, 4, 12, 45, 1, 1, 2, 1, 3 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 12, 45, 1, 1, 2, 2, 4 )			-- No spares and no strikes	
		,( 1, 4, 12, 45, 1, 1, 3, 1, 3 )				
		,( 1, 4, 12, 45, 1, 1, 3, 2, 4 )			-- Same as #1 BUT	
		,( 1, 4, 12, 45, 1, 1, 4, 1, 3 )			-- different league, different player	
		,( 1, 4, 12, 45, 1, 1, 4, 2, 4 )			-- This will test league scoring	
		,( 1, 4, 12, 45, 1, 1, 5, 1, 3 )			-- Same player but now on couples league instead of singles	
		,( 1, 4, 12, 45, 1, 1, 5, 2, 4 )				
		,( 1, 4, 12, 45, 1, 1, 6, 1, 3 )				
		,( 1, 4, 12, 45, 1, 1, 6, 2, 4 )			-- Format:	
		,( 1, 4, 12, 45, 1, 1, 7, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 12, 45, 1, 1, 7, 2, 4 )			-- Some spares an no strikes	
		,( 1, 4, 12, 45, 1, 1, 8, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 12, 45, 1, 1, 8, 2, 4 )			-- No spares and some strikes	
		,( 1, 4, 12, 45, 1, 1, 9, 1, 3 )			-- No spares and all strikes	
		,( 1, 4, 12, 45, 1, 1, 9, 2, 4 )			-- Some spares and some strikes	
		,( 1, 4, 12, 45, 1, 1, 10, 1, 3 )				
		,( 1, 4, 12, 45, 1, 1, 10, 2, 4 )				
		,( 1, 4, 12, 45, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 45, 2, 1, 1, 1, 3 )					
		,( 1, 4, 12, 45, 2, 1, 1, 2, 4 )				
		,( 1, 4, 12, 45, 2, 1, 2, 1, 3 )				
		,( 1, 4, 12, 45, 2, 1, 2, 2, 2 )				
		,( 1, 4, 12, 45, 2, 1, 3, 1, 3 )				
		,( 1, 4, 12, 45, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 12, 45, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 12, 45, 2, 1, 4, 2, 2 )				
		,( 1, 4, 12, 45, 2, 1, 5, 1, 3 )				
		,( 1, 4, 12, 45, 2, 1, 5, 2, '' )				
		,( 1, 4, 12, 45, 2, 1, 6, 1, 6 )				
		,( 1, 4, 12, 45, 2, 1, 6, 2, 4 )				
		,( 1, 4, 12, 45, 2, 1, 7, 1, 3 )				
		,( 1, 4, 12, 45, 2, 1, 7, 2, 4 )				
		,( 1, 4, 12, 45, 2, 1, 8, 1, '' )				
		,( 1, 4, 12, 45, 2, 1, 8, 2, 4 )				
		,( 1, 4, 12, 45, 2, 1, 9, 1, 3 )				
		,( 1, 4, 12, 45, 2, 1, 9, 2, 7 )				
		,( 1, 4, 12, 45, 2, 1, 10, 1, 1 )				
		,( 1, 4, 12, 45, 2, 1, 10, 2, 1 )				
		,( 1, 4, 12, 45, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 45, 3, 1, 1, 1, 3 )					
		,( 1, 4, 12, 45, 3, 1, 1, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 2, 1, 3 )				
		,( 1, 4, 12, 45, 3, 1, 2, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 3, 1, 3 )				
		,( 1, 4, 12, 45, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 3, Week: 1,Total score: 131	
		,( 1, 4, 12, 45, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 12, 45, 3, 1, 4, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 5, 1, 3 )				
		,( 1, 4, 12, 45, 3, 1, 5, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 6, 1, 3 )				
		,( 1, 4, 12, 45, 3, 1, 6, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 7, 1, 3 )				
		,( 1, 4, 12, 45, 3, 1, 7, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 8, 1, 3 )				
		,( 1, 4, 12, 45, 3, 1, 8, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 9, 1, 3 )				
		,( 1, 4, 12, 45, 3, 1, 9, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 10, 1, 3 )				
		,( 1, 4, 12, 45, 3, 1, 10, 2, 7 )				
		,( 1, 4, 12, 45, 3, 1, 10, 3, 4 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 45, 4, 2, 1, 1, 10 )					
		,( 1, 4, 12, 45, 4, 2, 1, 2, '' )				
		,( 1, 4, 12, 45, 4, 2, 2, 1, '' )				
		,( 1, 4, 12, 45, 4, 2, 2, 2, 5 )				
		,( 1, 4, 12, 45, 4, 2, 3, 1, 10 )				
		,( 1, 4, 12, 45, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 12, Player: 45, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 12, 45, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 12, 45, 4, 2, 4, 2, 3 )				
		,( 1, 4, 12, 45, 4, 2, 5, 1, 2 )				
		,( 1, 4, 12, 45, 4, 2, 5, 2, '' )				
		,( 1, 4, 12, 45, 4, 2, 6, 1, 3 )				
		,( 1, 4, 12, 45, 4, 2, 6, 2, 2 )				
		,( 1, 4, 12, 45, 4, 2, 7, 1, 10 )				
		,( 1, 4, 12, 45, 4, 2, 7, 2, '' )				
		,( 1, 4, 12, 45, 4, 2, 8, 1, '' )				
		,( 1, 4, 12, 45, 4, 2, 8, 2, '' )				
		,( 1, 4, 12, 45, 4, 2, 9, 1, '' )				
		,( 1, 4, 12, 45, 4, 2, 9, 2, '' )				
		,( 1, 4, 12, 45, 4, 2, 10, 1, 4 )				
		,( 1, 4, 12, 45, 4, 2, 10, 2, 6 )				
		,( 1, 4, 12, 45, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 45, 5, 2, 1, 1, 10 )					
		,( 1, 4, 12, 45, 5, 2, 1, 2, '' )				
		,( 1, 4, 12, 45, 5, 2, 2, 1, 10 )				
		,( 1, 4, 12, 45, 5, 2, 2, 2, '' )				
		,( 1, 4, 12, 45, 5, 2, 3, 1, 10 )				
		,( 1, 4, 12, 45, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 12, Player: 45, Game:5, Week: 2,Total score: 300	
 		,( 1, 4, 12, 45, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 12, 45, 5, 2, 4, 2, '' )				
		,( 1, 4, 12, 45, 5, 2, 5, 1, 10 )				
		,( 1, 4, 12, 45, 5, 2, 5, 2, '' )				
		,( 1, 4, 12, 45, 5, 2, 6, 1, 10 )				
		,( 1, 4, 12, 45, 5, 2, 6, 2, '' )				
		,( 1, 4, 12, 45, 5, 2, 7, 1, 10 )				
		,( 1, 4, 12, 45, 5, 2, 7, 2, '' )				
		,( 1, 4, 12, 45, 5, 2, 8, 1, 10 )				
		,( 1, 4, 12, 45, 5, 2, 8, 2, '' )				
		,( 1, 4, 12, 45, 5, 2, 9, 1, 10 )				
		,( 1, 4, 12, 45, 5, 2, 9, 2, '' )				
		,( 1, 4, 12, 45, 5, 2, 10, 1, 10 )				
		,( 1, 4, 12, 45, 5, 2, 10, 2, 10 )				
		,( 1, 4, 12, 45, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 45, 6, 2, 1, 1, 3 )					
		,( 1, 4, 12, 45, 6, 2, 1, 2, 7 )				
		,( 1, 4, 12, 45, 6, 2, 2, 1, 3 )				
		,( 1, 4, 12, 45, 6, 2, 2, 2, 7 )				
		,( 1, 4, 12, 45, 6, 2, 3, 1, 3 )				
		,( 1, 4, 12, 45, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 45, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 12, 45, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 12, 45, 6, 2, 4, 2, 2 )				
		,( 1, 4, 12, 45, 6, 2, 5, 1, 10 )				
		,( 1, 4, 12, 45, 6, 2, 5, 2, '' )				
		,( 1, 4, 12, 45, 6, 2, 6, 1, 10 )				
		,( 1, 4, 12, 45, 6, 2, 6, 2, '' )				
		,( 1, 4, 12, 45, 6, 2, 7, 1, 3 )				
		,( 1, 4, 12, 45, 6, 2, 7, 2, 7 )				
		,( 1, 4, 12, 45, 6, 2, 8, 1, 3 )				
		,( 1, 4, 12, 45, 6, 2, 8, 2, 7 )				
		,( 1, 4, 12, 45, 6, 2, 9, 1, 3 )				
		,( 1, 4, 12, 45, 6, 2, 9, 2, 6 )				
		,( 1, 4, 12, 45, 6, 2, 10, 1, 10 )				
		,( 1, 4, 12, 45, 6, 2, 10, 2, 10 )				
		,( 1, 4, 12, 45, 6, 2, 10, 3, 10 )							
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 46, 1, 1, 1, 1, 3 )					
		,( 1, 4, 12, 46, 1, 1, 1, 2, 4 )				
		,( 1, 4, 12, 46, 1, 1, 2, 1, 3 )				
		,( 1, 4, 12, 46, 1, 1, 2, 2, 4 )				
		,( 1, 4, 12, 46, 1, 1, 3, 1, 3 )				
		,( 1, 4, 12, 46, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 12, 46, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 12, 46, 1, 1, 4, 2, 4 )				
		,( 1, 4, 12, 46, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 12, 46, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 12, 46, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 12, 46, 1, 1, 6, 2, 4 )				
		,( 1, 4, 12, 46, 1, 1, 7, 1, 3 )				
		,( 1, 4, 12, 46, 1, 1, 7, 2, 4 )				
		,( 1, 4, 12, 46, 1, 1, 8, 1, 3 )				
		,( 1, 4, 12, 46, 1, 1, 8, 2, 4 )				
		,( 1, 4, 12, 46, 1, 1, 9, 1, 3 )				
		,( 1, 4, 12, 46, 1, 1, 9, 2, 4 )				
		,( 1, 4, 12, 46, 1, 1, 10, 1, 3 )				
		,( 1, 4, 12, 46, 1, 1, 10, 2, 4 )				
		,( 1, 4, 12, 46, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 46, 2, 1, 1, 1, 3 )					
		,( 1, 4, 12, 46, 2, 1, 1, 2, 4 )				
		,( 1, 4, 12, 46, 2, 1, 2, 1, 3 )				
		,( 1, 4, 12, 46, 2, 1, 2, 2, 2 )				
		,( 1, 4, 12, 46, 2, 1, 3, 1, 3 )				
		,( 1, 4, 12, 46, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 12, 46, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 12, 46, 2, 1, 4, 2, 2 )				
		,( 1, 4, 12, 46, 2, 1, 5, 1, 3 )				
		,( 1, 4, 12, 46, 2, 1, 5, 2, '' )				
		,( 1, 4, 12, 46, 2, 1, 6, 1, 6 )				
		,( 1, 4, 12, 46, 2, 1, 6, 2, 4 )				
		,( 1, 4, 12, 46, 2, 1, 7, 1, 3 )				
		,( 1, 4, 12, 46, 2, 1, 7, 2, 4 )				
		,( 1, 4, 12, 46, 2, 1, 8, 1, '' )				
		,( 1, 4, 12, 46, 2, 1, 8, 2, 4 )				
		,( 1, 4, 12, 46, 2, 1, 9, 1, 3 )				
		,( 1, 4, 12, 46, 2, 1, 9, 2, 7 )				
		,( 1, 4, 12, 46, 2, 1, 10, 1, 1 )				
		,( 1, 4, 12, 46, 2, 1, 10, 2, 1 )				
		,( 1, 4, 12, 46, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 46, 3, 1, 1, 1, 3 )					
		,( 1, 4, 12, 46, 3, 1, 1, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 2, 1, 3 )				
		,( 1, 4, 12, 46, 3, 1, 2, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 3, 1, 3 )				
		,( 1, 4, 12, 46, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 3, Week: 1,Total score: 131	
		,( 1, 4, 12, 46, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 12, 46, 3, 1, 4, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 5, 1, 3 )				
		,( 1, 4, 12, 46, 3, 1, 5, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 6, 1, 3 )				
		,( 1, 4, 12, 46, 3, 1, 6, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 7, 1, 3 )				
		,( 1, 4, 12, 46, 3, 1, 7, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 8, 1, 3 )				
		,( 1, 4, 12, 46, 3, 1, 8, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 9, 1, 3 )				
		,( 1, 4, 12, 46, 3, 1, 9, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 10, 1, 3 )				
		,( 1, 4, 12, 46, 3, 1, 10, 2, 7 )				
		,( 1, 4, 12, 46, 3, 1, 10, 3, 4 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 46, 4, 2, 1, 1, 10 )					
		,( 1, 4, 12, 46, 4, 2, 1, 2, '' )				
		,( 1, 4, 12, 46, 4, 2, 2, 1, '' )				
		,( 1, 4, 12, 46, 4, 2, 2, 2, 5 )				
		,( 1, 4, 12, 46, 4, 2, 3, 1, 10 )				
		,( 1, 4, 12, 46, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 12, Player: 46, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 12, 46, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 12, 46, 4, 2, 4, 2, 3 )				
		,( 1, 4, 12, 46, 4, 2, 5, 1, 2 )				
		,( 1, 4, 12, 46, 4, 2, 5, 2, '' )				
		,( 1, 4, 12, 46, 4, 2, 6, 1, 3 )				
		,( 1, 4, 12, 46, 4, 2, 6, 2, 2 )				
		,( 1, 4, 12, 46, 4, 2, 7, 1, 10 )				
		,( 1, 4, 12, 46, 4, 2, 7, 2, '' )				
		,( 1, 4, 12, 46, 4, 2, 8, 1, '' )				
		,( 1, 4, 12, 46, 4, 2, 8, 2, '' )				
		,( 1, 4, 12, 46, 4, 2, 9, 1, '' )				
		,( 1, 4, 12, 46, 4, 2, 9, 2, '' )				
		,( 1, 4, 12, 46, 4, 2, 10, 1, 4 )				
		,( 1, 4, 12, 46, 4, 2, 10, 2, 6 )				
		,( 1, 4, 12, 46, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 46, 5, 2, 1, 1, 10 )					
		,( 1, 4, 12, 46, 5, 2, 1, 2, '' )				
		,( 1, 4, 12, 46, 5, 2, 2, 1, 10 )				
		,( 1, 4, 12, 46, 5, 2, 2, 2, '' )				
		,( 1, 4, 12, 46, 5, 2, 3, 1, 10 )				
		,( 1, 4, 12, 46, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 12, 46, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 12, 46, 5, 2, 4, 2, '' )				
		,( 1, 4, 12, 46, 5, 2, 5, 1, 10 )				
		,( 1, 4, 12, 46, 5, 2, 5, 2, '' )				
		,( 1, 4, 12, 46, 5, 2, 6, 1, 10 )				
		,( 1, 4, 12, 46, 5, 2, 6, 2, '' )				
		,( 1, 4, 12, 46, 5, 2, 7, 1, 10 )				
		,( 1, 4, 12, 46, 5, 2, 7, 2, '' )				
		,( 1, 4, 12, 46, 5, 2, 8, 1, 10 )				
		,( 1, 4, 12, 46, 5, 2, 8, 2, '' )				
		,( 1, 4, 12, 46, 5, 2, 9, 1, 10 )				
		,( 1, 4, 12, 46, 5, 2, 9, 2, '' )				
		,( 1, 4, 12, 46, 5, 2, 10, 1, 10 )				
		,( 1, 4, 12, 46, 5, 2, 10, 2, 10 )				
		,( 1, 4, 12, 46, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 46, 6, 2, 1, 1, 3 )					
		,( 1, 4, 12, 46, 6, 2, 1, 2, 7 )				
		,( 1, 4, 12, 46, 6, 2, 2, 1, 3 )				
		,( 1, 4, 12, 46, 6, 2, 2, 2, 7 )				
		,( 1, 4, 12, 46, 6, 2, 3, 1, 3 )				
		,( 1, 4, 12, 46, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 46, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 12, 46, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 12, 46, 6, 2, 4, 2, 2 )				
		,( 1, 4, 12, 46, 6, 2, 5, 1, 10 )				
		,( 1, 4, 12, 46, 6, 2, 5, 2, '' )				
		,( 1, 4, 12, 46, 6, 2, 6, 1, 10 )				
		,( 1, 4, 12, 46, 6, 2, 6, 2, '' )				
		,( 1, 4, 12, 46, 6, 2, 7, 1, 3 )				
		,( 1, 4, 12, 46, 6, 2, 7, 2, 7 )				
		,( 1, 4, 12, 46, 6, 2, 8, 1, 3 )				
		,( 1, 4, 12, 46, 6, 2, 8, 2, 7 )				
		,( 1, 4, 12, 46, 6, 2, 9, 1, 3 )				
		,( 1, 4, 12, 46, 6, 2, 9, 2, 6 )				
		,( 1, 4, 12, 46, 6, 2, 10, 1, 10 )				
		,( 1, 4, 12, 46, 6, 2, 10, 2, 10 )				
		,( 1, 4, 12, 46, 6, 2, 10, 3, 10 )							
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 47, 1, 1, 1, 1, 3 )					
		,( 1, 4, 12, 47, 1, 1, 1, 2, 4 )				
		,( 1, 4, 12, 47, 1, 1, 2, 1, 3 )				
		,( 1, 4, 12, 47, 1, 1, 2, 2, 4 )				
		,( 1, 4, 12, 47, 1, 1, 3, 1, 3 )				
		,( 1, 4, 12, 47, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 12, 47, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 12, 47, 1, 1, 4, 2, 4 )				
		,( 1, 4, 12, 47, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 12, 47, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 12, 47, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 12, 47, 1, 1, 6, 2, 4 )				
		,( 1, 4, 12, 47, 1, 1, 7, 1, 3 )				
		,( 1, 4, 12, 47, 1, 1, 7, 2, 4 )				
		,( 1, 4, 12, 47, 1, 1, 8, 1, 3 )				
		,( 1, 4, 12, 47, 1, 1, 8, 2, 4 )				
		,( 1, 4, 12, 47, 1, 1, 9, 1, 3 )				
		,( 1, 4, 12, 47, 1, 1, 9, 2, 4 )				
		,( 1, 4, 12, 47, 1, 1, 10, 1, 3 )				
		,( 1, 4, 12, 47, 1, 1, 10, 2, 4 )				
		,( 1, 4, 12, 47, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 47, 2, 1, 1, 1, 3 )					
		,( 1, 4, 12, 47, 2, 1, 1, 2, 4 )				
		,( 1, 4, 12, 47, 2, 1, 2, 1, 3 )				
		,( 1, 4, 12, 47, 2, 1, 2, 2, 2 )				
		,( 1, 4, 12, 47, 2, 1, 3, 1, 3 )				
		,( 1, 4, 12, 47, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 12, 47, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 12, 47, 2, 1, 4, 2, 2 )				
		,( 1, 4, 12, 47, 2, 1, 5, 1, 3 )				
		,( 1, 4, 12, 47, 2, 1, 5, 2, '' )				
		,( 1, 4, 12, 47, 2, 1, 6, 1, 6 )				
		,( 1, 4, 12, 47, 2, 1, 6, 2, 4 )				
		,( 1, 4, 12, 47, 2, 1, 7, 1, 3 )				
		,( 1, 4, 12, 47, 2, 1, 7, 2, 4 )				
		,( 1, 4, 12, 47, 2, 1, 8, 1, '' )				
		,( 1, 4, 12, 47, 2, 1, 8, 2, 4 )				
		,( 1, 4, 12, 47, 2, 1, 9, 1, 3 )				
		,( 1, 4, 12, 47, 2, 1, 9, 2, 7 )				
		,( 1, 4, 12, 47, 2, 1, 10, 1, 1 )				
		,( 1, 4, 12, 47, 2, 1, 10, 2, 1 )				
		,( 1, 4, 12, 47, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 47, 3, 1, 1, 1, 3 )					
		,( 1, 4, 12, 47, 3, 1, 1, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 2, 1, 3 )				
		,( 1, 4, 12, 47, 3, 1, 2, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 3, 1, 3 )				
		,( 1, 4, 12, 47, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 3, Week: 1,Total score: 130	
		,( 1, 4, 12, 47, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 12, 47, 3, 1, 4, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 5, 1, 3 )				
		,( 1, 4, 12, 47, 3, 1, 5, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 6, 1, 3 )				
		,( 1, 4, 12, 47, 3, 1, 6, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 7, 1, 3 )				
		,( 1, 4, 12, 47, 3, 1, 7, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 8, 1, 3 )				
		,( 1, 4, 12, 47, 3, 1, 8, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 9, 1, 3 )				
		,( 1, 4, 12, 47, 3, 1, 9, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 10, 1, 3 )				
		,( 1, 4, 12, 47, 3, 1, 10, 2, 7 )				
		,( 1, 4, 12, 47, 3, 1, 10, 3, 3 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 47, 4, 2, 1, 1, 10 )					
		,( 1, 4, 12, 47, 4, 2, 1, 2, '' )				
		,( 1, 4, 12, 47, 4, 2, 2, 1, '' )				
		,( 1, 4, 12, 47, 4, 2, 2, 2, 5 )				
		,( 1, 4, 12, 47, 4, 2, 3, 1, 10 )				
		,( 1, 4, 12, 47, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 12, Player: 47, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 12, 47, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 12, 47, 4, 2, 4, 2, 3 )				
		,( 1, 4, 12, 47, 4, 2, 5, 1, 2 )				
		,( 1, 4, 12, 47, 4, 2, 5, 2, '' )				
		,( 1, 4, 12, 47, 4, 2, 6, 1, 3 )				
		,( 1, 4, 12, 47, 4, 2, 6, 2, 2 )				
		,( 1, 4, 12, 47, 4, 2, 7, 1, 10 )				
		,( 1, 4, 12, 47, 4, 2, 7, 2, '' )				
		,( 1, 4, 12, 47, 4, 2, 8, 1, '' )				
		,( 1, 4, 12, 47, 4, 2, 8, 2, '' )				
		,( 1, 4, 12, 47, 4, 2, 9, 1, '' )				
		,( 1, 4, 12, 47, 4, 2, 9, 2, '' )				
		,( 1, 4, 12, 47, 4, 2, 10, 1, 4 )				
		,( 1, 4, 12, 47, 4, 2, 10, 2, 6 )				
		,( 1, 4, 12, 47, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 47, 5, 2, 1, 1, 10 )					
		,( 1, 4, 12, 47, 5, 2, 1, 2, '' )				
		,( 1, 4, 12, 47, 5, 2, 2, 1, 10 )				
		,( 1, 4, 12, 47, 5, 2, 2, 2, '' )				
		,( 1, 4, 12, 47, 5, 2, 3, 1, 10 )				
		,( 1, 4, 12, 47, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 12, 47, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 12, 47, 5, 2, 4, 2, '' )				
		,( 1, 4, 12, 47, 5, 2, 5, 1, 10 )				
		,( 1, 4, 12, 47, 5, 2, 5, 2, '' )				
		,( 1, 4, 12, 47, 5, 2, 6, 1, 10 )				
		,( 1, 4, 12, 47, 5, 2, 6, 2, '' )				
		,( 1, 4, 12, 47, 5, 2, 7, 1, 10 )				
		,( 1, 4, 12, 47, 5, 2, 7, 2, '' )				
		,( 1, 4, 12, 47, 5, 2, 8, 1, 10 )				
		,( 1, 4, 12, 47, 5, 2, 8, 2, '' )				
		,( 1, 4, 12, 47, 5, 2, 9, 1, 10 )				
		,( 1, 4, 12, 47, 5, 2, 9, 2, '' )				
		,( 1, 4, 12, 47, 5, 2, 10, 1, 10 )				
		,( 1, 4, 12, 47, 5, 2, 10, 2, 10 )				
		,( 1, 4, 12, 47, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 47, 6, 2, 1, 1, 3 )					
		,( 1, 4, 12, 47, 6, 2, 1, 2, 7 )				
		,( 1, 4, 12, 47, 6, 2, 2, 1, 3 )				
		,( 1, 4, 12, 47, 6, 2, 2, 2, 7 )				
		,( 1, 4, 12, 47, 6, 2, 3, 1, 3 )				
		,( 1, 4, 12, 47, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 47, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 12, 47, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 12, 47, 6, 2, 4, 2, 2 )				
		,( 1, 4, 12, 47, 6, 2, 5, 1, 10 )				
		,( 1, 4, 12, 47, 6, 2, 5, 2, '' )				
		,( 1, 4, 12, 47, 6, 2, 6, 1, 10 )				
		,( 1, 4, 12, 47, 6, 2, 6, 2, '' )				
		,( 1, 4, 12, 47, 6, 2, 7, 1, 3 )				
		,( 1, 4, 12, 47, 6, 2, 7, 2, 7 )				
		,( 1, 4, 12, 47, 6, 2, 8, 1, 3 )				
		,( 1, 4, 12, 47, 6, 2, 8, 2, 7 )				
		,( 1, 4, 12, 47, 6, 2, 9, 1, 3 )				
		,( 1, 4, 12, 47, 6, 2, 9, 2, 6 )				
		,( 1, 4, 12, 47, 6, 2, 10, 1, 10 )				
		,( 1, 4, 12, 47, 6, 2, 10, 2, 10 )				
		,( 1, 4, 12, 47, 6, 2, 10, 3, 10 )								
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 48, 1, 1, 1, 1, 3 )					
		,( 1, 4, 12, 48, 1, 1, 1, 2, 4 )				
		,( 1, 4, 12, 48, 1, 1, 2, 1, 3 )				
		,( 1, 4, 12, 48, 1, 1, 2, 2, 4 )				
		,( 1, 4, 12, 48, 1, 1, 3, 1, 3 )				
		,( 1, 4, 12, 48, 1, 1, 3, 2, 4 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 1, Week: 1,Total score: 70	
		,( 1, 4, 12, 48, 1, 1, 4, 1, 3 )			-- No spares and no strikes	
		,( 1, 4, 12, 48, 1, 1, 4, 2, 4 )				
		,( 1, 4, 12, 48, 1, 1, 5, 1, 3 )			-- Repeat of above BUT	
		,( 1, 4, 12, 48, 1, 1, 5, 2, 4 )			-- different player same everything else	
		,( 1, 4, 12, 48, 1, 1, 6, 1, 3 )			-- This will test to make sure our scoring works on the player level	
		,( 1, 4, 12, 48, 1, 1, 6, 2, 4 )				
		,( 1, 4, 12, 48, 1, 1, 7, 1, 3 )				
		,( 1, 4, 12, 48, 1, 1, 7, 2, 4 )				
		,( 1, 4, 12, 48, 1, 1, 8, 1, 3 )				
		,( 1, 4, 12, 48, 1, 1, 8, 2, 4 )				
		,( 1, 4, 12, 48, 1, 1, 9, 1, 3 )				
		,( 1, 4, 12, 48, 1, 1, 9, 2, 4 )				
		,( 1, 4, 12, 48, 1, 1, 10, 1, 3 )				
		,( 1, 4, 12, 48, 1, 1, 10, 2, 4 )				
		,( 1, 4, 12, 48, 1, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 48, 2, 1, 1, 1, 3 )					
		,( 1, 4, 12, 48, 2, 1, 1, 2, 4 )				
		,( 1, 4, 12, 48, 2, 1, 2, 1, 3 )				
		,( 1, 4, 12, 48, 2, 1, 2, 2, 2 )				
		,( 1, 4, 12, 48, 2, 1, 3, 1, 3 )				
		,( 1, 4, 12, 48, 2, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 2, Week: 1,Total score: 70	
		,( 1, 4, 12, 48, 2, 1, 4, 1, 3 )			-- Some spares and no strikes	
		,( 1, 4, 12, 48, 2, 1, 4, 2, 2 )				
		,( 1, 4, 12, 48, 2, 1, 5, 1, 3 )				
		,( 1, 4, 12, 48, 2, 1, 5, 2, '' )				
		,( 1, 4, 12, 48, 2, 1, 6, 1, 6 )				
		,( 1, 4, 12, 48, 2, 1, 6, 2, 4 )				
		,( 1, 4, 12, 48, 2, 1, 7, 1, 3 )				
		,( 1, 4, 12, 48, 2, 1, 7, 2, 4 )				
		,( 1, 4, 12, 48, 2, 1, 8, 1, '' )				
		,( 1, 4, 12, 48, 2, 1, 8, 2, 4 )				
		,( 1, 4, 12, 48, 2, 1, 9, 1, 3 )				
		,( 1, 4, 12, 48, 2, 1, 9, 2, 7 )				
		,( 1, 4, 12, 48, 2, 1, 10, 1, 1 )				
		,( 1, 4, 12, 48, 2, 1, 10, 2, 1 )				
		,( 1, 4, 12, 48, 2, 1, 10, 3, '' )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 48, 3, 1, 1, 1, 3 )					
		,( 1, 4, 12, 48, 3, 1, 1, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 2, 1, 3 )				
		,( 1, 4, 12, 48, 3, 1, 2, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 3, 1, 3 )				
		,( 1, 4, 12, 48, 3, 1, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 3, Week: 1,Total score: 131	
		,( 1, 4, 12, 48, 3, 1, 4, 1, 3 )			-- All spares and no strikes	
		,( 1, 4, 12, 48, 3, 1, 4, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 5, 1, 3 )				
		,( 1, 4, 12, 48, 3, 1, 5, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 6, 1, 3 )				
		,( 1, 4, 12, 48, 3, 1, 6, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 7, 1, 3 )				
		,( 1, 4, 12, 48, 3, 1, 7, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 8, 1, 3 )				
		,( 1, 4, 12, 48, 3, 1, 8, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 9, 1, 3 )				
		,( 1, 4, 12, 48, 3, 1, 9, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 10, 1, 3 )				
		,( 1, 4, 12, 48, 3, 1, 10, 2, 7 )				
		,( 1, 4, 12, 48, 3, 1, 10, 3, 4 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 48, 4, 2, 1, 1, 10 )					
		,( 1, 4, 12, 48, 4, 2, 1, 2, '' )				
		,( 1, 4, 12, 48, 4, 2, 2, 1, '' )				
		,( 1, 4, 12, 48, 4, 2, 2, 2, 5 )				
		,( 1, 4, 12, 48, 4, 2, 3, 1, 10 )				
		,( 1, 4, 12, 48, 4, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 12, Player: 48, Game:4, Week: 2,Total score: 70	
		,( 1, 4, 12, 48, 4, 2, 4, 1, 5 )			-- No spares and some strikes	
		,( 1, 4, 12, 48, 4, 2, 4, 2, 3 )				
		,( 1, 4, 12, 48, 4, 2, 5, 1, 2 )				
		,( 1, 4, 12, 48, 4, 2, 5, 2, '' )				
		,( 1, 4, 12, 48, 4, 2, 6, 1, 3 )				
		,( 1, 4, 12, 48, 4, 2, 6, 2, 2 )				
		,( 1, 4, 12, 48, 4, 2, 7, 1, 10 )				
		,( 1, 4, 12, 48, 4, 2, 7, 2, '' )				
		,( 1, 4, 12, 48, 4, 2, 8, 1, '' )				
		,( 1, 4, 12, 48, 4, 2, 8, 2, '' )				
		,( 1, 4, 12, 48, 4, 2, 9, 1, '' )				
		,( 1, 4, 12, 48, 4, 2, 9, 2, '' )				
		,( 1, 4, 12, 48, 4, 2, 10, 1, 4 )				
		,( 1, 4, 12, 48, 4, 2, 10, 2, 6 )				
		,( 1, 4, 12, 48, 4, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 48, 5, 2, 1, 1, 10 )					
		,( 1, 4, 12, 48, 5, 2, 1, 2, '' )				
		,( 1, 4, 12, 48, 5, 2, 2, 1, 10 )				
		,( 1, 4, 12, 48, 5, 2, 2, 2, '' )				
		,( 1, 4, 12, 48, 5, 2, 3, 1, 10 )				
		,( 1, 4, 12, 48, 5, 2, 3, 2, '' )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 5, Week: 2,Total score: 300	
		,( 1, 4, 12, 48, 5, 2, 4, 1, 10 )			-- No spares and all strikes	
		,( 1, 4, 12, 48, 5, 2, 4, 2, '' )				
		,( 1, 4, 12, 48, 5, 2, 5, 1, 10 )				
		,( 1, 4, 12, 48, 5, 2, 5, 2, '' )				
		,( 1, 4, 12, 48, 5, 2, 6, 1, 10 )				
		,( 1, 4, 12, 48, 5, 2, 6, 2, '' )				
		,( 1, 4, 12, 48, 5, 2, 7, 1, 10 )				
		,( 1, 4, 12, 48, 5, 2, 7, 2, '' )				
		,( 1, 4, 12, 48, 5, 2, 8, 1, 10 )				
		,( 1, 4, 12, 48, 5, 2, 8, 2, '' )				
		,( 1, 4, 12, 48, 5, 2, 9, 1, 10 )				
		,( 1, 4, 12, 48, 5, 2, 9, 2, '' )				
		,( 1, 4, 12, 48, 5, 2, 10, 1, 10 )				
		,( 1, 4, 12, 48, 5, 2, 10, 2, 10 )				
		,( 1, 4, 12, 48, 5, 2, 10, 3, 10 )				
						
INSERT INTO TPlayerGameFrameThrows ( intYearID, intLeagueID, intTeamID, intPlayerID, intGameIndex, intWeekIndex, intFrameindex, intThrowIndex, intPinCount)						
VALUES	 ( 1, 4, 12, 48, 6, 2, 1, 1, 3 )					
		,( 1, 4, 12, 48, 6, 2, 1, 2, 7 )				
		,( 1, 4, 12, 48, 6, 2, 2, 1, 3 )				
		,( 1, 4, 12, 48, 6, 2, 2, 2, 7 )				
		,( 1, 4, 12, 48, 6, 2, 3, 1, 3 )				
		,( 1, 4, 12, 48, 6, 2, 3, 2, 7 )			-- Year 2011, League: 4, Team: 12, Player: 48, Game: 6, Week: 2,Total score: 148	
		,( 1, 4, 12, 48, 6, 2, 4, 1, 1 )			-- Some spares and some strikes	
		,( 1, 4, 12, 48, 6, 2, 4, 2, 2 )				
		,( 1, 4, 12, 48, 6, 2, 5, 1, 10 )				
		,( 1, 4, 12, 48, 6, 2, 5, 2, '' )				
		,( 1, 4, 12, 48, 6, 2, 6, 1, 10 )				
		,( 1, 4, 12, 48, 6, 2, 6, 2, '' )				
		,( 1, 4, 12, 48, 6, 2, 7, 1, 3 )				
		,( 1, 4, 12, 48, 6, 2, 7, 2, 7 )				
		,( 1, 4, 12, 48, 6, 2, 8, 1, 3 )				
		,( 1, 4, 12, 48, 6, 2, 8, 2, 7 )				
		,( 1, 4, 12, 48, 6, 2, 9, 1, 3 )				
		,( 1, 4, 12, 48, 6, 2, 9, 2, 6 )				
		,( 1, 4, 12, 48, 6, 2, 10, 1, 10 )				
		,( 1, 4, 12, 48, 6, 2, 10, 2, 10 )				
		,( 1, 4, 12, 48, 6, 2, 10, 3, 10 )				
		
					
-- --------------------------------------------------------------------------------
-- Step 2.1: SP1 Create a new player and assign that player to to a team
---- --------------------------------------------------------------------------------
GO

CREATE PROCEDURE  uspSP1_AddPlayerAndAssignToATeam
	 @intPlayerID		AS INTEGER OUTPUT		-- Must specify OUTPUT
	,@strFirstName		AS VARCHAR( 50 )
	,@strLastName		AS VARCHAR( 50 )
	,@strPhoneNumber	AS VARCHAR( 50 )
	,@strAddress		AS VARCHAR( 100 )
	,@intYearID			AS INTEGER
	,@intLeagueID		AS INTEGER
	,@intTeamID			AS INTEGER
AS
SET NOCOUNT ON			-- Report only errors
SET XACT_ABORT ON		-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION

	SELECT @intPlayerID  = MAX( intPlayerID ) + 1
	FROM TPlayers (TABLOCKX) -- Lock table until end of transaction

	-- Default to 1 if table is empty
	SELECT @intPlayerID  = COALESCE( @intPlayerID , 1 )

	INSERT INTO TPlayers( intPlayerID, strFirstName, strLastName, strPhoneNumber, strAddress )
	VALUES( @intPlayerID , @strFirstName, @strLastName, @strPhoneNumber, @strAddress )

	-- Assign to a team
	INSERT INTO TYearLeagueTeamPlayers ( intYearID, intLeagueID, intTeamID, intPlayerID )
	VALUES( @intYearID, @intLeagueID, @intTeamID, @intPlayerID )

COMMIT TRANSACTION
			
GO

--	-- Test it
SELECT 'STEP 2 SP1 Add player Pete Rose'
DECLARE @intPlayerID AS INTEGER = 0;
EXECUTE uspSP1_AddPlayerAndAssignToATeam @intPlayerID OUTPUT, 'Pete', 'Rose', '745-1111', '98 0ak', 1, 3, 8	-- Must specify OUTPUT
PRINT 'intPlayerID = ' + CONVERT( VARCHAR, @intPlayerID )

	-- Select statement for the above stored procedure to show changes
SELECT * FROM TPlayers						
SELECT * FROM TYearLeagueTeamPlayers

-- --------------------------------------------------------------------------------
-- Step 2.2: SP2 Create a Team with 4 unique players
-- --------------------------------------------------------------------------------
GO

CREATE PROCEDURE uspSP2_AddTeamAndPlayers
	 @intTeamID				AS INTEGER OUTPUT		-- Must specify OUTPUT
	,@strTeam				AS VARCHAR( 50 )
	,@intYearID				AS INTEGER
	,@intLeagueID			AS INTEGER
	,@intTeamCaptainID		AS INTEGER
	,@intPlayerID			AS INTEGER

AS
SET NOCOUNT ON			-- Report only errors
SET XACT_ABORT ON		-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION

	SELECT @intTeamID  = MAX( intTeamID ) + 1
	FROM TTeams (TABLOCKX) -- Lock table until end of transaction

	-- Default to 1 if table is empty
	SELECT @intTeamID  = COALESCE( @intTeamID , 1 )

	INSERT INTO TTeams( intTeamID, strTeam )
	VALUES( @intTeamID , @strTeam )

	-- Assign a year,league and captain
	INSERT INTO TYearLeagueTeams( intYearID, intLeagueID, intTeamID, intTeamCaptainID )
	VALUES( @intYearID, @intLeagueID, @intTeamID, @intTeamCaptainID )

	-- Assign a player
	INSERT INTO TYearLeagueTeamPlayers( intYearID, intLeagueID, intTeamID, intPlayerID )
	VALUES( @intYearID, @intLeagueID, @intTeamID, @intPlayerID )

COMMIT TRANSACTION

GO

	-- Test it
SELECT 'STEP 2 SP2 Add team Strike Force'
DECLARE @intTeamID AS INTEGER = 0;
EXECUTE uspSP2_AddTeamAndPlayers @intTeamID OUTPUT, 'Strike Force', 1, 1, 49, 49	-- Must specify OUTPUT
PRINT 'intTeamID = ' + CONVERT( VARCHAR, @intTeamID )

	-- Select statement for the above stored procedure to show changes
SELECT * FROM TTeams
SELECT * FROM TYearLeagueTeams
SELECT * FROM TYearLeagueTeamPlayers

-- --------------------------------------------------------------------------------
-- Step 2.3: SP3 Create a Team with 4 unique players
-- --------------------------------------------------------------------------------
GO

CREATE PROCEDURE uspSP3_AddLeague
	 @intLeagueID				AS INTEGER OUTPUT		-- Must specify OUTPUT
	,@strLeague					AS VARCHAR( 50 )
	,@intYearID					AS INTEGER
	,@intLeaguePresidentID		AS INTEGER

AS
SET NOCOUNT ON			-- Report only errors
SET XACT_ABORT ON		-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION

	SELECT @intLeagueID  = MAX( intLeagueID ) + 1
	FROM TLeagues (TABLOCKX) -- Lock table until end of transaction

	-- Default to 1 if table is empty
	SELECT @intLeagueID  = COALESCE( @intLeagueID , 1 )

	INSERT INTO TLeagues( intLeagueID, strLeague )
	VALUES( @intLeagueID , @strLeague )

	INSERT INTO TYearLeagues( intYearID, intLeagueID, intLeaguePresidentID )
	VALUES( @intYearID, @intLeagueID, @intLeaguePresidentID )

COMMIT TRANSACTION

GO

	-- Test it
SELECT 'STEP 2 SP3 Add league F'
DECLARE @intLeagueID AS INTEGER = 0;
EXECUTE uspSP3_AddLeague @intLeagueID OUTPUT, 'League F (youth)', 1, 2	-- Must specify OUTPUT
PRINT 'intTeamID = ' + CONVERT( VARCHAR, @intLeagueID )

	 --Select statement to show changes
SELECT * FROM TLeagues
SELECT * FROM TYearLeagues

-- --------------------------------------------------------------------------------
-- Step 2.4: SP4 Edit player score in a frame of a game
-- --------------------------------------------------------------------------------
GO

CREATE PROCEDURE uspSP4_EditPlayerScoreInAFrameOfAGame
	 @intYearID			AS INTEGER
	,@intLeagueID		AS INTEGER
	,@intTeamID			AS INTEGER
	,@intPlayerID		AS INTEGER
	,@intGameIndex		AS INTEGER
	,@intWeekIndex		AS INTEGER
	,@intFrameIndex		AS INTEGER
	,@intThrowIndex		AS INTEGER
	,@intPinCount		AS INTEGER

AS
SET NOCOUNT ON			-- Report only errors
SET XACT_ABORT ON		-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION

		-- Update the record
		UPDATE
				TPlayerGameFrameThrows
		SET
				intPinCount = @intPinCount
		WHERE
				intYearID = @intYearID
			AND	intLeagueID = @intLeagueID
			AND intTeamID = @intTeamID
			AND intPlayerID = @intPlayerID
			AND intGameIndex = @intGameIndex
			AND intWeekIndex = @intWeekIndex
			AND intFrameIndex = @intFrameIndex
			AND intThrowIndex = @intThrowIndex

COMMIT TRANSACTION

GO

	-- Test it

SELECT 'STEP 2 SP4 Edit-alter score by 2'
EXECUTE uspSP4_EditPlayerScoreInAFrameOfAGame	1, 1, 1, 1, 1, 1, 1, 1, 5	-- Must specify OUTPUT

	 -- Select statement to show changes
SELECT 
	*
FROM
	TPlayerGameFrameThrows
WHERE
		intYearID = 1
	AND intLeagueID = 1
	AND intTeamID = 1
	AND intPlayerID = 1
	AND intGameIndex = 1
	AND intWeekIndex = 1
	AND intFrameIndex = 1
	AND intThrowIndex = 1

GO
-- --------------------------------------------------------------------------------
-- Step 3: Write the views that will show the joins to create the final score
-- --------------------------------------------------------------------------------	

-- --------------------------------------------------------------------------------
-- Create view for standing pin count
-- --------------------------------------------------------------------------------
 GO

 CREATE VIEW VGamePinCountScore
 AS

 SELECT
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName + ', ' + TP.strFirstName AS strPlayer
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex
	,ISNULL( SUM( TPGFT.intPinCount ), 0 ) AS intGamePinCountScore
FROM
	TYears AS TY

		INNER JOIN TYearLeagues AS TYL

			INNER JOIN TLeagues AS TL
			ON( TYL.intLeagueID = TL.intLeagueID )

			INNER JOIN TYearLeagueTeams AS TYLT

				INNER JOIN TTeams AS TT
				ON( TYLT.intTeamID = TT.intTeamID )

				INNER JOIN TYearLeagueTeamPlayers AS TYLTP

					INNER JOIN TPlayers AS TP
					ON( TYLTP.intPlayerID = TP.intPlayerID )

					INNER JOIN TPlayerGames AS TPG

						INNER JOIN TYearLeagueTeamGames AS TYLTG
						ON(		TPG.intYearID	 = TYLTG.intYearID
							AND TPG.intLeagueID	 = TYLTG.intLeagueID
							AND TPG.intTeamID	 = TYLTG.intTeamID
							AND TPG.intGameIndex = TYLTG.intGameIndex
							AND TPG.intWeekIndex = TYLTG.intWeekIndex 
							)

						INNER JOIN TPlayerGameFrames AS TPGF
						
							INNER JOIN TPlayerGameFrameThrows AS TPGFT
							ON(		TPGF.intYearID	   = TPGFT.intYearID
								AND TPGF.intLeagueID   = TPGFT.intLeagueID
								AND TPGF.intTeamID	   = TPGFT.intTeamID
								AND TPGF.intPlayerID   = TPGFT.intPlayerID
								AND TPGF.intGameIndex  = TPGFT.intGameIndex
								AND TPGF.intWeekIndex  = TPGFT.intWeekIndex
								AND TPGF.intFrameIndex = TPGFT.intFrameIndex 
								)

						ON(		TPG.intYearID    = TPGF.intYearID
							AND TPG.intLeagueID  = TPGF.intLeagueID
							AND TPG.intTeamID    = TPGF.intTeamID
							AND TPG.intPlayerID  = TPGF.intPlayerID
							AND TPG.intGameIndex = TPGF.intGameIndex
							AND TPG.intWeekIndex = TPGF.intWeekIndex 
							)

					ON(		TPG.intYearID    = TPGF.intYearID
						AND TPG.intLeagueID  = TPGF.intLeagueID
						AND TPG.intTeamID    = TPGF.intTeamID
						AND TPG.intPlayerID  = TPGF.intPlayerID
						AND TPG.intGameIndex = TPGF.intGameIndex
						AND TPG.intWeekIndex = TPGF.intWeekIndex 
						)

				ON(		TYLTP.intYearID   = TPG.intYearID
					AND TYLTP.intLeagueID = TPG.intLeagueID
					AND TYLTP.intTeamID   = TPG.intTeamID
					AND TYLTP.intPlayerID = TPG.intPlayerID 
					)

			ON(		TYLT.intYearID = TYLTP.intYearID
				AND TYLT.intLeagueID = TYLTP.intLeagueID
				AND TYLT.intTeamID = TYLTP.intTeamID 
				)
				
		ON(		TYL.intYearID = TYLT.intYearID
			AND TYL.intLeagueID = TYLT.intLeagueID 
			)

WHERE
		strYear = 2011
	
GROUP BY
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName
	,TP.strFirstName
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex

GO

-- SELECT * FROM VGamePinCountScore

-- --------------------------------------------------------------------------------
-- Create view for Spare bonus pins-- score when first ball knocks down some or none but not all
-- of the ten pins, and you knock down the rest of the pins with the second throw.
-- The first ball of the next frame is then added to the score of ten from the previous
-- frame. Get next frame throw one pin count. 
-- --------------------------------------------------------------------------------
 GO

 CREATE VIEW VGameSpareScore
 AS

 SELECT
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName + ', ' + TP.strFirstName AS strPlayer
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex
	,ISNULL( SUM( NextFrameThrow1.intPinCount ), 0 ) AS intGameSpareScore
FROM
	TYears AS TY

		INNER JOIN TYearLeagues AS TYL

			INNER JOIN TLeagues AS TL
			ON( TYL.intLeagueID = TL.intLeagueID )

			INNER JOIN TYearLeagueTeams AS TYLT

				INNER JOIN TTeams AS TT
				ON( TYLT.intTeamID = TT.intTeamID )

				INNER JOIN TYearLeagueTeamPlayers AS TYLTP

					INNER JOIN TPlayers AS TP
					ON( TYLTP.intPlayerID = TP.intPlayerID )

					INNER JOIN TPlayerGames AS TPG

						INNER JOIN TYearLeagueTeamGames AS TYLTG
						ON(		TPG.intYearID	 = TYLTG.intYearID
							AND TPG.intLeagueID	 = TYLTG.intLeagueID
							AND TPG.intTeamID	 = TYLTG.intTeamID
							AND TPG.intGameIndex = TYLTG.intGameIndex
							AND TPG.intWeekIndex = TYLTG.intWeekIndex 
							)

						INNER JOIN TPlayerGameFrames AS TPGF
						
							INNER JOIN TPlayerGameFrameThrows AS CurrentFrameThrow1
							ON(		TPGF.intYearID					 = CurrentFrameThrow1.intYearID
								AND TPGF.intLeagueID				 = CurrentFrameThrow1.intLeagueID
								AND TPGF.intTeamID					 = CurrentFrameThrow1.intTeamID
								AND TPGF.intPlayerID				 = CurrentFrameThrow1.intPlayerID
								AND TPGF.intGameIndex				 = CurrentFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex				 = CurrentFrameThrow1.intWeekIndex
								AND TPGF.intFrameIndex				 = CurrentFrameThrow1.intFrameIndex
								AND CurrentFrameThrow1.intThrowIndex = 1 
								)

							INNER JOIN TPlayerGameFrameThrows AS CurrentFrameThrow2
							ON(		TPGF.intYearID					 = CurrentFrameThrow2.intYearID
								AND TPGF.intLeagueID				 = CurrentFrameThrow2.intLeagueID
								AND TPGF.intTeamID					 = CurrentFrameThrow2.intTeamID
								AND TPGF.intPlayerID				 = CurrentFrameThrow2.intPlayerID
								AND TPGF.intGameIndex				 = CurrentFrameThrow2.intGameIndex
								AND TPGF.intWeekIndex				 = CurrentFrameThrow2.intWeekIndex
								AND TPGF.intFrameIndex				 = CurrentFrameThrow2.intFrameIndex
								AND CurrentFrameThrow2.intThrowIndex = 2 
								)

							INNER JOIN TPlayerGameFrameThrows AS NextFrameThrow1
							ON(		TPGF.intYearID				  = NextFrameThrow1.intYearID
								AND TPGF.intLeagueID			  = NextFrameThrow1.intLeagueID
								AND TPGF.intTeamID				  = NextFrameThrow1.intTeamID
								AND TPGF.intPlayerID			  = NextFrameThrow1.intPlayerID
								AND TPGF.intGameIndex			  = NextFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex			  = NextFrameThrow1.intWeekIndex
								AND (TPGF.intFrameIndex + 1)	  = NextFrameThrow1.intFrameIndex
								AND NextFrameThrow1.intThrowIndex = 1 
								)

						ON(		TPG.intYearID    = TPGF.intYearID
							AND TPG.intLeagueID  = TPGF.intLeagueID
							AND TPG.intTeamID    = TPGF.intTeamID
							AND TPG.intPlayerID  = TPGF.intPlayerID
							AND TPG.intGameIndex = TPGF.intGameIndex
							AND TPG.intWeekIndex = TPGF.intWeekIndex 
							)

					ON(		TPG.intYearID    = TPGF.intYearID
						AND TPG.intLeagueID  = TPGF.intLeagueID
						AND TPG.intTeamID    = TPGF.intTeamID
						AND TPG.intPlayerID  = TPGF.intPlayerID
						AND TPG.intGameIndex = TPGF.intGameIndex
						AND TPG.intWeekIndex = TPGF.intWeekIndex 
						)

				ON(		TYLTP.intYearID   = TPG.intYearID
					AND TYLTP.intLeagueID = TPG.intLeagueID
					AND TYLTP.intTeamID   = TPG.intTeamID
					AND TYLTP.intPlayerID = TPG.intPlayerID 
					)

			ON(		TYLT.intYearID = TYLTP.intYearID
				AND TYLT.intLeagueID = TYLTP.intLeagueID
				AND TYLT.intTeamID = TYLTP.intTeamID 
				)
				
		ON(		TYL.intYearID = TYLT.intYearID
			AND TYL.intLeagueID = TYLT.intLeagueID 
			)

WHERE
		CurrentFrameThrow1.intPinCount + CurrentFrameThrow2.intPinCount = 10
	AND CurrentFrameThrow1.intPinCount <> 10
	AND CurrentFrameThrow1.intFrameIndex <> 10
	And strYear = 2011
	
GROUP BY
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName
	,TP.strFirstName
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex

GO

-- SELECT * FROM VGameSpareScore

-- --------------------------------------------------------------------------------
-- Create view for strike when the next throw is not a strike -- we must now go to
-- the next frame and get the next two throws in that frame, so we can get the bonus 
-- pin count.  Wow my head hurts. 
-- --------------------------------------------------------------------------------
 GO

 CREATE VIEW VGameStrikeNextThrowNoStrike
 AS

 SELECT
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName + ', ' + TP.strFirstName AS strPlayer
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex
	,ISNULL( SUM( NextFrameThrow1.intPinCount + NextFrameThrow2.intPinCount ), 0 ) 
				 AS intGameStrikeNextThrowNoStrike
FROM
	TYears AS TY

		INNER JOIN TYearLeagues AS TYL

			INNER JOIN TLeagues AS TL
			ON( TYL.intLeagueID = TL.intLeagueID )

			INNER JOIN TYearLeagueTeams AS TYLT

				INNER JOIN TTeams AS TT
				ON( TYLT.intTeamID = TT.intTeamID )

				INNER JOIN TYearLeagueTeamPlayers AS TYLTP

					INNER JOIN TPlayers AS TP
					ON( TYLTP.intPlayerID = TP.intPlayerID )

					INNER JOIN TPlayerGames AS TPG

						INNER JOIN TYearLeagueTeamGames AS TYLTG
						ON(		TPG.intYearID	 = TYLTG.intYearID
							AND TPG.intLeagueID	 = TYLTG.intLeagueID
							AND TPG.intTeamID	 = TYLTG.intTeamID
							AND TPG.intGameIndex = TYLTG.intGameIndex
							AND TPG.intWeekIndex = TYLTG.intWeekIndex 
							)

						INNER JOIN TPlayerGameFrames AS TPGF
						
							INNER JOIN TPlayerGameFrameThrows AS CurrentFrameThrow1
							ON(		TPGF.intYearID					 = CurrentFrameThrow1.intYearID
								AND TPGF.intLeagueID				 = CurrentFrameThrow1.intLeagueID
								AND TPGF.intTeamID					 = CurrentFrameThrow1.intTeamID
								AND TPGF.intPlayerID				 = CurrentFrameThrow1.intPlayerID
								AND TPGF.intGameIndex				 = CurrentFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex				 = CurrentFrameThrow1.intWeekIndex
								AND TPGF.intFrameIndex				 = CurrentFrameThrow1.intFrameIndex
								AND CurrentFrameThrow1.intThrowIndex = 1 
								)

							INNER JOIN TPlayerGameFrameThrows AS NextFrameThrow1
							ON(		TPGF.intYearID				  = NextFrameThrow1.intYearID
								AND TPGF.intLeagueID			  = NextFrameThrow1.intLeagueID
								AND TPGF.intTeamID				  = NextFrameThrow1.intTeamID
								AND TPGF.intPlayerID			  = NextFrameThrow1.intPlayerID
								AND TPGF.intGameIndex			  = NextFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex			  = NextFrameThrow1.intWeekIndex
								AND (TPGF.intFrameIndex + 1)	  = NextFrameThrow1.intFrameIndex
								AND NextFrameThrow1.intThrowIndex = 1 
								)

							INNER JOIN TPlayerGameFrameThrows AS NextFrameThrow2
							ON(		TPGF.intYearID				  = NextFrameThrow2.intYearID
								AND TPGF.intLeagueID			  = NextFrameThrow2.intLeagueID
								AND TPGF.intTeamID				  = NextFrameThrow2.intTeamID
								AND TPGF.intPlayerID			  = NextFrameThrow2.intPlayerID
								AND TPGF.intGameIndex			  = NextFrameThrow2.intGameIndex
								AND TPGF.intWeekIndex			  = NextFrameThrow2.intWeekIndex
								AND (TPGF.intFrameIndex + 1)	  = NextFrameThrow2.intFrameIndex
								AND NextFrameThrow2.intThrowIndex = 2 
								)

						ON(		TPG.intYearID    = TPGF.intYearID
							AND TPG.intLeagueID  = TPGF.intLeagueID
							AND TPG.intTeamID    = TPGF.intTeamID
							AND TPG.intPlayerID  = TPGF.intPlayerID
							AND TPG.intGameIndex = TPGF.intGameIndex
							AND TPG.intWeekIndex = TPGF.intWeekIndex 
							)

					ON(		TPG.intYearID    = TPGF.intYearID
						AND TPG.intLeagueID  = TPGF.intLeagueID
						AND TPG.intTeamID    = TPGF.intTeamID
						AND TPG.intPlayerID  = TPGF.intPlayerID
						AND TPG.intGameIndex = TPGF.intGameIndex
						AND TPG.intWeekIndex = TPGF.intWeekIndex 
						)

				ON(		TYLTP.intYearID   = TPG.intYearID
					AND TYLTP.intLeagueID = TPG.intLeagueID
					AND TYLTP.intTeamID   = TPG.intTeamID
					AND TYLTP.intPlayerID = TPG.intPlayerID 
					)

			ON(		TYLT.intYearID = TYLTP.intYearID
				AND TYLT.intLeagueID = TYLTP.intLeagueID
				AND TYLT.intTeamID = TYLTP.intTeamID 
				)
				
		ON(		TYL.intYearID = TYLT.intYearID
			AND TYL.intLeagueID = TYLT.intLeagueID 
			)
	
WHERE
		CurrentFrameThrow1.intPinCount = 10
	AND NextFrameThrow1.intPinCount <> 10
	AND CurrentFrameThrow1.intFrameIndex <> 10
	And strYear = 2011
	
GROUP BY
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName
	,TP.strFirstName
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex

GO  

-- SELECT * FROM VGameStrikeNextThrowNoStrike

-- --------------------------------------------------------------------------------
-- Create view for strike when the next throw is a strike -- we must now go to
-- the next frame and get the strike in that frame, then go to the next frame and get 
-- the first throw so we can get the bonus pin count. 
-- This will not work for the ninth and tenth frame -- WHY? Not enough frames left. 
-- Praise God for everyone who has helped me to understand this project. 
-- --------------------------------------------------------------------------------
 GO

 CREATE VIEW VGameStrikeNextThrowStrikePlusNextThrow
 AS

 SELECT
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName + ', ' + TP.strFirstName AS strPlayer
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex
	,ISNULL( SUM( NextFrameThrow1.intPinCount + NextFollowingFrameThrow1.intPinCount ), 0 ) 
				 AS intGameStrikeNextThrowStrikePlusNextThrow
FROM
	TYears AS TY

		INNER JOIN TYearLeagues AS TYL

			INNER JOIN TLeagues AS TL
			ON( TYL.intLeagueID = TL.intLeagueID )

			INNER JOIN TYearLeagueTeams AS TYLT

				INNER JOIN TTeams AS TT
				ON( TYLT.intTeamID = TT.intTeamID )

				INNER JOIN TYearLeagueTeamPlayers AS TYLTP

					INNER JOIN TPlayers AS TP
					ON( TYLTP.intPlayerID = TP.intPlayerID )

					INNER JOIN TPlayerGames AS TPG

						INNER JOIN TYearLeagueTeamGames AS TYLTG
						ON(		TPG.intYearID	 = TYLTG.intYearID
							AND TPG.intLeagueID	 = TYLTG.intLeagueID
							AND TPG.intTeamID	 = TYLTG.intTeamID
							AND TPG.intGameIndex = TYLTG.intGameIndex
							AND TPG.intWeekIndex = TYLTG.intWeekIndex 
							)

						INNER JOIN TPlayerGameFrames AS TPGF
						
							INNER JOIN TPlayerGameFrameThrows AS CurrentFrameThrow1
							ON(		TPGF.intYearID					 = CurrentFrameThrow1.intYearID
								AND TPGF.intLeagueID				 = CurrentFrameThrow1.intLeagueID
								AND TPGF.intTeamID					 = CurrentFrameThrow1.intTeamID
								AND TPGF.intPlayerID				 = CurrentFrameThrow1.intPlayerID
								AND TPGF.intGameIndex				 = CurrentFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex				 = CurrentFrameThrow1.intWeekIndex
								AND TPGF.intFrameIndex				 = CurrentFrameThrow1.intFrameIndex
								AND CurrentFrameThrow1.intThrowIndex = 1 
								)

							INNER JOIN TPlayerGameFrameThrows AS NextFrameThrow1
							ON(		TPGF.intYearID				  = NextFrameThrow1.intYearID
								AND TPGF.intLeagueID			  = NextFrameThrow1.intLeagueID
								AND TPGF.intTeamID				  = NextFrameThrow1.intTeamID
								AND TPGF.intPlayerID			  = NextFrameThrow1.intPlayerID
								AND TPGF.intGameIndex			  = NextFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex			  = NextFrameThrow1.intWeekIndex
								AND (TPGF.intFrameIndex + 1)	  = NextFrameThrow1.intFrameIndex
								AND NextFrameThrow1.intThrowIndex = 1 
								)

							INNER JOIN TPlayerGameFrameThrows AS NextFollowingFrameThrow1
							ON(		TPGF.intYearID						   = NextFollowingFrameThrow1.intYearID
								AND TPGF.intLeagueID					   = NextFollowingFrameThrow1.intLeagueID
								AND TPGF.intTeamID						   = NextFollowingFrameThrow1.intTeamID
								AND TPGF.intPlayerID					   = NextFollowingFrameThrow1.intPlayerID
								AND TPGF.intGameIndex					   = NextFollowingFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex					   = NextFollowingFrameThrow1.intWeekIndex
								AND (TPGF.intFrameIndex + 2)			   = NextFollowingFrameThrow1.intFrameIndex
								AND NextFollowingFrameThrow1.intThrowIndex = 1 
								)

						ON(		TPG.intYearID    = TPGF.intYearID
							AND TPG.intLeagueID  = TPGF.intLeagueID
							AND TPG.intTeamID    = TPGF.intTeamID
							AND TPG.intPlayerID  = TPGF.intPlayerID
							AND TPG.intGameIndex = TPGF.intGameIndex
							AND TPG.intWeekIndex = TPGF.intWeekIndex 
							)

					ON(		TPG.intYearID    = TPGF.intYearID
						AND TPG.intLeagueID  = TPGF.intLeagueID
						AND TPG.intTeamID    = TPGF.intTeamID
						AND TPG.intPlayerID  = TPGF.intPlayerID
						AND TPG.intGameIndex = TPGF.intGameIndex
						AND TPG.intWeekIndex = TPGF.intWeekIndex 
						)

				ON(		TYLTP.intYearID   = TPG.intYearID
					AND TYLTP.intLeagueID = TPG.intLeagueID
					AND TYLTP.intTeamID   = TPG.intTeamID
					AND TYLTP.intPlayerID = TPG.intPlayerID 
					)

			ON(		TYLT.intYearID = TYLTP.intYearID
				AND TYLT.intLeagueID = TYLTP.intLeagueID
				AND TYLT.intTeamID = TYLTP.intTeamID 
				)
				
		ON(		TYL.intYearID = TYLT.intYearID
			AND TYL.intLeagueID = TYLT.intLeagueID 
			)
	
WHERE
		CurrentFrameThrow1.intPinCount = 10
	AND NextFrameThrow1.intPinCount = 10
	AND CurrentFrameThrow1.intFrameIndex < 9
	And strYear = 2011
	
GROUP BY
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName
	,TP.strFirstName
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex

GO  

-- SELECT * FROM VGameStrikeNextThrowStrikePlusNextThrow

-- --------------------------------------------------------------------------------
-- Create view for a strike in the ninth frame and strike in the tenth. 
-- Remember we are only getting bonus pins.
-- --------------------------------------------------------------------------------
 GO

 CREATE VIEW VGameStrikeInNinthNextThrowStrike
 AS

 SELECT
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName + ', ' + TP.strFirstName AS strPlayer
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex
	,ISNULL( SUM( TenthFrameThrow1.intPinCount + TenthFrameThrow2.intPinCount ), 0 ) 
				 AS intGameStrikeInNinthNextThrowStrike
FROM
	TYears AS TY

		INNER JOIN TYearLeagues AS TYL

			INNER JOIN TLeagues AS TL
			ON( TYL.intLeagueID = TL.intLeagueID )

			INNER JOIN TYearLeagueTeams AS TYLT

				INNER JOIN TTeams AS TT
				ON( TYLT.intTeamID = TT.intTeamID )

				INNER JOIN TYearLeagueTeamPlayers AS TYLTP

					INNER JOIN TPlayers AS TP
					ON( TYLTP.intPlayerID = TP.intPlayerID )

					INNER JOIN TPlayerGames AS TPG

						INNER JOIN TYearLeagueTeamGames AS TYLTG
						ON(		TPG.intYearID	 = TYLTG.intYearID
							AND TPG.intLeagueID	 = TYLTG.intLeagueID
							AND TPG.intTeamID	 = TYLTG.intTeamID
							AND TPG.intGameIndex = TYLTG.intGameIndex
							AND TPG.intWeekIndex = TYLTG.intWeekIndex 
							)

						INNER JOIN TPlayerGameFrames AS TPGF
						
							INNER JOIN TPlayerGameFrameThrows AS NinthFrameThrow1
							ON(		TPGF.intYearID				   = NinthFrameThrow1.intYearID
								AND TPGF.intLeagueID			   = NinthFrameThrow1.intLeagueID
								AND TPGF.intTeamID				   = NinthFrameThrow1.intTeamID
								AND TPGF.intPlayerID			   = NinthFrameThrow1.intPlayerID
								AND TPGF.intGameIndex			   = NinthFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex			   = NinthFrameThrow1.intWeekIndex
								AND TPGF.intFrameIndex			   = NinthFrameThrow1.intFrameIndex
								AND NinthFrameThrow1.intThrowIndex = 1 
								)

							INNER JOIN TPlayerGameFrameThrows AS TenthFrameThrow1
							ON(		TPGF.intYearID				   = TenthFrameThrow1.intYearID
								AND TPGF.intLeagueID			   = TenthFrameThrow1.intLeagueID
								AND TPGF.intTeamID				   = TenthFrameThrow1.intTeamID
								AND TPGF.intPlayerID			   = TenthFrameThrow1.intPlayerID
								AND TPGF.intGameIndex			   = TenthFrameThrow1.intGameIndex
								AND TPGF.intWeekIndex			   = TenthFrameThrow1.intWeekIndex
								AND (TPGF.intFrameIndex + 1)	   = TenthFrameThrow1.intFrameIndex
								AND TenthFrameThrow1.intThrowIndex = 1 
								)

							INNER JOIN TPlayerGameFrameThrows AS TenthFrameThrow2
							ON(		TPGF.intYearID				   = TenthFrameThrow2.intYearID
								AND TPGF.intLeagueID			   = TenthFrameThrow2.intLeagueID
								AND TPGF.intTeamID				   = TenthFrameThrow2.intTeamID
								AND TPGF.intPlayerID			   = TenthFrameThrow2.intPlayerID
								AND TPGF.intGameIndex			   = TenthFrameThrow2.intGameIndex
								AND TPGF.intWeekIndex			   = TenthFrameThrow2.intWeekIndex
								AND (TPGF.intFrameIndex + 1)	   = TenthFrameThrow2.intFrameIndex
								AND TenthFrameThrow2.intThrowIndex = 2 
								)

						ON(		TPG.intYearID    = TPGF.intYearID
							AND TPG.intLeagueID  = TPGF.intLeagueID
							AND TPG.intTeamID    = TPGF.intTeamID
							AND TPG.intPlayerID  = TPGF.intPlayerID
							AND TPG.intGameIndex = TPGF.intGameIndex
							AND TPG.intWeekIndex = TPGF.intWeekIndex 
							)

					ON(		TPG.intYearID    = TPGF.intYearID
						AND TPG.intLeagueID  = TPGF.intLeagueID
						AND TPG.intTeamID    = TPGF.intTeamID
						AND TPG.intPlayerID  = TPGF.intPlayerID
						AND TPG.intGameIndex = TPGF.intGameIndex
						AND TPG.intWeekIndex = TPGF.intWeekIndex 
						)

				ON(		TYLTP.intYearID   = TPG.intYearID
					AND TYLTP.intLeagueID = TPG.intLeagueID
					AND TYLTP.intTeamID   = TPG.intTeamID
					AND TYLTP.intPlayerID = TPG.intPlayerID 
					)

			ON(		TYLT.intYearID = TYLTP.intYearID
				AND TYLT.intLeagueID = TYLTP.intLeagueID
				AND TYLT.intTeamID = TYLTP.intTeamID 
				)
				
		ON(		TYL.intYearID = TYLT.intYearID
			AND TYL.intLeagueID = TYLT.intLeagueID 
			)
	
WHERE
		NinthFrameThrow1.intFrameIndex = 9
	AND NinthFrameThrow1.intPinCount   = 10
	AND TenthFrameThrow1.intPinCount   = 10
	And strYear = 2011
	
GROUP BY
	 TY.intYearID
	,TY.strYear
	,TL.intLeagueID
	,TL.strLeague
	,TT.intTeamID
	,TT.strTeam
	,TP.intPlayerID
	,TP.strLastName
	,TP.strFirstName
	,TYLTG.intGameIndex	
	,TYLTG.intWeekIndex

GO

-- SELECT * FROM VGameStrikeInNinthNextThrowStrike  

-- --------------------------------------------------------------------------------
-- Create view for the final score.  Show all the final scores for each player game,
-- by player, by team, by league, by year and week.
-- --------------------------------------------------------------------------------
GO

CREATE VIEW VGameFinalScore
AS

SELECT
	 VGPCS.intYearID
	,VGPCS.strYear
	,VGPCS.intLeagueID
	,VGPCS.strLeague
	,VGPCS.intTeamID
	,VGPCS.strTeam
	,VGPCS.intPlayerID
	,VGPCS.strPlayer
	,VGPCS.intGameIndex
	,VGPCS.intWeekIndex
	,ISNULL( SUM( ISNULL( VGPCS.intGamePinCountScore, 0 )
				+ ISNULL( VGSS.intGameSpareScore, 0 )
				+ ISNULL( VGSNTNS.intGameStrikeNextThrowNoStrike, 0 )
				+ ISNULL( VGSNTSPNT.intGameStrikeNextThrowStrikePlusNextThrow, 0 )
				+ ISNULL( VGSINNTS.intGameStrikeInNinthNextThrowStrike, 0 )), 0 ) AS intGameFinalScore
FROM
	VGamePinCountScore AS VGPCS
		
		LEFT OUTER JOIN VGameSpareScore AS VGSS
		ON(		VGPCS.intYearID    = VGSS.intYearID
			AND VGPCS.intLeagueID  = VGSS.intLeagueID
			AND VGPCS.intTeamID    = VGSS.intTeamID
			AND VGPCS.intPlayerID  = VGSS.intPlayerID
			AND VGPCS.intGameIndex = VGSS.intGameIndex
			AND VGPCS.intWeekIndex = VGSS.intWeekIndex
			)

		LEFT OUTER JOIN VGameStrikeNextThrowNoStrike AS VGSNTNS
		ON(		VGPCS.intYearID    = VGSNTNS.intYearID
			AND VGPCS.intLeagueID  = VGSNTNS.intLeagueID
			AND VGPCS.intTeamID    = VGSNTNS.intTeamID
			AND VGPCS.intPlayerID  = VGSNTNS.intPlayerID
			AND VGPCS.intGameIndex = VGSNTNS.intGameIndex
			AND VGPCS.intWeekIndex = VGSNTNS.intWeekIndex
			)

		LEFT OUTER JOIN VGameStrikeNextThrowStrikePlusNextThrow AS VGSNTSPNT
		ON(		VGPCS.intYearID    = VGSNTSPNT.intYearID
			AND VGPCS.intLeagueID  = VGSNTSPNT.intLeagueID
			AND VGPCS.intTeamID    = VGSNTSPNT.intTeamID
			AND VGPCS.intPlayerID  = VGSNTSPNT.intPlayerID
			AND VGPCS.intGameIndex = VGSNTSPNT.intGameIndex
			AND VGPCS.intWeekIndex = VGSNTSPNT.intWeekIndex
			)

		LEFT OUTER JOIN VGameStrikeInNinthNextThrowStrike AS VGSINNTS
		ON(		VGPCS.intYearID    = VGSINNTS.intYearID
			AND VGPCS.intLeagueID  = VGSINNTS.intLeagueID
			AND VGPCS.intTeamID    = VGSINNTS.intTeamID
			AND VGPCS.intPlayerID  = VGSINNTS.intPlayerID
			AND VGPCS.intGameIndex = VGSINNTS.intGameIndex
			AND VGPCS.intWeekIndex = VGSINNTS.intWeekIndex
			)

GROUP BY
	 VGPCS.intYearID
	,VGPCS.strYear
	,VGPCS.intLeagueID
	,VGPCS.strLeague
	,VGPCS.intTeamID
	,VGPCS.strTeam
	,VGPCS.intPlayerID
	,VGPCS.strPlayer
	,VGPCS.intGameIndex
	,VGPCS.intWeekIndex
	
	GO	
	
	-- Show the scores --
SELECT 'STEP 3 show final score'
SELECT
	*
FROM
	VGameFinalScore
ORDER BY
	 strYear
	,strLeague
	,strTeam
	,strPlayer	
	
-- --------------------------------------------------------------------------------
-- Step 4: Show the top ten players and their team for each league for the 2011 
-- playing season, including their rank, ordered from 1st - 10th
-- --------------------------------------------------------------------------------
GO
CREATE VIEW VTopTenPlayers
AS
SELECT
	TTopTenAveragePlayerLeagueScores.*
FROM
	(
		SELECT
			 VGFS.intYearID
			,VGFS.strYear
			,VGFS.intLeagueID
			,VGFS.strLeague
			,VGFS.intTeamID
			,VGFS.strTeam
			,VGFS.intPlayerID
			,VGFS.strPlayer
			,ISNULL( SUM( VGFS.intGameFinalScore ), 0 ) AS intGameTotalScores
			,RANK( ) OVER
				(
					PARTITION BY
						VGFS.intLeagueID
					ORDER BY
						SUM( VGFS.intGameFinalScore  ) DESC
				) AS intAverageScoreRankOrder		
		FROM
			VGameFinalScore AS VGFS
				

					INNER JOIN TYearLeagueTeamPlayers AS TYLTP
					ON(		VGFS.intYearID	  = TYLTP.intYearID
						AND VGFS.intLeagueID  = TYLTP.intLeagueID
						AND VGFS.intTeamID	  = TYLTP.intTeamID

						)

					INNER JOIN TPlayerGames AS TPG
					ON(		VGFS.intYearID    = TPG.intYearID
						AND VGFS.intLeagueID  = TPG.intLeagueID
						AND VGFS.intTeamID    = TPG.intTeamID
						AND VGFS.intPlayerID  = TPG.intPlayerID
						AND VGFS.intGameIndex = TPG.intGameIndex
						AND VGFS.intWeekIndex = TPG.intWeekIndex 
						)

		GROUP BY
			 VGFS.intYearID
			,VGFS.strYear
			,VGFS.intLeagueID
			,VGFS.strLeague
			,VGFS.intTeamID
			,VGFS.strTeam
			,VGFS.intPlayerID
			,VGFS.strPlayer
	) AS TTopTenAveragePlayerLeagueScores

WHERE
		intAverageScoreRankOrder <= 10
	AND strYear Like '2011'
GO	

SELECT 'STEP 4 show rank'
SELECT
	*
FROM
	VTopTenPlayers
ORDER BY
	 strLeague
	,intAverageScoreRankOrder