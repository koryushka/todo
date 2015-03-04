class AddDemoUserIdToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :demo_user_id, :integer
  end
end
