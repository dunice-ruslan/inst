require 'bundler/capistrano'
require "rvm/capistrano"
set :application, "inst"



set :rvm_ruby_string, :local        # use the same ruby as used locally for deployment

before 'deploy', 'rvm:install_rvm'  # update RVM
before 'deploy', 'rvm:install_ruby'


set :rvm_ruby_string, '1.9.3@inst'

set :rvm_ruby_string, :local               # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, OR:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset


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



