class CreateUserSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :user_schedules do |t|
      t.integer :user_id
      t.date :user_schedule_date
      t.integer :user_schedule_time_cd

      t.timestamps
    end
  end
end
