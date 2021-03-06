Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect('/text_messages')

  resources :text_messages, only: :index, :defaults => { format: :html }
  resources :text_messages, only: :create, :defaults => { format: :json } do
    collection do
      post :delivery_status
    end
  end

  get 'text_messages/new', :defaults => { format: :html }
end
