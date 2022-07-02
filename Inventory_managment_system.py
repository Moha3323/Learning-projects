import sqlite3
conn = sqlite3.connect('inventory.db')
cursor = conn.cursor()
cursor.execute("create table if not exists customer(customer_id  INTEGER   ,\
                                                    first_name  nvarchar(40) not null,\
                                                    last_name  nvarchar(40) not null,\
                                                    address   nvarchar(255)  null,\
                                                    contact_number    nvarchar(40)  not null,\
                                                      PRIMARY KEY('customer_id' AUTOINCREMENT))")
conn.commit()

cursor.execute("create table if not exists Employee(employee_id   INTEGER    ,\
                                                    first_name  nvarchar(40) not null,\
                                                    last_name  nvarchar(40) not null,\
                                                    address   nvarchar(255) null,\
                                                    contact_number    nvarchar(40) not null,\
                                                      position  nvarchar(40)   not null,\
                                                        PRIMARY KEY('employee_id' AUTOINCREMENT))")

conn.commit()


cursor.execute("create table if not exists supplier(supplier_id   INTEGER   ,\
                                                                   name  nvarchar(40)  not null,\
                                                                   address   nvarchar(255) null,\
                                                                   contact_number    nvarchar(40)   not null,\
                                                                   brand_id  int    not null,\
                                                                  PRIMARY KEY('supplier_id' AUTOINCREMENT)\
                                                                   Foreign key(Brand_id) REFERENCES product(product_id))")


conn.commit()
cursor.execute("create table if not exists orders(order_id   INTEGER   ,\
                                                                customer_id int not null,\
                                                                employee_id  int not null,\
                                                                invoice_number int   not null,\
                                                                total_price int not null,\
                                                                date_order  date not null,\
                                                                quantity  int not null,\
                                                                brand_id   int not null,\
                                                                PRIMARY KEY('order_id' AUTOINCREMENT),\
                                                                foreign key(customer_id)   references  customer(customer_id),\
                                                                foreign key(employee_id) references Employee(employee_id) ,\
                                                                  foreign key(brand_id) references product(brand_id) )")
conn.commit()

cursor.execute("create table if not exists cash_order(cash_order_id   INTEGER ,\
                              invoice_number  int not null,\
                              brand_name nvarchar(50) null,\
                              model nvarchar(50) null,\
                              serial_number  int  not null,\
                              price int not null,\
                              unit_type  nvarchar(55) null,\
                                PRIMARY KEY('cash_order_id' AUTOINCREMENT))")

conn.commit()


cursor.execute("create table if not exists product(product_id   INTEGER ,\
                                                   date_received  date,\
                                                   brand_id   int not null,\
                                                   brand_name nvarchar(55),\
                                                   model    nvarchar(55),\
                                                   serial_number   int   not null,\
                                                   availability    nvarchar(55)  not null,\
                                                   date_sold     date,\
                                                   customer_id    int not null,\
                                                   unit_type   nvarchar(55)  not null,\
                                                  PRIMARY KEY('product_id' AUTOINCREMENT )\
                                                   foreign key(customer_id) references customer(customer_id))")

conn.commit()

cursor.execute("create table if not exists charge_order(chargeoder_id   INTEGER ,\
                                                        invoice_number int,\
                                                        brand_name   nvarchar(50),\
                                                        model	nvarchar(50),\
                                                        unit_Type	nvarchar(50),\
                                                        serial_Number	int not null,\
                                                        price	 int not null,\
                                                        down_Payment	Int	not null,\
                                                        month_Term	Int,\
                                                        monthly_Payment int not null,\
                                                          PRIMARY KEY('chargeoder_id' AUTOINCREMENT))")

conn.commit()




cursor.execute("create view  if not exists supplier_to_product AS \
                select * from supplier s join product  p on  p.brand_id   =s.brand_id   ")
conn.commit()

cursor.execute("create view  if not exists invoices AS \
                select * from orders o join charge_order  co on o.invoive_number   =co.invoive_number \
                  join  cash_order cor on co.invoive_number =cor.invoive_number  ")
conn.commit()
