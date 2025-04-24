-- =====================
-- Step 8 – Demonstrating ROLLBACK on the Volunteer table
-- =====================

-- Start a transaction
BEGIN;

-- Show the data before the update
SELECT VolunteerID, FirstName, LastName
FROM Volunteer
WHERE VolunteerID = 1;


-- Update the name of the volunteer with VolunteerID = 1
UPDATE Volunteer
SET FirstName = 'Yafit'
WHERE VolunteerID = 1;

-- Show the data after the update
SELECT VolunteerID, FirstName, LastName
FROM Volunteer
WHERE VolunteerID = 1;

-- Rollback the change
ROLLBACK;

-- Show the data again to confirm the rollback
SELECT VolunteerID, FirstName, LastName
FROM Volunteer
WHERE VolunteerID = 1;


-- =====================
-- Step 9 – Demonstrating COMMIT on the Volunteer table
-- =====================

-- Start a new transaction
BEGIN;

-- Update the name again
UPDATE Volunteer
SET FirstName = 'Avital'
WHERE VolunteerID = 1;

-- Show the data after the update
SELECT VolunteerID, FirstName, LastName
FROM Volunteer
WHERE VolunteerID = 1;

-- Commit the change
COMMIT;

-- Show the data again to confirm the change is saved
SELECT VolunteerID, FirstName, LastName
FROM Volunteer
WHERE VolunteerID = 1;
