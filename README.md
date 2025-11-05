# Inception 🐳

A **system administration and containerization project** that introduces **Docker**, **docker-compose**, and **virtualized service orchestration**.

## 📋 Table of Contents

* [About](#-about)
* [Features](#-features)
* [Goals](#-goals)
* [Architecture](#-architecture)
* [Prerequisites](#-prerequisites)
* [Installation](#-installation)
* [Usage](#-usage)
* [Services](#-services)
* [Makefile Commands](#-makefile-commands)

---

## 🎯 About

**Inception** is a **DevOps and system administration** project.
It aims to build a **virtualized multi-container infrastructure** using **Docker Compose**.
Each service runs in its own container, with specific volumes and networks ensuring full isolation and reproducibility.

The goal is to understand how modern web infrastructure works — from databases to web servers — using Docker to manage and connect all components.

---

## ✨ Features

### Core Features

* 🧱 Containerized architecture using **Docker Compose**
* 🗄️ **MariaDB** database service
* 🌐 **WordPress** instance with **PHP**
* ⚙️ **NGINX** reverse proxy
* 💾 Persistent storage using Docker **volumes**
* 🔐 Secure configuration via **environment variables** and **Docker secrets**
* 🌍 SSL certificates (self-signed)
* 📦 Custom base images using **Debian**

---

## 🎓 Goals

* Learn **Docker basics** and container orchestration
* Learn how to configure **network bridges** and **volumes**
* Understand the **client-server model**
* Practice **secure, isolated, and reproducible environments**

---

## 🧱 Architecture

```
                ┌───────────────────┐
                │       NGINX       │
                │       TLS +       |
                |   Reverse Proxy   │
                └─────────┬─────────┘
                          │
                ┌─────────┴─────────┐
                │  WordPress + PHP  │
                └─────────┬─────────┘
                          │
                ┌─────────┴─────────┐
                │      MariaDB      │
                └───────────────────┘
```

Each container communicates over a **custom Docker network**, with **volumes** mounted locally to ensure data persistence between restarts.

---

## 🔧 Prerequisites

* **Docker** && **Docker Compose** 

---

## 🚀 Installation

1. **Clone the repository**

   ```bash
   git clone git@github.com:chrstnhu/inception.git && cd inception
   ```

2. **Build the environment**

   ```bash
   make
   ```

3. **Stop containers**

   ```bash
   make down
   ```

4. **Remove everything (volumes, images, networks)**

   ```bash
   make fclean
   ```

---

## 🧭 Usage

Once the environment is built, the stack automatically launches:

```bash
make up
```

Then, open your browser and visit:

```
https://localhost
```

---

## 🧩 Services

| Service       | Description         | Access              |
| :------------ | :------------------ | :------------------ |
| **NGINX**     | Reverse proxy + SSL | `https://localhost` |
| **WordPress** | CMS + PHP           | Managed by NGINX    |
| **MariaDB**   | Database backend    | Internal only       |

---

## 🧰 Makefile Commands

| Command       | Description                                        |
| :------------ | :------------------------------------------------- |
| `make`        | Build and launch all containers                    |
| `make up`     | Start containers in detached mode                  |
| `make down`   | Stop and remove containers                         |
| `make logs`   | Display container logs                             |
| `make clean`  | Remove containers but keep volumes                 |
| `make fclean` | Remove all (containers, volumes, images, networks) |
| `make re`     | Rebuild environment from scratch                   |

