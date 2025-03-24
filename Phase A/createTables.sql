CREATE TABLE VolunteerType(
                              VolunteerTypeID INT AUTO_INCREMENT,
                              TypeName VARCHAR(255) NOT NULL,
                              PRIMARY KEY(VolunteerTypeID)
);

CREATE TABLE Shift(
                      ShiftID INT AUTO_INCREMENT,
                      StartTime TIME NOT NULL,
                      EndTime TIME NOT NULL,
                      Date DATE NOT NULL,
                      PRIMARY KEY(ShiftID)
);

CREATE TABLE Training(
                         TrainingID INT AUTO_INCREMENT,
                         TrainingName VARCHAR(255) NOT NULL,
                         TrainingDate DATE NOT NULL,
                         Description TEXT NOT NULL,
                         PRIMARY KEY(TrainingID)
);

CREATE TABLE Manager(
                        ManagerID INT AUTO_INCREMENT,
                        FirstName VARCHAR(50) NOT NULL,
                        LastName VARCHAR(50) NOT NULL,
                        Email VARCHAR(255) NOT NULL UNIQUE,
                        PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
                        PRIMARY KEY(ManagerID)
);

CREATE TABLE Volunteer(
                          VolunteerID INT AUTO_INCREMENT,
                          FirstName VARCHAR(50) NOT NULL,
                          LastName VARCHAR(50) NOT NULL,
                          PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
                          Email VARCHAR(255) NOT NULL UNIQUE,
                          Skill TEXT NOT NULL,
                          ManagerID INT NOT NULL,
                          VolunteerTypeID INT NOT NULL,
                          PRIMARY KEY(VolunteerID),
                          FOREIGN KEY(ManagerID) REFERENCES Manager(ManagerID) ON DELETE CASCADE,
                          FOREIGN KEY(VolunteerTypeID) REFERENCES VolunteerType(VolunteerTypeID) ON DELETE CASCADE
);

CREATE TABLE Project(
                        ProjectID INT AUTO_INCREMENT,
                        ProjectName VARCHAR(255) NOT NULL,
                        Description TEXT NOT NULL,
                        StartDate DATE NOT NULL,
                        EndDate DATE NOT NULL,
                        ManagerID INT NOT NULL,
                        PRIMARY KEY(ProjectID),
                        FOREIGN KEY(ManagerID) REFERENCES Manager(ManagerID) ON DELETE CASCADE
);

CREATE TABLE WorksIn(
                        VolunteerID INT NOT NULL,
                        ShiftID INT NOT NULL,
                        PRIMARY KEY(VolunteerID, ShiftID),
                        FOREIGN KEY(VolunteerID) REFERENCES Volunteer(VolunteerID) ON DELETE CASCADE,
                        FOREIGN KEY(ShiftID) REFERENCES Shift(ShiftID) ON DELETE CASCADE
);

CREATE TABLE Trained(
                        VolunteerID INT NOT NULL,
                        TrainingID INT NOT NULL,
                        PRIMARY KEY(VolunteerID, TrainingID),
                        FOREIGN KEY(VolunteerID) REFERENCES Volunteer(VolunteerID) ON DELETE CASCADE,
                        FOREIGN KEY(TrainingID) REFERENCES Training(TrainingID) ON DELETE CASCADE
);

CREATE TABLE AssignedTo(
                           VolunteerID INT NOT NULL,
                           ProjectID INT NOT NULL,
                           PRIMARY KEY(VolunteerID, ProjectID),
                           FOREIGN KEY(VolunteerID) REFERENCES Volunteer(VolunteerID) ON DELETE CASCADE,
                           FOREIGN KEY(ProjectID) REFERENCES Project(ProjectID) ON DELETE CASCADE
);
