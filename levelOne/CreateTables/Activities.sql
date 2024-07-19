CREATE TABLE Activities
(
  Operator_Name INT NOT NULL,
  Type INT NOT NULL,
  Contact_Number INT NOT NULL,
  PRIMARY KEY (Operator_Name),
  UNIQUE (Contact_Number)
);
