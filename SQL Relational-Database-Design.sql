-- Create Tables Section
-- This section defines the tables with their respective primary and foreign keys.

-- Users table: Stores user information
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- User_Accounts table: Stores account details linked to users
CREATE TABLE User_Accounts (
    user_account_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    account_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Roles table: Stores available roles
CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name VARCHAR(50) NOT NULL
);

-- User_Roles table: Junction table linking accounts to roles with time periods
CREATE TABLE User_Roles (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_account_id INT NOT NULL,
    role_id INT NOT NULL,
    role_start_time DATETIME NOT NULL,
    role_end_time DATETIME, -- Nullable to indicate an active role
    FOREIGN KEY (user_account_id) REFERENCES User_Accounts(user_account_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Insert Data Section
-- This section inserts at least two rows into each table, ensuring foreign key relationships.

-- Insert into Users
INSERT INTO Users (username, email)
VALUES ('john_doe', 'john@example.com'),
       ('jane_smith', 'jane@example.com');

-- Insert into Roles
INSERT INTO Roles (role_name)
VALUES ('Admin'),
       ('Editor');

-- Insert into User_Accounts, linking to Users via user_id
INSERT INTO User_Accounts (user_id, account_status)
VALUES ((SELECT user_id FROM Users WHERE username = 'john_doe'), 'active'),
       ((SELECT user_id FROM Users WHERE username = 'jane_smith'), 'inactive');

-- Insert into User_Roles, linking accounts to roles with start and end times
INSERT INTO User_Roles (user_account_id, role_id, role_start_time, role_end_time)
VALUES (
    (SELECT user_account_id FROM User_Accounts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'john_doe')),
    (SELECT role_id FROM Roles WHERE role_name = 'Admin'),
    '2023-01-01',
    NULL -- Indicates the role is still active
),
(
    (SELECT user_account_id FROM User_Accounts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'jane_smith')),
    (SELECT role_id FROM Roles WHERE role_name = 'Editor'),
    '2023-02-01',
    '2023-12-31' -- Role has ended
);

-- Delete Data Section
-- This section deletes all data from each table, in an order respecting foreign key constraints.

DELETE FROM User_Roles;    -- Delete from junction table first due to FK references
DELETE FROM User_Accounts; -- Then delete accounts, which are referenced by User_Roles
DELETE FROM Users;         -- Then delete users, referenced by User_Accounts
DELETE FROM Roles;         -- Finally delete roles, referenced by User_Roles