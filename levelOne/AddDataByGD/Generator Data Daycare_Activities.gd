
[General]
Version=1

[Preferences]
Username=
Password=2330
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=NOREN
Name=DAYCARE_ACTIVITIES
Count=10..20

[Record]
Name=D_ID
Type=NUMBER
Size=
Data=List(select D_ID from DAYCARE)
Master=

[Record]
Name=OPERATOR_NAME
Type=VARCHAR2
Size=100
Data=List(select operator_name from activities)
Master=

