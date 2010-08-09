set :application, "castly"
set :repository,  "git@blinr.unfuddle.com:blinr/castly.git"

set :scm, :git
set :user, "apps"
set :use_sudo, false
role :app, "castly.com"
role :app, "castly.com"
role :db,  "castly.com", :primary => true

set :deploy_to, "/srv/apps/#{application}"


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    # run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "link the database.yml file over"
  task :link_database_config do
    run "ln -sF #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "use shared sockets dir"
  task :link_sockets_dir do
    run "mkdir -p #{shared_path}/sockets"
    run "ln -sF #{shared_path}/sockets #{release_path}/tmp/sockets"
  end
  
  task :bundle do
    run "cd #{release_path} && RAILS_ENV=production bundle install #{shared_path}/bundle"
  end
end

namespace :unicorn do
  task :start do
    run "(cd #{current_path} && unicorn_rails -c config/unicorn.rb -E production -D)"
  end
  task :stop do
    run "(cd #{current_path} && kill -QUIT `cat #{current_path}/tmp/pids/unicorn.pid`)"
  end
  task :restart do
    run "(cd #{current_path} && kill -USR2 `cat #{current_path}/tmp/pids/unicorn.pid`)"
  end
end

after 'deploy:update_code', 'deploy:bundle',
                            'deploy:link_database_config',
                            'deploy:link_sockets_dir'
                            
#after "deploy:restart", "unicorn:restart"
