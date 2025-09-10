-- Dental Clinic Management System Database 

-- Patients
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100),
    date_of_birth DATE
);

-- Dentists
CREATE TABLE dentists (
    dentist_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(20)
);

-- Appointments
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    dentist_id INT,
    appointment_date DATETIME,
    status ENUM('scheduled','completed','cancelled') DEFAULT 'scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id)
);

-- Treatments
CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    cost DECIMAL(10,2)
);

-- Visits
CREATE TABLE visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT,
    treatment_id INT,
    notes VARCHAR(255),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);

-- Bills
CREATE TABLE bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT,
    total_amount DECIMAL(10,2),
    status ENUM('unpaid','paid','partial') DEFAULT 'unpaid',
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
);

-- Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT,
    amount DECIMAL(10,2),
    method ENUM('Cash','Card','M-PESA'),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id)
);

-- Staff
CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    role VARCHAR(50),
    phone VARCHAR(20)
);

-- Inventory
CREATE TABLE inventory (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    quantity INT,
    unit_cost DECIMAL(10,2)
);

-- Sample Data
INSERT INTO patients (name, phone, email, date_of_birth) VALUES
('James Mwangi', '0711002200', 'james@gmail.com', '1990-05-12'),
('Sarah Achieng', '0722334455', 'sarah@gmail.com', '1985-09-20');

INSERT INTO dentists (name, specialization, phone) VALUES
('Dr. Alice Njeri', 'Orthodontist', '0733445566'),
('Dr. Peter Ouma', 'General Dentist', '0744556677');

INSERT INTO treatments (name, cost) VALUES
('Teeth Cleaning', 3000),
('Tooth Extraction', 5000),
('Filling', 4000);

INSERT INTO appointments (patient_id, dentist_id, appointment_date) VALUES
(1, 1, '2025-09-15 10:00:00'),
(2, 2, '2025-09-16 14:30:00');

INSERT INTO visits (appointment_id, treatment_id, notes) VALUES
(1, 1, 'Routine cleaning completed successfully'),
(2, 2, 'Wisdom tooth extracted, follow-up in 1 week');

INSERT INTO bills (visit_id, total_amount, status) VALUES
(1, 3000, 'paid'),
(2, 5000, 'unpaid');

INSERT INTO payments (bill_id, amount, method) VALUES
(1, 3000, 'M-PESA');

INSERT INTO inventory (name, quantity, unit_cost) VALUES
('Dental Gloves', 200, 10),
('Anesthesia', 50, 500),
('Filling Material', 30, 1500);
