######################################################################
### Heroku
######################################################################

#default
$heroku_app = 'appname-staging'
$git_remote = 'staging'

namespace :deploy do
  desc 'Set deployment to Production'
  task :production do
    $heroku_app = 'appname'
    $git_remote = 'production'
  end
end
