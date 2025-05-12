
-- Create Person Entity
CREATE TABLE Person (
    id SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255),
    birthday DATE,
    gender VARCHAR(10)
);

-- Insert to person - Manger, Volunteer, patient, Staff_Member
INSERT INTO Person (id, FirstName, LastName, email, phone)
SELECT ManagerID, FirstName, LastName, Email, PhoneNumber
FROM Manager;

INSERT INTO Person (id, FirstName, LastName, email, phone)
SELECT VolunteerID, FirstName, LastName, Email, PhoneNumber
FROM Volunteer;

INSERT INTO Person (id, FirstName, LastName, address, email, phone, birthday, gender)
SELECT
    id,
    SPLIT_PART(name, ' ', 1) AS FirstName,
    COALESCE(SPLIT_PART(name, ' ', 2), '') AS LastName,
    address, email, phone, birhday, gender
FROM patient;

INSERT INTO Person (id, FirstName, LastName, email, phone)
SELECT
    id,
    SPLIT_PART(name, ' ', 1) AS FirstName,
    COALESCE(SPLIT_PART(name, ' ', 2), 'Staff') AS LastName,
    LOWER(SPLIT_PART(name, ' ', 1)) || id || '@hospital.org' AS email,
    '05' || LPAD((FLOOR(RANDOM() * 100000000))::TEXT, 8, '0') AS phone
FROM Staff_Member;

-- Create Worker
CREATE TABLE Worker
(
  W_id SERIAL,
  Role VARCHAR(50) NOT NULL,
  PRIMARY KEY (W_id),
  FOREIGN KEY (W_id) REFERENCES Person(id)
);

-- Insert manger to Worker
INSERT INTO Worker (W_id, Role)
SELECT ManagerID, 'Manager'
FROM Manager;

-- Insert Staff member to Worker
INSERT INTO Worker (W_id, Role)
SELECT id, role
FROM Staff_Member;

----Delete all refrences to Manager and Staff_Member to refrence worker
--Volunteer
ALTER TABLE Volunteer
DROP CONSTRAINT volunteer_managerid_fkey;

ALTER TABLE Volunteer
ADD CONSTRAINT volunteer_managerid_fkey
FOREIGN KEY (ManagerID) REFERENCES Worker(W_id) ON DELETE CASCADE;

--Project
ALTER TABLE Project
DROP CONSTRAINT project_managerid_fkey;

ALTER TABLE Project
ADD CONSTRAINT project_managerid_fkey
FOREIGN KEY (ManagerID) REFERENCES Worker(W_id) ON DELETE CASCADE;

--Appointment
ALTER TABLE Appointment
DROP CONSTRAINT appointment_staffm__id_fkey;

ALTER TABLE Appointment
ADD CONSTRAINT appointment_staffm__id_fkey
FOREIGN KEY (staffm_id) REFERENCES Worker(W_id) ON DELETE CASCADE;

-- Create new table (Volunteer -- TreatPlan)
CREATE TABLE VolunteerInTreatPlan (
    VolunteerID INT NOT NULL,
    TreatType VARCHAR(50) NOT NULL,
    PatientID INT NOT NULL,
    PRIMARY KEY (VolunteerID, TreatType, PatientID),
    FOREIGN KEY (VolunteerID) REFERENCES Volunteer(VolunteerID) ON DELETE CASCADE,
    FOREIGN KEY (TreatType, PatientID) REFERENCES Treat_Plan(treat_type, patient_id) ON DELETE CASCADE
);

--Insert to new table randomly
INSERT INTO VolunteerInTreatPlan (VolunteerID, TreatType, PatientID)
SELECT
    v.VolunteerID,
    tp.treat_type,
    tp.patient_id
FROM
    Volunteer v
CROSS JOIN
    TreatmentPlan tp
ORDER BY RANDOM()
LIMIT 100;


--Add a variable to m_record key along with patient_id
ALTER TABLE m_record
ADD COLUMN RecordID SERIAL PRIMARY KEY;

ALTER TABLE m_record
DROP CONSTRAINT m_record_pkey;

ALTER TABLE m_record DROP CONSTRAINT m_record_pkey;

ALTER TABLE m_record
ADD CONSTRAINT m_record_pkey PRIMARY KEY (RecordID, patient_id);

ALTER TABLE m_record
ADD CONSTRAINT unique_patient_record UNIQUE (patient_id);

--Delete tables Manager and Staff_Member
DROP TABLE IF EXISTS Manager;
DROP TABLE IF EXISTS Staff_Member;

--Alter table Volunteer
ALTER TABLE Volunteer ADD CONSTRAINT fk_volunteer_person FOREIGN KEY (VolunteerID) REFERENCES Person(id);

ALTER TABLE Volunteer DROP COLUMN FirstName;
ALTER TABLE Volunteer DROP COLUMN LastName;
ALTER TABLE Volunteer DROP COLUMN PhoneNumber;
ALTER TABLE Volunteer DROP COLUMN Email;

--Alter table Patient
ALTER TABLE Patient ADD CONSTRAINT fk_patient_person FOREIGN KEY (id) REFERENCES Person(id);

ALTER TABLE Patient DROP COLUMN name;
ALTER TABLE Patient DROP COLUMN address;
ALTER TABLE Patient DROP COLUMN phone;
ALTER TABLE Patient DROP COLUMN email;
ALTER TABLE Patient DROP COLUMN birhday;
ALTER TABLE Patient DROP COLUMN gender;

--Change fields name
ALTER TABLE use RENAME TO use_equipment;
ALTER TABLE m_equipment RENAME TO MedicalEquipment;
ALTER TABLE m_record RENAME TO MedicalRecord;
ALTER TABLE treat_plan RENAME TO TreatmentPlan;
ALTER TABLE WorksIn RENAME TO VolunteerShift;
ALTER TABLE Trained RENAME TO VolunteerTraining;
ALTER TABLE AssignedTo RENAME TO VolunteerProject;
