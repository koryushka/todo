class RenameIsNotDone < ActiveRecord::Migration
  def change
  	rename_column :tasks, :is_not_done, :is_done
  end
end
