namespace :demo_user do
  desc "TODO"
  task clear_demo_users: :environment do
  	DemoUser.destroy_all
  end

end
