class RenameIsDone < ActiveRecord::Migration
  def change
  	rename_column :tasks, :is_done, :is_not_done
  end
end
