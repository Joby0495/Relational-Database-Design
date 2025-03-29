-- Create Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Create User_Accounts table
CREATE TABLE User_Accounts (
    user_account_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    account_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Roles table
CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name VARCHAR(50) NOT NULL
);

-- Create User_Roles table
CREATE TABLE User_Roles (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_account_id INT NOT NULL,
    role_id INT NOT NULL,
    role_start_time DATETIME NOT NULL,
    role_end_time DATETIME,
    FOREIGN KEY (user_account_id) REFERENCES User_Accounts(user_account_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
