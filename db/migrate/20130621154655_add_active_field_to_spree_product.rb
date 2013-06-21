class AddActiveFieldToSpreeProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :instamart_id, :integer, default: false
    add_column :spree_products, :price, :integer, default: false
    add_column :spree_products, :display_price, :integer
  end
end
