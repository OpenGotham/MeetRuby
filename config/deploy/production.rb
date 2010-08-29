set :application, 'meetruby'
set :domain, 'meetruby.com'
default_run_options[:pty] = true
server 'meetruby.com', :app, :web, :db
role :appservers, 'meetruby.com','meetruby.com','meetruby.com'

set :scm, :git
set :repository, 'git@github.com:OpenGotham/MeetRuby.git'
set :user, 'mjording'
set :scm_passphrase, 'grackle'
set :branch, 'master'
set :primary, true

set :use_sudo, false
set :ssh_options, { :port => 2223, :forward_agent => true }




set :deploy_via, :remote_cache
set :git_enable_submodules, 1

set :deploy_to, '/var/www/meetruby'