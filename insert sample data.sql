insert into Club values 
('Al-Ahly','Cairo'),
('Liverpool','England'),
('Rio de Janeiro','Brazil'),
('Roma','Italy'),
('Lisbon','Portugal'),
('Madrid','Spain'),
('Barcelona','Spain'),
('Zamalek','Giza'),
('Ismaily','Ismailia')
;


-----
insert into Stadium values 
('Camp Nou', 'Barcelona',99354,1),
('San Siro','Milan', 80018,1),
('Allianz Arena','Munich',75000,1),
('Emirates Stadium','London',60361,1),
('Cairo','Cairo',60000,1);

--------------
insert into Match values
(  1,8,'2019-08-1 20:00','2019-08-1 23:00',5 ),
(  6,7,'2023-08-1 20:00','2023-08-1 23:00' ,1),
(  8,4,'2022-08-1 20:00','2022-08-1 23:00',4),
(  2,4,'2021-08-1 20:00','2021-08-1 23:00',2),
( 2,4,'2020-08-1 20:00','2020-08-1 23:00',2),
(  1,4,'2020-08-1 20:00','2020-08-1 23:00',3);

insert into SystemUser values 
('Ahmed1.a','Ahmed1',123),
('Ahmed2.a','Ahmed2',123),
('Ahmed3.a','Ahmed3',123),
('Ahmed4.a','Ahmed4',123),
('Ahmed5.a','Ahmed5',123),
('Ahmed6.a','Ahmed6',123),
('Ahmed7.a','Ahmed7',123),
('Ahmed8.a','Ahmed8',123),
('Ahmed9.a','Ahmed9',123),
('Ahmed10.a','Ahmed10',123);

insert into Stadium_Manager values 
('Ahmed1.a',1),
('Ahmed2.a',2),
('Ahmed3.a',3),
('Ahmed4.a',4),
('Ahmed5.a',5);


insert into  Club_Representative values 
('Ahmed1.a',1),
('Ahmed2.a',2),
('Ahmed3.a',3),
('Ahmed4.a',4),
('Ahmed5.a',5),
('Ahmed6.a',6),
('Ahmed7.a',7),
('Ahmed8.a',8),
('Ahmed9.a',9);

insert into System_Admin values 
('Ahmed1.a');
 
insert into Sports_Association_Manager values 
('Ahmed1.a');
 
insert into Fan  values 
(11,'Ahmed1.a',123,'2001-10-10','AA',0),
(22,'Ahmed2.a',123,'2001-10-10','AA',0),
(33,'Ahmed2.a',123,'2001-10-10','AA',0),
(44,'Ahmed4.a',123,'2001-10-10','AA',0),
(55,'Ahmed5.a',123,'2001-10-10','AA',0),
(66,'Ahmed6.a',123,'2001-10-10','AA',0),
(77,'Ahmed7.a',123,'2001-10-10','AA',0),
(88,'Ahmed8.a',123,'2001-10-10','AA',0),
(99,'Ahmed9.a',123,'2001-10-10','AA',0);

 
insert into Ticket  values
(1,1),
(1,1),
(2,1),
(2,1),
(3,1),
(3,1),
(4,1),
(4,1);


insert into  Ticket_purchase values 
(1,11),
(2,22),
(3,33),
(4,44),
(5,55),
(6,66),
(7,77);





insert into Request values
 
(1,1,5,1),
(1,2,1,6),
(1,3,5,7),
(1,4,2,2),
(0,5,2,2),
(0,6,3,1);

select * from Request;
select * from SystemUser;
select * from Stadium;
select * from Club;
select * from Match;
select * from Fan;
select * from Stadium_Manager;
select * from Club_Representative;
select * from Sports_Association_Manager;
select * from System_Admin;
select * from Ticket;
select * from Ticket_purchase;



