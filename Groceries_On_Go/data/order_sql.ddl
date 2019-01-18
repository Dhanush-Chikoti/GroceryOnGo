
DROP TABLE PayPal;
DROP TABLE CreditCard;
DROP TABLE Delivery;
DROP TABLE InOrder;
DROP TABLE Cart;
DROP TABLE Products;
DROP TABLE Category;
DROP TABLE Farmer;
DROP TABLE Driver;
DROP TABLE Customers;
DROP TABLE Users;


CREATE TABLE Users (
	username varchar(20),
	password varchar(30) NOT NULL,
	firstName varchar(20) NOT NULL,
	lastName varchar(20) NOT NULL,
	address varchar(50) NOT NULL,
	email varchar(30) NOT NULL,
	phone varchar(15) NOT NULL,
	PRIMARY KEY(username)
);

CREATE TABLE Farmer(
	fId int,
	username varchar(20),
	companyName varchar(20) NOT NULL,
	PRIMARY KEY (fId),
	FOREIGN KEY (username) REFERENCES Users(username)
);

CREATE TABLE Driver(
	dId int,
	DLNum int NOT NULL,
	username varchar(20),
	PRIMARY KEY(dId),
	FOREIGN KEY (username) REFERENCES Users(username)
);

CREATE TABLE Customers(
	cId int,
	username varchar(20),
	PRIMARY KEY(cId),
	FOREIGN KEY (username) REFERENCES Users(username)
);

CREATE TABLE Category(
	catName varchar(20),
	catDesc varchar(300),
	PRIMARY KEY(catName)
);

CREATE TABLE Products (
	pId int,
	pName varchar(20) NOT NULL,
	pDesc varchar(300) NOT NULL,
	stock decimal(8,2) NOT NULL,
	price decimal(8,2) NOT NULL,
	fId int,
	catName varchar(20),
	PRIMARY KEY(pId),
	FOREIGN KEY (fId) REFERENCES Farmer(fId),
	FOREIGN KEY (catName) REFERENCES Category(catName)
);

CREATE TABLE Cart(
	cartId int,
	totalPrice decimal(8,2) NOT NULL,
	cId int,
	PRIMARY KEY(cartId),
	FOREIGN KEY (cId) REFERENCES Customers(cId)
);

CREATE TABLE InOrder( 
	amount decimal(8,2) NOT NULL,
	subTotal decimal(8,2) NOT NULL,
	pId int,
	cartId int,
	PRIMARY KEY(pId, cartId),
	FOREIGN KEY (pId) REFERENCES Products(pId),
	FOREIGN KEY (cartId) REFERENCES Cart(cartId)
);



CREATE TABLE Delivery(
	trackNum int NOT NULL,
	timestmp DATETIME,
	status int,
	cartId int,
	dId int,
	PRIMARY KEY(trackNum, cartId, dId),
	FOREIGN KEY (cartId) REFERENCES Cart(cartId),
	FOREIGN KEY (dId) REFERENCES Driver(dId)
);	

CREATE TABLE PayPal(
	accId int NOT NULL,
	cId int,
	PRIMARY KEY(accId, cId),
	FOREIGN KEY (cId) REFERENCES Customers (cId)
);

CREATE TABLE CreditCard(
	cardNumber int NOT NULL,
	expDate date NOT NULL,
	ccv int NOT NULL,
	cId int,
	PRIMARY KEY(cId, cardNumber),
	FOREIGN KEY (cId) REFERENCES Customers(cId)
);

INSERT INTO Users VALUES(
	'asmith', 'asmith', 'Adam', 'Smith', 'Harvey Ave', 'asmith@gmail.com', 7894561230
);

INSERT INTO Users VALUES(
	'dcooper', 'dcooper', 'David', 'Cooper', 'Gordon ave', 'dcooper@gmail.com', 9876543210
);

INSERT INTO Users VALUES(
	'jcaprio', 'jcaprio', 'John', 'Caprio', 'Tarton Road', 'jcaprio@gmail.com', 4567891230
);


INSERT INTO Farmer VALUES(
	1, 'asmith', 'Okanagan Farm'
);

INSERT INTO Farmer VALUES(
	2, 'dcooper', 'Cherry farm'
);

INSERT INTO Farmer VALUES(
	3, 'jcaprio', 'Orchard Farm'
);


INSERT INTO Category VALUES('Fruits', 'All sorts of fruits');

INSERT INTO Products VALUES(1, 'Orange', 'Mandarin Orange', 20, 5, 1, 'Fruits');

INSERT INTO Products VALUES(2, 'Apple', 'Gala Apple', 10, 3, 1, 'Fruits');

INSERT INTO Products VALUES(3, 'Mango', 'Alphonso Mango', 15, 10, 2, 'Fruits');

INSERT INTO Products VALUES(4, 'Banana', 'Organic Banana', 18, 2, 2, 'Fruits');

INSERT INTO Products VALUES(5, 'Strawberry', 'Organic Strawberry', 50, 7, 3, 'Fruits');

INSERT INTO Products VALUES(6, 'Avacado', 'Organic Avacado', 20, 9, 3, 'Fruits');


