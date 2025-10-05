# 🎲 Dice Game Deployment with Terraform & Docker

This project demonstrates how to deploy a static **Dice Game web application** using **Terraform** and **Docker**.  
The app is served by an **Nginx container** built from a custom image that includes all static files (`index.html`, `styles.css`, `app.js`).

---

## 📂 Project Structure

```bash
.
├── image
│   ├── Dockerfile
│   └── site
│       ├── app.js
│       ├── index.html
│       └── styles.css
├── main.tf
├── terraform.tfstate
└── terraform.tfstate.backup

