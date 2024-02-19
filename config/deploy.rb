# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"

set :application, "daily-tools"
set :repo_url, "git@github.com:chen1125he/daily_tool_rails.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :deploy_to, '/data/www/daily-tools'
set :rbenv_prefix,
    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails puma pumactl]

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'node_modules', 'tmp/videos',
       'public/app'

append :linked_files, 'config/database.yml', 'config/master.key', '.env'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'tmp/videos', 'public/app',
       'tmp/images'
namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end

        unless test("[ -f #{shared_path}/config/database.yml ]")
          upload! 'config/database.yml', "#{shared_path}/config/database.yml"
        end
      end
    end
  end
end

SSHKit.config.command_map[:sidekiq] = 'bundle exec sidekiq'
SSHKit.config.command_map[:sidekiqctl] = 'bundle exec sidekiqctl'
