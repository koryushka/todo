class UserMailer < ApplicationMailer
  #include Resque::Mailer
  def new_task(user_id)
    @user_id = user_id
    @task = User.find(user_id).tasks.last
    #attachments.inline['2.jpg'] = File.read("#{Rails.root}/app/assets/images/2.jpg")
    mail(to: User.find(user_id).email, subject:"Your task is ready")

  end
end
