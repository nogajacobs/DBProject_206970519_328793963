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
