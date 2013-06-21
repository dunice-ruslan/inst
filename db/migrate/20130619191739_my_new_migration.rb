class MyNewMigration < ActiveRecord::Migration
  def up
    add_column :spree_products_taxons, :home_phone, :integer
  end
  def down
    remove_column :aaas, :home_phone
  end
end
