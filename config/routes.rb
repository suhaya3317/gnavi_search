Rails.application.routes.draw do
  root              to: 'restaurant#top'
  get 'list',       to: 'restaurant#top'
  post 'list',      to: 'restaurant#list'
  get 'detail/:id', to: 'restaurant#detail', as: 'detail'
end
