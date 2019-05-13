Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/auzmor', module: 'api' do
    resources :sms, only: [] do
      collection do
        post :inbound
        post :outbound
      end
    end
  end

  match '*unmatched_route' => 'errors#not_found' , via: [:get, :post, :put, :delete]
end
