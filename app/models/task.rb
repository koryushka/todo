class Task < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  scope :done, ->{where(is_done: true)}
  scope :to_do, ->{where(is_done: false)}
  scope :demo, ->{where(owner_type: "DemoUser")}

  def resolve!
  	self.update_attributes(is_done:true)
  end

  def unresolve!
  	self.update_attributes(is_done:false)
  end


end
