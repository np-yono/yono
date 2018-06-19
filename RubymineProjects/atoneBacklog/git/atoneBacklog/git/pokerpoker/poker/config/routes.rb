Rails.application.routes.draw do

  post "result" => "posts#result"
  get "/" => "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount API::Root => '/'

end
