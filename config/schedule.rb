# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']
set :output, "cronlog.log"
#set :bundle_command, "/home/koryushka/.rvm/gems/ruby-2.1.5@global/bin/bundle"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#

# Learn more: http://github.com/javan/whenever
every 1.minute do
	rake "demo_user:clear_demo_users"
end