class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, :string, null: false, default:""
    change_column_null :users, :gender_cd, :integer, null: false, default:""
    change_column_null :users, :birth_date, :date, null: false, default:""
    change_column_null :users, :prefecture_cd, :integer, null: false, default:""
  end
end
