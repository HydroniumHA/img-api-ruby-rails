class UserProfilePic < ApplicationRecord
  # Active Storage : Lie l'enregistrement de cette table (User Profile Pic)
  # à un seul fichier image binaire.
  has_one_attached :picture 

  # Validations pour l'identifiant unique de Firebase
  validates :firebase_uid, presence: true, uniqueness: true

  # Valide
  validates :picture, 
    content_type: { in: %w[image/jpeg image/png image/jpg], message: 'doit être un JPEG ou PNG' },
    size: { less_than: 5.megabytes, message: 'doit être inférieur à 5MB' }
end
