class ChangeDataPrefectureCdShop < ActiveRecord::Migration[5.2]
  def change
    change_column :shops, :prefecture_cd, :integer
  end
end
