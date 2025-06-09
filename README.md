# Phi Browser - Landing Page

This repository contains the source code for the Phi Browser landing page and job listings.

Phi Browser is an everyday browser that opens the door to every possibility in AI, for everyone. Ships standalone, with a custom OS and on a dedicated hardware.

## Project Structure

*   `index.html`: The main landing page.
*   `style.css`: Main stylesheet for all pages.
*   `js/`: Contains JavaScript files.
    *   `three.min.js`: Three.js library (dependency for VantaJS).
    *   `vanta.rings.js`: VantaJS Rings animation library.
    *   `custom-vanta.js`: Custom script to initialize and configure VantaJS on the landing page.
*   `jobs/`: Contains HTML pages for individual job descriptions.
    *   `software-engineer.html`: Example job page.
    *   `product-manager.html`: Example job page.
*   `deploy.sh`: A simple shell script for deploying the static website to a server.

## Viewing Locally

To view the website locally and avoid potential issues with browser security restrictions when loading files directly (using the `file://` protocol), it's recommended to use a simple local HTTP server.

1.  Clone this repository.
2.  Navigate to the root directory of the cloned repository in your terminal.
3.  Start a local HTTP server. Here are a couple of common ways using Python:

    *   **For Python 3:**
        ```bash
        python3 -m http.server
        ```
        Or, if you know the specific port you want to use (e.g., 8000):
        ```bash
        python3 -m http.server 8000
        ```

    *   **For Python 2 (if Python 3 is not available):**
        ```bash
        python -m SimpleHTTPServer
        ```
        Or with a specific port:
        ```bash
        python -m SimpleHTTPServer 8000
        ```

4.  Once the server is running, it will typically print a message like `Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...`.
5.  Open your web browser and go to `http://localhost:8000` (or the port number shown by the server).
6.  You should see the `index.html` page. You can navigate to job pages through the links on the main page.

## Deployment (`deploy.sh`)

The `deploy.sh` script is designed to automate the deployment of this static website to a VPS environment.

**Prerequisites:**

*   SSH access to the target server.
*   `rsync` installed on both your local machine and the server.
*   The server details (`REMOTE_USER`, `REMOTE_HOST`, `REMOTE_TARGET_DIR`) in `deploy.sh` must be configured correctly.

**How it Works:**

1.  **Tagging:** The script will only deploy if the current commit is tagged with a specific pattern (e.g., `deploy-v1.0.0`). This prevents accidental deployments. The pattern is defined by `DEPLOY_TAG_PATTERN` in the script.
    *   Example tagging: `git tag deploy-v0.1.0 && git push origin deploy-v0.1.0`
2.  **Execution:** Run the script from the root of the repository: `./deploy.sh`
3.  **Process:**
    *   It checks for the deployment tag.
    *   (Placeholders for build/test steps are included but not implemented).
    *   It uses `rsync` to copy the website files (excluding `.git`, `README.md`, and `deploy.sh` itself) to the `REMOTE_TARGET_DIR` on the server. `rsync` efficiently updates only changed files and can delete files on the server that are no longer in the source.

**Note:** This is a basic script. For a production environment, you would typically integrate this into a more robust CI/CD system (e.g., GitHub Actions, GitLab CI, Jenkins) that triggers automatically on pushes to specific branches or tags.
