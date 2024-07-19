CREATE TABLE Daycare_Activities
(
  D_ID INT NOT NULL,
  Operator_Name INT NOT NULL,
  PRIMARY KEY (D_ID, Operator_Name),
  FOREIGN KEY (D_ID) REFERENCES Daycare(D_ID),
  FOREIGN KEY (Operator_Name) REFERENCES Activities(Operator_Name)
);
