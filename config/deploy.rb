# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "rails_app"
set :repo_url, "git@github.com:mohd-adib/rails_app.git"
set :deploy_to, '/root/rails_app'


set :rails_env, 'production'
server '35.187.227.33', user: "root", roles: %w{app db web}, primary: true
set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :config_example_suffix, '.example'
set :config_files, %w{config/database.yml config/secrets.yml}
set :rvm_ruby_version, '2.5.0'

set :passenger_restart_with_touch, true

namespace :logs do
  desc "tail rails logs" 
  task :tail_rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end
end