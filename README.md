# Clinic Booking System Database

A comprehensive MySQL database system designed for managing a medical clinic's operations, including patient appointments, medical records, prescriptions, and doctor management.

## Database Overview

The system consists of 7 main tables with proper relationships and constraints, designed to handle all aspects of a medical clinic's operations.

### Core Tables

1. **specialties**
   - Stores medical specialties
   - Primary key: `specialty_id`
   - Contains specialty name and description

2. **doctors**
   - Manages doctor information
   - Primary key: `doctor_id`
   - Links to specialties (1-M relationship)
   - Tracks license numbers and status

3. **patients**
   - Stores patient information
   - Primary key: `patient_id`
   - Includes personal and medical information
   - Tracks emergency contacts

4. **appointments**
   - Manages patient appointments
   - Primary key: `appointment_id`
   - Links patients and doctors (M-M relationship)
   - Tracks appointment status and details

5. **medical_records**
   - Stores patient medical history
   - Primary key: `record_id`
   - Links to patients and doctors
   - Contains diagnosis and treatment information

6. **medications**
   - Catalog of available medications
   - Primary key: `medication_id`
   - Includes medication details and manufacturer info

7. **prescriptions**
   - Manages medication prescriptions
   - Primary key: `prescription_id`
   - Links medical records and medications (M-M relationship)
   - Tracks dosage and duration

## Relationships

- **One-to-Many (1-M)**
  - Specialties → Doctors
  - Doctors → Appointments
  - Patients → Appointments
  - Patients → Medical Records

- **Many-to-Many (M-M)**
  - Doctors ↔ Patients (through Appointments)
  - Medical Records ↔ Medications (through Prescriptions)

## Views

The database includes two useful views:

1. **upcoming_appointments**
   - Shows all future appointments
   - Includes patient and doctor details
   - Sorted by date and time

2. **patient_medical_history**
   - Displays complete patient medical history
   - Includes doctor information
   - Sorted by record date

## Performance Optimization

The database includes indexes on frequently queried columns:
- `idx_doctor_specialty`
- `idx_appointment_patient`
- `idx_appointment_doctor`
- `idx_medical_record_patient`
- `idx_prescription_record`

## Installation

1. Ensure MySQL is installed on your system
2. Run the SQL script:
```bash
mysql -u your_username -p < clinic_booking_system.sql
```

## Sample Data

The database comes pre-populated with sample data for:
- 5 medical specialties
- 5 doctors
- 5 patients
- 5 appointments
- 5 medical records
- 5 medications
- 5 prescriptions

## Usage Examples

### View Upcoming Appointments
```sql
SELECT * FROM upcoming_appointments;
```

### View Patient Medical History
```sql
SELECT * FROM patient_medical_history WHERE patient_id = 1;
```

### Schedule New Appointment
```sql
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, reason)
VALUES (1, 1, '2024-03-25', '10:00:00', 'Regular checkup');
```

### Add New Medical Record
```sql
INSERT INTO medical_records (patient_id, doctor_id, diagnosis, prescription, notes)
VALUES (1, 1, 'Hypertension', 'Blood pressure medication', 'Regular monitoring required');
```

## Data Integrity

The database maintains data integrity through:
- Primary and Foreign Key constraints
- Unique constraints on email addresses and license numbers
- NOT NULL constraints on required fields
- ENUM types for status fields and blood types
- Default values for timestamps and status fields

## Security Considerations

- Email addresses are unique to prevent duplicate accounts
- License numbers are unique for doctors
- Sensitive medical information is properly structured
- Timestamps track all record creation times

## Maintenance

Regular maintenance tasks:
1. Monitor appointment statuses
2. Update doctor availability
3. Archive old medical records
4. Update medication inventory
5. Review and update patient information

## Contributing

Feel free to submit issues and enhancement requests! 
