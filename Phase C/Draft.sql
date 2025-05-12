CREATE TABLE person (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    gender VARCHAR,
    birth_date DATE,
    address VARCHAR,
    phone_number VARCHAR,
    email_address VARCHAR
);

CREATE TABLE worker (
    worker_id INTEGER PRIMARY KEY,
    role VARCHAR
);

CREATE TABLE volunteerType (
    volunteer_type_id INTEGER PRIMARY KEY,
    type_name VARCHAR
);

CREATE TABLE volunteer (
    volunteer_id INTEGER PRIMARY KEY,
    skill VARCHAR,
    volunteer_type_id INTEGER,
    manager_id INTEGER,
    FOREIGN KEY (volunteer_type_id) REFERENCES volunteerType(volunteer_type_id),
    FOREIGN KEY (manager_id) REFERENCES worker(worker_id)
);

CREATE TABLE patient (
    patient_id INTEGER PRIMARY KEY
);

CREATE TABLE volunteerType (
    treatment_type VARCHAR,
    patient_id INTEGER,
    start_date DATE,
    end_date DATE,
    sessions_per_week INTEGER,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE volunteerInTreatPlan (
    volunteer_id INTEGER,
    patient_id INTEGER,
    treatment_type VARCHAR,
    FOREIGN KEY (volunteer_id) REFERENCES volunteer(volunteer_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE appointment (
    patient_id INTEGER,
    worker_id INTEGER,
    appointment_date DATE,
    appointment_time TIME,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (worker_id) REFERENCES worker(worker_id)
);

CREATE TABLE project (
    project_id INTEGER PRIMARY KEY,
    project_name VARCHAR,
    description VARCHAR,
    start_date DATE,
    end_date DATE,
    manager_id INTEGER,
    FOREIGN KEY (manager_id) REFERENCES worker(worker_id)
);

CREATE TABLE volunteerProject (
    volunteer_id INTEGER,
    project_id INTEGER,
    FOREIGN KEY (volunteer_id) REFERENCES volunteer(volunteer_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id)
);

CREATE TABLE shift (
    shift_id INTEGER PRIMARY KEY,
    shift_date DATE,
    start_time TIME,
    end_time TIME
);

CREATE TABLE volunteerShift (
    volunteer_id INTEGER,
    shift_id INTEGER,
    FOREIGN KEY (volunteer_id) REFERENCES volunteer(volunteer_id),
    FOREIGN KEY (shift_id) REFERENCES shift(shift_id)
);

CREATE TABLE training (
    training_id INTEGER PRIMARY KEY,
    training_name VARCHAR,
    description VARCHAR,
    training_date DATE
);

CREATE TABLE volunteerTraining (
    volunteer_id INTEGER,
    training_id INTEGER,
    FOREIGN KEY (volunteer_id) REFERENCES volunteer(volunteer_id),
    FOREIGN KEY (training_id) REFERENCES training(training_id)
);

CREATE TABLE medicalRecord (
    record_id INTEGER PRIMARY KEY,
    patient_id INTEGER,
    severity_of_injury INTEGER,
    family_status INTEGER,
    cause_of_injury VARCHAR,
    allergies VARCHAR,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE medicalEquipment (
    equipment_id INTEGER PRIMARY KEY,
    equipment_name VARCHAR,
    destination_age INTEGER,
    status VARCHAR
);

CREATE TABLE useEquipment (
    patient_id INTEGER,
    equipment_id INTEGER,
    treatment_type VARCHAR,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (equipment_id) REFERENCES medicalEquipment(equipment_id)
);
