use master
go
create database inventory_try
go
use inventory_try
go

create table  customer(customer_id  INTEGER  primary key identity(1,1) ,
                                                    first_name  nvarchar(40) not null,
                                                    last_name  nvarchar(40) not null,
                                                    [address]   nvarchar(255)  null,
                                                    contact_number    nvarchar(40)  not null);

create table  Employee(employee_id   INTEGER  PRIMARY KEY identity(1,1)  ,
                                                    first_name  nvarchar(40) not null,
                                                    last_name  nvarchar(40) not null,
                                                    address   nvarchar(255) null,
                                                    contact_number    nvarchar(40) not null,
                                                      position  nvarchar(40)   not null);
                                                        


create table  supplier(supplier_id   INTEGER  PRIMARY KEY identity(1,1) ,
                                                         [name]  nvarchar(40)  not null,
                                        [address]   nvarchar(255) null,
                                          contact_number    nvarchar(40)   not null,
                                                 brand_id  int    not null)
												 ;



create table  orders(order_id   INTEGER   PRIMARY KEY identity(1,1) ,
                                                                customer_id int not null,
                                                                employee_id  int not null,
                                                                invoice_number int   not null,
                                                                total_price int not null,
                                                                date_order  date not null,
                                                                quantity  int not null,
                                                                brand_id   int not null,
                                                              
                                                                foreign key(customer_id)   references  customer(customer_id),
                                                                foreign key(employee_id) references Employee(employee_id) );


create table cash_order(cash_order_id   INTEGER  PRIMARY KEY identity(1,1),
                              invoice_number  int not null,
                              brand_name nvarchar(50) null,
                              model nvarchar(50) null,
                              serial_number  int  not null,
                              price int not null,
                              unit_type  nvarchar(55) null );




create table  product(product_id   INTEGER primary key identity(1,1) ,
                                                   date_received  date,
                                                   brand_id   int not null,
                                                   brand_name nvarchar(55),
                                                   model    nvarchar(55),
                                                   serial_number   int   not null,
                                                   [availability]    nvarchar(55)  not null,
                                                   date_sold     date,
                                                   customer_id    int not null,
                                                   unit_type   nvarchar(55)  not null,
                                                   foreign key(customer_id) references customer(customer_id));



create table  charge_order(chargeoder_id   INTEGER  primary key identity(1,1),
                                                        invoice_number int,
                                                        brand_name   nvarchar(50),
                                                        model	nvarchar(50),
                                                        unit_Type	nvarchar(50),
                                                        serial_Number	int not null,
                                                        price	 int not null,
                                                        down_Payment	Int	not null,
                                                        month_Term	nvarchar(255),
                                                        monthly_Payment int not null);


alter table        supplier add constraint brand_product  foreign key     
(Brand_id) REFERENCES product (product_id)     ;                            
 
go


alter table        orders add constraint order_product
foreign key(brand_id) references product(product_id);

go



create view trial as
select b.brand_id,b.brand_name ,o.invoice_number,o.quantity from product b 
inner join orders o on o.customer_id=b.customer_id

go




create procedure employee_insert @first_name nvarchar(55),
@last_name nvarchar(55),@address nvarchar(255),@contact_number nvarchar(55),@position nvarchar(55)
AS
insert into  [dbo].Employee (first_name, last_name, [address], contact_number, position) 
	   values(@first_name ,@last_name ,@address ,@contact_number,@position );

	   go

create procedure  product_insert   @date_received date,
@brand_id int,@brand_name nvarchar(255),@model nvarchar(55),  @serial_number int,@availability nvarchar(55),
@date_sold date ,@customer_id int ,@unit_type  nvarchar(55)
AS
insert into  [dbo].[product] (date_received, brand_id, brand_name,
model, serial_number, [availability], date_sold,customer_id, unit_type) 
	   values(@date_received ,@brand_id ,@brand_name,@model,@serial_number 
	   ,@availability,@date_sold,@customer_id,@unit_type );
	   go


create procedure supplier_insert @name nvarchar(55),
@address nvarchar(55),@contact_number nvarchar(255),@brand_id int
AS
insert into  [dbo].[supplier] ([name],[address],contact_number,brand_id) 
	   values(@name ,@address ,@contact_number ,@brand_id );
go


create procedure order_insert @customer_id int,
@employee_id int,@invoice_number int,@total_price int,@date_order date,
@quantity int ,@brand_id int
AS
insert into  [dbo].[orders] (customer_id, employee_id, 
invoice_number, total_price, date_order, quantity, brand_id) 
	   values(@customer_id ,@employee_id ,@invoice_number ,@total_price,@date_order,
	   @quantity,@brand_id);
go


create procedure customer_insert @first_name nvarchar(55),
@last_name nvarchar(55),@address nvarchar(255),@contact_number nvarchar(55)
AS
insert into  [dbo].[customer] (first_name, last_name, [address], contact_number) 
	   values(@first_name ,@last_name ,@address ,@contact_number );

go

create procedure chargeorder_insert @invoice_number int,
@brand_name nvarchar(55),@model nvarchar(255),@unit_Type nvarchar(55),@serial_number int
,@price int,@down_Payment int,@month_Term nvarchar(255),@monthly_Payment int
AS
insert into  [dbo].[charge_order] (invoice_number, brand_name, model, unit_Type
, serial_number, price, down_Payment, month_Term, monthly_Payment) 
	   values(@invoice_number, @brand_name, @model, @unit_Type
, @serial_number, @price, @down_Payment, @month_Term, @monthly_Payment );

go

create procedure cashorder_insert @invoice_number int,
@brand_name nvarchar(55),@model nvarchar(255),@serial_number int,@price int,@unit_type nvarchar(55)
AS
insert into  [dbo].[cash_order] (invoice_number,brand_name, model, serial_number, price, unit_type) 
	   values(@invoice_number,@brand_name, @model, @serial_number, @price, @unit_type );

go

/*use master
go 

drop database inventory_try
*/