class UserProfilePic < ApplicationRecord
  # Active Storage : Lie l'enregistrement de cette table (User Profile Pic)
  # à un seul fichier image binaire.
  has_one_attached :picture 

  # Validations pour l'identifiant unique de Firebase
  validates :firebase_uid, presence: true, uniqueness: true

  # Validations pour l'image (exécution au moment de l'upload)
  validates :picture, 
            content_type: [:png, :jpg, :jpeg], # Types de fichiers autorisés
            size: { less_than: 5.megabytes },   # Taille maximale du fichier (5 Mo)
            # Cette validation ne s'exécute que si un fichier est attaché
            if: -> { picture.attached? }
end
