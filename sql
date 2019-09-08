CREATE DATABASE IF NOT EXISTS summit DEFAULT CHARSET = UTF8MB4;

USE summit;
CREATE TABLE california
SELECT cr.student_id AS 'ST_NUMBER', cr.local_student_id AS 'ST_ID', cd.has_iep AS IEP, cd.combined_race_ethnicity AS RACE,
cd.gender AS GENDER, cr.site_name AS WEBSITE, cr.last_name AS 'LAST_NAME', cr.first_name AS 'FIRST_NAME', cr.grade AS GRADE
FROM ca_demographics AS cd
JOIN ca_roster AS cr
ON cd.student_id = cr.student_id;

CREATE TABLE washington
SELECT wr.STUDENT_NUMBER AS 'ST_NUMBER', wr.ID AS 'ST_ID', wd.IEP, wd.RACE_ETHNICITY AS RACE,
wd.GENDER, wr.NAME AS WEBSITE, wr.LAST_NAME AS 'LAST_NAME', wr.FIRST_NAME AS 'FIRST_NAME', wr.GRADE_LEVEL AS GRADE
FROM wa_demographics AS wd
JOIN wa_roster AS wr
ON wd.ID = wr.ID;

INSERT INTO california (ST_NUMBER, ST_ID, IEP, RACE, GENDER, WEBSITE, LAST_NAME, FIRST_NAME, GRADE)
SELECT *
FROM washington;

UPDATE california SET IEP = 0 WHERE IEP = 'FALSE';
UPDATE california SET IEP = 1 WHERE IEP = 'TRUE';
UPDATE california SET RACE = 'Black or African American' WHERE RACE = 'Black';
UPDATE california SET RACE = 'Native Hawaiian or Other Pacific Islander' WHERE RACE = 'Pacific Islander';
SELECT * FROM california
ORDER BY ST_NUMBER;

CREATE TABLE uniqueid
SELECT CONCAT(ST_NUMBER, ST_ID) AS 'UNIQUE_ID', IEP, RACE, GENDER, WEBSITE, LAST_NAME, FIRST_NAME, GRADE
FROM california;

SELECT * FROM uniqueid;

-- QA --
SELECT UNIQUE_ID, COUNT(UNIQUE_ID) 
FROM uniqueid
GROUP BY UNIQUE_ID
HAVING COUNT(UNIQUE_ID)>0;

SELECT RACE, COUNT(RACE)
FROM uniqueid
GROUP BY RACE;

SELECT IEP, COUNT(IEP)
FROM uniqueid
GROUP BY IEP;
