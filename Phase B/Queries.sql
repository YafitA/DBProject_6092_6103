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

/* 3. Volunteers who never had any training and their managers */
SELECT
    V.VolunteerID,
    V.FirstName,
    V.LastName,
    M.FirstName || ' ' || M.LastName AS ManagerName
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
    SUM(EXTRACT(EPOCH FROM (s.EndTime - s.StartTime)) / 3600) AS TotalHours
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

/* 8. Projects that started and ended in different years, showing the duration and manager */
SELECT
    p.ProjectName,
    p.StartDate,
    p.EndDate,
    EXTRACT(YEAR FROM p.StartDate) AS StartYear,
    EXTRACT(YEAR FROM p.EndDate) AS EndYear,
    (p.EndDate - p.StartDate) AS DurationDays,
    m.FirstName || ' ' || m.LastName AS ManagerName
FROM Project p
JOIN Manager m ON p.ManagerID = m.ManagerID
WHERE EXTRACT(YEAR FROM p.StartDate) <> EXTRACT(YEAR FROM p.EndDate)
ORDER BY p.StartDate;
