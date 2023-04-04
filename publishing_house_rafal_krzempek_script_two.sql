# List of authors living in Dablin
SELECT * FROM `author` WHERE `city` = 'Dublin';

# Search for all manuscripts cheaper than €20,000.
SELECT * FROM `manuscript` WHERE `manuscriptPrice` < 20000;

# Book title and price under the heading book
SELECT concat(title, '  -  €', price) AS Book FROM book;

# ID of manuscripts sent to the publisher in 'hardcopy' form 
SELECT manuscriptId FROM manuscript WHERE manuscriptType = 'hardcopy';

# List of books when the full title is not known.
SELECT * FROM book WHERE title LIKE '%_ove%';

# Book sales where a single purchase exceeded 200 books.
SELECT * FROM `sale` WHERE `quantity` > 200;

# Summary of codes of sales transacted in 2022 with the number of sold books
SELECT concat(transactionId, ' -   quantity: ', quantity) AS Summary_of_sales_in_2022
FROM sale WHERE saleDate BETWEEN '2022-01-01' AND '2022-12-31';

# Sales transaction ID numbers from the last 30 days.
SELECT transactionId FROM sale WHERE DATE_SUB(CURDATE(),INTERVAL 30 DAY) <= saleDate;

# Merging data from 'book' and 'author' tables
SELECT * FROM book INNER JOIN author ON book.PPSN = author.PPSN;

# Merging data from 4 tables: 'book', 'sale', 'Terms_Of_Sale' and 'Book_Shop'
SELECT * FROM book INNER JOIN sale ON book.ISBN = sale.ISBN
				   INNER JOIN Terms_Of_Sale ON sale.termsOfSaleId = Terms_Of_Sale.termsOfSaleId
				   INNER JOIN Book_Shop ON Book_Shop.bookshopId = sale.bookshopId;
  
# Average number of books sold
SELECT AVG(quantity) average_buy_quantity FROM sale;

# Preparation of a summary of cash withdrawal orders for banks in each city 
SELECT city, SUM(advancePayment) AS income FROM author GROUP BY city;
       
