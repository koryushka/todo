class DemoUser < ActiveRecord::Base
	has_many :tasks, dependent: :destroy, as: :owner

  def self.clear_demo_users
    DemoUser.destroy_all
  end

end
