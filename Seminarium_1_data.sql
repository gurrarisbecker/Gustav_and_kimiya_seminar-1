-- BAS-TABELLER (utan FK)

INSERT INTO department (department_id, department_name, manager) VALUES
  (1, 'Computer Science', 'Dr. Alice'),
  (2, 'Mathematics',      'Dr. Bob');

INSERT INTO job_title (job_title_id, job_title) VALUES
  (1, 'Professor'),
  (2, 'Lecturer'),
  (3, 'Teaching Assistant');

INSERT INTO course_layout (course_layout_id, course_code, course_name, hp,
                           min_students, max_students, valid_from_date, valid_to_date)
VALUES
  ('CL1', 'IV1351', 'Data Storage Paradigms', 7, 10, 200, DATE '2025-01-01', NULL),
  ('CL2', 'AF2101', 'Concrete Structures',    7, 10, 150, DATE '2025-01-01', NULL);

INSERT INTO study_period (study_period) VALUES
  ('HT25-P1'),
  ('HT25-P2');

INSERT INTO study_year (study_year) VALUES
  (1), (2), (3);

INSERT INTO num_students (num_students) VALUES
  (80), (120), (150);

INSERT INTO person (person_id, personal_number, first_name, last_name, address) VALUES
  (1, '19900101-1234', 'Anna',  'Andersson', 'KTH Campus'),
  (2, '19851212-5678', 'Björn', 'Berg',      'Stockholm'),
  (3, '19950202-2345', 'Clara', 'Carlsson',  'Uppsala');

INSERT INTO phone_number (phone_id, phone_number) VALUES
  (1, '+46700000001'),
  (2, '+46700000002'),
  (3, '+46700000003');

INSERT INTO skill_set (id, skill_name) VALUES
  ('skill_sql',   'SQL'),
  ('skill_java',  'Java'),
  ('skill_teach', 'Teaching');

INSERT INTO teaching_activity (id, activity_name, factor) VALUES
  (1, 'Lecture', 1.0),
  (2, 'Exercise', 0.5),
  (3, 'Lab', 0.75);

-- TABELLER MED FK

INSERT INTO course_instance (instance_id, study_period, num_students,
                             course_layout_id, study_year)
VALUES
  ('CI1', 'HT25-P1', 120, 'CL1', 2),
  ('CI2', 'HT25-P2',  80, 'CL2', 3);

INSERT INTO course_instance_study_year (instance_id) VALUES
  ('CI1'),
  ('CI2');

INSERT INTO employee (employment_id, person_id, department_id,
                      job_title_id, supervisor_id)
VALUES
  ('emp1', 1, 1, 1, NULL),       -- Professor, ingen chef
  ('emp2', 2, 1, 2, 'emp1'),     -- Lecturer, chef = emp1
  ('emp3', 3, 2, 3, 'emp2');     -- TA, chef = emp2

INSERT INTO employee_skill (skill_set_id, employment_id) VALUES
  ('skill_sql',   'emp1'),
  ('skill_teach', 'emp1'),
  ('skill_java',  'emp2'),
  ('skill_sql',   'emp2'),
  ('skill_teach', 'emp3');

INSERT INTO person_number (person_id, phone_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3);

INSERT INTO planned_activity (instance_id, planned_hours, teaching_id) VALUES
  ('CI1', 20, 1),   -- 20h lectures för IV1351
  ('CI2', 15, 1);   -- 15h lectures för AF2101

INSERT INTO salary_history (salary_id, salary_amount, valid_from_date,
                            valid_to_date, version_number, employment_id)
VALUES
  ('S1', 50000, DATE '2025-01-01', NULL, 1, 'emp1'),
  ('S2', 42000, DATE '2025-01-01', NULL, 1, 'emp2'),
  ('S3', 32000, DATE '2025-01-01', NULL, 1, 'emp3');
