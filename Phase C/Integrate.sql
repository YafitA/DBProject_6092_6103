
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

--Change tables name
ALTER TABLE use RENAME TO useEquipment;
ALTER TABLE m_equipment RENAME TO MedicalEquipment;
ALTER TABLE m_record RENAME TO MedicalRecord;
ALTER TABLE treat_plan RENAME TO TreatmentPlan;
ALTER TABLE WorksIn RENAME TO VolunteerShift;
ALTER TABLE Trained RENAME TO VolunteerTraining;
ALTER TABLE AssignedTo RENAME TO VolunteerProject;

--Change variables names
-- person
ALTER TABLE person RENAME COLUMN firstname TO first_name;
ALTER TABLE person RENAME COLUMN lastname TO last_name;
ALTER TABLE person RENAME COLUMN birthday TO birth_date;
ALTER TABLE person RENAME COLUMN email TO email_address;
ALTER TABLE person RENAME COLUMN phone TO phone_number;

-- worker
ALTER TABLE worker RENAME COLUMN w_id TO worker_id;

-- volunteer
ALTER TABLE volunteer RENAME COLUMN volunteertypeid TO volunteer_type_id;
ALTER TABLE volunteer RENAME COLUMN managerid TO manager_id;
ALTER TABLE volunteer RENAME COLUMN volunteerid TO volunteer_id;

-- volunteertype
ALTER TABLE volunteertype RENAME COLUMN volunteertypeid TO volunteer_type_id;
ALTER TABLE volunteertype RENAME COLUMN typename TO type_name;

-- volunteerintreatplan
ALTER TABLE volunteerintreatplan RENAME COLUMN patientid TO patient_id;
ALTER TABLE volunteerintreatplan RENAME COLUMN volunteerid TO volunteer_id;
ALTER TABLE volunteerintreatplan RENAME COLUMN treattype TO treatment_type;

-- treatmentplan
ALTER TABLE treatmentplan RENAME COLUMN treat_type TO treatment_type;
ALTER TABLE treatmentplan RENAME COLUMN patientid TO patient_id;

-- appointment
ALTER TABLE appointment RENAME COLUMN workerid TO worker_id;
ALTER TABLE appointment RENAME COLUMN patientid TO patient_id;
ALTER TABLE appointment RENAME COLUMN date TO appointment_date;
ALTER TABLE appointment RENAME COLUMN time TO appointment_time;

-- project
ALTER TABLE project RENAME COLUMN projectid TO project_id;
ALTER TABLE project RENAME COLUMN projectname TO project_name;
ALTER TABLE project RENAME COLUMN startdate TO start_date;
ALTER TABLE project RENAME COLUMN enddate TO end_date;
ALTER TABLE project RENAME COLUMN managerid TO manager_id;

-- volunteerproject
ALTER TABLE volunteerproject RENAME COLUMN volunteerid TO volunteer_id;
ALTER TABLE volunteerproject RENAME COLUMN projectid TO project_id;

-- volunteershift
ALTER TABLE volunteershift RENAME COLUMN volunteerid TO volunteer_id;
ALTER TABLE volunteershift RENAME COLUMN shiftid TO shift_id;

-- shift
ALTER TABLE shift RENAME COLUMN shiftid TO shift_id;
ALTER TABLE shift RENAME COLUMN shiftdate TO shift_date;
ALTER TABLE shift RENAME COLUMN starttime TO start_time;
ALTER TABLE shift RENAME COLUMN endtime TO end_time;

-- training
ALTER TABLE training RENAME COLUMN trainingid TO training_id;
ALTER TABLE training RENAME COLUMN trainingname TO training_name;
ALTER TABLE training RENAME COLUMN trainingdate TO training_date;

-- volunteertraining
ALTER TABLE volunteertraining RENAME COLUMN volunteerid TO volunteer_id;
ALTER TABLE volunteertraining RENAME COLUMN trainingid TO training_id;

-- medicalrecord
ALTER TABLE medicalrecord RENAME COLUMN recordid TO record_id;
ALTER TABLE medicalrecord RENAME COLUMN family_s TO family_status;
ALTER TABLE medicalrecord RENAME COLUMN causing_injury TO cause_of_injury;

-- medicalequipment
ALTER TABLE medicalequipment RENAME COLUMN equipid TO equipment_id;
ALTER TABLE medicalequipment RENAME COLUMN name TO equipment_name;
ALTER TABLE medicalequipment RENAME COLUMN dest_age TO destination_age;

-- useequipment
ALTER TABLE useequipment RENAME COLUMN equip_id TO equipment_id;

-- patient
ALTER TABLE patient RENAME COLUMN patientid TO patient_id;
