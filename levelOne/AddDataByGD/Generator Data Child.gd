
[General]
Version=1

[Preferences]
Username=
Password=2706
Database=
DateFormat=dd-mm-yyyy
CommitCount=100
CommitDelay=0
InitScript=

[Table]
Owner=NOREN
Name=CHILD
Count=10..20

[Record]
Name=CHILD_ID
Type=NUMBER
Size=
Data=Random(100000, 190000)
Master=

[Record]
Name=CHILD_DOB
Type=DATE
Size=
Data=Random(1/1/2018, 1/1/2019)
Master=

[Record]
Name=CHILD_NAME
Type=VARCHAR2
Size=100
Data=FirstName + LastName
Master=

