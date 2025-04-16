/*
1. Extend ongoing projects by 30 days to allow for additional volunteer work.
   This only affects projects currently active (today between start and end dates).
*/

UPDATE Project
SET EndDate = EndDate + INTERVAL '30 days'
WHERE CURRENT_DATE BETWEEN StartDate AND EndDate
RETURNING ProjectID, ProjectName, StartDate, EndDate;


/*
2. Append status label to project description
   based on whether the project is already ended.
*/

UPDATE Project
SET Description = Description || ' [Closed]'
WHERE EndDate < CURRENT_DATE
RETURNING ProjectID, ProjectName, Description;


/*
3. Add "[Experienced]" tag to the Skill field
   for volunteers who participated in more than 3 projects.
*/

UPDATE Volunteer
SET Skill = Skill || ' [Experienced]'
WHERE VolunteerID IN (
    SELECT v.VolunteerID
    FROM Volunteer v
    JOIN AssignedTo a ON v.VolunteerID = a.VolunteerID
    GROUP BY v.VolunteerID
    HAVING COUNT(a.ProjectID) > 3
)
RETURNING VolunteerID, FirstName, LastName, Skill;

