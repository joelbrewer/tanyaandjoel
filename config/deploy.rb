require 'rvm/capistrano'
require 'bundler/capistrano'

#RVM and bundler settings
#set :bundle_cmd, "/Users/joelbrewer/.rvm/gems/ruby-2.0.0-p353@global/bin/bundle"
#set :bundle_dir, "/Users/joelbrewer/.rvm/gems/ruby-2.0.0-p353/gems"
#set :rvm_ruby_string, :local
#set :rack_env, :production

#general info
set :user, 'ubuntu'
set :domain, 'ec2-54-191-201-125.us-west-2.compute.amazonaws.com'

set :applicationdir, "/home/www/tanyaandjoel"
set :scm, 'git'
set :application, "tanyaandjoel"
set :repository,  "git@github.com:jahbrewski/tanyaandjoel.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :deploy_via, :remote_cache

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :deploy_to, applicationdir
set :deploy_via, :export

#additional settings -- mostly SSH
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "keys/tolkien_key_pair.cer")]
ssh_options[:paranoid] = false
default_run_options[:pty] = true
set :use_sudo, true

after "deploy:cold" do
  admin.nginx_restart
end

namespace :deploy do
  desc "Not starting as we're running passenger."
  task :start do
  end
end
