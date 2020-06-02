class CreateShopSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_schedules do |t|
      t.integer :shop_id
      t.date :shop_schedule_date
      t.integer :shop_schedule_time_cd

      t.timestamps
    end
  end
end
