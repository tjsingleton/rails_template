require Rails.root.join('config', 'deploy.rb')

task :deploy => ['deploy:push', 'deploy:restart']
task :deploy_prod => ['deploy:production', 'deploy:migrations', 'deploy:tag']

namespace :deploy do
  task :migrations => [:push, :off, :migrate, :restart, :on]
  task :rollback => [:off, :push_previous, :restart, :on]

  desc 'Push to Heroku'
  task :push do
    puts "Deploying #{$git_remote} to Heroku ..."
    puts `git push #{$git_remote}`
  end

  desc 'Restart Heroku application'
  task :restart do
    puts "Restarting #{$git_remote} app servers ..."
    puts `heroku restart --app #{$heroku_app}`
  end

  desc 'Tag release with datetime'
  task :tag do
    release_name = "release-#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
    puts "Tagging release as '#{release_name}'"
    puts `git tag -a #{release_name} -m 'Tagged release'`
    puts `git push --tags staging`
  end

  desc 'Migrate database on Heroku'
  task :migrate do
    puts 'Running database migrations ...'
    puts `heroku rake db:migrate --app #{$heroku_app}`
  end

  desc 'Maintenance on, application off'
  task :off do
    puts "Putting #{$heroku_app} into maintenance mode ..."
    puts `heroku maintenance:on --app #{$heroku_app}`
  end

  desc 'Maintenance off, application on'
  task :on do
    puts "Taking #{$heroku_app} out of maintenance mode ..."
    puts `heroku maintenance:off --app #{$heroku_app}`
  end

  desc 'Rollback site to previous release'
  task :push_previous do
    releases = `git tag`.split("\n").select { |t| t[0..7] == 'release-' }.sort
    current_release = releases.last
    previous_release = releases[-2] if releases.length >= 2
    if previous_release
      puts "Rolling back to '#{previous_release}' ..."
      puts `git push -f staging #{previous_release}:master`
      puts "Deleting rollbacked release '#{current_release}' ..."
      puts `git tag -d #{current_release}`
      puts `git push staging :refs/tags/#{current_release}`
      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
      puts releases
    end
  end

  desc 'Captures a Heroku bundle and download it (stored in backups/)'
  task :backup do
    timestamp = `date -u '+%Y-%m-%d-%H-%M'`.chomp
    bundle_name = "staging-#{timestamp}"
    puts "Capturing bundle #{bundle_name}..."
    `heroku bundles:capture --app staging '#{bundle_name}'`
    # poll for completion (warning, a little hacky)
    begin
      bundles = `heroku bundles --app staging`
    end while bundles.match(/complete/).nil?
    # download & destroy the bundle we just captured
    %w(download destroy).each do | action |
      `heroku bundles:#{action} --app staging '#{bundle_name}'`
    end

    `mv staging.tar.gz backups/#{bundle_name}.tar.gz`
    puts "Bundle captured and stored in backups/#{bundle_name}.tar.gz"
  end

end