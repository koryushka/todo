class ChangeTasks < ActiveRecord::Migration
  def change
  	rename_column :tasks, :user_id, :owner_id
  	remove_column :tasks, :demo_user_id
  end
end
