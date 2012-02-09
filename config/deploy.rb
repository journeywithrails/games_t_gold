default_run_options[:pty] = true

set :user, 'gamdoco'
#~ set :user, 'lvedo'
set :application, 'gg'

#~ set :repository,  'ssh://gamdoco@gamdo.com/~/src/gg.git'
set :repository,  'https://secure.odesk.com/svn/NorpSolutions:gandgteam/trunk/'
set :deploy_to, "/home/#{user}/etc/rails_apps/#{application}"
set :deploy_via, :remote_cache
#~ set :scm, :git
set :scm, :subversion
#~ set :branch, 'master'
#~ set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server 'gamdo.com', :app, :web
role :db, 'gamdo.com', :primary => true

after 'deploy:update_code', 'db:symlink', 'assets:symlink'

namespace :db do

  task :symlink do
    run "ln -nfs #{shared_path}/system/database.yml #{release_path}/config"
  end

end

namespace :assets do

  task :symlink do
    run "ln -nfs #{shared_path}/public/photos #{release_path}/public"
    run "ln -nfs #{shared_path}/public/teams #{release_path}/public"
  end

end

namespace :deploy do

  task :start, :roles => :app do
    run <<-CMD
      cd #{current_path} &&
      mongrel_rails start -e production -p 12001 -d
    CMD
  end

  task :stop, :roles => :app do
    run <<-CMD
      cd #{current_path} &&
      mongrel_rails stop
    CMD
  end

  task :restart, :roles => :app do
    stop
    start
  end

end
