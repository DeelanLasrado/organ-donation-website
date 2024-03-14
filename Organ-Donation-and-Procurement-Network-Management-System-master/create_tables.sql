CREATE DATABASE DBMS_PROJECT;
USE DBMS_PROJECT;

CREATE TABLE login(
    username VARCHAR(20) NOT NULL,
    password VARCHAR(20) NOT NULL
);

INSERT INTO login VALUES ('admin','admin');

#table 1
CREATE TABLE User(
    User_ID int NOT NULL,
    Name varchar(20) NOT NULL,
    Date_of_Birth date NOT NULL,
    Medical_insurance int,
    Medical_history varchar(20),
    Street varchar(20),
    City varchar(20),
    State varchar(20),
    PRIMARY KEY(User_ID)
);

#table 2
CREATE TABLE User_phone_no(
    User_ID int NOT NULL,
    phone_no varchar(15),
    FOREIGN KEY(User_ID) REFERENCES User(User_ID) ON DELETE CASCADE
);

#table 3
CREATE TABLE Organization(
  Organization_ID int NOT NULL,
  Organization_name varchar(20) NOT NULL,
  Location varchar(20),
  Government_approved int, # 0 or 1
  PRIMARY KEY(Organization_ID)
);

#table 4
CREATE TABLE Doctor(
  Doctor_ID int NOT NULL,
  Doctor_Name varchar(20) NOT NULL,
  Department_Name varchar(20) NOT NULL,
  organization_ID int NOT NULL,
  FOREIGN KEY(organization_ID) REFERENCES Organization(organization_ID) ON DELETE CASCADE,
  PRIMARY KEY(Doctor_ID)
);

#table 5
CREATE TABLE Patient(
    Patient_ID int NOT NULL,
    organ_req varchar(20) NOT NULL,
    reason_of_procurement varchar(20),
    Doctor_ID int NOT NULL,
    User_ID int NOT NULL,
    FOREIGN KEY(User_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
    FOREIGN KEY(Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE,
    PRIMARY KEY(Patient_Id, organ_req)
);

#table 6
CREATE TABLE Donor(
  Donor_ID int NOT NULL,
  organ_donated varchar(20) NOT NULL,
  reason_of_donation varchar(20),
  Organization_ID int NOT NULL,
  User_ID int NOT NULL,
  FOREIGN KEY(User_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
  FOREIGN KEY(Organization_ID) REFERENCES Organization(Organization_ID) ON DELETE CASCADE,
  PRIMARY KEY(Donor_ID, organ_donated)
);

#table 7
CREATE TABLE Organ_available(
  Organ_ID int NOT NULL AUTO_INCREMENT,
  Organ_name varchar(20) NOT NULL,
  Donor_ID int NOT NULL,
  FOREIGN KEY(Donor_ID) REFERENCES Donor(Donor_ID) ON DELETE CASCADE,
  PRIMARY KEY(Organ_ID)
);

#table 8
CREATE TABLE Transaction(
  Patient_ID int NOT NULL,
  Organ_ID int NOT NULL,
  Donor_ID int NOT NULL,
  Date_of_transaction date NOT NULL,
  Status int NOT NULL, #0 or 1
  FOREIGN KEY(Patient_ID) REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
  FOREIGN KEY(Donor_ID) REFERENCES Donor(Donor_ID) ON DELETE CASCADE,
  PRIMARY KEY(Patient_ID,Organ_ID)
);

#table 9
CREATE TABLE Organization_phone_no(
  Organization_ID int NOT NULL,
  Phone_no varchar(15),
  FOREIGN KEY(Organization_ID) REFERENCES Organization(Organization_ID) ON DELETE CASCADE
);

#table 10
CREATE TABLE Doctor_phone_no(
  Doctor_ID int NOT NULL,
  Phone_no varchar(15),
  FOREIGN KEY(Doctor_ID) REFERENCES Doctor(Doctor_ID) ON DELETE CASCADE
);

#table 11
CREATE TABLE Organization_head(
  Organization_ID int NOT NULL,
  Employee_ID int NOT NULL,
  Name varchar(20) NOT NULL,
  Date_of_joining date NOT NULL,
  Term_length int NOT NULL,
  FOREIGN KEY(Organization_ID) REFERENCES Organization(Organization_ID) ON DELETE CASCADE,
  PRIMARY KEY(Organization_ID,Employee_ID)
);
--
-- delimiter //
-- create trigger ADD_DONOR
-- after insert
-- on Donor
-- for each row
-- begin
-- insert into Organ_available(Organ_name, Donor_ID)
-- values (new.organ_donated, new.Donor_ID);
-- end//
-- delimiter ;
--
-- delimiter //
-- create trigger REMOVE_ORGAN
-- after insert
-- on Transaction
-- for each row
-- begin
-- delete from Organ_available
-- where Organ_ID = new.Organ_ID;
-- end//
-- delimiter ;

create table log (
  querytime datetime,
  comment varchar(255)
);

delimiter //
create trigger ADD_DONOR_LOG
after insert
on Donor
for each row
begin
insert into log values
(now(), concat("Inserted new Donor", cast(new.Donor_Id as char)));
end //

create trigger UPD_DONOR_LOG
after update
on Donor
for each row
begin
insert into log values
(now(), concat("Updated Donor Details", cast(new.Donor_Id as char)));
end //

delimiter //
create trigger DEL_DONOR_LOG
after delete
on Donor
for each row
begin
insert into log values
(now(), concat("Deleted Donor ", cast(old.Donor_Id as char)));
end //

create trigger ADD_PATIENT_LOG
after insert
on Patient
for each row
begin
insert into log values
(now(), concat("Inserted new Patient ", cast(new.Patient_Id as char)));
end //

create trigger UPD_PATIENT_LOG
after update
on Patient
for each row
begin
insert into log values
(now(), concat("Updated Patient Details ", cast(new.Patient_Id as char)));
end //

create trigger DEL_PATIENT_LOG
after delete
on Donor
for each row
begin
insert into log values
(now(), concat("Deleted Patient ", cast(old.Donor_Id as char)));
end //

create trigger ADD_TRASACTION_LOG
after insert
on Transaction
for each row
begin
insert into log values
(now(), concat("Added Transaction :: Patient ID : ", cast(new.Patient_ID as char), "; Donor ID : " ,cast(new.Donor_ID as char)));
end //

-- INSERT INTO User VALUES(10,'Random1','2000-01-01',1,NULL,'Street 1','City 1','State 1');
-- INSERT INTO User VALUES(20,'Random2','2000-01-02',1,NULL,'Street 2','City 2','State 2');


insert into User values
( 2 ,'Name-2','1975-12-10',0,'NIL','Street-2','Mumbai','Maharashtra'),
( 3 ,'Name-3','1976-6-4',0,'NIL','Street-3','Mumbai','Maharashtra'),
( 4 ,'Name-4','1985-10-13',1,'NIL','Street-4','Ahmedabad','Gujarat'),
( 5 ,'Name-5','1983-10-12',1,'NIL','Street-5','Kolkata','West Bengal'),
( 6 ,'Name-6','1977-1-18',1,'NIL','Street-6','Kolkata','West Bengal'),
( 7 ,'Name-7','1976-2-26',0,'NIL','Street-7','New Delhi','Delhi'),
( 8 ,'Name-8','1973-4-12',1,'NIL','Street-8','Mumbai','Maharashtra'),
( 9 ,'Name-9','1976-11-1',0,'NIL','Street-9','Mumbai','Maharashtra'),
( 10 ,'Name-10','1978-11-18',1,'NIL','Street-10','New Delhi','Delhi'),
( 11 ,'Name-11','1975-1-6',1,'NIL','Street-11','Mumbai','Maharashtra'),
( 12 ,'Name-12','1983-11-1',1,'NIL','Street-12','Mumbai','Maharashtra'),
( 13 ,'Name-13','1983-1-9',1,'NIL','Street-13','New Delhi','Delhi'),
( 14 ,'Name-14','1975-10-12',1,'NIL','Street-14','Mumbai','Maharashtra'),
( 15 ,'Name-15','1977-9-23',0,'NIL','Street-15','Ahmedabad','Gujarat'),
( 16 ,'Name-16','1982-11-29',1,'NIL','Street-16','New Delhi','Delhi'),
( 17 ,'Name-17','1974-3-19',0,'NIL','Street-17','Mumbai','Maharashtra'),
( 18 ,'Name-18','1973-10-27',0,'NIL','Street-18','New Delhi','Delhi'),
( 19 ,'Name-19','1980-3-18',0,'NIL','Street-19','Kolkata','West Bengal'),
( 20 ,'Name-20','1978-8-15',1,'NIL','Street-20','Kolkata','West Bengal'),
( 21 ,'Name-21','1975-10-12',1,'NIL','Street-21','Mumbai','Maharashtra'),
( 22 ,'Name-22','1983-2-19',1,'NIL','Street-22','Ahmedabad','Gujarat'),
( 23 ,'Name-23','1987-3-30',1,'NIL','Street-23','Mumbai','Maharashtra'),
( 24 ,'Name-24','1979-10-28',1,'NIL','Street-24','Ahmedabad','Gujarat'),
( 25 ,'Name-25','1987-7-26',1,'NIL','Street-25','Kolkata','West Bengal'),
( 26 ,'Name-26','1987-12-23',0,'NIL','Street-26','New Delhi','Delhi'),
( 27 ,'Name-27','1982-4-29',1,'NIL','Street-27','Kolkata','West Bengal'),
( 28 ,'Name-28','1984-3-9',0,'NIL','Street-28','Kolkata','West Bengal'),
( 29 ,'Name-29','1985-1-4',0,'NIL','Street-29','Mumbai','Maharashtra'),
( 30 ,'Name-30','1981-5-19',0,'NIL','Street-30','Kolkata','West Bengal'),
( 31 ,'Name-31','1981-11-5',1,'NIL','Street-31','New Delhi','Delhi'),
( 32 ,'Name-32','1975-7-6',1,'NIL','Street-32','New Delhi','Delhi'),
( 33 ,'Name-33','1984-9-4',1,'NIL','Street-33','New Delhi','Delhi'),
( 34 ,'Name-34','1985-6-9',1,'NIL','Street-34','New Delhi','Delhi'),
( 35 ,'Name-35','1984-11-16',0,'NIL','Street-35','Ahmedabad','Gujarat'),
( 36 ,'Name-36','1973-4-19',1,'NIL','Street-36','New Delhi','Delhi'),
( 37 ,'Name-37','1977-5-19',0,'NIL','Street-37','Kolkata','West Bengal'),
( 38 ,'Name-38','1985-5-10',0,'NIL','Street-38','New Delhi','Delhi'),
( 39 ,'Name-39','1975-4-2',0,'NIL','Street-39','Kolkata','West Bengal'),
( 40 ,'Name-40','1978-2-20',1,'NIL','Street-40','Mumbai','Maharashtra'),
( 41 ,'Name-41','1987-2-19',0,'NIL','Street-41','Mumbai','Maharashtra'),
( 42 ,'Name-42','1975-11-30',0,'NIL','Street-42','Mumbai','Maharashtra'),
( 43 ,'Name-43','1986-12-18',1,'NIL','Street-43','Mumbai','Maharashtra'),
( 44 ,'Name-44','1979-2-21',1,'NIL','Street-44','New Delhi','Delhi'),
( 45 ,'Name-45','1986-9-2',0,'NIL','Street-45','Ahmedabad','Gujarat'),
( 46 ,'Name-46','1983-12-13',0,'NIL','Street-46','Mumbai','Maharashtra'),
( 47 ,'Name-47','1977-9-28',0,'NIL','Street-47','Mumbai','Maharashtra'),
( 48 ,'Name-48','1979-1-9',1,'NIL','Street-48','Kolkata','West Bengal'),
( 49 ,'Name-49','1985-3-8',1,'NIL','Street-49','Mumbai','Maharashtra'),
( 50 ,'Name-50','1974-1-3',1,'NIL','Street-50','Mumbai','Maharashtra'),
( 51 ,'Name-51','1976-7-5',1,'NIL','Street-51','New Delhi','Delhi'),
( 52 ,'Name-52','1973-4-16',0,'NIL','Street-52','New Delhi','Delhi'),
( 53 ,'Name-53','1985-6-29',0,'NIL','Street-53','Ahmedabad','Gujarat'),
( 54 ,'Name-54','1976-4-2',0,'NIL','Street-54','Ahmedabad','Gujarat'),
( 55 ,'Name-55','1974-12-23',0,'NIL','Street-55','Ahmedabad','Gujarat'),
( 56 ,'Name-56','1982-2-8',0,'NIL','Street-56','Kolkata','West Bengal'),
( 57 ,'Name-57','1976-1-9',0,'NIL','Street-57','Kolkata','West Bengal'),
( 58 ,'Name-58','1982-2-12',1,'NIL','Street-58','New Delhi','Delhi'),
( 59 ,'Name-59','1974-3-17',0,'NIL','Street-59','Ahmedabad','Gujarat'),
( 60 ,'Name-60','1986-3-1',1,'NIL','Street-60','Mumbai','Maharashtra'),
( 61 ,'Name-61','1984-2-9',1,'NIL','Street-61','Mumbai','Maharashtra'),
( 62 ,'Name-62','1986-1-24',1,'NIL','Street-62','New Delhi','Delhi'),
( 63 ,'Name-63','1985-12-27',0,'NIL','Street-63','Kolkata','West Bengal'),
( 64 ,'Name-64','1973-6-29',0,'NIL','Street-64','Mumbai','Maharashtra'),
( 65 ,'Name-65','1984-4-6',1,'NIL','Street-65','Kolkata','West Bengal'),
( 66 ,'Name-66','1982-5-16',1,'NIL','Street-66','Ahmedabad','Gujarat'),
( 67 ,'Name-67','1979-5-10',0,'NIL','Street-67','Mumbai','Maharashtra'),
( 68 ,'Name-68','1984-8-7',1,'NIL','Street-68','New Delhi','Delhi'),
( 69 ,'Name-69','1987-2-24',0,'NIL','Street-69','Ahmedabad','Gujarat'),
( 70 ,'Name-70','1979-6-21',0,'NIL','Street-70','Mumbai','Maharashtra'),
( 71 ,'Name-71','1987-10-24',0,'NIL','Street-71','Kolkata','West Bengal'),
( 72 ,'Name-72','1983-6-7',1,'NIL','Street-72','Ahmedabad','Gujarat'),
( 73 ,'Name-73','1977-12-15',0,'NIL','Street-73','Mumbai','Maharashtra'),
( 74 ,'Name-74','1984-7-2',0,'NIL','Street-74','Ahmedabad','Gujarat'),
( 75 ,'Name-75','1986-3-24',1,'NIL','Street-75','Ahmedabad','Gujarat'),
( 76 ,'Name-76','1986-2-6',0,'NIL','Street-76','Kolkata','West Bengal'),
( 77 ,'Name-77','1977-11-6',1,'NIL','Street-77','Ahmedabad','Gujarat'),
( 78 ,'Name-78','1978-7-20',0,'NIL','Street-78','Ahmedabad','Gujarat'),
( 79 ,'Name-79','1983-4-29',1,'NIL','Street-79','Kolkata','West Bengal'),
( 80 ,'Name-80','1980-3-5',0,'NIL','Street-80','Ahmedabad','Gujarat'),
( 81 ,'Name-81','1986-12-17',1,'NIL','Street-81','New Delhi','Delhi'),
( 82 ,'Name-82','1983-1-1',1,'NIL','Street-82','Mumbai','Maharashtra'),
( 83 ,'Name-83','1979-2-3',1,'NIL','Street-83','Mumbai','Maharashtra'),
( 84 ,'Name-84','1984-4-16',0,'NIL','Street-84','Mumbai','Maharashtra'),
( 85 ,'Name-85','1985-10-18',1,'NIL','Street-85','Kolkata','West Bengal'),
( 86 ,'Name-86','1977-7-15',1,'NIL','Street-86','Mumbai','Maharashtra'),
( 87 ,'Name-87','1981-8-8',0,'NIL','Street-87','New Delhi','Delhi'),
( 88 ,'Name-88','1982-4-4',1,'NIL','Street-88','Mumbai','Maharashtra'),
( 89 ,'Name-89','1982-12-20',1,'NIL','Street-89','Ahmedabad','Gujarat'),
( 90 ,'Name-90','1983-4-8',1,'NIL','Street-90','Kolkata','West Bengal'),
( 91 ,'Name-91','1981-11-17',1,'NIL','Street-91','Ahmedabad','Gujarat'),
( 92 ,'Name-92','1986-8-10',1,'NIL','Street-92','Ahmedabad','Gujarat'),
( 93 ,'Name-93','1985-5-5',0,'NIL','Street-93','Ahmedabad','Gujarat'),
( 94 ,'Name-94','1977-1-10',0,'NIL','Street-94','Kolkata','West Bengal'),
( 95 ,'Name-95','1985-1-30',0,'NIL','Street-95','Ahmedabad','Gujarat'),
( 96 ,'Name-96','1987-2-4',1,'NIL','Street-96','Kolkata','West Bengal'),
( 97 ,'Name-97','1985-12-22',1,'NIL','Street-97','Kolkata','West Bengal'),
( 98 ,'Name-98','1981-8-6',1,'NIL','Street-98','Mumbai','Maharashtra'),
( 99 ,'Name-99','1978-1-15',1,'NIL','Street-99','Kolkata','West Bengal');

insert into User_phone_no values
(1,'Kidney','Reason-1',85,6),
(2,'Pancreas','Reason-2',13,10),
(3,'Heart','Reason-3',44,39),
(4,'Lung','Reason-4',88,49),
(5,'Lung','Reason-5',80,60),
(6,'Intestine','Reason-6',49,66),
(7,'Heart','Reason-7',8,90),
(8,'Heart','Reason-8',44,27),
(9,'Pancreas','Reason-9',39,84),
(10,'Lung','Reason-10',51,66),
(11,'Pancreas','Reason-11',57,40),
(12,'Kidney','Reason-12',11,68),
(13,'Kidney','Reason-13',47,32),
(14,'Intestine','Reason-14',51,43),
(15,'Heart','Reason-15',38,85),
(16,'Lung','Reason-16',32,70),
(17,'Lung','Reason-17',65,69),
(18,'Kidney','Reason-18',21,85),
(19,'Lung','Reason-19',28,58),
(20,'Pancreas','Reason-20',23,68),
(21,'Intestine','Reason-21',19,10),
(22,'Intestine','Reason-22',44,47),
(23,'Intestine','Reason-23',77,79),
(24,'Kidney','Reason-24',95,9),
(25,'Kidney','Reason-25',25,42),
(26,'Lung','Reason-26',30,89),
(27,'Heart','Reason-27',75,35),
(28,'Heart','Reason-28',70,35),
(29,'Heart','Reason-29',12,32),
(30,'Pancreas','Reason-30',18,60),
(31,'Lung','Reason-31',30,53),
(32,'Heart','Reason-32',19,97),
(33,'Heart','Reason-33',66,16),
(34,'Heart','Reason-34',9,2),
(35,'Pancreas','Reason-35',75,23),
(36,'Pancreas','Reason-36',94,47),
(37,'Lung','Reason-37',84,18),
(38,'Lung','Reason-38',45,71),
(39,'Lung','Reason-39',62,66),
(40,'Pancreas','Reason-40',98,59),
(41,'Heart','Reason-41',18,51),
(42,'Kidney','Reason-42',27,82),
(43,'Kidney','Reason-43',68,12),
(44,'Lung','Reason-44',46,64),
(45,'Kidney','Reason-45',11,60),
(46,'Heart','Reason-46',67,4),
(47,'Intestine','Reason-47',38,48),
(48,'Pancreas','Reason-48',26,33),
(49,'Heart','Reason-49',61,90),
(50,'Lung','Reason-50',71,64),
(51,'Kidney','Reason-51',86,91),
(52,'Lung','Reason-52',86,78),
(53,'Heart','Reason-53',28,30),
(54,'Pancreas','Reason-54',68,22),
(55,'Pancreas','Reason-55',49,21),
(56,'Kidney','Reason-56',28,45),
(57,'Intestine','Reason-57',65,97),
(58,'Pancreas','Reason-58',9,58),
(59,'Intestine','Reason-59',42,96),
(60,'Kidney','Reason-60',32,54),
(61,'Kidney','Reason-61',28,83),
(62,'Pancreas','Reason-62',4,55),
(63,'Kidney','Reason-63',6,72),
(64,'Lung','Reason-64',84,30),
(65,'Intestine','Reason-65',21,18),
(66,'Intestine','Reason-66',19,40),
(67,'Pancreas','Reason-67',1,43),
(68,'Pancreas','Reason-68',22,23),
(69,'Lung','Reason-69',6,9),
(70,'Lung','Reason-70',59,38),
(71,'Intestine','Reason-71',8,89),
(72,'Pancreas','Reason-72',23,14),
(73,'Heart','Reason-73',68,45),
(74,'Heart','Reason-74',99,89),
(75,'Intestine','Reason-75',96,56),
(76,'Heart','Reason-76',60,97),
(77,'Lung','Reason-77',46,37),
(78,'Lung','Reason-78',39,79),
(79,'Pancreas','Reason-79',97,68),
(80,'Heart','Reason-80',62,37),
(81,'Kidney','Reason-81',94,74),
(82,'Lung','Reason-82',71,14),
(83,'Kidney','Reason-83',10,5),
(84,'Kidney','Reason-84',83,69),
(85,'Intestine','Reason-85',33,86),
(86,'Pancreas','Reason-86',70,44),
(87,'Pancreas','Reason-87',62,64),
(88,'Heart','Reason-88',10,79),
(89,'Pancreas','Reason-89',11,41),
(90,'Kidney','Reason-90',3,86),
(91,'Lung','Reason-91',55,79),
(92,'Heart','Reason-92',86,11),
(93,'Pancreas','Reason-93',12,33),
(94,'Lung','Reason-94',38,15),
(95,'Kidney','Reason-95',87,89),
(96,'Kidney','Reason-96',19,64),
(97,'Heart','Reason-97',94,89),
(98,'Lung','Reason-98',26,70),
(99,'Heart','Reason-99',9,43),
(100,'Heart','Reason-100',31,1),
(101,'Pancreas','Reason-101',93,89),
(102,'Lung','Reason-102',39,10),
(103,'Lung','Reason-103',90,67),
(104,'Intestine','Reason-104',2,61),
(105,'Lung','Reason-105',96,43),
(106,'Heart','Reason-106',62,5),
(107,'Lung','Reason-107',66,17),
(108,'Pancreas','Reason-108',96,76),
(109,'Heart','Reason-109',68,49),
(110,'Lung','Reason-110',83,75),
(111,'Lung','Reason-111',38,95),
(112,'Kidney','Reason-112',66,71),
(113,'Intestine','Reason-113',90,20),
(114,'Lung','Reason-114',19,18),
(115,'Pancreas','Reason-115',96,27),
(116,'Heart','Reason-116',91,41),
(117,'Heart','Reason-117',61,85),
(118,'Heart','Reason-118',15,50),
(119,'Intestine','Reason-119',66,39),
(120,'Kidney','Reason-120',45,52),
(121,'Intestine','Reason-121',96,48),
(122,'Heart','Reason-122',83,64),
(123,'Kidney','Reason-123',85,55),
(124,'Kidney','Reason-124',39,45),
(125,'Heart','Reason-125',11,45),
(126,'Kidney','Reason-126',18,8),
(127,'Intestine','Reason-127',77,13),
(128,'Intestine','Reason-128',52,23),
(129,'Pancreas','Reason-129',63,93),
(130,'Pancreas','Reason-130',72,33),
(131,'Intestine','Reason-131',38,40),
(132,'Heart','Reason-132',30,65),
(133,'Pancreas','Reason-133',73,78),
(134,'Heart','Reason-134',88,10),
(135,'Pancreas','Reason-135',42,25),
(136,'Intestine','Reason-136',44,63),
(137,'Heart','Reason-137',59,8),
(138,'Kidney','Reason-138',12,24),
(139,'Lung','Reason-139',39,79),
(140,'Intestine','Reason-140',57,86),
(141,'Intestine','Reason-141',43,62),
(142,'Intestine','Reason-142',72,6),
(143,'Heart','Reason-143',30,9),
(144,'Heart','Reason-144',30,35),
(145,'Kidney','Reason-145',23,46),
(146,'Intestine','Reason-146',44,7),
(147,'Lung','Reason-147',61,1),
(148,'Pancreas','Reason-148',48,55),
(149,'Heart','Reason-149',31,35),
(150,'Intestine','Reason-150',69,39),
(151,'Intestine','Reason-151',27,76),
(152,'Lung','Reason-152',77,93),
(153,'Kidney','Reason-153',28,4),
(154,'Heart','Reason-154',70,36),
(155,'Pancreas','Reason-155',83,28),
(156,'Kidney','Reason-156',7,12),
(157,'Kidney','Reason-157',94,32),
(158,'Heart','Reason-158',18,52),
(159,'Lung','Reason-159',55,5),
(160,'Lung','Reason-160',42,96),
(161,'Heart','Reason-161',14,72),
(162,'Pancreas','Reason-162',59,86),
(163,'Lung','Reason-163',79,1),
(164,'Heart','Reason-164',71,94),
(165,'Intestine','Reason-165',45,7),
(166,'Pancreas','Reason-166',16,19),
(167,'Intestine','Reason-167',75,33),
(168,'Pancreas','Reason-168',20,79),
(169,'Kidney','Reason-169',45,21),
(170,'Heart','Reason-170',83,67),
(171,'Kidney','Reason-171',96,73),
(172,'Lung','Reason-172',13,41),
(173,'Lung','Reason-173',2,67),
(174,'Kidney','Reason-174',68,53),
(175,'Lung','Reason-175',85,76),
(176,'Lung','Reason-176',33,33),
(177,'Lung','Reason-177',95,16),
(178,'Kidney','Reason-178',22,69),
(179,'Lung','Reason-179',69,88),
(180,'Kidney','Reason-180',35,49),
(181,'Heart','Reason-181',65,61),
(182,'Lung','Reason-182',56,19),
(183,'Lung','Reason-183',22,53),
(184,'Intestine','Reason-184',53,35),
(185,'Pancreas','Reason-185',89,85),
(186,'Kidney','Reason-186',33,14),
(187,'Heart','Reason-187',63,29),
(188,'Pancreas','Reason-188',61,44),
(189,'Heart','Reason-189',30,26),
(190,'Lung','Reason-190',11,43),
(191,'Lung','Reason-191',26,34),
(192,'Lung','Reason-192',93,79),
(193,'Pancreas','Reason-193',22,57),
(194,'Intestine','Reason-194',69,47),
(195,'Intestine','Reason-195',6,58),
(196,'Pancreas','Reason-196',22,41),
(197,'Kidney','Reason-197',18,22),
(198,'Heart','Reason-198',98,20),
(199,'Lung','Reason-199',80,38);
