-- UNIQUE constraint: A shift (date + time) cannot occur more than once
ALTER TABLE Shift
ADD CONSTRAINT uniq_shift_datetime
UNIQUE (ShiftDate, StartTime, EndTime);

-- CHECK constraint on the Volunteer table: Phone number must be at least 9 digits long
ALTER TABLE Volunteer
ADD CONSTRAINT chk_phone_length
CHECK (LENGTH(PhoneNumber) >= 9 AND LENGTH(PhoneNumber) <= 10);

-- DEFAULT constraint on the Project table: Default start date is today's date
ALTER TABLE Project
ALTER COLUMN StartDate
SET DEFAULT CURRENT_DATE;
