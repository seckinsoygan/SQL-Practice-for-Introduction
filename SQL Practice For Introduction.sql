SELECT * FROM  PRODUCTS

SELECT PRODUCTID as Id,PRODUCTNAME as Name FROM PRODUCTS --Alyans
--Sayısal Alanlar için
Select p.ProductName,p.UnitsInStock * p.UnitPrice as Total from Products p -- Sondaki p products anlamına gelir.
--Sözel Alanlar için
Select p.ProductName + '-' + p.QuantityPerUnit from Products p -- Yan yana getirir.

--Where koşulu
Select * from products where CategoryId=1
Select * from products where UnitsInStock=0
Select * from products where UnitsInStock=0 and UnitsOnOrder>0 --And koşulu
Select * from products where UnitsInStock=0 or UnitsOnOrder=0 --Or koşulu
Select * from products where not UnitsInStock>0 --Not koşulu

--Order by koşulu
Select * from Categories order by CategoryName --Sıralama yapar
Select * from Categories order by CategoryName asc --Sıralama yapar(Default hali)
Select * from Categories order by CategoryName desc --Tersten Sıralama yapar

asc = ascending
desc = descending 

--Like

Select * from Products where ProductName like '%a' -- a ile biten bütün verileri getir.
Select * from Products where ProductName like '%a%' -- içinde a geçen bütün verileri getir.
Select * from Products where ProductName like 'a%' -- a ile başlayan bütün ürünleri getir.

--Between
Select * from Products where UnitPrice between 10 and 50 --10 ile 50 arasındaki değerleri gösterir.

--In
Select * from Products where CategoryId in(1,2) --Categorisi 1 ve 2 olanlar gösterilir.
--Fonksiyonlar--
--Count   --Count Fonksiyonu NULL saymaz.**
Select Count(*) as [Urun Sayisi] from Products 
Select Count(ProductName) from Products
Select Count(*) from Customers
Select Count(Region) from Customers

--Min
Select Min(UnitPrice) from Products --En düşük değeri döndürür.
--Max
Select Max(UnitPrice) from Products --En yüksek değeri döndürür.
--Avg
Select Avg(UnitPrice) from Products --Ortalama değeri döndürür.
--Sum
Select Sum(UnitPrice) as [Kazanc] from [Order Details] --Toplam değeri döndürür.
--Rand
Select Rand() --Rastgele Sayı üretir.

--String Fonksiyonları (Veritabanından veritabanına değişir.)
--Left
Select Left('Seckin Soygan',5) 
Select Left(ProductName,3) from Products  --Soldan 3 karakter yazdırır.
--Right
Select Right('Seckin Soygan',5) 
Select Right(ProductName,3) from Products  --Sağdan 3 karakter yazdırır.
--Len
Select Len('Seckin Soygan')
Select ProductName,Len(ProductName) as [Karakter Sayisi] from Products --Karakter sayisini gösterir.
--Lower
Select Lower('SECkin SoyGAN') --Tüm karakterleri küçük harf yapar.
--Upper
Select Upper('Seckin Soygan') --Tüm karakterleri büyük harf yapar.

--Trim
Select Trim('   Seckin Soygan   ') --Başında ve sonundaki boşlukları yok sayar.
--LTrim
Select LTrim(ProductName) from Products --Soldaki boşluğu atmaya yarar.
--RTrim
Select RTrim(ProductName) from Products --Sağdaki boşluğu atmaya yarar.

--Reverse
Select Reverse('Seckin Soygan') --Metni tersten yazdırır.
Select Reverse(CompanyName) as [Ters Isim] from Customers

--CharIndex
Select  CHARINDEX('c','Seckin Soygan',1) 
-- 1.Parametre=Aranan karakter, 2.Parametre=Aranacak Metin, 3.Parametre=Kaçıncı indexten itibaren olduğu

--Replace
Select Replace('Niyazi Seçkin Soygan',' ','_') as [Yer Degistirme]
--1.Parametre=Metin, 2.Parametre=Değişecek Karakter, 3.Parametre=Yerine geçecek karakter.

--Substring
Select SUBSTRING('Seckin Soygan',2,9) --Metni 2.indexten itibaren 9.indexe kadar böler.

--ASCII
Select ASCII('S') as [Matematiksel karsiligi] --Girilen karakterin matematiksel karşılığını döndürür.
--Char
Select Char(65) as [Karakter karsiligi] --Girilen karakterin karakter karşılığını döndürür.

--Distinct
Select distinct(Country) from Customers order by Country --Birden fazla gösterilen verinin sadece 1 kere gösterilmesini sağlar.

--Group By
Select Country,Count(*) as Adet from Customers group by Country --Belirttiğiniz kolona göre gruplandırma yapmaya yarar.

--Having
Select Country,City,Count(*) as Adet 
from Customers group by Country,City having Count(*)>1 order by Country

--Joins (Bir araya getirmek)

--Inner Join
Select * from Products inner join Categories on Products.CategoryID=Categories.CategoryID
where Products.UnitPrice>20 --Eşleşenleri ekranda gösterir.

Select * from Products p inner join Categories c on p.CategoryID=c.CategoryID
where p.UnitPrice>20 --Yukarıdakiyle aynı sadece obje(alyans) gibi gösterebiliyoruz.

--3 tane tabloyu join etme
Select p.ProductName,o.OrderDate,od.Quantity*od.UnitPrice as total
from Products p inner join [Order Details] od on
p.ProductID=od.ProductID inner join Orders o on 
o.OrderID=od.OrderID
order by p.ProductName

--Left join (Soldaki tabloda olup,sağdaki tabloda hepsini getirir.)
Select * from Products p left join [Order Details] od on
p.ProductID=od.ProductID
where od.ProductID is null

Select * from Customers c left join Orders o on
c.CustomerID=o.CustomerID
where o.CustomerID is null

--Right join (Sağdaki tabloda olup,soldaki tabloda hepsini getirir.)
Select c.customerId as ID,c.ContactName from Orders o right join Customers c on
o.CustomerID=c.CustomerID
where o.CustomerID is null

--Full Join (Full Outer Join)
Select * from Customers c full join Orders o on
o.CustomerID=c.CustomerID --Hem left,hem righti kapsiyor.

--Workshop 1 (Hiç satış yapamayan personeliniz var mı?)ü

Select * from Employees e left join Orders o on
e.EmployeeID=o.EmployeeID 

--Workshop 2

Select p.ProductName,count(*) as Total from Products p inner join [Order Details] od on
p.ProductID=od.productID
group by p.ProductName
order by p.ProductName --Hangi üründen kaç tane satmışız?

Select c.CategoryName,count(*) as Total from Categories c inner join Products p on --Hangi kategoriden kaç tane satmışız?
c.CategoryID=p.CategoryID
group by c.CategoryName
order by c.CategoryName

--Workshop 3 --Çalışan ve CEO gösterme.

Select e2.FirstName + ' ' +e2.LastName as Personal,e1.FirstName+' '+e1.LastName as CEO 
from Employees e1 right join Employees e2 on
e1.EmployeeID=e2.ReportsTo

--Insert Into (Yeni Kayıt Eklemek için)

insert into Categories (CategoryName,Description)
values ('Technology','Technology Desc')

--Update (Mevcut veriyi güncellemek için)
update Categories set CategoryName='Marketing' where CategoryID=10
update Categories set Description ='Marketing Desc' where CategoryID=10
update Territories set TerritoryDescription='İc Anadolu'

--Delete (Veriyi silmek için)
delete from Categories where CategoryID=9

--Select ile Insert Yapmak
Select * from CustomersWork 

insert into CustomersWork(CustomerId,CompanyName,ContactName)
select CustomerId,CompanyName,ContactName from Customers

--Join ile Update Yapmak
update Customers set CompanyName=CustomersWork.CompanyName from
Customers c inner join CustomersWork cw on c.CustomerID=cw.CustomersWork
where cw.CompanyName like '%test%'

--Join ile Delete Yapmak

delete Customers from Customers c inner join CustomersWork cw on 
c.CustomerID=cw.CustomersWork
where cw.CompanyName like '%test%'

--(Joinden farklı join tabloları yan yana bir araya getirir,Union alt alta bir araya getirir.)
--Union (Birleştirme,bir araya getirme)(Sadece farklıları ekler aynı verileri eklemez.)

Select CustomerID,CompanyName,ContactName from Customers --Sütün sayıları eşit olmak zorunda.
union
Select * from CustomersWork


-----------------------
Clustered index Nedir? ==Veri fiziksel olarak index anahtarina göre sıralanır.Primary key oluşunca otamatik olarak clustured index oluşur.
Non-clustered index= Konuyu a-z ye değil ihtiyaca göre sıralar.Bir tabloda birden fazla olabilir.
Fragmantation=
