class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :content
      t.boolean :is_done, default: false

      t.timestamps null: false
    end
  end
end
