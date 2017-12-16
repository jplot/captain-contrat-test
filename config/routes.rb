Rails.application.routes.draw do
  scope format: false do
    devise_for :users, skip: :registrations

    devise_scope :user do
      unauthenticated do
        root controller: 'devise/sessions', action: :new
      end

      authenticated do
        root controller: :characters, action: :index, as: :authenticated_root
      end

      resource :registration,
        only: %i[new create edit update],
        path: 'users',
        path_names: { new: 'sign_up' },
        controller: 'devise/registrations',
        as: :user_registration do
          get :cancel
        end
    end

    resources :characters
  end
end
