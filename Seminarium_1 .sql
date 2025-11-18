-- Ta bort tabeller om de redan finns (PostgreSQL-syntax)
DROP TABLE IF EXISTS salary_history CASCADE;
DROP TABLE IF EXISTS planned_activity CASCADE;
DROP TABLE IF EXISTS person_number CASCADE;
DROP TABLE IF EXISTS employee_skill CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS course_instance_study_year CASCADE;
DROP TABLE IF EXISTS course_instance CASCADE;
DROP TABLE IF EXISTS teaching_activity CASCADE;
DROP TABLE IF EXISTS study_year CASCADE;
DROP TABLE IF EXISTS study_period CASCADE;
DROP TABLE IF EXISTS skill_set CASCADE;
DROP TABLE IF EXISTS phone_number CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS job_title CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS course_layout CASCADE;
-- salary-tabellen är borttagen (den var tom/ogiltig)


CREATE TABLE course_layout (
  course_layout_id VARCHAR(10) PRIMARY KEY,
  course_code      VARCHAR(100) NOT NULL,
  course_name      VARCHAR(100) NOT NULL,
  hp               INT NOT NULL,
  min_students     INT NOT NULL,
  max_students     INT NOT NULL,
  valid_from_date  DATE,
  valid_to_date    DATE
);


CREATE TABLE department (
  department_id   INT PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL,
  manager         VARCHAR(100)
);


CREATE TABLE job_title (
  job_title_id INT PRIMARY KEY,
  job_title    VARCHAR(100) NOT NULL
);


CREATE TABLE person (
  person_id       INT PRIMARY KEY,
  personal_number VARCHAR(13) NOT NULL UNIQUE,   -- plats för personnummer med bindestreck
  first_name      VARCHAR(50) NOT NULL,
  last_name       VARCHAR(50) NOT NULL,
  address         VARCHAR(100)
);


CREATE TABLE phone_number (
  phone_id     INT PRIMARY KEY,
  phone_number VARCHAR(15) NOT NULL
);


CREATE TABLE skill_set (
  id         VARCHAR(100) PRIMARY KEY,
  skill_name VARCHAR(100) NOT NULL
);


CREATE TABLE study_period (
  study_period VARCHAR(100) PRIMARY KEY
);


CREATE TABLE study_year (
  study_year INT PRIMARY KEY
);


CREATE TABLE teaching_activity (
  id            INT PRIMARY KEY,
  activity_name VARCHAR(50) NOT NULL,
  factor        NUMERIC(5,2)
);


CREATE TABLE course_instance (
  instance_id       VARCHAR(100) PRIMARY KEY,
  study_period      VARCHAR(100),
  num_students      INT,
  course_layout_id  VARCHAR(10) NOT NULL,
  study_year        INT,
  FOREIGN KEY (course_layout_id) REFERENCES course_layout(course_layout_id),
  FOREIGN KEY (study_period)    REFERENCES study_period(study_period),
  FOREIGN KEY (study_year)      REFERENCES study_year(study_year)
);


CREATE TABLE course_instance_study_year (
  instance_id VARCHAR(100) PRIMARY KEY,
  FOREIGN KEY (instance_id) REFERENCES course_instance(instance_id)
);


CREATE TABLE employee (
  employment_id  VARCHAR(100) PRIMARY KEY,
  person_id      INT NOT NULL,
  department_id  INT NOT NULL,
  job_title_id   INT NOT NULL,
  supervisor_id  VARCHAR(100),
  FOREIGN KEY (person_id)     REFERENCES person(person_id),
  FOREIGN KEY (department_id) REFERENCES department(department_id),
  FOREIGN KEY (job_title_id)  REFERENCES job_title(job_title_id),
  FOREIGN KEY (supervisor_id) REFERENCES employee(employment_id)
);


CREATE TABLE employee_skill (
  skill_set_id   VARCHAR(100) NOT NULL,
  employment_id  VARCHAR(100) NOT NULL,
  PRIMARY KEY (skill_set_id, employment_id),
  FOREIGN KEY (skill_set_id)  REFERENCES skill_set(id),
  FOREIGN KEY (employment_id) REFERENCES employee(employment_id)
);


CREATE TABLE person_number (
  person_id INT NOT NULL,
  phone_id  INT NOT NULL,
  PRIMARY KEY (person_id, phone_id),
  FOREIGN KEY (person_id) REFERENCES person(person_id),
  FOREIGN KEY (phone_id)  REFERENCES phone_number(phone_id)
);


CREATE TABLE planned_activity (
  instance_id     VARCHAR(100) PRIMARY KEY,
  planned_hours   INT,
  teaching_id     INT,
  FOREIGN KEY (instance_id) REFERENCES course_instance(instance_id),
  FOREIGN KEY (teaching_id) REFERENCES teaching_activity(id)
);


CREATE TABLE salary_history (
  salary_id        VARCHAR(10) PRIMARY KEY,
  salary_amount    INT NOT NULL,
  valid_from_date  DATE,
  valid_to_date    DATE,
  version_number   INT,
  employment_id    VARCHAR(100) NOT NULL,
  FOREIGN KEY (employment_id) REFERENCES employee(employment_id)
);
