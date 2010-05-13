Crunch Account Setup
=====================

Heroku Account
--------------

Hosting

* http://www.heroku.com
* user: technical@salescrunch.com 
* pass: TODO

GitHub Account
--------------

Source control

* https://github.com/salescrunch
* user: salescrunch
* pass: TODO

Pivotal Tracker
---------------

Project Management

* Please ask an existing developer to be invited

Amazon S3
---------

Keys are stored in config/s3.yml

* http://s3.amazonaws.com/s3fm/index.html
* access_key_id: TODO
* secret_access_key: TODO 

Hoptoad
-------

This is used to track errors in production.

* http://salescrunch.hoptoadapp.com
* user: TODO
* pass: TODO

New Relic
---------

Captures performance data on the rails app.

* http://www.newrelic.com
* Account Name: use heroku interface 
* Login email: 
* Password: 
* License Key: 

Google Maps API
---------------

Key for Google Maps API

* http://code.google.com/apis/maps/signup.html
* Account listed under david@salescrunch.com Google Account
* http://salescrunch.com: TODO

Deployment to Heroku
====================

Direct push to staging

    git push staging master
    heroku rake db:migrate --app crunch-staging
    heroku restart --app crunch-staging

Rake task for deployment that does the following actions: push, restart, and tag

`rake deploy`

And if migrations exist, this will: push, app off, migrate, restart, app on, and tag

`rake deploy:migrations`

TODO:
* heroku to handle compass
* handle production (vlad-like rake argument)
* backup task exists, need to integrate into current deployment sequence

Development Setup
=================

Tests
-----

Using RSpec.

Memcached
---------

Memcached is required to help troubleshoot complicated caching problems if they arise - beats faking it.

Use: http://github.com/andrewfromcali/mcinsight

Postgres Database
-----------------

Heroku uses v8.3 and not v8.4

    # install postgres
    sudo port install postgresql83 postgresql83-server
    
    sudo mkdir -p /opt/local/var/db/postgresql83/defaultdb
    sudo chown postgres:postgres /opt/local/var/db/postgresql83/defaultdb
    sudo su postgres -c '/opt/local/lib/postgresql83/bin/initdb -D /opt/local/var/db/postgresql83/defaultdb'
    
    # this starts the servers and sets it up to autostart on reboot
    sudo launchctl load -w /Library/LaunchDaemons/org.macports.postgresql83-server.plist
    
    # create a database user
    createuser -U postgres -sPE [your_database_user]

    # create _dev and _test databases
    /opt/local/lib/postgresql83/bin/psql -U [your_database_user] postgres
    postgres=# \l
             List of databases
         Name     |  Owner   | Encoding 
    --------------+----------+----------
     postgres     | postgres | UTF8
     template0    | postgres | UTF8
     template1    | postgres | UTF8
    postgres=# create database crunch_dev;
    postgres=# create database crunch_test;
    postgres=# \q
 
    # install pg gem
    export PATH=/opt/local/lib/postgresql83/bin:${PATH}
    env ARCHFLAGS="-arch x86_64" gem install pg

Heroku
------

Install the heroku gem locally:
    http://docs.heroku.com/quickstart

Setup your apps using:
    git clone git@github.com:databyte/crunch.git crunch
    git remote add production git@heroku.com:crunch.git
    git remote add staging git@heroku.com:crunch-staging.git

Push to staging all you want with:
    git push staging master

Access the server at:
    http://crunch-staging.heroku.com
    user: admin@crunch.com
    pass: admin

Debug remotely:
    heroku logs --app crunch-staging
    heroku restart --app crunch-staging
    heroku console --app crunch-staging

Copy database to local (assuming you have Postgres setup locally):
    heroku db:pull postgres://postgres:_pass_@localhost/crunch_development --app crunch

