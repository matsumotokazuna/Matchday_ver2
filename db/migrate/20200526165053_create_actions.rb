class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.integer :male_user_id
      t.integer :female_user_id
      t.datetime :male_matching_at
      t.datetime :female_matching_at
      t.datetime :matching_at
      t.date :matching_date
      t.integer :matching_time_cd
      t.integer :shop_id

      t.timestamps
    end
  end
end
