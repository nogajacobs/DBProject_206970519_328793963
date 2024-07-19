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
