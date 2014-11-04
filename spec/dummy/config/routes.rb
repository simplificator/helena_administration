Rails.application.routes.draw do
  mount HelenaAdministration::Engine => "/administration"
  mount Helena::Engine => "/helena"
end
