
create database icu_idmp;
use icu_idmp;

-- -----------------------------------------------------
-- Table `icu_idmp`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS user (
  `user_id` INT NOT NULL,
  `user_access_level` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`));

INSERT INTO user(user_id, user_access_level, username, password) values
(0, 'admin', 'admin', 'password'),
(1, 'doctor', 'dr_sussie', 'password'),
(2, 'doctor', 'dr_smith', 'password'),
(3, 'caregiver', 'caring_jane', 'password'),
(4, 'patient', 'alice_patient', 'password'),
(5, 'doctor', 'medical_mike', 'password'),
(6, 'caregiver', 'support_susan', 'password'),
(7, 'patient', 'health_harry', 'password'),
(8, 'doctor', 'dr_laura', 'password'),
(9, 'caregiver', 'care_carol', 'password'),
(10, 'patient', 'wellness_will', 'password'),
(11,'patient','health_olivia', 'password'),
(12, 'patient','med_expert_jack', 'password'),
(13,'patient','caring_emily', 'password'),
(14,'patient','wellness_chris', 'password'),
(15,'patient','patient_sara', 'password'),
(16,'patient','dr_jennifer', 'password'),
(17,'patient','support_mark', 'password'),
(18, 'caregiver', 'd_brown', 'password'),
(19, 'caregiver', 'e_wilson', 'password'),
(20, 'caregiver', 'r_taylor', 'password'),
(21, 'caregiver', 'l_turner', 'password'),
(22, 'caregiver', 'b_white', 'password'),
(23, 'caregiver', 'g_green', 'password'),
(24, 'caregiver', 't_anderson', 'password'),
(25, 'patient', 'j_doe', 'password');

-- drop table user;
-- alter table user
-- add column user_access_level varchar(45) not null;
-- -----------------------------------------------------
-- Table `icu_idmp`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Patients (
  `patient_id` INT NOT NULL,
  `patient_name` VARCHAR(45) NOT NULL,
  `patient_age` VARCHAR(45) NOT NULL,
  `contact_no` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `patient_address` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`patient_id`),
  FOREIGN KEY (user_id)
  REFERENCES `icu_idmp`.`User` (`user_id`));

insert into Patients (patient_id,patient_name,patient_age,contact_no,state,city,zip_code,patient_address,user_id) values 
  (101,'John Doe', 35, '555-1234', 'California', 'Los Angeles', '90001', '123 Main St', 25),
  (102, 'Alice Patient', 45, '555-5678', 'New York', 'New York City', '10001', '456 Oak Ave',4),
  (103, 'Health Harry', 28, '555-9876', 'Texas', 'Houston', '77001', '789 Pine Rd', 7),
  (104, 'Wellness Will', 50, '555-4321', 'Florida', 'Miami', '33101', '101 Elm Blvd',10),
  (105, 'Olivia Johnson', 40, '555-1111', 'California', 'Los Angeles', '90001', '456 Oak St', 11),
  (106,  'Jack Miller', 55, '555-2222', 'New York', 'New York City', '10001', '789 Maple Ave',12),
  (107, 'Emily Davis', 30, '555-3333', 'Texas', 'Houston', '77001', '101 Pine Rd',13),
  (108, 'Chris Wilson', 45, '555-4444', 'Florida', 'Miami', '33101', '202 Elm Blvd',14),
  (109,  'Sara Brown', 35, '555-5555', 'Illinois', 'Chicago', '60601', '303 Cedar St',15),
  (110,  'Jennifer White', 50, '555-6666', 'Georgia', 'Atlanta', '30301', '404 Walnut Ave',16),
  (111, 'Mark Turner', 28, '555-7777', 'Arizona', 'Phoenix', '85001', '505 Birch Ln',17);

drop table Patients;
-- -----------------------------------------------------
-- Table `icu_idmp`.`Doctors`
-- -----------------------------------------------------
CREATE TABLE Doctors (
  `doctor_id` INT NOT NULL,
  `doctor_name` VARCHAR(45) NULL,
  `license_no` VARCHAR(45) NULL,
  `contact_no` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `doctor_domain` VARCHAR(45) NULL,
  `visiting_start_hours` VARCHAR(45) NULL,
  `visitng_end_hours` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`doctor_id`),
    FOREIGN KEY (user_id)
    REFERENCES `icu_idmp`.`User` (`user_id`));

insert into Doctors (doctor_id, doctor_name, license_no,contact_no,address,doctor_domain,visiting_start_hours,visitng_end_hours,user_id) values 
(201, 'Dr. Smith', 'MD12345', '555-1111', '123 Medical Plaza', 'Cardiology', '09:00 AM', '05:00 PM',2 ),
  (202, 'Dr. Mike', 'MD67890', '555-2222', '456 Health Street', 'Pediatrics', '10:00 AM', '06:00 PM',5),
  (203,'Dr. Laura', 'MD54321', '555-3333', '789 Wellness Avenue', 'Internal Medicine', '08:00 AM', '04:00 PM', 8);

-- -----------------------------------------------------
-- Table `icu_idmp`.`Caregivers`
-- -----------------------------------------------------
CREATE TABLE Caregivers (
  `caregiver_id` INT NOT NULL,
  `caregiver_name` VARCHAR(45) NULL,
  `shift_hours_start` VARCHAR(45) NULL,
  `shift_hours_end` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`caregiver_id`),
    FOREIGN KEY (`user_id`)
    REFERENCES `icu_idmp`.`User` (`user_id`));

insert into Caregivers(caregiver_id,caregiver_name,shift_hours_start,shift_hours_end,user_id)values 
(401, 'Jane Smith', '08:00 AM', '04:00 PM', 3),
  (402, 'Susan', '09:00 AM', '05:00 PM', 6),
  (403, 'Carol', '10:00 AM', '06:00 PM', 9),
  (404, 'David Brown', '08:30 AM', '04:30 PM', 18),
  (405, 'Emily Wilson', '09:30 AM', '05:30 PM', 19),
  (406, 'Richard Taylor', '10:30 AM', '06:30 PM', 20),
  (407, 'Linda Turner', '08:00 AM', '04:00 PM', 21),
  (408, 'Brian White', '09:00 AM', '05:00 PM', 22),
  (409, 'Grace Green', '10:00 AM', '06:00 PM', 23),
  (410, 'Tom Anderson', '08:30 AM', '04:30 PM', 24);
-- -----------------------------------------------------
-- Table `icu_idmp`.`Admissions`
-- -----------------------------------------------------
CREATE TABLE Admissions (
  `admission_id` INT NOT NULL,
  `admitted_date` VARCHAR(45) NULL,
  `admitted_discharge_date` VARCHAR(45) NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`admission_id`),
    FOREIGN KEY (patient_id)
    REFERENCES `icu_idmp`.`Patients` (`patient_id`));

insert into Admissions(admission_id,admitted_date,admitted_discharge_date,patient_id) 
values (401, '2023-01-15', '2023-01-20', 101),
  (402, '2023-02-05', '2023-02-10', 104),
  (403, '2023-03-12', '2023-03-18', 107),
  (404, '2023-04-22', '2023-04-30', 110),
  (405, '2023-05-10', '2023-05-15', 103),
  (406, '2023-06-01', '2023-06-08', 106),
  (407, '2023-07-17', '2023-07-25', 109),
  (408, '2023-08-08', '2023-08-15', 102),
  (409, '2023-04-22', '2023-06-08', 105),
  (410, '2023-11-11', '2023-11-18', 108);
  
-- ------------------------------------------------------ -----------------------------------------------------
-- Table `icu_idmp`.`ICU_Stays`
-- -----------------------------------------------------
CREATE TABLE ICU_Stays (
  `icu_stay_id` INT NOT NULL,
  `admit_time` VARCHAR(45) NULL,
  `discharge_time` VARCHAR(45) NULL,
  `doctor_id` INT NOT NULL,
  `admission_id` INT NOT NULL,
  PRIMARY KEY (`icu_stay_id`),
    FOREIGN KEY (`doctor_id`)
    REFERENCES `icu_idmp`.`Doctors` (`doctor_id`),
    FOREIGN KEY (`admission_id`)
    REFERENCES `icu_idmp`.`Admissions` (`admission_id`));

insert into ICU_Stays (icu_stay_id, admit_time, discharge_time, doctor_id, admission_id) 
values (1001, '2023-01-15 10:00:00', '2023-01-20 16:00:00', 201,401),
  (1002, '2023-02-05 11:30:00', '2023-02-10 17:30:00', 202,402),
  (1003, '2023-03-12 12:45:00', '2023-03-18 18:45:00', 203,403),
  (1004, '2023-04-22 08:15:00', '2023-04-30 14:15:00', 203,409),
  (1005, '2023-05-10 11:00:00', '2023-05-15 17:00:00', 202,405),
  (1006, '2023-06-01 11:00:00', '2023-06-08 17:00:00', 202,409),
  (1007, '2023-07-17 08:30:00', '2023-07-25 14:30:00', 201,407),
  (1008, '2023-08-08 09:45:00', '2023-08-15 15:45:00', 201,410),
  (1009, '2023-09-25 10:30:00', '2023-10-02 16:30:00', 202,406),
  (1010, '2023-11-11 11:15:00', '2023-11-18 17:15:00', 203,404);

-- -----------------------------------------------------
-- Table `icu_idmp`.`Prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`Prescription` (
  `prescription_id` INT AUTO_INCREMENT NOT NULL,
  `patient_condition` VARCHAR(45) NULL,
  `icu_stay_id` INT NOT NULL,
  PRIMARY KEY (`prescription_id`),
    FOREIGN KEY (icu_stay_id)
    REFERENCES `icu_idmp`.`ICU_Stays` (`icu_stay_id`)
  );
  
insert into Prescription (prescription_id, patient_condition, icu_stay_id) values 
  (501, 'Hypertension', 1001),
  (502, 'Type 2 Diabetes', 1002),
  (503, 'Migraine', 1003),
  (504, 'Asthma', 1004),
  (505, 'Arthritis', 1005),
  (506, 'Depression', 1006),
  (507, 'Allergies', 1007),
  (508, 'Chronic Pain', 1008),
  (509, 'Insomnia', 1009),
  (510, 'Heart Disease', 1010);



-- -----------------------------------------------------
-- Table `icu_idmp`.`Procedure`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`ICU_Procedures` (
  `procedure_id` INT NOT NULL,
  `procedure_name` VARCHAR(45) NULL,
  PRIMARY KEY (`procedure_id`))
ENGINE = InnoDB;

INSERT INTO `ICU_Procedures` (`procedure_id`, `procedure_name`) VALUES 
(1, 'Endotracheal Intubation'),
(2, 'Central Venous Catheter Placement'),
(3, 'Mechanical Ventilation'),
(4, 'Percutaneous Tracheostomy'),
(5, 'Arterial Line Placement'),
(6, 'Thoracentesis'),
(7, 'Lumbar Puncture'),
(8, 'Chest Tube Insertion'),
(9, 'Hemodialysis'),
(10, 'Transfusion of Blood Products'),
(11, 'Bronchoscopy'),
(12, 'Pericardiocentesis'),
(13, 'Electroconvulsive Therapy (ECT)'),
(14, 'Cardiopulmonary Resuscitation (CPR)'),
(15, 'Intravenous Medication Administration');

-- -----------------------------------------------------
-- Table `icu_idmp`.`Lab_Test`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`Lab_Test` (
  `lab_test_id` INT NOT NULL,
  `lab_test_name` VARCHAR(45) NULL,
  PRIMARY KEY (`lab_test_id`))
ENGINE = InnoDB;

INSERT INTO lab_test (lab_test_id, lab_test_name) VALUES 
(1, 'Complete Blood Count (CBC)'),
(2, 'Basic Metabolic Panel (BMP)'),
(3, 'Comprehensive Metabolic Panel (CMP)'),
(4, 'Lipid Panel'),
(5, 'Thyroid Function Tests'),
(6, 'Coagulation Panel'),
(7, 'Blood Glucose Test'),
(8, 'Hepatic Function Panel'),
(9, 'Electrolyte Panel'),
(10, 'Hemoglobin A1c (HbA1c)');

-- -----------------------------------------------------
-- Table `icu_idmp`.`vital_signs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`vital_signs` (
  `vital_sign_id` INT AUTO_INCREMENT NOT NULL,
  `vital_sign_name` VARCHAR(45) NOT NULL,
  `vital_sign_unit` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`vital_sign_id`))
ENGINE = InnoDB;

INSERT INTO `icu_idmp`.`vital_signs` (`vital_sign_name`, `vital_sign_unit`)
VALUES
    ('Heart Rate', 'beats per minute'),
    ('Blood Pressure', 'mmHg'),
    ('Respiratory Rate', 'breaths per minute'),
    ('Temperature', 'degrees Celsius'),
    ('Oxygen Saturation', '%'),
    ('Blood Oxygen Level', 'mmHg'),
    ('Carbon Dioxide Level', 'mmHg'),
    ('Blood pH', 'pH scale'),
    ('Glucose Level', 'mg/dL'),
    ('Pain Level', 'Numeric Rating Scale');


-- -----------------------------------------------------
-- Table `icu_idmp`.`Chartevents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`Chartevents` (
  `chartevents_id` INT AUTO_INCREMENT NOT NULL,
  `measure_value` VARCHAR(45) NULL,
  `icu_stay_id` INT NOT NULL,
  `recording_time` DATETIME NULL,
  `vital_sign_id` INT NOT NULL,
  PRIMARY KEY (`chartevents_id`),
  CONSTRAINT `fk_Chartevents_ICU_Stays1`
    FOREIGN KEY (`icu_stay_id`)
    REFERENCES `icu_idmp`.`ICU_Stays` (`icu_stay_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Chartevents_vital_signs`
    FOREIGN KEY (`vital_sign_id`)
    REFERENCES `icu_idmp`.`vital_signs` (`vital_sign_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `icu_idmp`.`monitors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`monitors` (
  `icu_stay_id` INT NOT NULL,
  `caregiver_id` INT NOT NULL,
  PRIMARY KEY (`icu_stay_id`, `caregiver_id`),
  CONSTRAINT `fk_ICU_Stays_has_Caregivers_ICU_Stays1`
    FOREIGN KEY (`icu_stay_id`)
    REFERENCES `icu_idmp`.`ICU_Stays` (`icu_stay_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ICU_Stays_has_Caregivers_Caregivers1`
    FOREIGN KEY (`caregiver_id`)
    REFERENCES `icu_idmp`.`Caregivers` (`caregiver_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

INSERT INTO `icu_idmp`.`monitors` (`icu_stay_id`, `caregiver_id`)
VALUES
    (1001, 401),
    (1002, 402),
    (1003, 403),
    (1004, 404),
    (1005, 405),
    (1006, 406),
    (1007, 407),
    (1008, 408),
    (1009, 409),
    (1010, 410);


-- -----------------------------------------------------
-- Table `icu_idmp`.`consists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`consists` (
  `icu_stay_id` INT NOT NULL,
  `procedure_id` INT NOT NULL,
  PRIMARY KEY (`icu_stay_id`, `procedure_id`),
  CONSTRAINT `fk_ICU_Stays_has_Procedure_ICU_Stays1`
    FOREIGN KEY (`icu_stay_id`)
    REFERENCES `icu_idmp`.`ICU_Stays` (`icu_stay_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ICU_Stays_has_Procedure_Procedure1`
    FOREIGN KEY (`procedure_id`)
    REFERENCES `icu_idmp`.`icu_procedures` (`procedure_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `icu_idmp`.`monitors` (`icu_stay_id`, `caregiver_id`)
VALUES
    (1001, 1),
    (1002, 2),
    (1003, 3),
    (1004, 4),
    (1005, 5),
    (1006, 6),
    (1007, 7),
    (1008, 8),
    (1009, 9),
    (1010, 10);

-- -----------------------------------------------------
-- Table `icu_idmp`.`prescribes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`prescribes` (
  `prescription_id` INT NOT NULL,
  `lab_test_id` INT NOT NULL,
  `earliest_test_by_date` INT NOT NULL,
  PRIMARY KEY (`prescription_id`, `lab_test_id`),
  CONSTRAINT `fk_Prescription_has_Lab_Test_Prescription1`
    FOREIGN KEY (`prescription_id`)
    REFERENCES `icu_idmp`.`Prescription` (`prescription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Prescription_has_Lab_Test_Lab_Test1`
    FOREIGN KEY (`lab_test_id`)
    REFERENCES `icu_idmp`.`Lab_Test` (`lab_test_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


INSERT INTO `icu_idmp`.`prescribes` (`prescription_id`, `lab_test_id`, `earliest_test_by_date`)
VALUES
    (501, 1, 20230101),
    (502, 2, 20230102),
    (503, 3, 20230103),
    (504, 4, 20230104),
    (505, 5, 20230105),
    (506, 6, 20230106),
    (507, 7, 20230107),
    (508, 8, 20230108),
    (509, 9, 20230109),
    (510, 10, 20230110);


-- -----------------------------------------------------
-- Table `icu_idmp`.`Medicine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`Medicine` (
  `Medicine_id` INT NOT NULL,
  `Medicine_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Medicine_id`))
ENGINE = InnoDB;

INSERT INTO `icu_idmp`.`Medicine` (`Medicine_id`, `Medicine_name`) VALUES 
(1, 'Acetaminophen'),
(2, 'Morphine'),
(3, 'Lorazepam'),
(4, 'Fentanyl'),
(5, 'Propofol'),
(6, 'Heparin'),
(7, 'Insulin'),
(8, 'Vancomycin'),
(9, 'Piperacillin-tazobactam'),
(10, 'Ceftriaxone'),
(11, 'Metronidazole'),
(12, 'Omeprazole'),
(13, 'Ranitidine'),
(14, 'Dexamethasone'),
(15, 'Epinephrine'),
(16, 'Norepinephrine'),
(17, 'Dobutamine'),
(18, 'Milrinone'),
(19, 'Aspirin'),
(20, 'Clopidogrel');

-- -----------------------------------------------------
-- Table `icu_idmp`.`Prescription_has_Medicine` - the table only stores what dosage has been prescribed
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `icu_idmp`.`Prescription_has_Medicine` (
  `prescription_id` INT NOT NULL,
  `medicine_id` INT NOT NULL,
  `dosage` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`prescription_id`, `medicine_id`),
  CONSTRAINT `fk_Prescription_has_Medicine_Prescription1`
    FOREIGN KEY (`prescription_id`)
    REFERENCES `icu_idmp`.`Prescription` (`prescription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Prescription_has_Medicine_Medicine1`
    FOREIGN KEY (`medicine_id`)
    REFERENCES `icu_idmp`.`Medicine` (`Medicine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO `icu_idmp`.`Prescription_has_Medicine` (`prescription_id`, `medicine_id`, `dosage`)
VALUES
    (501, 1, '50'),
    (502, 2, '50'),
    (503, 3, '50'),
    (504, 4, '50'),
    (505, 5, '50'),
    (506, 6, '50'),
    (507, 7, '50'),
    (508, 8, '50'),
    (509, 9, '50'),
    (510, 10, '50');


-- select * from User;
-- alter table user
-- add username varchar(45) not null;
-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





-- -------------------------------------------------------------------------
-- View all doctors information
-- -------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE view_all_patients()
BEGIN
	SELECT 
	patient_id as 'Patient ID',
    patient_name as 'Patient Name',
    patient_age as 'Patient Age',
    contact_no as 'Patient Contact No.'
	FROM Patients
  ORDER BY user_id;
END$$

DELIMITER ;

-- -------------------------------------------------------------------------
-- View all doctors information
-- -------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE view_all_doctors()
BEGIN
	SELECT 
	doctor_id as 'Doctor ID',
    doctor_name as 'Doctor Name',
    doctor_domain as 'Domain',
    visiting_start_hours as 'Start Hours',
    visitng_end_hours as 'End Hours'
	FROM Doctors
  ORDER BY user_id;
END$$

DELIMITER ;

-- -------------------------------------------------------------------------
-- View all users information
-- -------------------------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE view_all_users()
BEGIN
	SELECT 
	user_id as 'User ID',
    user_name as 'User Name',
    user_access_level as 'Role'
	FROM user
  ORDER BY user_id;
END$$

DELIMITER ;


-- -------------------------------------------------------------------------
-- View a doctor's patients
-- -------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE get_doctors_patients(IN doc_id INT)
BEGIN
    SELECT  a.patient_id as 'Patient ID', p.patient_name as 'Patient Name', i.icu_stay_id as 'ICU Stay ID'
    FROM ICU_stays as i
    INNER JOIN Admissions as a
    ON a.admission_id = i.admission_id
    INNER JOIN Patients as p
    on p.patient_id = a.patient_id
    WHERE i.doctor_id = doc_id;
END //

DELIMITER ;

DROP PROCEDURE get_doctors_patients;

-- -------------------------------------------------------------------------
-- View a doctor's patients
-- -------------------------------------------------------------------------

CREATE VIEW get_all_tests as
select * from lab_test;

CREATE VIEW get_all_medicines as
select * from medicine;

-- -------------------------------------------------------------------------
-- Create a trigger
-- -------------------------------------------------------------------------

DELIMITER //

CREATE TRIGGER add_to_icu_stay_after_insert
AFTER INSERT ON Admissions
FOR EACH ROW
BEGIN
    INSERT INTO ICU_Stays (admit_time, discharge_time, doctor_id, admission_id, icu_stay_id)
    VALUES (NEW.admitted_date, NULL, 201, NEW.admission_id, unix_timestamp(now()));
END //

DELIMITER ;


-- -------------------------------------------------------------------------
-- View a patient's lab_tests
-- -------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE get_patients_labtests(IN icu_stay_id INT)
BEGIN
    select i.icu_stay_id as 'ICU Stay ID', l.lab_test_name as 'Test Name'
    FROM ICU_stays as i
    INNER JOIN Prescription as p
    ON p.icu_stay_id = i.icu_stay_id
    INNER JOIN prescribes as pr
    on pr.prescription_id = p.prescription_id
    INNER JOIN lab_test as l
    on l.lab_test_id=pr.lab_test_id
    WHERE i.icu_stay_id=icu_stay_id;
END//

DELIMITER ;

-- -------------------------------------------------------------------------
-- View a patient's prescribed medicines
-- -------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE get_patients_medicines(IN icu_stay_id INT)
BEGIN
    select i.icu_stay_id as 'ICU Stay ID', m.medicine_name as 'Prescribe Medicine'
    FROM ICU_stays as i
    INNER JOIN Prescription as p
    ON p.icu_stay_id = i.icu_stay_id
    INNER JOIN Prescription_has_Medicine as pr
    ON pr.prescription_id = p.prescription_id
    INNER JOIN medicine as m
    ON m.medicine_id=pr.medicine_id
    WHERE i.icu_stay_id=icu_stay_id;
END//

DELIMITER ;

-- -------------------------------------------------------------------------
-- View a patient's health report
-- -------------------------------------------------------------------------

-- Last admission to ICU
-- Doctor who is monitoring the patient
-- Prescribed medicines, lab reports
-- Patient condition
-- ICU Procedures that have been conducted


DELIMITER //

CREATE PROCEDURE get_patient_report(IN icu_stay_id INT,
                                    OUT doctor_name VARCHAR(300),
                                    OUT caregiver_name VARCHAR(300),
                                    OUT prescribed_medicines VARCHAR(300),
                                    OUT prescribed_lab_tests VARCHAR(300),
                                    OUT patient_condition VARCHAR(300),
                                    OUT procedures VARCHAR
                                    )
BEGIN

    select d.doctor_name OUT doctor_name
    FROM icu_stays as i
    INNER JOIN doctors as d
    on i.doctor_id = d.doctor_id
    where i.icu_stay_id = icu_stay_id;

    select GROUP_CONCAT(caregiver_name SEPARATOR ', ') OUT caregiver_name
    FROM monitors as m
    INNER JOIN icu_stays as i
    on i.icu_stay_id = m.icu_stay_id
    INNER JOIN caregivers as c
    on c.caregiver_id = m.caregiver_id
    where i.icu_stay_id = icu_stay_id;

    select GROUP_CONCAT(l.lab_test_name SEPARATOR ', ') OUT prescribed_lab_tests, p.patient_condition OUT patient_condition
    FROM ICU_stays as i
    INNER JOIN Prescription as p
    ON p.icu_stay_id = i.icu_stay_id
    INNER JOIN prescribes as pr
    on pr.prescription_id = p.prescription_id
    INNER JOIN lab_test as l
    on l.lab_test_id=pr.lab_test_id
    WHERE i.icu_stay_id=icu_stay_id;

    select GROUP_CONCAT(m.medicine_name SEPARATOR ', ') OUT prescribed_medicines
    FROM ICU_stays as i
    INNER JOIN Prescription as p
    ON p.icu_stay_id = i.icu_stay_id
    INNER JOIN Prescription_has_Medicine as pr
    ON pr.prescription_id = p.prescription_id
    INNER JOIN medicine as m
    ON m.medicine_id=pr.medicine_id
    WHERE i.icu_stay_id=icu_stay_id;

END//

DELIMITER ;


-- -------------------------------------------------------------------------
-- View a summary statistics
-- -------------------------------------------------------------------------

DELIMITER //

CREATE FUNCTION get_row_counts()
RETURNS VARCHAR(100)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE count1 INT;
    DECLARE count2 INT;
    DECLARE count3 INT;
    DECLARE result VARCHAR(100);

    SELECT COUNT(*) INTO count1 FROM Patients;
    SELECT COUNT(*) INTO count2 FROM icu_stays;
    SELECT COUNT(*) INTO count3 FROM doctors;

    SET result = CONCAT('Total number of patients: ', count1, '\n',
                        'Total number of icu_stays: ', count2, '\n',
                        'Total number of doctors: ', count3);

    RETURN result;
END //

DELIMITER ;

-- -------------------------------------------------------------------------
-- View another summary statistics
-- -------------------------------------------------------------------------

DELIMITER //

CREATE FUNCTION get_stats()
RETURNS VARCHAR(100)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE doctor VARCHAR(100);
    DECLARE patient VARCHAR(100);
    DECLARE caregiver VARCHAR(100);
    DECLARE result VARCHAR(300);
	
    
    SELECT CONCAT(k.doctor_name, ' ', k.count_icu_stays) INTO doctor
    FROM
    (SELECT d.doctor_name, count(*) as count_icu_stays
    FROM icu_stays as i
    INNER JOIN doctors as d
    ON d.doctor_id = i.doctor_id
    GROUP BY d.doctor_id
    ORDER BY count_icu_stays DESC
    LIMIT 1) as k;

    SELECT CONCAT(k.patient_name, ' ', k.count_icu_stays) INTO patient
    FROM
    (SELECT p.patient_name, count(*) as count_icu_stays 
    FROM icu_stays as i
    INNER JOIN Admissions as a
    ON a.admission_id = i.admission_id
    INNER JOIN Patients as p
    ON p.patient_id = a.patient_id
    GROUP BY p.patient_id
    ORDER BY count_icu_stays DESC
    LIMIT 1) as k;

     SELECT CONCAT(k.caregiver_name, ' ', k.count_icu_stays) INTO caregiver
    FROM
    (SELECT c.caregiver_name, count(*) as count_icu_stays
    FROM icu_stays as i
    INNER JOIN monitors as m
    ON i.icu_stay_id = m.icu_stay_id
    INNER JOIN caregivers as c
    ON c.caregiver_id = m.caregiver_id
    GROUP BY c.caregiver_id
    ORDER BY count_icu_stays DESC
    LIMIT 1) as k;


    SET result = CONCAT('Doctor with most number of icu stays: ', doctor, '\n',
                        'Patient with highest number of icu stays: ', patient, '\n',
                        'Caregiver with most number of icu stays: ', caregiver);

    RETURN result;
END //

DELIMITER ;