/*
--------------------------------------------
Project: Hospital Management Database
Author: [Your Name]
Description:
    This SQL script creates a database for managing 
    hospital operations, including doctors, patients, 
    appointments, medications, prescriptions, and billing.

    Database Name: Hospital Management

    Tables:
    1. Departments   - Stores information about hospital departments.
    2. Doctors       - Stores doctor details and their department.
    3. Patients      - Stores patient personal and contact details.
    4. Appointments  - Records patient appointments with doctors.
    5. Medications   - Lists available medicines with details.
    6. Prescriptions - Links patients, doctors, and medications.
    7. Billing       - Tracks patient payments and billing status.

Usage:
    - Run this script in Microsoft SQL Server Management Studio (SSMS)
      or any T-SQL compatible environment.
    - Make sure to execute each batch separated by 'GO'.

Version: 1.0
License: MIT (You can modify and distribute freely with attribution)
--------------------------------------------
*/


CREATE DATABASE [Hospital Managment];
GO
USE [Hospital Managment];
GO


CREATE TABLE Departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    location NVARCHAR(100)
);
GO


CREATE TABLE Doctors (
    doctor_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    specialization NVARCHAR(100),
    phone NVARCHAR(15),
    email NVARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2),
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
GO


CREATE TABLE Patients (
    patient_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    age INT,
    gender NVARCHAR(10) CHECK (gender IN ('Male','Female','Other')),
    phone NVARCHAR(15),
    address NVARCHAR(255),
    date_registered DATE DEFAULT GETDATE()
);
GO


CREATE TABLE Appointments (
    appointment_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason NVARCHAR(255),
    status NVARCHAR(20) CHECK (status IN ('Scheduled','Completed','Cancelled')) DEFAULT 'Scheduled',
    prescription_id INT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
GO


CREATE TABLE Medications (
    medication_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(10,2)
);
GO


CREATE TABLE Prescriptions (
    prescription_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage NVARCHAR(50),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);
GO


CREATE TABLE Billing (
    patient_id INT PRIMARY KEY,
    total_amount DECIMAL(10,2) NOT NULL,
    date_issued DATE DEFAULT GETDATE(),
    payment_status NVARCHAR(10) CHECK (payment_status IN ('Paid','Unpaid','Pending')) DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
GO
