# Automating-User-Creation-Script


This Bash script performs several tasks related to creating a new user, generating a random password, and saving the user information. Let's break down the script step by step:

1. **Function to Generate a Random Password:**
   ```bash
   generate_password() {
       cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 12
       echo
   }
   ```
   This function generates a random password of 12 characters using the `/dev/urandom` as a source of randomness.

2. **User Input:**
   ```bash
   read -p "Enter the username: " username
   read -p "Enter the user position: " position
   read -p "Enter the user's email address: " email
   ```
   The script prompts the user to enter the username, user position, and email address.

3. **Check if Username Already Exists:**
   ```bash
   if id "$username" &>/dev/null; then
       echo "Error: The username $username already exists."
       exit 1
   fi
   ```
   It checks whether the provided username already exists. If it does, an error message is displayed, and the script exits.

4. **Generate Random Password:**
   ```bash
   password=$(generate_password)
   ```
   It generates a random password using the previously defined function.

5. **Add User:**
   ```bash
   sudo useradd -m -p "$(openssl passwd -1 "$password")" "$username"
   ```
   It adds the user with the generated password using `useradd` and encrypts the password using `openssl`.

6. **Get User UID and Current Date/Time:**
   ```bash
   uid=$(id -u "$username")
   creation_time=$(date +"%Y-%m-%d %H:%M:%S")
   ```
   It retrieves the UID of the newly created user and the current date and time.

7. **Display User Information:**
   ```bash
   echo "User '$username' (Position: $position) created with password '$password', UID '$uid', and Email '$email' at $creation_time."
   ```
   It prints out the user information on the terminal.

8. **Save User Information to File (`user-created.txt`):**
   ```bash
   echo "Username: $username" >> user-created.txt
   echo "Position: $position" >> user-created.txt
   echo "Password: $password" >> user-created.txt
   echo "Email: $email" >> user-created.txt
   echo "UID: $uid" >> user-created.txt
   echo "Creation Time: $creation_time" >> user-created.txt
   echo "------------------------------------" >> user-created.txt
   ```
   It appends the user information to a text file named `user-created.txt`.

9. **Check User Existence in File (`user-created.txt`):**
   ```bash
   if grep -q "UID: $uid" user-created.txt; then
       echo "User $username with UID $uid confirmed in /etc/passwd."
   else
       echo "Error: User $username not found in /etc/passwd, please run again."
   fi
   ```
   It checks if the user information has been successfully saved in `user-created.txt` by searching for the UID.

In summary, this script creates a new user, generates a random password, displays the user information, saves the information to a file, and checks if the user information has been successfully recorded in the file.
