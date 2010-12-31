#require "bundler/capistrano"

set :scm, :git
set :application, "Bookm.arq"
set :repository,  "git://github.com/pbalduino/bookmarq.git"
set :branch, "master"
set :deploy_via, :checkout
set :deploy_to, "/var/www/bookmarq"

set :user, 'pftechroot'
set :ssh_options, { :forward_agent => true }

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.bookm.arq.br"                          # Your HTTP server, Apache/etc
role :app, "www.bookm.arq.br"                          # This may be the same as your `Web` server
role :db,  "www.bookm.arq.br", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

end
