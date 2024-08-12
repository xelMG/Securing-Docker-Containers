
# Docker Security 

This project aims to create Docker containers for an application called "todo-app" that runs with a non-root user. Running applications inside Docker containers with a non-root user is a crucial practice for enhancing security, as it prevents the container from having excessive permissions that could be exploited by attackers in the event of vulnerabilities.

## Setup

1. **Update the `.env` file:**
   - Replace the `MY_user` variable with the username you want to use inside the container, for example, `myuser`.

2. **Adjust configuration in `src/persistence/sqlite.js`:**
   - Ensure that the configuration reflects the username specified in the `.env` file.
   - On line 3 of the file, update the SQLite file path to include the correct username.
   - Example: `/home/newuser/app/todos/todo.db`

3. **Build and run the containers:**
   - Execute the following command to build the Docker image and start the containers:
     ```sh
     docker-compose up --build
     ```

4. **Access the application:**
   - Once the containers are up and running, open your browser and visit the URL:
     ```
     http://localhost:3000
     ```

---
