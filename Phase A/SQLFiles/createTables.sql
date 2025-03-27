CREATE TABLE VolunteerType (
                               VolunteerTypeID INT PRIMARY KEY,
                               TypeName VARCHAR(255) NOT NULL
);

CREATE TABLE Shift (
                       ShiftID INT PRIMARY KEY,
                       StartTime TIME NOT NULL,
                       EndTime TIME NOT NULL,
                       ShiftDate DATE NOT NULL
);

CREATE TABLE Training (
                          TrainingID INT PRIMARY KEY,
                          TrainingName VARCHAR(255) NOT NULL,
                          TrainingDate DATE NOT NULL,
                          Description VARCHAR(4000) NOT NULL
);

CREATE TABLE Manager (
                         ManagerID INT PRIMARY KEY,
                         FirstName VARCHAR(50) NOT NULL,
                         LastName VARCHAR(50) NOT NULL,
                         Email VARCHAR(255) NOT NULL UNIQUE,
                         PhoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE Volunteer (
                           VolunteerID INT PRIMARY KEY,
                           FirstName VARCHAR(50) NOT NULL,
                           LastName VARCHAR(50) NOT NULL,
                           PhoneNumber VARCHAR(20) NOT NULL,
                           Email VARCHAR(255) NOT NULL UNIQUE,
                           Skill VARCHAR(4000) NOT NULL,
                           ManagerID INT NOT NULL,
                           VolunteerTypeID INT NOT NULL,
                           FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID) ON DELETE CASCADE,
                           FOREIGN KEY (VolunteerTypeID) REFERENCES VolunteerType(VolunteerTypeID) ON DELETE CASCADE
);

CREATE TABLE Project (
                         ProjectID INT PRIMARY KEY,
                         ProjectName VARCHAR(255) NOT NULL,
                         Description VARCHAR(4000) NOT NULL,
                         StartDate DATE NOT NULL,
                         EndDate DATE NOT NULL,
                         ManagerID INT NOT NULL,
                         FOREIGN KEY (ManagerID) REFERENCES Manager(ManagerID) ON DELETE CASCADE
);

CREATE TABLE WorksIn (
                         VolunteerID INT,
                         ShiftID INT,
                         PRIMARY KEY (VolunteerID, ShiftID),
                         FOREIGN KEY (VolunteerID) REFERENCES Volunteer(VolunteerID) ON DELETE CASCADE,
                         FOREIGN KEY (ShiftID) REFERENCES Shift(ShiftID) ON DELETE CASCADE
);

CREATE TABLE Trained (
                         VolunteerID INT,
                         TrainingID INT,
                         PRIMARY KEY (VolunteerID, TrainingID),
                         FOREIGN KEY (VolunteerID) REFERENCES Volunteer(VolunteerID) ON DELETE CASCADE,
                         FOREIGN KEY (TrainingID) REFERENCES Training(TrainingID) ON DELETE CASCADE
);

CREATE TABLE AssignedTo (
                            VolunteerID INT,
                            ProjectID INT,
                            PRIMARY KEY (VolunteerID, ProjectID),
                            FOREIGN KEY (VolunteerID) REFERENCES Volunteer(VolunteerID) ON DELETE CASCADE,
                            FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID) ON DELETE CASCADE
);