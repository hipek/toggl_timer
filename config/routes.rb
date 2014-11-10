# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :toggls, controller: 'toggl_timer', only: [:index, :create, :destroy]
