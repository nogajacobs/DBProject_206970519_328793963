--הגבלה ייחודית על שם הקייטרינג
--וודאו שלכל חברת קייטרינג יש שם ייחודי למניעת כפילות.
ALTER TABLE Catering
ADD CONSTRAINT unique_catering_name UNIQUE (Catering_Name);
