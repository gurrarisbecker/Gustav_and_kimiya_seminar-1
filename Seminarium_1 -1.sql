CREATE TABLE "course_layout " (
 "course_layout_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL PRIMARY KEY,
 "course_code" VARCHAR(100) NOT NULL,
 "cours_name" VARCHAR(100) NOT NULL,
 "hp" FLOAT(10) NOT NULL,
 "min_students" INT NOT NULL,
 "max_students" INT NOT NULL,
 "valid_from_date" DATE NOT NULL,
 "valid_to_date " DATE
);


CREATE TABLE "department " (
 "department_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL PRIMARY KEY,
 "departent_name" VARCHAR(100) NOT NULL,
 "manager" VARCHAR(100)
);


CREATE TABLE "job_title " (
 "job_title_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL PRIMARY KEY,
 "job_title " VARCHAR(100) NOT NULL
);


CREATE TABLE "person " (
 "personal_number " VARCHAR(12) NOT NULL PRIMARY KEY,
 "frist_name" VARCHAR(10) NOT NULL,
 "adress" CHAR(100),
 "last_name" CHAR(100)
);


CREATE TABLE "phone_number " (
 "phone_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL PRIMARY KEY,
 "phone_number " VARCHAR(15) NOT NULL
);


CREATE TABLE "skill_set" (
 "skill_set_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL PRIMARY KEY,
 "skill_set" VARCHAR(100) NOT NULL
);


CREATE TABLE "study_period" (
 "study_period" VARCHAR(100) NOT NULL
);


CREATE TABLE "study_year" (
 "study_year" VARCHAR(100) NOT NULL
);


CREATE TABLE "teacher_rules" (
 "rule_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL PRIMARY KEY,
 "max_course_per_period" INT NOT NULL
);


CREATE TABLE "teaching_activity" (
 "teaching_activity_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL PRIMARY KEY,
 "activity_name" VARCHAR(100) NOT NULL,
 "factor" FLOAT(10)
);


CREATE TABLE "course_instace" (
 "instance_id" VARCHAR(100) NOT NULL PRIMARY KEY,
 "study_period " VARCHAR(100),
 "num_students " INT,
 "course_layout_id" INT NOT NULL,
 "study_year " INT,

 FOREIGN KEY ("course_layout_id") REFERENCES "course_layout " ("course_layout_id")
);


CREATE TABLE "course_instance_study_year " (
 "instance_id" VARCHAR(100) NOT NULL PRIMARY KEY,

 FOREIGN KEY ("instance_id") REFERENCES "course_instace" ("instance_id")
);


CREATE TABLE "employee" (
 "employment_id " VARCHAR(100) NOT NULL PRIMARY KEY,
 "department_id" INT NOT NULL,
 "job_title_id" INT NOT NULL,
 "supervisor/manager" VARCHAR(100),
 "personal_number " VARCHAR(12) NOT NULL,

 FOREIGN KEY ("department_id") REFERENCES "department " ("department_id"),
 FOREIGN KEY ("job_title_id") REFERENCES "job_title " ("job_title_id"),
 FOREIGN KEY ("personal_number ") REFERENCES "person " ("personal_number ")
);


CREATE TABLE "employee_skill" (
 "skill_set_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL,
 "employment_id " VARCHAR(100) NOT NULL,

 PRIMARY KEY ("skill_set_id","employment_id "),

 FOREIGN KEY ("skill_set_id") REFERENCES "skill_set" ("skill_set_id"),
 FOREIGN KEY ("employment_id ") REFERENCES "employee" ("employment_id ")
);


CREATE TABLE "person_number" (
 "phone_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL,
 "personal_number " VARCHAR(12) NOT NULL,

 PRIMARY KEY ("phone_id","personal_number "),

 FOREIGN KEY ("phone_id") REFERENCES "phone_number " ("phone_id"),
 FOREIGN KEY ("personal_number ") REFERENCES "person " ("personal_number ")
);


CREATE TABLE "planned_activity" (
 "instance_id" VARCHAR(100) NOT NULL PRIMARY KEY,
 "planned_hours " INT,
 "teaching_activity_id" INT,

 FOREIGN KEY ("instance_id") REFERENCES "course_instace" ("instance_id"),
 FOREIGN KEY ("teaching_activity_id") REFERENCES "teaching_activity" ("teaching_activity_id")
);


CREATE TABLE "salary_history " (
 "salary_id" INTGENERATEDALLWAYSASIDENTITY NOT NULL PRIMARY KEY,
 "salay_amount " INT,
 "valid_from_date" DATE,
 "valid_to_date" DATE,
 "version_number" INT,
 "employment_id " VARCHAR(100) NOT NULL,

 FOREIGN KEY ("employment_id ") REFERENCES "employee" ("employment_id ")
);
