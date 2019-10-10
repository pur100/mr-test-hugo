      Rails.application.routes.draw do
        root :to => 'home#index'
        get :home, to: 'home#home'
        mount ShopifyApp::Engine, at: '/'
        # root to: 'pages#home'
        namespace :api, defaults: { format: :json } do
         namespace :v1 do
           get 'products', to: 'products#index'
         end
        end
        # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
        resource :recurring_application_charge, only: [:show, :create_free_plan, :create_silver_plan, :create_gold_plan, :destroy] do
          collection do
            get :create_free_plan, to: 'recurring_application_charges#create_free_plan'
            get :create_silver_plan, to: 'recurring_application_charges#create_silver_plan'
            get :create_gold_plan, to: 'recurring_application_charges#create_gold_plan'
            get :show, to: 'recurring_application_charges#show'
            get :callback
            post :customize
          end
        end
      end




