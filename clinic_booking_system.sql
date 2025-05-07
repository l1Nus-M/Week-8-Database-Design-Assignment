-- Clinic Booking System Database Schema

-- Create database
CREATE DATABASE clinic_booking_system;
USE clinic_booking_system;

-- Create Tables

-- Specialties table (1-M relationship with Doctors)
CREATE TABLE specialties (
    specialty_id INT PRIMARY KEY AUTO_INCREMENT,
    specialty_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Doctors table (1-M relationship with Appointments)
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    specialty_id INT,
    license_number VARCHAR(20) NOT NULL UNIQUE,
    hire_date DATE NOT NULL,
    status ENUM('active', 'inactive', 'on_leave') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (specialty_id) REFERENCES specialties(specialty_id)
);

-- Patients table (1-M relationship with Appointments)
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('M', 'F', 'Other') NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address TEXT,
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
    emergency_contact VARCHAR(100),
    emergency_phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments table (M-M relationship between Doctors and Patients)
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('scheduled', 'completed', 'cancelled', 'no_show') DEFAULT 'scheduled',
    reason TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Medical Records table (1-M relationship with Patients)
CREATE TABLE medical_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    prescription TEXT,
    notes TEXT,
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Medications table
CREATE TABLE medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    dosage_form VARCHAR(50),
    manufacturer VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Prescriptions table (M-M relationship between Medical Records and Medications)
CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    duration VARCHAR(50) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (record_id) REFERENCES medical_records(record_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id)
);

-- Insert Sample Data

-- Insert Specialties
INSERT INTO specialties (specialty_name, description) VALUES
('Cardiology', 'Heart and cardiovascular system specialist'),
('Dermatology', 'Skin, hair, and nail specialist'),
('Pediatrics', 'Children''s health specialist'),
('Orthopedics', 'Bone and joint specialist'),
('Neurology', 'Nervous system specialist');

-- Insert Doctors
INSERT INTO doctors (first_name, last_name, email, phone, specialty_id, license_number, hire_date) VALUES
('John', 'Smith', 'john.smith@clinic.com', '555-0101', 1, 'MD12345', '2020-01-15'),
('Sarah', 'Johnson', 'sarah.j@clinic.com', '555-0102', 2, 'MD12346', '2019-06-01'),
('Michael', 'Brown', 'michael.b@clinic.com', '555-0103', 3, 'MD12347', '2021-03-10'),
('Emily', 'Davis', 'emily.d@clinic.com', '555-0104', 4, 'MD12348', '2018-11-20'),
('David', 'Wilson', 'david.w@clinic.com', '555-0105', 5, 'MD12349', '2022-02-01');

-- Insert Patients
INSERT INTO patients (first_name, last_name, date_of_birth, gender, email, phone, address, blood_type) VALUES
('Alice', 'Cooper', '1985-05-15', 'F', 'alice.c@email.com', '555-0201', '123 Main St', 'A+'),
('Bob', 'Miller', '1990-08-22', 'M', 'bob.m@email.com', '555-0202', '456 Oak Ave', 'O-'),
('Carol', 'Taylor', '1978-11-30', 'F', 'carol.t@email.com', '555-0203', '789 Pine Rd', 'B+'),
('David', 'Anderson', '1995-03-10', 'M', 'david.a@email.com', '555-0204', '321 Elm St', 'AB+'),
('Eva', 'Martinez', '1982-07-25', 'F', 'eva.m@email.com', '555-0205', '654 Maple Dr', 'O+');

-- Insert Appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, reason) VALUES
(1, 1, '2024-03-20', '09:00:00', 'scheduled', 'Regular checkup'),
(2, 2, '2024-03-20', '10:30:00', 'scheduled', 'Skin condition'),
(3, 3, '2024-03-21', '14:00:00', 'scheduled', 'Child vaccination'),
(4, 4, '2024-03-21', '15:30:00', 'scheduled', 'Joint pain'),
(5, 5, '2024-03-22', '11:00:00', 'scheduled', 'Headache consultation');

-- Insert Medical Records
INSERT INTO medical_records (patient_id, doctor_id, diagnosis, prescription, notes) VALUES
(1, 1, 'Hypertension', 'Blood pressure medication', 'Regular monitoring required'),
(2, 2, 'Eczema', 'Topical cream', 'Follow up in 2 weeks'),
(3, 3, 'Common cold', 'Rest and fluids', 'No complications'),
(4, 4, 'Sprained ankle', 'Pain medication', 'Rest and ice recommended'),
(5, 5, 'Migraine', 'Pain relief medication', 'Avoid triggers');

-- Insert Medications
INSERT INTO medications (name, description, dosage_form, manufacturer) VALUES
('Amoxicillin', 'Antibiotic', 'Capsule', 'Pfizer'),
('Ibuprofen', 'Pain reliever', 'Tablet', 'Bayer'),
('Lisinopril', 'Blood pressure medication', 'Tablet', 'Merck'),
('Cetirizine', 'Antihistamine', 'Tablet', 'Johnson & Johnson'),
('Omeprazole', 'Acid reducer', 'Capsule', 'AstraZeneca');

-- Insert Prescriptions
INSERT INTO prescriptions (record_id, medication_id, dosage, frequency, duration) VALUES
(1, 3, '10mg', 'Once daily', '30 days'),
(2, 4, '10mg', 'Once daily', '14 days'),
(3, 1, '500mg', 'Three times daily', '7 days'),
(4, 2, '400mg', 'Every 6 hours', '5 days'),
(5, 2, '400mg', 'As needed', '30 days');

-- Create Indexes for better performance
CREATE INDEX idx_doctor_specialty ON doctors(specialty_id);
CREATE INDEX idx_appointment_patient ON appointments(patient_id);
CREATE INDEX idx_appointment_doctor ON appointments(doctor_id);
CREATE INDEX idx_medical_record_patient ON medical_records(patient_id);
CREATE INDEX idx_prescription_record ON prescriptions(record_id);

-- Create Views for common queries

-- View for upcoming appointments
CREATE VIEW upcoming_appointments AS
SELECT 
    a.appointment_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    s.specialty_name,
    a.appointment_date,
    a.appointment_time,
    a.status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN specialties s ON d.specialty_id = s.specialty_id
WHERE a.appointment_date >= CURDATE()
ORDER BY a.appointment_date, a.appointment_time;

-- View for patient medical history
CREATE VIEW patient_medical_history AS
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    mr.record_date,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    mr.diagnosis,
    mr.prescription,
    mr.notes
FROM patients p
JOIN medical_records mr ON p.patient_id = mr.patient_id
JOIN doctors d ON mr.doctor_id = d.doctor_id
ORDER BY mr.record_date DESC; 
