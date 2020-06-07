class ChangeActionsToActivitys < ActiveRecord::Migration[5.2]
  def change
    rename_table :actions, :activitys
  end
end
