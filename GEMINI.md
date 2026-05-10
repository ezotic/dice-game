# Project Overview

This project deploys a simple, static dice-rolling web application using Terraform and Docker. The application consists of an HTML page, a CSS stylesheet, and a JavaScript file that allows users to "roll" two virtual dice and see the result.

The infrastructure is managed by Terraform, which automates the process of building a custom Docker image and running it as a container. The Docker image is based on Nginx and serves the static web content.

## Key Technologies

*   **Terraform:** Used for infrastructure as code. It defines the Docker image, container, and network resources.
*   **Docker:** Used to containerize the web application, ensuring a consistent and isolated environment.
*   **Nginx:** Used as the web server within the Docker container to serve the static HTML, CSS, and JavaScript files.
*   **HTML/CSS/JavaScript:** The core technologies used for the front-end of the web application.

## Architecture

1.  **Terraform Configuration (`main.tf`):**
    *   Defines a `docker_image` resource that builds a Docker image from the `image` directory.
    *   Includes a cache-busting mechanism to ensure the image is rebuilt whenever the website's content changes.
    *   Defines a `docker_container` resource to run the built image.
    *   Exposes the web application on a host port (default: 8080).
    *   Sets up a Docker network for the application.

2.  **Docker Image (`image/Dockerfile`):**
    *   Starts from a lightweight `nginx:alpine` base image.
    *   Copies the static website files (`site/*`) into the Nginx web root (`/usr/share/nginx/html`).

3.  **Web Application (`image/site/*`):**
    *   `index.html`: The main HTML file for the dice game.
    *   `styles.css`: The stylesheet for the game.
    *   `app.js`: The JavaScript code that handles the dice rolling logic.

# Building and Running

The following commands are used to manage the project:

*   **Initialize Terraform:**
    ```bash
    terraform init
    ```
*   **Plan the deployment:**
    ```bash
    terraform plan
    ```
*   **Apply the changes (build and run the container):**
    ```bash
    terraform apply
    ```
*   **Destroy the resources:**
    ```bash
    terraform destroy
    ```

After running `terraform apply`, the web application will be accessible at [http://localhost:8080](http://localhost:8080) by default.

# Development Conventions

*   **Terraform:** The Terraform code is well-structured with variables, locals, and outputs. It follows standard Terraform practices.
*   **Docker:** The `Dockerfile` is simple and efficient, using a minimal base image.
*   **Web:** The front-end code is straightforward and self-contained.
