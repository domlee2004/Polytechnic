CREATE TABLE EventType(
ETID int Primary Key,
ETName varchar(30) not null
)

CREATE TABLE [Event] (
EventID int primary key,
ETID int not null,
EventName varchar(100) not null,
EventDescr varchar(300) null,
EventLoc varchar(20) not null,
MinAge int null,
MaxAge int null,
EventCapacity int null check(EventCapacity > 0),
EventDuration float null check(EventDuration > 0),
AdultPrice smallmoney null,
ChildPrice smallmoney null,
CONSTRAINT FK_Event_ETID FOREIGN KEY (ETID) REFERENCES EventType(ETID),
CONSTRAINT Chk_MinAge CHECK (MinAge < MaxAge)
)

CREATE TABLE EventSession
(
EventID int,			 
SessionNo int,
EventDateTime smalldatetime not null,
CONSTRAINT PK_EventSession PRIMARY KEY (EventID, SessionNo),
CONSTRAINT FK_EventSession_EventID FOREIGN KEY (EventID) REFERENCES [Event](EventID)
)

CREATE TABLE Passenger
(
PgrID int PRIMARY KEY,
PgrName varchar(50) NOT NULL,
PgrEmail varchar(50) NULL,
PgrDOB date not null,
PgrGender char(1) not null check(PgrGender IN ('M', 'F')),
CabinNo int not null
)

CREATE TABLE Booking
(
BookingID int primary key,
PgrID int not null,
SessionNo int not null,
EventID int not null,
NoOfAdultTickets int null,
NoOfChildTickets int null,
AdultSalesPrice smallmoney null,
ChildSalesPrice smallmoney null,
BookStatus varchar(20) not null,
BookDateTime smalldatetime not null,
CONSTRAINT FK_Booking_PgrID FOREIGN KEY (PgrID) REFERENCES Passenger(PgrID),
CONSTRAINT FK_Booking_composite FOREIGN KEY (EventID, SessionNo) REFERENCES EventSession (EventID, SessionNo)
)

CREATE TABLE PgrContactNo
(
PgrID int,
PgrContactNo char(30),
CONSTRAINT PK_PgrContactNo PRIMARY KEY (PgrID, PgrContactNo),
CONSTRAINT FK_PgrContactNo_PgrID FOREIGN KEY (PgrID) REFERENCES Passenger(PgrID)
)


CREATE TABLE Eatery
(
EatyID int primary key,
EatyOpHr time(0) not null,
EatyClHr time(0) not null,
EatyCapacity int not null,
EatyLoc varchar(50) not null,
EatyName varchar(50) not null
)

CREATE TABLE Reservation 
(
ReservID int primary key,
EatyID int not null,
PgrID int not null,
ReservStatus varchar(20) not null,
RequiredDateTime smalldatetime not null,
ReservDateTime smalldatetime not null,
NoOfPax int not null default 1,
CONSTRAINT FK_Reservation_EatyID FOREIGN KEY (EatyID) REFERENCES Eatery(EatyID),
CONSTRAINT FK_Reservation_PgrID FOREIGN KEY (PgrID) REFERENCES Passenger(PgrID),
CONSTRAINT Chk_RequiredDateTime CHECK (RequiredDateTime > ReservDateTime)
)

CREATE TABLE Cuisine
(
cuisineID int primary key,
cuisineName varchar(30) not null
)

CREATE TABLE Dish
(
DishID int PRIMARY KEY,
cuisineID int not null,
EatyID int not null,
DishName varchar(50) not null,
DishDescr varchar(150) null,
CONSTRAINT FK_Dish_cuisine FOREIGN KEY (cuisineID) REFERENCES Cuisine(cuisineID),
CONSTRAINT FK_Dish_eatery FOREIGN KEY (EatyID) REFERENCES Eatery(EatyID)
)

CREATE TABLE orders     
(
PgrID int,
DishID int,
DelDateTime smalldatetime not null,
DeliverTo int not null,
OrderDateTime smalldatetime not null,
OrderQty int not null check (OrderQty > 0) default 1,
OrderPrice smallmoney not null,
CONSTRAINT PK_orders PRIMARY KEY (PgrID, DishID),
CONSTRAINT FK_orders_PgrID FOREIGN KEY (PgrID) REFERENCES Passenger(PgrID),
CONSTRAINT FK_orders_DishID FOREIGN KEY (DishID) REFERENCES Dish(DishID),
CONSTRAINT Chk_DelDateTime CHECK (DelDateTime > OrderDateTime)
)

CREATE TABLE CSDish
(
DishID int primary key,
Price smallmoney not null,
CONSTRAINT FK_CSDish_DishID FOREIGN KEY (DishID) REFERENCES Dish(DishID)
)

CREATE TABLE FoodCategory
(
FcID int primary key,
FcName varchar(30) not null,
FcDescr varchar(150) null
)

CREATE TABLE categorised_in
(
FcID int,
DishID int,
CONSTRAINT PK_categorised_in PRIMARY KEY (FcID, DishID), 
CONSTRAINT FK_categorised_in_FC FOREIGN KEY (FcID) REFERENCES FoodCategory(FcID),
CONSTRAINT FK_categorised_in_Dish FOREIGN KEY (DishID) REFERENCES Dish(DishID)
)

CREATE TABLE Ingredient 
(
IngredID int primary key,
IngredName varchar(30) not null UNIQUE
)

CREATE TABLE [contains]
(
DishID int,
IngredID int,
CONSTRAINT PK_contains PRIMARY KEY (DishID, IngredID),
CONSTRAINT FK_contains_Ingredient FOREIGN KEY (IngredID) REFERENCES Ingredient(IngredID),
CONSTRAINT FK_contains_Dish FOREIGN KEY (DishID) REFERENCES Dish(DishID)
) 

-- Data for EventType relation
INSERT INTO EventType(ETID, ETName)
VALUES(1, 'Entertainment')
INSERT INTO EventType(ETID, ETName)
VALUES(2, 'Land Sport')
INSERT INTO EventType(ETID, ETName)
VALUES(3, 'Meeting')
INSERT INTO EventType(ETID, ETName)
VALUES(4, 'Educational')
INSERT INTO EventType(ETID, ETName)
VALUES(5, 'Musical')
INSERT INTO EventType(ETID, ETName)
VALUES(6, 'Tours')
INSERT INTO EventType(ETID, ETName)
VALUES(7, 'Water sport')
INSERT INTO EventType(ETID, ETName)
VALUES(8, 'Movie')
INSERT INTO EventType(ETID, ETName)
VALUES(9, 'Nightlife')
INSERT INTO EventType(ETID, ETName)
VALUES(10, 'Fundraiser')

-- Data for Event relation
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(1, 2, 'Rock Climbing', 'Passengers can scale a 50m high wall on the cruise', '#05-01', 8, null, null, 0.5, 20, 20)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(2, 2, 'Tennis', 'Passengers can play tennis on the cruise', '#05-02', null, null, null, null, null, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(3, 2, 'Basketball', 'Passengers can play basketball on the cruise', '#05-03', null, null, null, null, null, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(4, 2, 'Table tennis', 'Passengers can play table tennis on the cruise', '#04-07', null, null, null, null, null, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(5, 7, 'Swimming', 'Passengers can swim on the cruise', '#03-04', null, null, null, null, null, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(6, 7, 'Surfing', 'Passengers can surf on the cruise', '#03-03', 8, null, null, 0.5, 20, 20)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(7, 2, 'Bowling', 'Passengers can bowl on the cruise', '#04-08', null, null, null, 1, 12, 8)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(8, 1, 'Casino', 'Passengers can gamble on the cruise', '#04-09', 18, null, null, null, 100, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(9, 1, 'Arcade', 'Passengers can enter the aracde on the cruise', '#04-08', null, null, null, null, null, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(10, 5, 'Les Miserables', 'Les Miserables will be performed by the Jason Brewer team', '#01-01', null, null, 200, 2.5, 80, 60)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(11, 5, 'Hamilton', 'Hamilton will be performed by the Warner Brother team', '#01-02', null, null, 200, 2, 85, 70)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(12, 8, 'The Last Dance', 'Michael Jordans journey for his 6th NBA championship in 8 years', '#01-03', 16, null, 150, 2, 15, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(13, 8, 'The Life of Pi', 'Lost in sea, with a tiger..', '#01-04', null, null, 1.5, 150, 15, 15)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(14, 8, 'James Bond', 'Action packed thriller featuring James McDale', '#01-05', 21, null, 150, 2, 15, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(15, 8, 'Arcane', 'Sisters by blood enemies by fate', '#01-06', null, null, 150, 1.5, 15, 15)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(16, 4, 'Intricasies of Asian spices', 'Learn more about the beauty of Asian spices', '#02-03', null, null, 50, 3, 50, 40)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(17, 4, 'Western delights', null, '#03-08', null, null, 50, 2.5, 60, 60)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(18, 1, 'Bingo!', 'Win at bingo to win some big prizes', '#03-09', null, null, 200, 2, null, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(19, 1, 'Pool Games', 'Compete in some pool games for a chance to win some exclusive prizes', '#04-10', 4, null, 50, 1.5, null, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(20, 9, 'Star Gazing', 'Learn about stars and see shining stars lighting up the dark night sky', '#05-05', null, null, 200, 1, null, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(21, 9, '90s themed party', 'Dress up as if you were in the 90s and enjoy the night away', '#03-09', 18, null, 150, 3, 20, null)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(22, 10, 'Fundraiser at sea', 'Raise some funds to clear our blue oceans of garbage', '#01-13', null, null, 300, 2, 100, 70)
INSERT INTO Event(EventID, ETID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice, ChildPrice)
VALUES(23, 6, 'Running a ship', 'A galley tour through the ship lead by our crew', '#01-14', null, null, 70, 1.5, 10, 10)

-- Data for EventSession relation
INSERT INTO EventSession
VALUES(10, 1, '20 January 2022 20:00:00')
INSERT INTO EventSession
VALUES(10, 2, '21 January 2022 20:00:00')
INSERT INTO EventSession
VALUES(11, 1, '21 January 2022 21:00:00')
INSERT INTO EventSession
VALUES(11, 2, '22 January 2022 21:00:00')
INSERT INTO EventSession
VALUES(12, 1, '19 January 2022 19:00:00')
INSERT INTO EventSession
VALUES(12, 2, '20 January 2022 20:00:00')
INSERT INTO EventSession
VALUES(12, 3, '21 January 2022 19:00:00')
INSERT INTO EventSession
VALUES(12, 4, '22 January 2022 19:00:00')
INSERT INTO EventSession
VALUES(13, 1, '19 January 2022 18:00:00')
INSERT INTO EventSession
VALUES(13, 2, '21 January 2022 21:00:00')
INSERT INTO EventSession
VALUES(13, 3, '23 January 2022 18:00:00')
INSERT INTO EventSession
VALUES(14, 1, '18 January 2022 21:30:00')
INSERT INTO EventSession
VALUES(14, 2, '19 January 2022 21:00:00')
INSERT INTO EventSession
VALUES(15, 1, '21 January 2022 20:30:00')
INSERT INTO EventSession
VALUES(15, 2, '23 January 2022 21:00:00')
INSERT INTO EventSession
VALUES(15, 3, '23 January 2022 21:00:00')
INSERT INTO EventSession
VALUES(16, 1, '18 January 2022 12:00:00')
INSERT INTO EventSession
VALUES(16, 2, '19 January 2022 12:00:00')
INSERT INTO EventSession
VALUES(17, 1, '20 January 2022 14:00:00')
INSERT INTO EventSession
VALUES(18, 1, '19 January 2022 10:00:00')
INSERT INTO EventSession
VALUES(18, 2, '19 January 2022 15:00:00')
INSERT INTO EventSession
VALUES(18, 3, '21 January 2022 10:00:00')
INSERT INTO EventSession
VALUES(19, 1, '22 January 2022 11:00:00')
INSERT INTO EventSession
VALUES(19, 2, '23 January 2022 11:00:00')
INSERT INTO EventSession
VALUES(20, 1, '19 January 2022 23:30:00')
INSERT INTO EventSession
VALUES(20, 2, '20 January 2022 23:30:00')
INSERT INTO EventSession
VALUES(20, 3, '21 January 2022 23:30:00')
INSERT INTO EventSession
VALUES(21, 1, '20 January 2022 22:00:00')
INSERT INTO EventSession
VALUES(22, 1, '23 January 2022 17:30:00')
INSERT INTO EventSession
VALUES(23, 1, '18 January 2022 9:00:00')

-- Data for Passenger relation 
INSERT INTO Passenger
VALUES(1, 'John Tan', 'john@gmail.com', '1 January 2006', 'M', 1)
INSERT INTO Passenger
VALUES(2, 'Mary Tay', null, '3 March 2009', 'F', 2)
INSERT INTO Passenger
VALUES(3, 'Harry Tay', null, '9 September 2012', 'M', 2)
INSERT INTO Passenger
VALUES(4, 'Terry Leong', null, '10 May 2016', 'M', 6)
INSERT INTO Passenger
VALUES(5, 'Timmy Long', null, '10 December 2015', 'M', 5)
INSERT INTO Passenger
VALUES(6, 'Theresa Lim', null, '15 June 2018', 'F', 3)
INSERT INTO Passenger
VALUES(7, 'Tommy Lim', null, '20 May 2014', 'M', 3)
INSERT INTO Passenger
VALUES(8, 'Hugh Dee', null, '29 April 2014', 'F', 4)
INSERT INTO Passenger
VALUES(9, 'Teng Dee', null, '10 May 2015', 'F', 4)
INSERT INTO Passenger
VALUES(10, 'Jim Heng', 'jimheng@gmail.com.sg', '13 August 2004', 'M', 5)
INSERT INTO Passenger
VALUES(11, 'Dylan Long', 'dylanloong@gmail.com.sg', '22 September 1996', 'M', 5)
INSERT INTO Passenger
VALUES(12, 'Mary Lee', 'Mrylee@gmail.com.sg', '13 February 1999', 'F', 7)
INSERT INTO Passenger
VALUES(13, 'Tan Beck', 'tanback@gmail.com.sg', '10 May 1990', 'F', 1)
INSERT INTO Passenger
VALUES(14, 'Felicia Yee', 'feliciayee@gmail.com.sg', '29 March 1992', 'F', 8)
INSERT INTO Passenger
VALUES(15, 'Peng Yew', 'pengyew@gmail.com.sg', '28 November 1980', 'M', 9)
INSERT INTO Passenger
VALUES(16, 'Boon Tan', 'boontan@gmail.com.sg', '27 July 1985', 'M', 1)
INSERT INTO Passenger
VALUES(17, 'Timothy Lee', 'timothylee@gmail.com.sg', '13 October 1974', 'M', 7)
INSERT INTO Passenger
VALUES(18, 'Jason Lim', 'jasonlim@gmail.com.sg', '26 October 1960', 'M', 3)
INSERT INTO Passenger
VALUES(19, 'Kimmy Chong', 'kimmychong@gmail.com.sg', '12 May 1990', 'F', 7)
INSERT INTO Passenger
VALUES(20, 'Johnathan tay', 'johnathantay@gmail.com.sg', '16 May 2002', 'M', 2)
INSERT INTO Passenger
VALUES(21, 'John Dee', 'john@gmail.com.sg', '28 April 2004', 'M', 4)
INSERT INTO Passenger
VALUES(22, 'Patty Lim', 'patty@gmail.com.sg', '8 January 2004', 'F', 6)
INSERT INTO Passenger
VALUES(23, 'Eric Tong', 'eric@gmail.com.sg', '20 December 1970', 'M', 10)
INSERT INTO Passenger
VALUES(24, 'Joanna Dee', 'joanna@gmail.com.sg', '1 May 1969', 'F', 4)
INSERT INTO Passenger
VALUES(25, 'Michael Jordan', 'Michael@gmail.com.sg', '22 August 1975', 'M', 11)
INSERT INTO Passenger
VALUES(26, 'Stephen Curry', 'Steph3@gmail.com.sg', '2 June 1999', 'M', 12)
INSERT INTO Passenger
VALUES(27, 'Shaquille O Neal', 'BigDiesel@gmail.com.sg', '12 June 1998', 'M', 13)
INSERT INTO Passenger
VALUES(28, 'Tim Duncan', 'Fundamentals@gmail.com.sg', '27 October 2001', 'M', 12)
INSERT INTO Passenger
VALUES(29, 'Tom Brady', 'goat@gmail.com.sg', '5 March 2003', 'M', 12)
INSERT INTO Passenger
VALUES(30, 'Lebron James', 'LejonBrames@gmail.com.sg', '14 February 1977', 'M', 13)
INSERT INTO Passenger
VALUES(31, 'Kobe Bryant', 'Mamba@gmail.com.sg', '9 August 1972', 'M', 13)
INSERT INTO Passenger
VALUES(32, 'Adolf Herman', 'Hitler@gmail.com.sg', '10 July 1969', 'F', 13)
INSERT INTO Passenger
VALUES(33, 'Joe Stalin', 'StalinJoseph@gmail.com.sg', '18 July 1975', 'M', 13)
INSERT INTO Passenger
VALUES(34, 'Simon Kandel', 'SimonSays@gmail.com.sg', '23 November 1983', 'M', 14)
INSERT INTO Passenger
VALUES(35, 'Jesus Lee', 'LeeJesus@gmail.com.sg', '9 October 1983', 'F', 15)
INSERT INTO Passenger
VALUES(36, 'Adrian Franz', 'Adrian@gmail.com.sg', '3 March1991', 'M', 15)
INSERT INTO Passenger
VALUES(37, 'Linda Neurath', 'Lindawho@gmail.com.sg', '31 January 1972', 'F', 16)
INSERT INTO Passenger
VALUES(38, 'Stella Breuer', 'stella@gmail.com.sg', '10 August 1974', 'F', 17)
INSERT INTO Passenger
VALUES(39, 'Mia Auer', 'MiaAuer@gmail.com.sg', '5 December 1972', 'F', 16)
INSERT INTO Passenger
VALUES(40, 'Rosalie Werner', 'Rosalie@gmail.com.sg', '4 November 1964', 'F', 18)
INSERT INTO Passenger
VALUES(41, 'Mira Rottmayr', 'Rottymayr@gmail.com.sg', '21 August 2001', 'F', 19)
INSERT INTO Passenger
VALUES(42, 'Emily Wilder', 'Emily@gmail.com.sg', '20 July 1955', 'F', 19)
INSERT INTO Passenger
VALUES(43, 'Christina Neurath', 'Christina@gmail.com.sg', '3 August 1950', 'F', 20)
INSERT INTO Passenger
VALUES(44, 'Lina Hass', 'Lina@gmail.com.sg', '29 September 1953', 'F', 19)
INSERT INTO Passenger
VALUES(45, 'Alexandra Klestil', 'Alexandra@gmail.com.sg', '10 September 1990', 'F', 21)
INSERT INTO Passenger
VALUES(46, 'Selina Beelek', 'Selina@gmail.com.sg', '13 September 1980', 'F', 22)
INSERT INTO Passenger
VALUES(47, 'Laureen Menger', 'Laureen@gmail.com.sg', '12 October 2005', 'F', 20)
INSERT INTO Passenger
VALUES(48, 'Gabriel Ambros', 'Gabriel@gmail.com.sg', '30 November 1971', 'M', 18)
INSERT INTO Passenger
VALUES(49, 'Leonhard Leitner', 'Leonhard@gmail.com.sg', '3 December 1972', 'M', 21)
INSERT INTO Passenger
VALUES(50, 'Peter Fichter', 'Peter@gmail.com.sg', '19 January 1992', 'M', 22)
INSERT INTO Passenger
VALUES(51, 'Andreas Moser', 'Andreas@gmail.com.sg', '4 February 1982', 'M', 23)
INSERT INTO Passenger
VALUES(52, 'Fabio Baeder', 'Fabio@gmail.com.sg', '15 March 1989', 'M', 24)
INSERT INTO Passenger
VALUES(53, 'Manuel Muster', 'Manuel@gmail.com.sg', '7 April 1999', 'M', 25)
INSERT INTO Passenger
VALUES(54, 'Marco Lechner', 'MarcodeLarco@gmail.com.sg', '6 December 1988', 'M', 26)
INSERT INTO Passenger
VALUES(55, 'Paul Pichler', 'PaulPaulPaul@gmail.com.sg', '8 October 1989', 'M', 27)
INSERT INTO Passenger
VALUES(56, 'Emil Kohn', 'Emil@gmail.com.sg', '25 November 1979', 'F', 28)
INSERT INTO Passenger
VALUES(57, 'Helene Heilig', 'Helene@gmail.com.sg', '21 September 1970', 'F', 29)
INSERT INTO Passenger
VALUES(58, 'Amina Rainer', 'Amina@gmail.com.sg', '28 August 1973', 'F', 30)
INSERT INTO Passenger
VALUES(59, 'Chiara Maier', 'Chiara@gmail.com.sg', '1 July 1996', 'F', 31)
INSERT INTO Passenger
VALUES(60, 'Patrick Schmid', 'Patrick@gmail.com.sg', '3 June 2004', 'M', 30)

--PgrContactNo
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(1, '91238283')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(2, '81618811')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(3, '90203933')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(4, '91494949')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(5, '81618811')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(6, '94318484')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(7, '91349304')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(8, '99886834')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(9, '99886834')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(10, '81930393')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(11, '81618811')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(12, '9832382')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(13, '8948484')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(14, '9393030')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(15, '9349184')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(16, '91048489')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(17, '94138283')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(18, '94318484')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(19, '96877440')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(20, '97068112')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(21, '99886834')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(22, '91494949')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(23, '97694838')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(24, '97859302')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(25, '95696483')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(26, '90878723')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(27, '95736141')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(28, '91732433')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(29, '91374735')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(30, '92374574')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(31, '94464723')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(32, '88524958')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(33, '93483934')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(34, '90243433')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(35, '90014256')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(36, '93360101')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(37, '933702933')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(38, '966739403')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(39, '90091117')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(40, '93495835')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(41, '91094103')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(42, '98757654')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(43, '91192882')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(44, '94303944')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(45, '98088332')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(46, '94340944')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(47, '92222333')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(48, '96664884')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(49, '84932843')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(50, '82398411')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(51, '81394832')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(52, '84938592')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(53, '83948232')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(54, '82229383')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(55, '83483943')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(56, '89348930')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(57, '91849131')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(58, '89183413')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(59, '81618811')
INSERT INTO PgrContactNo(PgrID, PgrContactNo)
VALUES(60, '90934233')

--Data for Booking relation
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(1, 1, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 15:00:01')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(2, 36, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 14:23:34')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(3, 33, 1, 10, 1, 1, 80, 60, 'Cancelled', '19 January 2022 00:42:20')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(4, 43, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(5, 32, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(6, 33, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 15:10:40')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(7, 47, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(8, 24, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(9, 21, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 15:10:30')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(10, 8, 1, 10, 1, 1, 80, 60, 'Booked', '19 January 2022 15:08:12')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(11, 9, 1, 10, 1, 1, 80, 60, 'Waitlisted', '20 January 2022 19:52:20')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(12, 34, 2, 10, 1, 1, 80, 60, 'Booked', '20 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(13, 4, 2, 10, 1, 1, 80, 60, 'Booked', '20 January 2022 10:00:48')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(14, 22, 2, 10, 1, 1, 80, 60, 'Booked', '20 January 2022 10:01:10')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(15, 53, 2, 10, 1, 1, 80, 60, 'Booked', '20 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(16, 52, 2, 10, 1, 1, 80, 60, 'Booked', '20 January 2022 18:13:10')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(17, 13, 1, 11, 1, 1, 85, 70, 'Booked', '20 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(18, 54, 1, 11, 1, 1, 85, 70, 'Cancelled', '20 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(19, 18, 1, 11, 1, 1, 85, 70, 'Booked', '20 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(20, 6, 1, 11, 1, 1, 85, 70, 'Booked', '20 January 2022 09:50:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(21, 7, 1, 11, 1, 1, 85, 70, 'Booked', '20 January 2022 11:11:20')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(22, 2, 1, 11, 1, 1, 85, 70, 'Booked', '20 January 2022 15:06:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(23, 3, 1, 11, 1, 1, 85, 70, 'Booked', '20 January 2022 15:10:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(24, 20, 1, 11, 1, 1, 85, 70, 'Booked', '20 January 2022 17:20:09')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(25, 35, 2, 11, 1, 1, 85, 70, 'Booked', '21 January 2022 18:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(26, 36, 2, 11, 1, 1, 85, 70, 'Booked', '21 January 2022 14:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(27, 27, 2, 11, 1, 1, 85, 70, 'Booked', '21 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(28, 30, 2, 11, 1, 1, 85, 70, 'Booked', '21 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(29, 31, 2, 11, 1, 1, 85, 70, 'Booked', '21 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(30, 32, 2, 11, 1, 1, 85, 70, 'Booked', '21 January 2022 12:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(31, 33, 2, 11, 1, 1, 85, 70, 'Waitlisted', '21 January 2022 20:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(32, 40, 2, 11, 1, 1, 85, 70, 'Booked', '21 January 2022 21:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(33, 18, 2, 11, 1, 1, 85, 70, 'Booked', '21 January 2022 20:15:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(34, 45, 1, 12, 1, null, 15, null, 'Booked', '18 January 2022 18:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(35, 49, 1, 12, 1, null, 15, null, 'Booked', '18 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(36, 29, 1, 12, 1, null, 15, null, 'Booked', '18 January 2022 16:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(37, 44, 1, 12, 1, null, 15, null, 'Waitlisted', '18 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(38, 32, 1, 12, 1, null, 15, null, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(39, 25, 1, 12, 1, null, 15, null, 'Cancelled', '18 January 2022 16:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(40, 19, 1, 12, 1, null, 15, null, 'Booked', '18 January 2022 18:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(41, 17, 1, 12, 1, null, 15, null, 'Cancelled', '18 January 2022 18:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(42, 26, 1, 12, 1, null, 15, null, 'Booked', '18 January 2022 15:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(43, 28, 1, 12, 1, null, 15, null, 'Booked', '18 January 2022 11:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(44, 29, 1, 12, 1, null, 15, null, 'Booked', '18 January 2022 08:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(45, 30, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 12:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(46, 27, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 18:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(47, 32, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(48, 33, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 12:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(49, 13, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(50, 34, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(51, 16, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 11:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(52, 36, 2, 12, 1, null, 15, null, 'Cancelled', '19 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(53, 39, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(54, 37, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 11:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(55, 55, 2, 12, 1, null, 15, null, 'Booked', '19 January 2022 15:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(56, 17, 3, 12, 1, null, 15, null, 'Booked', '20 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(57, 19, 3, 12, 1, null, 15, null, 'Booked', '20 January 2022 01:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(58, 23, 3, 12, 1, null, 15, null, 'Cancelled', '20 January 2022 12:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(59, 60, 3, 12, 1, null, 15, null, 'Booked', '20 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(60,  1, 3, 12, 1, null, 15, null, 'Booked', '20 January 2022 06:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(61, 30, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(62, 31, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 16:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(63, 33, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 17:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(64, 51, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 14:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(65, 2, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(66, 3, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(67, 20, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 12:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(68, 23, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 11:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(69, 46, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(70, 10, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 05:45:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(71, 19, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 01:15:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(72, 35, 1, 13, 1, 1, 15, 15, 'Booked', '18 January 2022 02:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(73, 27, 2, 13, 1, 1, 15, 15, 'Booked', '20 January 2022 12:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(74, 32, 2, 13, 1, 1, 15, 15, 'Booked', '20 January 2022 11:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(75, 34, 2, 13, 1, 1, 15, 15, 'Cancelled', '20 January 2022 11:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(76,  4, 2, 13, 1, 1, 15, 15, 'Booked', '20 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(77, 22, 2, 13, 1, 1, 15, 15, 'Booked', '20 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(78,  7, 2, 13, 1, 1, 15, 15, 'Cancelled', '20 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(79, 18, 2, 13, 1, 1, 15, 15, 'Booked', '20 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(80,  6, 2, 13, 1, 1, 15, 15, 'Cancelled', '20 January 2022 01:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(81, 41, 2, 13, 1, 1, 15, 15, 'Booked', '20 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(82, 42, 2, 13, 1, 1, 15, 15, 'Booked', '20 January 2022 15:10:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(83, 44, 3, 13, 1, 1, 15, 15, 'Booked', '22 January 2022 12:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(84, 39, 3, 13, 1, 1, 15, 15, 'Booked', '22 January 2022 02:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(85, 37, 3, 13, 1, 1, 15, 15, 'Booked', '22 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(86,  2, 3, 13, 1, 1, 15, 15, 'Booked', '22 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(87, 20, 3, 13, 1, 1, 15, 15, 'Booked', '22 January 2022 17:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(88, 52, 3, 13, 1, 1, 15, 15, 'Waitlisted', '22 January 2022 19:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(89, 57, 3, 13, 1, 1, 15, 15, 'Booked', '22 January 2022 03:50:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(90, 43, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(91, 30, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(92, 17, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 14:15:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(93, 33, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 12:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(94, 19, 2, 14, 1, null, 15, null, 'Cancelled', '18 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(95, 50, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 14:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(96, 27, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 02:55:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(97, 31, 2, 14, 1, null, 15, null, 'Waitlisted', '18 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(98, 46, 2, 14, 1, null, 15, null, 'Waitlisted', '18 January 2022 20:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(99, 25, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 13:10:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(100, 32, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 07:35:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(101, 54, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:50:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(102, 40, 2, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:10:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(103, 26, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(104, 28, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(105, 19, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(106, 24, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(107, 26, 3, 15, 1, 1, 15, 15, 'Booked', '23 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(108, 28, 3, 15, 1, 1, 15, 15, 'Booked', '23 January 2022 03:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(109, 29, 3, 15, 1, 1, 15, 15, 'Booked', '23 January 2022 03:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(110, 5, 3, 15, 1, 1, 15, 15, 'Booked', '23 January 2022 03:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(111, 57, 3, 15, 1, 1, 15, 15, 'Booked', '23 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(112, 10, 3, 15, 1, 1, 15, 15, 'Booked', '23 January 2022 15:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(113, 18, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(114, 7, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(115, 2, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 03:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(116, 6, 1, 16, 1, 1, 50, 40, 'Cancelled', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(117, 20, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 03:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(118, 11, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 10:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(119, 5, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 08:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(120, 10, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(121, 18, 1, 16, 1, 1, 50, 40, 'Waitlisted', '18 January 2022 04:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(122, 6, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(123, 7, 1, 16, 1, 1, 50, 40, 'Cancelled', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(124, 29, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 08:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(125, 1, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 07:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(126, 13, 1, 16, 1, 1, 50, 40, 'Waitlisted', '18 January 2022 08:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(127, 16, 1, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 09:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(128, 46, 2, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 02:10:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(129, 50, 2, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 03:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(130, 41, 2, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 06:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(131, 42, 2, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 07:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(132, 44, 2, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 09:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(133, 59, 2, 16, 1, 1, 50, 40, 'Cancelled', '18 January 2022 09:55:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(134, 47, 2, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 11:50:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(135, 43, 2, 16, 1, 1, 50, 40, 'Waitlisted', '18 January 2022 11:10:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(136, 34, 2, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(137, 33, 2, 16, 1, 1, 50, 40, 'Booked', '18 January 2022 07:10:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(138, 38, 1, 17, 1, 1, 60, 60, 'Booked', '19 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(139, 5, 1, 17, 1, 1, 60, 60, 'Waitlisted', '19 January 2022 09:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(140, 10, 1, 17, 1, 1, 60, 60, 'Cancelled', '19 January 2022 06:35:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(141, 26, 1, 17, 1, 1, 60, 60, 'Booked', '19 January 2022 05:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(142, 14, 1, 18, null, null, null, null, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(143, 39, 1, 18, null, null, null, null, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(144, 37, 1, 18, null, null, null, null, 'Booked', '18 January 2022 08:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(145, 2, 1, 18, null, null, null, null, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(146, 20, 1, 18, null, null, null, null, 'Booked', '18 January 2022 01:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(147, 3, 1, 18, null, null, null, null, 'Waitlisted', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(148, 8, 1, 18, null, null, null, null, 'Booked', '18 January 2022 09:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(149, 9, 1, 18, null, null, null, null, 'Cancelled', '18 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(150, 21, 1, 18, null, null, null, null, 'Booked', '18 January 2022 06:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(151, 24, 1, 18, null, null, null, null, 'Booked', '18 January 2022 06:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(152, 36, 1, 18, null, null, null, null, 'Cancelled', '18 January 2022 09:45:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(153, 59, 1, 18, null, null, null, null, 'Waitlisted', '18 January 2022 03:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(154, 35, 1, 18, null, null, null, null, 'Booked', '18 January 2022 04:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(155, 38, 2, 18, null, null, null, null, 'Booked', '18 January 2022 14:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(156, 40, 2, 18, null, null, null, null, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(157, 2, 2, 18, null, null, null, null, 'Booked', '18 January 2022 14:15:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(158, 14, 2, 18, null, null, null, null, 'Cancelled', '18 January 2022 13:45:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(159, 42, 2, 18, null, null, null, null, 'Waitlisted', '18 January 2022 08:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(160, 22, 2, 18, null, null, null, null, 'Waitlisted', '18 January 2022 11:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(161, 58, 2, 18, null, null, null, null, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(162, 60, 2, 18, null, null, null, null, 'Booked', '18 January 2022 12:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(163, 29, 2, 18, null, null, null, null, 'Booked', '18 January 2022 11:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(164, 37, 2, 18, null, null, null, null, 'Booked', '18 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(165, 35, 2, 18, null, null, null, null, 'Booked', '18 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(166, 30, 2, 18, null, null, null, null, 'Waitlisted', '18 January 2022 10:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(167, 48, 3, 18, null, null, null, null, 'Booked', '20 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(168, 16, 3, 18, null, null, null, null, 'Booked', '20 January 2022 06:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(169, 5, 3, 18, null, null, null, null, 'Booked', '20 January 2022 05:35:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(170, 10, 3, 18, null, null, null, null, 'Booked', '20 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(171, 11, 3, 18, null, null, null, null, 'Booked', '20 January 2022 06:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(172, 58, 3, 18, null, null, null, null, 'Cancelled', '20 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(173, 60, 3, 18, null, null, null, null, 'Booked', '20 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(174, 45, 3, 18, null, null, null, null, 'Booked', '20 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(175, 49, 3, 18, null, null, null, null, 'Booked', '20 January 2022 09:05:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(176, 4, 3, 18, null, null, null, null, 'Booked', '20 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(177, 22, 3, 18, null, null, null, null, 'Booked', '20 January 2022 01:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(178, 42, 3, 18, null, null, null, null, 'Cancelled', '20 January 2022 09:05:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(179, 6, 3, 18, null, null, null, null, 'Booked', '20 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(180, 18, 3, 18, null, null, null, null, 'Booked', '20 January 2022 07:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(181, 54, 1, 19, null, null, null, null, 'Booked', '21 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(182, 36, 1, 19, null, null, null, null, 'Booked', '21 January 2022 01:05:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(183, 15, 1, 19, null, null, null, null, 'Booked', '21 January 2022 05:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(184, 60, 1, 19, null, null, null, null, 'Booked', '21 January 2022 07:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(185, 11, 1, 19, null, null, null, null, 'Cancelled', '21 January 2022 04:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(186, 5, 1, 19, null, null, null, null, 'Booked', '21 January 2022 06:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(187, 1, 1, 19, null, null, null, null, 'Booked', '21 January 2022 08:45:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(188, 16, 1, 19, null, null, null, null, 'Booked', '21 January 2022 10:10:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(189, 22, 2, 19, null, null, null, null, 'Booked', '22 January 2022 09:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(190, 55, 1, 20, null, null, null, null, 'Booked', '18 January 2022 23:15:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(191, 6, 1, 20, null, null, null, null, 'Cancelled', '18 January 2022 09:55:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(192, 16, 1, 20, null, null, null, null, 'Booked', '18 January 2022 21:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(193, 8, 1, 20, null, null, null, null, 'Booked', '18 January 2022 14:05:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(194, 57, 2, 20, null, null, null, null, 'Booked', '19 January 2022 20:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(195, 58, 2, 20, null, null, null, null, 'Cancelled', '19 January 2022 09:55:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(196, 43, 2, 20, null, null, null, null, 'Booked', '19 January 2022 19:25:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(197, 20, 3, 20, null, null, null, null, 'Booked', '20  January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(198, 3, 3, 20, null, null, null, null, 'Booked', '20 January 2022 18:45:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(199, 2, 3, 20, null, null, null, null, 'Cancelled', '20 January 2022 19:50:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(200, 38, 3, 20, null, null, null, null, 'Cancelled', '20 January 2022 09:55:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(201, 5, 3, 20, null, null, null, null, 'Booked', '20 January 2022 09:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(202, 16, 1, 21, null, null, null, null, 'Booked', '19 January 2022 14:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(203, 18, 1, 21, null, null, null, null, 'Booked', '19 January 2022 11:55:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(204, 21, 1, 21, null, null, null, null, 'Cancelled', '19 January 2022 19:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(205, 24, 1, 21, null, null, null, null, 'Cancelled', '19 January 2022 09:35:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(206, 28, 1, 21, null, null, null, null, 'Booked', '19 January 2022 17:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(207, 29, 1, 21, null, null, null, null, 'Booked', '19 January 2022 18:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(208, 39, 1, 21, null, null, null, null, 'Booked', '19 January 2022 01:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(209, 37, 1, 21, null, null, null, null, 'Booked', '19 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(210, 35, 1, 21, null, null, null, null, 'Booked', '19 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(211, 36, 1, 21, null, null, null, null, 'Booked', '19 January 2022 20:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(212,46 , 1, 21, null, null, null, null, 'Booked', '19 January 2022 19:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(213, 50, 1, 21, null, null, null, null, 'Booked', '19 January 2022 21:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(214, 48, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 15:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(215, 20, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 16:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(216, 4, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 14:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(217, 22, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 01:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(218, 13, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 05:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(219, 27, 1, 22, 1, 1, 100, 70, 'Cancelled', '22 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(220, 30, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 09:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(221, 32, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 10:15:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(222, 33, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 17:25:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(223, 31, 1, 22, 1, 1, 100, 70, 'Booked', '22 January 2022 11:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(224, 49, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(225, 28, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(226, 29, 1, 23, 1, 1, 10, 10, 'Cancelled', '18 January 2022 15:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(227, 44, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 05:10:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(228, 57, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 08:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(229, 42, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 04:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(230, 45, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 03:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(231, 53, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 08:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(232, 48, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 01:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(233, 21, 1, 23, 1, 1, 10, 10, 'Cancelled', '18 January 2022 05:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(234, 56, 1, 23, 1, 1, 10, 10, 'Booked', '18 January 2022 08:50:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(235, 45, 1, 15, 1, 1, 15, 15, 'Booked', '20 January 2022 19:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(236, 49, 1, 15, 1, 1, 15, 15, 'Booked', '20 January 2022 18:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(237, 2,  1, 15, 1, 1, 15, 15, 'Cancelled', '20 January 2022 17:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(238, 3,  1, 15, 1, 1, 15, 15, 'Booked', '20 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(239, 20, 1, 15, 1, 1, 15, 15, 'Booked', '20 January 2022 08:25:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(240, 26, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:30:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(241, 28, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 13:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(242, 19, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(243, 24, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(244, 23, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 13:10:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(245, 11, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 15:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(246, 48, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 06:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(247, 47, 1, 14, 1, null, 15, null, 'Booked', '18 January 2022 08:00:00')

INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(248, 8, 2, 15, 1, 1, 15, 15, 'Booked', '22 January 2022 01:00:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(249, 9, 2, 15, 1, 1, 15, 15, 'Booked', '22 January 2022 03:40:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(250, 1, 2, 15, 1, 1, 15, 15, 'Booked', '22 January 2022 05:20:00')
INSERT INTO Booking(BookingID, PgrID, SessionNo, EventID, NoOfAdultTickets, NoOfChildTickets, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime)
VALUES(251, 24, 2, 15, 1, 1, 15, 15, 'Booked', '22 January 2022 11:00:00') 


--Data for Ingredient relation
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(1, 'Beef')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(2, 'Rice noodle')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(3, 'Fish Sauce')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(4, 'Coriander')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(5, 'Salt')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(6, 'Baguette')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(7, 'Fish')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(8, 'Tumeric')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(9, 'Rice')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(10, 'Spring onions')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(11, 'Cheese')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(12, 'Feta')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(13, 'Tomato')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(14, 'Cucumber')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(15, 'Potato')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(16, 'Chicken')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(17, 'Lemon')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(18, 'Olive oil')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(19, 'Lamb')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(20, 'Spaghetti')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(21, 'Cream')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(22, 'Pancetta')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(23, 'Milk')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(24, 'Pizza dough')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(25, 'Pepperoni')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(26, 'Flour')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(27, 'Bread')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(28, 'Sugar')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(29, 'Yogurt')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(30, 'Egg')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(31, 'Lettuce')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(32, 'Garlic')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(33, 'Shrimps')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(34, 'Banana')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(35, 'Tomato Sauce')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(36, 'Lemongrass')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(37, 'Kalgan')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(38, 'Laim')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(39, 'Tofu')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(40, 'Tamarind')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(41, 'Green chili')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(42, 'Papaya')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(43, 'Rockets')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(44, 'Prawn')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(45, 'Pork Chop')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(46, 'Red bean')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(47, 'Bird''s nest')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(48, 'Rock sugar')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(49, 'Brocolli')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(50, 'Cabbage')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(51, 'Carrots')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(52, 'Condensed milk')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(53, 'Cumin')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(54, 'Black pepper')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(55, 'Cauliflower')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(56, 'Masala')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(57, 'Sandwich bun')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(58, 'Ham')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(59, 'Roquefort')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(60, 'Tortilla wrap')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(61, 'Tonkatsu sauce')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(62, 'Avocado')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(63, 'Baked beans')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(64, 'Jalapeno pepper')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(65, 'Ginseng chestnuts')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(66, 'Mushrooms')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(67, 'Pine nuts')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(68, 'Daikon')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(69, 'Soy beans')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(70, 'Yeast')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(71, 'Malt extract')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(72, 'Vegetable extract')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(73, 'White bread')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(74, 'Butter')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(75, 'Macaroni')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(76, 'Anchovies') -- caesars
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(77, 'Cinammon')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(78, 'Red berries')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(79, 'Jam')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(80, 'Yellow Pea')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(81, 'Fennel')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(82, 'Beetroot')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(83, 'Pork lard')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(84, 'Oysters')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(85, 'Mussels')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(86, 'Soy Sauce')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(87, 'Clams')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(88, 'Popcorn')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(89, 'Sardines')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(90, 'Corn')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(91, 'Lemon Zest')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(92, 'Aubergine')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(93, 'Pork')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(94, 'Vodka')
INSERT INTO Ingredient(IngredID, IngredName)
VALUES(95, 'Coconut')

-- Data for Eatery relation
INSERT INTO Eatery
Values(1, '8:30:00', '22:30:00', 120, '#02-15', 'Vietnam Cafe')
INSERT INTO Eatery
Values(2, '8:30:00', '22:00:00', 40, '#02-11', 'Greek food Good')
INSERT INTO Eatery
Values(3, '9:00:00', '23:00:00', 62, '#01-11', 'Italian indulgence')
INSERT INTO Eatery
Values(4, '8:00:00', '23:30:00', 23, '#03-01', 'Pakistani paradise')
INSERT INTO Eatery
Values(5, '9:00:00', '22:30:00', 55, '#03-05', 'Phillipine''s delight')
INSERT INTO Eatery
Values(6, '8:15:00', '22:30:00', 36, '#03-06', 'Great Thai Boat Noodles')
INSERT INTO Eatery
Values(7, '9:00:00', '22:00:00', 50, '#01-13', 'Japanese')
INSERT INTO Eatery
Values(8, '9:00:00', '22:30:00', 80, '#04-02', 'Chinese')
INSERT INTO Eatery
Values(9, '8:30:00', '22:30:00', 30, '#01-09', 'Indian')
INSERT INTO Eatery
Values(10, '9:00:00', '23:00:00', 110, '#01-07', 'French')
INSERT INTO Eatery
Values(11, '9:00:00', '22:00:00', 95, '#03-10', 'Mexican')
INSERT INTO Eatery
Values(12, '8:30:00', '22:00:00', 20, '#02-12', 'Korean')
INSERT INTO Eatery
Values(13, '9:00:00', '23:00:00', 15, '#02-13', 'Australian')
INSERT INTO Eatery
Values(14, '8:30:00', '22:30:00', 30, '#04-06', 'American')
INSERT INTO Eatery
Values(15, '9:00:00', '22:00:00', 40, '#04-04', 'Swedish')
INSERT INTO Eatery
Values(16, '9:00:00', '22:00:00', 130, '#05-08', 'Savoury Swistzerland')
INSERT INTO Eatery
Values(17, '8:00:00', '22:30:00', 120, '#05-12', 'Ukraine''s local delights')
INSERT INTO Eatery
Values(18, '8:30:00', '22:00:00', 60, '#03-16', 'Meal in Spain')
INSERT INTO Eatery
Values(19, '9:00:00', '22:30:00', 70, '#03-07', 'Classic Portugese')
INSERT INTO Eatery
Values(20, '8:00:00', '23:00:00', 50, '#03-02', 'Montenegrin restaurant')

-- Data for cuisine--
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(1, 'Vietnamese')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(2, 'Greek')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(3, 'Italian')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(4, 'Pakistani')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(5, 'Phillipino')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(6, 'Thai')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(7, 'Japanese')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(8, 'Chinese')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(9, 'Indian')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(10, 'French')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(11, 'Mexican')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(12, 'Korean')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(13, 'Australian')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(14, 'American')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(15, 'Swedish')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(16, 'Swiss')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(17, 'Ukrainian')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(18, 'Spanish')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(19, 'Portugese')
INSERT INTO Cuisine(cuisineID, cuisineName)
VALUES(20, 'Montenegrin')

--Data for Dish
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(1, 1, 1,'Pho', 'Noodle soup')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(2, 1, 1,'Banh Mi', 'sandwich with vegetables, omelette and various different fillings')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(3, 1, 1,'Cha ca', 'white fish, sauteed in butter with spring onions')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(4, 2, 2,'Greek Salad', 'Salad, with a greek spin to it')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(5, 2, 2,'Moussaka', ' It is an eggplant- or potato-based dish.')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(6, 2, 2,'Souvlaki', 'Little pieces of marinated pork, fried on grill')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(7, 3, 3,'Carbonara', 'Pasta with raw egg')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(8, 3, 3,'Panna cotta', 'A creamy dessert made of heaven, usually served with red-berry jam.')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(9, 3, 3,'Pizza', 'Margherita or Quattro Formaggi')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(10, 4, 4,'Shahi tukda', 'A sweet dish made with sliced bread, cream, sugar, milk and saffron')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(11, 4, 4,'Chicken tandoori', 'Chicken marinated and roasted in tandoor')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(12, 4, 4,'Raita', 'Vegetable salad with yogurt')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(13, 5, 5,'Adobo', 'Chicken cooked in garlic')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(14, 5, 5,'Torta', 'Omelette')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(15, 5, 5,'Puchero', 'A strange but intriguing mixture of taste, created by beef in bananas and tomato sauce')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(16, 6, 6,'Tom Yam Goong', 'A delicious soup with lemongrass, kalgan, laim, chilli, coco, shrimps and cream')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(17, 6, 6,'Pad Thai', 'A stir-fried rice noodle dish, made with tofu, eggs, tamarind and other delicious ingredients')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(18, 6, 6,'Som Tam', 'Spicy green papaya salad')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(19, 7, 7,'Tempura', 'Fried prawn')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(20, 7, 7,'Tonkatsu', 'Deep-fried pork cutlets')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(21, 7, 7,'Wagashi', 'Sweets, made of red bean past')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(22, 8, 8,'Bird''s nest soup', 'Prepared with the gelatinous product derived from the nests of cliff-dwelling birds')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(23, 8, 8,'Chop suey', 'Stir-fried dish with meat or shrimps and vegetables')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(24, 8, 8,'Man Tou', 'Fried buns with condensed milk')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(25, 9, 9,'Paneer Butter Masala', 'Tomato puree with cream and the traditional Indian herbs and spices')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(26, 9, 9,'Aloo Gobi',  'Side dish, made of potato and cauliflower')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(27, 9, 9,'Masala Tea', 'Tea with masala')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(28, 10, 10,'TarTar', 'Raw meat or fish, served with olive oil and flavors')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(29, 10, 10,'Croque-Monsieur', 'Toast sandwich with fried egg, ham and melted cheese in between bread')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(30, 10, 10,'Roquefort', 'Famous blue cheese')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(31, 11, 11,'Quessadilla ', 'A wrap with avocado, meat, chilli pepper and beans')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(32, 11, 11,'Guacamole', 'Avocado based dip')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(33, 11, 11,'Enchilladas ', 'Kind of Mexican lasagna')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(34, 12, 12,'Dolsotbap', 'Cooked rice in a stone pot (dolsot)')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(35, 12, 12,'Kimchi', 'Fermented vegetable dishes usually made with cabbage')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(36, 12, 12,'Kongguksu', 'A cold noodle dish with a broth made from ground soy beans')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(37, 13, 13,'Vegemite', 'Very salty and thick paste made from leftover brewers’ yeast with vegetable and spice additives')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(38, 13, 13,'Melbourne Chicken', 'Cooked in olive oil usually served with pink sauce')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(39, 13, 13,'Fairy bread', 'White bread with butter and sprinkles')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(40, 14, 14,'Mac & cheese', 'Pasta with cheese')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(41, 14, 14,'Caesar salad', 'An Iceberg salad, mixed with grilled chicken, Parmesan cheese and anchovy sauceS')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(42, 14, 14, 'Cheese cake', 'A cake, made of pressured Philadelphia cheese. Usually served with red-berry sauce')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(43, 15, 15,'Kanelbulle', 'Cinnamon bread roll')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(44, 15, 15,'Raggmunk', 'Potato pancakes')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(45, 15, 15,'Ärtsoppa', 'Yellow pea soup')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(46, 16, 16,'La Fondue', 'Melted cheese served in a communal pot to dip bread inside')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(47, 16, 16,'Les Röstis', 'Roasted potato')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(48, 16, 16,'La longeole', 'The traditional swiss sausage made of pork and fennel')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(49, 17, 17,'Borsch', 'A meat-beetroot soup, made with everything that was found in the fridge')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(50, 17, 17,'Salo', 'Salted pork fat. Sounds creepy, but it’s amazing')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(51, 17, 17, 'Gorilka', 'Homemade Ukrainian vodka')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(52, 18, 18,'Paella ', 'A Spanish risotto, usually with seafood')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(53, 18, 18,'Tapas ', 'Traditional Spanish snacks')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(54, 18, 18,'Jamon', 'A row cured meat. Delicious and flavorous')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(55, 19, 19,'Bacalhau', 'Raw fish in coconut or other marinade')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(56, 19, 19,'Pateis de Natal', 'Small sweet pastries')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(57, 19, 19,'Pollo arrosto', 'Street food roasted chicken')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(58, 20, 20,'Polenta', 'A dish made of corn flavour')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(59, 20, 20,'Stuffed peppers', 'Grilled peppers, stuffed with meat and vegetables. Served with a creamy sauce')
INSERT INTO Dish(DishID, cuisineID, EatyID, DishName, DishDescr)
VALUES(60, 20, 20,'Plieskavitsa', 'Grilled dish of spiced meat mixture of pork, beef and lamb')

--Data for CSDish
INSERT INTO CSDish(DishID, Price)
VALUES(1, 9)
INSERT INTO CSDish(DishID, Price)
VALUES(2, 34)
INSERT INTO CSDish(DishID, Price)
VALUES(4, 15)
INSERT INTO CSDish(DishID, Price)
VALUES(5, 30)
INSERT INTO CSDish(DishID, Price)
VALUES(7, 35)
INSERT INTO CSDish(DishID, Price)
VALUES(8, 10)
INSERT INTO CSDish(DishID, Price)
VALUES(10, 10)
INSERT INTO CSDish(DishID, Price)
VALUES(11, 38)
INSERT INTO CSDish(DishID, Price)
VALUES(13, 49)
INSERT INTO CSDish(DishID, Price)
VALUES(14, 12)
INSERT INTO CSDish(DishID, Price)
VALUES(16, 24)
INSERT INTO CSDish(DishID, Price)
VALUES(17, 25)
INSERT INTO CSDish(DishID, Price)
VALUES(19, 11)
INSERT INTO CSDish(DishID, Price)
VALUES(20, 40)
INSERT INTO CSDish(DishID, Price)
VALUES(22, 30)
INSERT INTO CSDish(DishID, Price)
VALUES(23, 24)
INSERT INTO CSDish(DishID, Price)
VALUES(25, 10)
INSERT INTO CSDish(DishID, Price)
VALUES(26, 12)
INSERT INTO CSDish(DishID, Price)
VALUES(28, 32)
INSERT INTO CSDish(DishID, Price)
VALUES(29, 30)
INSERT INTO CSDish(DishID, Price)
VALUES(31, 35)
INSERT INTO CSDish(DishID, Price)
VALUES(32, 15)
INSERT INTO CSDish(DishID, Price)
VALUES(34, 15)
INSERT INTO CSDish(DishID, Price)
VALUES(35, 25)
INSERT INTO CSDish(DishID, Price)
VALUES(37, 25)
INSERT INTO CSDish(DishID, Price)
VALUES(38, 12)
INSERT INTO CSDish(DishID, Price)
VALUES(40, 40)
INSERT INTO CSDish(DishID, Price)
VALUES(41, 0)
INSERT INTO CSDish(DishID, Price)
VALUES(43, 17)
INSERT INTO CSDish(DishID, Price)
VALUES(44, 30)
INSERT INTO CSDish(DishID, Price)
VALUES(46, 30)
INSERT INTO CSDish(DishID, Price)
VALUES(47, 40)
INSERT INTO CSDish(DishID, Price)
VALUES(49, 30)
INSERT INTO CSDish(DishID, Price)
VALUES(50, 28)
INSERT INTO CSDish(DishID, Price)
VALUES(52, 35)
INSERT INTO CSDish(DishID, Price)
VALUES(53, 42)
INSERT INTO CSDish(DishID, Price)
VALUES(55, 20)
INSERT INTO CSDish(DishID, Price)
VALUES(56, 13)
INSERT INTO CSDish(DishID, Price)
VALUES(58, 32)
INSERT INTO CSDish(DishID, Price)
VALUES(59, 25)

-- Data for orders
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(1, 47, '18 January 2022 00:30:00', 1, '18 January 2022 00:00:00', 9, 360)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(2, 26, '19 January 2022 00:35:00', 2, '19 January 2022 00:05:00', 6, 72)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(3, 41, '20 January 2022 16:15:00', 2, '20 January 2022 15:45:00 ', 1, 0)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(3, 7, '19 January 2022 18:10:00', 2, '19 January 2022 17:35:00', 3, 105)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(3, 8, '22 January 2022 04:15:00', 2, '22 January 2022 03:35:00', 1, 10)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(4, 11, '21 January 2022 04:05:00', 6, '21 January 2022 03:45:00', 2, 76)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(4, 34, '18 January 2022 04:20:00', 6, '18 January 2022 03:55:00', 1, 15)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(5, 49, '20 January 2022 04:40:00', 5, '20 January 2022 04:00:00', 8, 240)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(6, 32, '22 January 2022 04:40:00', 3, '22 January 2022 04:10:00', 2, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(6, 26, '21 January 2022 05:20:00', 3, '21 January 2022 04:50:00', 1, 12)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(7, 1, '21 January 2022 05:25:00', 3, '21 January 2022 05:15:00', 2, 18)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(8, 2, '20 January 2022 06:00:00', 4, '20 January 2022 05:40:00', 9, 306)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(8, 35, '23 January 2022 06:25:00', 4, '23 January 2022 06:05:00', 1, 25)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(9, 31, '19 January 2022 06:35:00', 4, '19 January 2022 06:15:00', 1, 35)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(9, 32, '21 January 2022 07:00:00', 4, '21 January 2022 06:35:00', 3, 45)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(9, 46, '20 January 2022 06:55:00', 4, '20 January 2022 06:40:00', 1, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(10, 43, '22 January 2022 07:25:00', 5, '22 January 2022 07:00:00', 5, 85)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(11, 17, '20 January 2022 07:25:00', 5, '20 January 2022 07:05:00', 4, 100)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(12, 34, '21 January 2022 07:55:00', 7, '21 January 2022 07:10:00', 5, 75)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(13, 59, '20 January 2022 07:50:00', 1, '20 January 2022 07:25:00', 4, 100)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(14, 4, '22 January 2022 07:40:00', 8, '22 January 2022 07:35:00', 2, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(14, 37, '18 January 2022 07:55:00', 8, '18 January 2022 07:45:00', 2, 50)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(14, 40, '18 January 2022 08:25:00', 8, '18 January 2022 08:00:00', 3, 120)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(15, 10, '21 January 2022 08:35:00', 9, '21 January 2022 08:15:00', 1, 10)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(16, 46, '22 January 2022 09:45:00', 1, '22 January 2022 09:05:00', 2, 60)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(17, 5, '19 January 2022 09:35:00', 7, '19 January 2022 09:15:00', 1, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(18, 4, '19 January 2022 09:55:00', 3, '19 January 2022 09:25:00', 3, 45)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(18, 22, '22 January 2022 10:45:00', 3, '22 January 2022 10:30:00', 1, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(18, 44, '19 January 2022 10:45:00', 3, '19 January 2022 10:35:00', 1, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(19, 32, '20 January 2022 10:55:00', 7, '20 January 2022 10:45:00', 3, 45)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(19, 49, '18 January 2022 12:10:00', 7, '18 January 2022 11:25:00', 5, 150)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(21, 38, '23 January 2022 12:00:00', 4, '23 January 2022 11:40:00', 3, 36)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(22, 13, '18 January 2022 12:55:00', 6, '18 January 2022 12:20:00', 5, 245)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(22, 47, '19 January 2022 12:45:00', 6, '19 January 2022 12:30:00', 2, 80)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(23, 16, '23 January 2022 12:55:00', 10, '23 January 2022 12:50:00', 4, 96)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(23, 46, '21 January 2022 13:15:00', 10, '21 January 2022 13:00:00', 2, 60)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(24, 14, '19 January 2022 13:50:00', 4, '19 January 2022 13:25:00', 2, 24)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(25, 8, '23 January 2022 13:40:00', 11, '23 January 2022 13:35:00', 1, 10)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(25, 47, '22 January 2022 14:40:00', 11, '22 January 2022 14:25:00', 5, 200)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(27, 31, '22 January 2022 14:35:00', 13, '22 January 2022 14:30:00', 4, 140)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(30, 4, '21 January 2022 15:10:00', 13, '21 January 2022 14:50:00', 1, 15)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(30, 23, '20 January 2022 15:15:00', 13, '20 January 2022 14:55:00', 3, 72)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(31, 50, '22 January 2022 15:20:00', 13, '22 January 2022 15:05:00', 5, 140)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(32, 2, '21 January 2022 15:45:00', 13, '21 January 2022 15:40:00', 1, 34)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(32, 8, '23 January 2022 15:55:00', 13, '23 January 2022 15:45:00', 3, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(32, 13, '21 January 2022 16:00:00', 13, '21 January 2022 15:50:00', 5, 245)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(33, 44, '22 January 2022 16:30:00', 13, '22 January 2022 15:55:00', 4, 120)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(35, 16, '21 January 2022 16:25:00', 14, '21 January 2022 16:00:00', 5, 120)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(37, 22, '23 January 2022 16:25:00', 16, '23 January 2022 16:10:00', 3, 90)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(37, 23, '20 January 2022 16:25:00', 16, '20 January 2022 16:15:00', 4, 96)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(39, 16, '20 January 2022 16:55:00', 16, '20 January 2022 16:20:00', 3, 72)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(40, 28, '19 January 2022 17:00:00', 18, '19 January 2022 16:55:00', 4, 128)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(41, 23, '18 January 2022 17:25:00', 19, '18 January 2022 17:05:00', 3, 72)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(41, 26, '21 January 2022 17:25:00', 19, '21 January 2022 17:15:00', 2, 24)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(42, 55, '23 January 2022 17:45:00', 19, '23 January 2022 17:35:00', 3, 60)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(43, 13, '18 January 2022 17:55:00', 19, '18 January 2022 17:40:00', 5, 245)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(43, 49, '22 January 2022 17:50:00', 20, '22 January 2022 17:45:00', 2, 60)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(44, 38, '23 January 2022 18:10:00', 19, '23 January 2022 18:05:00', 2, 24)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(44, 59, '23 January 2022 18:35:00', 19, '23 January 2022 18:25:00', 2, 50)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(46, 14, '22 January 2022 18:50:00', 22, '22 January 2022 18:45:00', 4, 48)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(47, 4, '22 January 2022 19:15:00', 20, '22 January 2022 19:10:00', 2, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(47, 46, '22 January 2022 19:50:00', 20, '22 January 2022 19:40:00', 1, 30)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(48, 4, '22 January 2022 20:15:00', 18, '22 January 2022 19:45:00', 3, 45)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(49, 46, '19 January 2022 20:00:00', 21, '19 January 2022 19:55:00', 3, 90)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(49, 20, '20 January 2022 20:10:00', 21, '20 January 2022 20:00:00', 3, 120)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(51, 52, '23 January 2022 20:35:00', 23, '23 January 2022 20:05:00', 2, 70)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(51, 59, '22 January 2022 20:15:00', 23, '22 January 2022 20:10:00', 3, 75)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(52, 19, '20 January 2022 20:40:00', 24, '20 January 2022 20:35:00', 4, 44)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(52, 56, '21 January 2022 20:55:00', 24, '21 January 2022 20:50:00', 2, 26)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(53, 50, '20 January 2022 21:10:00', 25, '20 January 2022 20:55:00', 5, 140)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(54, 2, '19 January 2022 21:25:00', 26, '19 January 2022 21:10:00', 4, 136)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(55, 28, '20 January 2022 21:25:00', 27, '20 January 2022 21:15:00', 3, 96)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(58, 10, '20 January 2022 21:50:00', 30, '20 January 2022 21:25:00', 1, 10)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(58, 17, '18 January 2022 22:40:00', 30, '18 January 2022 22:10:00', 2, 50)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(58, 43, '20 January 2022 22:45:00', 30, '20 January 2022 22:30:00', 2, 34)
INSERT INTO orders(PgrID, DishID, DelDateTime, DeliverTo, OrderDateTime, OrderQty, OrderPrice)
VALUES(58, 50, '20 January 2022 22:45:00', 30, '20 January 2022 22:35:00', 3, 84)

--Data for [contains]
INSERT INTO [contains](DishID, IngredID)
VALUES(1, 1)
INSERT INTO [contains](DishID, IngredID)
VALUES(1, 2)
INSERT INTO [contains](DishID, IngredID)
VALUES(1, 3)
INSERT INTO [contains](DishID, IngredID)
VALUES(1, 4)
INSERT INTO [contains](DishID, IngredID)
VALUES(2, 4)
INSERT INTO [contains](DishID, IngredID)
VALUES(2, 5)
INSERT INTO [contains](DishID, IngredID)
VALUES(2, 30)
INSERT INTO [contains](DishID, IngredID)
VALUES(3, 7)
INSERT INTO [contains](DishID, IngredID)
VALUES(3, 10)
INSERT INTO [contains](DishID, IngredID)
VALUES(3, 74)
INSERT INTO [contains](DishID, IngredID)
VALUES(4, 11)
INSERT INTO [contains](DishID, IngredID)
VALUES(4, 12)
INSERT INTO [contains](DishID, IngredID)
VALUES(4, 13)
INSERT INTO [contains](DishID, IngredID)
VALUES(4, 14)
INSERT INTO [contains](DishID, IngredID)
VALUES(5, 15)
INSERT INTO [contains](DishID, IngredID)
VALUES(5, 92)
INSERT INTO [contains](DishID, IngredID)
VALUES(6, 93)
INSERT INTO [contains](DishID, IngredID)
VALUES(7, 20)
INSERT INTO [contains](DishID, IngredID)
VALUES(7, 21)
INSERT INTO [contains](DishID, IngredID)
VALUES(7, 22)
INSERT INTO [contains](DishID, IngredID)
VALUES(7, 23)
INSERT INTO [contains](DishID, IngredID)
VALUES(8, 23)
INSERT INTO [contains](DishID, IngredID)
VALUES(8, 78)
INSERT INTO [contains](DishID, IngredID)
VALUES(9, 24)
INSERT INTO [contains](DishID, IngredID)
VALUES(9, 25)
INSERT INTO [contains](DishID, IngredID)
VALUES(9, 26)
INSERT INTO [contains](DishID, IngredID)
VALUES(10, 23)
INSERT INTO [contains](DishID, IngredID)
VALUES(10, 21)
INSERT INTO [contains](DishID, IngredID)
VALUES(11, 16)
INSERT INTO [contains](DishID, IngredID)
VALUES(11, 23)
INSERT INTO [contains](DishID, IngredID)
VALUES(12, 29)
INSERT INTO [contains](DishID, IngredID)
VALUES(12, 4)
INSERT INTO [contains](DishID, IngredID)
VALUES(12, 14)
INSERT INTO [contains](DishID, IngredID)
VALUES(12, 53)
INSERT INTO [contains](DishID, IngredID)
VALUES(13, 16)
INSERT INTO [contains](DishID, IngredID)
VALUES(13, 32)
INSERT INTO [contains](DishID, IngredID)
VALUES(13, 5)
INSERT INTO [contains](DishID, IngredID)
VALUES(13, 86)
INSERT INTO [contains](DishID, IngredID)
VALUES(14, 30)
INSERT INTO [contains](DishID, IngredID)
VALUES(14, 10)
INSERT INTO [contains](DishID, IngredID)
VALUES(15, 35)
INSERT INTO [contains](DishID, IngredID)
VALUES(15, 34)
INSERT INTO [contains](DishID, IngredID)
VALUES(15, 1)
INSERT INTO [contains](DishID, IngredID)
VALUES(16, 36)
INSERT INTO [contains](DishID, IngredID)
VALUES(16, 37)
INSERT INTO [contains](DishID, IngredID)
VALUES(16, 38)
INSERT INTO [contains](DishID, IngredID)
VALUES(17, 2)
INSERT INTO [contains](DishID, IngredID)
VALUES(17, 30)
INSERT INTO [contains](DishID, IngredID)
VALUES(17, 39)
INSERT INTO [contains](DishID, IngredID)
VALUES(17, 40)
INSERT INTO [contains](DishID, IngredID)
VALUES(18, 13)
INSERT INTO [contains](DishID, IngredID)
VALUES(18, 3)
INSERT INTO [contains](DishID, IngredID)
VALUES(18, 32)
INSERT INTO [contains](DishID, IngredID)
VALUES(18, 41)
INSERT INTO [contains](DishID, IngredID)
VALUES(18, 42)
INSERT INTO [contains](DishID, IngredID)
VALUES(19, 30)
INSERT INTO [contains](DishID, IngredID)
VALUES(19, 26)
INSERT INTO [contains](DishID, IngredID)
VALUES(19, 33)
INSERT INTO [contains](DishID, IngredID)
VALUES(19, 44)
INSERT INTO [contains](DishID, IngredID)
VALUES(20, 45)
INSERT INTO [contains](DishID, IngredID)
VALUES(20, 50)
INSERT INTO [contains](DishID, IngredID)
VALUES(20, 61)
INSERT INTO [contains](DishID, IngredID)
VALUES(21, 46)
INSERT INTO [contains](DishID, IngredID)
VALUES(21, 48)
INSERT INTO [contains](DishID, IngredID)
VALUES(22, 47)
INSERT INTO [contains](DishID, IngredID)
VALUES(23, 16)
INSERT INTO [contains](DishID, IngredID)
VALUES(23, 93)
INSERT INTO [contains](DishID, IngredID)
VALUES(24, 26)
INSERT INTO [contains](DishID, IngredID)
VALUES(25, 13)
INSERT INTO [contains](DishID, IngredID)
VALUES(25, 53)
INSERT INTO [contains](DishID, IngredID)
VALUES(25, 54)
INSERT INTO [contains](DishID, IngredID)
VALUES(25, 56)
INSERT INTO [contains](DishID, IngredID)
VALUES(26, 15)
INSERT INTO [contains](DishID, IngredID)
VALUES(26, 55)
INSERT INTO [contains](DishID, IngredID)
VALUES(27, 56)
INSERT INTO [contains](DishID, IngredID)
VALUES(28, 18)
INSERT INTO [contains](DishID, IngredID)
VALUES(28, 7)
INSERT INTO [contains](DishID, IngredID)
VALUES(29, 30)
INSERT INTO [contains](DishID, IngredID)
VALUES(29, 11)
INSERT INTO [contains](DishID, IngredID)
VALUES(29, 7)
INSERT INTO [contains](DishID, IngredID)
VALUES(30, 59)
INSERT INTO [contains](DishID, IngredID)
VALUES(31, 60)
INSERT INTO [contains](DishID, IngredID)
VALUES(31, 62)
INSERT INTO [contains](DishID, IngredID)
VALUES(31, 63)
INSERT INTO [contains](DishID, IngredID)
VALUES(31, 64)
INSERT INTO [contains](DishID, IngredID)
VALUES(32, 62)
INSERT INTO [contains](DishID, IngredID)
VALUES(32, 13)
INSERT INTO [contains](DishID, IngredID)
VALUES(33, 11)
INSERT INTO [contains](DishID, IngredID)
VALUES(33, 16)
INSERT INTO [contains](DishID, IngredID)
VALUES(33, 61)
INSERT INTO [contains](DishID, IngredID)
VALUES(34, 65)
INSERT INTO [contains](DishID, IngredID)
VALUES(34, 9)
INSERT INTO [contains](DishID, IngredID)
VALUES(34, 66)
INSERT INTO [contains](DishID, IngredID)
VALUES(34, 67)
INSERT INTO [contains](DishID, IngredID)
VALUES(35, 9)
INSERT INTO [contains](DishID, IngredID)
VALUES(35, 50)
INSERT INTO [contains](DishID, IngredID)
VALUES(36, 68)
INSERT INTO [contains](DishID, IngredID)
VALUES(36, 69)
INSERT INTO [contains](DishID, IngredID)
VALUES(37, 70)
INSERT INTO [contains](DishID, IngredID)
VALUES(37, 71)
INSERT INTO [contains](DishID, IngredID)
VALUES(37, 72)
INSERT INTO [contains](DishID, IngredID)
VALUES(38, 16)
INSERT INTO [contains](DishID, IngredID)
VALUES(38, 18)
INSERT INTO [contains](DishID, IngredID)
VALUES(39, 73)
INSERT INTO [contains](DishID, IngredID)
VALUES(40, 11)
INSERT INTO [contains](DishID, IngredID)
VALUES(40, 75)
INSERT INTO [contains](DishID, IngredID)
VALUES(41, 76)
INSERT INTO [contains](DishID, IngredID)
VALUES(41, 13)
INSERT INTO [contains](DishID, IngredID)
VALUES(41, 14)
INSERT INTO [contains](DishID, IngredID)
VALUES(41, 43)
INSERT INTO [contains](DishID, IngredID)
VALUES(42, 26)
INSERT INTO [contains](DishID, IngredID)
VALUES(42, 12)
INSERT INTO [contains](DishID, IngredID)
VALUES(42, 28)
INSERT INTO [contains](DishID, IngredID)
VALUES(43, 77)
INSERT INTO [contains](DishID, IngredID)
VALUES(43, 27)
INSERT INTO [contains](DishID, IngredID)
VALUES(44, 15)
INSERT INTO [contains](DishID, IngredID)
VALUES(44, 26)
INSERT INTO [contains](DishID, IngredID)
VALUES(45, 51)
INSERT INTO [contains](DishID, IngredID)
VALUES(45, 5)
INSERT INTO [contains](DishID, IngredID)
VALUES(45, 80)
INSERT INTO [contains](DishID, IngredID)
VALUES(46, 11)
INSERT INTO [contains](DishID, IngredID)
VALUES(46, 12)
INSERT INTO [contains](DishID, IngredID)
VALUES(46, 27)
INSERT INTO [contains](DishID, IngredID)
VALUES(47, 15)
INSERT INTO [contains](DishID, IngredID)
VALUES(48, 93)
INSERT INTO [contains](DishID, IngredID)
VALUES(48, 81)
INSERT INTO [contains](DishID, IngredID)
VALUES(49, 82)
INSERT INTO [contains](DishID, IngredID)
VALUES(49, 1)
INSERT INTO [contains](DishID, IngredID)
VALUES(50, 5)
INSERT INTO [contains](DishID, IngredID)
VALUES(50, 83)
INSERT INTO [contains](DishID, IngredID)
VALUES(51, 94)
INSERT INTO [contains](DishID, IngredID)
VALUES(52, 84)
INSERT INTO [contains](DishID, IngredID)
VALUES(52, 85)
INSERT INTO [contains](DishID, IngredID)
VALUES(52, 86)
INSERT INTO [contains](DishID, IngredID)
VALUES(52, 87)
INSERT INTO [contains](DishID, IngredID)
VALUES(53, 88)
INSERT INTO [contains](DishID, IngredID)
VALUES(53, 89)
INSERT INTO [contains](DishID, IngredID)
VALUES(53, 90)
INSERT INTO [contains](DishID, IngredID)
VALUES(54, 7)
INSERT INTO [contains](DishID, IngredID)
VALUES(55, 90)
INSERT INTO [contains](DishID, IngredID)
VALUES(55, 95)
INSERT INTO [contains](DishID, IngredID)
VALUES(56, 90)
INSERT INTO [contains](DishID, IngredID)
VALUES(56, 28)
INSERT INTO [contains](DishID, IngredID)
VALUES(57, 16)
INSERT INTO [contains](DishID, IngredID)
VALUES(58, 90)
INSERT INTO [contains](DishID, IngredID)
VALUES(59, 64)
INSERT INTO [contains](DishID, IngredID)
VALUES(59, 21)
INSERT INTO [contains](DishID, IngredID)
VALUES(59, 22)
INSERT INTO [contains](DishID, IngredID)
VALUES(59, 23)
INSERT INTO [contains](DishID, IngredID)
VALUES(60, 1)
INSERT INTO [contains](DishID, IngredID)
VALUES(60, 19)
INSERT INTO [contains](DishID, IngredID)
VALUES(60, 93)
INSERT INTO [contains](DishID, IngredID)
VALUES(60, 57)
INSERT INTO [contains](DishID, IngredID)
VALUES(60, 8)

-- Data for FoodCategory
INSERT INTO FoodCategory
Values(1, 'Kosher', 'Kosher food for Jewish passengers')
INSERT INTO FoodCategory
Values(2, 'International', 'International food for general passengers')
INSERT INTO FoodCategory
Values(3, 'Halal', 'Halal food for Muslim passengers')
INSERT INTO FoodCategory
Values(4, 'Vegan', 'Vegan food for vegan passengers')
INSERT INTO FoodCategory
Values(5, 'Vegetarian', 'Vegetarian food for vegetarian passengers' )
INSERT INTO FoodCategory
Values(6, 'Raw', 'Raw, unprocessed food for passengers and preparation')
INSERT INTO FoodCategory
Values(7, 'Processed', 'Processed, packaged food for passengers')
INSERT INTO FoodCategory
Values(8, 'Gluten-free', 'Gluten-free food for gluten-allergic passengers')
INSERT INTO FoodCategory
Values(9, 'Shellfish-free', 'Shellfish-free food for shellfish-allergic passengers')
INSERT INTO FoodCategory
Values(10, 'Nut-free', 'Nut-free food for nut-allergic passengers')

-- Data for categorised_in <FcID>, <DishID>
INSERT INTO categorised_in 
Values (1, 1)
INSERT INTO categorised_in 
Values (1, 2)
INSERT INTO categorised_in 
Values (1, 3)
INSERT INTO categorised_in 
Values (1, 4)
INSERT INTO categorised_in 
Values (1, 5)
INSERT INTO categorised_in 
Values (1, 7)
INSERT INTO categorised_in 
Values (1, 8)
INSERT INTO categorised_in 
Values (1, 9)
INSERT INTO categorised_in 
Values (1, 10)
INSERT INTO categorised_in 
Values (1, 11)
INSERT INTO categorised_in 
Values (1, 12)
INSERT INTO categorised_in 
Values (1, 13)
INSERT INTO categorised_in 
Values (1, 14)
INSERT INTO categorised_in 
Values (1, 15)
INSERT INTO categorised_in 
Values (1, 18)
INSERT INTO categorised_in 
Values (1, 21)
INSERT INTO categorised_in 
Values (1, 22)
INSERT INTO categorised_in 
Values (1, 24)
INSERT INTO categorised_in 
Values (1, 25)
INSERT INTO categorised_in 
Values (1, 27)
INSERT INTO categorised_in 
Values (1, 28)
INSERT INTO categorised_in 
Values (1, 29)
INSERT INTO categorised_in 
Values (1, 30)
INSERT INTO categorised_in 
Values (1, 31)
INSERT INTO categorised_in 
Values (1, 32)
INSERT INTO categorised_in 
Values (1, 33)
INSERT INTO categorised_in 
Values (1, 34)
INSERT INTO categorised_in 
Values (1, 35)
INSERT INTO categorised_in 
Values (1, 36)
INSERT INTO categorised_in 
Values (1, 37)
INSERT INTO categorised_in 
Values (1, 38)
INSERT INTO categorised_in 
Values (1, 39)
INSERT INTO categorised_in 
Values (1, 40)
INSERT INTO categorised_in 
Values (1, 41)
INSERT INTO categorised_in 
Values (1, 42)
INSERT INTO categorised_in 
Values (1, 43)
INSERT INTO categorised_in 
Values (1, 44)
INSERT INTO categorised_in 
Values (1, 45)
INSERT INTO categorised_in 
Values (1, 46)
INSERT INTO categorised_in 
Values (1, 47)
INSERT INTO categorised_in 
Values (1, 49)
INSERT INTO categorised_in 
Values (1, 53)
INSERT INTO categorised_in 
Values (1, 55)
INSERT INTO categorised_in 
Values (1, 56)
INSERT INTO categorised_in 
Values (1, 57)
INSERT INTO categorised_in 
Values (1, 58)
INSERT INTO categorised_in 
Values (1, 59)
INSERT INTO categorised_in 
Values (2, 1)
INSERT INTO categorised_in 
Values (2, 2)
INSERT INTO categorised_in 
Values (2, 3)
INSERT INTO categorised_in 
Values (2, 4)
INSERT INTO categorised_in 
Values (2, 5)
INSERT INTO categorised_in 
Values (2, 6)
INSERT INTO categorised_in 
Values (2, 7)
INSERT INTO categorised_in 
Values (2, 8)
INSERT INTO categorised_in 
Values (2, 9)
INSERT INTO categorised_in 
Values (2, 10)
INSERT INTO categorised_in 
Values (2, 11)
INSERT INTO categorised_in 
Values (2, 12)
INSERT INTO categorised_in 
Values (2, 13)
INSERT INTO categorised_in 
Values (2, 14)
INSERT INTO categorised_in 
Values (2, 15)
INSERT INTO categorised_in 
Values (2, 16)
INSERT INTO categorised_in 
Values (2, 17)
INSERT INTO categorised_in 
Values (2, 18)
INSERT INTO categorised_in 
Values (2, 19)
INSERT INTO categorised_in 
Values (2, 20)
INSERT INTO categorised_in 
Values (2, 21)
INSERT INTO categorised_in 
Values (2, 22)
INSERT INTO categorised_in 
Values (2, 23)
INSERT INTO categorised_in 
Values (2, 24)
INSERT INTO categorised_in 
Values (2, 25)
INSERT INTO categorised_in 
Values (2, 26)
INSERT INTO categorised_in 
Values (2, 27)
INSERT INTO categorised_in 
Values (2, 28)
INSERT INTO categorised_in 
Values (2, 29)
INSERT INTO categorised_in 
Values (2, 30)
INSERT INTO categorised_in 
Values (2, 31)
INSERT INTO categorised_in 
Values (2, 32)
INSERT INTO categorised_in 
Values (2, 33)
INSERT INTO categorised_in 
Values (2, 34)
INSERT INTO categorised_in 
Values (2, 35)
INSERT INTO categorised_in 
Values (2, 36)
INSERT INTO categorised_in 
Values (2, 37)
INSERT INTO categorised_in 
Values (2, 38)
INSERT INTO categorised_in 
Values (2, 39)
INSERT INTO categorised_in 
Values (2, 40)
INSERT INTO categorised_in 
Values (2, 41)
INSERT INTO categorised_in 
Values (2, 42)
INSERT INTO categorised_in 
Values (2, 43)
INSERT INTO categorised_in 
Values (2, 44)
INSERT INTO categorised_in 
Values (2, 45)
INSERT INTO categorised_in 
Values (2, 46)
INSERT INTO categorised_in 
Values (2, 47)
INSERT INTO categorised_in 
Values (2, 48)
INSERT INTO categorised_in 
Values (2, 49)
INSERT INTO categorised_in 
Values (2, 50)
INSERT INTO categorised_in 
Values (2, 51)
INSERT INTO categorised_in 
Values (2, 52)
INSERT INTO categorised_in 
Values (2, 53)
INSERT INTO categorised_in 
Values (2, 54)
INSERT INTO categorised_in 
Values (2, 55)
INSERT INTO categorised_in 
Values (2, 56)
INSERT INTO categorised_in 
Values (2, 57)
INSERT INTO categorised_in 
Values (2, 58)
INSERT INTO categorised_in 
Values (2, 59)
INSERT INTO categorised_in 
Values (2, 60)
INSERT INTO categorised_in 
Values (3, 1)
INSERT INTO categorised_in 
Values (10, 1)
INSERT INTO categorised_in 
Values (3, 2)
INSERT INTO categorised_in 
Values (7, 2)
INSERT INTO categorised_in 
Values (10, 2)
INSERT INTO categorised_in 
Values (9, 3)
INSERT INTO categorised_in 
Values (10, 3)
INSERT INTO categorised_in 
Values (3, 4)
INSERT INTO categorised_in 
Values (7, 4)
INSERT INTO categorised_in 
Values (5, 4)
INSERT INTO categorised_in 
Values (9, 5)
INSERT INTO categorised_in 
Values (7, 5)
INSERT INTO categorised_in 
Values (9, 6)
INSERT INTO categorised_in 
Values (6, 6)
INSERT INTO categorised_in 
Values (3, 7)
INSERT INTO categorised_in 
Values (7, 7)
INSERT INTO categorised_in 
Values (3, 8)
INSERT INTO categorised_in 
Values (7, 8)
INSERT INTO categorised_in 
Values (3, 9)
INSERT INTO categorised_in 
Values (7, 9)
INSERT INTO categorised_in 
Values (3, 10)
INSERT INTO categorised_in 
Values (5, 10)
INSERT INTO categorised_in 
Values (3, 11)
INSERT INTO categorised_in 
Values (9, 11)
INSERT INTO categorised_in 
Values (5, 12)
INSERT INTO categorised_in 
Values (6, 12)
INSERT INTO categorised_in 
Values (3, 13)
INSERT INTO categorised_in 
Values (9, 13)
INSERT INTO categorised_in 
Values (10, 14)
INSERT INTO categorised_in 
Values (5, 14)
INSERT INTO categorised_in 
Values (7, 15)
INSERT INTO categorised_in 
Values (9, 15)
INSERT INTO categorised_in 
Values (3, 16)
INSERT INTO categorised_in 
Values (7, 16)
INSERT INTO categorised_in 
Values (3, 17)
INSERT INTO categorised_in 
Values (10, 17)
INSERT INTO categorised_in 
Values (4, 18)
INSERT INTO categorised_in 
Values (6, 18)
INSERT INTO categorised_in 
Values (3, 19)
INSERT INTO categorised_in 
Values (7, 19)
INSERT INTO categorised_in 
Values (7, 20)
INSERT INTO categorised_in 
Values (9, 20)
INSERT INTO categorised_in 
Values (4, 21)
INSERT INTO categorised_in 
Values (7, 21)
INSERT INTO categorised_in 
Values (7, 22)
INSERT INTO categorised_in 
Values (9, 22)
INSERT INTO categorised_in 
Values (3, 23)
INSERT INTO categorised_in 
Values (10, 23)
INSERT INTO categorised_in 
Values (7, 24)
INSERT INTO categorised_in 
Values (4, 24)
INSERT INTO categorised_in 
Values (5, 25)
INSERT INTO categorised_in 
Values (7, 25)
INSERT INTO categorised_in 
Values (4, 26)
INSERT INTO categorised_in 
Values (9, 26)
INSERT INTO categorised_in 
Values (4, 27)
INSERT INTO categorised_in 
Values (9, 27)
INSERT INTO categorised_in 
Values (6, 28)
INSERT INTO categorised_in 
Values (3, 28)
INSERT INTO categorised_in 
Values (10, 29)
INSERT INTO categorised_in 
Values (7, 29)
INSERT INTO categorised_in 
Values (5, 30)
INSERT INTO categorised_in 
Values (7, 30)
INSERT INTO categorised_in 
Values (7, 31)
INSERT INTO categorised_in 
Values (9, 31)
INSERT INTO categorised_in 
Values (10, 32)
INSERT INTO categorised_in 
Values (4, 32)
INSERT INTO categorised_in 
Values (7, 33)
INSERT INTO categorised_in 
Values (10, 33)
INSERT INTO categorised_in 
Values (9, 34)
INSERT INTO categorised_in 
Values (10, 34)
INSERT INTO categorised_in 
Values (4, 35)
INSERT INTO categorised_in 
Values (5, 35)
INSERT INTO categorised_in 
Values (5, 36)
INSERT INTO categorised_in 
Values (9, 36)
INSERT INTO categorised_in 
Values (7, 37)
INSERT INTO categorised_in 
Values (4, 37) 
INSERT INTO categorised_in 
Values (3, 38)
INSERT INTO categorised_in 
Values (7, 38)
INSERT INTO categorised_in 
Values (7, 39)
INSERT INTO categorised_in 
Values (4, 39)
INSERT INTO categorised_in 
Values (5, 40)
INSERT INTO categorised_in 
Values (7, 40)
INSERT INTO categorised_in 
Values (7, 41)
INSERT INTO categorised_in 
Values (10, 41)
INSERT INTO categorised_in 
Values (7, 42)
INSERT INTO categorised_in 
Values (4, 42)
INSERT INTO categorised_in 
Values (4, 43)
INSERT INTO categorised_in 
Values (7, 43)
INSERT INTO categorised_in 
Values (4, 44)
INSERT INTO categorised_in 
Values (9, 44)
INSERT INTO categorised_in 
Values (4, 45)
INSERT INTO categorised_in 
Values (9, 45)
INSERT INTO categorised_in 
Values (7, 46)
INSERT INTO categorised_in 
Values (9, 46)
INSERT INTO categorised_in 
Values (4, 47)
INSERT INTO categorised_in 
Values (9, 47)
INSERT INTO categorised_in 
Values (9, 48)
INSERT INTO categorised_in 
Values (10, 48)
INSERT INTO categorised_in 
Values (9, 49)
INSERT INTO categorised_in 
Values (8, 49)
INSERT INTO categorised_in 
Values (7, 50)
INSERT INTO categorised_in 
Values (8, 50)
INSERT INTO categorised_in 
Values (4, 51)
INSERT INTO categorised_in 
Values (5, 51)
INSERT INTO categorised_in 
Values (3, 52)
INSERT INTO categorised_in 
Values (10, 52)
INSERT INTO categorised_in 
Values (5, 53)
INSERT INTO categorised_in 
Values (6, 53)
INSERT INTO categorised_in 
Values (7, 54)
INSERT INTO categorised_in 
Values (8, 54)
INSERT INTO categorised_in 
Values (3, 55)
INSERT INTO categorised_in 
Values (6, 55)
INSERT INTO categorised_in 
Values (4, 56)
INSERT INTO categorised_in 
Values (5, 56)
INSERT INTO categorised_in 
Values (9, 57)
INSERT INTO categorised_in 
Values (8, 57)
INSERT INTO categorised_in 
Values (7, 58)
INSERT INTO categorised_in 
Values (4, 58)
INSERT INTO categorised_in 
Values (10, 59)
INSERT INTO categorised_in 
Values (3, 59)
INSERT INTO categorised_in 
Values (7, 60)
INSERT INTO categorised_in 
Values (10, 60)


-- Data for reservation
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(1, 1, 10, 'Booked', '20 January 2022 14:25:00', '19 January 2022 12:30:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(2, 2, 10, 'Booked', '20 January 2022 18:00:00', '19 January 2022 17:05:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(3, 2, 18, 'Booked', '23 January 2022 19:40:00', '22 January 2022 19:30:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(4, 2, 16, 'Booked', '19 January 2022 20:15:00', '18 January 2022 19:55:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(5, 2, 22, 'Cancelled', '22 January 2022 21:00:00', '21 January 2022 20:30:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(6, 2, 22, 'Booked', '19 January 2022 15:30:00', '18 January 2022 11:50:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(7, 2, 14, 'Booked', '22 January 2022 16:05:00', '21 January 2022 12:35:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(8, 2, 13, 'Booked', '19 January 2022 20:00:00', '18 January 2022 13:45:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(9, 2, 20, 'Booked', '23 January 2022 20:40:00', '22 January 2022 18:35:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(10, 3, 22, 'Booked', '22 January 2022 20:55:00', '21 January 2022 20:30:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(11, 3, 33, 'Booked', '21 January 2022 12:55:00', '20 January 2022 11:50:00', 5)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(12, 3, 50, 'Booked', '19 January 2022 18:10:00', '18 January 2022 12:05:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(13, 3, 58, 'Booked', '21 January 2022 20:00:00', '20 January 2022 13:50:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(14, 3, 19, 'Booked', '20 January 2022 20:25:00', '19 January 2022 15:10:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(15, 3, 4, 'Booked', '23 January 2022 20:35:00', '22 January 2022 15:25:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(16, 3, 26, 'Booked', '21 January 2022 11:00:00', '20 January 2022 10:50:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(17, 3, 59, 'Booked', '19 January 2022 13:35:00', '19 January 2022 12:05:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(18, 3, 40, 'Booked', '21 January 2022 15:15:00', '20 January 2022 13:50:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(19, 4, 20, 'Booked', '23 January 2022 15:40:00', '22 January 2022 15:10:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(20, 4, 59, 'Booked', '20 January 2022 17:05:00', '19 January 2022 15:25:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(21, 4, 49, 'Booked', '22 January 2022 11:30:00', '21 January 2022 10:10:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(22, 4, 27, 'Booked', '22 January 2022 13:45:00', '21 January 2022 12:20:00', 4)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(23, 4, 53, 'Booked', '23 January 2022 16:05:00', '22 January 2022 15:40:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(24, 4, 44, 'Booked', '20 January 2022 18:40:00', '19 January 2022 17:55:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(25, 4, 7, 'Booked', '23 January 2022 20:15:00', '22 January 2022 19:00:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(26, 4, 55, 'Booked', '23 January 2022 11:45:00', '22 January 2022 11:35:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(27, 5, 52, 'Booked', '21 January 2022 11:40:00', '20 January 2022 10:45:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(28, 6, 29, 'Booked', '19 January 2022 13:20:00', '18 January 2022 12:25:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(29, 6, 10, 'Booked', '22 January 2022 15:25:00', '21 January 2022 14:40:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(30, 6, 34, 'Booked', '22 January 2022 17:30:00', '21 January 2022 17:15:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(31, 6, 22, 'Booked', '23 January 2022 19:15:00', '22 January 2022 11:10:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(32, 6, 47, 'Booked', '23 January 2022 11:20:00', '22 January 2022 10:25:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(33, 6, 12, 'Booked', '19 January 2022 12:55:00', '18 January 2022 12:10:00', 3)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(34, 7, 34, 'Booked', '23 January 2022 15:25:00', '22 January 2022 14:40:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(35, 7, 24, 'Booked', '23 January 2022 19:55:00', '22 January 2022 18:55:00', 4)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(36, 7, 18, 'Booked', '19 January 2022 20:30:00', '18 January 2022 11:30:00', 3)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(37, 8, 13, 'Booked', '19 January 2022 15:35:00', '18 January 2022 13:35:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(38, 8, 41, 'Booked', '22 January 2022 15:45:00', '21 January 2022 14:10:00', 4)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(39, 9, 23, 'Booked', '23 January 2022 15:50:00', '22 January 2022 14:45:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(40, 9, 30, 'Booked', '21 January 2022 16:05:00', '20 January 2022 14:10:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(41, 9, 37, 'Booked', '22 January 2022 20:20:00', '21 January 2022 11:30:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(42, 9, 1, 'Booked', '20 January 2022 11:25:00', '19 January 2022 11:15:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(43, 9, 42, 'Booked', '21 January 2022 13:40:00', '20 January 2022 12:35:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(44, 9, 15, 'Booked', '20 January 2022 15:00:00', '19 January 2022 14:45:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(45, 9, 47, 'Booked', '22 January 2022 15:50:00', '21 January 2022 15:40:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(46, 9, 20, 'Booked', '19 January 2022 20:40:00', '18 January 2022 12:05:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(47, 9, 57, 'Booked', '23 January 2022 11:25:00', '22 January 2022 10:30:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(48, 10, 31, 'Booked', '20 January 2022 15:50:00', '19 January 2022 15:45:00', 5)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(49, 10, 21, 'Booked', '20 January 2022 17:15:00', '19 January 2022 16:45:00', 4)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(50, 10, 37, 'Booked', '21 January 2022 20:40:00', '20 January 2022 16:40:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(51, 11, 56, 'Booked', '23 January 2022 13:15:00', '22 January 2022 12:00:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(52, 11, 59, 'Booked', '22 January 2022 16:50:00', '21 January 2022 15:10:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(53, 11, 60, 'Booked', '22 January 2022 19:40:00', '21 January 2022 14:50:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(54, 11, 48, 'Booked', '20 January 2022 21:25:00', '19 January 2022 20:55:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(55, 12, 33, 'Booked', '23 January 2022 20:05:00', '22 January 2022 11:05:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(56, 12, 59, 'Booked', '23 January 2022 12:25:00', '22 January 2022 11:00:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(57, 13, 26, 'Booked', '23 January 2022 15:00:00', '22 January 2022 13:10:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(58, 13, 13, 'Booked', '21 January 2022 13:15:00', '20 January 2022 11:50:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(59, 13, 11, 'Booked', '23 January 2022 20:25:00', '22 January 2022 18:55:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(60, 13, 7, 'Booked', '22 January 2022 20:20:00', '21 January 2022 12:40:00', 3)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(61, 14, 44, 'Booked', '21 January 2022 11:55:00', '20 January 2022 9:10:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(62, 14, 9, 'Booked', '23 January 2022 12:55:00', '22 January 2022 11:35:00', 4)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(63, 15, 50, 'Booked', '20 January 2022 17:35:00', '19 January 2022 15:10:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(64, 15, 55, 'Booked', '20 January 2022 18:45:00', '19 January 2022 18:30:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(65, 15, 38, 'Booked', '23 January 2022 20:55:00', '22 January 2022 11:05:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(66, 15, 14, 'Booked', '19 January 2022 13:45:00', '18 January 2022 12:45:00', 1)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(67, 16, 52, 'Booked', '23 January 2022 17:00:00', '22 January 2022 16:15:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(68, 16, 13, 'Booked', '20 January 2022 18:10:00', '19 January 2022 17:50:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(69, 16, 24, 'Booked', '20 January 2022 21:40:00', '19 January 2022 20:25:00', 4)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(70, 17, 46, 'Booked', '20 January 2022 15:55:00', '19 January 2022 13:40:00', 2)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(71, 17, 49, 'Booked', '20 January 2022 15:15:00', '19 January 2022 14:40:00', 2)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(72, 18, 32, 'Booked', '22 January 2022 16:20:00', '21 January 2022 15:05:00', 5)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(73, 19, 21, 'Booked', '23 January 2022 18:25:00', '22 January 2022 15:40:00', 4)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(74, 19, 41, 'Booked', '19 January 2022 19:50:00', '18 January 2022 16:40:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(75, 19, 15, 'Booked', '23 January 2022 20:55:00', '22 January 2022 13:05:00', 1)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(76, 19, 28, 'Booked', '23 January 2022 14:00:00', '22 January 2022 13:55:00', 3)

INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(77, 20, 20, 'Booked', '22 January 2022 15:35:00', '21 January 2022 14:30:00', 3)
INSERT INTO Reservation(ReservID, EatyID, PgrID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax)
VALUES(78, 20, 24, 'Booked', '20 January 2022 17:15:00', '19 January 2022 16:50:00', 2)

SELECT * FROM EventType --
SELECT * FROM Event     --
SELECT * FROM EventSession --
SELECT * FROM Booking --
SELECT * FROM Passenger --
SELECT * FROM PgrContactNo --
SELECT * FROM Reservation --
SELECT * FROM orders --
SELECT * FROM CSDish --
SELECT * FROM Dish   --
SELECT * FROM categorised_in
SELECT * FROM FoodCategory
SELECT * FROM Cuisine     --
SELECT * FROM Ingredient
SELECT * FROM [contains]
SELECT * FROM Eatery  
/*
drop table booking 
drop table eventSession
drop table event 
drop table eventType
drop table PgrContactNo
drop table passenger
drop table orders
drop table csdish
drop table categorised_in
drop table [contains]
drop table FoodCategory
drop table Ingredient
drop table cuisine
drop table dish
drop table eatery
drop table reservation
*/