

create database eshop;

use eshop;


create table products( id int NOT NULL , prodname varchar (50), price int , PRIMARY KEY (id));

insert into products( id,prodname,price) values( 1001,'mobile',200);

insert into products( id,prodname,price) values( 1002,'laptop',600);

insert into products( id,prodname,price) values( 1003,'Airpods',500);

insert into products( id,prodname,price) values( 1004,'macbook',1500);

insert into products( id,prodname,price) values( 1005,'macbook',1850);

insert into products( id,prodname,price) values( 1006,'laptop',1900);

insert into products( id,prodname,price) values( 1007,'laptop',1000);


select * from products;



create table orders (  orderid int NOT NULL PRIMARY KEY, ordernumber int,id int, FOREIGN KEY (id) REFERENCES products(id));

insert into orders(orderid,ordernumber,id) values (2001, 4509, 1004);

insert into orders(orderid,ordernumber,id) values (2002, 4509, 1003);

insert into orders(orderid,ordernumber,id) values (2003, 4509, 1003);



select * from orders;


create table sales ( salesid int, salesdate date, orderid int,  foreign key (orderid )references orders(orderid));

insert into sales values( 3001,' 2021-01-06', 2003);

insert into sales values( 3002,' 2020-05-21', 2001);

insert into sales values( 3004,' 2019-08-12', 2002);

insert into sales values( 3005, ' 2019-10-12', 2004);



create table Customer( custid int, custname varchar(200), city varchar(100) ,state varchar(100),orderid int,  foreign key (orderid )references orders(orderid))

insert into Customer values( 1,' Anne ', 'Novi','MI',2001);

insert into Customer values( 2,' Adam ', 'Troy','TX',2001);

insert into Customer values( 3,' joe ', 'Livonia','NY',2002);

insert into Customer values( 4, ' john ', 'Northville','CA',2003);

insert into Customer values( 7, ' shanu ', 'Northville','CA',2003);

drop table customer

select * from customer


 

select * from products;

select * from orders;

select * from sales;


create table guestorder (  orderid int NOT NULL PRIMARY KEY, ordernumber int,id int, FOREIGN KEY (id) REFERENCES products(id));

insert into guestorder(orderid,ordernumber,id) values (2001, 4509, 1004);

insert into guestorder(orderid,ordernumber,id) values (2002, 4509, 1003);

insert into guestorder(orderid,ordernumber,id) values (2003, 4509, 1003);

insert into guestorder(orderid,ordernumber,id) values (2004, 4509, 1002);

update guestorder 

set orderid=30003 where orderid=2003;

select orderid, ordernumber from guestorder except 

select orderid, ordernumber from orders


select getdate() from orders 

select day(getdate()) as currentdate from orders 



select prodname, count(s.salesid) as salescount from orders o  inner join products p  on o.id=p.id inner join sales s on  o.orderid = s.orderid group by prodname 
having count(s.salesid)>1


select p.id, prodname, price, orderid 
from products p  join
orders o on p.id = o.id;

select p.id, prodname, salesdate 
from products p  join
orders o on p.id= o.id  left join
sales  s on o.orderid= s.orderid

select orderid, ordernumber from guestorder intersect
select orderid, ordernumber from orders

select orderid, ordernumber from guestorder union 
select orderid, ordernumber from orders

select id,price from products
where price >600

select prodname, price from products
order by prodname desc

select count(prodname) as totalprod, prodname from products
group by prodname

select prodname,price from products
having price >600

select prodname,sum(price) as totalsales  from products
group by prodname
order by sum(price) desc

create view vcustomerorder 

as

select p.id, prodname,c.custname, ordernumber, salesdate from products p

join orders o  on  p.id=o.id 
 
join sales s on o.orderid= s.orderid join Customer c on o.orderid=c.orderid

 select * from vcustomerorder



 create view vavgprice
 as
 select prodname ,price from products
 where price > (select avg(price) from products)

 select * from vavgprice


  create view vsaleyear
  as
  select salesdate, salesid from sales where salesdate > '2018-01-01'
 
 select * from vsaleyear



create function discount (@price as int)
returns int
as 
begin
return
(@price-10)

end

select dbo.discount(60) 


create function fprod( @pname varchar(40))
returns table
as
return(select * from products 

       where prodname=@pname)

select dbo.fprod('Airpods')

select * from prodfunc('Airpods')

select * from price(1900)

select * from products


create  procedure Addproduct (@id int, @prodname varchar(200),@price int )

as

begin
    
	insert into products(id,prodname,price)
	values(@id,@prodname,@price)
	  
 end

 exec Addproduct 1010,'Earphones',65

 select * from products


 create  procedure Removeproduct (@id int )

as

begin
    
	Delete from products where id=@id
	
 end

 exec RemoveProduct 1010

create procedure Removealluser 

as

begin
    
	Delete from userinfo
	
 end


 

 create table customerlog ( logdetails Datetime)

 select * from customerlog

 update  Customer 

set  custname='shan'  where custid= 8

SELECT * 
FROM sales 
WHERE salesamount <
    (SELECT AVG(salesamount) FROM sales)  

		


 create table customerlog ( logdetails Datetime)

 select * from customerlog

 update  Customer 

set  custname='shan'  where custid= 8

SELECT * 
FROM sales 
WHERE salesamount <
    (SELECT AVG(salesamount) FROM sales)  



create table userinfo( username varchar(200), userpassword varchar(200), useremail varchar(200) )
insert into userinfo (username,userpassword,useremail)
  values( 'john', 'a4353', 'john@gmail.com')

select * from userinfo



Create procedure Adduser( @username varchar(200), @userpassword varchar(200), @useremail varchar(200))


as

begin
    
       insert into Adduser(username,userpassword,useremail)
       values (@username,@userpassword,@useremail) 
	           
 end


 execute Adduser 'tina','abc343','tina@gmail'


  
 create procedure Showusers

 as

 begin

 select * from userinfo

 end

 exec Showusers


 ALter  procedure productsordered (@id int)

as

begin
    
	select p.id,prodname,o.ordernumber from products p
	join orders o 
	on p.id=o.id
	where p.id=@id

	
 end

 exec productsordered 1003


 create procedure Customerorder (@id int, @prodname varchar(200),@price int,@orderid int, @ordernumber int, @custid int)

as

begin
    
	insert into products(id,prodname,price)
	values(@id,@prodname,@price)
	insert into orders(orderid,ordernumber,custid)
	values(@orderid,@ordernumber, @custid)
	  
 end

 exec Customerorder 1011,'ipod',499,2007,4511,3


 select * from userinfo


 create procedure userdetails (@name varchar, @gender varchar, @country varchar,@state varchar)
 as
 begin
 insert into userdetails (name,gender,country,state)
 values(@name,@gender,@country,@state)

 end

 

