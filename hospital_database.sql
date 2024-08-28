-- Drop Schema without CASCADE (MySQL doesn't support CASCADE for DROP SCHEMA)
DROP SCHEMA IF EXISTS hospital_management;

-- Create Schema
CREATE SCHEMA IF NOT EXISTS hospital_management;
USE hospital_management;

-- Create Tables

DROP TABLE IF EXISTS patient;
CREATE TABLE IF NOT EXISTS patient (
    email VARCHAR(50) PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(60) NOT NULL,
    gender VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS medical_history;
CREATE TABLE IF NOT EXISTS medical_history (
    medical_history_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    conditions VARCHAR(100) NOT NULL,
    surgeries VARCHAR(100) NOT NULL,
    medication VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS doctor;
CREATE TABLE IF NOT EXISTS doctor (
    email VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(20) NOT NULL,
    password VARCHAR(30) NOT NULL,
    name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS appointment;
CREATE TABLE IF NOT EXISTS appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status VARCHAR(15) NOT NULL
);

DROP TABLE IF EXISTS patient_visits;
CREATE TABLE IF NOT EXISTS patient_visits (
    patient_email VARCHAR(50) NOT NULL,
    appt_id INT NOT NULL,
    concerns VARCHAR(40) NOT NULL,
    symptoms VARCHAR(40) NOT NULL,
    PRIMARY KEY (patient_email, appt_id),
    FOREIGN KEY (patient_email) REFERENCES patient (email),
    FOREIGN KEY (appt_id) REFERENCES appointment (appointment_id)
);

DROP TABLE IF EXISTS schedule;
CREATE TABLE IF NOT EXISTS schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    break_time TIME NOT NULL,
    day VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS patients_history;
CREATE TABLE IF NOT EXISTS patients_history (
    patient_email VARCHAR(50) NOT NULL,
    history_id INT NOT NULL,
    PRIMARY KEY (history_id, patient_email),
    FOREIGN KEY (patient_email) REFERENCES patient (email),
    FOREIGN KEY (history_id) REFERENCES medical_history (medical_history_id)
);

DROP TABLE IF EXISTS diagnose;
CREATE TABLE IF NOT EXISTS diagnose (
    appt_id INT NOT NULL,
    doctor_email VARCHAR(50) NOT NULL,
    diagnosis VARCHAR(40) NOT NULL,
    prescription VARCHAR(50) NOT NULL,
    PRIMARY KEY (appt_id, doctor_email),
    FOREIGN KEY (appt_id) REFERENCES appointment (appointment_id),
    FOREIGN KEY (doctor_email) REFERENCES doctor (email)
);

DROP TABLE IF EXISTS doctor_schedules;
CREATE TABLE IF NOT EXISTS doctor_schedules (
    schedule_id INT NOT NULL,
    doctor_email VARCHAR(50) NOT NULL,
    PRIMARY KEY (schedule_id, doctor_email),
    FOREIGN KEY (schedule_id) REFERENCES schedule (schedule_id),
    FOREIGN KEY (doctor_email) REFERENCES doctor (email)
);

DROP TABLE IF EXISTS doctor_view_history;
CREATE TABLE IF NOT EXISTS doctor_view_history (
    history_id INT NOT NULL,
    doctor_email VARCHAR(50) NOT NULL,
    PRIMARY KEY (history_id, doctor_email),
    FOREIGN KEY (doctor_email) REFERENCES doctor (email),
    FOREIGN KEY (history_id) REFERENCES medical_history (medical_history_id)
);
