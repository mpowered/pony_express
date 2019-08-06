PonyExpress::Engine.routes.draw do
  post 'messages/:message', :controller => "messages", :action => "create"
  resources :messages, :only => :create
end
