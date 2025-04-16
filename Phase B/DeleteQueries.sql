/*We delete volunteers who have not been assigned to any projects in the past year.
A LEFT JOIN is used to include even those who were never assigned at all.
Filtering is done by year using EXTRACT(YEAR FROM ...).
An IN clause with a subquery is used to identify the relevant volunteers.*/
DELETE FROM Volunteer
WHERE VolunteerID IN (
    SELECT V.VolunteerID
    FROM Volunteer V
    LEFT JOIN AssignedTo A ON V.VolunteerID = A.VolunteerID
    LEFT JOIN Project P ON A.ProjectID = P.ProjectID
    WHERE A.ProjectID IS NULL
       OR EXTRACT(YEAR FROM P.EndDate) < EXTRACT(YEAR FROM CURRENT_DATE)
);



/*The query deletes all trainings that are scheduled in the year 2024
uses EXTRACT(YEAR FROM date) to filter dates by year.
Suitable for an interface that needs to clean outdated data (such as a training management GUI).*/
DELETE FROM Training
WHERE EXTRACT(YEAR FROM TrainingDate) = 2024;



/*Deletion of shifts in February that had no volunteers assigned to them.
Includes filtering by month using EXTRACT(MONTH...), grouping (GROUP BY), and a count condition (HAVING COUNT = 0).
This is a complex query that joins three tables and produces a result that cannot be understood by looking at
a single table in isolation.*/
DELETE FROM Shift
WHERE ShiftID IN (
    SELECT S.ShiftID
    FROM Shift S
    LEFT JOIN WorksIn W ON S.ShiftID = W.ShiftID
    WHERE EXTRACT(MONTH FROM S.ShiftDate) = 2
    GROUP BY S.ShiftID
    HAVING COUNT(W.VolunteerID) = 0
);

