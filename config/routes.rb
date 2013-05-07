PonyExpress::Engine.routes.draw do
  match 'messages/:message', :controller => "messages", :action => "create"
  resources :messages, :only => :create
end
