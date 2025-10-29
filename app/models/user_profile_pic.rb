require 'active_storage/content_type_validator' 
require 'active_storage/size_validator'

class UserProfilePic < ApplicationRecord
  # Active Storage : Lie l'enregistrement de cette table (User Profile Pic)
  # à un seul fichier image binaire.
  has_one_attached :picture 

  # Validations pour l'identifiant unique de Firebase
  validates :firebase_uid, presence: true, uniqueness: true

  # Valide le type de contenu (MIME type)
  validates_with ActiveStorage::Attached::ContentTypeValidator, 
    attributes: :picture, 
    in: %w[image/jpeg image/png image/jpg]
    
  # Valide la taille du fichier
  validates_with ActiveStorage::Attached::SizeValidator, 
    attributes: :picture, 
    less_than: 5.megabytes
end
