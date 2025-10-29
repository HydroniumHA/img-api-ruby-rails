# 🖼️ Image Manager API (Ruby on Rails + PostgreSQL + Docker)

Ce projet implémente une API REST pour la gestion des photos de profil des utilisateurs, s'intégrant avec un système d'authentification externe (Firebase UIDs). Il utilise **Ruby on Rails** pour la logique d'API, **Active Storage** pour le stockage des fichiers, et **PostgreSQL** pour la persistance des données. L'ensemble est conteneurisé avec Docker. Ceci est une base, énormément de choses peuvent encore être ajoutées notemment l'aspect sécurité.

***

## ✨ Fonctionnalités Clés

* **Stockage Persistant :** Utilisation d'Active Storage avec un volume Docker (`profile_images`) pour garantir la persistance des fichiers images, même après redémarrage du conteneur.
* **Traitement en Tâche de Fond :** Utilisation de **Solid Queue** pour l'analyse des images en arrière-plan (nécessaire pour les futures fonctionnalités de redimensionnement/variants).
* **Gestion Complète de l'Image :** Permet les opérations de Création/Mise à jour, Lecture (récupération de l'URL publique), et Suppression de la photo de profil par UID.

***

## 🚀 Stack Technique

| Composant | Rôle | Configuration |
| :--- | :--- | :--- |
| **Backend** | Ruby on Rails 8.1 | API Mode, Puma Server |
| **Base de Données** | PostgreSQL 16 | Persistance des données et des métadonnées (Active Record) |
| **Stockage Fichiers** | Active Storage | Utilisation du service `Disk` monté sur un **Volume Docker persistant** (`profile_images`) |
| **File d'Attente** | Solid Queue / Active Job | Gestion des tâches asynchrones (analyse d'images) |
| **Conteneurisation** | Docker & Docker Compose | Orchestration de l'application (`web`) et de la base de données (`db`) |

***

## 🎯 Endpoints de l'API (Routes)

| Fonction | Méthode | Route Complète | Contrôleur#Action |
| :--- | :--- | :--- | :--- |
| **Télécharger / Mettre à Jour** | `POST` | `/profile_pictures/:uid` | `profile_pictures#create` |
| **Récupérer Image (Redirection)**| `GET` | `/profile_pictures/:uid` | `profile_pictures#show` |
| **Supprimer** | `DELETE` | `/profile_pictures/:uid` | `profile_pictures#destroy` |
| **Liste de la Collection** | `GET` | `/profile_pictures` | `profile_pictures#index` |
| **Vérification de Santé** | `GET` | `/` | X |

***

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
```

## 📧 Contact

👤 [HydroniumHA]
📧 [contact@hydronium.be]

## 🔗 Lien du Projet

👉 https://github.com/HydroniumHA/img-api-ruby-rails
