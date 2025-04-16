/*Deletion of volunteers who have not attended any training sessions in the past year (based on training dates)*/
DELETE FROM Volunteer
WHERE VolunteerID IN (
    SELECT V.VolunteerID
    FROM Volunteer V
    LEFT JOIN Trained T ON V.VolunteerID = T.VolunteerID
    LEFT JOIN Training TR ON T.TrainingID = TR.TrainingID
    GROUP BY V.VolunteerID
    HAVING MAX(TR.TrainingDate) IS NULL
        OR MAX(TR.TrainingDate) < (CURRENT_DATE - INTERVAL '1 year')
)
RETURNING *;



/*Deletes projects where the description contains the phrase "Post-Surgery Assistance"*/
DELETE FROM Project
WHERE ProjectID IN (
    SELECT p.ProjectID
    FROM Project p
    WHERE p.Description LIKE '%Post-Surgery Assistance%'
)
RETURNING *;


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
)
RETURNING *;

