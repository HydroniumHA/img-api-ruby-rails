Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # Une route de test pour vérifier que l'API est vivante
  get "/", to: proc { [200, {}, ["OK"]] }

  # Définit les routes pour la ressource `profile_pictures`.
  # param: :uid indique à Rails d'utiliser la partie variable de l'URL comme 'uid'.
  # Only: définit les méthodes HTTP que nous gérons.
  resources :profile_pictures, param: :uid, only: [:show, :destroy] do
    member do
      post :create # Crée la route POST /profile_pictures/:uid (qui mappe à #create)
    end
  end

  # Active Storage nécessite des routes internes pour générer des URLs publiques,
  # qui sont activées automatiquement par Rails/Active Storage
end
