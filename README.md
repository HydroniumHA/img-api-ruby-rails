# 🖼️ Image Manager API (Ruby on Rails + PostgreSQL + Docker)

Ce projet implémente une API REST pour la gestion des photos de profil des utilisateurs, s'intégrant avec un système d'authentification externe (Firebase UIDs). Il utilise **Ruby on Rails** pour la logique d'API, **Active Storage** pour le stockage des fichiers, et **PostgreSQL** pour la persistance des données. L'ensemble est conteneurisé avec Docker.

---

## 🚀 Stack Technique

| Composant | Rôle | Configuration |
| :--- | :--- | :--- |
| **Backend** | Ruby on Rails 8.1 | API Mode, Puma Server |
| **Base de Données** | PostgreSQL 16 | Persistance des données et des métadonnées (Active Record) |
| **Stockage Fichiers** | Active Storage | Utilisation du service `Disk` monté sur un **Volume Docker persistant** (`profile_images`) |
| **File d'Attente** | Solid Queue / Active Job | Gestion des tâches asynchrones (analyse d'images) |
| **Conteneurisation** | Docker & Docker Compose | Orchestration de l'application (`web`) et de la base de données (`db`) |

---

## ⚙️ Configuration & Déploiement

### 1. Prérequis sur le VPS

Vous devez avoir installé **Docker**, **Docker Compose**, et **Git** sur votre machine.

### 2. Variables d'Environnement

Créez un fichier **`.env`** à la racine de votre projet (et assurez-vous qu'il est dans votre `.gitignore` !) avec les variables de production :

```ini
# Configuration de la base de données PostgreSQL
DB_USERNAME=my_api_user
DB_PASSWORD=YOUR_STRONG_DB_PASSWORD
DB_NAME_PRODUCTION=image_manager_production

# Clés de sécurité Rails
SECRET_KEY_BASE=VOTRE_SECRET_KEY_DE_64_CARACTERES
RAILS_MASTER_KEY=VOTRE_MASTER_KEY_DE_PRODUCTION
