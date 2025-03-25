-- Inserting into VolunteerType
INSERT INTO VolunteerType (VolunteerTypeID, TypeName) VALUES (1, 'General');
INSERT INTO VolunteerType (VolunteerTypeID, TypeName) VALUES (2, 'Specialized');
INSERT INTO VolunteerType (VolunteerTypeID, TypeName) VALUES (3, 'Administrative');

-- Inserting into Shift
INSERT INTO Shift (ShiftID, StartTime, EndTime, ShiftDate) VALUES (1, TO_DATE('2025-04-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-01', 'YYYY-MM-DD'));
INSERT INTO Shift (ShiftID, StartTime, EndTime, ShiftDate) VALUES (2, TO_DATE('2025-04-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-01', 'YYYY-MM-DD'));
INSERT INTO Shift (ShiftID, StartTime, EndTime, ShiftDate) VALUES (3, TO_DATE('2025-04-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-04-01', 'YYYY-MM-DD'));

-- Inserting into Training
INSERT INTO Training (TrainingID, TrainingName, TrainingDate, Description) VALUES (1, 'Basic Volunteer Training', TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'Introduction to volunteering roles.');
INSERT INTO Training (TrainingID, TrainingName, TrainingDate, Description) VALUES (2, 'Medical Support Training', TO_DATE('2025-04-10', 'YYYY-MM-DD'), 'Training for medical assistance.');
INSERT INTO Training (TrainingID, TrainingName, TrainingDate, Description) VALUES (3, 'Administrative Support Training', TO_DATE('2025-04-15', 'YYYY-MM-DD'), 'Training for administrative roles.');

-- Inserting into Manager
INSERT INTO Manager (ManagerID, FirstName, LastName, Email, PhoneNumber) VALUES (1, 'Rachel', 'HaCohen', 'rachel.hacohen@sheba.health.gov.il', '03-530-3221');
INSERT INTO Manager (ManagerID, FirstName, LastName, Email, PhoneNumber) VALUES (2, 'Matan', 'Amsalem', 'matan.amsalem@sheba.health.gov.il', '03-530-3232');
INSERT INTO Manager (ManagerID, FirstName, LastName, Email, PhoneNumber) VALUES (3, 'David', 'Levi', 'david.levi@sheba.health.gov.il', '03-530-3243');

-- Inserting into Volunteer
INSERT INTO Volunteer (VolunteerID, FirstName, LastName, PhoneNumber, Email, Skill, ManagerID, VolunteerTypeID) VALUES (1, 'Sarah', 'Goldberg', '054-1234567', 'sarah.goldberg@gmail.com', 'Medical Assistance', 1, 1);
INSERT INTO Volunteer (VolunteerID, FirstName, LastName, PhoneNumber, Email, Skill, ManagerID, VolunteerTypeID) VALUES (2, 'Yaara', 'Shamir', '054-2345678', 'yaara.shamir@gmail.com', 'Admin Support', 2, 2);
INSERT INTO Volunteer (VolunteerID, FirstName, LastName, PhoneNumber, Email, Skill, ManagerID, VolunteerTypeID) VALUES (3, 'Tom', 'Cohen', '054-3456789', 'tom.cohen@gmail.com', 'Specialized Assistance', 3, 1);

-- Inserting into Project
INSERT INTO Project (ProjectID, ProjectName, Description, StartDate, EndDate, ManagerID) VALUES (1, 'Cancer Center Support', 'Volunteer support for cancer patients.', TO_DATE('2025-05-01', 'YYYY-MM-DD'), TO_DATE('2025-08-01', 'YYYY-MM-DD'), 1);
INSERT INTO Project (ProjectID, ProjectName, Description, StartDate, EndDate, ManagerID) VALUES (2, 'Admin Support for Sheba', 'Providing administrative support to hospital departments.', TO_DATE('2025-05-15', 'YYYY-MM-DD'), TO_DATE('2025-07-15', 'YYYY-MM-DD'), 2);
INSERT INTO Project (ProjectID, ProjectName, Description, StartDate, EndDate, ManagerID) VALUES (3, 'COVID-19 Support', 'Volunteer work for COVID-19 related tasks.', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-09-01', 'YYYY-MM-DD'), 3);

-- Inserting into WorksIn
INSERT INTO WorksIn (VolunteerID, ShiftID) VALUES (1, 1);
INSERT INTO WorksIn (VolunteerID, ShiftID) VALUES (2, 2);
INSERT INTO WorksIn (VolunteerID, ShiftID) VALUES (3, 3);

-- Inserting into Trained
INSERT INTO Trained (VolunteerID, TrainingID) VALUES (1, 1);
INSERT INTO Trained (VolunteerID, TrainingID) VALUES (2, 2);
INSERT INTO Trained (VolunteerID, TrainingID) VALUES (3, 3);

-- Inserting into AssignedTo
INSERT INTO AssignedTo (VolunteerID, ProjectID) VALUES (1, 1);
INSERT INTO AssignedTo (VolunteerID, ProjectID) VALUES (2, 2);
INSERT INTO AssignedTo (VolunteerID, ProjectID) VALUES (3, 3);
