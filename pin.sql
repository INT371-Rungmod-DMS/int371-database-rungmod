DROP SCHEMA IF EXISTS `dorm` ;
CREATE SCHEMA IF NOT EXISTS `dorm` DEFAULT CHARACTER SET utf8 ;
USE dorm;
DROP TABLE IF EXISTS `assignReport`;
DROP TABLE IF EXISTS `reports`;
DROP TABLE IF EXISTS `reviewReports`;
DROP TABLE IF EXISTS `maintainer`;
DROP TABLE IF EXISTS `historyCus`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `room`;
DROP TABLE IF EXISTS `employeeWithDorm`;
DROP TABLE IF EXISTS `dorm`;
DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
	employeeId			VARCHAR(5)		NOT NULL,
    fname				VARCHAR(30)		NOT NULL,
    lname				VARCHAR(30)		NOT NULL,
    phone				CHAR(10)		NOT NULL,
    address				VARCHAR(80)		NOT NULL,
    sex					CHAR(1)			NOT NULL,
    email				VARCHAR(30)		NOT NULL,
    age					INT				NOT NULL,
    dateOfBirth			DATETIME		NOT NULL,
    position			VARCHAR(10)		NOT NULL,
    CONSTRAINT employeeId_pk PRIMARY KEY ( employeeId )
);

CREATE TABLE `dorm` (
	dormId				INT				NOT NULL,
    address				VARCHAR(120)	NOT NULL,
    phone				CHAR(10)		NOT NULL,
    email				VARCHAR(30)		NOT NULL,
    CONSTRAINT dormId_pk PRIMARY KEY ( dormId )
);

CREATE TABLE `employeeWithDorm` (
	employeeId			VARCHAR(5)		NOT NULL,
	dormId				INT				NOT NULL,
    CONSTRAINT empDorm_pk PRIMARY KEY ( employeeId, dormId ),
    CONSTRAINT employeeId_fk FOREIGN KEY ( employeeId ) REFERENCES `employee` ( employeeId ),
	CONSTRAINT dormId_fk FOREIGN KEY ( dormId ) REFERENCES `dorm` ( dormId )
);

CREATE TABLE `room` (
	roomId				INT				NOT NULL,
    roomNum				VARCHAR(10)		NOT NULL,
    floors				INT				NOT NULL,
    description			VARCHAR(120)	NOT NULL,
    status				CHAR(10)		NOT NULL,
    dormId				INT				NOT NULL,
    CONSTRAINT roomId_pk PRIMARY KEY ( roomId ),
    CONSTRAINT dormId_room_fk FOREIGN KEY ( dormId ) REFERENCES `dorm` ( dormId )
);

CREATE TABLE `customer` (
	customerId			VARCHAR(5)		NOT NULL,
    email				VARCHAR(30)		NOT NULL,
    password			VARCHAR(100)	NOT NULL,
    fname				VARCHAR(30)		NOT NULL,
    lname				VARCHAR(30)		NOT NULL,
    sex					CHAR(1)			NOT NULL,
    dateOfBirth			DATETIME		NOT NULL,
    age					INT				NOT NULL,
    phone				CHAR(10)		NOT NULL,
    address				VARCHAR(150)	NOT NULL,
    status				CHAR(10)		NOT NULL,
    CONSTRAINT customerId_pk PRIMARY KEY ( customerId )
);

CREATE TABLE `historyCus` (
	historyId			INT				NOT NULL,
    dateOfEntry			DATETIME		NOT NULL,
    dateOfIssue			DATETIME		NOT NULL,
    roomId				INT				NOT NULL,
    customerId			VARCHAR(5)		NOT NULL,
    CONSTRAINT historyId_pk PRIMARY KEY ( historyId ),
    CONSTRAINT roomId_fk FOREIGN KEY ( roomId ) REFERENCES `room` ( roomId ),
    CONSTRAINT customerId_fk FOREIGN KEY ( customerId ) REFERENCES `customer` ( customerId )
);

CREATE TABLE `maintainer` (
	maintainerId		VARCHAR(5)		NOT NULL,
    fname				VARCHAR(30)		NOT NULL,
    phone				CHAR(10)		NOT NULL,
    CONSTRAINT maintainerId_pk PRIMARY KEY ( maintainerId )
);

CREATE TABLE `reviewReports` (
	reviewId			INT				NOT NULL,
    des					VARCHAR(120)	NOT NULL,
    CONSTRAINT reviewId_pk PRIMARY KEY ( reviewId )
);

CREATE TABLE `reports` (
	reportId			INT				NOT NULL,
    title				VARCHAR(50)		NOT NULL,
    categoriesReport	VARCHAR(45)		NOT NULL,
    reportDes			VARCHAR(300)	NOT NULL,
    status				CHAR(10)		NOT NULL,
    successDate			DATETIME		NOT NULL,
    reportDate			DATETIME		NOT NUll,
    reviewId			INT				NOT NULL,
    CONSTRAINT reportId_pk PRIMARY KEY ( reportId ),
    CONSTRAINT reviewId_fk FOREIGN KEY ( reviewId ) REFERENCES `reviewReports` ( reviewId )
);

CREATE TABLE `assignReport` (
	assignId			VARCHAR(5)		NOT NULL,
    assignDate			DATETIME		NOT NULL,
    maintainerId		VARCHAR(5)		NOT NULL,
    employeeId			VARCHAR(5)		NOT NULL,
    reportId			INT				NOT NULL,
    CONSTRAINT assignRep_pk PRIMARY KEY ( assignId, reportId ),
    CONSTRAINT maintainerId_fk FOREIGN KEY ( maintainerId ) REFERENCES `maintainer` ( maintainerId ),
    CONSTRAINT employeeId_assign_fk FOREIGN KEY ( employeeId ) REFERENCES `employee` ( employeeId ),
    CONSTRAINT reportId_assignRep_fk FOREIGN KEY ( reportId ) REFERENCES `reports` ( reportId )
);

SELECT * FROM `employee`;
SELECT * FROM `dorm`;
SELECT * FROM `employeeWithDorm`;
SELECT * FROM `room`;
SELECT * FROM `customer`;
SELECT * FROM `historyCus`;
SELECT * FROM `maintainer`;
SELECT * FROM `reports`;
SELECT * FROM `assignReport`;