Rails.application.routes.draw do
  match '/api/inbound/sms/' => 'api/sms#inbound' , via: :post
  match '/api/outbound/sms/' => 'api/sms#outbound' , via: :post
  match '*unmatched_route' => 'errors#not_found' , via: [:get, :post, :put, :delete]
end
