# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do
  get 'download_history/:attachment_id' => 'download_history#show', as: :attachment_history
end
