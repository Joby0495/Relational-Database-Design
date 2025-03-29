-- Insert into Users
INSERT INTO Users (username, email) 
VALUES 
    ('john_doe', 'john@example.com'),
    ('jane_smith', 'jane@example.com');

-- Insert into User_Accounts
INSERT INTO User_Accounts (user_id, account_status) 
VALUES 
    (1, 'Active'),  -- John’s account
    (2, 'Inactive');  -- Jane’s account

-- Insert into Roles
INSERT INTO Roles (role_name) 
VALUES 
    ('Admin'),
    ('User');

-- Insert into User_Roles
INSERT INTO User_Roles (user_account_id, role_id, role_start_time, role_end_time)
VALUES 
    (1, 1, GETDATE(), NULL),  -- John has Admin role, still active
    (2, 2, '2023-01-01', '2023-12-31');  -- Jane had User role in 2023
