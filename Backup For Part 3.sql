prompt Creating ACTIVITIES...
create table ACTIVITIES
(
  contact_number VARCHAR2(20) not null,
  activity_type  VARCHAR2(100) not null,
  operator_name  VARCHAR2(100) not null
)
alter table ACTIVITIES
  add primary key (CONTACT_NUMBER);
alter table ACTIVITIES
  add unique (OPERATOR_NAME);

prompt Creating CATERING...
create table CATERING
(
  phone_number  VARCHAR2(10) not null,
  kashrut       VARCHAR2(20) not null,
  location      VARCHAR2(30) not null,
  c_id          INTEGER not null,
  catering_name VARCHAR2(30) not null,
  celiac        VARCHAR2(3) default 'NO'
);
alter table CATERING
  add primary key (C_ID);
alter table CATERING
  add constraint UNIQUE_CATERING_NAME unique (CATERING_NAME);
alter table CATERING
  add check (CELIAC IN ('YES', 'NO'));

prompt Creating CHILD...
create table CHILD
(
  child_id   INTEGER not null,
  child_dob  DATE not null,
  child_name VARCHAR2(100) not null,
  celiac     VARCHAR2(3) default 'NO'
);
alter table CHILD
  add primary key (CHILD_ID);
alter table CHILD
  add check (CELIAC IN ('YES', 'NO'));

prompt Creating DAYCARE...
create table DAYCARE
(
  sector       VARCHAR2(100) not null,
  daycare_name VARCHAR2(100) not null,
  location     VARCHAR2(100) not null,
  open_time    DATE not null,
  close_time   DATE not null,
  d_id         INTEGER not null,
  c_id         INTEGER
);
alter table DAYCARE
  add primary key (D_ID);
alter table DAYCARE
  add constraint DC_C_ID_FK foreign key (C_ID)
  references CATERING (C_ID);
alter table DAYCARE
  add constraint CHECK_OPENING_CLOSING_HOURS
  check (Close_time > Open_time);

prompt Creating DAYCARE_ACTIVITIES...
create table DAYCARE_ACTIVITIES
(
  d_id          INTEGER not null,
  operator_name VARCHAR2(100) not null
);
alter table DAYCARE_ACTIVITIES
  add primary key (D_ID, OPERATOR_NAME);
alter table DAYCARE_ACTIVITIES
  add foreign key (D_ID)
  references DAYCARE (D_ID);
alter table DAYCARE_ACTIVITIES
  add foreign key (OPERATOR_NAME)
  references ACTIVITIES (OPERATOR_NAME);

prompt Creating REGISTRATION...
create table REGISTRATION
(
  price             INTEGER not null,
  registration_id   INTEGER not null,
  registration_date DATE not null,
  d_id              INTEGER not null,
  child_id          INTEGER not null
);
alter table REGISTRATION
  add primary key (REGISTRATION_ID, D_ID);
alter table REGISTRATION
  add foreign key (D_ID)
  references DAYCARE (D_ID);
alter table REGISTRATION
  add foreign key (CHILD_ID)
  references CHILD (CHILD_ID);
alter table REGISTRATION
  add constraint CHECK_REGISTRATION_PRICE
  check (Price > 0);

prompt Creating TEACHER...
create table TEACHER
(
  t_id          INTEGER not null,
  teacher_name  VARCHAR2(100) not null,
  teacher_dob   DATE not null,
  degree        VARCHAR2(100) not null,
  teacher_phone VARCHAR2(20) not null,
  seniority     VARCHAR2(50) not null,
  d_id          INTEGER not null,
  salary        FLOAT
);
alter table TEACHER
  add primary key (T_ID);
alter table TEACHER
  add foreign key (D_ID)
  references DAYCARE (D_ID);

prompt Disabling triggers for ACTIVITIES...
alter table ACTIVITIES disable all triggers;
prompt Disabling triggers for CATERING...
alter table CATERING disable all triggers;
prompt Disabling triggers for CHILD...
alter table CHILD disable all triggers;
prompt Disabling triggers for DAYCARE...
alter table DAYCARE disable all triggers;
prompt Disabling triggers for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES disable all triggers;
prompt Disabling triggers for REGISTRATION...
alter table REGISTRATION disable all triggers;
prompt Disabling triggers for TEACHER...
alter table TEACHER disable all triggers;
prompt Disabling foreign key constraints for DAYCARE...
alter table DAYCARE disable constraint DC_C_ID_FK;
prompt Disabling foreign key constraints for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES disable constraint SYS_C00716350;
alter table DAYCARE_ACTIVITIES disable constraint SYS_C00716351;
prompt Disabling foreign key constraints for REGISTRATION...
alter table REGISTRATION disable constraint SYS_C00715726;
alter table REGISTRATION disable constraint SYS_C00715727;
prompt Disabling foreign key constraints for TEACHER...
alter table TEACHER disable constraint SYS_C00715736;
prompt Deleting TEACHER...
delete from TEACHER;
commit;
prompt Deleting REGISTRATION...
delete from REGISTRATION;
commit;
prompt Deleting DAYCARE_ACTIVITIES...
delete from DAYCARE_ACTIVITIES;
commit;
prompt Deleting DAYCARE...
delete from DAYCARE;
commit;
prompt Deleting CHILD...
delete from CHILD;
commit;
prompt Deleting CATERING...
delete from CATERING;
commit;
prompt Deleting ACTIVITIES...
delete from ACTIVITIES;
commit;
prompt Loading ACTIVITIES...
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0541234567', 'Art', 'Art in Love');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0542345678', 'Music', 'Musical Wonders');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0543456789', 'Dance', 'Dancing Stars');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0544567890', 'Sports', 'Sport Champions');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0545678901', 'Swimming', 'Swim Masters');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0546789012', 'Drama', 'Drama Queens');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0547890123', 'Science', 'Science Explorers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0548901234', 'Math', 'Math Geniuses');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0549012345', 'Cooking', 'Culinary Artists');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0550123456', 'Coding', 'Code Breakers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0551234567', 'Robotics', 'Robo Tech');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0552345678', 'Gardening', 'Green Thumbs');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0553456789', 'Chess', 'Chess Masters');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0554567890', 'Painting', 'Color Palette');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0555678901', 'Crafting', 'Craft Wizards');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0556789012', 'Puzzles', 'Puzzle Solvers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0557890123', 'Storytelling', 'Story Time');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0558901234', 'Language', 'Language Lovers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0559012345', 'Photography', 'Photo Snappers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0560123456', 'Debate', 'Debate Club');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0561234567', 'Yoga', 'Yoga Harmony');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0562345678', 'Zumba', 'Zumba Dancers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0563456789', 'Karate', 'Karate Kids');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0564567890', 'Ballet', 'Ballet Beauties');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0565678901', 'Pilates', 'Pilates Pros');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0566789012', 'Boxing', 'Boxing Champs');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0567890123', 'Soccer', 'Soccer Stars');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0568901234', 'Basketball', 'Basketball Heroes');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0569012345', 'Volleyball', 'Volleyball Victors');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0570123456', 'Handball', 'Handball Heroes');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0571234567', 'Hockey', 'Hockey Players');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0572345678', 'Tennis', 'Tennis Aces');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0573456789', 'Table Tennis', 'Ping Pong Masters');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0574567890', 'Running', 'Run Fast');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0575678901', 'Jump Rope', 'Jump Ropers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0576789012', 'Ice Skating', 'Ice Skaters');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0577890123', 'Skiing', 'Ski Experts');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0578901234', 'Skateboarding', 'Skateboard Riders');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0579012345', 'Surfing', 'Surf Riders');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0580123456', 'Sailing', 'Sailors Club');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0581234567', 'Mountain Biking', 'Mountain Bikers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0582345678', 'Rock Climbing', 'Rock Climbers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0583456789', 'Hiking', 'Hiking Crew');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0584567890', 'Fishing', 'Fishing Friends');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0585678901', 'Horse Riding', 'Horse Riders');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0586789012', 'Bird Watching', 'Bird Watchers');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0587890123', 'Camping', 'Campers Club');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0588901234', 'Archery', 'Archery Aces');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0589012345', 'Fencing', 'Fencing Warriors');
insert into ACTIVITIES (contact_number, activity_type, operator_name)
values ('0590123456', 'Cricket', 'Cricket Champs');
commit;
prompt 50 records loaded
prompt Loading CATERING...
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0541234567', 'rabanut', 'Tel Aviv', 1, 'Delicious Catering', 'YES');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0522345678', 'rabanut mehadrin', 'Jerusalem', 2, 'Jerusalem Catering', 'YES');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0503456789', 'eida charedit', 'Haifa', 3, 'Haifa Delights', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0534567890', 'rubin', 'Beer Sheva', 4, 'Negev Catering', 'YES');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0545678901', 'bet yosef', 'Eilat', 5, 'Eilat Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0526789012', 'mehuderet', 'Rishon LeZion', 6, 'Rishon Tastes', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0507890123', 'rabanut', 'Netanya', 7, 'Netanya Feasts', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0538901234', 'rabanut mehadrin', 'Petah Tikva', 8, 'Petah Delicacies', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0549012345', 'eida charedit', 'Ashdod', 9, 'Ashdod Catering', 'YES');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0520123456', 'rubin', 'Holon', 10, 'Holon Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0501234567', 'bet yosef', 'Bnei Brak', 11, 'Bnei Brak Tastes', 'YES');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0532345678', 'mehuderet', 'Bat Yam', 12, 'Bat Yam Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0543456789', 'rabanut', 'Herzliya', 13, 'Herzliya Delights', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0524567890', 'rabanut mehadrin', 'Kfar Saba', 14, 'Kfar Saba Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0505678901', 'eida charedit', 'Rehovot', 15, 'Rehovot Feasts', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0536789012', 'rubin', 'Ashkelon', 16, 'Ashkelon Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0547890123', 'bet yosef', 'Raanana', 17, 'Raanana Tastes', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0528901234', 'mehuderet', 'Modiin', 18, 'Modiin Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0509012345', 'rabanut', 'Nahariya', 19, 'Nahariya Delights', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0530123456', 'rabanut mehadrin', 'Afula', 20, 'Afula Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0541234567', 'eida charedit', 'Tiberias', 21, 'Tiberias Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0522345678', 'rubin', 'Yavne', 22, 'Yavne Feasts', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0503456789', 'bet yosef', 'Karmiel', 23, 'Karmiel Delights', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0534567890', 'mehuderet', 'Beit Shemesh', 24, 'Beit Shemesh Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0545678901', 'rabanut', 'Kiryat Gat', 25, 'Kiryat Gat Tastes', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0526789012', 'rabanut mehadrin', 'Hadera', 26, 'Hadera Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0507890123', 'eida charedit', 'Tzfat', 27, 'Tzfat Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0538901234', 'rubin', 'Arad', 28, 'Arad Feasts', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0549012345', 'bet yosef', 'Dimona', 29, 'Dimona Delights', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0520123456', 'mehuderet', 'Maale Adumim', 30, 'Maale Adumim Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0501234567', 'rabanut', 'Zichron Yaakov', 31, 'Zichron Yaakov Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0532345678', 'rabanut mehadrin', 'Rosh HaAyin', 32, 'Rosh HaAyin Feasts', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0543456789', 'eida charedit', 'Kiryat Shmona', 33, 'Kiryat Shmona Delights', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0524567890', 'rubin', 'Sderot', 34, 'Sderot Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0505678901', 'bet yosef', 'Ness Ziona', 35, 'Ness Ziona Tastes', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0536789012', 'mehuderet', 'Kiryat Yam', 36, 'Kiryat Yam Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0547890123', 'rabanut', 'Or Yehuda', 37, 'Or Yehuda Feasts', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0528901234', 'rabanut mehadrin', 'Migdal HaEmek', 38, 'Migdal HaEmek Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0509012345', 'eida charedit', 'Ramat HaSharon', 39, 'Ramat HaSharon Delights', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0530123456', 'rubin', 'Kiryat Malakhi', 40, 'Kiryat Malakhi Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0541234567', 'bet yosef', 'Ariel', 41, 'Ariel Feasts', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0522345678', 'mehuderet', 'Sakhnin', 42, 'Sakhnin Catering', 'NO');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name, celiac)
values ('0587154110', 'rabanut mehadrin', 'Beersheba', 43, 'CateringBeersheba', 'NO');
commit;
prompt 43 records loaded
prompt Loading CHILD...
insert into CHILD (child_id, child_dob, child_name, celiac)
values (1, to_date('10-05-2018', 'dd-mm-yyyy'), 'John Smith', 'YES');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (2, to_date('20-08-2017', 'dd-mm-yyyy'), 'Emily Davis', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (3, to_date('15-12-2016', 'dd-mm-yyyy'), 'Michael Johnson', 'YES');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (4, to_date('25-09-2015', 'dd-mm-yyyy'), 'Sarah Brown', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (5, to_date('05-11-2014', 'dd-mm-yyyy'), 'David Wilson', 'YES');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (6, to_date('30-01-2019', 'dd-mm-yyyy'), 'Olivia Miller', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (7, to_date('14-07-2017', 'dd-mm-yyyy'), 'James Moore', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (8, to_date('22-03-2018', 'dd-mm-yyyy'), 'Sophia Taylor', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (9, to_date('12-05-2016', 'dd-mm-yyyy'), 'William Anderson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (10, to_date('28-02-2015', 'dd-mm-yyyy'), 'Isabella Thomas', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (11, to_date('18-10-2014', 'dd-mm-yyyy'), 'Lucas Jackson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (12, to_date('01-04-2019', 'dd-mm-yyyy'), 'Mia White', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (13, to_date('11-11-2017', 'dd-mm-yyyy'), 'Benjamin Harris', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (14, to_date('09-06-2018', 'dd-mm-yyyy'), 'Charlotte Martin', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (15, to_date('21-09-2016', 'dd-mm-yyyy'), 'Henry Thompson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (16, to_date('16-08-2015', 'dd-mm-yyyy'), 'Amelia Garcia', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (17, to_date('27-07-2014', 'dd-mm-yyyy'), 'Alexander Martinez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (18, to_date('13-05-2019', 'dd-mm-yyyy'), 'Ava Robinson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (19, to_date('05-12-2017', 'dd-mm-yyyy'), 'Ethan Clark', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (20, to_date('14-02-2018', 'dd-mm-yyyy'), 'Harper Rodriguez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (21, to_date('06-03-2016', 'dd-mm-yyyy'), 'Mason Lewis', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (22, to_date('30-10-2015', 'dd-mm-yyyy'), 'Evelyn Lee', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (23, to_date('10-01-2014', 'dd-mm-yyyy'), 'Logan Walker', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (24, to_date('18-08-2019', 'dd-mm-yyyy'), 'Abigail Hall', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (25, to_date('23-03-2017', 'dd-mm-yyyy'), 'Aiden Allen', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (26, to_date('22-11-2018', 'dd-mm-yyyy'), 'Ella Young', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (27, to_date('11-02-2016', 'dd-mm-yyyy'), 'Daniel Hernandez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (28, to_date('12-12-2015', 'dd-mm-yyyy'), 'Lily King', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (29, to_date('07-06-2014', 'dd-mm-yyyy'), 'Jackson Wright', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (30, to_date('19-03-2019', 'dd-mm-yyyy'), 'Grace Lopez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (31, to_date('09-09-2017', 'dd-mm-yyyy'), 'Sebastian Hill', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (32, to_date('25-05-2018', 'dd-mm-yyyy'), 'Aria Scott', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (33, to_date('03-07-2016', 'dd-mm-yyyy'), 'Jack Green', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (34, to_date('19-04-2015', 'dd-mm-yyyy'), 'Zoe Adams', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (35, to_date('17-02-2014', 'dd-mm-yyyy'), 'Owen Baker', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (36, to_date('26-09-2019', 'dd-mm-yyyy'), 'Scarlett Gonzalez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (37, to_date('14-04-2017', 'dd-mm-yyyy'), 'Jacob Nelson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (38, to_date('30-08-2018', 'dd-mm-yyyy'), 'Victoria Carter', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (39, to_date('21-10-2016', 'dd-mm-yyyy'), 'Gabriel Mitchell', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (40, to_date('07-03-2015', 'dd-mm-yyyy'), 'Hannah Perez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (41, to_date('11-05-2014', 'dd-mm-yyyy'), 'Samuel Roberts', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (42, to_date('03-11-2019', 'dd-mm-yyyy'), 'Layla Turner', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (43, to_date('02-06-2017', 'dd-mm-yyyy'), 'Anthony Phillips', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (44, to_date('12-10-2018', 'dd-mm-yyyy'), 'Sofia Campbell', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (45, to_date('08-01-2016', 'dd-mm-yyyy'), 'Cameron Parker', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (46, to_date('20-11-2015', 'dd-mm-yyyy'), 'Ella Evans', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (47, to_date('02-09-2014', 'dd-mm-yyyy'), 'Matthew Edwards', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (48, to_date('15-07-2019', 'dd-mm-yyyy'), 'Avery Collins', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (49, to_date('16-01-2017', 'dd-mm-yyyy'), 'Nathan Stewart', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (50, to_date('28-12-2018', 'dd-mm-yyyy'), 'Madison Sanchez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (101, to_date('15-05-2016', 'dd-mm-yyyy'), 'Rivka  Cohen', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (102, to_date('15-05-2016', 'dd-mm-yyyy'), 'Noga Levi', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (103, to_date('15-05-2016', 'dd-mm-yyyy'), 'Child3', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (51, to_date('12-05-2018', 'dd-mm-yyyy'), 'Liam Johnson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (52, to_date('23-08-2017', 'dd-mm-yyyy'), 'Emma Martinez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (53, to_date('05-11-2016', 'dd-mm-yyyy'), 'Noah Rodriguez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (54, to_date('17-09-2015', 'dd-mm-yyyy'), 'Olivia Smith', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (55, to_date('30-11-2014', 'dd-mm-yyyy'), 'Lucas Brown', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (56, to_date('10-02-2019', 'dd-mm-yyyy'), 'Ava Davis', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (57, to_date('07-07-2017', 'dd-mm-yyyy'), 'Mia Wilson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (58, to_date('18-03-2018', 'dd-mm-yyyy'), 'Liam Thomas', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (59, to_date('09-05-2016', 'dd-mm-yyyy'), 'Ethan White', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (60, to_date('25-02-2015', 'dd-mm-yyyy'), 'Sophia Lee', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (61, to_date('03-11-2014', 'dd-mm-yyyy'), 'Mason Taylor', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (62, to_date('28-03-2019', 'dd-mm-yyyy'), 'Amelia Harris', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (63, to_date('16-11-2017', 'dd-mm-yyyy'), 'Michael Clark', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (64, to_date('14-06-2018', 'dd-mm-yyyy'), 'Alexis King', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (65, to_date('19-09-2016', 'dd-mm-yyyy'), 'Elijah Moore', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (66, to_date('20-08-2015', 'dd-mm-yyyy'), 'Harper Jackson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (67, to_date('25-07-2014', 'dd-mm-yyyy'), 'Logan Hall', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (68, to_date('03-05-2019', 'dd-mm-yyyy'), 'Isabella Nelson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (69, to_date('15-12-2017', 'dd-mm-yyyy'), 'Aiden Young', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (70, to_date('01-02-2018', 'dd-mm-yyyy'), 'Ellie Garcia', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (71, to_date('02-03-2016', 'dd-mm-yyyy'), 'James Perez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (72, to_date('13-10-2015', 'dd-mm-yyyy'), 'Charlotte Adams', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (73, to_date('22-01-2014', 'dd-mm-yyyy'), 'Benjamin Turner', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (74, to_date('28-08-2019', 'dd-mm-yyyy'), 'Mila Phillips', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (75, to_date('11-04-2017', 'dd-mm-yyyy'), 'Owen Evans', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (76, to_date('21-11-2018', 'dd-mm-yyyy'), 'Emily Miller', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (77, to_date('12-02-2016', 'dd-mm-yyyy'), 'Lucas Campbell', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (78, to_date('05-12-2015', 'dd-mm-yyyy'), 'Abigail Martinez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (79, to_date('10-06-2014', 'dd-mm-yyyy'), 'William Sanchez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (80, to_date('20-03-2019', 'dd-mm-yyyy'), 'Madison Hall', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (81, to_date('29-09-2017', 'dd-mm-yyyy'), 'Lincoln Baker', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (82, to_date('05-05-2018', 'dd-mm-yyyy'), 'Evelyn Collins', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (83, to_date('07-07-2016', 'dd-mm-yyyy'), 'Mila Thompson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (84, to_date('09-04-2015', 'dd-mm-yyyy'), 'Henry Wright', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (85, to_date('21-02-2014', 'dd-mm-yyyy'), 'Grace Robinson', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (86, to_date('26-09-2019', 'dd-mm-yyyy'), 'Sebastian Stewart', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (87, to_date('04-04-2017', 'dd-mm-yyyy'), 'Aria Perez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (88, to_date('11-08-2018', 'dd-mm-yyyy'), 'John Garcia', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (89, to_date('18-10-2016', 'dd-mm-yyyy'), 'Elizabeth Allen', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (90, to_date('27-03-2015', 'dd-mm-yyyy'), 'Nathan Thomas', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (91, to_date('01-05-2014', 'dd-mm-yyyy'), 'Lily Adams', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (92, to_date('02-11-2019', 'dd-mm-yyyy'), 'Landon Hernandez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (93, to_date('03-06-2017', 'dd-mm-yyyy'), 'Zoe Scott', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (94, to_date('22-10-2018', 'dd-mm-yyyy'), 'Ella Rodriguez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (95, to_date('10-01-2016', 'dd-mm-yyyy'), 'Lincoln Lee', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (96, to_date('12-11-2015', 'dd-mm-yyyy'), 'Aurora Turner', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (97, to_date('01-09-2014', 'dd-mm-yyyy'), 'Adam Harris', 'NO');
commit;
prompt 100 records committed...
insert into CHILD (child_id, child_dob, child_name, celiac)
values (98, to_date('16-07-2019', 'dd-mm-yyyy'), 'Leah Parker', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (99, to_date('27-01-2017', 'dd-mm-yyyy'), 'Hudson Perez', 'NO');
insert into CHILD (child_id, child_dob, child_name, celiac)
values (100, to_date('18-12-2018', 'dd-mm-yyyy'), 'Skylar Martinez', 'NO');
commit;
prompt 103 records loaded
prompt Loading DAYCARE...
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Rinas Daycare', ' Jerusalem', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 160, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Adinas Daycare', ' Tel Aviv', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 170, 8);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Shirs Daycare', ' Jerusalem', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 171, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Hallels Daycare', ' Tel Aviv', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 172, 8);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Little Stars', 'Tel Aviv', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Happy Kids', 'Jerusalem', to_date('31-05-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Sunshine Daycare', 'Haifa', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 3, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Play and Learn', 'Beersheba', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 4, 28);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Tiny Tots', 'Netanya', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 5, 7);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Kid''s Haven', 'Holon', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 6, 10);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Smiles Daycare', 'Rishon LeZion', to_date('31-05-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 7, 10);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Fun Time', 'Petah Tikva', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 8, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Children''s Corner', 'Ashdod', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 9, 9);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Little Angels', 'Bat Yam', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 10, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Happy Hearts', 'Bnei Brak', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 11, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Sunrise Daycare', 'Herzliya', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 12, 13);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Laughing Kids', 'Ramat Gan', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 13, 13);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Kids'' Paradise', 'Rehovot', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 14, 13);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Dreamland', 'Kfar Saba', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 15, 7);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Learning Tree', 'Ra''anana', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 16, 8);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Little Learners', 'Ramat Hasharon', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 17, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Happy Hands', 'Hadera', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 18, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Kid''s World', 'Hod Hasharon', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 19, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Smart Kids', 'Yavne', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 20, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Tiny Treasures', 'Modi''in', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 21, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Loving Care', 'Kiryat Gat', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 22, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Little Scholars', 'Ashkelon', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 23, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Kids'' Kingdom', 'Raanana', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 24, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Tiny Adventures', 'Beit Shemesh', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 25, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Playful Minds', 'Modi''in Illit', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 26, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Joyful Daycare', 'Giv''atayim', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 27, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Happy Times', 'Afula', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 28, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Kid''s Corner', 'Akko', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 29, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Learning Land', 'Yehud', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 30, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Little Explorers', 'Rosh HaAyin', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 31, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Smart Start', 'Dimona', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 32, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Happy Days', 'Netivot', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 33, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Little Stars', 'Tirat Carmel', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 34, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Happy Kids', 'Kfar Saba', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 35, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Sunshine Daycare', 'Nahariya', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 36, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Play and Learn', 'Ariel', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 37, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Tiny Tots', 'Ness Ziona', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 38, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Kid''s Haven', 'Or Akiva', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 39, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Smiles Daycare', 'Nesher', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 40, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Fun Time', 'Yokneam', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 41, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Children''s Corner', 'Ma''ale Adumim', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 42, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Little Angels', 'Karmiel', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 43, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Happy Hearts', 'Kiryat Bialik', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 44, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Sunrise Daycare', 'Kiryat Shmona', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 45, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Laughing Kids', 'Rehovot', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 46, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Kids'' Paradise', 'Hadera', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 47, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Dreamland', 'Kiryat Yam', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 48, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Learning Tree', 'Yavne', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 49, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Little Learners', 'Arad', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 50, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Sunshine Kids', 'Kiryat Malakhi', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 51, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Happy Days', 'Beit El', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), 52, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Little Wonders', 'Sderot', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 53, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Tiny Miracles', 'Maalot', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 54, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Kids World', 'Ofakim', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 55, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Smiles and Fun', 'Migdal HaEmek', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 56, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('Charedi', 'Happy_Days', 'eben gvirol st 10 tel aviv', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 60, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('Charedi', 'Child''s_Town', 'hayam rd 20 haifa', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 61, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('Charedi', 'Sunshine', 'jaffa st 100 jerusalem', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 62, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Happy Days', 'Beit El', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), 152, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Little Wonders', 'Sderot', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 153, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Tiny Miracles', 'Maalot', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 154, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Kids World', 'Ofakim', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 155, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Smiles and Fun', 'Migdal HaEmek', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 156, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Magic Moments', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 110, 42);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Little Lambs', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 111, 42);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Sunshine Smiles', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 112, 41);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Little Angels', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 113, 41);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Playtime Palace', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 114, 41);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Daycare1', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 115, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Sunshine Kids', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 116, 12);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Little Stars', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 117, 6);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Caring Kids', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 118, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Bright Beginnings', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 119, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Wonder World', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 120, 5);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Playful Preschool', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 121, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Growing Together', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 122, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Kinder Kids', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 123, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Fun Frolics', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 124, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Learning Ladder', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 125, 5);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Little Einsteins', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 126, 6);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Kidz Klub', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 127, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Happy Home', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 128, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Teddy Bear Daycare', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 129, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Wonderland', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 130, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Gan Shalom', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 67, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Sunshine Daycare', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 68, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Happy Kids', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 69, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Little Angels', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 70, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Tiny Tots', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 71, 5);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Busy Bees', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 73, 6);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Playful Pals', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 74, 7);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Smiling Faces', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 75, 8);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Happy Hearts', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 76, 9);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Rainbow Kids', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 77, 10);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Sunny Skies', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 78, 11);
commit;
prompt 100 records committed...
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Bright Beginnings', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 79, 12);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Little Learners', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 80, 13);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Happy Days', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 81, 14);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Tiny Treasures', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 82, 15);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Playtime Paradise', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 83, 16);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Fun Factory', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 84, 17);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Angelic Care', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 85, 18);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Kinder Garden', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 86, 19);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Growing Up', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 87, 20);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Shining Stars', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 88, 21);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Smart Start', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 89, 22);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Bright Minds', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 90, 23);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Little Explorers', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 91, 24);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Rainbow Daycare', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 92, 25);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Sunshine Kids', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 93, 26);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Dreamy Days', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 94, 27);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Happy Campers', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 95, 28);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Little Stars', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 96, 29);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Caring Kids', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 97, 30);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Bright Beginnings', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 98, 31);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Wonder World', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 99, 32);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Playful Preschool', ' Jerusalem', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 100, 33);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Growing Together', ' Tel Aviv', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 101, 34);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Kinder Kids', ' Haifa', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 102, 35);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Fun Frolics', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 103, 36);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Learning Ladder', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 104, 37);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Little Einsteins', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 105, 38);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Kidz Klub', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 106, 39);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Happy Home', ' Tel Aviv', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 107, 40);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Teddy Bear Daycare', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 108, 41);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Wonderland', ' Jerusalem', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 109, 42);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Magic Moments', ' Tel Aviv', to_date('09-06-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 131, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Little Lambs', ' Haifa', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 132, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Sunshine Smiles', ' Jerusalem', to_date('09-06-2024 13:45:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:45:00', 'dd-mm-yyyy hh24:mi:ss'), 133, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Little Angels', ' Tel Aviv', to_date('09-06-2024 14:15:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:15:00', 'dd-mm-yyyy hh24:mi:ss'), 134, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Playtime Palace', ' Haifa', to_date('09-06-2024 13:20:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:20:00', 'dd-mm-yyyy hh24:mi:ss'), 135, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Daycare1', ' Jerusalem', to_date('09-06-2024 13:10:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:10:00', 'dd-mm-yyyy hh24:mi:ss'), 136, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Sunshine Kids', ' Tel Aviv', to_date('09-06-2024 13:55:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:55:00', 'dd-mm-yyyy hh24:mi:ss'), 137, 12);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Little Stars', ' Haifa', to_date('09-06-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), 138, 6);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Caring Kids', ' Jerusalem', to_date('09-06-2024 13:40:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:40:00', 'dd-mm-yyyy hh24:mi:ss'), 139, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Bright Beginnings', ' Tel Aviv', to_date('09-06-2024 13:25:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:25:00', 'dd-mm-yyyy hh24:mi:ss'), 140, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Wonder World', ' Haifa', to_date('09-06-2024 13:50:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:50:00', 'dd-mm-yyyy hh24:mi:ss'), 141, 5);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Playful Preschool', ' Jerusalem', to_date('09-06-2024 14:10:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:10:00', 'dd-mm-yyyy hh24:mi:ss'), 142, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Growing Together', ' Tel Aviv', to_date('09-06-2024 13:35:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:35:00', 'dd-mm-yyyy hh24:mi:ss'), 143, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Kinder Kids', ' Haifa', to_date('09-06-2024 14:20:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:20:00', 'dd-mm-yyyy hh24:mi:ss'), 144, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Fun Frolics', ' Jerusalem', to_date('09-06-2024 13:15:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:15:00', 'dd-mm-yyyy hh24:mi:ss'), 145, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Learning Ladder', ' Tel Aviv', to_date('09-06-2024 13:05:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:05:00', 'dd-mm-yyyy hh24:mi:ss'), 146, 5);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Little Einsteins', ' Haifa', to_date('09-06-2024 13:45:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:45:00', 'dd-mm-yyyy hh24:mi:ss'), 147, 6);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Kidz Klub', ' Jerusalem', to_date('09-06-2024 14:25:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:25:00', 'dd-mm-yyyy hh24:mi:ss'), 148, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Happy Home', ' Tel Aviv', to_date('09-06-2024 13:55:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:55:00', 'dd-mm-yyyy hh24:mi:ss'), 149, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHILONI', ' Teddy Bear Daycare', ' Haifa', to_date('09-06-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 150, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Wonderland', ' Jerusalem', to_date('09-06-2024 14:15:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:15:00', 'dd-mm-yyyy hh24:mi:ss'), 151, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Morah Sarah', 'Beersheba', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 177, 43);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('chiloni', 'Tel Aviv Daycare', 'Tel Aviv', to_date('01-06-2024 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 18:00:00', 'dd-mm-yyyy hh24:mi:ss'), 63, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('dati', 'Jerusalem Daycare', 'Jerusalem', to_date('01-06-2024 12:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 18:30:00', 'dd-mm-yyyy hh24:mi:ss'), 64, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('chiloni', 'Haifa Daycare', 'Haifa', to_date('01-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 19:00:00', 'dd-mm-yyyy hh24:mi:ss'), 65, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('charedi', 'Negev Daycare', 'Beer Sheva', to_date('01-06-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 19:30:00', 'dd-mm-yyyy hh24:mi:ss'), 66, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('charedi', 'Holon Daycare', 'Holon', to_date('01-06-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 22:30:00', 'dd-mm-yyyy hh24:mi:ss'), 72, 10);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Cuties Daycare', ' Jerusalem', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 173, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' sunshine Daycare', ' Tel Aviv', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 174, 8);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' CHAREDI', ' Precious Moments', ' Jerusalem', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 175, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values (' DATI', ' Little Ones', ' Tel Aviv', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 176, 8);
commit;
prompt 162 records loaded
prompt Loading DAYCARE_ACTIVITIES...
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (1, 'Art in Love');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (2, 'Art in Love');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (2, 'Dancing Stars');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (2, 'Musical Wonders');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (2, 'Sport Champions');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (2, 'Swim Masters');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (3, 'Code Breakers');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (3, 'Culinary Artists');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (3, 'Drama Queens');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (3, 'Math Geniuses');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (3, 'Science Explorers');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (4, 'Chess Masters');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (4, 'Color Palette');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (4, 'Craft Wizards');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (4, 'Green Thumbs');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (4, 'Robo Tech');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (5, 'Art in Love');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (5, 'Dancing Stars');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (5, 'Musical Wonders');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (5, 'Sport Champions');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (5, 'Swim Masters');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (6, 'Code Breakers');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (6, 'Culinary Artists');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (6, 'Drama Queens');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (6, 'Math Geniuses');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (6, 'Science Explorers');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (7, 'Chess Masters');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (7, 'Color Palette');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (7, 'Craft Wizards');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (7, 'Green Thumbs');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (7, 'Robo Tech');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (9, 'Art in Love');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (9, 'Musical Wonders');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (10, 'Dancing Stars');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (10, 'Sport Champions');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (11, 'Swim Masters');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (12, 'Drama Queens');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (12, 'Science Explorers');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (13, 'Culinary Artists');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (13, 'Math Geniuses');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (14, 'Code Breakers');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (15, 'Robo Tech');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (17, 'Chess Masters');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (18, 'Green Thumbs');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (19, 'Color Palette');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (20, 'Craft Wizards');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (20, 'Dancing Stars');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (21, 'Dancing Stars');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (23, 'Dancing Stars');
insert into DAYCARE_ACTIVITIES (d_id, operator_name)
values (24, 'Dancing Stars');
commit;
prompt 50 records loaded
prompt Loading REGISTRATION...
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (2064, 1, to_date('01-06-2023', 'dd-mm-yyyy'), 4, 5);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1733, 3, to_date('14-06-2024', 'dd-mm-yyyy'), 6, 11);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1733, 2, to_date('14-06-2024', 'dd-mm-yyyy'), 6, 10);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (2064, 4, to_date('10-09-2023', 'dd-mm-yyyy'), 4, 6);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1650, 6, to_date('20-11-2023', 'dd-mm-yyyy'), 5, 7);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 7, to_date('15-12-2023', 'dd-mm-yyyy'), 5, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1733, 8, to_date('14-06-2024', 'dd-mm-yyyy'), 6, 12);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1650, 12, to_date('01-05-2022', 'dd-mm-yyyy'), 5, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1444, 14, to_date('05-07-2024', 'dd-mm-yyyy'), 5, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1050, 15, to_date('01-02-2024', 'dd-mm-yyyy'), 6, 10);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 16, to_date('15-01-2024', 'dd-mm-yyyy'), 8, 16);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 17, to_date('15-01-2024', 'dd-mm-yyyy'), 8, 17);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 18, to_date('15-01-2024', 'dd-mm-yyyy'), 8, 18);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 19, to_date('15-01-2024', 'dd-mm-yyyy'), 8, 19);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 20, to_date('15-01-2024', 'dd-mm-yyyy'), 8, 20);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 21, to_date('15-01-2024', 'dd-mm-yyyy'), 8, 21);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1313, 22, to_date('15-01-2024', 'dd-mm-yyyy'), 9, 22);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1313, 23, to_date('15-01-2024', 'dd-mm-yyyy'), 9, 23);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1155, 24, to_date('01-05-2024', 'dd-mm-yyyy'), 6, 4);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1313, 25, to_date('15-01-2024', 'dd-mm-yyyy'), 9, 25);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1313, 26, to_date('15-01-2024', 'dd-mm-yyyy'), 9, 27);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1313, 28, to_date('15-01-2024', 'dd-mm-yyyy'), 9, 28);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1313, 29, to_date('15-01-2024', 'dd-mm-yyyy'), 9, 29);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1260, 30, to_date('15-01-2024', 'dd-mm-yyyy'), 10, 30);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1260, 311, to_date('15-01-2024', 'dd-mm-yyyy'), 10, 31);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1260, 32, to_date('15-01-2024', 'dd-mm-yyyy'), 10, 32);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1260, 33, to_date('15-01-2024', 'dd-mm-yyyy'), 10, 33);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1260, 34, to_date('15-01-2024', 'dd-mm-yyyy'), 10, 34);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1260, 35, to_date('15-01-2024', 'dd-mm-yyyy'), 10, 35);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1260, 36, to_date('15-01-2024', 'dd-mm-yyyy'), 10, 36);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 38, to_date('15-01-2024', 'dd-mm-yyyy'), 11, 38);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 31, to_date('15-01-2023', 'dd-mm-yyyy'), 11, 38);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 39, to_date('15-01-2024', 'dd-mm-yyyy'), 11, 39);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 40, to_date('15-01-2024', 'dd-mm-yyyy'), 11, 40);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 41, to_date('15-01-2024', 'dd-mm-yyyy'), 11, 41);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1365, 43, to_date('15-01-2024', 'dd-mm-yyyy'), 12, 45);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1155, 42, to_date('01-11-2024', 'dd-mm-yyyy'), 6, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1365, 45, to_date('15-01-2024', 'dd-mm-yyyy'), 12, 46);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1444, 44, to_date('01-01-2024', 'dd-mm-yyyy'), 5, 5);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1365, 47, to_date('15-01-2024', 'dd-mm-yyyy'), 12, 46);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1365, 48, to_date('15-01-2024', 'dd-mm-yyyy'), 12, 49);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1464, 51, to_date('01-01-2023', 'dd-mm-yyyy'), 4, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1210, 52, to_date('01-01-2022', 'dd-mm-yyyy'), 4, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1271, 50, to_date('01-07-2024', 'dd-mm-yyyy'), 5, 9);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1210, 55, to_date('01-01-2022', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1464, 56, to_date('01-01-2023', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1210, 58, to_date('01-01-2022', 'dd-mm-yyyy'), 4, 50);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1464, 60, to_date('01-01-2023', 'dd-mm-yyyy'), 4, 50);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 62, to_date('01-01-2022', 'dd-mm-yyyy'), 5, 51);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 63, to_date('01-01-2023', 'dd-mm-yyyy'), 5, 51);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1502, 64, to_date('01-01-2024', 'dd-mm-yyyy'), 5, 51);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 66, to_date('01-01-2023', 'dd-mm-yyyy'), 5, 52);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1502, 67, to_date('01-01-2024', 'dd-mm-yyyy'), 5, 52);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 69, to_date('01-01-2022', 'dd-mm-yyyy'), 5, 53);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 70, to_date('01-01-2023', 'dd-mm-yyyy'), 5, 53);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1502, 71, to_date('01-01-2024', 'dd-mm-yyyy'), 5, 53);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 73, to_date('01-01-2022', 'dd-mm-yyyy'), 11, 4);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 74, to_date('01-01-2023', 'dd-mm-yyyy'), 11, 4);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (247, 318, to_date('07-07-2024 09:26:44', 'dd-mm-yyyy hh24:mi:ss'), 177, 7);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (215, 319, to_date('07-07-2024 09:26:44', 'dd-mm-yyyy hh24:mi:ss'), 177, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (175, 320, to_date('07-07-2024 09:26:44', 'dd-mm-yyyy hh24:mi:ss'), 177, 50);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (3000, 75, to_date('01-06-2024', 'dd-mm-yyyy'), 177, 101);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (3000, 76, to_date('01-06-2024', 'dd-mm-yyyy'), 177, 102);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (3000, 77, to_date('01-06-2024', 'dd-mm-yyyy'), 177, 103);
commit;
prompt 64 records loaded
prompt Loading TEACHER...
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (1, 'John Doe', to_date('15-05-1980', 'dd-mm-yyyy'), 'Bachelor', '0541234567', 'Experienced', 1, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (2, 'Jane Smith', to_date('20-10-1985', 'dd-mm-yyyy'), 'Master', '0542345678', 'Intermediate', 2, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (3, 'Alice Johnson', to_date('25-03-1990', 'dd-mm-yyyy'), 'Doctorate', '0543456789', 'Novice', 3, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (4, 'David Brown', to_date('30-08-1982', 'dd-mm-yyyy'), 'Bachelor', '0544567890', 'Experienced', 4, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (5, 'Sarah Lee', to_date('10-11-1987', 'dd-mm-yyyy'), 'Master', '0545678901', 'Intermediate', 5, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (6, 'Michael Wang', to_date('05-04-1992', 'dd-mm-yyyy'), 'Doctorate', '0546789012', 'Novice', 6, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (7, 'Emily Taylor', to_date('20-09-1984', 'dd-mm-yyyy'), 'Bachelor', '0547890123', 'Experienced', 7, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (8, 'Andrew Wilson', to_date('15-12-1989', 'dd-mm-yyyy'), 'Master', '0548901234', 'Intermediate', 8, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (9, 'Olivia Martinez', to_date('01-01-1994', 'dd-mm-yyyy'), 'Doctorate', '0549012345', 'Novice', 9, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (10, 'Liam Garcia', to_date('10-06-1983', 'dd-mm-yyyy'), 'Bachelor', '0549123456', 'Experienced', 10, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (11, 'Ella Rodriguez', to_date('25-11-1988', 'dd-mm-yyyy'), 'Master', '0549234567', 'Intermediate', 11, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (12, 'Noah Hernandez', to_date('20-02-1993', 'dd-mm-yyyy'), 'Doctorate', '0549345678', 'Novice', 12, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (13, 'Emma Lopez', to_date('15-07-1981', 'dd-mm-yyyy'), 'Bachelor', '0549456789', 'Experienced', 13, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (14, 'William Perez', to_date('30-12-1986', 'dd-mm-yyyy'), 'Master', '0549567890', 'Intermediate', 14, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (15, 'Isabella Gonzales', to_date('05-05-1991', 'dd-mm-yyyy'), 'Doctorate', '0549678901', 'Novice', 15, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (16, 'James Wilson', to_date('20-10-1985', 'dd-mm-yyyy'), 'Bachelor', '0549789012', 'Experienced', 16, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (17, 'Sophia Carter', to_date('15-03-1990', 'dd-mm-yyyy'), 'Master', '0549890123', 'Intermediate', 17, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (18, 'Logan Evans', to_date('01-06-1995', 'dd-mm-yyyy'), 'Doctorate', '0549901234', 'Novice', 18, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (19, 'Mia Ramirez', to_date('10-11-1982', 'dd-mm-yyyy'), 'Bachelor', '0549912345', 'Experienced', 19, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (20, 'Benjamin Foster', to_date('25-04-1987', 'dd-mm-yyyy'), 'Master', '0549923456', 'Intermediate', 20, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (21, 'Ava Flores', to_date('20-09-1992', 'dd-mm-yyyy'), 'Doctorate', '0549934567', 'Novice', 21, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (22, 'Aiden Gonzales', to_date('15-02-1980', 'dd-mm-yyyy'), 'Bachelor', '0549945678', 'Experienced', 22, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (23, 'Charlotte Moore', to_date('30-07-1985', 'dd-mm-yyyy'), 'Master', '0549956789', 'Intermediate', 23, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (24, 'Lucas Coleman', to_date('15-12-1990', 'dd-mm-yyyy'), 'Doctorate', '0549967890', 'Novice', 24, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (25, 'Grace Washington', to_date('10-05-1984', 'dd-mm-yyyy'), 'Bachelor', '0549978901', 'Experienced', 25, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (26, 'Ethan Butler', to_date('05-10-1989', 'dd-mm-yyyy'), 'Master', '0549989012', 'Intermediate', 26, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (27, 'Sofia Simmons', to_date('01-01-1994', 'dd-mm-yyyy'), 'Doctorate', '0549990123', 'Novice', 27, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (28, 'Lucas Gonzalez', to_date('10-06-1981', 'dd-mm-yyyy'), 'Bachelor', '0550001234', 'Experienced', 28, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (29, 'Lily Russell', to_date('25-11-1986', 'dd-mm-yyyy'), 'Master', '0550012345', 'Intermediate', 29, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (30, 'Max Bennett', to_date('20-04-1991', 'dd-mm-yyyy'), 'Doctorate', '0550023456', 'Novice', 30, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (31, 'Chloe Stewart', to_date('15-09-1979', 'dd-mm-yyyy'), 'Bachelor', '0550034567', 'Experienced', 31, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (32, 'Owen Webb', to_date('29-02-1984', 'dd-mm-yyyy'), 'Master', '0550045678', 'Intermediate', 32, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (33, 'Amelia Howard', to_date('15-07-1989', 'dd-mm-yyyy'), 'Doctorate', '0550056789', 'Novice', 33, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (34, 'Daniel Johnston', to_date('30-12-1983', 'dd-mm-yyyy'), 'Bachelor', '0550067890', 'Experienced', 34, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (35, 'Harper Kennedy', to_date('25-05-1988', 'dd-mm-yyyy'), 'Master', '0550078901', 'Intermediate', 35, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (36, 'Matthew Marshall', to_date('20-10-1993', 'dd-mm-yyyy'), 'Doctorate', '0550089012', 'Novice', 36, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (37, 'Avery Fox', to_date('05-03-1980', 'dd-mm-yyyy'), 'Bachelor', '0550090123', 'Experienced', 37, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (38, 'Evelyn Sanders', to_date('20-08-1985', 'dd-mm-yyyy'), 'Master', '0550101234', 'Intermediate', 38, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (39, 'Jack Dixon', to_date('15-01-1990', 'dd-mm-yyyy'), 'Doctorate', '0550112345', 'Novice', 39, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (40, 'Abigail Arnold', to_date('30-06-1984', 'dd-mm-yyyy'), 'Bachelor', '0550123456', 'Experienced', 40, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (41, 'Henry Matthews', to_date('25-11-1989', 'dd-mm-yyyy'), 'Master', '0550134567', 'Intermediate', 41, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (43, 'Yael Cohen', to_date('12-04-1985', 'dd-mm-yyyy'), 'B.Ed', '541234567', 'Senior', 152, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (44, 'David Levi', to_date('23-07-1990', 'dd-mm-yyyy'), 'M.Ed', '542345678', 'Junior', 152, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (45, 'Rivka Shapiro', to_date('05-09-1982', 'dd-mm-yyyy'), 'Ph.D', '543456789', 'Senior', 152, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (46, 'Sara Mizrahi', to_date('22-11-1988', 'dd-mm-yyyy'), 'B.A', '544567890', 'Junior', 153, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (47, 'Avi Cohen', to_date('10-03-1975', 'dd-mm-yyyy'), 'M.Sc', '545678901', 'Senior', 153, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (48, 'Leah Levy', to_date('15-06-1992', 'dd-mm-yyyy'), 'M.A', '546789012', 'Intermediate', 153, null);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (49, 'Sarah Cohen', to_date('15-05-1980', 'dd-mm-yyyy'), 'Degree', '123456789', 'Novice', 177, null);
commit;
prompt 48 records loaded
prompt Enabling foreign key constraints for DAYCARE...
alter table DAYCARE enable constraint DC_C_ID_FK;
prompt Enabling foreign key constraints for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES enable constraint SYS_C00716350;
alter table DAYCARE_ACTIVITIES enable constraint SYS_C00716351;
prompt Enabling foreign key constraints for REGISTRATION...
alter table REGISTRATION enable constraint SYS_C00715726;
alter table REGISTRATION enable constraint SYS_C00715727;
prompt Enabling foreign key constraints for TEACHER...
alter table TEACHER enable constraint SYS_C00715736;
prompt Enabling triggers for ACTIVITIES...
alter table ACTIVITIES enable all triggers;
prompt Enabling triggers for CATERING...
alter table CATERING enable all triggers;
prompt Enabling triggers for CHILD...
alter table CHILD enable all triggers;
prompt Enabling triggers for DAYCARE...
alter table DAYCARE enable all triggers;
prompt Enabling triggers for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES enable all triggers;
prompt Enabling triggers for REGISTRATION...
alter table REGISTRATION enable all triggers;
prompt Enabling triggers for TEACHER...
alter table TEACHER enable all triggers;
