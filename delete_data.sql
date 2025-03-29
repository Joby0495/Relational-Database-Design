-- Delete from User_Roles (child table)
DELETE FROM User_Roles;

-- Delete from User_Accounts (child table)
DELETE FROM User_Accounts;

-- Delete from Users (parent table)
DELETE FROM Users;

-- Delete from Roles (independent after User_Roles)
DELETE FROM Roles;
