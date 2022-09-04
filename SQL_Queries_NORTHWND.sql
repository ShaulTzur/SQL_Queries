USE NORTHWND

/* The follwing exercises are based on the fictitious company called NorthWind. This demo company has been created by
Microsoft for the purpose of allowing users to develop their SQL knowledge and skills */

------------------------------------------------------------------------------------------------------------------


/* We are going to view all the orders that are at the same date or later than order 10533 but we do not wish
to see the order 10533 on the final result */

Select orderid, orderdate
From orders
Where OrderDate >= (Select orderdate From orders Where orderid = 10533) and OrderID != 10533


/* We are not going to view the product number, the product name, and unit price for products from the Produtcs table 
that their price is higher than the average price of all products */

Select ProductID, ProductName, UnitPrice
From Products
Where UnitPrice > (Select AVG(unitprice) From Products)


/* We would like to see the order numbers and order dates for all orders from the Orders table that their suppliers
are from 'Spain', 'Germany' or 'US' and their order month is July */

Select ODE.OrderID, convert(date, OrderDate) as Full_Date
From Orders as ORD
Join [Order Details] as ODE
On ORD.OrderID = ODE.OrderID
Join Products as PRO
On ODE.ProductID = PRO.ProductID
Join Suppliers as SUP
On PRO.SupplierID = SUP.SupplierID
Where sup.Country in('Spain', 'Germany', 'USA') and MONTH(OrderDate) = 7



/* Finally, we wish to view from the Products table the total items that were ordered from UnitsOnOrder 
and the total UnitsInStock for each category name (from Categories table). We want to show just categories that 
contain the letter "B" in them and only products with total units ordered is greater than 97. 
We would like to have it sorted according to the category name on a descending order */
Select SUM(unitsonorder) as Total_Of_Units_On_Order, SUM(unitsinstock) as Total_Of_Units_In_Stock, CategoryName
From Products as PRO
Left Join Categories as CAT
On PRO.CategoryID = CAT.CategoryID
Where CategoryName like '%b%'
Group by CategoryName
Having SUM(UnitsOnOrder) > 97