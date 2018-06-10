Rails.application.routes.draw do

  # This in place for testing and example
  # scope module: :v2, constraints: ApiVersion.new('v2') do
  #   resources :workouts, only: :index
  # end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :workouts do
      resources :exercises
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
