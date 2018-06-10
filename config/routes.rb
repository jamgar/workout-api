Rails.application.routes.draw do
  resources :workouts do
    resources :exercises
  end

  post 'auth/login', to: 'authentication#authenticate'
end
