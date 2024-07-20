
---------------------ORDERS<->dAYCARE----------------

-- Create table
create table ORDERS
(
  orderid      INTEGER not null,
  ticketamount INTEGER not null,
  ticketcost   INTEGER not null,
  orderdate    DATE not null,
  eventid      INTEGER not null,
  d_id         INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table ORDERS
  add primary key (ORDERID)
  using index 
  tablespace SYSTEM
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
alter table ORDERS
  add foreign key (EVENTID)
  references EVENT (EVENTID);
  
  
-------------------------------DAYCARE<->LOCATIONS---------------------------------------------------

ALTER TABLE daycare ADD locationId int;


UPDATE Daycare d
SET d.locationId = (
  SELECT c.locationId
  FROM Catering c
  WHERE c.C_ID = d.C_ID
)
WHERE EXISTS (
  SELECT 1
  FROM Catering c
  WHERE c.C_ID = d.C_ID
);

ALTER TABLE daycare DROP COLUMN Location;


ALTER TABLE daycare
ADD CONSTRAINT FK_daycare_Location FOREIGN KEY (locationId) REFERENCES Locations(locationId);

select * from daycare;


-------------------------------CATERING<->LOCATIONS-------------------------------------------------
ALTER TABLE Catering ADD locationId;
ALTER TABLE Catering DROP COLUMN Location;

ALTER TABLE Catering
ADD CONSTRAINT FK_Catering_Location FOREIGN KEY (locationId) REFERENCES Locations(locationId);

select * from catering;
