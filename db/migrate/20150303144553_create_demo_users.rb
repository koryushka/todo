class CreateDemoUsers < ActiveRecord::Migration
  def change
    create_table :demo_users do |t|

      t.timestamps null: false
    end
  end
end
