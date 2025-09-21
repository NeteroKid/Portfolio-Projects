-- Create The Table
create table epl_players 
		(ID	serial primary key,
		Player	Varchar(100),
		Nation	Varchar(3),
		Pos   	Varchar(30),
		TEAM	Varchar(30),
		Age	        int,
		Born_Year	int,
		MP	        int,
		Starts	    int,
		Minutes     int ,     
		num_90s	   FLOAT,
		Goals     	int,
		assists			int,
		pen_goals		int,
		pen		int,
		CrdY		int,
		CrdR		int,
		xG			FLOAT,
		npxG		FLOAT,
		xAG			FLOAT,
		no_pen_xG_xAG	FLOAT,
		PrgC		int,
		PrgP		int,
		PrgR		int,
		Gls_90			FLOAT,
		Ast_90			FLOAT,
		Gls_Ast_90		FLOAT,
		pen_goals_90		FLOAT,
		pen_90		FLOAT,
		xG_90			FLOAT,
		xAG_90			FLOAT,
		xG_xAG_90		FLOAT,
		no_pen_xG_90		FLOAT,
		no_pen_xG_xAG_90 	FLOAT
		);

-- Explore The Table After Importing The Data
select * from epl_players;

--- Cleaning The Table
 select *
 from epl_players
 where id is null
or
 player is null
or
 nation is null
or 
 pos is null
or
 team is null
or 
 age is null
or 
 born_year is null
or
 mp is null
or
starts is null
or
minutes is null
or
num_90s is null
or
goals is null
or
assists is null
or
pen_goals is null
or
pen is null
or
crdy is null
or
crdr is null
or
xg is null
or
npxg is null
or
xag is null
or
no_pen_xg_xag is null
or 
prgc is null
or
prgp is null
or
prgr is null
or
gls_90 is null
or
ast_90 is null
or
gls_ast_90 is null
or
pen_goals_90 is null
or
pen_90 is null
or
xg_90 is null
or
xag_90 is null
or
xg_xag_90 is null
or
no_pen_xg_90 is null
or
no_pen_xg_xag_90 is null;

SELECT player, team
FROM epl_players
WHERE player ~ '[?!@/()01#<>~^*•%©]';

--- fixing problems
update epl_players
set nation = case id 
			when 18 then 'ENG'
			WHEN 172 THEN 'ENG'
			WHEN 328 THEN 'ENG'
			WHEN 360 THEN 'ENG'
END,
AGE = CASE ID 
			when 18 then 18
			WHEN 172 THEN 17
			WHEN 328 THEN 17
			WHEN 360 THEN 16 
END,
BORN_YEAR = CASE ID
			when 18 then 2006
			WHEN 172 THEN 2008
			WHEN 328 THEN 2007
			WHEN 360 THEN 2009 
END
WHERE ID IN (18,172,328,360);


UPDATE epl_players
SET player = 'rayan ait nouri', player = 'nathan ake'
WHERE player = 'Rayan AÃ¯t-Nouri', player = 'Nathan AkÃ©' ;

UPDATE epl_players
SET player = 'nathan ake'
WHERE player = 'Nathan AkÃ©' ;

UPDATE epl_players
SET player = 'andre'
WHERE player = 'AndrÃ©' ;

UPDATE epl_players
SET player = 'moises caicedo'
WHERE player = 'MoisÃ©s Caicedo' ;

UPDATE epl_players
SET player = 'seamus coleman'
WHERE player = 'SÃ©amus Coleman' ;

UPDATE epl_players
SET player = 'abdoulaye doucoure'
WHERE player = 'Abdoulaye DoucourÃ©' ;

UPDATE epl_players
SET player = 'cheick doucoure'
WHERE player = 'Cheick DoucourÃ©' ;

UPDATE epl_players
SET player = 'joao felix'
WHERE player = 'JoÃ£o FÃ©lix' ;

UPDATE epl_players
SET player = 'andres garcia'
WHERE player = 'AndrÃ©s GarcÃ­a' ;

UPDATE epl_players
SET player = 'marc guehi'
WHERE player = 'Marc GuÃ©hi' ;

UPDATE epl_players
SET player = 'raul jimenez'
WHERE player = 'RaÃºl JimÃ©nez' ;

UPDATE epl_players
SET player = 'Ibrahima Konate'
WHERE player = 'Ibrahima KonatÃ©' ;

UPDATE epl_players
SET player = 'romeo lavia'
WHERE player = 'RomÃ©o Lavia' ;

UPDATE epl_players
SET player = 'andre onana'
WHERE player = 'AndrÃ© Onana' ;

UPDATE epl_players
SET player = 'jose sa'
WHERE player = 'JosÃ© SÃ¡' ;

UPDATE epl_players
SET player = 'ibrahim sangare'
WHERE player = 'Ibrahim SangarÃ©' ;

UPDATE epl_players
SET player = 'boubacar traore'
WHERE player = 'Boubacar TraorÃ©' ;

UPDATE epl_players
SET player = 'adama traore'
WHERE player = 'Adama TraorÃ©' ;

UPDATE epl_players
SET player = 'boubakary soumare'
WHERE player = 'Boubakary SoumarÃ©' ;

UPDATE epl_players
SET player = 'nelson semedo'
WHERE player = 'NÃ©lson Semedo' ;


-- Explore The Data After Cleaning
---1) Who's the top scorer
select player, goals
from epl_players
order by goals desc
limit 1;
---2) Goal scoring table
select player, goals, rank() over (order by goals desc)
from epl_players;
---3) the player with most assists
select player, assists
from epl_players
order by assists desc
limit 1;
---4) assists table
select player, assists, rank() over (order by assists desc)
from epl_players;
---5) who are the best overperformence players
select player, goals, xg, round((goals - xg):: numeric,1)AS goals_over_xg
from epl_players
where goals > xg and xg <>0
order by  (goals - xg) desc;
---6)team's score table
select team, sum(goals), sum(xg)
from epl_players
group by team
order by sum(goals)desc;
---7)nation's representation in EPL
select COALESCE(nation, 'TOTAL') AS nation,
count(player) as total_players,
count(player) * 100/(select count(player) from epl_players) as percentage
from epl_players
group by ROLLUP (nation)
ORDER BY GROUPING(nation) ASC, total_players DESC;
---8)how many players born in 21st and how are they doing
select count(player) as young_players, sum(mp) as total_matches_played,
count(starts) as matches_started, round(avg(minutes),2) as avg_minutes
from epl_players
where born_year >=2000;
---9)progressive passes and progressive passes receieved for each player
select player, prgp, prgr
from epl_players
where pos like 'DF'
ORDER BY Prgp desc, prgr desc;
---10)Players Disciplinary Record
SELECT player, crdy   as yellow_cards, crdr as red_cards
from epl_players;
---11)teams Disciplinary Record
SELECT team, sum(crdy) as yellow_cards , sum(crdr) as red_cards
from epl_players
group by team;
