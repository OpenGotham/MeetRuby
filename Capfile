require 'capistrano/ext/multistage'
require 'bundler/capistrano'
set :stages, %w(testing staging production) 
set :default_stage, 'staging'

load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'
