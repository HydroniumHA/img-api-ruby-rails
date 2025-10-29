class UserProfilePic < ApplicationRecord
  # Active Storage : Lie l'enregistrement de cette table (User Profile Pic)
  # à un seul fichier image binaire.
  has_one_attached :picture 

  # Validations pour l'identifiant unique de Firebase
  validates :firebase_uid, presence: true, uniqueness: true
end
