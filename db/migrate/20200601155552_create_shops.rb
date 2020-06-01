class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :shop_name
      t.string :postal_code
      t.string :prefecture_cd
      t.string :city
      t.string :building
      t.string :shop_image_id
      t.boolean :invalid_flg

      t.timestamps
    end
  end
end
