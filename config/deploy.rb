serverlist = [ 'testing.meetruby.com','staging.meetruby.com','production.meetruby.com']
namespace :nginx do
  task :start, :roles => :app do
    sudo "nohup /etc/init.d/nginx start > /dev/null"
  end

  task :restart, :roles => :app do
    sudo "nohup /etc/init.d/nginx restart > /dev/null"
  end
end
task :uname do
  run "uname -a"
end


namespace :bundler do
  task :create_symlink, :roles => :app do
      shared_dir = File.join(shared_path, 'bundle')
      release_dir = File.join(current_release, '.bundle')
      run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
    end

    task :bundle_new_release, :roles => :app do
      bundler.create_symlink
      run "cd #{release_path} && bundle install --without test"
    end

    task :lock, :roles => :app do
      run "cd #{current_release} && bundle lock;"
    end

    task :unlock, :roles => :app do
      run "cd #{current_release} && bundle unlock;"
    end
end
  namespace :resque do
    desc 'Stop the god resque process'
    task :restart, :roles => :db do
      sudo "god restart resque"
      #run 'cd #{current_path} && RAILS_ENV=#{ENV["DEPLOY"]} script/job_runner stop'
    end

    desc 'Start the delayed_job process'
    task :start, :roles => :db do
      sudo "god terminate"
      #run 'cd #{current_path} && RAILS_ENV=#{ENV["DEPLOY"]} script/job_runner start'
    end

    desc 'Restart the delayed_job process'
    task :start, :roles => :db do
      sudo "god -c /etc/god.rb"
      #run 'cd #{current_path} && RAILS_ENV=#{ENV["DEPLOY"]} script/job_runner restart'
    end
  end

  task :tail_log, :roles => :app do
    sudo "tail -30 #{shared_path}/log/#{ENV["DEPLOY"]}.log"
  end
  desc "Tail Rails application log"
  task :tail, :roles => :app do
    tail_log "#{shared_path}/log/#{ENV["DEPLOY"]}.log"
  end
  namespace :mysql do
    desc "Restarts MySQL database server"
    task :restart, :roles => :db do
      sudo "/etc/init.d/mysql restart"
    end

    desc "Starts MySQL database server"
    task :start, :roles => :db do
      sudo "/etc/init.d/mysql start"
    end

    desc "Stops MySQL database server"
    task :stop, :roles => :db do
      sudo "/etc/init.d/mysql stop"
    end

    desc "Export MySQL database"
    task :export, :roles => :db do
      database = Capistrano::CLI.ui.ask("Which database should we export: ")
      sudo "mysqldump -u root -p #{database} > #{database}.sql"
    end

    desc "Import MySQL database"
    task :import, :roles => :db do
      database = Capistrano::CLI.ui.ask("Which database should we create: ")
      file = Capistrano::CLI.ui.ask("Which database file should we import: ")
      sudo "mysqladmin -u root -p create #{database}"
      sudo "mysql -u root -p #{database} < #{file}"
    end

    desc "Install MySQL"
    task :install, :roles => :db do
      sudo "aptitude install -y mysql-server mysql-client libmysqlclient15-dev"
      sudo "aptitude install -y libmysql-ruby1.8"
    end

    
  end
  namespace :patch do
    task :replace, :roles => :app do
      run "sed -e 's/blography\.com/#{domain}/g' #{release_path}/config/environments/#{ENV['DEPLOY']}.rb > /tmp/tmp_prodfile && mv /tmp/tmp_prodfile #{release_path}/config/environments/#{ENV['DEPLOY']}.rb"
      run "sed -e 's/blography\.com/#{domain}/g' #{release_path}/config/settings.yml > /tmp/tmp_settingsfile && mv /tmp/tmp_settingsfile #{release_path}/config/settings.yml"
    end
    task :dbconfig do
      sudo "cp #{release_path}/config/deploy_database.yml #{release_path}/config/database.yml"
    end
    
  end
  
  
  namespace :slice do
    task :uname, :roles => :db do
      run "uname -a"
    end


    desc "Show the amount of free disk space."
    task :free, :roles => :db do
      run "df -h /"
    end

    desc "Show free memory"
    task :memory, :roles => :db do
      run "free -m"
    end
    

  end
 
  # Thinking Sphinx
  namespace :thinking_sphinx do
    task :configure, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:configure #{ENV['DEPLOY']}"
    end
    task :index, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:index #{ENV['DEPLOY']}"
    end
    task :start, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:start #{ENV['DEPLOY']}"
    end
    task :stop, :roles => [:app] do
      run "cd #{current_path}; rake thinking_sphinx:stop #{ENV['DEPLOY']}"
    end
    task :restart, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:restart #{ENV['DEPLOY']}"
    end
    task :rebuild, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:rebuild #{ENV['DEPLOY']}"
    end
  end

  # Thinking Sphinx typing shortcuts
  namespace :ts do
    task :conf, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:configure #{ENV['DEPLOY']}"
    end
    task :in, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:index #{ENV['DEPLOY']}"
    end
    task :start, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:start #{ENV['DEPLOY']}"
    end
    task :stop, :roles => [:app] do
      run "cd #{current_path}; rake thinking_sphinx:stop #{ENV['DEPLOY']}"
    end
    task :restart, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:restart #{ENV['DEPLOY']}"
    end
    task :rebuild, :roles => [:app] do
      run "cd #{release_path}; rake thinking_sphinx:rebuild #{ENV['DEPLOY']}"
    end
  end


  namespace :deploy do
    task :start, :roles => :app do
     
      sudo "/etc/init.d/unicorn /var/www/meetruby start #{ENV['DEPLOY']}"
    end
    task :stop, :roles => :app do
      sudo "thor unicorn stop '#{release_path}'"
    end
    task :restart, :roles => :app do
      sudo "thor unicorn restart '#{release_path}'"
    end
    task :gentle_restart, :roles => :app do
      sudo "thor unicorn upgrade '#{release_path}'"
    end
    task :addworker, :roles => :app do
      sudo "thor unicorn addworker '#{release_path}'"
    end
    task :reduce, :roles => :app do
      sudo "thor unicorn reduce '#{release_path}'"
    end
    
    desc "Symlink shared sockets on each release."
    task :symlink_shared_sockets do
      run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
    end
    

   
  end

  after "deploy:update_code", "deploy:symlink_shared_sockets"
  after "deploy:symlink_shared_sockets","bundler:bundle_new_release"
  after "deploy", "deploy:cleanup"
  after "deploy:migrations", "deploy:cleanup"
