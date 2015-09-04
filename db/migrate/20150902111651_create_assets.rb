class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :image_name
      t.integer :assetable_id
      t.string :assetable_type
      t.string :alt_text

      t.timestamps null: false
    end
  end
end
