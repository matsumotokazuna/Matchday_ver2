class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :gender_cd, :integer
    add_column :users, :birth_date, :date
    add_column :users, :prefecture_cd, :integer
    add_column :users, :user_image_id, :string
    add_column :users, :job_cd, :integer
    add_column :users, :height_cd, :integer
    add_column :users, :income_cd, :integer
    add_column :users, :marriage_history_cd, :integer
    add_column :users, :marriage_purpose_cd, :integer
    add_column :users, :housemate_cd, :integer
    add_column :users, :holiday_cd, :integer
    add_column :users, :alcohol_cd, :integer
    add_column :users, :cigaret_cd, :integer
    add_column :users, :introduction, :text
    add_column :users, :disabled_at, :datetime
  end
end
