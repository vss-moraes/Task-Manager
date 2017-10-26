Rails.application.routes.draw do
  get '/tarefas/estatisticas', to: 'tarefas#estatisticas'
  resources :tarefas
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
