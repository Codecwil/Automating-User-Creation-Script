#!/bin/bash

##################################"BY WILSON CHOUNDONG #########################

# Founction to generate a random password 

generate_password() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 12
    echo
}

# Input the user details
read -p "Enter the username: " username
read -p "Enter the user position: " position
read -p "Enter the user's email address: " email

# Check if the username already exists
if id "$username" &>/dev/null; then
    echo "Error: The username $username already exists."
    exit 1
fi

# Generate a random password
password=$(generate_password)

# Add the user with the generated password
sudo useradd -m -p "$(openssl passwd -1 "$password")" "$username"

# Get the UID of the newly created user
uid=$(id -u "$username")

# Get the current date and time
creation_time=$(date +"%Y-%m-%d %H:%M:%S")

# Display the user information
echo "User '$username' (Position: $position) created with password '$password', UID '$uid', and Email '$email' at $creation_time."


# Save the results in user-created.txt 

echo "Username: $username" >> user-created.txt
echo "Position: $position" >> user-created.txt
echo "Password: $password" >> user-created.txt
echo "Email: $email" >> user-created.txt
echo "UID: $uid" >> user-created.txt
echo "Creation Time: $creation_time" >> user-created.txt
echo "------------------------------------" >> user-created.txt

echo "User information has been saved in user-created.txt."

# Check if the user exists in user-created.txt using grep

if grep -q "UID: $uid" user-created.txt; then
    echo "User $username with UID $uid confirmed in /etc/passwd."
else
    echo "Error: User $username not found in /etc/passwd, please run again."
fi
