
CREATE DATABASE library;

USE library;


CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(200),
  Contact_no VARCHAR(15)
);


CREATE TABLE Employee (
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(20),
  Position VARCHAR(20),
  Salary DECIMAL(10, 2)
);

CREATE TABLE Customer (
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(20),
  Customer_address VARCHAR(200),
  Reg_date DATE
);

CREATE TABLE Books (
  ISBN VARCHAR(20) PRIMARY KEY,
  Book_title VARCHAR(20),
  Category VARCHAR(20),
  Rental_Price DECIMAL(10, 2),
  Status ENUM('yes', 'no'),
  Author VARCHAR(20),
  Publisher VARCHAR(20)
);

CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(20),
  Issue_date DATE,
  Isbn_book VARCHAR(20),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(20),
  Return_date DATE,
  Isbn_book2 VARCHAR(20),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);



INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    (1, 101, 'Branch 1 Address', '1234567890'),
    (2, 102, 'Branch 2 Address', '9876543210'),
    (3, 103, 'Branch 3 Address', '5555555555'),
    (4, 104, 'Branch 4 Address', '9999999999'),
    (5, 105, 'Branch 5 Address', '1111111111');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary)
VALUES
(101, 'Ashwin', 'Manager', 50000.00),
(102, 'Ashna', 'Librarian', 30000.00),
(103, 'Gokul', 'Assistant Manager', 25000.00),
(104, 'Suhas', 'Assistant Manager', 25000.00),
(105, 'Akshay', 'Branch Manager', 30000.00);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1001, 'Anushka', '123 Street', '2021-01-01'),
(1002, 'Sara', '456 Street', '2023-02-15'),
(1003, 'Sachin', '789 Street', '2023-03-30'),
(1004, 'Aparna', '987 Street', '2023-04-10'),
(1005, 'Kiran', '654 Street', '2023-05-20');

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('ISBN-001', 'Book A', 'Fiction', 10.00, 'Yes', 'Author A', 'Publisher X'),
('ISBN-002', 'Book B', 'Non-Fiction', 12.50, 'Yes', 'Author B', 'Publisher Y'),
('ISBN-003', 'Book C', 'Mystery', 8.00, 'No', 'Author C', 'Publisher Z'),
('ISBN-004', 'Book D', 'History', 9.99, 'Yes', 'Author D', 'Publisher W'),
('ISBN-005', 'Book E', 'Thriller', 11.25, 'No', 'Author E', 'Publisher V');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1001, 'Book A', '2021-04-04', 'ISBN-001'),
(2, 1002, 'Book B', '2022-04-05', 'ISBN-002'),
(3, 1003, 'Book C', '2023-04-07', 'ISBN-003'),
(4, 1004, 'Book D', '2023-06-13', 'ISBN-004'),
(5, 1005, 'Book E', '2023-07-20', 'ISBN-005');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1001, 'Book A', '2021-04-10', 'ISBN-001'),
(2, 1002, 'Book B', '2022-04-12', 'ISBN-002'),
(3, 1003, 'Book C', '2023-04-15', 'ISBN-003'),
(4, 1004, 'Book D', '2023-06-20', 'ISBN-004'),
(5, 1005, 'Book E', '2023-07-25', 'ISBN-005');


SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'Yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
  AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT b.Branch_no, COUNT(*) AS Total_Count
FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no;

SELECT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE EXTRACT(YEAR_MONTH FROM i.Issue_date) = '202306';

SELECT Book_title
FROM Books
WHERE Category = 'History';

SELECT b.Branch_no, COUNT(*) AS Employee_Count
FROM Branch b
JOIN Employee e ON b.Branch_no = e.Branch_no
GROUP BY b.Branch_no
HAVING Employee_Count > 5;



