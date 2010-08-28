set :application, 'meetruby'
set :domain, 'staging.meetruby.com'
default_run_options[:pty] = true
server 'ogln001', :app, :web, :db
role :appservers,  'ogln001','ogln001','ogln001'

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
set :deploy_to, '/var/www/orderberry'