-- Active: 1728400145529@@127.0.0.1@3306@school_management
-- Step 1: Create the school_management database
CREATE DATABASE school_management;

-- Step 2: Use the newly created database
USE school_management;

-- Step 3: Create the students table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each student
    first_name VARCHAR(50),                     -- Student's first name
    last_name VARCHAR(50),                      -- Student's last name
    age INT,                                    -- Student's age
    class_id INT                                -- Foreign key linking to the class
);

-- Step 4: Create the teachers table
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each teacher
    first_name VARCHAR(50),                     -- Teacher's first name
    last_name VARCHAR(50),                      -- Teacher's last name
    subject_id INT                              -- Foreign key linking to the subject
);

-- Step 5: Create the classes table
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique identifier for each class
    class_name VARCHAR(50)                      -- Name of the class (e.g., Grade 1)
);

-- Step 6: Create the subjects table
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each subject
    subject_name VARCHAR(50)                    -- Name of the subject (e.g., Mathematics)
);

-- Step 7: Create the student_subjects table
CREATE TABLE student_subjects (
    student_id INT,                             -- Foreign key referencing student
    subject_id INT,                             -- Foreign key referencing subject
    FOREIGN KEY (student_id) REFERENCES students(student_id),  -- Ensures valid student_id
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)   -- Ensures valid subject_id
);

-- Step 8: Create the teacher_subjects table
CREATE TABLE teacher_subjects (
    teacher_id INT,                             -- Foreign key referencing teacher
    subject_id INT,                             -- Foreign key referencing subject
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),  -- Ensures valid teacher_id
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)   -- Ensures valid subject_id
);

-- Step 9: Insert sample data into students table
INSERT INTO students (first_name, last_name, age, class_id) VALUES
('John', 'Doe', 14, 1),
('Emma', 'Stone', 13, 2),
('Liam', 'Brown', 15, 3),
('Olivia', 'Johnson', 14, 1),
('Sophia', 'Wilson', 13, 2);

-- Step 10: Insert sample data into teachers table
INSERT INTO teachers (first_name, last_name, subject_id) VALUES
('Michael', 'Smith', 1),
('Emily', 'Davis', 2),
('Daniel', 'Garcia', 3),
('Linda', 'Martinez', 4);

-- Step 11: Insert sample data into classes table
INSERT INTO classes (class_name) VALUES
('Grade 1'),
('Grade 2'),
('Grade 3');

-- Step 12: Insert sample data into subjects table
INSERT INTO subjects (subject_name) VALUES
('Mathematics'),
('Science'),
('English'),
('History');

-- Step 13: Insert sample data into student_subjects table
INSERT INTO student_subjects (student_id, subject_id) VALUES
(1, 1), (1, 2),
(2, 2), (2, 3),
(3, 1), (3, 3), (3, 4),
(4, 1), (4, 4),
(5, 2), (5, 3);

-- Step 14: Insert sample data into teacher_subjects table
INSERT INTO teacher_subjects (teacher_id, subject_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 2),
(2, 3);

-- Step 15: Query - List all students with their first and last names
SELECT first_name, last_name FROM students;

-- Step 16: Query - Find the name and age of students who are 14 years old
SELECT first_name, last_name, age FROM students WHERE age = 14;

-- Step 17: Query - Show the names of all classes available in the school
SELECT class_name FROM classes;

-- Step 18: Query - List all teachers with their first and last names
SELECT first_name, last_name FROM teachers;

-- Step 19: Query - Display the names of all subjects taught in the school
SELECT subject_name FROM subjects;

-- Step 20: Query - Retrieve a list of students along with their class names
SELECT students.first_name, students.last_name, classes.class_name
FROM students
JOIN classes ON students.class_id = classes.class_id;

-- Step 21: Query - Find the subjects assigned to a specific student (student_id = 1)
SELECT subjects.subject_name
FROM student_subjects
JOIN subjects ON student_subjects.subject_id = subjects.subject_id
WHERE student_subjects.student_id = 1;

-- Step 22: Query - List all teachers who teach "Mathematics"
SELECT teachers.first_name, teachers.last_name
FROM teachers
JOIN teacher_subjects ON teachers.teacher_id = teacher_subjects.teacher_id
JOIN subjects ON teacher_subjects.subject_id = subjects.subject_id
WHERE subjects.subject_name = 'Mathematics';

-- Step 23: Query - Show the total number of students in each class
SELECT classes.class_name, COUNT(students.student_id) AS total_students
FROM students
JOIN classes ON students.class_id = classes.class_id
GROUP BY classes.class_name;

-- Step 24: Query - Display the names of all students who are enrolled in "Science"
SELECT students.first_name, students.last_name
FROM students
JOIN student_subjects ON students.student_id = student_subjects.student_id
JOIN subjects ON student_subjects.subject_id = subjects.subject_id
WHERE subjects.subject_name = 'Science';

