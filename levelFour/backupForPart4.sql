prompt PL/SQL Developer Export Tables for user SYSTEM@XE
prompt Created by adina on Tuesday, 23 July 2024
set feedback off
set define off

prompt Creating LOCATIONS...
create table LOCATIONS
(
  locationid    INTEGER not null,
  locationname  VARCHAR2(20) not null,
  address       VARCHAR2(30) not null,
  capacity      INTEGER not null,
  accessibility VARCHAR2(20) not null,
  contactperson INTEGER not null,
  parking       INTEGER default 0 not null,
  ticketssold   INTEGER default 0
);
alter table LOCATIONS
  add primary key (LOCATIONID);
  
prompt Creating CATERING...
create table CATERING
(
  phone_number  VARCHAR2(10) not null,
  kashrut       VARCHAR2(20) not null,
  c_id          INTEGER not null,
  catering_name VARCHAR2(30) not null,
  celiac        VARCHAR2(3) default 'NO',
  locationi__d  INTEGER

);
alter table CATERING
  add primary key (C_ID);
alter table CATERING
  add constraint UNIQUE_CATERING_NAME unique (CATERING_NAME);
alter table CATERING
  add constraint FK_CATERING_LOCATION foreign key (LOCATIONI__D)
  references LOCATIONS (LOCATIONID);
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
  open_time    DATE not null,
  close_time   DATE not null,
  d_id         INTEGER not null,
  c_id         INTEGER,
  locationid   INTEGER
);
alter table DAYCARE
  add primary key (D_ID);
alter table DAYCARE
  add constraint DC_C_ID_FK foreign key (C_ID)
  references CATERING (C_ID);
alter table DAYCARE
  add constraint FK_DAYCARE_LOCATION foreign key (LOCATIONID)
  references LOCATIONS (LOCATIONID);
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

prompt Creating EVENTTYPE...
create table EVENTTYPE
(
  eventtypeid     INTEGER not null,
  eventtype       VARCHAR2(20) not null,
  typedescription VARCHAR2(100) not null
);
alter table EVENTTYPE
  add primary key (EVENTTYPEID);

prompt Creating ORGANIZER...
create table ORGANIZER
(
  organizerid   INTEGER not null,
  organizername VARCHAR2(20) not null,
  phone         INTEGER not null,
  email         VARCHAR2(30) not null
);
alter table ORGANIZER
  add primary key (ORGANIZERID);

prompt Creating EVENT...
create table EVENT
(
  eventid       INTEGER not null,
  eventname     VARCHAR2(50) not null,
  eventdate     DATE not null,
  eventdescribe VARCHAR2(100) not null,
  organizerid   INTEGER not null,
  eventtypeid   INTEGER not null,
  locationid    INTEGER not null
);
alter table EVENT
  add primary key (EVENTID);
alter table EVENT
  add foreign key (ORGANIZERID)
  references ORGANIZER (ORGANIZERID);
alter table EVENT
  add foreign key (EVENTTYPEID)
  references EVENTTYPE (EVENTTYPEID);
alter table EVENT
  add foreign key (LOCATIONID)
  references LOCATIONS (LOCATIONID);

prompt Creating ORDERS...
create table ORDERS
(
  orderid      INTEGER not null,
  ticketamount INTEGER not null,
  ticketcost   INTEGER not null,
  orderdate    DATE not null,
  eventid      INTEGER not null,
  d_id         INTEGER
);
alter table ORDERS
  add primary key (ORDERID);
alter table ORDERS
  add foreign key (EVENTID)
  references EVENT (EVENTID);

prompt Creating PARTICIPANTS...
create table PARTICIPANTS
(
  participantid INTEGER not null,
  firstname     VARCHAR2(20) not null,
  lastname      VARCHAR2(20) not null,
  email         VARCHAR2(30) not null,
  clubmember    INTEGER not null
);
alter table PARTICIPANTS
  add primary key (PARTICIPANTID);

prompt Creating MAKEORDER...
create table MAKEORDER
(
  participantid INTEGER not null,
  orderid       INTEGER not null
);
alter table MAKEORDER
  add primary key (PARTICIPANTID, ORDERID);
alter table MAKEORDER
  add foreign key (PARTICIPANTID)
  references PARTICIPANTS (PARTICIPANTID);
alter table MAKEORDER
  add foreign key (ORDERID)
  references ORDERS (ORDERID);

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

prompt Disabling triggers for LOCATIONS...
alter table LOCATIONS disable all triggers;
prompt Disabling triggers for CATERING...
alter table CATERING disable all triggers;
prompt Disabling triggers for CHILD...
alter table CHILD disable all triggers;
prompt Disabling triggers for DAYCARE...
alter table DAYCARE disable all triggers;
prompt Disabling triggers for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES disable all triggers;
prompt Disabling triggers for EVENTTYPE...
alter table EVENTTYPE disable all triggers;
prompt Disabling triggers for ORGANIZER...
alter table ORGANIZER disable all triggers;
prompt Disabling triggers for EVENT...
alter table EVENT disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for PARTICIPANTS...
alter table PARTICIPANTS disable all triggers;
prompt Disabling triggers for MAKEORDER...
alter table MAKEORDER disable all triggers;
prompt Disabling triggers for REGISTRATION...
alter table REGISTRATION disable all triggers;
prompt Disabling triggers for TEACHER...
alter table TEACHER disable all triggers;
prompt Disabling foreign key constraints for CATERING...
alter table CATERING disable constraint FK_CATERING_LOCATION;
prompt Disabling foreign key constraints for DAYCARE...
alter table DAYCARE disable constraint DC_C_ID_FK;
alter table DAYCARE disable constraint FK_DAYCARE_LOCATION;
prompt Disabling foreign key constraints for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES disable constraint SYS_C008339;
prompt Disabling foreign key constraints for EVENT...
alter table EVENT disable constraint SYS_C008383;
alter table EVENT disable constraint SYS_C008384;
alter table EVENT disable constraint SYS_C008385;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint SYS_C008392;
prompt Disabling foreign key constraints for MAKEORDER...
alter table MAKEORDER disable constraint SYS_C008402;
alter table MAKEORDER disable constraint SYS_C008403;
prompt Disabling foreign key constraints for REGISTRATION...
alter table REGISTRATION disable constraint SYS_C008346;
alter table REGISTRATION disable constraint SYS_C008347;
prompt Disabling foreign key constraints for TEACHER...
alter table TEACHER disable constraint SYS_C008357;
prompt Deleting TEACHER...
delete from TEACHER;
commit;
prompt Deleting REGISTRATION...
delete from REGISTRATION;
commit;
prompt Deleting MAKEORDER...
delete from MAKEORDER;
commit;
prompt Deleting PARTICIPANTS...
delete from PARTICIPANTS;
commit;
prompt Deleting ORDERS...
delete from ORDERS;
commit;
prompt Deleting EVENT...
delete from EVENT;
commit;
prompt Deleting ORGANIZER...
delete from ORGANIZER;
commit;
prompt Deleting EVENTTYPE...
delete from EVENTTYPE;
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
prompt Deleting LOCATIONS...
delete from LOCATIONS;
commit;
prompt Loading LOCATIONS...
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (1, 'Sports Arena', 'Jerusalem', 5000, 'Yes', 1, 200, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (2, 'Community Center', 'Jerusalem', 300, 'Yes', 2, 50, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (3, 'Cultural Hall', 'Jerusalem', 800, 'Yes', 3, 100, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (4, 'Independence Park', '101 Freedom Blvd', 10000, 'Yes', 4, 500, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (5, 'Theatre House', '202 Drama Ln', 1200, 'Yes', 5, 150, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (6, 'Memorial Hall', '303 Remembrance Rd', 600, 'Yes', 6, 80, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (7, 'Education Center', '404 Learning St', 400, 'Yes', 7, 60, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (8, 'Concert Hall', '505 Music Ave', 2000, 'Yes', 8, 300, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (9, 'Festival Grounds', '606 Celebration Blvd', 8000, 'Yes', 9, 400, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (10, 'Cinema Complex', '707 Film St', 1500, 'Yes', 10, 250, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (11, 'Groton', '2 Rooker Drive', 541, 'N', -3244531, 82, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (12, 'Solikamsk', '98 Murdock Road', 784, 'Y', -8713169, 26, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (13, 'Norderstedt', '6 Weir Blvd', 131, 'Y', -4858845, 61, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (14, 'Hayward', '39 Negbaur Road', 561, 'N', -5916944, 6, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (15, 'Oulu', '31 Downey Drive', 363, 'Y', -690926, 96, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (16, 'Crete', '63 Juno Beach Road', 576, 'N', -2647222, 63, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (17, 'Springfield', '2 Napolitano', 658, 'Y', -2443767, 30, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (19, 'New orleans', '96 Ittigen Blvd', 578, 'Y', -6086722, 2, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (20, 'Fukushima', '63 Mulroney Blvd', 776, 'N', -1265402, 99, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (21, 'Stellenbosch', '57 Andre Road', 240, 'Y', -8214810, 77, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (22, 'Burlington', '65 Berkoff Road', 211, 'Y', -5921306, 62, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (23, 'Zurich', '79 Derwood Blvd', 191, 'N', -9040648, 33, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (24, 'Chinnor', '77 Hutch Ave', 391, 'Y', -4044766, 31, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (25, 'Calcutta', '56 Field Street', 445, 'Y', -5819494, 14, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (26, 'Abbotsford', '63 Holland Ave', 155, 'N', -8505276, 95, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (27, 'Niles', '32 MacIsaac Street', 419, 'N', -3075235, 79, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (28, 'Cesena', '9 Steenburgen Road', 184, 'N', -3569244, 48, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (29, 'Lake Oswego', '94 Moorer Ave', 277, 'N', -791361, 78, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (30, 'Changwon-si', '12nd Street', 905, 'Y', -9666372, 68, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (31, 'Fountain Hills', '92 Renfro Road', 578, 'N', -7581807, 54, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (32, 'London', '65 Camp Street', 300, 'N', -7017897, 90, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (33, 'East sussex', '76 Dayne Road', 780, 'Y', -3290555, 17, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (34, 'Rockford', '30 Cocker Blvd', 61, 'N', -236654, 9, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (35, 'Fuchstal-asch', '53 Bad Camberg Road', 424, 'Y', -2962560, 94, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (36, 'Kaiserslautern', '13rd Street', 707, 'Y', -6542358, 55, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (37, 'Kista', '37 Niles Street', 267, 'N', -3532767, 38, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (38, 'West Lafayette', '52nd Street', 353, 'Y', -2190958, 2, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (39, 'Coppell', '39 Martinez Drive', 576, 'Y', -2905698, 53, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (40, 'Ashdod', '33 Southampton Drive', 232, 'N', -1496739, 80, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (41, 'Gersthofen', '22nd Street', 716, 'Y', -638207, 78, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (42, 'Redwood Shores', '43 Olyphant Blvd', 907, 'N', -8704186, 29, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (43, 'Tours', '44 Hugh Road', 664, 'Y', -5705624, 66, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (44, 'N. ft. Myers', '46 Redondo beach Road', 837, 'Y', -5565776, 85, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (45, 'Immenstaad', '351 Terry Road', 671, 'Y', -2770094, 53, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (46, 'Goteborg', '39 Cleary Road', 458, 'N', -3722599, 28, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (47, 'Chorz×£w', '47 Avital Ave', 85, 'Y', -1644150, 27, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (48, 'Geneva', '422 Balthazar Street', 369, 'Y', -6930388, 24, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (49, 'Stanford', '53 Dionne Blvd', 473, 'N', -6121222, 34, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (50, 'Nagano', '13 Stampley Drive', 111, 'N', -1545877, 25, 6);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (51, 'Billund', '385 DeVito Drive', 354, 'N', -153739, 56, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (52, 'Udine', '28 Swoosie Drive', 909, 'N', -5888196, 11, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (53, 'Wetzlar', '31 Tomei Road', 762, 'N', -9998309, 74, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (54, 'Dublin', '12 Borgnine Road', 260, 'N', -6324866, 73, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (55, 'New Haven', '6 Blaine Drive', 896, 'N', -2802248, 42, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (56, 'Kongserbg', '83 Weiland Street', 716, 'N', -766052, 58, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (57, 'Koppl', '343 Gere', 144, 'Y', -218109, 76, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (58, 'Aurora', '60 Ruth Drive', 790, 'Y', -8258589, 46, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (59, 'Boulogne', '89 Chao Street', 170, 'N', -1130545, 73, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (60, 'Maidstone', '60 Suvari Street', 115, 'N', -6029264, 69, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (61, 'Gen×˜ve', '73 Navarro Street', 745, 'N', -8973561, 8, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (62, 'New York City', '65 Winstone Street', 123, 'Y', -9298205, 45, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (63, 'Wien', '48 Holden Ave', 251, 'N', -6084491, 62, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (64, 'Erlangen', '89 Salt', 752, 'N', -6227419, 92, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (65, 'Frankfurt am Main', '411 Randall Road', 489, 'Y', -7428370, 10, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (66, 'durham', '70 Root Street', 932, 'N', -335816, 41, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (67, 'Bismarck', '30 Pantoliano Ave', 98, 'Y', -9533666, 22, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (68, 'New York', '20 Glenn Ave', 125, 'N', -4486399, 3, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (69, 'Birmingham', '93 San Jose Drive', 946, 'N', -4733692, 98, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (70, 'Derwood', '132 William Street', 905, 'N', -2603676, 29, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (71, 'Michendorf', '91 Springfield', 158, 'Y', -5505258, 0, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (72, 'Jacksonville', '12nd Street', 246, 'Y', -1729573, 86, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (73, 'Santa Clarat', '44 Gallant Street', 460, 'Y', -9056772, 75, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (74, 'Calgary', '71st Street', 505, 'Y', -2353632, 9, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (75, 'Kwun Tong', '43rd Street', 890, 'Y', -1997665, 51, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (76, 'Luedenscheid', '91 Allan Street', 102, 'Y', -2667651, 91, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (77, 'Hannover', '81st Street', 760, 'Y', -937837, 91, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (78, 'Schlieren', '97 Vannelli Street', 898, 'N', -2605715, 29, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (79, 'W×¦rth', '56 Kleinenberg Drive', 328, 'N', -9560542, 92, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (80, 'Fort worth', '62nd Street', 651, 'Y', -3739538, 21, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (81, 'Paal Beringen', '38 Carlin Street', 574, 'N', -1776318, 100, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (82, 'Sundsvall', '11 Rachael Road', 184, 'N', -1755732, 36, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (83, 'Bad Camberg', '43 Lake worth Ave', 800, 'Y', -228387, 9, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (84, 'Salt Lake City', '33 Santana Street', 302, 'N', -371119, 37, 6);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (85, 'Birmensdorf', '67 DiCaprio Road', 486, 'Y', -7460690, 3, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (86, 'Charleston', '18 Vaughn Ave', 793, 'N', -849542, 90, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (87, 'Graz', '34 Costello Street', 334, 'Y', -599607, 94, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (88, 'Grapevine', '553 Rourke Road', 311, 'Y', -8825189, 36, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (89, 'Yamagata', '19 Huntsville Road', 739, 'Y', -519513, 0, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (90, 'Lexington', '2 Elche Drive', 87, 'N', -8735565, 11, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (91, 'Kozani', '19 East sussex Ave', 792, 'N', -7594654, 7, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (92, 'Holderbank', '63 Numan Drive', 922, 'Y', -5057575, 61, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (93, 'Cottbus', '27 Koblenz Drive', 651, 'Y', -4304489, 83, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (94, 'Araras', '4 Crowe Blvd', 402, 'Y', -1780898, 25, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (95, 'South Weber', '674 Steve Ave', 587, 'N', -1772491, 47, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (96, 'Silver Spring', '80 Lakeville Street', 354, 'N', -958228, 39, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (97, 'Flushing', '46 Nicholas Drive', 446, 'N', -5924730, 35, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (98, 'Lathrop', '641 Ving Blvd', 331, 'Y', -6954245, 73, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (99, 'Thames Ditton', '29 Scorsese Street', 240, 'Y', -4503149, 20, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (100, 'Springville', '82 Quatro Drive', 989, 'Y', -637153, 11, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (101, 'Gainesville', '25 Imperioli', 858, 'Y', -6604540, 78, 1);
commit;
prompt 100 records committed...
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (102, 'K×¦ln', '87 Belmont Blvd', 326, 'N', -4288238, 45, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (103, 'Newbury', '3 Ann Street', 575, 'N', -8098823, 36, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (104, 'North Wales', '27 Meppel Road', 523, 'Y', -3067399, 85, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (105, 'Williamstown', '14 Parker Ave', 199, 'Y', -3988565, 91, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (106, 'Istanbul', '163 Puckett Drive', 914, 'Y', -8514338, 87, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (107, 'Grand-mere', '95 Laurence', 360, 'Y', -1270187, 3, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (108, 'Chorz×£w', '33 Bening Street', 313, 'N', -8845632, 5, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (109, 'Benbrook', '440 Garcia Blvd', 473, 'Y', -154606, 97, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (110, 'Bolton', '41st Street', 956, 'Y', -2055418, 95, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (111, 'Rio de janeiro', '17 Soda Blvd', 298, 'N', -1718843, 75, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (112, 'T×”by', '81 Lippetal Road', 353, 'N', -7295724, 68, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (113, 'Royersford', '23rd Street', 507, 'Y', -965272, 36, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (114, 'Melrose', '10 Englund Street', 684, 'Y', -632929, 42, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (115, 'Huntsville', '92 Burke Street', 669, 'N', -9475800, 9, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (116, 'Suffern', '20 Juno Beach Street', 447, 'N', -1750233, 29, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (117, 'Koppl', '13 Renfro Street', 122, 'Y', -7131424, 16, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (118, 'Pottendorf', '54 Archer Street', 859, 'Y', -7710923, 64, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (119, 'Dreieich', '54 Jackson Road', 624, 'Y', -2688690, 8, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (120, 'B×¨nes', '36 Park Ridge Drive', 360, 'Y', -664797, 61, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (121, 'Miami', '13 Hatchet Street', 277, 'Y', -7280842, 10, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (122, 'Kaohsiung', '58 Brno Road', 932, 'N', -6087242, 94, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (123, 'Treviso', '44 Gdansk Road', 999, 'Y', -9865877, 77, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (124, 'Irvine', '62nd Street', 277, 'N', -1915080, 87, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (125, 'Franklin', '4 Levy Road', 909, 'N', -6818622, 7, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (126, 'Crete', '93 Jeffreys Drive', 975, 'Y', -9021804, 12, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (127, 'Walnut Creek', '68 Blackmore Drive', 304, 'N', -2213235, 28, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (128, 'Barnegat', '51st Street', 614, 'Y', -6530490, 94, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (129, 'Heiligenhaus', '163 Mykelti Street', 360, 'Y', -9608650, 39, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (130, 'Nanaimo', '29 Assante Road', 419, 'Y', -7974008, 84, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (131, 'Toyama', '362 Junior Ave', 179, 'N', -3954796, 88, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (132, 'Bartlesville', '56 Blaine Ave', 214, 'N', -926549, 52, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (133, 'Bend', '832 Cervine Street', 485, 'N', -9499764, 95, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (134, 'Soroe', '51 Orange Street', 271, 'Y', -9736807, 3, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (135, 'Mississauga', '510 Blackmore Ave', 665, 'N', -3993018, 33, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (136, 'Bloomington', '95 Matheson Drive', 406, 'N', -6011438, 24, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (137, 'Fort McMurray', '19 Spacey Blvd', 713, 'Y', -8346612, 69, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (138, 'Guadalajara', '89 Everett Drive', 723, 'Y', -980995, 68, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (139, 'Regina', '53rd Street', 774, 'N', -274653, 73, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (140, 'Vancouver', '49 Gooding Road', 778, 'Y', -9266765, 64, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (141, 'Rueil-Malmaison', '280 Union Drive', 357, 'N', -9195457, 28, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (142, 'Pacific Grove', '11 Hanley Road', 219, 'N', -6150865, 75, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (143, 'North Sydney', '4 Lewin Road', 905, 'N', -7355867, 57, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (144, 'Melrose', '71 Fukushima Road', 282, 'Y', -5510731, 18, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (145, 'Cobham', '34 Lawrence Drive', 214, 'Y', -9337393, 61, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (146, 'East Providence', '758 Sant Cugat Del Valle Drive', 708, 'N', -7316056, 100, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (147, 'Juazeiro', '19 Etta', 864, 'Y', -3582493, 92, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (148, 'Carson City', '67 Dourif Road', 451, 'N', -5941078, 4, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (149, 'Herndon', '65 Peter Blvd', 379, 'N', -3504560, 16, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (150, 'Salisbury', '91 Christmas Street', 357, 'Y', -7310440, 45, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (151, 'Albuquerque', '146 Sarsgaard Drive', 334, 'N', -7930948, 100, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (152, 'Santiago', '642 Head Ave', 84, 'Y', -7132699, 44, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (153, 'Northbrook', '65 Hershey Drive', 156, 'N', -1046006, 3, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (154, 'Lippetal', '69 Des Plaines', 394, 'Y', -5255736, 25, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (155, 'Edinburgh', '24 Toni Blvd', 972, 'Y', -1390678, 99, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (156, 'Fuerth', '2 Bekescsaba Street', 836, 'Y', -8513568, 78, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (157, 'Takamatsu', '66 Thomson Drive', 475, 'Y', -175870, 15, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (158, 'Auckland', '53 Haslam Blvd', 866, 'N', -499882, 17, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (159, 'Vilnius', '92nd Street', 403, 'N', -2781111, 44, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (160, 'Aurora', '83rd Street', 297, 'N', -9752252, 3, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (161, 'Gothenburg', '72 Frost Road', 942, 'N', -1225359, 9, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (162, 'Noumea', '11 Selma Drive', 819, 'N', -9452403, 84, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (163, 'Milford', '32 Hobson', 524, 'Y', -244789, 36, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (164, 'Nashua', '49 Fraser Road', 709, 'Y', -1106921, 7, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (165, 'Debary', '150 Suffern Street', 267, 'N', -3308220, 10, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (166, 'Lake worth', '50 Dorn Street', 389, 'N', -4183655, 8, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (167, 'Tbilisi', '14 Niles Street', 356, 'N', -5307515, 14, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (168, 'Tokyo', '31st Street', 756, 'N', -4861524, 92, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (169, 'Dorval', '260 Pete Drive', 122, 'N', -8881893, 4, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (170, 'Leeds', '20 Dern Ave', 50, 'Y', -1381044, 58, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (171, 'Belgrad', '53 Judd', 673, 'Y', -1725259, 15, 6);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (172, 'N. ft. Myers', '5 Shepherd', 694, 'N', -7525342, 72, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (173, 'Goslar', '31 Richmond Road', 775, 'Y', -8220435, 22, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (174, 'Rochester', '14 Bruxelles Drive', 247, 'Y', -2381049, 15, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (175, 'Crete', '56 Andy Street', 503, 'N', -893563, 94, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (176, 'Cape town', '51 Chandler Drive', 577, 'N', -5515380, 93, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (177, 'Gliwice', '28 Kravitz Road', 357, 'Y', -6502720, 91, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (178, 'West Launceston', '96 Jean Drive', 961, 'N', -2112568, 96, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (179, 'Redhill', '67 Hatfield Street', 473, 'Y', -6014382, 1, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (180, 'Redwood Shores', '53 McGovern', 892, 'Y', -9579947, 4, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (181, 'Caguas', '25 Perlman Blvd', 573, 'Y', -5487913, 83, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (182, 'West Drayton', '362 Sarandon Drive', 321, 'Y', -567333, 9, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (183, 'Tartu', '869 Lawrence Road', 793, 'N', -3032613, 55, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (184, 'New Delhi', '73 Trey Road', 726, 'Y', -266257, 75, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (185, 'Mablethorpe', '256 Shelby Street', 593, 'Y', -6804512, 15, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (186, 'Akron', '833 Milano Street', 107, 'N', -7655988, 56, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (187, 'Denver', '24 Sellers Drive', 455, 'N', -686286, 22, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (188, 'Dreieich', '866 Loretta Street', 688, 'N', -6474048, 8, 7);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (189, 'Jacksonville', '57 Farrell', 837, 'N', -1543521, 85, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (190, 'Portland', '654 Simon Road', 697, 'Y', -3737461, 95, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (191, 'Tulsa', '64 Buckingham Street', 433, 'Y', -5664850, 99, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (192, 'Piacenza', '89 von Sydow Street', 750, 'Y', -5122930, 20, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (193, 'Grapevine', '60 Cruise Street', 946, 'N', -5001814, 80, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (194, 'Roma', '87 Sarandon Street', 519, 'Y', -8435254, 18, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (195, 'Greenville', '71 Harrelson Street', 680, 'Y', -1546651, 26, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (196, 'San Francisco', '41 Geoffrey Road', 909, 'Y', -1035977, 41, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (197, 'New hartford', '5 Shandling Street', 219, 'N', -6766881, 26, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (198, 'Fountain Hills', '46 Bandy Ave', 265, 'Y', -4098065, 32, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (199, 'Macclesfield', '67 Lachey Street', 464, 'N', -9938357, 57, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (200, 'Rockland', '3 Joan Drive', 820, 'N', -1729561, 46, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (201, 'Magstadt', '45 Stigers Drive', 374, 'N', -263415, 11, 0);
commit;
prompt 200 records committed...
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (202, 'Sao paulo', '13rd Street', 87, 'N', -6728227, 29, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (203, 'Chambersburg', '58 Kate Road', 840, 'Y', -6247947, 53, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (204, 'Gaza', '926 Morgan Road', 851, 'N', -658194, 49, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (205, 'Bristol', '60 Kazem Road', 489, 'Y', -4048146, 47, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (206, 'Hearst', '42 Chambery Ave', 817, 'N', -5384058, 10, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (207, 'Scottsdale', '35 Kid Road', 436, 'Y', -5084564, 42, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (208, 'Warley', '81st Street', 177, 'Y', -5962561, 4, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (209, 'Araras', '40 Judd Road', 123, 'N', -4599236, 18, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (210, 'Lowell', '97 Kravitz Street', 798, 'N', -2957826, 90, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (211, 'Vilafranca Penedes', '442 Van Shelton Street', 893, 'Y', -882959, 23, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (212, 'Rosemead', '31st Street', 449, 'N', -670850, 1, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (213, 'Aurora', '22 Chilton Drive', 443, 'N', -3772806, 94, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (214, 'Okayama', '52 Tomei Street', 291, 'Y', -4221248, 17, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (215, 'Maintenon', '10 Sandler Ave', 643, 'N', -5800815, 67, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (216, 'New York City', '439 Burwood East Street', 682, 'N', -1276732, 11, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (217, 'Friedrichshafe', '97 Petula Street', 81, 'N', -6937595, 14, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (218, 'Boston', '17 Bernex Road', 377, 'N', -9461035, 63, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (219, 'Houston', '73 Randall Road', 425, 'N', -9587984, 66, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (220, 'Padova', '32 Howard Road', 675, 'Y', -9962149, 47, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (221, 'Pomona', '22 Folds Drive', 78, 'N', -2955755, 68, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (222, 'Kanata', '63 Rain Drive', 105, 'N', -1183873, 82, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (223, 'Mito', '458 Sao jose rio preto', 792, 'Y', -4885959, 39, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (224, 'Maryville', '47 Fleet Drive', 777, 'Y', -5000327, 5, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (225, 'Salisbury', '28 Nelly Drive', 57, 'Y', -8106104, 26, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (226, 'Pusan-city', '55 Tbilisi Drive', 425, 'N', -8254673, 72, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (227, 'Groton', '61 Holliday Street', 945, 'Y', -9881220, 100, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (228, 'Brampton', '288 Johnson Street', 173, 'Y', -7376709, 5, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (229, 'Altamonte Springs', '53 Raybon Street', 83, 'N', -6977039, 62, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (230, 'Rothenburg', '63rd Street', 285, 'N', -3242594, 34, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (231, 'Tilst', '18 Damon Street', 526, 'Y', -5527101, 50, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (232, 'Sulzbach', '65 Hoskins Road', 555, 'Y', -17678, 0, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (233, 'Alpharetta', '68 George Street', 544, 'N', -8553532, 85, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (234, 'San Jose', '13 De Almeida Street', 466, 'N', -5744840, 18, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (235, 'San Dimas', '11st Street', 56, 'Y', -1798886, 73, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (236, 'Chapel hill', '10 Rene Drive', 773, 'N', -6103927, 42, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (237, 'Golden', '127 Stuttgart Blvd', 938, 'Y', -5248866, 68, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (238, 'Swannanoa', '62 Loggins', 111, 'N', -6197125, 25, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (239, 'Hohenfels', '62 Johnson Road', 904, 'Y', -5197040, 19, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (240, 'Avon', '94 Rachel Drive', 521, 'N', -2738262, 9, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (241, 'Huntsville', '35 First Drive', 198, 'N', -8020674, 39, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (242, 'New York', '281 Blaine Road', 424, 'N', -5982821, 40, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (243, 'Bonn', '73 Idle Drive', 955, 'Y', -7895980, 84, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (244, 'Paisley', '54 Arlington Street', 819, 'Y', -7733193, 8, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (245, 'Warsaw', '73 New hartford Street', 112, 'Y', -2150609, 84, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (246, 'Anchorage', '14 Donald Street', 145, 'Y', -7263223, 100, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (247, 'Yavne', '74 Roth Road', 961, 'N', -5486445, 87, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (248, 'El Dorado Hills', '77 Holliday Street', 711, 'N', -2906640, 14, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (249, 'Mason', '61 Caan Road', 206, 'N', -8539684, 63, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (250, 'Cerritos', '44 Baarn', 59, 'N', -8369389, 45, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (251, 'Vilafranca Penedes', '49 Mount Laurel Drive', 293, 'Y', -6210119, 24, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (252, 'Yamagata', '697 Lewin Road', 210, 'Y', -8943938, 27, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (253, 'Limeira', '62 Crowell Road', 893, 'Y', -3459077, 7, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (254, 'Monroe', '14 Wayman Street', 846, 'N', -3993488, 14, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (255, 'Potsdam', '52 Myles Drive', 356, 'Y', -2841289, 99, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (256, 'Holliston', '56 Christian Road', 892, 'N', -3021139, 46, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (257, 'Redding', '62nd Street', 217, 'Y', -1643112, 100, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (258, 'Nagasaki', '73 Haynes Street', 605, 'Y', -6315341, 69, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (259, 'Kochi', '2 Adler Blvd', 734, 'N', -6224048, 70, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (260, 'Macclesfield', '92 Kylie Drive', 608, 'Y', -1883217, 3, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (261, 'Vancouver', '427 Americana Road', 695, 'Y', -691882, 64, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (262, 'Soest', '28 Clive', 503, 'N', -6430375, 6, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (263, 'Wageningen', '40 Natalie Street', 561, 'Y', -9837961, 30, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (264, 'Pirmasens', '37 Knight Drive', 392, 'Y', -1280903, 48, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (265, 'Cedar Rapids', '64 Julianna Road', 306, 'N', -2018993, 31, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (266, 'Southampton', '87 Beals Ave', 470, 'N', -7142692, 96, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (267, 'Steyr', '37 Marlon Road', 724, 'Y', -9124897, 58, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (268, 'Zipf', '92 Rickie', 898, 'Y', -9173727, 14, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (269, 'San Ramon', '59 Christian Street', 666, 'N', -8462336, 4, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (270, 'Recife', '66 Mekhi Drive', 137, 'Y', -9184599, 93, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (271, 'Cle Elum', '11 Morris Road', 942, 'Y', -8377307, 68, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (272, 'Fairbanks', '54 Perlman Drive', 638, 'N', -7346642, 9, 6);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (273, 'Ft. Lauderdale', '62 Vance Street', 779, 'Y', -5749501, 42, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (274, 'Glen Cove', '41 Claire Street', 251, 'Y', -4426171, 30, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (275, 'Lakeville', '71 Liam Ave', 215, 'N', -857478, 75, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (276, 'Bartlett', '92nd Street', 185, 'Y', -5325737, 67, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (277, 'Bingham Farms', '73 Vern Street', 424, 'Y', -5088757, 13, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (278, 'Altamonte Springs', '33 Solon Road', 879, 'N', -1459060, 61, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (279, 'Milsons Point', '2 Santa Cruz Road', 589, 'Y', -9436767, 65, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (280, 'Luedenscheid', '19 Tyler Road', 484, 'N', -3276786, 25, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (281, 'Zagreb', '49 Ft. Leavenworth Drive', 142, 'N', -4576444, 19, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (282, 'Maebashi', '43 Steagall Street', 434, 'N', -2756147, 38, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (283, 'Toledo', '786 Shawn Road', 131, 'N', -1855905, 18, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (284, 'Bautzen', '979 Ernie', 534, 'Y', -8943451, 66, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (285, 'Lucca', '10 Chaka Drive', 805, 'Y', -8668011, 47, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (286, 'Baarn', '81 Winans Road', 308, 'N', -3096810, 38, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (287, 'Gattico', '976 Rip Street', 1000, 'N', -9649337, 36, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (288, 'Holts Summit', '78 Popper Street', 960, 'N', -2885174, 49, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (289, 'Vantaa', '89 Melba Drive', 357, 'N', -3191192, 100, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (290, 'Fredericia', '586 Bracco Road', 934, 'N', -8909165, 38, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (291, 'Plymouth Meeting', '97 Wehrheim Street', 865, 'N', -9451546, 55, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (292, 'Frederiksberg', '11st Street', 99, 'N', -6688674, 67, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (293, 'Rio de janeiro', '25 Yomgok-dong Street', 855, 'N', -1341784, 96, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (294, 'Valencia', '78 Baldwin Road', 660, 'Y', -7209793, 37, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (295, 'Akita', '29 Thornton Street', 827, 'Y', -4349165, 17, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (296, 'Reading', '350 Wilmington Road', 958, 'N', -6665196, 93, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (297, 'Lake Oswego', '96 Barkin Blvd', 303, 'Y', -1855298, 25, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (298, 'Courbevoie', '26 Hal Ave', 88, 'Y', -1277162, 71, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (299, 'Enschede', '60 Brothers Road', 722, 'N', -444762, 76, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (300, 'Bozeman', '72nd Street', 613, 'Y', -8819908, 15, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (301, 'Kyoto', '52 Maxwell Street', 988, 'N', -5954792, 86, 1);
commit;
prompt 300 records committed...
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (302, 'Ohtsu', '7 Novara', 780, 'N', -4452434, 16, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (303, 'Lefkosa', '73 Chambersburg Street', 885, 'N', -6454769, 74, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (304, 'East Providence', '58 Itu Road', 404, 'N', -5626089, 35, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (305, 'Webster Groves', '85 Liev Drive', 940, 'Y', -2927316, 31, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (306, 'Hannover', '86 McPherson', 591, 'N', -4523138, 65, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (307, 'Oshawa', '30 Limeira Ave', 922, 'N', -4357915, 34, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (308, 'Takamatsu', '83rd Street', 472, 'Y', -2055199, 52, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (309, 'Rockland', '80 Stockard Street', 172, 'N', -3723890, 19, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (310, 'Chennai', '36 Gates Street', 576, 'Y', -554666, 42, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (311, 'Paderborn', '54 Spacek', 200, 'N', -7306695, 52, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (312, 'Cesena', '69 Sample', 458, 'N', -488278, 80, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (313, 'Nara', '42nd Street', 469, 'N', -9636981, 60, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (314, 'Cuiab×‘', '944 Johnnie Road', 525, 'Y', -5424577, 87, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (315, 'Immenstaad', '8 Whitley Road', 333, 'Y', -678224, 55, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (316, 'Hannover', '97 Jonny Lee Street', 810, 'N', -3268432, 6, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (317, 'Staten Island', '1 Fiennes Street', 680, 'N', -9828481, 29, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (318, 'Bangalore', '94 Karlstad Drive', 710, 'N', -9623728, 81, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (319, 'Sheffield', '62 Firth Road', 941, 'Y', -2925278, 87, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (320, 'Fort Collins', '849 Malm×¦ Ave', 893, 'N', -1239237, 36, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (321, 'Billund', '51 Remar Street', 658, 'Y', -1811788, 91, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (322, 'Cary', '54 Harary Street', 296, 'Y', -9527342, 51, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (323, 'Alpharetta', '88 Firth Road', 798, 'Y', -1651444, 99, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (324, 'Kejae City', '59 Double Oak Street', 867, 'Y', -4699972, 21, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (325, 'Hjallerup', '12nd Street', 739, 'Y', -5501120, 97, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (326, 'Neustadt', '96 Gary Blvd', 724, 'N', -2704651, 88, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (327, 'Zaandam', '2 Slough Street', 536, 'N', -4393594, 30, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (328, 'Lowell', '97 Ojeda Drive', 175, 'Y', -6059973, 4, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (329, 'Golden', '6 Yamaguchi Street', 499, 'N', -179447, 91, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (330, 'Bountiful', '620 Dorff', 742, 'Y', -9222222, 95, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (331, 'Mountain View', '16 Wheel Ave', 729, 'N', -5515485, 93, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (332, 'West Drayton', '44 Underwood Ave', 314, 'N', -3858216, 94, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (333, 'Research Triangle', '30 Glover Road', 723, 'Y', -9330437, 9, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (334, 'Glen Cove', '50 Redondo beach Blvd', 348, 'Y', -2326182, 89, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (335, 'Tadley', '63 White', 796, 'N', -5114924, 90, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (336, 'Schaumburg', '969 Feliciano Road', 455, 'Y', -3157462, 13, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (337, 'Casselberry', '74 Berkley Drive', 665, 'Y', -2138459, 90, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (338, 'Laredo', '65 Aimee', 102, 'Y', -3369162, 69, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (339, 'Fort gordon', '92 Kershaw Street', 152, 'N', -2100791, 71, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (340, 'Pusan', '84 Chapman Drive', 847, 'N', -3569495, 3, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (341, 'H×”ssleholm', '485 Cozier Road', 94, 'N', -1798541, 84, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (342, 'Treviso', '808 Corona Ave', 921, 'Y', -6531727, 15, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (343, 'Waite Park', '510 Campbell Street', 463, 'N', -5241705, 60, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (344, 'Rancho Palos Verdes', '982 Gandolfini Blvd', 483, 'N', -9520729, 19, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (345, 'Uden', '53 Nastassja Street', 546, 'Y', -7414572, 85, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (346, 'Mexico City', '78 Pepper Street', 587, 'N', -7348441, 8, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (347, 'Dalmine', '847 Bielefeld Drive', 388, 'Y', -3557737, 64, 4);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (348, 'Encinitas', '62nd Street', 522, 'N', -2187588, 88, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (349, 'Bellevue', '11 Bates Blvd', 927, 'N', -3502160, 7, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (350, 'Saint Paul', '85 Giraldo Ave', 282, 'N', -8094949, 0, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (351, 'Northampton', '96 Brooke Street', 918, 'N', -6157159, 70, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (352, 'Karlsruhe', '78 Nashua Road', 179, 'N', -9570894, 57, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (353, 'Ringwood', '35 Brad Drive', 54, 'N', -8079364, 92, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (354, 'Hercules', '31 Rochester Ave', 893, 'N', -8080130, 89, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (355, 'Herdecke', '66 Bergen Street', 694, 'Y', -3323768, 4, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (356, 'Araras', '100 Marie Street', 405, 'N', -1361491, 23, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (357, 'Gauteng', '42 Waldbronn', 319, 'N', -7986488, 90, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (358, 'Tilst', '50 Whitmore Street', 480, 'N', -884153, 27, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (359, 'Ingelheim', '73 Baez Road', 869, 'Y', -7061214, 16, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (360, 'Plymouth Meeting', '71 Avalon Road', 411, 'Y', -3759867, 30, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (361, 'Houma', '9 Reeve Blvd', 383, 'N', -7728295, 86, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (362, 'Salzburg', '139 McCain Road', 498, 'Y', -5405398, 78, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (363, 'Mogi Guacu', '62nd Street', 304, 'Y', -2678114, 9, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (364, 'Kobe', '637 Torres Ave', 279, 'N', -7032967, 3, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (365, 'Nordhausen', '61st Street', 965, 'Y', -3122460, 90, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (366, 'Tustin', '566 Desmond Road', 825, 'Y', -9599822, 46, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (367, 'Riverdale', '4 Brody Road', 935, 'N', -9971606, 94, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (368, 'Parsippany', '18 Amsterdam Road', 853, 'Y', -4515270, 71, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (369, 'Paisley', '63 Drew Street', 446, 'N', -6828853, 10, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (370, 'Cambridge', '50 Herford Street', 896, 'N', -9919402, 98, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (371, 'Mito', '25 Wilmington Road', 342, 'Y', -6949668, 69, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (372, 'Sendai', '100 Hanks Road', 351, 'Y', -6200283, 67, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (373, 'Birmingham', '844 Stuart Road', 375, 'Y', -4578579, 84, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (374, 'Beaverton', '47 Newton-le-willows Street', 822, 'N', -2405030, 97, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (375, 'Waldorf', '988 Rourke Road', 122, 'N', -9874472, 85, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (376, 'Copenhagen', '53 Whitehouse Station Street', 692, 'N', -7919094, 11, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (377, 'Columbia', '82 Neustadt Ave', 693, 'N', -3887173, 78, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (378, 'Albany', '861 Dallas Drive', 684, 'Y', -1985303, 89, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (379, 'Oklahoma city', '608 Avalon Ave', 577, 'N', -7825423, 84, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (380, 'Montr×™al', '98 Kathleen Road', 565, 'Y', -8121081, 80, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (381, 'Adamstown', '92nd Street', 108, 'Y', -7770888, 57, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (382, 'Bellerose', '95 Leon Drive', 119, 'N', -3805972, 36, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (383, 'New Castle', '97 Ehningen Drive', 914, 'N', -5260074, 97, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (384, 'Nagoya', '99 April Drive', 591, 'N', -6972754, 7, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (385, 'Bergen', '39 Polito', 799, 'N', -5147270, 65, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (386, 'Somerset', '98 Carson City', 628, 'N', -4861151, 77, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (387, 'Sao paulo', '34 Clint Drive', 247, 'Y', -9552395, 52, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (388, 'Antwerpen', '51 Franco Road', 460, 'Y', -3770593, 100, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (389, 'Milano', '81 Jones Drive', 303, 'N', -5356639, 65, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (390, 'Traralgon', '93rd Street', 299, 'Y', -5076829, 87, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (391, 'Sundsvall', '13 Karen Street', 955, 'N', -5826828, 66, 3);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (392, 'Augsburg', '83 Alda', 85, 'Y', -7524742, 16, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (393, 'Lake worth', '75 Rush Road', 873, 'N', -5277053, 22, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (394, 'Long Island City', '38 Jude Blvd', 230, 'N', -4304556, 85, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (395, 'Zipf', '11 Daejeon Street', 752, 'Y', -4500336, 33, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (396, 'Butner', '91 Clarkson Drive', 407, 'Y', -2835422, 45, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (397, 'Knutsford', '82nd Street', 83, 'N', -7179147, 17, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (398, 'Dinslaken', '32 Jennifer Drive', 708, 'N', -4176104, 15, 1);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (399, 'Rheinfelden', '44 Giamatti Street', 846, 'N', -6849214, 40, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (400, 'Spring Valley', '88 Ribisi Street', 573, 'N', -8538327, 56, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (401, 'Berkeley', '100 Payton', 968, 'N', -1469260, 40, 0);
commit;
prompt 400 records committed...
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (402, 'Carmichael', '88 Herndon', 379, 'Y', -3854706, 10, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (403, 'Valencia', '11 Des Plaines Ave', 297, 'N', -236812, 48, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (404, 'Southend on Sea', '27 Ticotin Street', 772, 'Y', -2531399, 98, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (405, 'B×¨nes', '617 Llewelyn Street', 211, 'Y', -7981022, 87, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (406, 'Glasgow', '41 Winterthur Blvd', 720, 'N', -2223269, 7, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (407, 'St. Louis', '63rd Street', 761, 'Y', -6843460, 90, 2);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (408, 'Rosario', '35 Stiles Road', 965, 'Y', -3962966, 59, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (409, 'Archbold', '77 Byrne', 496, 'Y', -4325789, 60, 0);
insert into LOCATIONS (locationid, locationname, address, capacity, accessibility, contactperson, parking, ticketssold)
values (410, 'Pensacola', '38 Hopkins Street', 312, 'Y', -4688325, 99, 0);
commit;
prompt 409 records loaded
prompt Loading CATERING...
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0541234567', 'rabanut', 1, 'Delicious Catering', 'YES', 1);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0522345678', 'rabanut mehadrin', 2, 'Jerusalem Catering', 'YES', 2);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0503456789', 'eida charedit', 3, 'Haifa Delights', 'NO', 3);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0534567890', 'rubin', 4, 'Negev Catering', 'YES', 1);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0545678901', 'bet yosef', 5, 'Eilat Catering', 'NO', 2);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0526789012', 'mehuderet', 6, 'Rishon Tastes', 'NO', 3);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0507890123', 'rabanut', 7, 'Netanya Feasts', 'NO', 3);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0538901234', 'rabanut mehadrin', 8, 'Petah Delicacies', 'NO', 3);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0549012345', 'eida charedit', 9, 'Ashdod Catering', 'YES', 3);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0520123456', 'rubin', 10, 'Holon Catering', 'NO', 4);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0501234567', 'bet yosef', 11, 'Bnei Brak Tastes', 'YES', 4);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0532345678', 'mehuderet', 12, 'Bat Yam Catering', 'NO', 4);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0543456789', 'rabanut', 13, 'Herzliya Delights', 'NO', 4);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0524567890', 'rabanut mehadrin', 14, 'Kfar Saba Catering', 'NO', 5);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0505678901', 'eida charedit', 15, 'Rehovot Feasts', 'NO', 5);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0536789012', 'rubin', 16, 'Ashkelon Catering', 'NO', 6);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0547890123', 'bet yosef', 17, 'Raanana Tastes', 'NO', 6);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0528901234', 'mehuderet', 18, 'Modiin Catering', 'NO', 7);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0509012345', 'rabanut', 19, 'Nahariya Delights', 'NO', 7);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0530123456', 'rabanut mehadrin', 20, 'Afula Catering', 'NO', 7);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0541234567', 'eida charedit', 21, 'Tiberias Catering', 'NO', 8);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0522345678', 'rubin', 22, 'Yavne Feasts', 'NO', 8);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0503456789', 'bet yosef', 23, 'Karmiel Delights', 'NO', 8);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0534567890', 'mehuderet', 24, 'Beit Shemesh Catering', 'NO', 9);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0545678901', 'rabanut', 25, 'Kiryat Gat Tastes', 'NO', 9);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0526789012', 'rabanut mehadrin', 26, 'Hadera Catering', 'NO', 9);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0507890123', 'eida charedit', 27, 'Tzfat Catering', 'NO', 9);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0538901234', 'rubin', 28, 'Arad Feasts', 'NO', 9);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0549012345', 'bet yosef', 29, 'Dimona Delights', 'NO', 9);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0520123456', 'mehuderet', 30, 'Maale Adumim Catering', 'NO', 10);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0501234567', 'rabanut', 31, 'Zichron Yaakov Catering', 'NO', 1);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0532345678', 'rabanut mehadrin', 32, 'Rosh HaAyin Feasts', 'NO', 11);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0543456789', 'eida charedit', 33, 'Kiryat Shmona Delights', 'NO', 12);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0524567890', 'rubin', 34, 'Sderot Catering', 'NO', 12);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0505678901', 'bet yosef', 35, 'Ness Ziona Tastes', 'NO', 13);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0536789012', 'mehuderet', 36, 'Kiryat Yam Catering', 'NO', 13);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0547890123', 'rabanut', 37, 'Or Yehuda Feasts', 'NO', 14);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0528901234', 'rabanut mehadrin', 38, 'Migdal HaEmek Catering', 'NO', 15);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0509012345', 'eida charedit', 39, 'Ramat HaSharon Delights', 'NO', 16);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0530123456', 'rubin', 40, 'Kiryat Malakhi Catering', 'NO', 17);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0541234567', 'bet yosef', 41, 'Ariel Feasts', 'NO', 19);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0522345678', 'mehuderet', 42, 'Sakhnin Catering', 'NO', 19);
insert into CATERING (phone_number, kashrut, c_id, catering_name, celiac, locationi__d)
values ('0587154110', 'rabanut mehadrin', 43, 'CateringBeersheba', 'NO', 19);
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
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Rinas Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 160, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Adinas Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 170, 8, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Shirs Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 171, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Hallels Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 172, 8, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Little Stars', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 1, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Happy Kids', to_date('31-05-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 2, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Sunshine Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 3, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Play and Learn', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 4, 28, 9);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Tiny Tots', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 5, 7, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Kid''s Haven', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 6, 10, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Smiles Daycare', to_date('31-05-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 7, 10, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Fun Time', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 8, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Children''s Corner', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 9, 9, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Little Angels', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 10, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Happy Hearts', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 11, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Sunrise Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 12, 13, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Laughing Kids', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 13, 13, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Kids'' Paradise', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 14, 13, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Dreamland', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 15, 7, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Learning Tree', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 16, 8, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Little Learners', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 17, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Happy Hands', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 18, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Kid''s World', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 19, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Smart Kids', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 20, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Tiny Treasures', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 21, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Loving Care', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 22, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Little Scholars', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 23, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Kids'' Kingdom', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 24, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Tiny Adventures', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 25, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Playful Minds', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 26, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Joyful Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 27, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Happy Times', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 28, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Kid''s Corner', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 29, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Learning Land', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 30, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Little Explorers', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 31, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Smart Start', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 32, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Happy Days', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 33, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Little Stars', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 34, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Happy Kids', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 35, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Sunshine Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 36, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Play and Learn', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 37, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Tiny Tots', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 38, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Kid''s Haven', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 39, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Smiles Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 40, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Fun Time', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 41, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Children''s Corner', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 42, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Little Angels', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 43, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Happy Hearts', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 44, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Sunrise Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 45, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Laughing Kids', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 46, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Kids'' Paradise', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 47, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Dreamland', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 48, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Learning Tree', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 49, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Little Learners', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 50, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Sunshine Kids', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 51, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Happy Days', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), 52, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Little Wonders', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 53, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Tiny Miracles', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 54, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Kids World', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 55, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Smiles and Fun', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 56, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('Charedi', 'Happy_Days', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 60, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('Charedi', 'Child''s_Town', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 61, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('Charedi', 'Sunshine', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 62, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Happy Days', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), 152, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Little Wonders', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 153, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('DATI', 'Tiny Miracles', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 154, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Kids World', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 155, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHILONI', 'Smiles and Fun', to_date('05-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-05-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 156, null, null);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Magic Moments', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 110, 42, 19);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Little Lambs', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 111, 42, 19);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Sunshine Smiles', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 112, 41, 19);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Little Angels', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 113, 41, 19);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Playtime Palace', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 114, 41, 19);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Daycare1', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 115, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Sunshine Kids', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 116, 12, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Little Stars', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 117, 6, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Caring Kids', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 118, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Bright Beginnings', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 119, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Wonder World', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 120, 5, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Playful Preschool', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 121, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Growing Together', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 122, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Kinder Kids', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 123, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Fun Frolics', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 124, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Learning Ladder', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 125, 5, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Little Einsteins', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 126, 6, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Kidz Klub', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 127, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Happy Home', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 128, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Teddy Bear Daycare', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 129, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Wonderland', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 130, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Gan Shalom', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 67, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Sunshine Daycare', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 68, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Happy Kids', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 69, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Little Angels', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 70, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Tiny Tots', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 71, 5, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Busy Bees', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 73, 6, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Playful Pals', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 74, 7, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Smiling Faces', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 75, 8, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Happy Hearts', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 76, 9, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Rainbow Kids', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 77, 10, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Sunny Skies', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 78, 11, 4);
commit;
prompt 100 records committed...
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Bright Beginnings', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 79, 12, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Little Learners', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 80, 13, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Happy Days', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 81, 14, 5);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Tiny Treasures', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 82, 15, 5);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Playtime Paradise', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 83, 16, 6);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Fun Factory', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 84, 17, 6);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Angelic Care', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 85, 18, 7);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Kinder Garden', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 86, 19, 7);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Growing Up', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 87, 20, 7);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Shining Stars', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 88, 21, 8);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Smart Start', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 89, 22, 8);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Bright Minds', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 90, 23, 8);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Little Explorers', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 91, 24, 9);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Rainbow Daycare', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 92, 25, 9);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Sunshine Kids', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 93, 26, 9);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Dreamy Days', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 94, 27, 9);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Happy Campers', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 95, 28, 9);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Little Stars', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 96, 29, 9);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Caring Kids', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 97, 30, 10);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Bright Beginnings', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 98, 31, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Wonder World', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 99, 32, 11);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Playful Preschool', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 100, 33, 12);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Growing Together', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 101, 34, 12);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Kinder Kids', to_date('09-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 102, 35, 13);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Fun Frolics', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 103, 36, 13);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Learning Ladder', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 104, 37, 14);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Little Einsteins', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 105, 38, 15);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Kidz Klub', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 106, 39, 16);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Happy Home', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 107, 40, 17);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Teddy Bear Daycare', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 108, 41, 19);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Wonderland', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 109, 42, 19);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Magic Moments', to_date('09-06-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 131, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Little Lambs', to_date('09-06-2024 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 132, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Sunshine Smiles', to_date('09-06-2024 13:45:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:45:00', 'dd-mm-yyyy hh24:mi:ss'), 133, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Little Angels', to_date('09-06-2024 14:15:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:15:00', 'dd-mm-yyyy hh24:mi:ss'), 134, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Playtime Palace', to_date('09-06-2024 13:20:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:20:00', 'dd-mm-yyyy hh24:mi:ss'), 135, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Daycare1', to_date('09-06-2024 13:10:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:10:00', 'dd-mm-yyyy hh24:mi:ss'), 136, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Sunshine Kids', to_date('09-06-2024 13:55:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:55:00', 'dd-mm-yyyy hh24:mi:ss'), 137, 12, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Little Stars', to_date('09-06-2024 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), 138, 6, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Caring Kids', to_date('09-06-2024 13:40:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:40:00', 'dd-mm-yyyy hh24:mi:ss'), 139, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Bright Beginnings', to_date('09-06-2024 13:25:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:25:00', 'dd-mm-yyyy hh24:mi:ss'), 140, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Wonder World', to_date('09-06-2024 13:50:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:50:00', 'dd-mm-yyyy hh24:mi:ss'), 141, 5, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Playful Preschool', to_date('09-06-2024 14:10:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:10:00', 'dd-mm-yyyy hh24:mi:ss'), 142, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Growing Together', to_date('09-06-2024 13:35:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:35:00', 'dd-mm-yyyy hh24:mi:ss'), 143, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Kinder Kids', to_date('09-06-2024 14:20:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:20:00', 'dd-mm-yyyy hh24:mi:ss'), 144, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Fun Frolics', to_date('09-06-2024 13:15:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:15:00', 'dd-mm-yyyy hh24:mi:ss'), 145, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Learning Ladder', to_date('09-06-2024 13:05:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:05:00', 'dd-mm-yyyy hh24:mi:ss'), 146, 5, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Little Einsteins', to_date('09-06-2024 13:45:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:45:00', 'dd-mm-yyyy hh24:mi:ss'), 147, 6, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Kidz Klub', to_date('09-06-2024 14:25:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:25:00', 'dd-mm-yyyy hh24:mi:ss'), 148, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Happy Home', to_date('09-06-2024 13:55:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:55:00', 'dd-mm-yyyy hh24:mi:ss'), 149, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHILONI', ' Teddy Bear Daycare', to_date('09-06-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 150, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Wonderland', to_date('09-06-2024 14:15:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-06-2024 16:15:00', 'dd-mm-yyyy hh24:mi:ss'), 151, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('CHAREDI', 'Morah Sarah', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 177, 43, 19);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('chiloni', 'Tel Aviv Daycare', to_date('01-06-2024 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 18:00:00', 'dd-mm-yyyy hh24:mi:ss'), 63, 1, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('dati', 'Jerusalem Daycare', to_date('01-06-2024 12:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 18:30:00', 'dd-mm-yyyy hh24:mi:ss'), 64, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('chiloni', 'Haifa Daycare', to_date('01-06-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 19:00:00', 'dd-mm-yyyy hh24:mi:ss'), 65, 3, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('charedi', 'Negev Daycare', to_date('01-06-2024 13:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 19:30:00', 'dd-mm-yyyy hh24:mi:ss'), 66, 4, 1);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values ('charedi', 'Holon Daycare', to_date('01-06-2024 16:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('01-06-2024 22:30:00', 'dd-mm-yyyy hh24:mi:ss'), 72, 10, 4);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Cuties Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 173, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' sunshine Daycare', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 174, 8, 3);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' CHAREDI', ' Precious Moments', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 175, 2, 2);
insert into DAYCARE (sector, daycare_name, open_time, close_time, d_id, c_id, locationid)
values (' DATI', ' Little Ones', to_date('31-05-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-05-2024 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 176, 8, 3);
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
prompt Loading EVENTTYPE...
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (1, 'Sports', 'Various sports events');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (2, 'Community', 'Community gatherings and social events');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (3, 'Culture', 'Cultural events and activities');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (4, 'Independence Day', 'Celebration of national independence');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (5, 'Theatre', 'Theatre performances');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (6, 'Memorial Day', 'Memorial events');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (7, 'Education', 'Educational seminars and workshops');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (8, 'Concert', 'Music concerts');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (9, 'Festival', 'Festivals and celebrations');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (10, 'Cinema', 'Film screenings and movie events');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (11, '55172M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (12, '95981M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (13, '56498M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (14, '99323M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (15, '17663M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (16, '75395M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (17, '68567M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (18, '6733M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (19, '1548M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (20, '69415M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (21, '8979M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (22, '22010M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (23, '91236M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (24, '47509M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (25, '11424M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (26, '42557M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (27, '51778M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (28, '2320M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (29, '10283M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (30, '66354M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (31, '92705M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (32, '74908M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (33, '14153M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (34, '93141M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (35, '70772M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (36, '2554M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (37, '61197M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (38, '18745M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (39, '44391M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (40, '77968M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (41, '9466M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (42, '90240M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (43, '68251M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (44, '91454M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (45, '33078M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (46, '39397M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (47, '12396M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (48, '78390M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (49, '46895M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (50, '85641M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (51, '16790M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (52, '86075M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (53, '69087M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (54, '94442M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (55, '39113M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (56, '59789M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (57, '90732M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (58, '32865M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (59, '47312M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (60, '81630M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (61, '26333M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (62, '37726M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (63, '57187M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (64, '32470M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (65, '46902M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (66, '20547M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (67, '32002M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (68, '49101M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (69, '37983M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (70, '45286M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (71, '81907M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (72, '5392M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (73, '18783M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (74, '66512M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (75, '39675M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (76, '33054M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (77, '17281M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (78, '16516M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (79, '88033M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (80, '63317M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (81, '98955M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (82, '66530M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (83, '79576M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (84, '58623M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (85, '83531M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (86, '21020M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (87, '66067M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (88, '54143M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (89, '92886M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (90, '95767M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (91, '24607M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (92, '44701M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (93, '28995M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (94, '9156M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (95, '59956M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (96, '74440M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (97, '65566M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (98, '72922M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (99, '11015M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (100, '20303M marathon', 'Running a marathon for health');
commit;
prompt 100 records committed...
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (101, '4749M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (102, '73260M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (103, '87238M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (104, '70155M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (105, '28068M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (106, '74042M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (107, '27490M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (108, '50126M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (109, '49457M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (110, '71563M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (111, '40615M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (112, '37512M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (113, '51047M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (114, '9038M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (115, '79723M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (116, '67292M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (117, '45095M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (118, '99799M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (119, '65978M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (120, '32107M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (121, '13186M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (122, '46882M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (123, '39386M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (124, '9278M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (125, '99613M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (126, '28489M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (127, '30859M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (128, '85177M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (129, '73566M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (130, '7487M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (131, '68562M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (132, '59040M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (133, '69524M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (134, '85929M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (135, '63322M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (136, '27061M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (137, '85986M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (138, '96284M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (139, '35598M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (140, '1313M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (141, '4441M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (142, '11842M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (143, '82295M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (144, '9859M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (145, '34211M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (146, '11479M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (147, '1414M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (148, '70111M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (149, '28551M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (150, '48748M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (151, '2339M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (152, '46264M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (153, '3165M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (154, '87003M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (155, '93233M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (156, '20403M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (157, '55014M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (158, '8991M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (159, '18850M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (160, '49585M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (161, '82056M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (162, '16142M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (163, '62753M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (164, '86990M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (165, '26318M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (166, '80477M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (167, '82704M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (168, '77968M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (169, '1437M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (170, '6866M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (171, '13762M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (172, '68554M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (173, '86557M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (174, '5082M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (175, '49334M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (176, '89787M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (177, '88218M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (178, '12834M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (179, '22191M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (180, '1904M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (181, '91652M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (182, '94766M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (183, '7250M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (184, '2239M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (185, '73592M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (186, '10091M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (187, '34589M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (188, '50412M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (189, '41512M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (190, '26350M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (191, '92998M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (192, '53119M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (193, '10924M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (194, '32455M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (195, '45058M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (196, '2626M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (197, '48128M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (198, '68010M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (199, '89541M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (200, '79776M marathon', 'Running a marathon for health');
commit;
prompt 200 records committed...
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (201, '36558M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (202, '64589M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (203, '55606M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (204, '64083M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (205, '37606M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (206, '84432M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (207, '95101M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (208, '91271M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (209, '62573M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (210, '89760M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (211, '17951M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (212, '71296M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (213, '77136M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (214, '82667M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (215, '84422M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (216, '54712M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (217, '94468M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (218, '94284M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (219, '53758M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (220, '97940M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (221, '39904M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (222, '21676M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (223, '45473M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (224, '83778M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (225, '84795M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (226, '28667M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (227, '62306M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (228, '77222M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (229, '92936M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (230, '73558M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (231, '97596M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (232, '39435M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (233, '15717M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (234, '22422M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (235, '2608M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (236, '24435M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (237, '27878M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (238, '49461M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (239, '96077M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (240, '27834M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (241, '12516M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (242, '60581M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (243, '57954M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (244, '67705M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (245, '8725M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (246, '69191M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (247, '10173M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (248, '13401M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (249, '92029M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (250, '12887M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (251, '88899M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (252, '88918M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (253, '63470M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (254, '98501M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (255, '84565M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (256, '32108M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (257, '41024M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (258, '15691M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (259, '57687M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (260, '63843M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (261, '2704M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (262, '37068M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (263, '91244M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (264, '14940M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (265, '18517M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (266, '18510M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (267, '38112M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (268, '12439M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (269, '62149M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (270, '60163M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (271, '47849M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (272, '13548M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (273, '1023M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (274, '79297M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (275, '8818M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (276, '54348M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (277, '91129M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (278, '25999M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (279, '26432M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (280, '36077M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (281, '50747M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (282, '22382M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (283, '24034M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (284, '74574M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (285, '58978M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (286, '27778M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (287, '42663M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (288, '87203M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (289, '20705M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (290, '43112M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (291, '68747M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (292, '88355M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (293, '97384M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (294, '11413M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (295, '25468M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (296, '16335M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (297, '82798M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (298, '81168M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (299, '93317M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (300, '18222M marathon', 'Running a marathon for health');
commit;
prompt 300 records committed...
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (301, '78675M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (302, '42952M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (303, '65118M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (304, '65028M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (305, '98804M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (306, '41579M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (307, '29520M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (308, '71238M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (309, '17037M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (310, '37674M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (311, '48739M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (312, '34556M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (313, '12325M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (314, '71418M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (315, '85043M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (316, '33432M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (317, '5675M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (318, '39883M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (319, '69272M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (320, '43702M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (321, '73664M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (322, '1184M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (323, '29395M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (324, '55420M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (325, '85908M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (326, '63388M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (327, '23861M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (328, '5708M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (329, '6629M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (330, '29881M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (331, '45283M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (332, '58207M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (333, '48197M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (334, '86667M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (335, '84690M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (336, '2437M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (337, '87300M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (338, '79769M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (339, '76399M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (340, '36186M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (341, '56126M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (342, '4720M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (343, '62240M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (344, '70702M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (345, '75706M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (346, '97818M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (347, '47664M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (348, '69317M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (349, '14299M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (350, '32614M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (351, '37004M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (352, '93794M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (353, '59461M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (354, '16839M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (355, '66897M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (356, '44496M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (357, '56195M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (358, '75706M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (359, '81628M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (360, '95198M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (361, '41320M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (362, '69310M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (363, '13928M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (364, '76114M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (365, '72945M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (366, '46563M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (367, '63482M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (368, '43488M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (369, '52690M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (370, '67881M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (371, '2149M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (372, '41798M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (373, '65056M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (374, '39564M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (375, '22691M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (376, '59423M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (377, '1061M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (378, '28576M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (379, '29497M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (380, '15344M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (381, '30066M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (382, '66190M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (383, '36582M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (384, '35211M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (385, '43391M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (386, '57675M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (387, '6878M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (388, '12839M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (389, '79147M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (390, '44006M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (391, '65576M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (392, '51984M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (393, '99412M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (394, '96285M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (395, '65033M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (396, '41961M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (397, '89628M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (398, '39322M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (399, '77522M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (400, '11437M marathon', 'Running a marathon for health');
commit;
prompt 400 records committed...
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (401, '88887M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (402, '17602M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (403, '50828M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (404, '58479M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (405, '81471M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (406, '70553M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (407, '54461M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (408, '65676M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (409, '1800M marathon', 'Running a marathon for health');
insert into EVENTTYPE (eventtypeid, eventtype, typedescription)
values (410, '76861M marathon', 'Running a marathon for health');
commit;
prompt 410 records loaded
prompt Loading ORGANIZER...
insert into ORGANIZER (organizerid, organizername, phone, email)
values (1, 'John Doe', 1234567890, 'john@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (2, 'Jane Smith', 2345678901, 'jane@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (3, 'Emily Johnson', 3456789012, 'emily@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (4, 'Michael Brown', 4567890123, 'michael@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (5, 'Jessica Davis', 5678901234, 'jessica@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (6, 'David Wilson', 6789012345, 'david@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (7, 'Sarah Miller', 7890123456, 'sarah@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (8, 'Chris Moore', 8901234567, 'chris@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (9, 'Ashley Taylor', 9012345678, 'ashley@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (10, 'Andrew Anderson', 1234509876, 'andrew@example.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (11, 'Alice Reid', -3821426, 'areid@medsource.mx');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (12, 'Danni Marx', -8377530, 'danni.marx@telecheminternation');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (13, 'Vertical Sevenfold', -9564769, 'verticals@atlanticcredit.is');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (14, 'Grace Margulies', -1453517, 'grace.margulies@marathonheater');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (15, 'Curtis Dillane', -1642190, 'curtis.dillane@staffone.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (16, 'Austin Sanchez', -2206864, 'a.sanchez@hencie.nz');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (17, 'Reese Prowse', -3886788, 'reese.prowse@generalelectric.c');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (18, 'Lee Houston', -1138548, 'lee.houston@bradleypharmaceuti');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (19, 'Kenneth Tobolowsky', -2133456, 'kenneth.tobolowsky@escalade.co');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (20, 'Denise Hynde', -6878478, 'deniseh@sms.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (21, 'John Davies', -1983420, 'john.davies@envisiontelephony.');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (22, 'Geoff Brothers', -9119456, 'geoff.b@scooterstore.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (23, 'Judy Greenwood', -5845202, 'judy.greenwood@ositissoftware.');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (24, 'Wang Gilley', -9499071, 'wang.gilley@comnetinternationa');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (25, 'Miranda Duschel', -2849293, 'miranda.d@valleyoaksystems.at');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (26, 'Roger Farina', -1480816, 'rfarina@atlanticcredit.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (27, 'Hilton Washington', -2839554, 'hwashington@mai.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (28, 'Ramsey Jovovich', -9004345, 'rjovovich@nhhc.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (29, 'Kathy Glenn', -7622781, 'kathy.glenn@sysconmedia.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (30, 'Jeffery Hall', -3038579, 'jefferyh@smg.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (31, 'Azucar Mitra', -5862521, 'azucar@saralee.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (32, 'Rose Salonga', -4164079, 'roses@sfb.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (33, 'Nicky McGill', -2145828, 'nicky.m@elitemedical.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (34, 'Rhys May', -5219051, 'rhys.may@mwh.pt');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (35, 'Madeline El-Saher', -8511449, 'madeline.elsaher@paisley.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (36, 'Robin Addy', -9079593, 'robin.a@virbac.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (37, 'Tramaine Crouch', -4227535, 'tramaine.crouch@mission.dk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (38, 'Uma Cronin', -7515494, 'uma.cronin@intel.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (39, 'Buffy Cazale', -2026122, 'buffy.cazale@ultimus.at');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (40, 'Mike Berenger', -6592606, 'm.berenger@processplus.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (41, 'Tyrone Ribisi', -4681187, 'tyrone@lms.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (42, 'Eliza Rubinek', -9808392, 'eliza.rubinek@airmethods.id');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (43, 'Davis Braugher', -8941871, 'd.braugher@wellsfinancial.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (44, 'Stanley Lillard', -9193261, 'stanleyl@oneidafinancial.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (45, 'Cuba Griggs', -7549080, 'c.griggs@genextechnologies.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (46, 'Allan Pleasure', -9802598, 'allan.pleasure@printtech.is');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (47, 'Sandra Wincott', -6153869, 's.wincott@lemproducts.za');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (48, 'Rosanna Hart', -8989618, 'r.hart@ibfh.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (49, 'Albertina Jessee', -2894420, 'albertina.j@hps.fr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (50, 'Mykelti Weaver', -293999, 'm.weaver@fam.hk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (51, 'Charles Duvall', -7020320, 'charles.duvall@marlabs.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (52, 'Dean Levert', -6410996, 'dlevert@fra.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (53, 'Liquid Epps', -9369196, 'liquid.epps@alogent.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (54, 'Nicole Glenn', -3728855, 'nglenn@lloydgroup.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (55, 'Minnie Stamp', -2020086, 'minnie.stamp@idlabel.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (56, 'Collective Watson', -6288079, 'collective.w@keith.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (57, 'Earl Day-Lewis', -489427, 'earl.daylewis@novartis.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (58, 'Cheryl Morrison', -9101929, 'cheryl.m@cyberthink.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (59, 'Lara Hewitt', -1006659, 'lara.hewitt@hiltonhotels.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (60, 'Adina Connick', -7518808, 'aconnick@diageo.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (61, 'Lara Spine', -4356479, 'lara.s@zoneperfectnutrition.co');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (62, 'Rose Polito', -8788427, 'rose.polito@mls.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (63, 'Rickie Wheel', -9388592, 'r.wheel@spd.se');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (64, 'Brooke Rapaport', -8410488, 'brooke.rapaport@ccfholding.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (65, 'Elvis Moss', -967211, 'elvism@topicsentertainment.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (66, 'Alice Smurfit', -9112000, 'alice@randomwalk.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (67, 'Hugh Rodgers', -4170537, 'hugh.rodgers@cyberthink.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (68, 'Ellen Ponty', -4093012, 'ellenp@dvdt.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (69, 'Coley Broza', -6606510, 'coley.broza@cyberthink.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (70, 'Trace Pride', -9284288, 'trace.pride@dearbornbancorp.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (71, 'Dave Atkins', -4681821, 'dave.atkins@sony.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (72, 'Jackie Laurie', -9262, 'jackie.laurie@nhr.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (73, 'Marlon Arthur', -4989101, 'marlon.arthur@bestever.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (74, 'Kasey Kadison', -6967328, 'kasey.kadison@solipsys.dk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (75, 'Robert Tripplehorn', -7301065, 'robert.tripplehorn@cws.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (76, 'Amanda Perry', -8953302, 'a.perry@hcoa.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (77, 'Lorraine Alston', -853841, 'lorraine.alston@csi.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (78, 'Joanna Kilmer', -2489447, 'joanna.kilmer@hcoa.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (79, 'Bernie Supernaw', -8975095, 'bernie.supernaw@stm.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (80, 'Alfie Rush', -2735629, 'alfie.rush@aristotle.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (81, 'Rickie Bullock', -4947520, 'rickie.bullock@employerservice');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (82, 'Merillee Shaye', -4462838, 'mshaye@kiamotors.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (83, 'Neneh Paul', -7637514, 'neneh.paul@envisiontelephony.c');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (84, 'Nikki Quatro', -4452679, 'nikki@inzone.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (85, 'Meryl Red', -9638425, 'meryl.red@keith.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (86, 'Nikka Raitt', -3350978, 'nikka@telepoint.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (87, 'Malcolm Stiers', -1872262, 'm.stiers@lindin.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (88, 'Thelma Joli', -3622392, 'thelmaj@bioanalytical.au');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (89, 'Gates Whitford', -1326605, 'gates.whitford@ptg.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (90, 'Kenny Hagar', -9067469, 'kenny.hagar@verizon.nl');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (91, 'Dean Pepper', -2367351, 'dean.pepper@ceb.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (92, 'Clay Cruz', -5303260, 'ccruz@faef.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (93, 'Mekhi Lawrence', -3337801, 'mekhi.lawrence@progressivedesi');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (94, 'Hikaru Mould', -9511118, 'hikarum@unilever.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (95, 'Juice Venora', -8270081, 'juice.venora@otbd.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (96, 'Hal Elliott', -5067906, 'hal.elliott@avr.be');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (97, 'William Allen', -4446096, 'william.allen@infopros.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (98, 'Marina Pullman', -6578914, 'm.pullman@sweetproductions.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (99, 'Leon Cazale', -8313892, 'lcazale@atlanticcredit.fi');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (100, 'Morris Vince', -4606577, 'morris.vince@microsoft.de');
commit;
prompt 100 records committed...
insert into ORGANIZER (organizerid, organizername, phone, email)
values (101, 'Uma Barrymore', -4888515, 'uma@bayer.cz');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (102, 'Brian Cusack', -5052107, 'brian.cusack@mms.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (103, 'Saul Palminteri', -8813988, 'saul.palminteri@afs.ve');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (104, 'Mika Holden', -3307022, 'mika.holden@ibfh.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (105, 'Rebecca Makowicz', -419812, 'rebecca@innovativelighting.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (106, 'Joy Williamson', -6545570, 'joy.williamson@gillette.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (107, 'Remy Bonneville', -6992133, 'remyb@cooktek.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (108, 'Ewan Glenn', -8793545, 'ewan@cis.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (109, 'Lindsay Pesci', -6193233, 'lindsay.pesci@pioneermortgage.');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (110, 'Andrae Rhodes', -861883, 'andrae.rhodes@telesynthesis.fr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (111, 'Burt Conley', -5012616, 'b.conley@dsp.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (112, 'Ethan Parsons', -451597, 'ethan@powerlight.be');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (113, 'Olga Wainwright', -1868056, 'olga.wainwright@als.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (114, 'Halle McNarland', -6094588, 'halle@gentrasystems.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (115, 'Dave Humphrey', -2520452, 'dave.humphrey@nuinfosystems.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (116, 'Richard Loeb', -3795661, 'richard.loeb@baesch.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (117, 'Ricardo McKellen', -7962071, 'ricardom@investorstitle.za');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (118, 'Nastassja Llewelyn', -3759900, 'nastassja.llewelyn@bat.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (119, 'Gabriel Lane', -8318219, 'gabriel.lane@anworthmortgage.a');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (120, 'Rip Frampton', -9162175, 'rip.frampton@volkswagen.se');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (121, 'Lloyd Randal', -9559007, 'lloyd.randal@pioneermortgage.i');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (122, 'Vickie Steagall', -4910457, 'vsteagall@capitalautomotive.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (123, 'Sophie Landau', -4345680, 'sophie.landau@gha.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (124, 'Ernest Crowe', -1964348, 'ernest.crowe@pis.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (125, 'Reese Mathis', -3536913, 'rmathis@venoco.fi');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (126, 'Liev Norton', -7205573, 'liev.norton@tps.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (127, 'Percy Askew', -5507750, 'percy.a@avs.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (128, 'Shelby Todd', -7531211, 'shelby.todd@medamicus.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (129, 'Miko Caine', -5117032, 'miko.caine@connected.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (130, 'Chuck Murphy', -270423, 'chuck.murphy@accesssystems.nl');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (131, 'Mac Keaton', -6680482, 'mac.keaton@shot.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (132, 'Lesley Dutton', -6607342, 'lesley.dutton@medsource.fr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (133, 'Rich Landau', -7817037, 'rich.landau@exinomtechnologies');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (134, 'Desmond Cattrall', -1678561, 'desmond.cattrall@alohanysystem');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (135, 'Garland Ali', -9394805, 'garland.ali@linersdirect.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (136, 'Heath Drive', -4239582, 'heath.drive@refinery.fr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (137, 'George Weisz', -8264215, 'g.weisz@unilever.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (138, 'Mia McDiarmid', -1404953, 'miam@ibm.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (139, 'Graham Gyllenhaal', -3787008, 'graham.gyllenhaal@colgatepalmo');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (140, 'Will Condition', -7198211, 'wcondition@flavorx.au');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (141, 'Chely Paxton', -9032942, 'chely.paxton@integratelecom.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (142, 'Jesus McIntosh', -1157334, 'jesus.mcintosh@wlt.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (143, 'Curt Hutton', -8180485, 'curt.hutton@cws.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (144, 'Harris Thomson', -8547772, 'harrist@monarchcasino.my');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (145, 'Alan Fisher', -5001825, 'afisher@qssgroup.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (146, 'Catherine Hatchet', -7189232, 'catherine.hatchet@wyeth.es');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (147, 'Olga Faithfull', -4430467, 'olga.faithfull@codykramerimpor');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (148, 'Samantha Ermey', -3509138, 'samantha.ermey@hitechpharmacal');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (149, 'Jared Orton', -7449723, 'jared.o@north.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (150, 'Chazz Hiatt', -9571530, 'chazz.hiatt@royalgold.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (151, 'Garth Hynde', -3547588, 'garth.hynde@sears.ar');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (152, 'Bret Sossamon', -2157860, 'bret.sossamon@bioreliance.be');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (153, 'Moe Allen', -8941947, 'm.allen@servicelink.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (154, 'Regina LaMond', -2643989, 'regina.lamond@spd.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (155, 'Ed Parker', -5350330, 'e.parker@typhoon.il');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (156, 'Orlando Bracco', -5396233, 'orlando.bracco@activeservices.');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (157, 'Bobby Hall', -1658027, 'bobby.hall@credopetroleum.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (158, 'Brendan Rauhofer', -3952028, 'brendan.rauhofer@americanmegac');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (159, 'Alessandro Cattrall', -617116, 'acattrall@sweetproductions.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (160, 'Joanna Shearer', -1950186, 'joanna.shearer@data.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (161, 'Miko Ojeda', -3340483, 'm.ojeda@marketfirst.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (162, 'Meryl Calle', -4094363, 'meryl.c@ataservices.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (163, 'Miko Beals', -2010225, 'miko.beals@ppr.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (164, 'Leonardo Willis', -2550549, 'leonardo.willis@spd.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (165, 'Rik Kattan', -6466416, 'rkattan@atlanticnet.nl');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (166, 'Kate Plowright', -5862087, 'kate.plowright@innovateecommer');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (167, 'Tara Chung', -6992798, 'tarac@astafunding.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (168, 'Patricia Armatrading', -1261023, 'patriciaa@gsat.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (169, 'John Davis', -5412498, 'john.davis@tilia.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (170, 'Carla Warwick', -2509934, 'carla.warwick@ecopy.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (171, 'Loretta Reeve', -3977327, 'loretta.reeve@hencie.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (172, 'Bebe Deschanel', -4803903, 'bebe.deschanel@balchem.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (173, 'Harriet Richter', -1946816, 'harriet.r@unicru.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (174, 'Lin Camp', -5063010, 'lin.camp@gagwear.at');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (175, 'Luis Tyson', -697201, 'l.tyson@circuitcitystores.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (176, 'Charlton Brosnan', -6826275, 'c.brosnan@stmaryland.ar');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (177, 'Ali Hiatt', -6668928, 'ahiatt@wav.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (178, 'Chaka Cale', -9749007, 'chaka.c@kmart.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (179, 'Chubby Bates', -9987159, 'cbates@sm.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (180, 'Ramsey McNarland', -1150242, 'ramsey@cardinalcartridge.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (181, 'Lin Pride', -5416220, 'lin.pride@hiltonhotels.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (182, 'Hugo Cornell', -5589964, 'hugo.cornell@solutionbuilders.');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (183, 'Keith Tanon', -332082, 'keith.tanon@caliber.nl');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (184, 'Beverley Atkinson', -8061489, 'beverleya@techrx.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (185, 'Debby Spacek', -5204885, 'd.spacek@procter.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (186, 'Sean Rickles', -919313, 'seanr@pra.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (187, 'Edwin Hiatt', -742124, 'edwin.hiatt@bradleypharmaceuti');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (188, 'Beth Curry', -9525634, 'b.curry@spd.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (189, 'Larnelle Baranski', -7725521, 'larnelle.baranski@ungertechnol');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (190, 'Diane Judd', -9227152, 'd.judd@benecongroup.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (191, 'Molly Aaron', -5934493, 'molly.aaron@avr.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (192, 'Marc Penders', -8183379, 'marc.penders@navigatorsystems.');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (193, 'Bebe Lange', -970233, 'bebe@bradleypharmaceuticals.py');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (194, 'Dean Coward', -2052690, 'dean.coward@horizonorganic.be');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (195, 'Demi Mahood', -9199550, 'demi.mahood@americanexpress.co');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (196, 'Ed Raye', -7451106, 'ed.raye@fmt.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (197, 'Dick Sweeney', -3924189, 'dick.sweeney@verizon.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (198, 'Christopher Alston', -8556893, 'christopher.alston@midwestmedi');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (199, 'Jeffery Russo', -469541, 'j.russo@bioreliance.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (200, 'Daryl Hunter', -914510, 'daryl.hunter@bedfordbancshares');
commit;
prompt 200 records committed...
insert into ORGANIZER (organizerid, organizername, phone, email)
values (201, 'Anne Solido', -347851, 'anne@restaurantpartners.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (202, 'Brendan Craig', -4646626, 'brendan@monitronicsinternation');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (203, 'Natalie Dench', -1732597, 'natalie@multimedialive.be');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (204, 'Marina Kinnear', -4782174, 'marina@ceom.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (205, 'Charlton Brody', -1950570, 'cbrody@amerisourcefunding.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (206, 'Owen Numan', -446625, 'onuman@gbas.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (207, 'Ray Birch', -1463847, 'rbirch@hondamotor.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (208, 'Frankie Gary', -1332620, 'frankieg@prahs.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (209, 'Vern Lizzy', -491734, 'vern@manhattanassociates.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (210, 'Jet Reiner', -7379996, 'j.reiner@hudsonriverbancorp.co');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (211, 'Jeremy Russell', -8162261, 'jeremy.russell@mitsubishimotor');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (212, 'Debby Guilfoyle', -3015048, 'debby@lms.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (213, 'Courtney Thornton', -5762170, 'cthornton@mathis.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (214, 'Chet McFerrin', -1387707, 'chet.mcferrin@denaliventures.c');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (215, 'Thin Bell', -5715669, 'thin.bell@terrafirma.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (216, 'April McCann', -3060531, 'april@streetglow.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (217, 'Bruce Murphy', -1402170, 'bruce@ntas.il');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (218, 'Wade Whitwam', -4012313, 'wade.whitwam@meritagetechnolog');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (219, 'Art Morse', -9047568, 'art.morse@streetglow.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (220, 'Janice Heald', -1217760, 'janice.heald@viacell.id');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (221, 'John Lucas', -9459303, 'john@totalentertainment.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (222, 'Renee Lennix', -7552546, 'reneel@americanpan.no');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (223, 'Johnny Ramis', -6461296, 'jramis@operationaltechnologies');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (224, 'Garth Slater', -7179117, 'garth.slater@usainstruments.co');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (225, 'Tony Dickinson', -1756499, 't.dickinson@angieslist.pk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (226, 'Judi Ferrell', -6738583, 'judif@powerlight.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (227, 'Cate Kadison', -1195768, 'ckadison@timevision.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (228, 'Rade Fender', -8871677, 'rade.fender@execuscribe.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (229, 'Bradley Rauhofer', -3445941, 'bradley.rauhofer@asa.es');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (230, 'Renee Swayze', -6575514, 'renee.s@sfgo.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (231, 'Andrew Capshaw', -7162159, 'acapshaw@stmaryland.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (232, 'Matt Clinton', -1145695, 'matt.clinton@evergreenresource');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (233, 'Meryl McDowell', -3623369, 'meryl.mcdowell@insurmark.id');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (234, 'Amanda Thurman', -7700793, 'amanda.t@tripwire.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (235, 'Sophie Grier', -6798506, 'sophie.grier@qestrel.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (236, 'Frank Zeta-Jones', -9174385, 'frank@learningvoyage.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (237, 'Colleen Humphrey', -8148840, 'c.humphrey@viacell.dk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (238, 'Keith Pacino', -8952630, 'k.pacino@mavericktechnologies.');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (239, 'Pierce Raye', -989260, 'pierce.raye@benecongroup.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (240, 'Meg Deejay', -5643287, 'meg.d@philipmorris.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (241, 'Debby Parm', -4782350, 'debby.parm@morganresearch.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (242, 'Blair Hershey', -826640, 'blair.hershey@tilsonlandscape.');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (243, 'Radney Gershon', -7911922, 'radney.gershon@stm.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (244, 'Geggy DeVita', -1138005, 'g.devita@shufflemaster.at');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (245, 'Lena Tinsley', -5235136, 'lena.tinsley@tmt.au');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (246, 'Chely Garza', -2750006, 'c.garza@saralee.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (247, 'Elizabeth Field', -4670747, 'elizabeth.field@base.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (248, 'Latin Solido', -3797884, 'latin.solido@astafunding.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (249, 'Buddy Shepherd', -9996598, 'b.shepherd@sony.nl');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (250, 'Lupe Skaggs', -8254334, 'lupe@curagroup.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (251, 'Alannah Manning', -1143373, 'alannah.m@simplycertificates.c');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (252, 'Brian Scorsese', -2337955, 'bscorsese@nhr.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (253, 'Holland Alda', -3173851, 'hollanda@volkswagen.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (254, 'Bruce Allison', -7458309, 'b.allison@oneidafinancial.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (255, 'Alec Rickman', -9246090, 'alec.rickman@pscinfogroup.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (256, 'Gladys Brosnan', -5723974, 'gladys.brosnan@volkswagen.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (257, 'Art Trevino', -8837052, 'art.t@healthscribe.at');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (258, 'Joaquin Duncan', -3674143, 'joaquin.duncan@emt.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (259, 'Cole Squier', -5542194, 'cole.squier@fetchlogistics.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (260, 'Boz Lyonne', -3284686, 'boz.lyonne@unica.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (261, 'Ming-Na May', -8719209, 'mmay@investmentscorecard.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (262, 'Antonio Malone', -2499040, 'antonio.malone@procter.fr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (263, 'Kiefer Waits', -1153517, 'k.waits@ositissoftware.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (264, 'Maxine Hoskins', -7847670, 'm.hoskins@scooterstore.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (265, 'Mia Garr', -1938544, 'mgarr@allegiantbancorp.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (266, 'Adrien Gagnon', -8337256, 'a.gagnon@signalperfection.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (267, 'Meg Everett', -8908494, 'mege@hitechpharmacal.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (268, 'Lesley Curry', -5391700, 'lesley.c@infinity.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (269, 'Dianne Wakeling', -9630510, 'dwakeling@pra.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (270, 'Udo Lang', -8591934, 'udo.lang@abs.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (271, 'Boyd Wariner', -367215, 'b.wariner@evinco.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (272, 'Leelee Smith', -6251749, 'leelees@mag.dk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (273, 'Chely Kennedy', -3750901, 'chely@componentgraphics.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (274, 'Suzanne Rowlands', -7201703, 'suzanne.r@quakercitybancorp.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (275, 'Mickey McGill', -9383411, 'mickey.mcgill@ceom.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (276, 'Timothy Buscemi', -450492, 'timothyb@tigris.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (277, 'Ashley Coughlan', -6873649, 'ashley@kmart.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (278, 'Rupert Wolf', -9707491, 'rupert@cmi.in');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (279, 'France Atkinson', -8558236, 'france.atkinson@morganresearch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (280, 'Debby Willis', -302055, 'debby@swp.dk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (281, 'Tea Davies', -298301, 'tead@viacom.hk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (282, 'Paula Isaak', -8146940, 'paulai@americanpan.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (283, 'Josh Cash', -8266737, 'josh.cash@kingland.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (284, 'Bridgette Hauer', -2408136, 'bridgetteh@gateway.za');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (285, 'Wang Donelly', -562900, 'wdonelly@bestever.dk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (286, 'Jessica Rio', -6116819, 'jrio@trc.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (287, 'Mae Roth', -7347701, 'mae.r@capstone.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (288, 'Eric McAnally', -2545536, 'eric.mcanally@computersource.j');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (289, 'Geena Harris', -643447, 'geena.harris@epamsystems.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (290, 'Teena Chilton', -9942383, 'teena.chilton@fra.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (291, 'Luke Carr', -3889804, 'luke.carr@oriservices.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (292, 'Alfred Cobbs', -1951887, 'a.cobbs@tracertechnologies.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (293, 'Albert Hackman', -5192829, 'albert.hackman@sunstream.au');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (294, 'Curtis Soul', -6568664, 'curtis@invisioncom.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (295, 'Andie Neville', -2252451, 'andien@generalelectric.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (296, 'Famke Elizabeth', -8954062, 'famke.elizabeth@onstaff.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (297, 'Sheena Bassett', -7264143, 'sheena@perfectorder.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (298, 'Sigourney King', -5023369, 'sigourney.king@simplycertifica');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (299, 'Kenny Liotta', -606508, 'kenny.liotta@horizon.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (300, 'Curtis Faithfull', -9048525, 'curtis.faithfull@insurmark.de');
commit;
prompt 300 records committed...
insert into ORGANIZER (organizerid, organizername, phone, email)
values (301, 'Rachel Grant', -6596957, 'rachel@lemproducts.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (302, 'Steven Quaid', -4979824, 'squaid@solipsys.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (303, 'Eugene Nelson', -8186746, 'eugene.n@exinomtechnologies.za');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (304, 'Shirley Ward', -9493600, 'shirleyw@stm.is');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (305, 'Lin Biggs', -6162738, 'lin.biggs@hcoa.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (306, 'Pete Jovovich', -9394261, 'pete.jovovich@apexsystems.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (307, 'Campbell Winger', -7099982, 'campbellw@stm.at');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (308, 'Isaiah O''Hara', -8463396, 'isaiaho@inzone.au');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (309, 'Val Harper', -3985221, 'val.harper@maverick.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (310, 'Lin Rebhorn', -5792201, 'lin@tarragonrealty.it');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (311, 'Juice Mitchell', -7726528, 'juice.mitchell@greenmountain.b');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (312, 'Orlando Goldblum', -9821284, 'ogoldblum@accucode.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (313, 'Gina Kotto', -1785265, 'gkotto@mse.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (314, 'Greg Mason', -1705672, 'greg.mason@ghrsystems.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (315, 'Coley Banderas', -8380526, 'coley.b@operationaltechnologie');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (316, 'Pamela Ryan', -7078005, 'pryan@bat.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (317, 'Armand Mantegna', -6035243, 'armand.mantegna@boldtechsystem');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (318, 'Dermot Belles', -4389147, 'dermot.b@valleyoaksystems.nl');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (319, 'Maura Rundgren', -4296893, 'maura.rundgren@sms.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (320, 'Emily Snider', -7931610, 'emily.s@worldcom.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (321, 'Ron Brando', -6920447, 'ron.brando@lindin.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (322, 'Patricia Gugino', -345347, 'patricia.gugino@spinnakerexplo');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (323, 'Sydney Visnjic', -3099259, 'sydney.visnjic@pharmacia.za');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (324, 'Ritchie Addy', -99066, 'ritchie.addy@air.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (325, 'Elvis Folds', -5667164, 'elvis.folds@stonetechprofessio');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (326, 'Jack Holiday', -6828083, 'jack.holiday@gra.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (327, 'Jeffrey Kapanka', -233668, 'jeffrey.k@ams.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (328, 'Loreena Jordan', -6353338, 'loreena@bioanalytical.gr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (329, 'Chet McDormand', -1457838, 'chet.mcdormand@veritekinternat');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (330, 'Johnette Nelligan', -3177732, 'johnette.nelligan@prosperityba');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (331, 'Marie Sawa', -2499966, 'msawa@vivendiuniversal.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (332, 'Howard Callow', -4341973, 'howard@nexxtworks.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (333, 'Danni Hobson', -4015281, 'd.hobson@esoftsolutions.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (334, 'Alfred Milsap', -9773025, 'alfred.m@gdi.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (335, 'Elvis Shepard', -8104095, 'elvis.shepard@zaiqtechnologies');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (336, 'Jimmie Matheson', -3925807, 'jimmie.matheson@powerlight.lt');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (337, 'Wang Reynolds', -7235680, 'wang.r@monarchcasino.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (338, 'Raymond Unger', -3443833, 'raymond.unger@vitacostcom.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (339, 'Harold Gugino', -2089782, 'harold.gugino@teoco.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (340, 'Emm Gyllenhaal', -760747, 'emm.gyllenhaal@speakeasy.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (341, 'Junior Fisher', -4964510, 'junior@onstaff.li');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (342, 'Gena Moriarty', -5574584, 'gena.m@fra.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (343, 'Wes Reubens', -2052675, 'wes.reubens@fetchlogistics.be');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (344, 'Rosanna LuPone', -4695562, 'rosanna@harrison.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (345, 'Harris Carter', -5380581, 'harris.carter@pib.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (346, 'Joey Keen', -1749823, 'joeyk@americanmegacom.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (347, 'Angela Butler', -5550106, 'angela.butler@capitalautomotiv');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (348, 'Davis Crouse', -611617, 'davis.crouse@woronocobancorp.c');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (349, 'Joe Evanswood', -7287389, 'joe@perfectorder.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (350, 'Max Wopat', -9696296, 'max.wopat@cardinalcartridge.fr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (351, 'Tia Dafoe', -8866806, 't.dafoe@usainstruments.is');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (352, 'Gin Roundtree', -5792391, 'gin.roundtree@3tsystems.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (353, 'Busta Chapman', -8728056, 'busta.chapman@volkswagen.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (354, 'Colin Shand', -7418852, 'colin.shand@lynksystems.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (355, 'Allan Gray', -1804996, 'allan.gray@solutionbuilders.co');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (356, 'Neneh Sweet', -7321632, 'nenehs@refinery.is');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (357, 'Natacha Jolie', -4761914, 'natacha@exinomtechnologies.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (358, 'Heath Hart', -2788812, 'heath.h@outsourcegroup.br');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (359, 'Eddie McDowell', -1376455, 'eddie.m@unica.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (360, 'Colin Kinnear', -4695713, 'ckinnear@jewettcameron.au');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (361, 'Chloe Zellweger', -9969075, 'chloe@bigyanksports.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (362, 'Carrie-Anne Biggs', -2092439, 'carrieanne@safeway.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (363, 'Judd Bentley', -3342045, 'judd.bentley@msdw.pe');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (364, 'Chi Voight', -2988513, 'cvoight@hitechpharmacal.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (365, 'Rachid Rippy', -7834414, 'rachid.rippy@horizon.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (366, 'Leo Allan', -7848577, 'leo.allan@walmartstores.il');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (367, 'Janice Yulin', -27581, 'janice.yulin@linersdirect.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (368, 'Terence Warden', -8648131, 'terence@cascadebancorp.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (369, 'Pam Llewelyn', -7136791, 'pam.l@connected.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (370, 'Jesse Pollack', -4585257, 'j.pollack@alogent.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (371, 'Jeanne Cherry', -7845956, 'jeanne.cherry@conagra.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (372, 'Miko Johansen', -3255178, 'miko.johansen@verizon.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (373, 'Meg Leoni', -7953453, 'meg.leoni@webgroup.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (374, 'Billy Reeves', -2184241, 'billy.reeves@denaliventures.co');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (375, 'Roscoe David', -5985669, 'roscoe.david@alternativetechno');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (376, 'Lili Williams', -8670800, 'lili.w@eagleone.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (377, 'Etta Rush', -2172873, 'etta.rush@usdairyproducers.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (378, 'Heather Levy', -2435170, 'heather.levy@accuship.tr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (379, 'Freddy McDowall', -1961401, 'freddy.mcdowall@networkdisplay');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (380, 'Mandy Hudson', -5134287, 'mandy@mms.fr');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (381, 'Garry Cleese', -3271970, 'g.cleese@ssci.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (382, 'Gilberto Weston', -1831946, 'g.weston@intraspheretechnologi');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (383, 'Kathleen Pitney', -2196407, 'kathleen@johnson.ar');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (384, 'Lin Barrymore', -5843223, 'lin.barrymore@aristotle.ca');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (385, 'Orlando Hanks', -6661589, 'ohanks@officedepot.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (386, 'Ernest Bruce', -9037310, 'ernest.bruce@mai.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (387, 'Gerald Doucette', -8911474, 'gerald@ogi.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (388, 'Tia Durning', -721290, 't.durning@ungertechnologies.co');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (389, 'Dionne Curfman', -416739, 'dionne.curfman@summitenergy.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (390, 'Woody Bell', -2787148, 'woody.bell@prahs.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (391, 'Hikaru McDormand', -7912198, 'hikarum@progressivemedical.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (392, 'Mykelti White', -1013847, 'mykelti.w@campbellsoup.lk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (393, 'Ceili Day-Lewis', -1623608, 'ceili.daylewis@quicksilverreso');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (394, 'Elle Bullock', -2114090, 'elle@max.ar');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (395, 'Faye McGovern', -906443, 'faye.m@freedommedical.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (396, 'Brian Twilley', -7086722, 'brian.twilley@slt.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (397, 'Randy Doucette', -7824363, 'randy.doucette@commworks.uk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (398, 'Emmylou Bergen', -4722660, 'emmylou.bergen@onstaff.be');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (399, 'Oliver Lee', -4592601, 'oliver.lee@cooktek.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (400, 'Leo Tempest', -5286529, 'leo.tempest@integramedamerica.');
commit;
prompt 400 records committed...
insert into ORGANIZER (organizerid, organizername, phone, email)
values (401, 'Tzi Solido', -3960199, 'tsolido@campbellsoup.cn');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (402, 'Geoffrey Affleck', -5596843, 'geoffrey.affleck@comglobalsyst');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (403, 'Harvey Biel', -6701152, 'harvey.biel@spectrum.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (404, 'Connie Collie', -3043328, 'connie.collie@aoe.jp');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (405, 'Selma Coe', -438147, 'selma@larkinenterprises.de');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (406, 'Bret Carlisle', -6559082, 'bret.carlisle@telepoint.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (407, 'Jet Blige', -2149845, 'jetb@vfs.dk');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (408, 'Devon Loveless', -1968123, 'devon.loveless@mss.ch');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (409, 'Gene Moriarty', -6188376, 'gmoriarty@lms.com');
insert into ORGANIZER (organizerid, organizername, phone, email)
values (410, 'Sally Lane', -3883586, 'sallyl@multimedialive.jp');
commit;
prompt 410 records loaded
prompt Loading EVENT...
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (1, 'Sports Event', to_date('01-06-2024', 'dd-mm-yyyy'), 'A local sports event.', 1, 1, 1);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (2, 'Community Gathering', to_date('05-06-2024', 'dd-mm-yyyy'), 'A gathering for the community.', 2, 2, 2);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (3, 'Cultural Night', to_date('10-06-2024', 'dd-mm-yyyy'), 'An evening of cultural performances.', 3, 3, 3);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (4, 'Independence Day', to_date('15-06-2024', 'dd-mm-yyyy'), 'Celebration of Independence Day.', 4, 4, 4);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (5, 'Theatre Play', to_date('20-06-2024', 'dd-mm-yyyy'), 'A theatre performance.', 5, 5, 5);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (6, 'Memorial Service', to_date('25-06-2024', 'dd-mm-yyyy'), 'A service to remember fallen heroes.', 6, 6, 6);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (7, 'Educational Workshop', to_date('01-07-2024', 'dd-mm-yyyy'), 'A workshop on educational topics.', 7, 7, 7);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (8, 'Music Concert', to_date('05-07-2024', 'dd-mm-yyyy'), 'A live music concert.', 8, 8, 8);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (9, 'Summer Festival', to_date('10-07-2024', 'dd-mm-yyyy'), 'A summer festival with various activities.', 9, 9, 9);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (10, 'Film Screening', to_date('15-07-2024', 'dd-mm-yyyy'), 'A screening of a popular film.', 10, 10, 10);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (11, 'Inspiration Software marathon', to_date('13-04-2024 16:45:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 32, 160, 278);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (12, 'Execuscribe marathon', to_date('29-10-2025 22:16:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 403, 252, 342);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (13, 'Comnet International marathon', to_date('08-04-2026 14:22:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 161, 345, 143);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (14, 'Networking Technologies and Su', to_date('27-07-2024 20:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 138, 106, 387);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (15, 'Progressive Designs marathon', to_date('03-02-2025 03:34:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 254, 215, 140);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (16, 'Fetch Logistics marathon', to_date('01-02-2025 17:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 307, 232, 25);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (17, 'MindIQ marathon', to_date('14-02-2026 05:15:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 196, 393, 192);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (18, 'Nike marathon', to_date('08-12-2025 02:34:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 325, 297, 395);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (19, 'American Pan & Engineering mar', to_date('05-06-2026 14:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 307, 324, 84);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (20, 'Capella Education marathon', to_date('06-05-2026 01:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 204, 174, 261);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (21, 'Questar Capital marathon', to_date('30-05-2026 13:39:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 403, 142, 95);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (23, 'IVCi marathon', to_date('30-11-2024 07:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 372, 43, 151);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (24, 'Component Graphics marathon', to_date('30-05-2026 02:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 311, 397, 276);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (25, 'Venoco marathon', to_date('03-12-2026 01:13:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 157, 351, 185);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (26, 'Signal Perfection marathon', to_date('20-09-2025 02:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 174, 323, 152);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (27, 'CHIPS Solutions marathon', to_date('23-01-2024 06:31:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 296, 38, 298);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (28, 'IPS Advisory marathon', to_date('02-01-2025 11:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 225, 109, 138);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (29, 'Bluff City Steel marathon', to_date('26-12-2025 13:32:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 132, 23, 355);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (30, 'Uniserve Facilities Services m', to_date('23-02-2024 13:55:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 178, 163, 382);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (31, 'St. Mary Land & Exploration ma', to_date('25-07-2026 13:48:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 297, 163, 323);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (32, 'netNumina marathon', to_date('29-09-2024 16:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 392, 131, 12);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (33, 'Primus Software marathon', to_date('16-06-2024 14:43:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 329, 234, 406);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (34, 'Navigator Systems marathon', to_date('23-04-2026 17:19:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 229, 351, 274);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (35, 'Corporate Executive Board mara', to_date('19-01-2025 16:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 344, 242, 355);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (36, 'North American Theatrix marath', to_date('08-04-2026 11:04:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 325, 170, 233);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (37, 'Bradley Pharmaceuticals marath', to_date('23-06-2026 08:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 367, 41, 347);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (38, 'LogistiCare marathon', to_date('11-04-2024 04:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 237, 382, 173);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (39, 'Topics Entertainment marathon', to_date('09-07-2026 19:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 64, 282, 71);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (40, 'TEOCO marathon', to_date('14-02-2026 22:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 273, 127, 301);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (41, 'U.S. dairy producers, processo', to_date('29-12-2024 13:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 388, 293, 231);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (42, 'McKee Wallwork Henderson marat', to_date('17-06-2026 19:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 386, 290, 94);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (43, 'Fiber Network Solutions marath', to_date('04-01-2024 22:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 194, 403, 131);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (44, 'York Enterprise Solutions mara', to_date('22-10-2025 08:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 325, 201, 279);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (45, 'McKee Wallwork Henderson marat', to_date('01-09-2026 11:29:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 255, 103, 89);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (46, 'Analytical Management Services', to_date('20-10-2024 00:24:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 79, 131, 228);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (47, 'Laboratory Management Systems ', to_date('09-05-2024 10:29:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 296, 77, 165);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (48, 'Miracle Software Systems marat', to_date('10-02-2025 18:15:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 247, 254, 108);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (49, 'Network Display marathon', to_date('24-09-2024 09:24:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 13, 14, 136);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (50, 'Carteret Mortgage marathon', to_date('10-12-2025 19:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 45, 101, 214);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (51, 'St. Mary Land & Exploration ma', to_date('21-01-2026 23:31:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 348, 390, 225);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (52, 'Atlantic Credit & Finance mara', to_date('31-08-2024 21:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 253, 221, 108);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (53, 'Keith Companies marathon', to_date('11-11-2026 01:42:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 276, 12, 410);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (54, 'Infinity Software Development ', to_date('16-06-2026 23:30:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 261, 119, 115);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (55, 'DataTrend Information Systems ', to_date('21-09-2024 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 345, 288, 223);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (56, 'Flow Management Technologies m', to_date('19-04-2024 10:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 187, 212, 387);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (57, 'WestNet Learning Technologies ', to_date('16-03-2024 10:30:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 107, 222, 225);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (58, 'Green Mountain Coffee marathon', to_date('03-06-2025 20:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 27, 179, 55);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (59, 'Franklin American Mortgage mar', to_date('16-05-2025 12:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 112, 334, 67);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (60, 'InfoPros marathon', to_date('16-08-2025 06:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 325, 295, 214);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (61, 'Cardinal Cartridge marathon', to_date('09-01-2025 09:19:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 77, 236, 388);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (62, 'Green Mountain Coffee marathon', to_date('17-09-2024 14:52:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 242, 98, 41);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (63, 'GDA Technologies marathon', to_date('09-11-2026 05:44:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 55, 344, 32);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (64, 'IBM Corp. marathon', to_date('05-01-2024 21:31:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 285, 16, 99);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (65, 'Urstadt Biddle Properties mara', to_date('01-09-2025 07:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 241, 314, 379);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (66, 'Conquest Systems marathon', to_date('10-01-2025 16:03:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 20, 177, 333);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (67, 'Zaiq Technologies marathon', to_date('17-01-2025 07:46:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 76, 212, 252);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (68, 'Bestever marathon', to_date('02-10-2026 22:32:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 238, 231, 224);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (69, 'Banfe Products marathon', to_date('11-11-2025 19:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 134, 202, 17);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (70, 'NLX marathon', to_date('20-05-2026 04:16:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 293, 392, 91);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (71, 'Data Company marathon', to_date('03-06-2025 23:44:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 353, 111, 296);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (72, 'Morgan Research marathon', to_date('21-03-2024 01:26:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 314, 310, 157);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (73, 'Partnership in Building marath', to_date('27-05-2025 21:25:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 327, 213, 38);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (74, 'ComGlobal Systems marathon', to_date('07-08-2024 11:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 346, 239, 56);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (75, '3t Systems marathon', to_date('21-06-2026 01:39:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 220, 362, 298);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (76, 'General Mills marathon', to_date('29-02-2024 09:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 199, 300, 112);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (77, 'Portage Environmental marathon', to_date('17-11-2026 08:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 32, 111, 93);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (78, 'General Electric Co. marathon', to_date('12-01-2026 13:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 123, 246, 391);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (79, 'Neogen marathon', to_date('31-10-2025 00:20:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 262, 170, 406);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (80, 'DataTrend Information Systems ', to_date('03-08-2026 21:06:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 213, 93, 88);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (81, 'USA Environmental Management m', to_date('15-12-2024 03:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 112, 248, 398);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (82, 'Merit Medical Systems marathon', to_date('18-08-2025 15:42:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 54, 269, 50);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (83, 'PrivateBancorp marathon', to_date('18-02-2024 18:12:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 35, 118, 230);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (84, 'Alternative Technology maratho', to_date('14-11-2026 14:13:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 69, 185, 125);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (85, 'Albertsonâ€™s marathon', to_date('23-04-2026 00:23:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 173, 285, 134);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (86, 'Texas Residential Mortgage mar', to_date('20-12-2025 02:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 237, 206, 190);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (87, 'Terra Firma marathon', to_date('08-01-2026 18:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 344, 211, 37);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (88, 'Web Group marathon', to_date('18-10-2024 09:29:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 399, 284, 235);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (89, 'Hospital Solutions marathon', to_date('25-04-2025 00:47:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 102, 161, 244);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (90, 'Enterprise Computing Solutions', to_date('23-11-2025 22:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 136, 19, 205);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (91, 'Alden Systems marathon', to_date('21-10-2026 20:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 282, 171, 389);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (92, 'Sunstream marathon', to_date('04-01-2024 07:31:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 244, 146, 240);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (93, 'Colgate-Palmolive Co. marathon', to_date('09-01-2026 05:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 116, 32, 316);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (94, 'Stone Brewing marathon', to_date('23-12-2024 04:15:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 14, 120, 278);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (95, 'Integrity Staffing Solutions m', to_date('26-08-2024 12:07:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 164, 362, 167);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (96, 'Dankoff Solar Products maratho', to_date('02-12-2024 05:15:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 205, 300, 267);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (97, 'ScriptSave marathon', to_date('16-01-2025 11:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 306, 38, 198);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (98, 'Denali Ventures marathon', to_date('07-10-2024 20:13:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 272, 403, 55);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (99, 'Ivory Systems marathon', to_date('12-04-2024 16:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 363, 259, 266);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (100, 'TLS Service Bureau marathon', to_date('07-01-2024 04:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 247, 25, 341);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (101, 'Lloyd Group marathon', to_date('19-05-2026 06:22:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 325, 39, 239);
commit;
prompt 100 records committed...
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (102, 'American Land Lease marathon', to_date('20-09-2026 11:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 115, 367, 318);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (103, 'InfoPros marathon', to_date('18-09-2025 19:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 176, 236, 324);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (104, 'Merit Medical Systems marathon', to_date('19-02-2024 07:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 41, 69, 24);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (105, 'Walt Disney Co. marathon', to_date('30-04-2025 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 407, 360, 197);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (106, 'Cold Stone Creamery marathon', to_date('15-03-2024 16:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 300, 38, 270);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (107, 'FlavorX marathon', to_date('21-05-2025 17:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 127, 176, 358);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (108, 'Innovate E-Commerce marathon', to_date('15-03-2025 20:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 257, 57, 332);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (109, 'Unica marathon', to_date('28-12-2024 03:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 164, 292, 116);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (110, 'Kitba Consulting Services mara', to_date('09-11-2025 08:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 13, 308, 309);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (111, 'MicroTek marathon', to_date('25-08-2024 08:29:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 43, 102, 60);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (112, 'Knightsbridge Solutions marath', to_date('06-07-2025 02:11:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 79, 263, 290);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (113, 'Linksys marathon', to_date('21-12-2026 09:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 160, 390, 199);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (114, 'Columbia Bancorp marathon', to_date('13-06-2025 08:26:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 404, 211, 289);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (115, 'HealthCare Financial Group mar', to_date('10-08-2026 03:26:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 99, 107, 254);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (116, 'GCI marathon', to_date('26-05-2025 08:37:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 356, 325, 159);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (117, 'ProfitLine marathon', to_date('04-06-2025 20:03:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 97, 317, 391);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (118, 'SupplyCore.com marathon', to_date('16-10-2025 18:11:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 246, 363, 173);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (119, 'McDonaldâ€™s Corp. marathon', to_date('19-10-2026 12:37:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 175, 192, 243);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (120, 'Innovative Lighting marathon', to_date('22-01-2026 19:19:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 268, 354, 278);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (121, 'U.S Physical Therapy marathon', to_date('03-05-2025 13:37:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 11, 72, 104);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (122, 'Astute marathon', to_date('04-06-2024 01:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 35, 265, 58);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (123, 'Cima Consulting Group marathon', to_date('08-01-2025 04:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 126, 296, 146);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (124, 'Portfolio Recovery Associates ', to_date('21-10-2025 02:48:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 306, 24, 171);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (125, 'Technology Resource Center mar', to_date('18-11-2025 10:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 125, 148, 175);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (126, 'Viacell marathon', to_date('05-03-2025 01:04:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 201, 113, 268);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (127, 'Denali Ventures marathon', to_date('02-06-2026 06:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 92, 119, 179);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (128, 'Investment Scorecard marathon', to_date('01-12-2025 06:43:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 67, 99, 255);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (129, 'TimeVision marathon', to_date('11-03-2024 01:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 344, 267, 113);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (130, 'Synhrgy HR Technologies marath', to_date('02-10-2026 19:23:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 353, 214, 316);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (131, 'GulfMark Offshore marathon', to_date('17-09-2024 20:03:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 62, 25, 154);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (132, 'Bestever marathon', to_date('18-01-2026 22:04:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 244, 165, 199);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (133, 'NLX marathon', to_date('04-10-2026 10:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 46, 24, 113);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (134, 'Lindin Consulting marathon', to_date('15-01-2024 16:07:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 218, 32, 23);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (135, 'Valley Oak Systems marathon', to_date('03-01-2024 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 17, 26, 160);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (136, 'Portfolio Recovery Associates ', to_date('25-09-2025 22:23:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 313, 50, 78);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (137, 'ProfitLine marathon', to_date('11-07-2026 23:48:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 152, 104, 299);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (138, 'Harrison & Shriftman marathon', to_date('27-07-2025 15:12:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 198, 188, 186);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (139, 'Venoco marathon', to_date('25-08-2024 11:21:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 64, 331, 296);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (140, 'Staff One marathon', to_date('08-06-2025 10:01:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 311, 86, 159);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (141, 'Computer World Services marath', to_date('12-03-2024 03:37:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 334, 399, 73);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (142, 'MedAmicus marathon', to_date('27-08-2025 14:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 19, 31, 298);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (143, 'State Farm Mutual Automobile I', to_date('22-02-2025 07:37:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 88, 265, 233);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (144, 'Aloha NY Systems marathon', to_date('12-04-2024 02:46:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 398, 285, 70);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (145, 'Corporate Executive Board mara', to_date('30-04-2026 11:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 333, 266, 217);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (146, 'Green Mountain Coffee marathon', to_date('23-11-2025 18:42:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 378, 290, 101);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (147, 'Micro Solutions Enterprises ma', to_date('13-12-2026 11:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 125, 42, 261);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (148, 'Horizon Organic marathon', to_date('05-05-2024 20:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 396, 207, 188);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (149, 'Floorgraphics marathon', to_date('30-06-2025 23:27:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 54, 292, 60);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (150, 'Air Methods marathon', to_date('28-01-2025 15:01:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 266, 42, 275);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (151, 'Jolly Enterprises marathon', to_date('10-10-2026 04:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 399, 393, 398);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (152, 'Schering-Plough Corp. marathon', to_date('03-03-2025 18:32:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 391, 170, 206);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (153, 'Unica marathon', to_date('19-03-2025 12:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 12, 187, 122);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (154, 'InfoVision Consultants maratho', to_date('25-10-2025 13:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 289, 94, 55);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (155, 'TMA Resources marathon', to_date('23-08-2026 00:12:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 19, 336, 226);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (156, 'Morgan Research marathon', to_date('08-11-2025 03:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 14, 197, 295);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (157, 'Amerisource Funding marathon', to_date('05-08-2026 21:12:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 189, 354, 360);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (158, 'Biosite marathon', to_date('02-05-2026 08:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 40, 220, 67);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (159, 'Mathis, Earnest & Vandeventer ', to_date('17-11-2026 21:39:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 267, 294, 227);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (160, 'Gray Hawk Systems marathon', to_date('15-11-2025 09:43:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 66, 339, 35);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (161, 'Client Network Services marath', to_date('26-01-2026 04:02:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 284, 391, 231);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (162, 'Franklin American Mortgage mar', to_date('08-04-2026 05:04:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 61, 153, 378);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (163, 'Pearl Law Group marathon', to_date('17-10-2024 21:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 88, 232, 283);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (164, 'BASE Consulting Group marathon', to_date('23-07-2025 06:14:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 305, 170, 340);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (165, 'Security Check marathon', to_date('05-05-2026 01:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 405, 257, 98);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (166, 'Pyramid Digital Solutions mara', to_date('15-05-2025 03:16:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 247, 366, 257);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (167, 'National Home Health Care mara', to_date('16-08-2024 03:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 316, 234, 312);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (168, 'Simply Certificates marathon', to_date('25-10-2024 08:26:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 70, 103, 122);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (169, 'Linac Systems marathon', to_date('17-08-2024 05:55:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 191, 344, 390);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (170, 'Montpelier Plastics marathon', to_date('22-07-2024 05:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 221, 343, 232);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (171, 'Cura Group marathon', to_date('18-02-2026 08:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 35, 196, 104);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (172, 'EPIQ Systems marathon', to_date('09-07-2025 19:42:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 156, 107, 346);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (173, 'Bioanalytical Systems marathon', to_date('15-10-2026 07:44:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 28, 15, 235);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (174, 'Office Depot marathon', to_date('10-08-2024 20:19:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 146, 183, 354);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (175, 'Megha Systems marathon', to_date('26-11-2025 03:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 200, 231, 335);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (176, 'Bio-Reference Labs marathon', to_date('18-09-2025 09:04:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 407, 287, 214);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (177, 'Sensor Technologies marathon', to_date('30-11-2025 20:27:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 112, 232, 188);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (178, 'Mattel marathon', to_date('10-07-2024 20:53:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 90, 226, 236);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (179, 'Market First marathon', to_date('08-02-2024 05:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 156, 285, 17);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (180, 'Sprint Corp. marathon', to_date('22-06-2024 05:19:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 53, 303, 323);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (181, 'AOL Time Warner marathon', to_date('02-06-2025 21:42:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 57, 29, 177);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (182, 'Mathis, Earnest & Vandeventer ', to_date('06-04-2025 06:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 211, 352, 187);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (183, 'Iris Software marathon', to_date('27-05-2024 01:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 336, 355, 164);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (184, 'EagleOne marathon', to_date('13-02-2024 14:01:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 250, 287, 138);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (185, 'ELMCO marathon', to_date('28-09-2025 04:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 187, 271, 274);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (186, 'Analytical Management Services', to_date('16-06-2024 08:47:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 97, 241, 16);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (187, 'Global Wireless Data marathon', to_date('22-04-2024 13:44:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 194, 401, 324);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (188, 'Smartronix marathon', to_date('25-02-2026 20:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 52, 36, 28);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (189, 'CLT Meetings International mar', to_date('12-04-2026 00:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 198, 248, 19);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (190, 'I.T.S. marathon', to_date('17-04-2024 12:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 102, 37, 212);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (191, 'DC Group marathon', to_date('26-12-2026 00:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 70, 351, 374);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (192, 'American Express Co. marathon', to_date('30-01-2024 14:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 277, 149, 211);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (193, 'SmartDraw.com marathon', to_date('07-01-2026 03:48:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 162, 334, 115);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (194, 'Advanced Vision Research marat', to_date('16-08-2024 18:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 26, 118, 282);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (195, 'Formatech marathon', to_date('16-06-2025 03:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 212, 284, 23);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (196, 'Legacy Financial Group maratho', to_date('20-11-2026 19:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 282, 64, 241);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (197, 'Sammy''s Woodfired Pizza marath', to_date('28-01-2025 20:02:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 120, 71, 407);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (198, 'American Vanguard marathon', to_date('23-01-2025 02:14:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 180, 406, 352);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (199, 'Berkshire Hathaway marathon', to_date('22-08-2024 16:46:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 271, 194, 196);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (200, 'Greyhawk North America maratho', to_date('28-01-2025 05:02:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 334, 86, 392);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (201, 'Telepoint Communications marat', to_date('06-02-2024 05:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 262, 309, 172);
commit;
prompt 200 records committed...
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (202, 'Tilson Landscape marathon', to_date('18-07-2024 20:24:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 382, 117, 221);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (203, 'Entelligence marathon', to_date('17-09-2026 05:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 298, 21, 179);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (204, 'Bradley Pharmaceuticals marath', to_date('20-04-2024 16:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 367, 147, 376);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (205, 'Portosan marathon', to_date('16-03-2025 01:25:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 138, 157, 30);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (206, 'ScriptSave marathon', to_date('09-09-2025 22:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 130, 190, 154);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (207, 'Imports By Four Hands marathon', to_date('28-09-2025 12:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 342, 354, 83);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (208, 'Prosoft Technology Group marat', to_date('31-01-2024 00:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 22, 203, 143);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (209, 'Megha Systems marathon', to_date('27-12-2026 06:53:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 285, 378, 103);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (210, 'SM Consulting marathon', to_date('01-12-2024 15:16:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 85, 296, 226);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (211, 'Networking Technologies and Su', to_date('22-06-2025 23:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 292, 281, 298);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (212, 'Comnet International marathon', to_date('26-03-2026 00:21:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 173, 392, 405);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (213, 'Provident Bancorp marathon', to_date('13-09-2024 02:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 127, 174, 333);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (214, 'Dearborn Bancorp marathon', to_date('04-02-2024 01:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 322, 58, 282);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (215, 'Hershey Foods Corp. marathon', to_date('09-11-2025 07:52:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 59, 202, 110);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (216, 'Client Network Services marath', to_date('24-10-2026 17:32:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 207, 64, 226);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (217, 'Spenser Communications maratho', to_date('01-08-2024 14:25:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 125, 21, 188);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (218, 'InfoPros marathon', to_date('02-04-2025 21:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 85, 196, 343);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (219, 'Clover Technologies Group mara', to_date('09-08-2026 16:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 337, 281, 140);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (220, 'Circuit City Stores marathon', to_date('17-11-2026 14:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 287, 23, 321);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (221, 'Custom Solutions International', to_date('23-02-2025 17:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 248, 63, 259);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (222, 'Evergreen Resources marathon', to_date('01-09-2024 08:02:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 287, 217, 121);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (223, 'Micro Solutions Enterprises ma', to_date('01-12-2024 19:05:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 241, 135, 192);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (224, 'GCI marathon', to_date('27-03-2026 15:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 258, 67, 17);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (225, 'Greene County Bancorp marathon', to_date('18-09-2026 16:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 116, 150, 384);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (226, 'Cardtronics marathon', to_date('09-03-2026 07:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 108, 163, 49);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (227, 'FFLC Bancorp marathon', to_date('13-02-2024 00:31:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 260, 268, 152);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (228, 'Biosite marathon', to_date('29-01-2025 15:15:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 214, 381, 310);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (229, 'Access Systems marathon', to_date('09-07-2026 11:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 313, 31, 210);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (230, 'RS Information Systems maratho', to_date('01-10-2025 14:04:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 325, 44, 323);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (231, 'Cardtronics marathon', to_date('11-11-2025 01:45:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 234, 219, 135);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (232, 'VoiceLog marathon', to_date('22-02-2026 08:25:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 208, 261, 356);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (233, 'Procurement Centre marathon', to_date('11-04-2026 15:21:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 405, 362, 203);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (234, 'Club One marathon', to_date('26-06-2024 13:11:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 125, 278, 144);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (235, 'Nestle marathon', to_date('27-03-2024 09:45:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 170, 136, 127);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (236, 'Travizon marathon', to_date('12-10-2024 16:11:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 300, 140, 64);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (237, 'Digital Visual Display Technol', to_date('14-12-2025 06:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 165, 72, 42);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (238, 'Eastman Kodak Co. marathon', to_date('06-09-2026 01:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 236, 134, 259);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (239, 'Flow Management Technologies m', to_date('16-09-2026 10:38:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 229, 167, 302);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (240, 'httprint marathon', to_date('13-01-2026 19:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 241, 172, 306);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (241, 'Allegiant Bancorp marathon', to_date('02-03-2026 19:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 146, 122, 209);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (242, 'Kimberly-Clark Corp. marathon', to_date('21-09-2024 04:02:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 140, 131, 383);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (243, 'In Zone marathon', to_date('25-12-2025 13:05:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 287, 156, 84);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (244, 'Vitacost.com marathon', to_date('27-09-2026 06:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 183, 358, 407);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (245, 'Spectrum Communications Cablin', to_date('12-06-2026 01:06:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 288, 209, 277);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (246, 'All Star Consulting marathon', to_date('06-08-2024 06:14:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 374, 379, 14);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (247, 'Albertsonâ€™s marathon', to_date('29-01-2024 00:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 401, 241, 111);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (248, 'Scott Pipitone Design marathon', to_date('12-02-2024 21:48:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 306, 68, 252);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (249, 'Laboratory Management Systems ', to_date('02-04-2025 12:20:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 123, 263, 351);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (250, 'Appriss marathon', to_date('03-09-2025 04:37:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 312, 206, 19);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (251, 'Elite Medical marathon', to_date('22-02-2025 20:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 394, 246, 183);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (252, 'Meridian Gold marathon', to_date('18-05-2026 17:23:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 166, 144, 53);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (253, 'Turner Professional Services m', to_date('13-07-2025 11:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 241, 260, 141);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (254, 'Mindworks marathon', to_date('19-11-2024 21:53:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 227, 72, 94);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (255, 'Tracer Technologies marathon', to_date('02-02-2025 15:27:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 75, 270, 357);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (256, 'Heartland Payment Systems mara', to_date('26-06-2026 22:23:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 247, 37, 119);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (257, 'ProClarity marathon', to_date('18-03-2026 17:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 396, 22, 315);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (258, 'Gagwear marathon', to_date('15-05-2026 15:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 200, 98, 83);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (259, 'Jewett-Cameron Trading maratho', to_date('31-08-2026 03:04:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 117, 150, 54);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (260, 'J.C. Malone Associates maratho', to_date('27-10-2026 05:26:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 317, 156, 283);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (261, 'Loss Mitigation Services marat', to_date('05-11-2025 18:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 113, 331, 33);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (262, 'Integrity Staffing Solutions m', to_date('16-05-2026 11:45:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 123, 31, 63);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (263, 'BioReliance marathon', to_date('29-10-2025 12:29:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 114, 405, 157);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (264, 'Print-Tech marathon', to_date('29-07-2026 19:40:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 75, 99, 311);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (265, 'Electrical Solutions marathon', to_date('15-05-2026 20:45:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 170, 396, 297);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (266, 'QSS Group marathon', to_date('09-11-2024 21:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 323, 350, 176);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (267, 'Market-Based Solutions maratho', to_date('10-07-2026 23:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 24, 153, 356);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (268, 'Envision Telephony marathon', to_date('22-02-2025 06:46:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 94, 324, 355);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (269, 'National Bankcard Systems mara', to_date('03-09-2025 10:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 214, 37, 13);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (270, 'Network Hardware Resale marath', to_date('24-02-2026 17:19:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 63, 353, 107);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (271, 'Noodles & Co. marathon', to_date('04-02-2025 08:17:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 135, 388, 121);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (272, 'Neogen marathon', to_date('07-09-2026 09:16:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 344, 141, 183);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (273, 'Kmart Corp. marathon', to_date('05-06-2024 18:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 294, 215, 209);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (274, 'Kimberly-Clark Corp. marathon', to_date('15-08-2024 15:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 62, 321, 202);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (275, 'USA Instruments marathon', to_date('07-01-2026 18:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 353, 319, 161);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (276, 'Open Software Solutions marath', to_date('13-10-2025 11:13:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 91, 191, 32);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (277, 'American Express Co. marathon', to_date('22-05-2025 06:22:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 174, 44, 313);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (278, 'Benecon Group marathon', to_date('09-02-2026 20:15:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 73, 194, 319);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (279, 'Anheuser-Busch Cos. marathon', to_date('13-09-2025 04:02:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 148, 156, 149);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (280, 'North Highland marathon', to_date('07-10-2026 00:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 270, 72, 31);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (281, 'Access Systems marathon', to_date('16-02-2025 12:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 381, 156, 107);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (282, 'Midwest Media Group marathon', to_date('23-09-2024 21:46:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 271, 74, 209);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (283, 'Axis Consulting marathon', to_date('30-06-2024 04:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 165, 250, 165);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (284, 'Appriss marathon', to_date('03-03-2024 11:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 317, 290, 36);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (285, 'Innovate E-Commerce marathon', to_date('13-11-2025 05:25:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 286, 333, 286);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (286, 'GlaxoSmithKline marathon', to_date('01-03-2026 16:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 85, 367, 111);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (287, 'Franklin American Mortgage mar', to_date('26-02-2026 10:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 223, 163, 251);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (288, 'Exinom Technologies marathon', to_date('20-05-2025 14:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 365, 206, 213);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (289, 'WAV marathon', to_date('27-11-2026 10:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 153, 269, 238);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (290, 'Uniserve Facilities Services m', to_date('20-08-2026 19:39:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 225, 292, 369);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (291, 'Kia Motors Corp. marathon', to_date('01-07-2026 03:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 122, 177, 118);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (292, 'Keller Williams Realty Ahwatuk', to_date('30-06-2026 13:05:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 190, 135, 31);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (293, 'Market-Based Solutions maratho', to_date('31-10-2024 11:02:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 257, 398, 160);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (294, 'J.C. Penney Corp. marathon', to_date('28-02-2025 12:05:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 144, 370, 150);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (295, 'Berkshire Hathaway marathon', to_date('22-10-2026 04:43:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 176, 229, 396);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (296, 'Morgan Stanley Dean Witter & C', to_date('03-11-2026 20:47:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 400, 276, 188);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (297, 'Franklin American Mortgage mar', to_date('08-06-2025 02:38:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 211, 234, 326);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (298, 'Tarragon Realty marathon', to_date('14-09-2024 01:26:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 84, 215, 272);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (299, 'Meridian Gold marathon', to_date('31-05-2024 16:02:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 88, 165, 84);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (300, 'Banfe Products marathon', to_date('30-09-2024 00:55:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 267, 45, 128);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (301, 'Tripwire marathon', to_date('08-02-2026 12:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 196, 163, 37);
commit;
prompt 300 records committed...
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (302, 'Strategic Products and Service', to_date('19-06-2026 19:04:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 139, 242, 21);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (303, 'Pioneer Mortgage marathon', to_date('30-05-2026 01:03:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 89, 113, 176);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (304, 'Refinery marathon', to_date('17-07-2024 21:52:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 290, 263, 288);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (305, 'Staff Force marathon', to_date('06-02-2024 17:29:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 237, 339, 65);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (306, 'Megha Systems marathon', to_date('08-05-2025 06:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 90, 11, 358);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (307, 'Axis Consulting marathon', to_date('17-06-2025 17:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 358, 256, 324);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (308, 'Monarch Casino marathon', to_date('26-10-2025 13:01:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 87, 390, 316);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (309, 'Flow Management Technologies m', to_date('08-11-2025 06:42:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 223, 21, 102);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (310, 'Sony Corp. marathon', to_date('09-04-2024 16:48:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 254, 36, 14);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (311, 'Wendyâ€™s International marathon', to_date('19-02-2024 13:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 44, 216, 311);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (312, 'Escalade marathon', to_date('18-06-2026 03:29:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 306, 255, 209);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (313, 'Pulaski Financial marathon', to_date('13-06-2024 21:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 209, 390, 53);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (314, 'PrintingForLess.com marathon', to_date('22-12-2025 05:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 81, 358, 258);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (315, 'InfoVision Consultants maratho', to_date('19-03-2024 11:01:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 107, 327, 207);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (316, 'Sunstream marathon', to_date('06-12-2026 03:11:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 150, 261, 213);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (317, 'Miracle Software Systems marat', to_date('14-09-2026 09:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 297, 407, 66);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (318, 'SYS-CON Media marathon', to_date('12-07-2024 09:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 156, 124, 235);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (319, 'Quicksilver Resources marathon', to_date('04-01-2024 11:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 292, 402, 365);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (320, 'Big Yank Sports marathon', to_date('24-11-2026 11:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 213, 132, 228);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (321, 'Mathis, Earnest & Vandeventer ', to_date('27-07-2026 05:23:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 247, 137, 343);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (322, 'Cima Labs marathon', to_date('29-06-2025 19:24:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 137, 66, 72);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (323, 'Span-America Medical Systems m', to_date('24-06-2025 23:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 271, 80, 141);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (324, 'Southern Financial Bancorp mar', to_date('25-02-2024 00:06:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 14, 366, 355);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (325, 'Envision Telephony marathon', to_date('10-11-2025 08:08:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 284, 90, 229);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (326, 'Evergreen Resources marathon', to_date('22-08-2025 03:45:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 91, 324, 240);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (327, 'Megha Systems marathon', to_date('24-10-2026 03:32:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 243, 149, 292);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (328, 'Procter & Gamble Co. marathon', to_date('03-05-2026 22:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 131, 274, 347);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (329, 'Cowlitz Bancorp marathon', to_date('20-05-2024 07:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 290, 32, 216);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (330, 'Security Check marathon', to_date('06-08-2024 18:38:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 345, 110, 168);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (331, 'TechBooks marathon', to_date('10-09-2024 18:11:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 48, 348, 133);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (332, 'Bashen Consulting marathon', to_date('11-02-2024 09:41:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 120, 154, 191);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (333, 'Dell Computer Corp. marathon', to_date('08-02-2025 22:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 230, 388, 169);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (334, 'Bayer marathon', to_date('18-10-2024 10:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 324, 250, 403);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (335, 'Freedom Medical marathon', to_date('01-06-2024 17:55:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 277, 21, 209);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (336, 'SSCI marathon', to_date('17-07-2024 08:14:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 322, 95, 165);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (337, 'SupplyCore.com marathon', to_date('15-11-2025 11:44:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 387, 308, 391);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (338, 'Heartlab marathon', to_date('09-09-2024 10:06:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 96, 102, 308);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (339, 'Mars Inc. marathon', to_date('30-08-2026 14:16:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 225, 139, 170);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (340, 'Gorman Richardson Architects m', to_date('23-12-2025 21:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 141, 356, 24);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (341, 'Access US marathon', to_date('14-10-2026 15:07:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 78, 113, 261);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (342, 'Comnet International marathon', to_date('29-12-2025 12:30:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 87, 93, 197);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (343, 'Appriss marathon', to_date('27-06-2026 23:03:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 388, 69, 392);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (344, 'Mattel marathon', to_date('21-10-2025 14:37:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 300, 402, 261);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (345, 'Calence marathon', to_date('22-04-2026 18:52:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 19, 386, 46);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (346, 'Calence marathon', to_date('08-07-2025 22:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 98, 375, 93);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (347, 'Staff Force marathon', to_date('05-11-2024 00:48:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 132, 192, 33);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (348, 'Capella Education marathon', to_date('16-07-2024 20:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 256, 161, 59);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (349, 'NoBrainerBlinds.com marathon', to_date('13-09-2024 23:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 398, 39, 14);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (350, 'Pan-Pacific Retail Properties ', to_date('12-10-2025 02:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 65, 222, 208);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (351, 'Oakleaf Waste Management marat', to_date('02-10-2026 10:03:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 47, 357, 293);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (352, 'Pan-Pacific Retail Properties ', to_date('09-06-2026 03:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 72, 375, 322);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (353, 'Prosoft Technology Group marat', to_date('28-04-2024 20:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 45, 205, 272);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (354, 'SupplyCore.com marathon', to_date('29-06-2024 17:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 323, 101, 340);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (355, 'Monitronics International mara', to_date('18-12-2024 14:33:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 215, 268, 125);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (356, 'J.C. Malone Associates maratho', to_date('27-06-2025 11:11:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 149, 207, 185);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (357, 'Oneida Financial marathon', to_date('06-12-2025 04:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 144, 96, 34);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (358, 'SSCI marathon', to_date('21-08-2024 19:22:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 397, 409, 273);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (359, 'PharmaFab marathon', to_date('02-08-2025 07:27:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 92, 405, 194);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (360, 'Target Corp. marathon', to_date('18-05-2026 16:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 294, 381, 381);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (361, 'Sterling Financial Group of Co', to_date('26-12-2026 06:05:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 74, 277, 352);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (362, 'Estee Lauder Cos. marathon', to_date('01-09-2026 08:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 275, 229, 182);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (363, 'Procurement Centre marathon', to_date('25-02-2026 05:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 244, 157, 132);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (364, 'Fiberlink Communications marat', to_date('07-12-2024 19:03:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 135, 210, 84);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (365, 'Atlantic Credit & Finance mara', to_date('19-08-2025 18:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 241, 86, 17);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (366, 'Cura Group marathon', to_date('05-02-2025 03:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 209, 285, 137);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (367, 'Cascade Bancorp marathon', to_date('04-02-2025 01:12:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 241, 371, 270);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (368, 'National Home Health Care mara', to_date('15-01-2026 07:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 162, 204, 387);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (369, 'Analytical Management Services', to_date('24-10-2025 04:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 63, 66, 61);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (370, 'Larkin Enterprises marathon', to_date('18-06-2026 11:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 379, 52, 289);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (371, 'AXSA Document Solutions marath', to_date('24-06-2025 15:50:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 336, 18, 307);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (372, 'Greenwich Technology Partners ', to_date('25-01-2025 07:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 405, 400, 56);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (373, 'Honda Motor Co. marathon', to_date('28-09-2024 20:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 193, 325, 364);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (374, 'Hencie marathon', to_date('06-07-2025 19:53:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 270, 213, 247);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (375, 'Strategic Management Initiativ', to_date('19-08-2026 23:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 237, 346, 291);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (376, 'Texas Residential Mortgage mar', to_date('27-04-2026 21:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 222, 304, 95);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (377, 'United Asset Coverage marathon', to_date('01-09-2024 00:32:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 132, 297, 396);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (378, 'Pharmacia Corp. marathon', to_date('06-01-2024 10:10:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 103, 195, 222);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (379, 'Gorman Richardson Architects m', to_date('02-12-2024 23:15:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 410, 41, 177);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (380, 'ConAgra marathon', to_date('06-01-2026 18:53:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 407, 401, 179);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (381, 'Cendant Corp. marathon', to_date('15-08-2024 12:34:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 114, 216, 216);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (382, 'ProfitLine marathon', to_date('16-07-2024 07:32:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 370, 197, 256);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (383, 'Pfizer marathon', to_date('06-10-2024 06:13:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 208, 176, 338);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (384, 'SSCI marathon', to_date('25-10-2025 19:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 107, 104, 86);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (385, 'Advanced Vending Systems marat', to_date('23-08-2026 08:09:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 217, 384, 327);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (386, 'Doral Dental USA marathon', to_date('26-03-2025 19:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 400, 31, 302);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (387, 'Consultants'' Choice marathon', to_date('14-10-2025 03:27:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 63, 233, 280);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (388, 'Swiss Watch International mara', to_date('27-11-2026 05:58:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 338, 321, 187);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (389, 'BioReliance marathon', to_date('25-08-2025 21:01:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 189, 337, 328);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (390, 'Painted Word marathon', to_date('11-04-2024 15:22:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 227, 401, 67);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (391, 'FFLC Bancorp marathon', to_date('07-08-2024 12:18:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 257, 217, 154);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (392, 'Granite Systems marathon', to_date('17-03-2024 00:06:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 399, 91, 313);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (393, 'TRX marathon', to_date('22-11-2024 08:45:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 337, 186, 372);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (394, 'Outta the Box Dispensers marat', to_date('06-08-2025 17:38:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 73, 320, 12);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (395, 'Estee Lauder Cos. marathon', to_date('26-07-2025 16:54:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 73, 328, 117);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (396, 'MidAmerica Auto Glass marathon', to_date('03-02-2024 13:51:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 373, 76, 77);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (397, 'Iris Software marathon', to_date('03-10-2026 09:57:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 358, 59, 347);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (398, 'Ositis Software marathon', to_date('16-02-2026 18:56:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 318, 109, 188);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (399, 'Global Science and Technology ', to_date('01-09-2025 22:36:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 80, 205, 313);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (400, 'Outsource Group marathon', to_date('29-10-2025 05:01:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 215, 159, 162);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (401, 'Alternative Business Systems m', to_date('30-04-2024 03:31:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 289, 88, 203);
commit;
prompt 400 records committed...
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (402, 'Aventis marathon', to_date('20-07-2025 21:47:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 74, 274, 121);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (403, 'Lifeline Systems marathon', to_date('26-03-2026 09:29:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 326, 226, 345);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (404, 'Great Lakes Technologies Group', to_date('23-07-2024 04:07:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 13, 137, 238);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (405, 'IPS Advisory marathon', to_date('15-11-2025 13:59:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 222, 294, 138);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (406, 'Deutsche Telekom marathon', to_date('05-05-2025 23:19:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 233, 297, 224);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (407, 'WCI marathon', to_date('28-02-2026 04:49:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 203, 257, 14);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (408, 'IntegraMed America marathon', to_date('18-06-2025 18:15:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 120, 161, 50);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (409, 'PSC Info Group marathon', to_date('02-05-2025 05:28:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 376, 205, 272);
insert into EVENT (eventid, eventname, eventdate, eventdescribe, organizerid, eventtypeid, locationid)
values (410, 'Street Glow marathon', to_date('24-08-2026 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'Running a marathon for health', 114, 247, 135);
commit;
prompt 409 records loaded
prompt Loading ORDERS...
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (1, 2, 4, to_date('01-05-2024', 'dd-mm-yyyy'), 1, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (2, 4, 0, to_date('02-05-2024', 'dd-mm-yyyy'), 2, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (3, 3, 2, to_date('03-05-2024', 'dd-mm-yyyy'), 3, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (4, 5, 0, to_date('04-05-2024', 'dd-mm-yyyy'), 4, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (5, 2, 2, to_date('05-05-2024', 'dd-mm-yyyy'), 5, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (6, 4, 0, to_date('06-05-2024', 'dd-mm-yyyy'), 6, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (7, 1, 1, to_date('07-05-2024', 'dd-mm-yyyy'), 7, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (8, 3, 40, to_date('08-05-2024', 'dd-mm-yyyy'), 8, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (9, 6, 2, to_date('09-05-2024', 'dd-mm-yyyy'), 9, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (10, 2, 15, to_date('10-05-2024', 'dd-mm-yyyy'), 10, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (11, 3, 36, to_date('10-05-2024 23:02:00', 'dd-mm-yyyy hh24:mi:ss'), 177, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (12, 3, 41, to_date('17-02-2024 10:59:00', 'dd-mm-yyyy hh24:mi:ss'), 290, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (13, 1, 22, to_date('15-01-2025 13:06:00', 'dd-mm-yyyy hh24:mi:ss'), 17, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (14, 5, 19, to_date('13-05-2026 10:47:00', 'dd-mm-yyyy hh24:mi:ss'), 99, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (15, 1, 5, to_date('01-11-2026 09:22:00', 'dd-mm-yyyy hh24:mi:ss'), 139, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (16, 4, 41, to_date('29-12-2024 16:21:00', 'dd-mm-yyyy hh24:mi:ss'), 310, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (17, 1, 50, to_date('15-11-2024 04:19:00', 'dd-mm-yyyy hh24:mi:ss'), 127, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (18, 3, 31, to_date('18-08-2025 00:35:00', 'dd-mm-yyyy hh24:mi:ss'), 104, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (19, 1, 28, to_date('02-03-2026 10:16:00', 'dd-mm-yyyy hh24:mi:ss'), 213, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (20, 3, 0, to_date('04-08-2025 14:08:00', 'dd-mm-yyyy hh24:mi:ss'), 359, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (21, 2, 15, to_date('26-01-2025 00:24:00', 'dd-mm-yyyy hh24:mi:ss'), 201, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (22, 1, 21, to_date('07-06-2025 19:23:00', 'dd-mm-yyyy hh24:mi:ss'), 127, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (23, 3, 45, to_date('09-08-2024 16:25:00', 'dd-mm-yyyy hh24:mi:ss'), 109, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (24, 4, 48, to_date('23-08-2025 19:56:00', 'dd-mm-yyyy hh24:mi:ss'), 48, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (25, 3, 13, to_date('17-01-2025 19:54:00', 'dd-mm-yyyy hh24:mi:ss'), 142, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (26, 4, 24, to_date('23-07-2026 05:43:00', 'dd-mm-yyyy hh24:mi:ss'), 281, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (27, 2, 22, to_date('28-08-2024 14:57:00', 'dd-mm-yyyy hh24:mi:ss'), 392, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (28, 2, 39, to_date('11-06-2025 01:27:00', 'dd-mm-yyyy hh24:mi:ss'), 164, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (29, 3, 12, to_date('11-08-2026 10:36:00', 'dd-mm-yyyy hh24:mi:ss'), 251, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (30, 3, 11, to_date('05-10-2025 02:35:00', 'dd-mm-yyyy hh24:mi:ss'), 395, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (31, 3, 37, to_date('18-02-2025 14:30:00', 'dd-mm-yyyy hh24:mi:ss'), 364, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (32, 4, 24, to_date('26-08-2025 14:58:00', 'dd-mm-yyyy hh24:mi:ss'), 145, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (33, 1, 23, to_date('13-10-2024 10:07:00', 'dd-mm-yyyy hh24:mi:ss'), 297, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (34, 1, 49, to_date('29-07-2024 05:46:00', 'dd-mm-yyyy hh24:mi:ss'), 287, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (35, 3, 31, to_date('15-12-2026 13:38:00', 'dd-mm-yyyy hh24:mi:ss'), 333, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (36, 1, 3, to_date('20-02-2024 05:59:00', 'dd-mm-yyyy hh24:mi:ss'), 358, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (37, 1, 48, to_date('02-08-2025 18:11:00', 'dd-mm-yyyy hh24:mi:ss'), 195, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (38, 3, 10, to_date('16-02-2026 04:27:00', 'dd-mm-yyyy hh24:mi:ss'), 40, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (39, 3, 23, to_date('22-12-2026 17:30:00', 'dd-mm-yyyy hh24:mi:ss'), 291, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (40, 4, 36, to_date('30-09-2024 17:29:00', 'dd-mm-yyyy hh24:mi:ss'), 371, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (41, 3, 49, to_date('22-11-2024 13:21:00', 'dd-mm-yyyy hh24:mi:ss'), 283, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (42, 2, 32, to_date('20-12-2025 21:42:00', 'dd-mm-yyyy hh24:mi:ss'), 276, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (43, 1, 19, to_date('10-10-2026 06:10:00', 'dd-mm-yyyy hh24:mi:ss'), 187, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (44, 4, 2, to_date('03-03-2025 14:41:00', 'dd-mm-yyyy hh24:mi:ss'), 29, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (45, 5, 0, to_date('15-03-2026 17:24:00', 'dd-mm-yyyy hh24:mi:ss'), 391, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (46, 1, 26, to_date('11-11-2026 10:54:00', 'dd-mm-yyyy hh24:mi:ss'), 32, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (47, 1, 19, to_date('26-06-2026 23:14:00', 'dd-mm-yyyy hh24:mi:ss'), 204, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (48, 4, 9, to_date('14-09-2025 21:21:00', 'dd-mm-yyyy hh24:mi:ss'), 128, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (49, 4, 5, to_date('27-06-2025 15:52:00', 'dd-mm-yyyy hh24:mi:ss'), 124, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (50, 4, 36, to_date('09-08-2026 16:23:00', 'dd-mm-yyyy hh24:mi:ss'), 232, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (51, 1, 26, to_date('11-08-2024 00:17:00', 'dd-mm-yyyy hh24:mi:ss'), 235, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (52, 3, 3, to_date('05-02-2026 16:23:00', 'dd-mm-yyyy hh24:mi:ss'), 292, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (53, 3, 49, to_date('21-12-2025 22:30:00', 'dd-mm-yyyy hh24:mi:ss'), 329, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (54, 2, 0, to_date('03-11-2026 21:45:00', 'dd-mm-yyyy hh24:mi:ss'), 369, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (55, 4, 9, to_date('21-10-2026 13:21:00', 'dd-mm-yyyy hh24:mi:ss'), 152, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (56, 5, 29, to_date('08-05-2025 22:20:00', 'dd-mm-yyyy hh24:mi:ss'), 48, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (57, 5, 9, to_date('22-12-2025 23:47:00', 'dd-mm-yyyy hh24:mi:ss'), 176, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (58, 2, 9, to_date('16-11-2026 14:32:00', 'dd-mm-yyyy hh24:mi:ss'), 371, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (59, 5, 10, to_date('30-09-2024 11:33:00', 'dd-mm-yyyy hh24:mi:ss'), 90, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (60, 2, 35, to_date('11-07-2024 01:50:00', 'dd-mm-yyyy hh24:mi:ss'), 297, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (61, 3, 18, to_date('14-09-2024 19:30:00', 'dd-mm-yyyy hh24:mi:ss'), 229, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (62, 2, 12, to_date('27-06-2026 02:39:00', 'dd-mm-yyyy hh24:mi:ss'), 83, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (63, 3, 4, to_date('18-11-2025 01:23:00', 'dd-mm-yyyy hh24:mi:ss'), 314, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (64, 4, 40, to_date('21-07-2026 18:06:00', 'dd-mm-yyyy hh24:mi:ss'), 394, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (65, 4, 21, to_date('24-01-2025 15:07:00', 'dd-mm-yyyy hh24:mi:ss'), 325, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (66, 5, 33, to_date('24-09-2025 06:49:00', 'dd-mm-yyyy hh24:mi:ss'), 338, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (67, 1, 6, to_date('13-04-2026 15:26:00', 'dd-mm-yyyy hh24:mi:ss'), 298, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (69, 5, 32, to_date('30-06-2024 14:21:00', 'dd-mm-yyyy hh24:mi:ss'), 244, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (70, 2, 24, to_date('07-10-2024 05:09:00', 'dd-mm-yyyy hh24:mi:ss'), 35, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (71, 4, 36, to_date('13-06-2025 08:44:00', 'dd-mm-yyyy hh24:mi:ss'), 199, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (72, 3, 50, to_date('27-03-2026 08:08:00', 'dd-mm-yyyy hh24:mi:ss'), 263, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (73, 2, 0, to_date('01-10-2026 11:42:00', 'dd-mm-yyyy hh24:mi:ss'), 389, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (74, 5, 27, to_date('26-08-2026 21:39:00', 'dd-mm-yyyy hh24:mi:ss'), 12, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (75, 4, 20, to_date('08-02-2026 19:19:00', 'dd-mm-yyyy hh24:mi:ss'), 332, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (76, 2, 4, to_date('20-06-2025 16:01:00', 'dd-mm-yyyy hh24:mi:ss'), 278, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (77, 3, 12, to_date('29-09-2026 08:52:00', 'dd-mm-yyyy hh24:mi:ss'), 57, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (78, 4, 33, to_date('10-03-2025 22:41:00', 'dd-mm-yyyy hh24:mi:ss'), 121, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (79, 2, 9, to_date('17-01-2025 16:42:00', 'dd-mm-yyyy hh24:mi:ss'), 247, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (80, 2, 24, to_date('11-05-2024 17:52:00', 'dd-mm-yyyy hh24:mi:ss'), 379, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (81, 1, 4, to_date('04-05-2025 07:20:00', 'dd-mm-yyyy hh24:mi:ss'), 117, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (82, 2, 43, to_date('09-09-2025 05:27:00', 'dd-mm-yyyy hh24:mi:ss'), 302, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (83, 3, 30, to_date('27-11-2024 14:24:00', 'dd-mm-yyyy hh24:mi:ss'), 201, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (84, 4, 49, to_date('02-06-2026 11:33:00', 'dd-mm-yyyy hh24:mi:ss'), 307, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (85, 1, 25, to_date('27-02-2026 00:45:00', 'dd-mm-yyyy hh24:mi:ss'), 82, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (86, 1, 23, to_date('27-10-2026 14:32:00', 'dd-mm-yyyy hh24:mi:ss'), 63, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (87, 2, 0, to_date('03-01-2025 14:25:00', 'dd-mm-yyyy hh24:mi:ss'), 233, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (88, 2, 39, to_date('05-12-2026 02:31:00', 'dd-mm-yyyy hh24:mi:ss'), 302, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (89, 5, 39, to_date('01-06-2026 15:36:00', 'dd-mm-yyyy hh24:mi:ss'), 389, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (90, 2, 19, to_date('02-06-2026 14:24:00', 'dd-mm-yyyy hh24:mi:ss'), 348, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (91, 1, 37, to_date('28-02-2024 23:46:00', 'dd-mm-yyyy hh24:mi:ss'), 42, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (92, 3, 38, to_date('21-09-2024 20:22:00', 'dd-mm-yyyy hh24:mi:ss'), 182, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (93, 5, 39, to_date('21-09-2025 07:34:00', 'dd-mm-yyyy hh24:mi:ss'), 266, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (94, 1, 12, to_date('13-04-2024 01:54:00', 'dd-mm-yyyy hh24:mi:ss'), 219, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (95, 2, 11, to_date('17-06-2026 22:54:00', 'dd-mm-yyyy hh24:mi:ss'), 59, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (96, 5, 31, to_date('05-01-2025 15:16:00', 'dd-mm-yyyy hh24:mi:ss'), 19, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (97, 1, 6, to_date('18-11-2025 22:03:00', 'dd-mm-yyyy hh24:mi:ss'), 16, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (98, 5, 30, to_date('24-12-2024 22:40:00', 'dd-mm-yyyy hh24:mi:ss'), 323, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (99, 5, 15, to_date('21-02-2026 06:22:00', 'dd-mm-yyyy hh24:mi:ss'), 124, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (100, 4, 1, to_date('17-03-2024 18:33:00', 'dd-mm-yyyy hh24:mi:ss'), 408, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (101, 3, 17, to_date('24-09-2024 18:44:00', 'dd-mm-yyyy hh24:mi:ss'), 86, null);
commit;
prompt 100 records committed...
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (102, 5, 3, to_date('15-09-2025 19:47:00', 'dd-mm-yyyy hh24:mi:ss'), 375, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (103, 2, 13, to_date('04-05-2025 23:07:00', 'dd-mm-yyyy hh24:mi:ss'), 161, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (104, 5, 47, to_date('17-09-2024 15:07:00', 'dd-mm-yyyy hh24:mi:ss'), 350, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (105, 1, 5, to_date('04-12-2024 08:01:00', 'dd-mm-yyyy hh24:mi:ss'), 142, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (106, 3, 32, to_date('18-01-2025 18:11:00', 'dd-mm-yyyy hh24:mi:ss'), 228, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (107, 3, 10, to_date('09-12-2024 01:07:00', 'dd-mm-yyyy hh24:mi:ss'), 49, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (108, 3, 29, to_date('01-10-2025 08:02:00', 'dd-mm-yyyy hh24:mi:ss'), 321, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (109, 2, 20, to_date('08-10-2024 19:34:00', 'dd-mm-yyyy hh24:mi:ss'), 149, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (110, 5, 37, to_date('24-10-2025 21:09:00', 'dd-mm-yyyy hh24:mi:ss'), 150, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (111, 4, 2, to_date('14-05-2024 03:49:00', 'dd-mm-yyyy hh24:mi:ss'), 303, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (112, 5, 43, to_date('05-03-2026 10:57:00', 'dd-mm-yyyy hh24:mi:ss'), 148, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (113, 1, 36, to_date('11-01-2024 22:46:00', 'dd-mm-yyyy hh24:mi:ss'), 240, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (114, 4, 21, to_date('07-11-2025 02:50:00', 'dd-mm-yyyy hh24:mi:ss'), 298, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (115, 1, 43, to_date('01-06-2024 06:40:00', 'dd-mm-yyyy hh24:mi:ss'), 347, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (116, 5, 18, to_date('13-04-2024 16:40:00', 'dd-mm-yyyy hh24:mi:ss'), 87, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (117, 3, 8, to_date('20-09-2026 15:15:00', 'dd-mm-yyyy hh24:mi:ss'), 195, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (118, 4, 34, to_date('05-11-2026 20:47:00', 'dd-mm-yyyy hh24:mi:ss'), 194, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (119, 2, 46, to_date('22-01-2024 09:38:00', 'dd-mm-yyyy hh24:mi:ss'), 385, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (120, 3, 36, to_date('09-08-2026 13:33:00', 'dd-mm-yyyy hh24:mi:ss'), 294, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (121, 3, 42, to_date('20-12-2025 15:25:00', 'dd-mm-yyyy hh24:mi:ss'), 116, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (122, 4, 25, to_date('28-02-2025 16:22:00', 'dd-mm-yyyy hh24:mi:ss'), 198, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (123, 5, 2, to_date('29-03-2026 05:38:00', 'dd-mm-yyyy hh24:mi:ss'), 82, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (124, 4, 31, to_date('07-10-2026 02:08:00', 'dd-mm-yyyy hh24:mi:ss'), 304, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (125, 5, 39, to_date('10-10-2024 06:53:00', 'dd-mm-yyyy hh24:mi:ss'), 296, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (126, 2, 5, to_date('09-08-2026 23:21:00', 'dd-mm-yyyy hh24:mi:ss'), 187, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (127, 1, 35, to_date('23-09-2025 21:07:00', 'dd-mm-yyyy hh24:mi:ss'), 34, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (128, 5, 3, to_date('01-04-2026 11:33:00', 'dd-mm-yyyy hh24:mi:ss'), 103, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (129, 5, 17, to_date('02-11-2026 02:59:00', 'dd-mm-yyyy hh24:mi:ss'), 305, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (130, 4, 7, to_date('19-04-2025 16:22:00', 'dd-mm-yyyy hh24:mi:ss'), 225, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (131, 5, 6, to_date('19-11-2026 12:30:00', 'dd-mm-yyyy hh24:mi:ss'), 48, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (132, 1, 34, to_date('26-03-2025 20:03:00', 'dd-mm-yyyy hh24:mi:ss'), 403, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (133, 5, 15, to_date('26-05-2024 15:22:00', 'dd-mm-yyyy hh24:mi:ss'), 54, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (134, 2, 44, to_date('08-06-2024 23:25:00', 'dd-mm-yyyy hh24:mi:ss'), 43, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (135, 3, 33, to_date('04-07-2025 02:42:00', 'dd-mm-yyyy hh24:mi:ss'), 211, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (136, 2, 34, to_date('25-05-2025 19:28:00', 'dd-mm-yyyy hh24:mi:ss'), 119, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (137, 4, 2, to_date('03-01-2025 22:21:00', 'dd-mm-yyyy hh24:mi:ss'), 76, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (138, 3, 18, to_date('18-02-2024 22:21:00', 'dd-mm-yyyy hh24:mi:ss'), 108, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (139, 1, 40, to_date('12-08-2026 01:36:00', 'dd-mm-yyyy hh24:mi:ss'), 371, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (140, 1, 9, to_date('27-09-2026 07:49:00', 'dd-mm-yyyy hh24:mi:ss'), 243, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (141, 1, 40, to_date('17-05-2024 09:32:00', 'dd-mm-yyyy hh24:mi:ss'), 201, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (142, 1, 30, to_date('22-03-2024 05:24:00', 'dd-mm-yyyy hh24:mi:ss'), 304, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (143, 5, 25, to_date('16-04-2026 22:38:00', 'dd-mm-yyyy hh24:mi:ss'), 406, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (144, 4, 22, to_date('23-05-2024 05:42:00', 'dd-mm-yyyy hh24:mi:ss'), 119, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (145, 2, 37, to_date('26-02-2024 10:15:00', 'dd-mm-yyyy hh24:mi:ss'), 228, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (146, 5, 41, to_date('27-01-2024 19:39:00', 'dd-mm-yyyy hh24:mi:ss'), 204, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (147, 3, 13, to_date('25-06-2026 03:09:00', 'dd-mm-yyyy hh24:mi:ss'), 107, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (148, 1, 46, to_date('28-05-2026 00:48:00', 'dd-mm-yyyy hh24:mi:ss'), 117, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (149, 3, 12, to_date('08-10-2025 02:03:00', 'dd-mm-yyyy hh24:mi:ss'), 203, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (150, 2, 28, to_date('25-05-2025 15:34:00', 'dd-mm-yyyy hh24:mi:ss'), 145, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (151, 1, 20, to_date('19-10-2025 13:05:00', 'dd-mm-yyyy hh24:mi:ss'), 243, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (152, 5, 27, to_date('10-08-2026 12:29:00', 'dd-mm-yyyy hh24:mi:ss'), 310, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (153, 4, 5, to_date('28-03-2024 19:18:00', 'dd-mm-yyyy hh24:mi:ss'), 291, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (154, 1, 46, to_date('28-01-2026 07:29:00', 'dd-mm-yyyy hh24:mi:ss'), 304, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (155, 5, 9, to_date('08-05-2025 07:16:00', 'dd-mm-yyyy hh24:mi:ss'), 44, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (156, 4, 45, to_date('21-05-2025 12:13:00', 'dd-mm-yyyy hh24:mi:ss'), 348, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (157, 3, 31, to_date('15-12-2025 01:30:00', 'dd-mm-yyyy hh24:mi:ss'), 254, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (158, 5, 36, to_date('14-12-2025 18:07:00', 'dd-mm-yyyy hh24:mi:ss'), 173, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (159, 1, 0, to_date('14-07-2025 10:05:00', 'dd-mm-yyyy hh24:mi:ss'), 274, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (160, 1, 16, to_date('29-06-2026 12:01:00', 'dd-mm-yyyy hh24:mi:ss'), 131, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (161, 3, 43, to_date('15-07-2024 02:00:00', 'dd-mm-yyyy hh24:mi:ss'), 126, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (162, 5, 37, to_date('28-08-2026 23:00:00', 'dd-mm-yyyy hh24:mi:ss'), 31, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (163, 4, 33, to_date('13-11-2025 11:53:00', 'dd-mm-yyyy hh24:mi:ss'), 302, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (164, 2, 14, to_date('21-11-2024 09:06:00', 'dd-mm-yyyy hh24:mi:ss'), 90, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (165, 5, 41, to_date('07-08-2024 12:20:00', 'dd-mm-yyyy hh24:mi:ss'), 84, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (166, 4, 40, to_date('03-06-2025 15:06:00', 'dd-mm-yyyy hh24:mi:ss'), 24, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (167, 5, 19, to_date('18-10-2024 09:33:00', 'dd-mm-yyyy hh24:mi:ss'), 384, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (168, 1, 18, to_date('11-07-2024 02:16:00', 'dd-mm-yyyy hh24:mi:ss'), 253, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (169, 2, 30, to_date('09-08-2026 02:45:00', 'dd-mm-yyyy hh24:mi:ss'), 326, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (170, 5, 3, to_date('14-11-2026 21:11:00', 'dd-mm-yyyy hh24:mi:ss'), 36, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (171, 3, 11, to_date('28-06-2025 22:53:00', 'dd-mm-yyyy hh24:mi:ss'), 332, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (172, 5, 27, to_date('02-03-2026 08:26:00', 'dd-mm-yyyy hh24:mi:ss'), 129, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (173, 5, 34, to_date('28-08-2026 10:49:00', 'dd-mm-yyyy hh24:mi:ss'), 148, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (174, 1, 9, to_date('16-11-2024 22:27:00', 'dd-mm-yyyy hh24:mi:ss'), 367, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (175, 5, 2, to_date('06-09-2026 15:14:00', 'dd-mm-yyyy hh24:mi:ss'), 191, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (176, 3, 20, to_date('23-03-2024 07:09:00', 'dd-mm-yyyy hh24:mi:ss'), 176, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (177, 1, 47, to_date('25-04-2025 13:48:00', 'dd-mm-yyyy hh24:mi:ss'), 215, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (178, 2, 22, to_date('26-04-2026 18:53:00', 'dd-mm-yyyy hh24:mi:ss'), 405, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (179, 4, 45, to_date('19-06-2025 05:57:00', 'dd-mm-yyyy hh24:mi:ss'), 115, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (180, 2, 12, to_date('11-07-2024 05:03:00', 'dd-mm-yyyy hh24:mi:ss'), 82, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (181, 1, 0, to_date('26-05-2024 17:12:00', 'dd-mm-yyyy hh24:mi:ss'), 38, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (182, 1, 50, to_date('09-12-2026 21:55:00', 'dd-mm-yyyy hh24:mi:ss'), 102, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (183, 1, 0, to_date('04-02-2026 14:50:00', 'dd-mm-yyyy hh24:mi:ss'), 240, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (184, 5, 20, to_date('01-03-2026 04:24:00', 'dd-mm-yyyy hh24:mi:ss'), 233, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (185, 3, 19, to_date('24-10-2026 23:15:00', 'dd-mm-yyyy hh24:mi:ss'), 249, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (186, 5, 1, to_date('21-02-2026 22:50:00', 'dd-mm-yyyy hh24:mi:ss'), 251, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (187, 5, 7, to_date('01-11-2024 06:42:00', 'dd-mm-yyyy hh24:mi:ss'), 163, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (188, 2, 12, to_date('21-04-2024 19:38:00', 'dd-mm-yyyy hh24:mi:ss'), 397, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (189, 4, 30, to_date('16-05-2024 23:30:00', 'dd-mm-yyyy hh24:mi:ss'), 74, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (190, 1, 50, to_date('16-10-2026 09:14:00', 'dd-mm-yyyy hh24:mi:ss'), 360, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (191, 5, 35, to_date('23-09-2024 03:52:00', 'dd-mm-yyyy hh24:mi:ss'), 12, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (192, 4, 26, to_date('21-12-2024 21:43:00', 'dd-mm-yyyy hh24:mi:ss'), 389, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (193, 4, 22, to_date('27-07-2024 15:09:00', 'dd-mm-yyyy hh24:mi:ss'), 13, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (194, 1, 37, to_date('16-01-2026 05:38:00', 'dd-mm-yyyy hh24:mi:ss'), 123, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (195, 1, 45, to_date('09-06-2026 06:36:00', 'dd-mm-yyyy hh24:mi:ss'), 322, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (196, 3, 26, to_date('24-11-2026 02:46:00', 'dd-mm-yyyy hh24:mi:ss'), 353, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (197, 4, 6, to_date('06-06-2026 17:40:00', 'dd-mm-yyyy hh24:mi:ss'), 109, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (198, 4, 36, to_date('24-02-2024 17:56:00', 'dd-mm-yyyy hh24:mi:ss'), 102, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (199, 3, 50, to_date('23-01-2025 09:43:00', 'dd-mm-yyyy hh24:mi:ss'), 315, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (200, 3, 8, to_date('25-04-2024 16:34:00', 'dd-mm-yyyy hh24:mi:ss'), 237, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (201, 3, 27, to_date('26-04-2026 17:18:00', 'dd-mm-yyyy hh24:mi:ss'), 226, null);
commit;
prompt 200 records committed...
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (202, 2, 9, to_date('06-04-2024 01:49:00', 'dd-mm-yyyy hh24:mi:ss'), 398, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (203, 2, 24, to_date('02-12-2024 19:00:00', 'dd-mm-yyyy hh24:mi:ss'), 167, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (204, 5, 15, to_date('04-10-2024 02:56:00', 'dd-mm-yyyy hh24:mi:ss'), 62, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (205, 5, 15, to_date('23-09-2026 07:31:00', 'dd-mm-yyyy hh24:mi:ss'), 325, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (206, 2, 19, to_date('06-04-2026 23:23:00', 'dd-mm-yyyy hh24:mi:ss'), 124, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (207, 2, 12, to_date('23-05-2024 19:42:00', 'dd-mm-yyyy hh24:mi:ss'), 91, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (208, 4, 44, to_date('25-11-2024 20:21:00', 'dd-mm-yyyy hh24:mi:ss'), 204, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (209, 1, 4, to_date('15-02-2024 05:32:00', 'dd-mm-yyyy hh24:mi:ss'), 336, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (210, 4, 35, to_date('30-07-2026 11:39:00', 'dd-mm-yyyy hh24:mi:ss'), 84, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (211, 3, 38, to_date('17-09-2024 17:06:00', 'dd-mm-yyyy hh24:mi:ss'), 205, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (212, 2, 1, to_date('11-05-2025 22:25:00', 'dd-mm-yyyy hh24:mi:ss'), 65, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (213, 4, 36, to_date('16-09-2026 20:45:00', 'dd-mm-yyyy hh24:mi:ss'), 37, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (214, 2, 44, to_date('17-12-2026 14:57:00', 'dd-mm-yyyy hh24:mi:ss'), 248, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (215, 3, 12, to_date('17-10-2026 04:56:00', 'dd-mm-yyyy hh24:mi:ss'), 12, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (216, 4, 21, to_date('01-07-2024 18:21:00', 'dd-mm-yyyy hh24:mi:ss'), 348, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (217, 2, 21, to_date('25-04-2024 23:25:00', 'dd-mm-yyyy hh24:mi:ss'), 124, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (218, 1, 12, to_date('05-05-2025 01:28:00', 'dd-mm-yyyy hh24:mi:ss'), 24, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (219, 5, 49, to_date('17-01-2025 06:00:00', 'dd-mm-yyyy hh24:mi:ss'), 273, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (220, 5, 16, to_date('31-03-2024 17:28:00', 'dd-mm-yyyy hh24:mi:ss'), 135, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (221, 3, 48, to_date('16-02-2024 08:56:00', 'dd-mm-yyyy hh24:mi:ss'), 91, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (222, 1, 42, to_date('08-08-2024 19:47:00', 'dd-mm-yyyy hh24:mi:ss'), 132, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (223, 2, 13, to_date('27-02-2025 16:31:00', 'dd-mm-yyyy hh24:mi:ss'), 83, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (224, 2, 41, to_date('27-11-2026 21:42:00', 'dd-mm-yyyy hh24:mi:ss'), 358, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (225, 4, 43, to_date('17-07-2026 14:28:00', 'dd-mm-yyyy hh24:mi:ss'), 101, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (226, 2, 29, to_date('03-06-2026 23:19:00', 'dd-mm-yyyy hh24:mi:ss'), 87, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (227, 5, 44, to_date('12-12-2025 22:41:00', 'dd-mm-yyyy hh24:mi:ss'), 342, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (228, 4, 0, to_date('28-12-2025 18:07:00', 'dd-mm-yyyy hh24:mi:ss'), 78, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (229, 2, 28, to_date('01-01-2025 15:28:00', 'dd-mm-yyyy hh24:mi:ss'), 64, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (230, 5, 28, to_date('31-01-2025 06:55:00', 'dd-mm-yyyy hh24:mi:ss'), 63, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (231, 4, 50, to_date('26-02-2025 17:17:00', 'dd-mm-yyyy hh24:mi:ss'), 37, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (232, 2, 10, to_date('28-12-2026 19:24:00', 'dd-mm-yyyy hh24:mi:ss'), 354, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (233, 1, 32, to_date('30-09-2026 14:04:00', 'dd-mm-yyyy hh24:mi:ss'), 310, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (234, 2, 5, to_date('05-04-2025 23:14:00', 'dd-mm-yyyy hh24:mi:ss'), 377, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (235, 2, 31, to_date('02-04-2025 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 111, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (236, 2, 6, to_date('26-03-2026 08:22:00', 'dd-mm-yyyy hh24:mi:ss'), 127, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (237, 2, 49, to_date('08-09-2025 07:42:00', 'dd-mm-yyyy hh24:mi:ss'), 265, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (238, 1, 4, to_date('10-11-2026 07:17:00', 'dd-mm-yyyy hh24:mi:ss'), 159, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (239, 1, 29, to_date('07-04-2024 02:04:00', 'dd-mm-yyyy hh24:mi:ss'), 141, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (240, 3, 0, to_date('27-08-2025 02:23:00', 'dd-mm-yyyy hh24:mi:ss'), 87, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (241, 5, 49, to_date('02-03-2026 05:28:00', 'dd-mm-yyyy hh24:mi:ss'), 325, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (242, 5, 49, to_date('29-10-2024 09:02:00', 'dd-mm-yyyy hh24:mi:ss'), 28, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (243, 4, 43, to_date('29-07-2024 14:39:00', 'dd-mm-yyyy hh24:mi:ss'), 212, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (244, 1, 45, to_date('21-08-2026 22:01:00', 'dd-mm-yyyy hh24:mi:ss'), 151, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (245, 2, 33, to_date('24-10-2024 20:48:00', 'dd-mm-yyyy hh24:mi:ss'), 132, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (246, 5, 6, to_date('07-12-2026 17:41:00', 'dd-mm-yyyy hh24:mi:ss'), 369, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (247, 4, 33, to_date('29-09-2026 21:28:00', 'dd-mm-yyyy hh24:mi:ss'), 393, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (248, 1, 39, to_date('31-10-2026 11:23:00', 'dd-mm-yyyy hh24:mi:ss'), 140, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (249, 3, 0, to_date('30-04-2025 15:48:00', 'dd-mm-yyyy hh24:mi:ss'), 51, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (250, 2, 49, to_date('22-08-2026 02:27:00', 'dd-mm-yyyy hh24:mi:ss'), 405, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (251, 3, 34, to_date('02-05-2026 07:14:00', 'dd-mm-yyyy hh24:mi:ss'), 209, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (252, 5, 39, to_date('08-12-2025 22:46:00', 'dd-mm-yyyy hh24:mi:ss'), 48, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (253, 2, 0, to_date('23-04-2026 13:51:00', 'dd-mm-yyyy hh24:mi:ss'), 238, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (254, 5, 6, to_date('08-11-2026 00:48:00', 'dd-mm-yyyy hh24:mi:ss'), 75, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (255, 1, 13, to_date('06-09-2025 14:06:00', 'dd-mm-yyyy hh24:mi:ss'), 121, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (256, 2, 17, to_date('14-07-2025 17:03:00', 'dd-mm-yyyy hh24:mi:ss'), 326, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (257, 2, 45, to_date('25-01-2024 20:04:00', 'dd-mm-yyyy hh24:mi:ss'), 124, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (258, 1, 32, to_date('12-10-2024 15:08:00', 'dd-mm-yyyy hh24:mi:ss'), 306, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (259, 1, 30, to_date('02-10-2024 14:14:00', 'dd-mm-yyyy hh24:mi:ss'), 196, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (260, 3, 20, to_date('23-11-2025 00:13:00', 'dd-mm-yyyy hh24:mi:ss'), 147, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (261, 5, 17, to_date('30-05-2024 13:47:00', 'dd-mm-yyyy hh24:mi:ss'), 284, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (262, 4, 9, to_date('16-09-2026 05:10:00', 'dd-mm-yyyy hh24:mi:ss'), 90, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (263, 4, 46, to_date('04-12-2026 22:17:00', 'dd-mm-yyyy hh24:mi:ss'), 385, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (264, 4, 33, to_date('17-10-2025 15:54:00', 'dd-mm-yyyy hh24:mi:ss'), 90, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (265, 3, 33, to_date('02-07-2024 13:07:00', 'dd-mm-yyyy hh24:mi:ss'), 313, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (266, 3, 11, to_date('08-11-2026 00:31:00', 'dd-mm-yyyy hh24:mi:ss'), 358, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (267, 3, 32, to_date('01-11-2026 15:58:00', 'dd-mm-yyyy hh24:mi:ss'), 397, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (268, 4, 32, to_date('29-04-2025 17:49:00', 'dd-mm-yyyy hh24:mi:ss'), 409, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (269, 5, 48, to_date('19-08-2024 19:24:00', 'dd-mm-yyyy hh24:mi:ss'), 303, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (270, 2, 9, to_date('21-02-2025 21:12:00', 'dd-mm-yyyy hh24:mi:ss'), 256, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (271, 5, 30, to_date('25-02-2025 00:23:00', 'dd-mm-yyyy hh24:mi:ss'), 376, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (272, 2, 48, to_date('15-09-2025 06:19:00', 'dd-mm-yyyy hh24:mi:ss'), 110, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (273, 5, 17, to_date('22-01-2025 09:43:00', 'dd-mm-yyyy hh24:mi:ss'), 316, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (274, 2, 33, to_date('14-01-2024 22:02:00', 'dd-mm-yyyy hh24:mi:ss'), 219, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (275, 1, 11, to_date('28-05-2025 00:41:00', 'dd-mm-yyyy hh24:mi:ss'), 371, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (276, 4, 25, to_date('03-02-2026 20:53:00', 'dd-mm-yyyy hh24:mi:ss'), 26, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (277, 4, 5, to_date('20-10-2025 01:23:00', 'dd-mm-yyyy hh24:mi:ss'), 260, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (278, 2, 32, to_date('04-05-2025 05:13:00', 'dd-mm-yyyy hh24:mi:ss'), 248, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (279, 1, 37, to_date('22-10-2024 06:30:00', 'dd-mm-yyyy hh24:mi:ss'), 216, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (280, 3, 31, to_date('27-05-2026 12:35:00', 'dd-mm-yyyy hh24:mi:ss'), 292, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (281, 5, 46, to_date('17-06-2026 20:29:00', 'dd-mm-yyyy hh24:mi:ss'), 163, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (282, 2, 29, to_date('11-01-2024 12:51:00', 'dd-mm-yyyy hh24:mi:ss'), 181, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (283, 4, 14, to_date('20-01-2026 12:27:00', 'dd-mm-yyyy hh24:mi:ss'), 205, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (284, 4, 13, to_date('12-02-2024 04:38:00', 'dd-mm-yyyy hh24:mi:ss'), 220, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (285, 4, 50, to_date('13-01-2026 22:20:00', 'dd-mm-yyyy hh24:mi:ss'), 50, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (286, 5, 38, to_date('11-01-2026 23:22:00', 'dd-mm-yyyy hh24:mi:ss'), 373, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (287, 2, 9, to_date('24-02-2025 10:41:00', 'dd-mm-yyyy hh24:mi:ss'), 161, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (288, 2, 12, to_date('26-01-2026 12:50:00', 'dd-mm-yyyy hh24:mi:ss'), 175, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (289, 1, 15, to_date('23-09-2025 03:57:00', 'dd-mm-yyyy hh24:mi:ss'), 217, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (290, 1, 16, to_date('02-02-2024 16:07:00', 'dd-mm-yyyy hh24:mi:ss'), 365, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (291, 2, 6, to_date('13-03-2026 07:16:00', 'dd-mm-yyyy hh24:mi:ss'), 118, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (292, 5, 19, to_date('02-05-2024 14:08:00', 'dd-mm-yyyy hh24:mi:ss'), 247, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (293, 2, 38, to_date('02-10-2025 20:39:00', 'dd-mm-yyyy hh24:mi:ss'), 302, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (294, 3, 27, to_date('04-07-2024 11:44:00', 'dd-mm-yyyy hh24:mi:ss'), 367, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (295, 5, 14, to_date('26-03-2026 14:50:00', 'dd-mm-yyyy hh24:mi:ss'), 193, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (296, 1, 33, to_date('09-12-2025 11:04:00', 'dd-mm-yyyy hh24:mi:ss'), 129, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (297, 2, 19, to_date('03-03-2025 10:28:00', 'dd-mm-yyyy hh24:mi:ss'), 369, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (298, 5, 48, to_date('07-01-2026 16:47:00', 'dd-mm-yyyy hh24:mi:ss'), 325, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (299, 4, 29, to_date('13-01-2024 20:58:00', 'dd-mm-yyyy hh24:mi:ss'), 61, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (300, 1, 25, to_date('05-10-2025 00:20:00', 'dd-mm-yyyy hh24:mi:ss'), 192, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (301, 4, 26, to_date('01-09-2024 02:41:00', 'dd-mm-yyyy hh24:mi:ss'), 373, null);
commit;
prompt 300 records committed...
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (302, 2, 30, to_date('01-08-2025 16:12:00', 'dd-mm-yyyy hh24:mi:ss'), 199, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (303, 4, 41, to_date('28-11-2025 04:44:00', 'dd-mm-yyyy hh24:mi:ss'), 29, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (304, 5, 43, to_date('15-04-2024 13:13:00', 'dd-mm-yyyy hh24:mi:ss'), 156, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (305, 5, 50, to_date('24-05-2026 14:17:00', 'dd-mm-yyyy hh24:mi:ss'), 43, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (306, 5, 9, to_date('08-03-2024 13:45:00', 'dd-mm-yyyy hh24:mi:ss'), 243, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (307, 3, 46, to_date('22-07-2024 01:15:00', 'dd-mm-yyyy hh24:mi:ss'), 115, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (308, 4, 24, to_date('13-06-2024 12:06:00', 'dd-mm-yyyy hh24:mi:ss'), 171, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (309, 5, 16, to_date('12-10-2024 18:35:00', 'dd-mm-yyyy hh24:mi:ss'), 353, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (310, 4, 14, to_date('23-08-2026 00:34:00', 'dd-mm-yyyy hh24:mi:ss'), 70, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (311, 4, 1, to_date('26-10-2025 22:04:00', 'dd-mm-yyyy hh24:mi:ss'), 318, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (312, 5, 3, to_date('07-06-2025 03:00:00', 'dd-mm-yyyy hh24:mi:ss'), 288, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (313, 5, 46, to_date('27-04-2024 09:33:00', 'dd-mm-yyyy hh24:mi:ss'), 196, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (314, 2, 25, to_date('18-06-2026 19:43:00', 'dd-mm-yyyy hh24:mi:ss'), 135, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (315, 1, 41, to_date('23-07-2024 23:44:00', 'dd-mm-yyyy hh24:mi:ss'), 94, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (316, 5, 21, to_date('28-06-2025 04:05:00', 'dd-mm-yyyy hh24:mi:ss'), 335, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (317, 1, 9, to_date('28-05-2024 18:26:00', 'dd-mm-yyyy hh24:mi:ss'), 262, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (318, 2, 33, to_date('09-08-2026 14:32:00', 'dd-mm-yyyy hh24:mi:ss'), 409, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (319, 3, 29, to_date('30-05-2025 20:20:00', 'dd-mm-yyyy hh24:mi:ss'), 236, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (320, 3, 35, to_date('01-10-2024 14:06:00', 'dd-mm-yyyy hh24:mi:ss'), 190, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (321, 2, 44, to_date('20-02-2025 10:14:00', 'dd-mm-yyyy hh24:mi:ss'), 113, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (322, 5, 1, to_date('27-04-2024 13:20:00', 'dd-mm-yyyy hh24:mi:ss'), 249, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (323, 3, 23, to_date('22-08-2024 03:53:00', 'dd-mm-yyyy hh24:mi:ss'), 343, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (324, 5, 28, to_date('12-01-2025 04:54:00', 'dd-mm-yyyy hh24:mi:ss'), 60, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (325, 4, 4, to_date('22-02-2024 20:11:00', 'dd-mm-yyyy hh24:mi:ss'), 54, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (326, 2, 24, to_date('10-12-2025 01:39:00', 'dd-mm-yyyy hh24:mi:ss'), 279, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (327, 4, 32, to_date('03-12-2024 08:57:00', 'dd-mm-yyyy hh24:mi:ss'), 296, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (328, 1, 18, to_date('27-08-2026 10:00:00', 'dd-mm-yyyy hh24:mi:ss'), 355, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (329, 5, 29, to_date('12-05-2025 02:14:00', 'dd-mm-yyyy hh24:mi:ss'), 212, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (330, 5, 33, to_date('24-09-2025 11:02:00', 'dd-mm-yyyy hh24:mi:ss'), 262, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (331, 3, 23, to_date('07-03-2026 09:02:00', 'dd-mm-yyyy hh24:mi:ss'), 135, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (332, 3, 18, to_date('06-04-2025 21:00:00', 'dd-mm-yyyy hh24:mi:ss'), 359, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (333, 1, 47, to_date('20-11-2026 13:36:00', 'dd-mm-yyyy hh24:mi:ss'), 410, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (334, 1, 10, to_date('29-08-2026 15:19:00', 'dd-mm-yyyy hh24:mi:ss'), 174, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (335, 1, 39, to_date('22-05-2025 05:12:00', 'dd-mm-yyyy hh24:mi:ss'), 336, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (336, 2, 44, to_date('13-08-2026 04:07:00', 'dd-mm-yyyy hh24:mi:ss'), 111, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (337, 2, 34, to_date('11-10-2026 15:17:00', 'dd-mm-yyyy hh24:mi:ss'), 42, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (338, 1, 47, to_date('30-03-2025 19:14:00', 'dd-mm-yyyy hh24:mi:ss'), 83, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (339, 3, 46, to_date('16-05-2025 18:25:00', 'dd-mm-yyyy hh24:mi:ss'), 80, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (340, 3, 26, to_date('04-06-2025 12:42:00', 'dd-mm-yyyy hh24:mi:ss'), 274, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (341, 2, 30, to_date('06-11-2025 08:26:00', 'dd-mm-yyyy hh24:mi:ss'), 346, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (342, 1, 50, to_date('01-05-2026 02:50:00', 'dd-mm-yyyy hh24:mi:ss'), 19, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (343, 5, 2, to_date('23-08-2025 10:14:00', 'dd-mm-yyyy hh24:mi:ss'), 331, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (344, 2, 14, to_date('21-02-2026 11:42:00', 'dd-mm-yyyy hh24:mi:ss'), 15, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (345, 1, 39, to_date('01-07-2024 03:02:00', 'dd-mm-yyyy hh24:mi:ss'), 283, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (346, 3, 5, to_date('10-12-2024 10:07:00', 'dd-mm-yyyy hh24:mi:ss'), 252, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (347, 4, 15, to_date('12-03-2025 19:08:00', 'dd-mm-yyyy hh24:mi:ss'), 113, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (348, 3, 45, to_date('19-10-2024 14:13:00', 'dd-mm-yyyy hh24:mi:ss'), 77, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (349, 2, 45, to_date('06-07-2025 10:13:00', 'dd-mm-yyyy hh24:mi:ss'), 408, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (350, 2, 36, to_date('23-01-2024 21:24:00', 'dd-mm-yyyy hh24:mi:ss'), 369, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (351, 4, 48, to_date('27-04-2025 09:06:00', 'dd-mm-yyyy hh24:mi:ss'), 383, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (352, 2, 41, to_date('16-10-2026 01:54:00', 'dd-mm-yyyy hh24:mi:ss'), 255, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (353, 5, 19, to_date('24-11-2024 10:57:00', 'dd-mm-yyyy hh24:mi:ss'), 347, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (354, 1, 8, to_date('15-06-2025 17:50:00', 'dd-mm-yyyy hh24:mi:ss'), 342, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (355, 2, 31, to_date('04-06-2026 06:07:00', 'dd-mm-yyyy hh24:mi:ss'), 305, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (356, 4, 29, to_date('19-09-2025 13:36:00', 'dd-mm-yyyy hh24:mi:ss'), 72, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (357, 2, 30, to_date('31-08-2026 20:23:00', 'dd-mm-yyyy hh24:mi:ss'), 273, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (358, 1, 47, to_date('30-06-2026 22:01:00', 'dd-mm-yyyy hh24:mi:ss'), 11, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (359, 2, 23, to_date('04-11-2024 18:42:00', 'dd-mm-yyyy hh24:mi:ss'), 327, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (360, 1, 45, to_date('04-03-2024 17:45:00', 'dd-mm-yyyy hh24:mi:ss'), 252, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (361, 5, 2, to_date('04-09-2024 08:27:00', 'dd-mm-yyyy hh24:mi:ss'), 377, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (362, 1, 38, to_date('18-12-2025 18:21:00', 'dd-mm-yyyy hh24:mi:ss'), 154, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (363, 4, 15, to_date('23-08-2024 06:16:00', 'dd-mm-yyyy hh24:mi:ss'), 56, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (364, 5, 44, to_date('25-07-2024 00:51:00', 'dd-mm-yyyy hh24:mi:ss'), 197, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (365, 5, 24, to_date('28-05-2026 12:16:00', 'dd-mm-yyyy hh24:mi:ss'), 348, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (366, 1, 46, to_date('07-11-2026 17:38:00', 'dd-mm-yyyy hh24:mi:ss'), 365, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (367, 2, 48, to_date('09-06-2025 15:48:00', 'dd-mm-yyyy hh24:mi:ss'), 131, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (368, 2, 8, to_date('05-12-2025 08:06:00', 'dd-mm-yyyy hh24:mi:ss'), 258, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (369, 4, 10, to_date('24-10-2025 08:45:00', 'dd-mm-yyyy hh24:mi:ss'), 46, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (370, 4, 14, to_date('15-03-2024 01:33:00', 'dd-mm-yyyy hh24:mi:ss'), 124, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (371, 2, 12, to_date('20-03-2025 06:16:00', 'dd-mm-yyyy hh24:mi:ss'), 98, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (372, 4, 11, to_date('01-10-2026 15:46:00', 'dd-mm-yyyy hh24:mi:ss'), 17, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (373, 5, 9, to_date('12-02-2024 03:02:00', 'dd-mm-yyyy hh24:mi:ss'), 175, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (374, 4, 33, to_date('16-11-2025 11:04:00', 'dd-mm-yyyy hh24:mi:ss'), 279, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (375, 2, 16, to_date('15-02-2026 09:05:00', 'dd-mm-yyyy hh24:mi:ss'), 290, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (376, 4, 22, to_date('07-10-2024 19:45:00', 'dd-mm-yyyy hh24:mi:ss'), 154, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (377, 1, 13, to_date('05-08-2026 20:59:00', 'dd-mm-yyyy hh24:mi:ss'), 160, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (378, 2, 41, to_date('05-06-2025 19:08:00', 'dd-mm-yyyy hh24:mi:ss'), 116, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (379, 2, 38, to_date('26-04-2025 00:42:00', 'dd-mm-yyyy hh24:mi:ss'), 94, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (380, 3, 17, to_date('07-10-2025 04:04:00', 'dd-mm-yyyy hh24:mi:ss'), 330, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (382, 5, 41, to_date('10-11-2025 18:58:00', 'dd-mm-yyyy hh24:mi:ss'), 36, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (383, 2, 42, to_date('21-09-2026 15:03:00', 'dd-mm-yyyy hh24:mi:ss'), 234, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (384, 2, 39, to_date('06-06-2025 05:20:00', 'dd-mm-yyyy hh24:mi:ss'), 255, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (385, 2, 30, to_date('10-08-2024 02:11:00', 'dd-mm-yyyy hh24:mi:ss'), 254, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (386, 4, 5, to_date('22-06-2024 16:44:00', 'dd-mm-yyyy hh24:mi:ss'), 228, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (387, 3, 33, to_date('28-11-2025 16:04:00', 'dd-mm-yyyy hh24:mi:ss'), 239, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (388, 4, 6, to_date('15-02-2024 09:19:00', 'dd-mm-yyyy hh24:mi:ss'), 367, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (389, 5, 29, to_date('10-06-2025 05:22:00', 'dd-mm-yyyy hh24:mi:ss'), 94, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (390, 2, 39, to_date('26-08-2024 23:53:00', 'dd-mm-yyyy hh24:mi:ss'), 146, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (391, 1, 15, to_date('07-11-2024 10:09:00', 'dd-mm-yyyy hh24:mi:ss'), 323, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (392, 2, 22, to_date('15-09-2026 15:21:00', 'dd-mm-yyyy hh24:mi:ss'), 106, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (393, 1, 26, to_date('18-09-2025 01:11:00', 'dd-mm-yyyy hh24:mi:ss'), 198, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (394, 3, 33, to_date('12-09-2026 01:48:00', 'dd-mm-yyyy hh24:mi:ss'), 386, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (395, 3, 7, to_date('05-10-2025 14:42:00', 'dd-mm-yyyy hh24:mi:ss'), 57, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (396, 1, 33, to_date('20-05-2024 04:58:00', 'dd-mm-yyyy hh24:mi:ss'), 188, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (397, 1, 21, to_date('27-04-2024 06:42:00', 'dd-mm-yyyy hh24:mi:ss'), 122, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (398, 2, 31, to_date('21-08-2024 22:15:00', 'dd-mm-yyyy hh24:mi:ss'), 155, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (399, 3, 46, to_date('30-11-2024 02:38:00', 'dd-mm-yyyy hh24:mi:ss'), 247, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (400, 1, 42, to_date('13-06-2024 06:14:00', 'dd-mm-yyyy hh24:mi:ss'), 82, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (401, 4, 15, to_date('04-02-2026 14:45:00', 'dd-mm-yyyy hh24:mi:ss'), 190, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (402, 3, 33, to_date('10-01-2024 19:46:00', 'dd-mm-yyyy hh24:mi:ss'), 351, null);
commit;
prompt 400 records committed...
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (403, 2, 48, to_date('07-06-2024 14:50:00', 'dd-mm-yyyy hh24:mi:ss'), 406, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (404, 3, 13, to_date('27-02-2026 14:22:00', 'dd-mm-yyyy hh24:mi:ss'), 285, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (405, 3, 18, to_date('31-08-2026 10:24:00', 'dd-mm-yyyy hh24:mi:ss'), 172, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (406, 4, 7, to_date('03-10-2026 00:20:00', 'dd-mm-yyyy hh24:mi:ss'), 236, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (407, 5, 18, to_date('13-02-2026 08:39:00', 'dd-mm-yyyy hh24:mi:ss'), 230, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (408, 4, 33, to_date('11-07-2026 08:12:00', 'dd-mm-yyyy hh24:mi:ss'), 192, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (409, 2, 8, to_date('24-03-2024 11:31:00', 'dd-mm-yyyy hh24:mi:ss'), 359, null);
insert into ORDERS (orderid, ticketamount, ticketcost, orderdate, eventid, d_id)
values (410, 4, 0, to_date('26-11-2024 09:48:00', 'dd-mm-yyyy hh24:mi:ss'), 112, null);
commit;
prompt 408 records loaded
prompt Loading PARTICIPANTS...
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (1, 'Alice', 'Green', 'alice@example.com', 1);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (2, 'Bob', 'White', 'bob@example.com', 0);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (3, 'Charlie', 'Black', 'charlie@example.com', 1);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (4, 'Diana', 'Red', 'diana@example.com', 0);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (5, 'Evan', 'Yellow', 'evan@example.com', 1);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (6, 'Fiona', 'Blue', 'fiona@example.com', 0);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (7, 'George', 'Pink', 'george@example.com', 1);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (8, 'Hannah', 'Brown', 'hannah@example.com', 0);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (9, 'Ian', 'Grey', 'ian@example.com', 1);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (10, 'Julia', 'Orange', 'julia@example.com', 0);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (11, 'Marc', 'Garza', 'marcg@visainternational.ch', 1000);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (12, 'Stockard', 'Wells', 'swells@sears.de', 1001);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (13, 'Dennis', 'Durning', 'dennis@educationaldevelopment.', 1002);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (14, 'Javon', 'Austin', 'javon.austin@netnumina.com', 1003);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (15, 'Edwin', 'Page', 'edwin.page@scriptsave.ch', 1004);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (16, 'Gino', 'Amos', 'gino.amos@ahl.com', 1005);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (17, 'Mira', 'Garr', 'mira.garr@multimedialive.com', 1006);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (18, 'Mark', 'Tate', 'mark@trm.com', 1007);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (19, 'Lee', 'Owen', 'lee.owen@canterburypark.br', 1008);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (20, 'Nik', 'Lynskey', 'nik.lynskey@fpf.com', 1009);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (21, 'Lindsey', 'Hutton', 'lindsey.h@floorgraphics.nl', 1010);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (22, 'Tim', 'Theron', 'tim.theron@contract.com', 1011);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (23, 'Hugh', 'Mulroney', 'hmulroney@calence.de', 1012);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (24, 'Lili', 'Zeta-Jones', 'lili.zetajones@greene.com', 1013);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (25, 'Lydia', 'Baker', 'lydiab@atlanticcredit.uk', 1014);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (26, 'Mary Beth', 'Coburn', 'marybeth.coburn@mls.uk', 1015);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (27, 'Kim', 'Ceasar', 'kceasar@marlabs.de', 1016);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (28, 'Anne', 'Crimson', 'anne.crimson@mercantilebank.it', 1017);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (29, 'Kazem', 'Moriarty', 'kazem.moriarty@safeway.ca', 1018);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (30, 'Freda', 'Ripley', 'freda.ripley@ibm.de', 1019);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (31, 'Joanna', 'Cummings', 'joannac@softworld.de', 1020);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (32, 'Natacha', 'Vai', 'natacha.vai@smartronix.jp', 1021);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (33, 'Domingo', 'Yankovic', 'dyankovic@ciwservices.com', 1022);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (34, 'Patti', 'Caine', 'patti.caine@bat.com', 1023);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (35, 'Suzy', 'Tucci', 's.tucci@nha.uk', 1024);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (36, 'Joey', 'Snow', 'jsnow@entelligence.it', 1025);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (37, 'Chi', 'Ojeda', 'cojeda@techrx.si', 1026);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (38, 'Samantha', 'Ontiveros', 'samantha.o@kimberlyclark.ca', 1027);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (39, 'Robby', 'Wilson', 'rwilson@nuinfosystems.com', 1028);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (40, 'Heath', 'Wainwright', 'heath.wainwright@conquestsyste', 1029);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (41, 'Denzel', 'Gayle', 'dgayle@walmartstores.de', 1030);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (42, 'Rolando', 'Bailey', 'rolando.bailey@marketbased.de', 1031);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (43, 'Zooey', 'Sellers', 'zooey@privatebancorp.com', 1032);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (44, 'Helen', 'Sevenfold', 'hsevenfold@fmb.au', 1033);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (45, 'Jay', 'Coward', 'jay@yashtechnologies.com', 1034);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (46, 'Wayman', 'Sheen', 'wayman@trafficmanagement.ch', 1035);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (47, 'Hector', 'Costner', 'hector.costner@printingforless', 1036);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (48, 'John', 'Day-Lewis', 'john.daylewis@gltg.de', 1037);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (49, 'Joely', 'Holm', 'joely.holm@qestrel.uk', 1038);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (50, 'Moe', 'LaBelle', 'moe@mastercardinternational.br', 1039);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (51, 'Aidan', 'Strathairn', 'astrathairn@diversitech.ch', 1040);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (52, 'Jill', 'Broadbent', 'jbroadbent@myricom.uk', 1041);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (53, 'Jonathan', 'Hatchet', 'jonathan.hatchet@aoe.com', 1042);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (54, 'Edgar', 'Bates', 'edgar.bates@arkidata.com', 1043);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (55, 'Glenn', 'Reeves', 'glenn.reeves@scjohnson.de', 1044);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (56, 'Sarah', 'Cassel', 'sarah.cassel@securitycheck.com', 1045);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (57, 'Barbara', 'Marshall', 'barbara.marshall@americanvangu', 1046);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (58, 'Tony', 'Rains', 'tony.rains@callhenry.se', 1047);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (59, 'Tom', 'Byrd', 't.byrd@nsd.de', 1048);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (60, 'Julianna', 'Lange', 'juliannal@greene.de', 1049);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (61, 'Hector', 'Winwood', 'hector.w@teamstudio.com', 1050);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (62, 'Gena', 'Green', 'gena.green@amerisourcefunding.', 1051);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (63, 'Arnold', 'McCain', 'arnold.mccain@ads.ch', 1052);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (64, 'Allison', 'Gibson', 'a.gibson@bis.it', 1053);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (65, 'Oliver', 'Utada', 'oliver.utada@telwares.br', 1054);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (66, 'Austin', 'Lucien', 'austin.l@microsoft.ca', 1055);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (67, 'Juan', 'Lynch', 'jlynch@americanland.au', 1056);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (68, 'Ronny', 'Horton', 'ronnyh@novartis.com', 1057);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (69, 'Charlie', 'Witt', 'c.witt@mwh.uk', 1058);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (70, 'Beverley', 'Hedaya', 'beverley.h@aoe.de', 1059);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (71, 'Stevie', 'Todd', 's.todd@saltgroup.ch', 1060);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (72, 'Madeleine', 'Berenger', 'mberenger@ntas.de', 1061);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (73, 'Aaron', 'Yorn', 'aaron.yorn@trainersoft.com', 1062);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (74, 'Avril', 'Dukakis', 'avril@tama.com', 1063);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (75, 'Ani', 'Melvin', 'ani.melvin@volkswagen.jp', 1064);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (76, 'Colin', 'Hayes', 'c.hayes@heritagemicrofilm.com', 1065);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (77, 'Lauren', 'Wood', 'lauren.wood@sht.com', 1066);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (78, 'Mindy', 'Navarro', 'mindy.navarro@seiaarons.com', 1067);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (79, 'Goldie', 'Wakeling', 'goldie.wakeling@ccb.com', 1068);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (80, 'Olga', 'Phifer', 'ophifer@pharmacia.nz', 1069);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (81, 'Eric', 'Spiner', 'eric.spiner@stonebrewing.com', 1070);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (82, 'Kylie', 'Barkin', 'kylie.barkin@nbs.es', 1071);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (83, 'Howard', 'Williamson', 'howard.williamson@benecongroup', 1072);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (84, 'Karen', 'Giamatti', 'karen.giamatti@serentec.au', 1073);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (85, 'Dionne', 'Schiavelli', 'dschiavelli@fmt.be', 1074);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (86, 'Suzy', 'McDowell', 'suzy.mcdowell@csi.ca', 1075);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (87, 'Adam', 'Freeman', 'adam.freeman@pharmacia.ch', 1076);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (88, 'Thelma', 'Springfield', 'thelma@bestbuy.fr', 1077);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (89, 'Curtis', 'Lang', 'curtis@balchem.com', 1078);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (90, 'Radney', 'Vincent', 'radney.vincent@ois.it', 1079);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (91, 'Roger', 'Lofgren', 'roger.lofgren@bioanalytical.ca', 1080);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (92, 'Aidan', 'Pesci', 'aidan.pesci@gbas.au', 1081);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (93, 'Gin', 'Palin', 'gin.palin@trafficmanagement.es', 1082);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (94, 'Jose', 'Blossoms', 'jose.blossoms@heartlab.com', 1083);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (95, 'Chant×™', 'Porter', 'chant.porter@spectrum.jp', 1084);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (96, 'Nickel', 'Jeter', 'n.jeter@unilever.de', 1085);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (97, 'Rod', 'Dzundza', 'rod@dcgroup.com', 1086);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (98, 'Merillee', 'Atkins', 'merilleea@target.pt', 1087);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (99, 'Kurtwood', 'Colman', 'kurtwood.colman@qestrel.dk', 1088);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (100, 'Vivica', 'MacNeil', 'vivica.macneil@chhc.com', 1089);
commit;
prompt 100 records committed...
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (101, 'Judy', 'Tankard', 'judyt@gha.es', 1090);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (102, 'Marie', 'Goldberg', 'marie.goldberg@verizon.com', 1091);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (103, 'Loreena', 'Moss', 'loreenam@coridiantechnologies.', 1092);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (104, 'Rosanna', 'Thurman', 'rosanna.thurman@monitronicsint', 1093);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (105, 'Buddy', 'Gibson', 'buddy@north.de', 1094);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (106, 'Grace', 'Hopper', 'grace.hopper@aco.be', 1095);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (107, 'Lara', 'Chao', 'lara.c@limitedbrands.com', 1096);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (108, 'John', 'Winter', 'john.winter@shirtfactory.com', 1097);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (109, 'Joe', 'Phoenix', 'joe.phoenix@fetchlogistics.com', 1098);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (110, 'Connie', 'El-Saher', 'connie.elsaher@securitycheck.d', 1099);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (111, 'Gailard', 'Easton', 'geaston@solutionbuilders.br', 1100);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (112, 'Dwight', 'Holm', 'dwight.holm@questarcapital.com', 1101);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (113, 'Kevn', 'Ponty', 'kevn@trafficmanagement.ca', 1102);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (114, 'Yolanda', 'Yankovic', 'yolanda@credopetroleum.ch', 1103);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (115, 'Jake', 'Stowe', 'j.stowe@freedommedical.com', 1104);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (116, 'Mindy', 'Leguizamo', 'mleguizamo@bowman.com', 1105);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (117, 'Jack', 'Dysart', 'jack.dysart@hitechpharmacal.ch', 1106);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (118, 'Saffron', 'Singletary', 'saffron@ccfholding.uk', 1107);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (119, 'Sissy', 'Serbedzija', 'sissy.serbedzija@hiltonhotels.', 1108);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (120, 'Tyrone', 'MacNeil', 'tyrone@jma.ch', 1109);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (121, 'Julianne', 'Giraldo', 'jgiraldo@cis.at', 1110);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (122, 'Miguel', 'Assante', 'miguel.assante@ksj.com', 1111);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (123, 'Lance', 'McClinton', 'l.mcclinton@greene.de', 1112);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (124, 'Mary', 'Fraser', 'mfraser@americanpan.com', 1113);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (125, 'Mark', 'Bergen', 'mark@elitemedical.de', 1114);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (126, 'Loreena', 'Gallagher', 'loreena.gallagher@enterprise.c', 1115);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (127, 'Nancy', 'Koyana', 'nancy.koyana@gentrasystems.br', 1116);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (128, 'Demi', 'Oates', 'demi.o@operationaltechnologies', 1117);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (129, 'Pelvic', 'Perez', 'pelvic.perez@sci.de', 1118);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (130, 'Goldie', 'Neville', 'goldie.n@signalperfection.com', 1119);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (131, 'Kristin', 'Jenkins', 'kristinj@peerlessmanufacturing', 1120);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (132, 'Wayman', 'Holliday', 'wayman.holliday@denaliventures', 1121);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (133, 'Caroline', 'Page', 'caroline.page@horizon.jp', 1122);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (134, 'Viggo', 'Richards', 'viggo.richards@aquickdelivery.', 1123);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (135, 'Sophie', 'Hidalgo', 'sophieh@hfg.ca', 1124);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (136, 'Joey', 'Statham', 'joey.statham@softworld.com', 1125);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (137, 'Julie', 'Lang', 'juliel@berkshirehathaway.com', 1126);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (138, 'Geraldine', 'Hagar', 'geraldine.hagar@employerservic', 1127);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (139, 'Rachael', 'Paige', 'rachaelp@webgroup.fr', 1128);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (140, 'Frederic', 'Dunst', 'frederic.dunst@parker.il', 1129);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (141, 'Toni', 'Donelly', 'toni.d@whitewave.de', 1130);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (142, 'Sam', 'Sandler', 'sam.sandler@flavorx.com', 1131);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (143, 'Ashton', 'Hopkins', 'ashton.hopkins@teamstudio.il', 1132);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (144, 'Penelope', 'LaMond', 'penelope.lamond@mms.com', 1133);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (145, 'Rip', 'Allison', 'rallison@insurmark.au', 1134);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (146, 'Laura', 'Willard', 'lauraw@typhoon.au', 1135);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (147, 'Gene', 'Stamp', 'gene@usenergyservices.it', 1136);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (148, 'Pierce', 'Venora', 'pvenora@epamsystems.com', 1137);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (149, 'Danni', 'Makeba', 'danni.makeba@ksj.uk', 1138);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (150, 'Josh', 'Hanley', 'joshh@alogent.be', 1139);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (151, 'Gin', 'Kimball', 'gin.kimball@myricom.be', 1140);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (152, 'Cliff', 'Shalhoub', 'cliff@unitedasset.com', 1141);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (153, 'Madeleine', 'Bloch', 'madeleine.b@veritekinternation', 1142);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (154, 'Sophie', 'Arkenstone', 'sophie.arkenstone@ipsadvisory.', 1143);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (155, 'Joy', 'Leigh', 'joy.leigh@sfmai.com', 1144);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (156, 'Nikka', 'Cartlidge', 'nikka.cartlidge@tilia.com', 1145);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (157, 'Ted', 'Donelly', 'tedd@team.it', 1146);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (158, 'Nicole', 'Watley', 'nicolew@mls.de', 1147);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (159, 'Gabriel', 'Adler', 'gabriel@sfgo.ca', 1148);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (160, 'Gladys', 'Underwood', 'gladys.underwood@accesssystems', 1149);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (161, 'Emily', 'Damon', 'emily.damon@ceo.dk', 1150);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (162, 'Elisabeth', 'Sorvino', 'e.sorvino@vitacostcom.de', 1151);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (163, 'Leslie', 'Benoit', 'leslie.benoit@saltgroup.com', 1152);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (164, 'Marty', 'Aiken', 'marty@campbellsoup.com', 1153);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (165, 'Brad', 'Stuermer', 'b.stuermer@caliber.in', 1154);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (166, 'Maury', 'Roy Parnell', 'maury.royparnell@sensortechnol', 1155);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (167, 'Gerald', 'Bacharach', 'g.bacharach@typhoon.ch', 1156);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (168, 'Tramaine', 'Campbell', 'tramaine.campbell@newtonintera', 1157);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (169, 'Moe', 'Damon', 'moed@horizonorganic.com', 1158);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (170, 'Wes', 'Blaine', 'wes.blaine@quakercitybancorp.c', 1159);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (171, 'Natalie', 'Nightingale', 'natalien@ssci.de', 1160);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (172, 'Juliana', 'Dalley', 'juliana@randomwalk.it', 1161);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (173, 'Lili', 'Belles', 'l.belles@kingland.gr', 1162);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (174, 'Franco', 'Hubbard', 'franco.hubbard@shirtfactory.co', 1163);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (175, 'Tcheky', 'Mantegna', 'tcheky.mantegna@doctorsassocia', 1164);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (176, 'Charlize', 'Chappelle', 'c.chappelle@vitacostcom.uk', 1165);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (177, 'Machine', 'Preston', 'machine@telwares.uk', 1166);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (178, 'Geraldine', 'Cross', 'geraldine.cross@airmethods.com', 1167);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (179, 'Rascal', 'Durning', 'rascald@pacificdatadesigns.com', 1168);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (180, 'Freddy', 'Perry', 'freddy.perry@marathonheater.co', 1169);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (181, 'Aidan', 'Paxton', 'aidan@sfb.de', 1170);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (182, 'Juliette', 'Chinlund', 'juliette@genextechnologies.de', 1171);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (183, 'Austin', 'Scheider', 'austin.s@cocacola.com', 1172);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (184, 'Tony', 'Alda', 'tony.alda@healthscribe.pl', 1173);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (185, 'Mia', 'Dushku', 'mia.dushku@flavorx.at', 1174);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (186, 'Ashton', 'Romijn-Stamos', 'ashton.romijnstamos@tlsservice', 1175);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (187, 'Donald', 'Dench', 'donald.dench@teoco.nl', 1176);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (188, 'Jaime', 'Costello', 'jaimec@clorox.ch', 1177);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (189, 'Illeana', 'Beatty', 'i.beatty@gillette.com', 1178);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (190, 'Laura', 'Choice', 'laura.c@cmi.it', 1179);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (191, 'Bridgette', 'Crudup', 'bridgette@pearllawgroup.il', 1180);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (192, 'Buddy', 'Rubinek', 'buddy.rubinek@yashtechnologies', 1181);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (193, 'Sydney', 'Basinger', 'sydney@capstone.com', 1182);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (194, 'Lisa', 'Vassar', 'lisa@aci.jp', 1183);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (195, 'Holly', 'Pastore', 'holly@kelmooreinvestment.uk', 1184);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (196, 'Juice', 'Reynolds', 'jreynolds@bis.il', 1185);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (197, 'Gwyneth', 'Lyonne', 'gwynethl@componentgraphics.com', 1186);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (198, 'Celia', 'Bugnon', 'celia.bugnon@venoco.nc', 1187);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (199, 'Ivan', 'Ramirez', 'i.ramirez@ctg.au', 1188);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (200, 'Pablo', 'Yankovic', 'p.yankovic@infovision.com', 1189);
commit;
prompt 200 records committed...
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (201, 'Darius', 'Zevon', 'darius.zevon@bashen.ca', 1190);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (202, 'Sharon', 'Mifune', 's.mifune@innovateecommerce.dk', 1191);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (203, 'Sylvester', 'Burton', 'sylvester.b@cima.br', 1192);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (204, 'Crispin', 'Bailey', 'crispin.bailey@noodles.com', 1193);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (205, 'Ewan', 'Weaving', 'ewan.weaving@aquascapedesigns.', 1194);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (206, 'Delbert', 'Badalucco', 'delbert.b@montpelierplastics.d', 1195);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (207, 'Uma', 'Nelligan', 'uma@ivorysystems.br', 1196);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (208, 'Jeffrey', 'Gandolfini', 'jgandolfini@tmaresources.au', 1197);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (209, 'Brent', 'Buscemi', 'b.buscemi@waltdisney.com', 1198);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (210, 'Davy', 'Briscoe', 'davy.briscoe@randomwalk.com', 1199);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (211, 'Uma', 'Manning', 'uma@virbac.com', 1200);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (212, 'Lauren', 'Austin', 'lauren.austin@usainstruments.c', 1201);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (213, 'Katrin', 'Greenwood', 'katrin.g@ceb.at', 1202);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (214, 'Loretta', 'Salonga', 'lorettas@activeservices.com', 1203);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (215, 'Hank', 'Berkley', 'hank.b@coldstonecreamery.it', 1204);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (216, 'Nikki', 'Himmelman', 'nhimmelman@talx.de', 1205);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (217, 'Kelli', 'Ball', 'kelli.ball@parker.nl', 1206);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (218, 'Colleen', 'von Sydow', 'colleen.vonsydow@bowman.jp', 1207);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (219, 'Crispin', 'Gallant', 'cgallant@ksj.com', 1208);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (220, 'Geena', 'Tobolowsky', 'geenat@parker.com', 1209);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (221, 'Lydia', 'Child', 'lydia@fetchlogistics.li', 1210);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (222, 'Claude', 'Porter', 'claudep@abatix.au', 1211);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (223, 'Spike', 'Hutch', 'spike.hutch@supplycorecom.be', 1212);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (224, 'Rhea', 'Schiff', 'rhea.schiff@ultimus.com', 1213);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (225, 'Vertical', 'Payne', 'vertical.payne@ghrsystems.es', 1214);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (226, 'Hilary', 'Kennedy', 'hkennedy@pragmatechsoftware.co', 1215);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (227, 'Vin', 'Levy', 'vlevy@prahs.com', 1216);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (228, 'Mekhi', 'Peet', 'mekhi.peet@cooktek.ch', 1217);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (229, 'Jeffery', 'D''Onofrio', 'jeffery.donofrio@granitesystem', 1218);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (230, 'Marisa', 'Statham', 'marisa.s@mcdonalds.de', 1219);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (231, 'Natalie', 'Reilly', 'natalie.reilly@trx.be', 1220);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (232, 'David', 'Kirshner', 'david.kirshner@acsis.com', 1221);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (233, 'Liquid', 'Mandrell', 'liquid.mandrell@trm.com', 1222);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (234, 'Gaby', 'Willis', 'gwillis@yes.com', 1223);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (235, 'Phil', 'MacPherson', 'p.macpherson@reckittbenckiser.', 1224);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (236, 'Etta', 'Stone', 'ettas@ccb.dk', 1225);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (237, 'Dianne', 'Astin', 'd.astin@fmi.id', 1226);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (238, 'Darius', 'Perry', 'darius.p@bestever.com', 1227);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (239, 'Stellan', 'Epps', 's.epps@gltg.com', 1228);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (240, 'Anthony', 'Palminteri', 'anthony@usenergyservices.com', 1229);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (241, 'Rebeka', 'Wills', 'rebeka.wills@unilever.com', 1230);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (242, 'Corey', 'Snow', 'corey@ivorysystems.com', 1231);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (243, 'Robin', 'Domino', 'robind@fnb.fi', 1232);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (244, 'Kelly', 'Davidtz', 'kelly.d@lynksystems.com', 1233);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (245, 'Willem', 'Stewart', 'willem.s@campbellsoup.ca', 1234);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (246, 'Kathy', 'Cassel', 'kathy.cassel@safehomesecurity.', 1235);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (247, 'Philip', 'Domino', 'philip.domino@marketfirst.com', 1236);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (248, 'Boyd', 'Streep', 'boyd.streep@ppr.ch', 1237);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (249, 'Rosanna', 'Ermey', 'rermey@irissoftware.com', 1238);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (250, 'Liev', 'Hampton', 'liev.hampton@anheuserbusch.uk', 1239);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (251, 'Cate', 'Ratzenberger', 'cratzenberger@limitedbrands.il', 1240);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (252, 'Bridget', 'Jovovich', 'bridget.jovovich@qas.za', 1241);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (253, 'Madeleine', 'Salt', 'madeleines@hewlettpackard.com', 1242);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (254, 'Bette', 'Nelson', 'bette@owm.be', 1243);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (255, 'Frankie', 'Kier', 'f.kier@spectrum.com', 1244);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (256, 'Ike', 'O''Neal', 'ike.o@operationaltechnologies.', 1245);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (257, 'Winona', 'Goodall', 'winona.goodall@gsat.com', 1246);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (258, 'Bret', 'Hector', 'bret@elitemedical.com', 1247);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (259, 'Gina', 'Hong', 'gina.hong@gapinc.com', 1248);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (260, 'Colleen', 'Howard', 'c.howard@morganresearch.de', 1249);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (261, 'Jack', 'Kleinenberg', 'jackk@at.com', 1250);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (262, 'Jonatha', 'Gallant', 'jonatha.gallant@gillani.de', 1251);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (263, 'Shelby', 'Langella', 's.langella@nlx.com', 1252);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (264, 'Judd', 'Anderson', 'judd.anderson@toyotamotor.no', 1253);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (265, 'Lindsey', 'Holm', 'lindsey.h@commworks.jp', 1254);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (266, 'Amanda', 'Heslov', 'amanda.heslov@topicsentertainm', 1255);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (267, 'Emily', 'Cherry', 'emily.cherry@accurateautobody.', 1256);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (268, 'Bill', 'DeLuise', 'bill.d@newhorizons.br', 1257);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (269, 'Jonatha', 'Steagall', 'jonatha.s@zoneperfectnutrition', 1258);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (270, 'Howie', 'Davidson', 'howie.davidson@progressivedesi', 1259);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (271, 'Vincent', 'Root', 'vincent.root@surmodics.com', 1260);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (272, 'Famke', 'Sarsgaard', 'famke.sarsgaard@adeasolutions.', 1261);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (273, 'Jake', 'Larter', 'jake.larter@officedepot.de', 1262);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (274, 'Hilton', 'Affleck', 'hilton.affleck@intel.ca', 1263);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (275, 'Reese', 'Wincott', 'rwincott@wellsfinancial.de', 1264);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (276, 'Patty', 'Reilly', 'preilly@heritagemicrofilm.au', 1265);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (277, 'Maureen', 'Dillon', 'maureen.dillon@authoria.ch', 1266);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (278, 'Sinead', 'Thompson', 'sinead@smg.uk', 1267);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (279, 'Oliver', 'Wilder', 'oliver.wilder@nexxtworks.com', 1268);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (280, 'Carlene', 'Carmen', 'c.carmen@timberlanewoodcrafter', 1269);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (281, 'LeVar', 'Braugher', 'levarb@lms.se', 1270);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (282, 'Pamela', 'Smurfit', 'pamela.smurfit@larkinenterpris', 1271);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (283, 'Naomi', 'Berenger', 'naomib@mindworks.nz', 1272);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (284, 'Liam', 'Savage', 'liam.savage@tigris.jp', 1273);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (285, 'Powers', 'Allison', 'p.allison@dearbornbancorp.com', 1274);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (286, 'Jeremy', 'Solido', 'jeremy.solido@newtoninteractiv', 1275);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (287, 'Larnelle', 'Greene', 'larnelle.greene@scheringplough', 1276);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (288, 'Frankie', 'Rivers', 'frankie@ogi.at', 1277);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (289, 'Sharon', 'Jordan', 's.jordan@netnumina.com', 1278);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (290, 'Anna', 'Weaver', 'anna.w@procter.com', 1279);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (291, 'Tamala', 'Reiner', 'tamala.reiner@tastefullysimple', 1280);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (292, 'Carla', 'Hanks', 'carla@dell.lt', 1281);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (293, 'Marisa', 'Springfield', 'marisa.springfield@lms.com', 1282);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (294, 'Alana', 'Bryson', 'alana@oss.nl', 1283);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (295, 'Stephen', 'Richardson', 'stephen.richardson@trx.jp', 1284);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (296, 'Donal', 'Charles', 'donal.charles@unit.hk', 1285);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (297, 'Larry', 'Lawrence', 'larry.lawrence@ssi.com', 1286);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (298, 'Taryn', 'Diddley', 'taryn.diddley@ptg.se', 1287);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (299, 'Rhys', 'Hersh', 'rhys.hersh@zaiqtechnologies.ar', 1288);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (300, 'Leelee', 'Purefoy', 'lpurefoy@fflcbancorp.ch', 1289);
commit;
prompt 300 records committed...
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (301, 'Veruca', 'Griffiths', 'veruca.griffiths@berkshirehath', 1290);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (302, 'Angie', 'Chung', 'angie.chung@envisiontelephony.', 1291);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (303, 'Madeleine', 'Richardson', 'madeleine.richardson@portageen', 1292);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (304, 'Micky', 'Gyllenhaal', 'mgyllenhaal@apexsystems.ca', 1293);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (305, 'Arturo', 'Milsap', 'arturo.milsap@qestrel.com', 1294);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (306, 'Eric', 'Presley', 'eric.presley@kiamotors.com', 1295);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (307, 'Katrin', 'Knight', 'katrin.knight@spinnakerexplora', 1296);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (308, 'Lou', 'Farrow', 'lou@kelmooreinvestment.at', 1297);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (309, 'Charlize', 'Soul', 'charlize.soul@entelligence.fr', 1298);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (310, 'Rodney', 'Biel', 'rodney.biel@zoneperfectnutriti', 1299);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (311, 'Mel', 'Orlando', 'mel.o@healthscribe.com', 1300);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (312, 'Kristin', 'Dalley', 'kristin.dalley@kingston.de', 1301);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (313, 'Kim', 'Olyphant', 'kim.olyphant@its.com', 1302);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (314, 'Nina', 'Cantrell', 'nina.cantrell@johnkeeler.com', 1303);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (315, 'Freda', 'McCabe', 'freda.mccabe@manhattanassociat', 1304);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (316, 'Shannyn', 'McBride', 'smcbride@atlanticcredit.com', 1305);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (317, 'Cary', 'Hannah', 'cary.hannah@mathis.com', 1306);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (318, 'Pam', 'Drive', 'pam@mwh.com', 1307);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (319, 'Adrien', 'Lipnicki', 'adrien.l@telecheminternational', 1308);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (320, 'Debbie', 'Parsons', 'd.parsons@investmentscorecard.', 1309);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (321, 'Burt', 'Price', 'burt.price@enterprise.com', 1310);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (322, 'Clea', 'Morrison', 'clea.morrison@loreal.com', 1311);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (323, 'Rene', 'Gibbons', 'rene.gibbons@prosum.com', 1312);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (324, 'Mae', 'Playboys', 'mae.playboys@gagwear.com', 1313);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (325, 'Chris', 'Carr', 'chris.c@hiltonhotels.com', 1314);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (326, 'Keith', 'Haynes', 'keith.haynes@taycorfinancial.u', 1315);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (327, 'Dianne', 'Platt', 'dianne@aquascapedesigns.it', 1316);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (328, 'Kimberly', 'Ferrell', 'kimberly.ferrell@connected.nl', 1317);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (329, 'Thin', 'Ojeda', 'thin.o@flavorx.ch', 1318);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (330, 'Catherine', 'Mars', 'catherine.mars@limitedbrands.c', 1319);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (331, 'Lila', 'Hershey', 'l.hershey@wyeth.de', 1320);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (332, 'Geoff', 'Howard', 'geoff.howard@cmi.com', 1321);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (333, 'Will', 'Preston', 'will@generalmills.com', 1322);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (334, 'Vanessa', 'Cara', 'vanessac@base.it', 1323);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (335, 'Tracy', 'Walken', 'tracy.walken@yumbrands.jp', 1324);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (336, 'Donald', 'Berkeley', 'donald@sds.it', 1325);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (337, 'Ron', 'Tate', 'ron.tate@abatix.com', 1326);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (338, 'Chant×™', 'Dempsey', 'chant.d@commworks.com', 1327);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (339, 'Steve', 'Reilly', 'steve.reilly@terrafirma.com', 1328);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (340, 'Danny', 'Haggard', 'danny@ach.no', 1329);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (341, 'Ted', 'Olyphant', 'ted.olyphant@jma.com', 1330);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (342, 'Sara', 'Mahood', 'sara@montpelierplastics.uk', 1331);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (343, 'Kevn', 'Gano', 'kevn.gano@scheringplough.com', 1332);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (344, 'Michael', 'White', 'mwhite@unit.com', 1333);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (345, 'Rosanne', 'Overstreet', 'r.overstreet@onesourceprinting', 1334);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (346, 'Kevn', 'Galecki', 'kevn.g@teoco.cy', 1335);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (347, 'Jann', 'Cornell', 'jann@staffforce.uk', 1336);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (348, 'Crystal', 'Harris', 'crystalh@aoe.ca', 1337);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (349, 'Liam', 'Nolte', 'liam.nolte@nuinfosystems.dk', 1338);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (350, 'Tara', 'McDowall', 'tara.mcdowall@ris.fr', 1339);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (351, 'Hector', 'Spader', 'hector.s@ezecastlesoftware.uk', 1340);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (352, 'Kiefer', 'Firth', 'kiefer.firth@hondamotor.jp', 1341);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (353, 'Gena', 'Sellers', 'gena.s@firstsouthbancorp.de', 1342);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (354, 'Rita', 'Church', 'r.church@johnkeeler.com', 1343);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (355, 'Louise', 'Portman', 'louise.portman@oriservices.com', 1344);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (356, 'Glenn', 'Kershaw', 'glenn.kershaw@diamondtechnolog', 1345);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (357, 'Emilio', 'Coltrane', 'emilio.coltrane@consultants.nl', 1346);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (358, 'Charles', 'Patillo', 'charles@hcoa.com', 1347);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (359, 'Marianne', 'Devine', 'marianne.devine@fmi.com', 1348);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (360, 'Rosie', 'McDiarmid', 'r.mcdiarmid@bigyanksports.ch', 1349);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (361, 'Kyle', 'Bridges', 'kyle.bridges@infinity.com', 1350);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (362, 'Noah', 'Purefoy', 'noah.purefoy@pioneermortgage.c', 1351);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (363, 'Nicole', 'Shocked', 'nicole.shocked@kimberlyclark.d', 1352);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (364, 'Janeane', 'Spine', 'jspine@ungertechnologies.de', 1353);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (365, 'France', 'Jones', 'france.jones@kelmooreinvestmen', 1354);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (366, 'Irene', 'Clark', 'irene.clark@mag.com', 1355);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (367, 'Noah', 'McGovern', 'nmcgovern@grayhawksystems.de', 1356);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (368, 'Jimmie', 'Oldman', 'jimmie@pis.com', 1357);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (369, 'Maggie', 'Iglesias', 'maggie.iglesias@efcbancorp.com', 1358);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (370, 'Jean', 'Carrack', 'jean.carrack@kingland.com', 1359);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (371, 'Russell', 'Dillane', 'russell.dillane@aristotle.com', 1360);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (372, 'Cledus', 'Squier', 'cledus.squier@morganresearch.c', 1361);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (373, 'Elle', 'Laws', 'elle.laws@sears.de', 1362);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (374, 'Kyle', 'Hannah', 'khannah@cardtronics.com', 1363);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (375, 'Richard', 'Finn', 'r.finn@mitsubishimotors.com', 1364);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (376, 'Tori', 'Farris', 'tori.farris@trx.ar', 1365);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (377, 'Alex', 'Stiller', 'a.stiller@interfacesoftware.nl', 1366);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (378, 'Philip', 'Whitmore', 'philip.whitmore@gulfmarkoffsho', 1367);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (379, 'Harold', 'Hopkins', 'harold@meghasystems.com', 1368);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (380, 'Steve', 'Gray', 'steve.gray@eagleone.com', 1369);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (381, 'Mika', 'Hersh', 'mika.hersh@bigyanksports.nz', 1370);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (382, 'Ahmad', 'Melvin', 'ahmadm@diageo.jp', 1371);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (383, 'Kevin', 'Gates', 'keving@servicesource.it', 1372);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (384, 'Hilary', 'Rickman', 'hilary.rickman@qls.de', 1373);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (385, 'Ahmad', 'Caldwell', 'ahmad.caldwell@dillards.com', 1374);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (386, 'Adam', 'Alda', 'adam.a@gna.uk', 1375);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (387, 'Doug', 'Creek', 'doug.creek@profitline.jp', 1376);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (388, 'Randall', 'Aglukark', 'randall.a@canterburypark.jp', 1377);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (389, 'Armand', 'Sedgwick', 'armand.sedgwick@knightsbridge.', 1378);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (390, 'Buddy', 'Dickinson', 'buddy.dickinson@sci.com', 1379);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (391, 'Lupe', 'Byrne', 'lupe.byrne@investmentscorecard', 1380);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (392, 'Debra', 'Dourif', 'ddourif@monitronicsinternation', 1381);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (393, 'Ronny', 'Shearer', 'ronny.shearer@genextechnologie', 1382);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (394, 'Jimmie', 'Davidtz', 'jimmie.d@linacsystems.uk', 1383);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (395, 'Mia', 'Lane', 'mia.lane@logisticare.pl', 1384);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (396, 'Franz', 'Griffith', 'franz.griffith@portageenvironm', 1385);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (397, 'Ruth', 'Russell', 'ruth.r@swp.tr', 1386);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (398, 'Cliff', 'Davidson', 'cdavidson@credopetroleum.com', 1387);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (399, 'Alicia', 'Conway', 'alicia.conway@timevision.de', 1388);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (400, 'Annie', 'Brooke', 'annie.brooke@astute.ar', 1389);
commit;
prompt 400 records committed...
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (401, 'Billy', 'Arden', 'billy.arden@uem.com', 1390);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (402, 'Tcheky', 'Gilley', 'tgilley@team.com', 1391);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (403, 'Juliet', 'Ferry', 'juliet.ferry@newhorizons.uk', 1392);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (404, 'Elvis', 'Mahoney', 'elvis@pioneerdatasystems.be', 1393);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (405, 'Alicia', 'Nash', 'anash@bestever.com', 1394);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (406, 'Lea', 'Fonda', 'lea.fonda@dearbornbancorp.ca', 1395);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (407, 'Tal', 'Shorter', 't.shorter@pinnaclestaffing.com', 1396);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (408, 'Bebe', 'Pressly', 'bebe.pressly@usdairyproducers.', 1397);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (409, 'Harrison', 'Bradford', 'harrison.b@astafunding.it', 1398);
insert into PARTICIPANTS (participantid, firstname, lastname, email, clubmember)
values (410, 'Randy', 'Clarkson', 'randy.clarkson@supplycorecom.c', 1399);
commit;
prompt 410 records loaded
prompt Loading MAKEORDER...
insert into MAKEORDER (participantid, orderid)
values (1, 1);
insert into MAKEORDER (participantid, orderid)
values (2, 2);
insert into MAKEORDER (participantid, orderid)
values (3, 3);
insert into MAKEORDER (participantid, orderid)
values (4, 4);
insert into MAKEORDER (participantid, orderid)
values (5, 5);
insert into MAKEORDER (participantid, orderid)
values (6, 6);
insert into MAKEORDER (participantid, orderid)
values (7, 7);
insert into MAKEORDER (participantid, orderid)
values (8, 8);
insert into MAKEORDER (participantid, orderid)
values (9, 9);
insert into MAKEORDER (participantid, orderid)
values (10, 10);
insert into MAKEORDER (participantid, orderid)
values (12, 215);
insert into MAKEORDER (participantid, orderid)
values (13, 76);
insert into MAKEORDER (participantid, orderid)
values (13, 128);
insert into MAKEORDER (participantid, orderid)
values (13, 181);
insert into MAKEORDER (participantid, orderid)
values (13, 268);
insert into MAKEORDER (participantid, orderid)
values (14, 376);
insert into MAKEORDER (participantid, orderid)
values (15, 281);
insert into MAKEORDER (participantid, orderid)
values (16, 80);
insert into MAKEORDER (participantid, orderid)
values (17, 35);
insert into MAKEORDER (participantid, orderid)
values (17, 89);
insert into MAKEORDER (participantid, orderid)
values (17, 112);
insert into MAKEORDER (participantid, orderid)
values (17, 311);
insert into MAKEORDER (participantid, orderid)
values (17, 409);
insert into MAKEORDER (participantid, orderid)
values (18, 75);
insert into MAKEORDER (participantid, orderid)
values (21, 162);
insert into MAKEORDER (participantid, orderid)
values (21, 233);
insert into MAKEORDER (participantid, orderid)
values (22, 185);
insert into MAKEORDER (participantid, orderid)
values (23, 226);
insert into MAKEORDER (participantid, orderid)
values (23, 231);
insert into MAKEORDER (participantid, orderid)
values (23, 270);
insert into MAKEORDER (participantid, orderid)
values (24, 139);
insert into MAKEORDER (participantid, orderid)
values (25, 73);
insert into MAKEORDER (participantid, orderid)
values (26, 55);
insert into MAKEORDER (participantid, orderid)
values (27, 225);
insert into MAKEORDER (participantid, orderid)
values (28, 108);
insert into MAKEORDER (participantid, orderid)
values (28, 185);
insert into MAKEORDER (participantid, orderid)
values (28, 371);
insert into MAKEORDER (participantid, orderid)
values (29, 242);
insert into MAKEORDER (participantid, orderid)
values (29, 338);
insert into MAKEORDER (participantid, orderid)
values (30, 96);
insert into MAKEORDER (participantid, orderid)
values (30, 215);
insert into MAKEORDER (participantid, orderid)
values (31, 15);
insert into MAKEORDER (participantid, orderid)
values (32, 376);
insert into MAKEORDER (participantid, orderid)
values (37, 132);
insert into MAKEORDER (participantid, orderid)
values (40, 82);
insert into MAKEORDER (participantid, orderid)
values (41, 244);
insert into MAKEORDER (participantid, orderid)
values (42, 136);
insert into MAKEORDER (participantid, orderid)
values (44, 351);
insert into MAKEORDER (participantid, orderid)
values (45, 19);
insert into MAKEORDER (participantid, orderid)
values (45, 81);
insert into MAKEORDER (participantid, orderid)
values (51, 339);
insert into MAKEORDER (participantid, orderid)
values (52, 11);
insert into MAKEORDER (participantid, orderid)
values (52, 235);
insert into MAKEORDER (participantid, orderid)
values (53, 116);
insert into MAKEORDER (participantid, orderid)
values (54, 40);
insert into MAKEORDER (participantid, orderid)
values (57, 30);
insert into MAKEORDER (participantid, orderid)
values (57, 87);
insert into MAKEORDER (participantid, orderid)
values (57, 286);
insert into MAKEORDER (participantid, orderid)
values (59, 124);
insert into MAKEORDER (participantid, orderid)
values (59, 403);
insert into MAKEORDER (participantid, orderid)
values (61, 405);
insert into MAKEORDER (participantid, orderid)
values (62, 116);
insert into MAKEORDER (participantid, orderid)
values (62, 241);
insert into MAKEORDER (participantid, orderid)
values (63, 108);
insert into MAKEORDER (participantid, orderid)
values (63, 197);
insert into MAKEORDER (participantid, orderid)
values (64, 336);
insert into MAKEORDER (participantid, orderid)
values (66, 271);
insert into MAKEORDER (participantid, orderid)
values (66, 322);
insert into MAKEORDER (participantid, orderid)
values (67, 254);
insert into MAKEORDER (participantid, orderid)
values (68, 352);
insert into MAKEORDER (participantid, orderid)
values (70, 70);
insert into MAKEORDER (participantid, orderid)
values (71, 257);
insert into MAKEORDER (participantid, orderid)
values (72, 177);
insert into MAKEORDER (participantid, orderid)
values (72, 333);
insert into MAKEORDER (participantid, orderid)
values (74, 358);
insert into MAKEORDER (participantid, orderid)
values (77, 111);
insert into MAKEORDER (participantid, orderid)
values (77, 394);
insert into MAKEORDER (participantid, orderid)
values (78, 49);
insert into MAKEORDER (participantid, orderid)
values (79, 179);
insert into MAKEORDER (participantid, orderid)
values (79, 219);
insert into MAKEORDER (participantid, orderid)
values (81, 409);
insert into MAKEORDER (participantid, orderid)
values (82, 146);
insert into MAKEORDER (participantid, orderid)
values (82, 234);
insert into MAKEORDER (participantid, orderid)
values (85, 238);
insert into MAKEORDER (participantid, orderid)
values (86, 54);
insert into MAKEORDER (participantid, orderid)
values (86, 59);
insert into MAKEORDER (participantid, orderid)
values (86, 321);
insert into MAKEORDER (participantid, orderid)
values (89, 301);
insert into MAKEORDER (participantid, orderid)
values (90, 324);
insert into MAKEORDER (participantid, orderid)
values (90, 375);
insert into MAKEORDER (participantid, orderid)
values (91, 87);
insert into MAKEORDER (participantid, orderid)
values (91, 346);
insert into MAKEORDER (participantid, orderid)
values (93, 383);
insert into MAKEORDER (participantid, orderid)
values (95, 72);
insert into MAKEORDER (participantid, orderid)
values (96, 132);
insert into MAKEORDER (participantid, orderid)
values (96, 212);
insert into MAKEORDER (participantid, orderid)
values (99, 154);
insert into MAKEORDER (participantid, orderid)
values (100, 228);
insert into MAKEORDER (participantid, orderid)
values (104, 148);
insert into MAKEORDER (participantid, orderid)
values (106, 210);
commit;
prompt 100 records committed...
insert into MAKEORDER (participantid, orderid)
values (107, 101);
insert into MAKEORDER (participantid, orderid)
values (107, 195);
insert into MAKEORDER (participantid, orderid)
values (107, 294);
insert into MAKEORDER (participantid, orderid)
values (109, 138);
insert into MAKEORDER (participantid, orderid)
values (112, 151);
insert into MAKEORDER (participantid, orderid)
values (112, 180);
insert into MAKEORDER (participantid, orderid)
values (112, 209);
insert into MAKEORDER (participantid, orderid)
values (112, 361);
insert into MAKEORDER (participantid, orderid)
values (113, 50);
insert into MAKEORDER (participantid, orderid)
values (113, 87);
insert into MAKEORDER (participantid, orderid)
values (113, 390);
insert into MAKEORDER (participantid, orderid)
values (114, 278);
insert into MAKEORDER (participantid, orderid)
values (115, 13);
insert into MAKEORDER (participantid, orderid)
values (115, 228);
insert into MAKEORDER (participantid, orderid)
values (119, 19);
insert into MAKEORDER (participantid, orderid)
values (119, 371);
insert into MAKEORDER (participantid, orderid)
values (120, 269);
insert into MAKEORDER (participantid, orderid)
values (121, 239);
insert into MAKEORDER (participantid, orderid)
values (121, 260);
insert into MAKEORDER (participantid, orderid)
values (122, 78);
insert into MAKEORDER (participantid, orderid)
values (122, 189);
insert into MAKEORDER (participantid, orderid)
values (122, 244);
insert into MAKEORDER (participantid, orderid)
values (123, 361);
insert into MAKEORDER (participantid, orderid)
values (124, 62);
insert into MAKEORDER (participantid, orderid)
values (126, 189);
insert into MAKEORDER (participantid, orderid)
values (128, 308);
insert into MAKEORDER (participantid, orderid)
values (129, 132);
insert into MAKEORDER (participantid, orderid)
values (129, 369);
insert into MAKEORDER (participantid, orderid)
values (131, 84);
insert into MAKEORDER (participantid, orderid)
values (131, 362);
insert into MAKEORDER (participantid, orderid)
values (133, 274);
insert into MAKEORDER (participantid, orderid)
values (133, 361);
insert into MAKEORDER (participantid, orderid)
values (136, 59);
insert into MAKEORDER (participantid, orderid)
values (137, 333);
insert into MAKEORDER (participantid, orderid)
values (137, 408);
insert into MAKEORDER (participantid, orderid)
values (138, 90);
insert into MAKEORDER (participantid, orderid)
values (140, 78);
insert into MAKEORDER (participantid, orderid)
values (140, 114);
insert into MAKEORDER (participantid, orderid)
values (141, 130);
insert into MAKEORDER (participantid, orderid)
values (141, 169);
insert into MAKEORDER (participantid, orderid)
values (141, 276);
insert into MAKEORDER (participantid, orderid)
values (142, 215);
insert into MAKEORDER (participantid, orderid)
values (142, 238);
insert into MAKEORDER (participantid, orderid)
values (142, 365);
insert into MAKEORDER (participantid, orderid)
values (144, 253);
insert into MAKEORDER (participantid, orderid)
values (146, 243);
insert into MAKEORDER (participantid, orderid)
values (147, 186);
insert into MAKEORDER (participantid, orderid)
values (148, 266);
insert into MAKEORDER (participantid, orderid)
values (149, 42);
insert into MAKEORDER (participantid, orderid)
values (149, 59);
insert into MAKEORDER (participantid, orderid)
values (149, 371);
insert into MAKEORDER (participantid, orderid)
values (150, 78);
insert into MAKEORDER (participantid, orderid)
values (150, 123);
insert into MAKEORDER (participantid, orderid)
values (150, 280);
insert into MAKEORDER (participantid, orderid)
values (152, 344);
insert into MAKEORDER (participantid, orderid)
values (153, 201);
insert into MAKEORDER (participantid, orderid)
values (155, 83);
insert into MAKEORDER (participantid, orderid)
values (155, 110);
insert into MAKEORDER (participantid, orderid)
values (156, 36);
insert into MAKEORDER (participantid, orderid)
values (158, 329);
insert into MAKEORDER (participantid, orderid)
values (159, 158);
insert into MAKEORDER (participantid, orderid)
values (160, 332);
insert into MAKEORDER (participantid, orderid)
values (162, 114);
insert into MAKEORDER (participantid, orderid)
values (164, 144);
insert into MAKEORDER (participantid, orderid)
values (164, 336);
insert into MAKEORDER (participantid, orderid)
values (166, 271);
insert into MAKEORDER (participantid, orderid)
values (167, 41);
insert into MAKEORDER (participantid, orderid)
values (167, 292);
insert into MAKEORDER (participantid, orderid)
values (167, 346);
insert into MAKEORDER (participantid, orderid)
values (168, 196);
insert into MAKEORDER (participantid, orderid)
values (168, 280);
insert into MAKEORDER (participantid, orderid)
values (169, 181);
insert into MAKEORDER (participantid, orderid)
values (169, 292);
insert into MAKEORDER (participantid, orderid)
values (169, 377);
insert into MAKEORDER (participantid, orderid)
values (170, 50);
insert into MAKEORDER (participantid, orderid)
values (172, 273);
insert into MAKEORDER (participantid, orderid)
values (174, 145);
insert into MAKEORDER (participantid, orderid)
values (176, 312);
insert into MAKEORDER (participantid, orderid)
values (176, 379);
insert into MAKEORDER (participantid, orderid)
values (178, 136);
insert into MAKEORDER (participantid, orderid)
values (179, 233);
insert into MAKEORDER (participantid, orderid)
values (179, 239);
insert into MAKEORDER (participantid, orderid)
values (181, 83);
insert into MAKEORDER (participantid, orderid)
values (181, 303);
insert into MAKEORDER (participantid, orderid)
values (182, 305);
insert into MAKEORDER (participantid, orderid)
values (183, 83);
insert into MAKEORDER (participantid, orderid)
values (185, 189);
insert into MAKEORDER (participantid, orderid)
values (187, 263);
insert into MAKEORDER (participantid, orderid)
values (187, 399);
insert into MAKEORDER (participantid, orderid)
values (190, 196);
insert into MAKEORDER (participantid, orderid)
values (193, 119);
insert into MAKEORDER (participantid, orderid)
values (193, 255);
insert into MAKEORDER (participantid, orderid)
values (196, 150);
insert into MAKEORDER (participantid, orderid)
values (197, 121);
insert into MAKEORDER (participantid, orderid)
values (201, 75);
insert into MAKEORDER (participantid, orderid)
values (202, 373);
insert into MAKEORDER (participantid, orderid)
values (203, 14);
insert into MAKEORDER (participantid, orderid)
values (203, 408);
insert into MAKEORDER (participantid, orderid)
values (206, 376);
insert into MAKEORDER (participantid, orderid)
values (208, 373);
commit;
prompt 200 records committed...
insert into MAKEORDER (participantid, orderid)
values (209, 62);
insert into MAKEORDER (participantid, orderid)
values (209, 241);
insert into MAKEORDER (participantid, orderid)
values (210, 203);
insert into MAKEORDER (participantid, orderid)
values (210, 376);
insert into MAKEORDER (participantid, orderid)
values (211, 19);
insert into MAKEORDER (participantid, orderid)
values (211, 224);
insert into MAKEORDER (participantid, orderid)
values (211, 379);
insert into MAKEORDER (participantid, orderid)
values (212, 37);
insert into MAKEORDER (participantid, orderid)
values (212, 338);
insert into MAKEORDER (participantid, orderid)
values (213, 101);
insert into MAKEORDER (participantid, orderid)
values (213, 307);
insert into MAKEORDER (participantid, orderid)
values (214, 376);
insert into MAKEORDER (participantid, orderid)
values (215, 227);
insert into MAKEORDER (participantid, orderid)
values (215, 290);
insert into MAKEORDER (participantid, orderid)
values (216, 161);
insert into MAKEORDER (participantid, orderid)
values (217, 124);
insert into MAKEORDER (participantid, orderid)
values (218, 212);
insert into MAKEORDER (participantid, orderid)
values (218, 328);
insert into MAKEORDER (participantid, orderid)
values (219, 97);
insert into MAKEORDER (participantid, orderid)
values (220, 307);
insert into MAKEORDER (participantid, orderid)
values (221, 74);
insert into MAKEORDER (participantid, orderid)
values (223, 15);
insert into MAKEORDER (participantid, orderid)
values (224, 127);
insert into MAKEORDER (participantid, orderid)
values (224, 146);
insert into MAKEORDER (participantid, orderid)
values (225, 31);
insert into MAKEORDER (participantid, orderid)
values (225, 69);
insert into MAKEORDER (participantid, orderid)
values (226, 115);
insert into MAKEORDER (participantid, orderid)
values (226, 319);
insert into MAKEORDER (participantid, orderid)
values (226, 364);
insert into MAKEORDER (participantid, orderid)
values (228, 166);
insert into MAKEORDER (participantid, orderid)
values (228, 261);
insert into MAKEORDER (participantid, orderid)
values (232, 205);
insert into MAKEORDER (participantid, orderid)
values (233, 90);
insert into MAKEORDER (participantid, orderid)
values (233, 146);
insert into MAKEORDER (participantid, orderid)
values (234, 128);
insert into MAKEORDER (participantid, orderid)
values (239, 42);
insert into MAKEORDER (participantid, orderid)
values (239, 277);
insert into MAKEORDER (participantid, orderid)
values (240, 304);
insert into MAKEORDER (participantid, orderid)
values (241, 336);
insert into MAKEORDER (participantid, orderid)
values (243, 291);
insert into MAKEORDER (participantid, orderid)
values (244, 94);
insert into MAKEORDER (participantid, orderid)
values (245, 220);
insert into MAKEORDER (participantid, orderid)
values (246, 370);
insert into MAKEORDER (participantid, orderid)
values (247, 284);
insert into MAKEORDER (participantid, orderid)
values (249, 14);
insert into MAKEORDER (participantid, orderid)
values (251, 39);
insert into MAKEORDER (participantid, orderid)
values (252, 188);
insert into MAKEORDER (participantid, orderid)
values (253, 356);
insert into MAKEORDER (participantid, orderid)
values (258, 196);
insert into MAKEORDER (participantid, orderid)
values (258, 240);
insert into MAKEORDER (participantid, orderid)
values (259, 266);
insert into MAKEORDER (participantid, orderid)
values (260, 99);
insert into MAKEORDER (participantid, orderid)
values (260, 210);
insert into MAKEORDER (participantid, orderid)
values (260, 269);
insert into MAKEORDER (participantid, orderid)
values (261, 95);
insert into MAKEORDER (participantid, orderid)
values (262, 175);
insert into MAKEORDER (participantid, orderid)
values (262, 281);
insert into MAKEORDER (participantid, orderid)
values (266, 270);
insert into MAKEORDER (participantid, orderid)
values (267, 107);
insert into MAKEORDER (participantid, orderid)
values (269, 242);
insert into MAKEORDER (participantid, orderid)
values (269, 286);
insert into MAKEORDER (participantid, orderid)
values (270, 340);
insert into MAKEORDER (participantid, orderid)
values (271, 90);
insert into MAKEORDER (participantid, orderid)
values (272, 69);
insert into MAKEORDER (participantid, orderid)
values (273, 57);
insert into MAKEORDER (participantid, orderid)
values (275, 117);
insert into MAKEORDER (participantid, orderid)
values (275, 225);
insert into MAKEORDER (participantid, orderid)
values (277, 69);
insert into MAKEORDER (participantid, orderid)
values (278, 329);
insert into MAKEORDER (participantid, orderid)
values (279, 64);
insert into MAKEORDER (participantid, orderid)
values (281, 50);
insert into MAKEORDER (participantid, orderid)
values (281, 301);
insert into MAKEORDER (participantid, orderid)
values (282, 195);
insert into MAKEORDER (participantid, orderid)
values (282, 205);
insert into MAKEORDER (participantid, orderid)
values (282, 364);
insert into MAKEORDER (participantid, orderid)
values (286, 191);
insert into MAKEORDER (participantid, orderid)
values (287, 54);
insert into MAKEORDER (participantid, orderid)
values (287, 252);
insert into MAKEORDER (participantid, orderid)
values (289, 142);
insert into MAKEORDER (participantid, orderid)
values (290, 74);
insert into MAKEORDER (participantid, orderid)
values (291, 391);
insert into MAKEORDER (participantid, orderid)
values (292, 13);
insert into MAKEORDER (participantid, orderid)
values (292, 62);
insert into MAKEORDER (participantid, orderid)
values (293, 198);
insert into MAKEORDER (participantid, orderid)
values (296, 87);
insert into MAKEORDER (participantid, orderid)
values (296, 296);
insert into MAKEORDER (participantid, orderid)
values (298, 174);
insert into MAKEORDER (participantid, orderid)
values (298, 303);
insert into MAKEORDER (participantid, orderid)
values (301, 252);
insert into MAKEORDER (participantid, orderid)
values (303, 81);
insert into MAKEORDER (participantid, orderid)
values (303, 404);
insert into MAKEORDER (participantid, orderid)
values (304, 49);
insert into MAKEORDER (participantid, orderid)
values (304, 373);
insert into MAKEORDER (participantid, orderid)
values (305, 42);
insert into MAKEORDER (participantid, orderid)
values (305, 43);
insert into MAKEORDER (participantid, orderid)
values (305, 130);
insert into MAKEORDER (participantid, orderid)
values (305, 172);
insert into MAKEORDER (participantid, orderid)
values (305, 290);
insert into MAKEORDER (participantid, orderid)
values (306, 245);
insert into MAKEORDER (participantid, orderid)
values (306, 308);
commit;
prompt 300 records committed...
insert into MAKEORDER (participantid, orderid)
values (307, 106);
insert into MAKEORDER (participantid, orderid)
values (307, 224);
insert into MAKEORDER (participantid, orderid)
values (308, 211);
insert into MAKEORDER (participantid, orderid)
values (308, 348);
insert into MAKEORDER (participantid, orderid)
values (309, 72);
insert into MAKEORDER (participantid, orderid)
values (309, 301);
insert into MAKEORDER (participantid, orderid)
values (310, 27);
insert into MAKEORDER (participantid, orderid)
values (310, 34);
insert into MAKEORDER (participantid, orderid)
values (310, 200);
insert into MAKEORDER (participantid, orderid)
values (311, 132);
insert into MAKEORDER (participantid, orderid)
values (312, 392);
insert into MAKEORDER (participantid, orderid)
values (312, 393);
insert into MAKEORDER (participantid, orderid)
values (315, 67);
insert into MAKEORDER (participantid, orderid)
values (315, 212);
insert into MAKEORDER (participantid, orderid)
values (316, 376);
insert into MAKEORDER (participantid, orderid)
values (318, 285);
insert into MAKEORDER (participantid, orderid)
values (319, 257);
insert into MAKEORDER (participantid, orderid)
values (320, 105);
insert into MAKEORDER (participantid, orderid)
values (321, 131);
insert into MAKEORDER (participantid, orderid)
values (322, 163);
insert into MAKEORDER (participantid, orderid)
values (322, 174);
insert into MAKEORDER (participantid, orderid)
values (322, 317);
insert into MAKEORDER (participantid, orderid)
values (325, 85);
insert into MAKEORDER (participantid, orderid)
values (325, 326);
insert into MAKEORDER (participantid, orderid)
values (326, 183);
insert into MAKEORDER (participantid, orderid)
values (327, 403);
insert into MAKEORDER (participantid, orderid)
values (330, 209);
insert into MAKEORDER (participantid, orderid)
values (337, 179);
insert into MAKEORDER (participantid, orderid)
values (338, 134);
insert into MAKEORDER (participantid, orderid)
values (338, 287);
insert into MAKEORDER (participantid, orderid)
values (339, 90);
insert into MAKEORDER (participantid, orderid)
values (340, 45);
insert into MAKEORDER (participantid, orderid)
values (341, 343);
insert into MAKEORDER (participantid, orderid)
values (343, 32);
insert into MAKEORDER (participantid, orderid)
values (343, 152);
insert into MAKEORDER (participantid, orderid)
values (343, 234);
insert into MAKEORDER (participantid, orderid)
values (343, 356);
insert into MAKEORDER (participantid, orderid)
values (344, 128);
insert into MAKEORDER (participantid, orderid)
values (344, 212);
insert into MAKEORDER (participantid, orderid)
values (345, 315);
insert into MAKEORDER (participantid, orderid)
values (346, 73);
insert into MAKEORDER (participantid, orderid)
values (346, 167);
insert into MAKEORDER (participantid, orderid)
values (346, 272);
insert into MAKEORDER (participantid, orderid)
values (346, 307);
insert into MAKEORDER (participantid, orderid)
values (348, 342);
insert into MAKEORDER (participantid, orderid)
values (351, 18);
insert into MAKEORDER (participantid, orderid)
values (351, 337);
insert into MAKEORDER (participantid, orderid)
values (353, 369);
insert into MAKEORDER (participantid, orderid)
values (354, 258);
insert into MAKEORDER (participantid, orderid)
values (355, 272);
insert into MAKEORDER (participantid, orderid)
values (358, 366);
insert into MAKEORDER (participantid, orderid)
values (359, 254);
insert into MAKEORDER (participantid, orderid)
values (359, 316);
insert into MAKEORDER (participantid, orderid)
values (360, 74);
insert into MAKEORDER (participantid, orderid)
values (360, 238);
insert into MAKEORDER (participantid, orderid)
values (360, 271);
insert into MAKEORDER (participantid, orderid)
values (360, 398);
insert into MAKEORDER (participantid, orderid)
values (360, 406);
insert into MAKEORDER (participantid, orderid)
values (361, 178);
insert into MAKEORDER (participantid, orderid)
values (361, 234);
insert into MAKEORDER (participantid, orderid)
values (361, 357);
insert into MAKEORDER (participantid, orderid)
values (362, 139);
insert into MAKEORDER (participantid, orderid)
values (363, 76);
insert into MAKEORDER (participantid, orderid)
values (363, 250);
insert into MAKEORDER (participantid, orderid)
values (363, 316);
insert into MAKEORDER (participantid, orderid)
values (364, 397);
insert into MAKEORDER (participantid, orderid)
values (365, 228);
insert into MAKEORDER (participantid, orderid)
values (365, 297);
insert into MAKEORDER (participantid, orderid)
values (366, 40);
insert into MAKEORDER (participantid, orderid)
values (368, 169);
insert into MAKEORDER (participantid, orderid)
values (368, 375);
insert into MAKEORDER (participantid, orderid)
values (369, 82);
insert into MAKEORDER (participantid, orderid)
values (369, 307);
insert into MAKEORDER (participantid, orderid)
values (371, 237);
insert into MAKEORDER (participantid, orderid)
values (371, 238);
insert into MAKEORDER (participantid, orderid)
values (375, 92);
insert into MAKEORDER (participantid, orderid)
values (375, 115);
insert into MAKEORDER (participantid, orderid)
values (376, 37);
insert into MAKEORDER (participantid, orderid)
values (376, 179);
insert into MAKEORDER (participantid, orderid)
values (378, 50);
insert into MAKEORDER (participantid, orderid)
values (378, 105);
insert into MAKEORDER (participantid, orderid)
values (378, 257);
insert into MAKEORDER (participantid, orderid)
values (378, 324);
insert into MAKEORDER (participantid, orderid)
values (379, 40);
insert into MAKEORDER (participantid, orderid)
values (379, 206);
insert into MAKEORDER (participantid, orderid)
values (382, 35);
insert into MAKEORDER (participantid, orderid)
values (382, 81);
insert into MAKEORDER (participantid, orderid)
values (382, 210);
insert into MAKEORDER (participantid, orderid)
values (383, 71);
insert into MAKEORDER (participantid, orderid)
values (383, 376);
insert into MAKEORDER (participantid, orderid)
values (385, 321);
insert into MAKEORDER (participantid, orderid)
values (386, 131);
insert into MAKEORDER (participantid, orderid)
values (386, 158);
insert into MAKEORDER (participantid, orderid)
values (387, 208);
insert into MAKEORDER (participantid, orderid)
values (387, 275);
insert into MAKEORDER (participantid, orderid)
values (389, 119);
insert into MAKEORDER (participantid, orderid)
values (389, 152);
insert into MAKEORDER (participantid, orderid)
values (394, 56);
insert into MAKEORDER (participantid, orderid)
values (394, 266);
insert into MAKEORDER (participantid, orderid)
values (394, 330);
commit;
prompt 400 records committed...
insert into MAKEORDER (participantid, orderid)
values (397, 185);
insert into MAKEORDER (participantid, orderid)
values (397, 278);
insert into MAKEORDER (participantid, orderid)
values (398, 128);
insert into MAKEORDER (participantid, orderid)
values (398, 158);
insert into MAKEORDER (participantid, orderid)
values (400, 49);
insert into MAKEORDER (participantid, orderid)
values (401, 393);
insert into MAKEORDER (participantid, orderid)
values (403, 153);
insert into MAKEORDER (participantid, orderid)
values (403, 343);
insert into MAKEORDER (participantid, orderid)
values (409, 330);
insert into MAKEORDER (participantid, orderid)
values (410, 130);
commit;
prompt 410 records loaded
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
values (1, 'John Doe', to_date('15-05-1980', 'dd-mm-yyyy'), 'Bachelor', '0541234567', 'Experienced', 1, 4000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (2, 'Jane Smith', to_date('20-10-1985', 'dd-mm-yyyy'), 'Master', '0542345678', 'Intermediate', 2, 3600);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (3, 'Alice Johnson', to_date('25-03-1990', 'dd-mm-yyyy'), 'Doctorate', '0543456789', 'Novice', 3, 1400);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (4, 'David Brown', to_date('30-08-1982', 'dd-mm-yyyy'), 'Bachelor', '0544567890', 'Experienced', 4, 3225);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (5, 'Sarah Lee', to_date('10-11-1987', 'dd-mm-yyyy'), 'Master', '0545678901', 'Intermediate', 5, 1065);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (6, 'Michael Wang', to_date('05-04-1992', 'dd-mm-yyyy'), 'Doctorate', '0546789012', 'Novice', 6, 1490);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (7, 'Emily Taylor', to_date('20-09-1984', 'dd-mm-yyyy'), 'Bachelor', '0547890123', 'Experienced', 7, 4000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (8, 'Andrew Wilson', to_date('15-12-1989', 'dd-mm-yyyy'), 'Master', '0548901234', 'Intermediate', 8, 2835);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (9, 'Olivia Martinez', to_date('01-01-1994', 'dd-mm-yyyy'), 'Doctorate', '0549012345', 'Novice', 9, 1490);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (10, 'Liam Garcia', to_date('10-06-1983', 'dd-mm-yyyy'), 'Bachelor', '0549123456', 'Experienced', 10, 1060);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (11, 'Ella Rodriguez', to_date('25-11-1988', 'dd-mm-yyyy'), 'Master', '0549234567', 'Intermediate', 11, 1920);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (12, 'Noah Hernandez', to_date('20-02-1993', 'dd-mm-yyyy'), 'Doctorate', '0549345678', 'Novice', 12, 2860);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (13, 'Emma Lopez', to_date('15-07-1981', 'dd-mm-yyyy'), 'Bachelor', '0549456789', 'Experienced', 13, 3000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (14, 'William Perez', to_date('30-12-1986', 'dd-mm-yyyy'), 'Master', '0549567890', 'Intermediate', 14, 900);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (15, 'Isabella Gonzales', to_date('05-05-1991', 'dd-mm-yyyy'), 'Doctorate', '0549678901', 'Novice', 15, 2100);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (16, 'James Wilson', to_date('20-10-1985', 'dd-mm-yyyy'), 'Bachelor', '0549789012', 'Experienced', 16, 2000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (17, 'Sophia Carter', to_date('15-03-1990', 'dd-mm-yyyy'), 'Master', '0549890123', 'Intermediate', 17, 900);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (18, 'Logan Evans', to_date('01-06-1995', 'dd-mm-yyyy'), 'Doctorate', '0549901234', 'Novice', 18, 2800);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (19, 'Mia Ramirez', to_date('10-11-1982', 'dd-mm-yyyy'), 'Bachelor', '0549912345', 'Experienced', 19, 2000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (20, 'Benjamin Foster', to_date('25-04-1987', 'dd-mm-yyyy'), 'Master', '0549923456', 'Intermediate', 20, 2700);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (21, 'Ava Flores', to_date('20-09-1992', 'dd-mm-yyyy'), 'Doctorate', '0549934567', 'Novice', 21, 1400);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (22, 'Aiden Gonzales', to_date('15-02-1980', 'dd-mm-yyyy'), 'Bachelor', '0549945678', 'Experienced', 22, 1000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (23, 'Charlotte Moore', to_date('30-07-1985', 'dd-mm-yyyy'), 'Master', '0549956789', 'Intermediate', 23, 3600);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (24, 'Lucas Coleman', to_date('15-12-1990', 'dd-mm-yyyy'), 'Doctorate', '0549967890', 'Novice', 24, 2100);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (25, 'Grace Washington', to_date('10-05-1984', 'dd-mm-yyyy'), 'Bachelor', '0549978901', 'Experienced', 25, 2000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (26, 'Ethan Butler', to_date('05-10-1989', 'dd-mm-yyyy'), 'Master', '0549989012', 'Intermediate', 26, 2700);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (27, 'Sofia Simmons', to_date('01-01-1994', 'dd-mm-yyyy'), 'Doctorate', '0549990123', 'Novice', 27, 2800);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (28, 'Lucas Gonzalez', to_date('10-06-1981', 'dd-mm-yyyy'), 'Bachelor', '0550001234', 'Experienced', 28, 2000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (29, 'Lily Russell', to_date('25-11-1986', 'dd-mm-yyyy'), 'Master', '0550012345', 'Intermediate', 29, 900);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (30, 'Max Bennett', to_date('20-04-1991', 'dd-mm-yyyy'), 'Doctorate', '0550023456', 'Novice', 30, 2100);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (31, 'Chloe Stewart', to_date('15-09-1979', 'dd-mm-yyyy'), 'Bachelor', '0550034567', 'Experienced', 31, 2000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (32, 'Owen Webb', to_date('29-02-1984', 'dd-mm-yyyy'), 'Master', '0550045678', 'Intermediate', 32, 3600);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (33, 'Amelia Howard', to_date('15-07-1989', 'dd-mm-yyyy'), 'Doctorate', '0550056789', 'Novice', 33, 2100);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (34, 'Daniel Johnston', to_date('30-12-1983', 'dd-mm-yyyy'), 'Bachelor', '0550067890', 'Experienced', 34, 1000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (35, 'Harper Kennedy', to_date('25-05-1988', 'dd-mm-yyyy'), 'Master', '0550078901', 'Intermediate', 35, 2700);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (36, 'Matthew Marshall', to_date('20-10-1993', 'dd-mm-yyyy'), 'Doctorate', '0550089012', 'Novice', 36, 2800);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (37, 'Avery Fox', to_date('05-03-1980', 'dd-mm-yyyy'), 'Bachelor', '0550090123', 'Experienced', 37, 2000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (38, 'Evelyn Sanders', to_date('20-08-1985', 'dd-mm-yyyy'), 'Master', '0550101234', 'Intermediate', 38, 2700);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (39, 'Jack Dixon', to_date('15-01-1990', 'dd-mm-yyyy'), 'Doctorate', '0550112345', 'Novice', 39, 700);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (40, 'Abigail Arnold', to_date('30-06-1984', 'dd-mm-yyyy'), 'Bachelor', '0550123456', 'Experienced', 40, 2000);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (41, 'Henry Matthews', to_date('25-11-1989', 'dd-mm-yyyy'), 'Master', '0550134567', 'Intermediate', 41, 3600);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (43, 'Yael Cohen', to_date('12-04-1985', 'dd-mm-yyyy'), 'B.Ed', '541234567', 'Senior', 152, 3300);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (44, 'David Levi', to_date('23-07-1990', 'dd-mm-yyyy'), 'M.Ed', '542345678', 'Junior', 152, 2400);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (45, 'Rivka Shapiro', to_date('05-09-1982', 'dd-mm-yyyy'), 'Ph.D', '543456789', 'Senior', 152, 3300);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (46, 'Sara Mizrahi', to_date('22-11-1988', 'dd-mm-yyyy'), 'B.A', '544567890', 'Junior', 153, 3200);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (47, 'Avi Cohen', to_date('10-03-1975', 'dd-mm-yyyy'), 'M.Sc', '545678901', 'Senior', 153, 4400);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (48, 'Leah Levy', to_date('15-06-1992', 'dd-mm-yyyy'), 'M.A', '546789012', 'Intermediate', 153, 3600);
insert into TEACHER (t_id, teacher_name, teacher_dob, degree, teacher_phone, seniority, d_id, salary)
values (49, 'Sarah Cohen', to_date('15-05-1980', 'dd-mm-yyyy'), 'Degree', '123456789', 'Novice', 177, 1490);
commit;
prompt 48 records loaded
prompt Enabling foreign key constraints for CATERING...
alter table CATERING enable constraint FK_CATERING_LOCATION;
prompt Enabling foreign key constraints for DAYCARE...
alter table DAYCARE enable constraint DC_C_ID_FK;
alter table DAYCARE enable constraint FK_DAYCARE_LOCATION;
prompt Enabling foreign key constraints for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES enable constraint SYS_C008339;
prompt Enabling foreign key constraints for EVENT...
alter table EVENT enable constraint SYS_C008383;
alter table EVENT enable constraint SYS_C008384;
alter table EVENT enable constraint SYS_C008385;
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint SYS_C008392;
prompt Enabling foreign key constraints for MAKEORDER...
alter table MAKEORDER enable constraint SYS_C008402;
alter table MAKEORDER enable constraint SYS_C008403;
prompt Enabling foreign key constraints for REGISTRATION...
alter table REGISTRATION enable constraint SYS_C008346;
alter table REGISTRATION enable constraint SYS_C008347;
prompt Enabling foreign key constraints for TEACHER...
alter table TEACHER enable constraint SYS_C008357;
prompt Enabling triggers for LOCATIONS...
alter table LOCATIONS enable all triggers;
prompt Enabling triggers for CATERING...
alter table CATERING enable all triggers;
prompt Enabling triggers for CHILD...
alter table CHILD enable all triggers;
prompt Enabling triggers for DAYCARE...
alter table DAYCARE enable all triggers;
prompt Enabling triggers for DAYCARE_ACTIVITIES...
alter table DAYCARE_ACTIVITIES enable all triggers;
prompt Enabling triggers for EVENTTYPE...
alter table EVENTTYPE enable all triggers;
prompt Enabling triggers for ORGANIZER...
alter table ORGANIZER enable all triggers;
prompt Enabling triggers for EVENT...
alter table EVENT enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for PARTICIPANTS...
alter table PARTICIPANTS enable all triggers;
prompt Enabling triggers for MAKEORDER...
alter table MAKEORDER enable all triggers;
prompt Enabling triggers for REGISTRATION...
alter table REGISTRATION enable all triggers;
prompt Enabling triggers for TEACHER...
alter table TEACHER enable all triggers;

set feedback on
set define on
prompt Done
