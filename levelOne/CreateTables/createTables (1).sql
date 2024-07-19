CREATE TABLE Child
(
  Child_Name INT NOT NULL,
  Child_D.O.B INT NOT NULL,
  Child_ID INT NOT NULL,
  PRIMARY KEY (Child_ID)
);

CREATE TABLE Catering
(
  Phone_Number INT NOT NULL,
  Kashrut INT NOT NULL,
  Location INT NOT NULL,
  C_ID INT NOT NULL,
  Catering_Name INT NOT NULL,
  PRIMARY KEY (C_ID)
);

CREATE TABLE Daycare
(
  Opening_Hours INT NOT NULL,
  Location INT NOT NULL,
  Daycare_Name INT NOT NULL,
  Sector INT NOT NULL,
  D_ID INT NOT NULL,
  Closing_Hours INT NOT NULL,
  C_ID INT,
  PRIMARY KEY (D_ID),
  FOREIGN KEY (C_ID) REFERENCES Catering(C_ID)
);

CREATE TABLE Activities
(
  Operator_Name INT NOT NULL,
  Type INT NOT NULL,
  Contact_Number INT NOT NULL,
  PRIMARY KEY (Operator_Name),
  UNIQUE (Contact_Number)
);

CREATE TABLE Daycare_Activities
(
  D_ID INT NOT NULL,
  Operator_Name INT NOT NULL,
  PRIMARY KEY (D_ID, Operator_Name),
  FOREIGN KEY (D_ID) REFERENCES Daycare(D_ID),
  FOREIGN KEY (Operator_Name) REFERENCES Activities(Operator_Name)
);

CREATE TABLE Teacher
(
  Teacher_Name INT NOT NULL,
  Teacher_D.O.B INT NOT NULL,
  T_ID INT NOT NULL,
  Degree INT NOT NULL,
  Teacher_Phone INT NOT NULL,
  Seniority INT NOT NULL,
  D_ID INT NOT NULL,
  PRIMARY KEY (T_ID),
  FOREIGN KEY (D_ID) REFERENCES Daycare(D_ID)
);

CREATE TABLE Registration
(
  Price INT NOT NULL,
  Date INT NOT NULL,
  Registation_ID INT NOT NULL,
  D_ID INT NOT NULL,
  Child_ID INT,
  PRIMARY KEY (Registation_ID, D_ID),
  FOREIGN KEY (D_ID) REFERENCES Daycare(D_ID),
  FOREIGN KEY (Child_ID) REFERENCES Child(Child_ID)
);
