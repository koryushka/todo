class AddDetailsToTasks < ActiveRecord::Migration
  def change
  	remove_column :tasks, :owner_id
    add_reference :tasks, :owner, index: true, polymorphic: :true
  end
end
