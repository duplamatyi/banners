Rails.application.routes.draw do
  # get 'campaigns/show'
  get '/campaigns/:id', to: 'campaigns#show', as: 'campaigns'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
