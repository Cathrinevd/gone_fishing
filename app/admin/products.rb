ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :brand, :category_id, :image

  config.filters = false

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock
    column :brand
    column :category
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :brand
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :price
      row :stock
      row :brand
      row :category
      row :created_at
      row :updated_at
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), width: 150
        end
      end
    end
  end
end