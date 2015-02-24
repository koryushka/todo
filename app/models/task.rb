class Task < ActiveRecord::Base
	scope :done, ->{where(is_not_done: false)}
  scope :to_do, ->{where(is_not_done: true)}
end
