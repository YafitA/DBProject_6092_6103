/* 1. List of volunteers including name, type of volunteering, name of manager,
   and number of projects assigned */
SELECT
    v.VolunteerID,
    v.FirstName || ' ' || v.LastName AS FullName,
    vt.TypeName AS VolunteerType,
    m.FirstName || ' ' || m.LastName AS ManagerName,
    COUNT(p.ProjectID) AS NumOfProjects
FROM Volunteer v
JOIN VolunteerType vt ON v.VolunteerTypeID = vt.VolunteerTypeID
JOIN Manager m ON v.ManagerID = m.ManagerID
LEFT JOIN AssignedTo a ON v.VolunteerID = a.VolunteerID
LEFT JOIN Project p ON a.ProjectID = p.ProjectID
GROUP BY v.VolunteerID, v.FirstName, v.LastName, vt.TypeName, m.FirstName, m.LastName
ORDER BY v.VolunteerID;

/* 2. Number of volunteers in each volunteer type */
SELECT
    vt.TypeName AS VolunteerType,
    COUNT(v.VolunteerID) AS VolunteerCount
FROM Volunteer v
JOIN VolunteerType vt ON v.VolunteerTypeID = vt.VolunteerTypeID
GROUP BY vt.TypeName
ORDER BY VolunteerCount DESC;

/* 3. Volunteers who never had any training and their managers name */
SELECT
    V.VolunteerID,
    V.FirstName,
    V.LastName,
    M.FirstName || ' ' || M.LastName AS ManagerName,
    M.Email AS ManagerEmail,
    M.PhoneNumber AS ManagerPhoneNumber
FROM Volunteer V
JOIN Manager M ON V.ManagerID = M.ManagerID
WHERE NOT EXISTS (
    SELECT 1 FROM Trained T WHERE T.VolunteerID = V.VolunteerID
);

/* 4. Volunteers who are currently assigned to open projects
        (projects ending in the future) */
SELECT
    v.FirstName,
    v.LastName,
    p.ProjectName,
    p.EndDate
FROM Volunteer v
JOIN AssignedTo a ON v.VolunteerID = a.VolunteerID
JOIN Project p ON a.ProjectID = p.ProjectID
WHERE p.EndDate > CURRENT_DATE
ORDER BY p.EndDate;

/* 5. Details about each project: manager, duration, volunteer count, and current status */
SELECT
    p.ProjectName,
    p.Description,
    m.FirstName || ' ' || m.LastName AS ManagerName,
    p.StartDate,
    p.EndDate,
    (p.EndDate - p.StartDate) AS DurationDays,
    CASE
        WHEN CURRENT_DATE < p.StartDate THEN 'Not Started'
        WHEN CURRENT_DATE BETWEEN p.StartDate AND p.EndDate THEN 'Active'
        ELSE 'Closed'
    END AS Status,
    COUNT(a.VolunteerID) AS VolunteerCount
FROM Project p
JOIN Manager m ON p.ManagerID = m.ManagerID
LEFT JOIN AssignedTo a ON p.ProjectID = a.ProjectID
GROUP BY
    p.ProjectID, p.ProjectName, p.Description, p.StartDate, p.EndDate, m.FirstName, m.LastName
ORDER BY p.StartDate DESC;

/* 6. Total hours volunteered per volunteer per month (based on shift durations) */
SELECT
    v.FirstName || ' ' || v.LastName AS VolunteerName,
    EXTRACT(YEAR FROM s.ShiftDate) AS Year,
    EXTRACT(MONTH FROM s.ShiftDate) AS Month,
    ROUND(
        SUM(
            EXTRACT(EPOCH FROM (
                CASE
                    WHEN s.EndTime >= s.StartTime THEN
                        (s.ShiftDate + s.EndTime) - (s.ShiftDate + s.StartTime)
                    ELSE
                        (s.ShiftDate + INTERVAL '1 day' + s.EndTime) - (s.ShiftDate + s.StartTime)
                END
            )) / 3600
        ),
        2
    ) AS TotalHours
FROM Volunteer v
JOIN WorksIn w ON v.VolunteerID = w.VolunteerID
JOIN Shift s ON w.ShiftID = s.ShiftID
GROUP BY v.VolunteerID, Year, Month
ORDER BY v.VolunteerID, Year, Month;


/* 7. Volunteers who participated in more than 2 different trainings */
SELECT
    v.VolunteerID,
    v.FirstName || ' ' || v.LastName AS VolunteerName,
    COUNT(t.TrainingID) AS TrainingCount
FROM Volunteer v
JOIN Trained t ON v.VolunteerID = t.VolunteerID
GROUP BY v.VolunteerID, v.FirstName, v.LastName
HAVING COUNT(t.TrainingID) > 2
ORDER BY TrainingCount DESC;

/*
8. Suggest trainings for volunteers who never had any training,
    only if:
    - The training date is in the future or today
    - The training does not overlap with any of the volunteer's project dates
*/
SELECT
    v.VolunteerID,
    v.FirstName || ' ' || v.LastName AS VolunteerName,
    t.TrainingID,
    t.TrainingName,
    t.TrainingDate
FROM Volunteer v
/* Combine each untrained volunteer with all available trainings */
CROSS JOIN Training t
/* Only volunteers who have never attended any training */
WHERE NOT EXISTS (
    SELECT 1
    FROM Trained tr
    WHERE tr.VolunteerID = v.VolunteerID
)
/* Exclude trainings that overlap with any project assigned to the volunteer */
AND NOT EXISTS (
    SELECT 1
    FROM AssignedTo a
    JOIN Project p ON a.ProjectID = p.ProjectID
    WHERE a.VolunteerID = v.VolunteerID
      AND t.TrainingDate BETWEEN p.StartDate AND p.EndDate
)
/* Only suggest trainings that are today or in the future */
AND t.TrainingDate >= CURRENT_DATE
/* Sort by volunteer and training date */
ORDER BY v.VolunteerID, t.TrainingDate;



/*
9.Retrieves volunteers who completed training in the last 6 months, ordered by Volunteer ID.
*/
SELECT
    V.VolunteerID,
    V.FirstName,
    V.LastName,
    V.Email,
    T.TrainingName,
    T.TrainingDate
FROM Volunteer V
JOIN Trained TR ON V.VolunteerID = TR.VolunteerID
JOIN Training T ON TR.TrainingID = T.TrainingID
WHERE T.TrainingDate >= CURRENT_DATE - INTERVAL '6 MONTH' AND  T.TrainingDate <= CURRENT_DATE
ORDER BY T.TrainingDate DESC;
