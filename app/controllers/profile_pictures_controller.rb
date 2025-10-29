class ProfilePicturesController < ApplicationController
  # Assure que nous trouvons l'enregistrement ou préparons le contexte pour la création
  before_action :set_user_pic, only: [:show, :destroy]
  
  # POST /profile_pictures/:uid (Upload ou remplacement)
  def create
    uid = params[:uid]
    picture_file = params[:picture]

    unless uid && picture_file
      return render json: { error: "UID ou fichier image manquant" }, status: :unprocessable_entity
    end

    # 1. Trouve ou initialise un nouvel enregistrement basé sur l'UID Firebase
    user_pic = UserProfilePic.find_or_initialize_by(firebase_uid: uid)
    
    # 2. Attache la nouvelle image (remplace l'ancienne si elle existe)
    user_pic.picture.attach(picture_file)

    if user_pic.save
      render json: { 
        message: "Photo de profil téléchargée/mise à jour avec succès",
        uid: user_pic.firebase_uid,
        # Génère l'URL publique pour que le front-end puisse la récupérer
        url: rails_blob_url(user_pic.picture) 
      }, status: :created
    else
      # 3. Gère les erreurs de validation (type/taille de fichier)
      render json: { errors: user_pic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /profile_pictures/:uid (Récupération de l'image)
  def show
    if @user_pic&.picture&.attached?
      # Redirige vers l'URL sécurisée et signée stockée dans le volume Docker
      redirect_to rails_blob_url(@user_pic.picture, disposition: "inline")
    else
      render json: { error: "Photo de profil non trouvée pour l'UID #{params[:uid]}" }, status: :not_found
    end
  end

  # DELETE /profile_pictures/:uid (Suppression de l'image)
  def destroy
    if @user_pic&.picture&.attached?
      @user_pic.picture.purge # Supprime à la fois l'enregistrement Active Storage et le fichier du volume
      render json: { message: "Photo de profil supprimée" }, status: :ok
    else
      render json: { error: "Photo de profil non trouvée" }, status: :not_found
    end
  end

  private

  # Tente de trouver l'enregistrement UserProfilePic par l'UID
  def set_user_pic
    @user_pic = UserProfilePic.find_by(firebase_uid: params[:uid])
  end
end