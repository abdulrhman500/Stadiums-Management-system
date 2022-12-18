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
('Ahmed1','Ahmed1',123),
('Ahmed2','Ahmed2',123),
('Ahmed3','Ahmed3',123),
('Ahmed4','Ahmed4',123),
('Ahmed5','Ahmed5',123),
('Ahmed6','Ahmed6',123),
('Ahmed7','Ahmed7',123),
('Ahmed8','Ahmed8',123),
('Ahmed9','Ahmed9',123),
('Ahmed10','Ahmed10',123);

insert into Stadium_Manager values 
('Ahmed1',1),
('Ahmed2',2),
('Ahmed3',3),
('Ahmed4',4),
('Ahmed5',5);


insert into  Club_Representative values 
('Ahmed1',1),
('Ahmed2',2),
('Ahmed3',3),
('Ahmed4',4),
('Ahmed5',5),
('Ahmed6',6),
('Ahmed7',7),
('Ahmed8',8),
('Ahmed9',9);

insert into System_Admin values 
('Ahmed1');
 
insert into Sports_Association_Manager values 
('Ahmed1');
 
insert into Fan  values 
('11','Ahmed1','2001-10-10','AA',123, 1),
('22','Ahmed2','2001-10-10','AA',123, 1),
('33','Ahmed3','2001-10-10','AA',123, 1),
('44','Ahmed4','2001-10-10','AA',123, 1),
('55','Ahmed5','2001-10-10','AA',123, 1),
('66','Ahmed6','2001-10-10','AA',123, 1),
('77','Ahmed7','2001-10-10','AA',123, 1),
('88','Ahmed8','2001-10-10','AA',123, 1),
('99','Ahmed9','2001-10-10','AA',123, 1);

 
insert into Ticket  values
(1,1),
(1,1),
(1,1),
(1,1),
(2,1),
(2,1),
(2,1),
(3,1),
(3,1),
(4,1),
(4,1);


insert into  Ticket_purchase values 
(1,'11'),
(2,'22'),
(3,'33'),
(4,'44'),
(5,'99'),
(6,'44'),
(7,'55'),
(8,'66'),
(9,'77');





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

select * from Stadium_Manager;
select * from Club_Representative;
select * from Sports_Association_Manager;
select * from System_Admin;
select * from Ticket;
select * from Ticket_purchase;
select * from Match;

select * from Fan;

