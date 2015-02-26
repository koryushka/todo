class Task < ActiveRecord::Base
  scope :done, ->{where(is_done: true)}
  scope :to_do, ->{where(is_done: false)}

  def resolve!
  	self.update_attributes(is_done:true)
  end
end
