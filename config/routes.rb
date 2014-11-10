# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'toggl', to: 'toggl_timer#index'
post 'toggl', to: 'toggl_timer#create'
