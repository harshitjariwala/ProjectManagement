# 📋 Project Management Tool

A robust web-based Project & Task Management System built using JSP, Servlets, and Oracle SQL. Designed for teams to track projects and manage tasks efficiently with a clean, responsive UI and visual reports.

## ✨ Features

* **🔐 Role-Based Access**:

  * **Admin**: Add/view/update/delete users, projects, and tasks. Assign tasks to users.
  * **User**: View assigned tasks, update task status.

* **📊 Reports Dashboard**:
  View visual insights with **Chart.js** for task distribution and completion status.

* **🌓 Light/Dark Mode**:
  Toggle theme support and responsive layout using **Bootstrap 5**.

---

## 🛠️ Tech Stack

| Layer    | Technology                          |
| -------- | ----------------------------------- |
| Frontend | JSP, HTML, CSS, Bootstrap, Chart.js |
| Backend  | Java Servlets, JSP, JDBC            |
| Database | Oracle SQL                          |
| Server   | Apache Tomcat (v9+)                 |
| IDE      | Eclipse IDE                         |

---

## 🚀 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/harshitjariwala/ProjectManagement.git
cd ProjectManagement
```

### 2. Database Setup (Oracle SQL)

* Create a database schema named `projectdb` (or your preferred name).
* Run the SQL script to create the required tables: `users`, `projects`, `tasks`.

Example schema snippet:

```sql
CREATE TABLE PROJECT_MANAGEMENT_USERS (USER_ID NUMBER PRIMARY KEY, FIRST_NAME VARCHAR(40) NOT NULL, LAST_NAME VARCHAR(40), EMAIL VARCHAR(40) NOT NULL, PASSWORD VARCHAR(40) NOT NULL, ROLE VARCHAR(10) NOT NULL);

CREATE TABLE PROJECT_MANAGEMENT_PROJECTS (PROJECT_ID NUMBER PRIMARY KEY, TITLE VARCHAR(40) NOT NULL, DESCRIPTION VARCHAR(100), ACTIVE VARCHAR(20) NOT NULL);

CREATE TABLE PROJECT_MANAGEMENT_TASKS (TASK_ID NUMBER PRIMARY KEY, PROJECT_ID NUMBER REFERENCES PROJECT_MANAGEMENT_PROJECTS, TASK_DETAIL VARCHAR(40) NOT NULL, ASSIGNED_BY NUMBER REFERENCES PROJECT_MANAGEMENT_USERS, ASSIGNED_TO NUMBER REFERENCES PROJECT_MANAGEMENT_USERS, REMARKS VARCHAR(100), STATUS VARCHAR(20) NOT NULL, ASSIGNED_DATE DATE NOT NULL, COMPLETION_DATE DATE);

CREATE SEQUENCE USER_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER USER_TRIGGER
BEFORE
INSERT
ON PROJECT_MANAGEMENT_USERS
FOR EACH ROW
BEGIN 
	IF :NEW.USER_ID IS NULL THEN 
		:NEW.USER_ID := USER_SEQUENCE.NEXTVAL;
	END IF;
	:NEW.FIRST_NAME := UPPER(:NEW.FIRST_NAME);
	:NEW.LAST_NAME := UPPER(:NEW.LAST_NAME);
END;
/

CREATE OR REPLACE TRIGGER USER_TRIGGER_2
BEFORE
UPDATE
ON PROJECT_MANAGEMENT_USERS
FOR EACH ROW
BEGIN 
	:NEW.FIRST_NAME := UPPER(:NEW.FIRST_NAME);
	:NEW.LAST_NAME := UPPER(:NEW.LAST_NAME);
END;
/

CREATE SEQUENCE PROJECT_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER PROJECT_TRIGGER
BEFORE 
INSERT
ON PROJECT_MANAGEMENT_PROJECTS
FOR EACH ROW
BEGIN
	IF :NEW.PROJECT_ID IS NULL THEN 
		:NEW.PROJECT_ID := PROJECT_SEQUENCE.NEXTVAL;
	END IF;
END;
/

CREATE OR REPLACE SEQUENCE TASK_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TASK_TRIGGER
BEFORE 
INSERT
ON PROJECT_MANAGEMENT_TASKS
FOR EACH ROW
BEGIN
	IF :NEW.TASK_ID IS NULL THEN
		:NEW.TASK_ID := TASK_SEQUENCE.NEXTVAL;
	END IF;
END;
/
```

* Update your JDBC connection settings in the `DBConnection.java` file:

```java
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String username = "your_db_username";
String password = "your_db_password";
```

### 3. Import Project in Eclipse

* Open **Eclipse IDE**
* File → Import → **Existing Projects into Workspace**
* Choose the cloned project folder and finish importing.

### 4. Configure Tomcat

* Add **Apache Tomcat** to your Eclipse runtime environments.
* Right-click the project → **Run on Server**.

---

## 📸 Demo Screenshots

| Admin Dashboard                           | Dark Mode                          | Reports View                       |
| ----------------------------------------- | ---------------------------------- | ---------------------------------- |
| ![admin](screenshots/admin-dashboard.png) | ![dark](screenshots/dark-mode.png) | ![report](screenshots/reports.png) |

> 📌 *Screenshots are located inside the `screenshots/` folder. You can update these with your own UI.*

---

## 🤝 Contributing

Feel free to fork this repository and open a pull request for feature improvements, bug fixes, or enhancements.

---

## 📧 Contact

**Harshit Jariwala**
📧 [harshitjariwala7178@gmail.com](mailto:harshitjariwala7178@gmail.com)
🔗 [LinkedIn](https://www.linkedin.com/in/harshit-jariwala-782a0a370/)

