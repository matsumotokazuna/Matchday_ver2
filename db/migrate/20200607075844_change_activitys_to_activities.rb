class ChangeActivitysToActivities < ActiveRecord::Migration[5.2]
  def change
    rename_table :activitys, :activities
  end
end
