ActiveAdmin.register Category do
  permit_params :name

  config.filters = false
end