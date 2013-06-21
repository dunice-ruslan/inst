require 'bundler/capistrano'
require "rvm/capistrano"
set :application, "inst"

set :rvm_ruby_string, "1.9.3"
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake"
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"


set :repository, "git@github.com:dunice-ruslan/inst.git"
set :scm, :git
set :deploy_server,   "vs02.secoint.ru"

set :user,            "instamart"
set :login,           "instamart"
set :use_sudo,        false
set :deploy_to,       "/home/#{user}/#{application}"
set :bundle_dir,      File.join(fetch(:shared_path), 'gems')
set :deploy_via, "remote_cache"
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, :primary => true


before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, :roles => :app do
  set :current_release, latest_release
end



