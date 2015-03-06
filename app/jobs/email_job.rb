class EmailJob
  @queue = :send_email
  def self.perform(user_id)
    user = User.find(user_id)
    UserMailer.new_task(user_id).deliver_later
    puts "#Just sent email to {user.email}"
  end
end