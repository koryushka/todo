module TasksHelper
  def change_users_tasks!(user)
    user.tasks.each do |t|
      t.owner_id = @user.id
      t.owner_type = "User"
      t.save
    end 
  end
end
