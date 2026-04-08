ActiveAdmin.register Order do
  permit_params :user_id, :address_id, :status, :subtotal, :tax_amount, :total_amount

  index do
    selectable_column
    id_column
    column :user do |order|
      order.user.email
    end
    column :address
    column :status
    column :subtotal
    column :tax_amount
    column :total_amount
    column :created_at
    actions
  end

  filter :user_email, as: :string
  filter :status
  filter :subtotal
  filter :tax_amount
  filter :total_amount
  filter :created_at

  show do
    attributes_table do
      row :id
      row :user do |order|
        order.user.email
      end
      row :address
      row :status
      row :subtotal
      row :tax_amount
      row :total_amount
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price_at_purchase
      end
    end
  end
end