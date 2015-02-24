class Task < ActiveRecord::Base
  scope :done, ->{where(is_done: true)}
  scope :to_do, ->{where(is_done: false)}
end
