---1. All Viewership Columns
SELECT 
v.UserID0,
v.Channel2,
v.RecordDate2,
v.`Duration 2`,

---2. All User Profiles
u.Name,
u.Surname,
u.Email,
u.Gender,
u.Race,
u.Age,
u.Province,
u.`Social Media Handle`,

---3. Classification of Age
CASE
 WHEN u.Age >50 THEN 'Senior'
 WHEN u.Age BETWEEN 30 AND 49 THEN 'Adult'
 WHEN u.Age BETWEEN 20 AND 29 THEN 'Young_Adult'
 WHEN u.Age BETWEEN 12 AND 19 THEN 'Teenager'
 ELSE 'Child'
 END AS Age_Classification,

 ---4. Name of Days,Months and Time Watched
DATE_FORMAT(v.RecordDate2, 'yyyy-MM-dd') AS DATE,
DATE_FORMAT(v.RecordDate2, 'HH:mm:ss') AS TIme
FROM workspace.default.viewership v
LEFT JOIN workspace.default.user_profiles u
ON v.UserID0 = u.UserID;




---5. Time took to watch the channel - program

SELECT v.UserID0, u.Name, u.Surname, date_format(v.`Duration 2`,'HH:mm:ss') AS How_Long
FROM workspace.default.viewership v
LEFT JOIN workspace.default.user_profiles u
ON v.UserID0 = u.UserID;




--- 6. CASE STATEMENT of how long the channel is watched

SELECT v.UserID0, u.Name, u.Surname,
 CASE
  WHEN date_format(v.`Duration 2`,'HH:mm:ss') BETWEEN '00:00:00' AND '00:09:59' THEN 'Too Short'
  WHEN date_format(v.`Duration 2`,'HH:mm:ss') BETWEEN '00:10:00' AND '00:19:59' THEN 'Moderate'
  WHEN date_format(v.`Duration 2`,'HH:mm:ss') BETWEEN '00:20:00' AND '00:59:59' THEN 'Satisfactory'
  ELSE 'Outstanding'
  END AS Duration_Category
  FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID;




--- 7. Provinces where BrighTV is watched

SELECT v.UserID0, u.Name, u.Surname,
CASE
 WHEN LOWER(TRIM(u.Province)) IN ('g','gauteng') THEN 'Gautemg'
 WHEN LOWER(TRIM(u.Province)) IN ('l','limpopo') THEN 'Limpopo'
 WHEN LOWER(TRIM(u.Province)) IN ('ec','eastern cape') THEN 'Eastern Cape'
 WHEN LOWER(TRIM(u.Province)) IN ('kn','kwazulu natal') THEN 'Kwazulu Natal'
 WHEN LOWER(TRIM(u.Province)) IN ('wc','western cape') THEN 'Western Cape'
 WHEN LOWER(TRIM(u.Province)) IN ('fs','free state') THEN 'Free Stata'
 WHEN LOWER(TRIM(u.Province)) IN ('nc','northern cape') THEN 'Northern Cape'
 WHEN LOWER(TRIM(u.Province)) IN ('mp','mpumalanga') THEN 'Mpumalanga'
 ELSE 'Not Specified'
 END AS Province_F
FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID;




---8. The Most Channel watched 

SELECT v.channel2, COUNT(v.Channel2) AS Most_Watched_Channel
FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID
GROUP BY v.Channel2 
ORDER BY Most_Watched_Channel DESC;




---9. Convert time Record2

SELECT 
  from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg') AS SA_Converted_time,
  CASE
    WHEN date_format(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'), 'HH:mm:ss') BETWEEN '05:00:00' AND '11:59:59' THEN 'Morning'
    WHEN date_format(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'), 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN date_format(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg'), 'HH:mm:ss') BETWEEN '17:00:00' AND '21:59:59' THEN 'Evening'
    ELSE 'Night'
  END AS Time_Classification
FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID;



---10. Earliest and Lastest Time

 SELECT  
    MIN(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg')) AS Earliest_Time,
    MAX(from_utc_timestamp(v.RecordDate2, 'Africa/Johannesburg')) AS Latest_Time
FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID;


---10. Null for Gender

SELECT v.UserID0, u.Name, u.Surname, COALESCE(TRIM(u.Gender), 'Not Specified') AS gender_1
FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID;



---CASE STATEMENT - GENDER
SELECT v.UserID0, u.Name, u.Surname,
CASE
 WHEN LOWER(TRIM(u.Gender)) IN ('m','male') THEN 'Male'
 WHEN LOWER(TRIM(u.Gender)) IN ('f','female') THEN 'Female'
 ELSE 'Not Specified'
 END AS Gender
FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID;


---10. Null for Race

SELECT v.UserID0, u.Name, u.Surname, COALESCE(TRIM(u.Race), 'Not Specified') AS Race_1
FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID;


---CASE STATEMENT - RACE
SELECT v.UserID0, u.Name, u.Surname,
CASE
 WHEN LOWER(TRIM(u.Race)) IN ('b','Black') THEN 'Black'
 WHEN LOWER(TRIM(u.Race)) IN ('w','white') THEN 'White'
 WHEN LOWER(TRIM(u.Race)) IN ('c','coloured') THEN 'Coloured'
 WHEN LOWER(TRIM(u.Race)) IN ('I','indian_asian') THEN 'Indian_Asian'
 WHEN LOWER(TRIM(u.Race)) IN ('o','other') THEN 'Other'
 ELSE 'Not Specified'
 END AS Race
FROM workspace.default.viewership v
  LEFT JOIN workspace.default.user_profiles u
  ON v.UserID0 = u.UserID;
