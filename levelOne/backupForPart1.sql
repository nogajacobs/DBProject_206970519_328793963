prompt Creating ACTIVITIES...
create table ACTIVITIES
(
  contact_number VARCHAR2(20) not null,
  activity_type  VARCHAR2(100) not null,
  operator_name  VARCHAR2(100) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVITIES
  add primary key (CONTACT_NUMBER)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVITIES
  add unique (OPERATOR_NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CATERING...
create table CATERING
(
  phone_number  VARCHAR2(10) not null,
  kashrut       VARCHAR2(20) not null,
  location      VARCHAR2(30) not null,
  c_id          INTEGER not null,
  catering_name VARCHAR2(30) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CATERING
  add primary key (C_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CHILD...
create table CHILD
(
  child_id   INTEGER not null,
  child_dob  DATE not null,
  child_name VARCHAR2(100) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CHILD
  add primary key (CHILD_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

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
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DAYCARE
  add primary key (D_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DAYCARE
  add constraint DC_C_ID_FK foreign key (C_ID)
  references CATERING (C_ID);

prompt Creating DAYCARE_ACTIVITIES...
create table DAYCARE_ACTIVITIES
(
  d_id           INTEGER not null,
  contact_number VARCHAR2(20) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DAYCARE_ACTIVITIES
  add primary key (D_ID, CONTACT_NUMBER)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DAYCARE_ACTIVITIES
  add foreign key (D_ID)
  references DAYCARE (D_ID);
alter table DAYCARE_ACTIVITIES
  add foreign key (CONTACT_NUMBER)
  references ACTIVITIES (CONTACT_NUMBER);

prompt Creating REGISTRATION...
create table REGISTRATION
(
  price             INTEGER not null,
  registration_id   INTEGER not null,
  registration_date DATE not null,
  d_id              INTEGER not null,
  child_id          INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table REGISTRATION
  add primary key (REGISTRATION_ID, D_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table REGISTRATION
  add foreign key (D_ID)
  references DAYCARE (D_ID);
alter table REGISTRATION
  add foreign key (CHILD_ID)
  references CHILD (CHILD_ID);

prompt Creating TEACHER...
create table TEACHER
(
  t_id          INTEGER not null,
  teacher_name  VARCHAR2(100) not null,
  teacher_dob   DATE not null,
  degree        VARCHAR2(100) not null,
  teacher_phone VARCHAR2(20) not null,
  seniority     VARCHAR2(50) not null,
  d_id          INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TEACHER
  add primary key (T_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
alter table DAYCARE_ACTIVITIES disable constraint SYS_C00715718;
alter table DAYCARE_ACTIVITIES disable constraint SYS_C00715719;
prompt Disabling foreign key constraints for REGISTRATION...
alter table REGISTRATION disable constraint SYS_C00715726;
alter table REGISTRATION disable constraint SYS_C00715727;
prompt Disabling foreign key constraints for TEACHER...
alter table TEACHER disable constraint SYS_C00715736;
prompt Deleting TEACHER...
delete from TEACHER;
prompt Deleting REGISTRATION...
delete from REGISTRATION;
prompt Deleting DAYCARE_ACTIVITIES...
delete from DAYCARE_ACTIVITIES;
prompt Deleting DAYCARE...
delete from DAYCARE;
prompt Deleting CHILD...
delete from CHILD;
prompt Deleting CATERING...
delete from CATERING;
prompt Deleting ACTIVITIES...
delete from ACTIVITIES;
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
prompt 50 records loaded
prompt Loading CATERING...
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0541234567', 'rabanut', 'Tel Aviv', 1, 'Delicious Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0522345678', 'rabanut mehadrin', 'Jerusalem', 2, 'Jerusalem Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0503456789', 'eida charedit', 'Haifa', 3, 'Haifa Delights');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0534567890', 'rubin', 'Beer Sheva', 4, 'Negev Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0545678901', 'bet yosef', 'Eilat', 5, 'Eilat Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0526789012', 'mehuderet', 'Rishon LeZion', 6, 'Rishon Tastes');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0507890123', 'rabanut', 'Netanya', 7, 'Netanya Feasts');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0538901234', 'rabanut mehadrin', 'Petah Tikva', 8, 'Petah Delicacies');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0549012345', 'eida charedit', 'Ashdod', 9, 'Ashdod Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0520123456', 'rubin', 'Holon', 10, 'Holon Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0501234567', 'bet yosef', 'Bnei Brak', 11, 'Bnei Brak Tastes');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0532345678', 'mehuderet', 'Bat Yam', 12, 'Bat Yam Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0543456789', 'rabanut', 'Herzliya', 13, 'Herzliya Delights');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0524567890', 'rabanut mehadrin', 'Kfar Saba', 14, 'Kfar Saba Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0505678901', 'eida charedit', 'Rehovot', 15, 'Rehovot Feasts');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0536789012', 'rubin', 'Ashkelon', 16, 'Ashkelon Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0547890123', 'bet yosef', 'Raanana', 17, 'Raanana Tastes');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0528901234', 'mehuderet', 'Modiin', 18, 'Modiin Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0509012345', 'rabanut', 'Nahariya', 19, 'Nahariya Delights');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0530123456', 'rabanut mehadrin', 'Afula', 20, 'Afula Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0541234567', 'eida charedit', 'Tiberias', 21, 'Tiberias Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0522345678', 'rubin', 'Yavne', 22, 'Yavne Feasts');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0503456789', 'bet yosef', 'Karmiel', 23, 'Karmiel Delights');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0534567890', 'mehuderet', 'Beit Shemesh', 24, 'Beit Shemesh Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0545678901', 'rabanut', 'Kiryat Gat', 25, 'Kiryat Gat Tastes');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0526789012', 'rabanut mehadrin', 'Hadera', 26, 'Hadera Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0507890123', 'eida charedit', 'Tzfat', 27, 'Tzfat Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0538901234', 'rubin', 'Arad', 28, 'Arad Feasts');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0549012345', 'bet yosef', 'Dimona', 29, 'Dimona Delights');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0520123456', 'mehuderet', 'Maale Adumim', 30, 'Maale Adumim Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0501234567', 'rabanut', 'Zichron Yaakov', 31, 'Zichron Yaakov Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0532345678', 'rabanut mehadrin', 'Rosh HaAyin', 32, 'Rosh HaAyin Feasts');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0543456789', 'eida charedit', 'Kiryat Shmona', 33, 'Kiryat Shmona Delights');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0524567890', 'rubin', 'Sderot', 34, 'Sderot Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0505678901', 'bet yosef', 'Ness Ziona', 35, 'Ness Ziona Tastes');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0536789012', 'mehuderet', 'Kiryat Yam', 36, 'Kiryat Yam Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0547890123', 'rabanut', 'Or Yehuda', 37, 'Or Yehuda Feasts');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0528901234', 'rabanut mehadrin', 'Migdal HaEmek', 38, 'Migdal HaEmek Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0509012345', 'eida charedit', 'Ramat HaSharon', 39, 'Ramat HaSharon Delights');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0530123456', 'rubin', 'Kiryat Malakhi', 40, 'Kiryat Malakhi Catering');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0541234567', 'bet yosef', 'Ariel', 41, 'Ariel Feasts');
insert into CATERING (phone_number, kashrut, location, c_id, catering_name)
values ('0522345678', 'mehuderet', 'Sakhnin', 42, 'Sakhnin Catering');
prompt 42 records loaded
prompt Loading CHILD...
insert into CHILD (child_id, child_dob, child_name)
values (1, to_date('10-05-2018', 'dd-mm-yyyy'), 'John Smith');
insert into CHILD (child_id, child_dob, child_name)
values (2, to_date('20-08-2017', 'dd-mm-yyyy'), 'Emily Davis');
insert into CHILD (child_id, child_dob, child_name)
values (3, to_date('15-12-2016', 'dd-mm-yyyy'), 'Michael Johnson');
insert into CHILD (child_id, child_dob, child_name)
values (4, to_date('25-09-2015', 'dd-mm-yyyy'), 'Sarah Brown');
insert into CHILD (child_id, child_dob, child_name)
values (5, to_date('05-11-2014', 'dd-mm-yyyy'), 'David Wilson');
insert into CHILD (child_id, child_dob, child_name)
values (6, to_date('30-01-2019', 'dd-mm-yyyy'), 'Olivia Miller');
insert into CHILD (child_id, child_dob, child_name)
values (7, to_date('14-07-2017', 'dd-mm-yyyy'), 'James Moore');
insert into CHILD (child_id, child_dob, child_name)
values (8, to_date('22-03-2018', 'dd-mm-yyyy'), 'Sophia Taylor');
insert into CHILD (child_id, child_dob, child_name)
values (9, to_date('12-05-2016', 'dd-mm-yyyy'), 'William Anderson');
insert into CHILD (child_id, child_dob, child_name)
values (10, to_date('28-02-2015', 'dd-mm-yyyy'), 'Isabella Thomas');
insert into CHILD (child_id, child_dob, child_name)
values (11, to_date('18-10-2014', 'dd-mm-yyyy'), 'Lucas Jackson');
insert into CHILD (child_id, child_dob, child_name)
values (12, to_date('01-04-2019', 'dd-mm-yyyy'), 'Mia White');
insert into CHILD (child_id, child_dob, child_name)
values (13, to_date('11-11-2017', 'dd-mm-yyyy'), 'Benjamin Harris');
insert into CHILD (child_id, child_dob, child_name)
values (14, to_date('09-06-2018', 'dd-mm-yyyy'), 'Charlotte Martin');
insert into CHILD (child_id, child_dob, child_name)
values (15, to_date('21-09-2016', 'dd-mm-yyyy'), 'Henry Thompson');
insert into CHILD (child_id, child_dob, child_name)
values (16, to_date('16-08-2015', 'dd-mm-yyyy'), 'Amelia Garcia');
insert into CHILD (child_id, child_dob, child_name)
values (17, to_date('27-07-2014', 'dd-mm-yyyy'), 'Alexander Martinez');
insert into CHILD (child_id, child_dob, child_name)
values (18, to_date('13-05-2019', 'dd-mm-yyyy'), 'Ava Robinson');
insert into CHILD (child_id, child_dob, child_name)
values (19, to_date('05-12-2017', 'dd-mm-yyyy'), 'Ethan Clark');
insert into CHILD (child_id, child_dob, child_name)
values (20, to_date('14-02-2018', 'dd-mm-yyyy'), 'Harper Rodriguez');
insert into CHILD (child_id, child_dob, child_name)
values (21, to_date('06-03-2016', 'dd-mm-yyyy'), 'Mason Lewis');
insert into CHILD (child_id, child_dob, child_name)
values (22, to_date('30-10-2015', 'dd-mm-yyyy'), 'Evelyn Lee');
insert into CHILD (child_id, child_dob, child_name)
values (23, to_date('10-01-2014', 'dd-mm-yyyy'), 'Logan Walker');
insert into CHILD (child_id, child_dob, child_name)
values (24, to_date('18-08-2019', 'dd-mm-yyyy'), 'Abigail Hall');
insert into CHILD (child_id, child_dob, child_name)
values (25, to_date('23-03-2017', 'dd-mm-yyyy'), 'Aiden Allen');
insert into CHILD (child_id, child_dob, child_name)
values (26, to_date('22-11-2018', 'dd-mm-yyyy'), 'Ella Young');
insert into CHILD (child_id, child_dob, child_name)
values (27, to_date('11-02-2016', 'dd-mm-yyyy'), 'Daniel Hernandez');
insert into CHILD (child_id, child_dob, child_name)
values (28, to_date('12-12-2015', 'dd-mm-yyyy'), 'Lily King');
insert into CHILD (child_id, child_dob, child_name)
values (29, to_date('07-06-2014', 'dd-mm-yyyy'), 'Jackson Wright');
insert into CHILD (child_id, child_dob, child_name)
values (30, to_date('19-03-2019', 'dd-mm-yyyy'), 'Grace Lopez');
insert into CHILD (child_id, child_dob, child_name)
values (31, to_date('09-09-2017', 'dd-mm-yyyy'), 'Sebastian Hill');
insert into CHILD (child_id, child_dob, child_name)
values (32, to_date('25-05-2018', 'dd-mm-yyyy'), 'Aria Scott');
insert into CHILD (child_id, child_dob, child_name)
values (33, to_date('03-07-2016', 'dd-mm-yyyy'), 'Jack Green');
insert into CHILD (child_id, child_dob, child_name)
values (34, to_date('19-04-2015', 'dd-mm-yyyy'), 'Zoe Adams');
insert into CHILD (child_id, child_dob, child_name)
values (35, to_date('17-02-2014', 'dd-mm-yyyy'), 'Owen Baker');
insert into CHILD (child_id, child_dob, child_name)
values (36, to_date('26-09-2019', 'dd-mm-yyyy'), 'Scarlett Gonzalez');
insert into CHILD (child_id, child_dob, child_name)
values (37, to_date('14-04-2017', 'dd-mm-yyyy'), 'Jacob Nelson');
insert into CHILD (child_id, child_dob, child_name)
values (38, to_date('30-08-2018', 'dd-mm-yyyy'), 'Victoria Carter');
insert into CHILD (child_id, child_dob, child_name)
values (39, to_date('21-10-2016', 'dd-mm-yyyy'), 'Gabriel Mitchell');
insert into CHILD (child_id, child_dob, child_name)
values (40, to_date('07-03-2015', 'dd-mm-yyyy'), 'Hannah Perez');
insert into CHILD (child_id, child_dob, child_name)
values (41, to_date('11-05-2014', 'dd-mm-yyyy'), 'Samuel Roberts');
insert into CHILD (child_id, child_dob, child_name)
values (42, to_date('03-11-2019', 'dd-mm-yyyy'), 'Layla Turner');
insert into CHILD (child_id, child_dob, child_name)
values (43, to_date('02-06-2017', 'dd-mm-yyyy'), 'Anthony Phillips');
insert into CHILD (child_id, child_dob, child_name)
values (44, to_date('12-10-2018', 'dd-mm-yyyy'), 'Sofia Campbell');
insert into CHILD (child_id, child_dob, child_name)
values (45, to_date('08-01-2016', 'dd-mm-yyyy'), 'Cameron Parker');
insert into CHILD (child_id, child_dob, child_name)
values (46, to_date('20-11-2015', 'dd-mm-yyyy'), 'Ella Evans');
insert into CHILD (child_id, child_dob, child_name)
values (47, to_date('02-09-2014', 'dd-mm-yyyy'), 'Matthew Edwards');
insert into CHILD (child_id, child_dob, child_name)
values (48, to_date('15-07-2019', 'dd-mm-yyyy'), 'Avery Collins');
insert into CHILD (child_id, child_dob, child_name)
values (49, to_date('16-01-2017', 'dd-mm-yyyy'), 'Nathan Stewart');
insert into CHILD (child_id, child_dob, child_name)
values (50, to_date('28-12-2018', 'dd-mm-yyyy'), 'Madison Sanchez');
insert into CHILD (child_id, child_dob, child_name)
values (51, to_date('12-05-2018', 'dd-mm-yyyy'), 'Liam Johnson');
insert into CHILD (child_id, child_dob, child_name)
values (52, to_date('23-08-2017', 'dd-mm-yyyy'), 'Emma Martinez');
insert into CHILD (child_id, child_dob, child_name)
values (53, to_date('05-11-2016', 'dd-mm-yyyy'), 'Noah Rodriguez');
insert into CHILD (child_id, child_dob, child_name)
values (54, to_date('17-09-2015', 'dd-mm-yyyy'), 'Olivia Smith');
insert into CHILD (child_id, child_dob, child_name)
values (55, to_date('30-11-2014', 'dd-mm-yyyy'), 'Lucas Brown');
insert into CHILD (child_id, child_dob, child_name)
values (56, to_date('10-02-2019', 'dd-mm-yyyy'), 'Ava Davis');
insert into CHILD (child_id, child_dob, child_name)
values (57, to_date('07-07-2017', 'dd-mm-yyyy'), 'Mia Wilson');
insert into CHILD (child_id, child_dob, child_name)
values (58, to_date('18-03-2018', 'dd-mm-yyyy'), 'Liam Thomas');
insert into CHILD (child_id, child_dob, child_name)
values (59, to_date('09-05-2016', 'dd-mm-yyyy'), 'Ethan White');
insert into CHILD (child_id, child_dob, child_name)
values (60, to_date('25-02-2015', 'dd-mm-yyyy'), 'Sophia Lee');
insert into CHILD (child_id, child_dob, child_name)
values (61, to_date('03-11-2014', 'dd-mm-yyyy'), 'Mason Taylor');
insert into CHILD (child_id, child_dob, child_name)
values (62, to_date('28-03-2019', 'dd-mm-yyyy'), 'Amelia Harris');
insert into CHILD (child_id, child_dob, child_name)
values (63, to_date('16-11-2017', 'dd-mm-yyyy'), 'Michael Clark');
insert into CHILD (child_id, child_dob, child_name)
values (64, to_date('14-06-2018', 'dd-mm-yyyy'), 'Alexis King');
insert into CHILD (child_id, child_dob, child_name)
values (65, to_date('19-09-2016', 'dd-mm-yyyy'), 'Elijah Moore');
insert into CHILD (child_id, child_dob, child_name)
values (66, to_date('20-08-2015', 'dd-mm-yyyy'), 'Harper Jackson');
insert into CHILD (child_id, child_dob, child_name)
values (67, to_date('25-07-2014', 'dd-mm-yyyy'), 'Logan Hall');
insert into CHILD (child_id, child_dob, child_name)
values (68, to_date('03-05-2019', 'dd-mm-yyyy'), 'Isabella Nelson');
insert into CHILD (child_id, child_dob, child_name)
values (69, to_date('15-12-2017', 'dd-mm-yyyy'), 'Aiden Young');
insert into CHILD (child_id, child_dob, child_name)
values (70, to_date('01-02-2018', 'dd-mm-yyyy'), 'Ellie Garcia');
insert into CHILD (child_id, child_dob, child_name)
values (71, to_date('02-03-2016', 'dd-mm-yyyy'), 'James Perez');
insert into CHILD (child_id, child_dob, child_name)
values (72, to_date('13-10-2015', 'dd-mm-yyyy'), 'Charlotte Adams');
insert into CHILD (child_id, child_dob, child_name)
values (73, to_date('22-01-2014', 'dd-mm-yyyy'), 'Benjamin Turner');
insert into CHILD (child_id, child_dob, child_name)
values (74, to_date('28-08-2019', 'dd-mm-yyyy'), 'Mila Phillips');
insert into CHILD (child_id, child_dob, child_name)
values (75, to_date('11-04-2017', 'dd-mm-yyyy'), 'Owen Evans');
insert into CHILD (child_id, child_dob, child_name)
values (76, to_date('21-11-2018', 'dd-mm-yyyy'), 'Emily Miller');
insert into CHILD (child_id, child_dob, child_name)
values (77, to_date('12-02-2016', 'dd-mm-yyyy'), 'Lucas Campbell');
insert into CHILD (child_id, child_dob, child_name)
values (78, to_date('05-12-2015', 'dd-mm-yyyy'), 'Abigail Martinez');
insert into CHILD (child_id, child_dob, child_name)
values (79, to_date('10-06-2014', 'dd-mm-yyyy'), 'William Sanchez');
insert into CHILD (child_id, child_dob, child_name)
values (80, to_date('20-03-2019', 'dd-mm-yyyy'), 'Madison Hall');
insert into CHILD (child_id, child_dob, child_name)
values (81, to_date('29-09-2017', 'dd-mm-yyyy'), 'Lincoln Baker');
insert into CHILD (child_id, child_dob, child_name)
values (82, to_date('05-05-2018', 'dd-mm-yyyy'), 'Evelyn Collins');
insert into CHILD (child_id, child_dob, child_name)
values (83, to_date('07-07-2016', 'dd-mm-yyyy'), 'Mila Thompson');
insert into CHILD (child_id, child_dob, child_name)
values (84, to_date('09-04-2015', 'dd-mm-yyyy'), 'Henry Wright');
insert into CHILD (child_id, child_dob, child_name)
values (85, to_date('21-02-2014', 'dd-mm-yyyy'), 'Grace Robinson');
insert into CHILD (child_id, child_dob, child_name)
values (86, to_date('26-09-2019', 'dd-mm-yyyy'), 'Sebastian Stewart');
insert into CHILD (child_id, child_dob, child_name)
values (87, to_date('04-04-2017', 'dd-mm-yyyy'), 'Aria Perez');
insert into CHILD (child_id, child_dob, child_name)
values (88, to_date('11-08-2018', 'dd-mm-yyyy'), 'John Garcia');
insert into CHILD (child_id, child_dob, child_name)
values (89, to_date('18-10-2016', 'dd-mm-yyyy'), 'Elizabeth Allen');
insert into CHILD (child_id, child_dob, child_name)
values (90, to_date('27-03-2015', 'dd-mm-yyyy'), 'Nathan Thomas');
insert into CHILD (child_id, child_dob, child_name)
values (91, to_date('01-05-2014', 'dd-mm-yyyy'), 'Lily Adams');
insert into CHILD (child_id, child_dob, child_name)
values (92, to_date('02-11-2019', 'dd-mm-yyyy'), 'Landon Hernandez');
insert into CHILD (child_id, child_dob, child_name)
values (93, to_date('03-06-2017', 'dd-mm-yyyy'), 'Zoe Scott');
insert into CHILD (child_id, child_dob, child_name)
values (94, to_date('22-10-2018', 'dd-mm-yyyy'), 'Ella Rodriguez');
insert into CHILD (child_id, child_dob, child_name)
values (95, to_date('10-01-2016', 'dd-mm-yyyy'), 'Lincoln Lee');
insert into CHILD (child_id, child_dob, child_name)
values (96, to_date('12-11-2015', 'dd-mm-yyyy'), 'Aurora Turner');
insert into CHILD (child_id, child_dob, child_name)
values (97, to_date('01-09-2014', 'dd-mm-yyyy'), 'Adam Harris');
insert into CHILD (child_id, child_dob, child_name)
values (98, to_date('16-07-2019', 'dd-mm-yyyy'), 'Leah Parker');
insert into CHILD (child_id, child_dob, child_name)
values (99, to_date('27-01-2017', 'dd-mm-yyyy'), 'Hudson Perez');
insert into CHILD (child_id, child_dob, child_name)
values (100, to_date('18-12-2018', 'dd-mm-yyyy'), 'Skylar Martinez');
prompt 100 records loaded
prompt Loading DAYCARE...
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Little Stars', 'Tel Aviv', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Happy Kids', 'Jerusalem', to_date('31-05-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 2, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Sunshine Daycare', 'Haifa', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 3, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Play and Learn', 'Beersheba', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 4, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Tiny Tots', 'Netanya', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 5, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Kid''s Haven', 'Holon', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 6, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Smiles Daycare', 'Rishon LeZion', to_date('31-05-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 7, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Fun Time', 'Petah Tikva', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 8, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Children''s Corner', 'Ashdod', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 9, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Little Angels', 'Bat Yam', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 10, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Happy Hearts', 'Bnei Brak', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 11, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Sunrise Daycare', 'Herzliya', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 12, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Laughing Kids', 'Ramat Gan', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 13, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHILONI', 'Kids'' Paradise', 'Rehovot', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 14, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('DATI', 'Dreamland', 'Kfar Saba', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 15, null);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('CHAREDI', 'Learning Tree', 'Ra''anana', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 16, null);
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
values ('chiloni', 'Tel Aviv Daycare', 'Tel Aviv', to_date('01-06-2024 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 18:00:00', 'dd-mm-yyyy hh24:mi:ss'), 63, 1);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('dati', 'Jerusalem Daycare', 'Jerusalem', to_date('01-06-2024 12:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 18:30:00', 'dd-mm-yyyy hh24:mi:ss'), 64, 2);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('chiloni', 'Haifa Daycare', 'Haifa', to_date('01-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 19:00:00', 'dd-mm-yyyy hh24:mi:ss'), 65, 3);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('charedi', 'Negev Daycare', 'Beer Sheva', to_date('01-06-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 19:30:00', 'dd-mm-yyyy hh24:mi:ss'), 66, 4);
insert into DAYCARE (sector, daycare_name, location, open_time, close_time, d_id, c_id)
values ('charedi', 'Holon Daycare', 'Holon', to_date('01-06-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 22:30:00', 'dd-mm-yyyy hh24:mi:ss'), 72, 10);
prompt 153 records loaded
prompt Loading DAYCARE_ACTIVITIES...
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (1, '0541234567');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (2, '0541234567');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (3, '0542345678');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (4, '0542345678');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (5, '0543456789');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (6, '0543456789');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (7, '0544567890');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (8, '0544567890');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (9, '0545678901');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (10, '0545678901');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (11, '0546789012');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (12, '0546789012');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (13, '0547890123');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (14, '0548901234');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (15, '0547890123');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (16, '0548901234');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (17, '0549012345');
insert into DAYCARE_ACTIVITIES (d_id, contact_number)
values (18, '0549012345');
prompt 18 records loaded
prompt Loading REGISTRATION...
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1000, 1, to_date('01-06-2023', 'dd-mm-yyyy'), 4, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 2, to_date('15-07-2023', 'dd-mm-yyyy'), 5, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1100, 3, to_date('20-08-2023', 'dd-mm-yyyy'), 6, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1500, 4, to_date('10-09-2023', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 5, to_date('05-10-2023', 'dd-mm-yyyy'), 5, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1400, 6, to_date('20-11-2023', 'dd-mm-yyyy'), 6, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 7, to_date('15-12-2023', 'dd-mm-yyyy'), 4, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1150, 8, to_date('10-01-2024', 'dd-mm-yyyy'), 5, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1350, 9, to_date('05-02-2024', 'dd-mm-yyyy'), 6, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1550, 10, to_date('01-03-2024', 'dd-mm-yyyy'), 4, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1450, 11, to_date('20-04-2024', 'dd-mm-yyyy'), 5, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1650, 12, to_date('15-05-2024', 'dd-mm-yyyy'), 6, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 13, to_date('10-06-2024', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1100, 14, to_date('05-07-2024', 'dd-mm-yyyy'), 5, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1000, 15, to_date('01-08-2024', 'dd-mm-yyyy'), 6, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 16, to_date('20-09-2024', 'dd-mm-yyyy'), 4, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 17, to_date('15-10-2024', 'dd-mm-yyyy'), 5, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1400, 18, to_date('10-11-2024', 'dd-mm-yyyy'), 6, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1450, 19, to_date('05-12-2024', 'dd-mm-yyyy'), 4, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1550, 20, to_date('01-01-2025', 'dd-mm-yyyy'), 5, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1650, 21, to_date('20-02-2025', 'dd-mm-yyyy'), 6, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1350, 22, to_date('15-03-2025', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 23, to_date('10-04-2025', 'dd-mm-yyyy'), 5, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1100, 24, to_date('05-05-2025', 'dd-mm-yyyy'), 6, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1000, 25, to_date('01-06-2025', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 26, to_date('20-07-2025', 'dd-mm-yyyy'), 5, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1150, 27, to_date('15-08-2025', 'dd-mm-yyyy'), 6, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1350, 28, to_date('10-09-2025', 'dd-mm-yyyy'), 4, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1550, 29, to_date('05-10-2025', 'dd-mm-yyyy'), 5, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1650, 30, to_date('01-11-2025', 'dd-mm-yyyy'), 6, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 31, to_date('20-12-2025', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1100, 32, to_date('15-01-2026', 'dd-mm-yyyy'), 5, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1000, 33, to_date('10-02-2026', 'dd-mm-yyyy'), 6, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 34, to_date('05-03-2026', 'dd-mm-yyyy'), 4, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1300, 35, to_date('01-04-2026', 'dd-mm-yyyy'), 5, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1400, 36, to_date('20-05-2026', 'dd-mm-yyyy'), 6, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1450, 37, to_date('15-06-2026', 'dd-mm-yyyy'), 4, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1550, 38, to_date('10-07-2026', 'dd-mm-yyyy'), 5, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1650, 39, to_date('05-08-2026', 'dd-mm-yyyy'), 6, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1350, 40, to_date('01-09-2026', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 41, to_date('20-10-2026', 'dd-mm-yyyy'), 5, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1100, 42, to_date('15-11-2026', 'dd-mm-yyyy'), 6, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1000, 43, to_date('10-12-2026', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1250, 44, to_date('05-01-2027', 'dd-mm-yyyy'), 5, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1150, 45, to_date('01-02-2027', 'dd-mm-yyyy'), 6, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1350, 46, to_date('20-03-2027', 'dd-mm-yyyy'), 4, 1);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1550, 47, to_date('15-04-2027', 'dd-mm-yyyy'), 5, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1650, 48, to_date('10-05-2027', 'dd-mm-yyyy'), 6, 3);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1200, 49, to_date('05-06-2027', 'dd-mm-yyyy'), 4, 2);
insert into REGISTRATION (price, registration_id, registration_date, d_id, child_id)
values (1100, 50, to_date('01-07-2027', 'dd-mm-yyyy'), 5, 3);
prompt 50 records loaded
prompt Loading TEACHER...
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (1, 'John Doe', to_date('15-05-1980', 'dd-mm-yyyy'), 'Bachelor', '0541234567', 'Experienced', 1);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (2, 'Jane Smith', to_date('20-10-1985', 'dd-mm-yyyy'), 'Master', '0542345678', 'Intermediate', 2);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (3, 'Alice Johnson', to_date('25-03-1990', 'dd-mm-yyyy'), 'Doctorate', '0543456789', 'Novice', 3);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (4, 'David Brown', to_date('30-08-1982', 'dd-mm-yyyy'), 'Bachelor', '0544567890', 'Experienced', 4);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (5, 'Sarah Lee', to_date('10-11-1987', 'dd-mm-yyyy'), 'Master', '0545678901', 'Intermediate', 5);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (6, 'Michael Wang', to_date('05-04-1992', 'dd-mm-yyyy'), 'Doctorate', '0546789012', 'Novice', 6);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (7, 'Emily Taylor', to_date('20-09-1984', 'dd-mm-yyyy'), 'Bachelor', '0547890123', 'Experienced', 7);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (8, 'Andrew Wilson', to_date('15-12-1989', 'dd-mm-yyyy'), 'Master', '0548901234', 'Intermediate', 8);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (9, 'Olivia Martinez', to_date('01-01-1994', 'dd-mm-yyyy'), 'Doctorate', '0549012345', 'Novice', 9);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (10, 'Liam Garcia', to_date('10-06-1983', 'dd-mm-yyyy'), 'Bachelor', '0549123456', 'Experienced', 10);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (11, 'Ella Rodriguez', to_date('25-11-1988', 'dd-mm-yyyy'), 'Master', '0549234567', 'Intermediate', 11);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (12, 'Noah Hernandez', to_date('20-02-1993', 'dd-mm-yyyy'), 'Doctorate', '0549345678', 'Novice', 12);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (13, 'Emma Lopez', to_date('15-07-1981', 'dd-mm-yyyy'), 'Bachelor', '0549456789', 'Experienced', 13);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (14, 'William Perez', to_date('30-12-1986', 'dd-mm-yyyy'), 'Master', '0549567890', 'Intermediate', 14);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (15, 'Isabella Gonzales', to_date('05-05-1991', 'dd-mm-yyyy'), 'Doctorate', '0549678901', 'Novice', 15);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (16, 'James Wilson', to_date('20-10-1985', 'dd-mm-yyyy'), 'Bachelor', '0549789012', 'Experienced', 16);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (17, 'Sophia Carter', to_date('15-03-1990', 'dd-mm-yyyy'), 'Master', '0549890123', 'Intermediate', 17);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (18, 'Logan Evans', to_date('01-06-1995', 'dd-mm-yyyy'), 'Doctorate', '0549901234', 'Novice', 18);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (19, 'Mia Ramirez', to_date('10-11-1982', 'dd-mm-yyyy'), 'Bachelor', '0549912345', 'Experienced', 19);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (20, 'Benjamin Foster', to_date('25-04-1987', 'dd-mm-yyyy'), 'Master', '0549923456', 'Intermediate', 20);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (21, 'Ava Flores', to_date('20-09-1992', 'dd-mm-yyyy'), 'Doctorate', '0549934567', 'Novice', 21);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (22, 'Aiden Gonzales', to_date('15-02-1980', 'dd-mm-yyyy'), 'Bachelor', '0549945678', 'Experienced', 22);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (23, 'Charlotte Moore', to_date('30-07-1985', 'dd-mm-yyyy'), 'Master', '0549956789', 'Intermediate', 23);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (24, 'Lucas Coleman', to_date('15-12-1990', 'dd-mm-yyyy'), 'Doctorate', '0549967890', 'Novice', 24);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (25, 'Grace Washington', to_date('10-05-1984', 'dd-mm-yyyy'), 'Bachelor', '0549978901', 'Experienced', 25);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (26, 'Ethan Butler', to_date('05-10-1989', 'dd-mm-yyyy'), 'Master', '0549989012', 'Intermediate', 26);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (27, 'Sofia Simmons', to_date('01-01-1994', 'dd-mm-yyyy'), 'Doctorate', '0549990123', 'Novice', 27);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (28, 'Lucas Gonzalez', to_date('10-06-1981', 'dd-mm-yyyy'), 'Bachelor', '0550001234', 'Experienced', 28);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (29, 'Lily Russell', to_date('25-11-1986', 'dd-mm-yyyy'), 'Master', '0550012345', 'Intermediate', 29);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (30, 'Max Bennett', to_date('20-04-1991', 'dd-mm-yyyy'), 'Doctorate', '0550023456', 'Novice', 30);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (31, 'Chloe Stewart', to_date('15-09-1979', 'dd-mm-yyyy'), 'Bachelor', '0550034567', 'Experienced', 31);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (32, 'Owen Webb', to_date('29-02-1984', 'dd-mm-yyyy'), 'Master', '0550045678', 'Intermediate', 32);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (33, 'Amelia Howard', to_date('15-07-1989', 'dd-mm-yyyy'), 'Doctorate', '0550056789', 'Novice', 33);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (34, 'Daniel Johnston', to_date('30-12-1983', 'dd-mm-yyyy'), 'Bachelor', '0550067890', 'Experienced', 34);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (35, 'Harper Kennedy', to_date('25-05-1988', 'dd-mm-yyyy'), 'Master', '0550078901', 'Intermediate', 35);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (36, 'Matthew Marshall', to_date('20-10-1993', 'dd-mm-yyyy'), 'Doctorate', '0550089012', 'Novice', 36);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (37, 'Avery Fox', to_date('05-03-1980', 'dd-mm-yyyy'), 'Bachelor', '0550090123', 'Experienced', 37);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (38, 'Evelyn Sanders', to_date('20-08-1985', 'dd-mm-yyyy'), 'Master', '0550101234', 'Intermediate', 38);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (39, 'Jack Dixon', to_date('15-01-1990', 'dd-mm-yyyy'), 'Doctorate', '0550112345', 'Novice', 39);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (40, 'Abigail Arnold', to_date('30-06-1984', 'dd-mm-yyyy'), 'Bachelor', '0550123456', 'Experienced', 40);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (41, 'Henry Matthews', to_date('25-11-1989', 'dd-mm-yyyy'), 'Master', '0550134567', 'Intermediate', 41);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (43, 'Yael Cohen', to_date('12-04-1985', 'dd-mm-yyyy'), 'B.Ed', '541234567', 'Senior', 152);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (44, 'David Levi', to_date('23-07-1990', 'dd-mm-yyyy'), 'M.Ed', '542345678', 'Junior', 152);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (45, 'Rivka Shapiro', to_date('05-09-1982', 'dd-mm-yyyy'), 'Ph.D', '543456789', 'Senior', 152);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (46, 'Sara Mizrahi', to_date('22-11-1988', 'dd-mm-yyyy'), 'B.A', '544567890', 'Junior', 153);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (47, 'Avi Cohen', to_date('10-03-1975', 'dd-mm-yyyy'), 'M.Sc', '545678901', 'Senior', 153);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id)
values (48, 'Leah Levy', to_date('15-06-1992', 'dd-mm-yyyy'), 'M.A', '546789012', 'Intermediate', 153);
prompt 47 records loaded
prompt Enabling foreign key constraints for DAYCARE...
alter table DAYCARE enable constraint DC_C_ID_FK;
prompt Enabling foreign key constraints for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES enable constraint SYS_C00715718;
alter table DAYCARE_ACTIVITIES enable constraint SYS_C00715719;
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
