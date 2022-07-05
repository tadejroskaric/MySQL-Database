# MySQL-Database
The files in this repository were created throughout the semester when attending the Databases I course at university. I got the task to design a database for an airport which would include all the employees like security personnel, luggage carriers, pilots etc. The database also needed to include the pubs, restaurants and shops at the airport. Apart from that, I had to include parking spaces and store information about them. And at the end of the day, the database also has to store all incoming and outgoing flights.

ER model.pdf. This was the first task. The Entity-Relationship model was the basis for all further work.

DDL Script.sql. The file is a script that creates all the tables, columns and rows within the database based on the ER model.

SQL Queries.sql. When the database got populated with data, the students had to answer some questions with the help of DML queries.

Trigger and Transaction.sql. The subject also covered a bit more advanced topics like triggers and transactions. Based on our initial database, we got the task to implement these concepts into our study case. I for instance created a trigger that counts the number of stops within a given flight.

SQL Administration.sql. This file was the conclusion of the subject. The starting part of the exercise was to create a new instance of the database since it was (up until now) running on the faculty’s server, so the students did not have administrative rights. I decided to set up an instance in Microsoft Azure. The final task was to create two users for the database, give them a password and grant them privileges like SELECT, INSERT, UPDATE and DELETE on selected databases.

