class CreateAaas < ActiveRecord::Migration
  def change
    create_table :aaas do |t|
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
