### DB Migrate
```
$ bundle exec rake db:migrate
$ #bundle exec rake db:reset
$ bundle exec rake db:populate
$ bundle exec rake db:test:prepare
```

### Annotate with database 
> bundle exec annotate

### Data Migration
> gem install yaml_db

```
rake db:dump
rake db:load
```

`/db/data.yaml`


### Faker
> http://rubydoc.info/github/stympy/faker/master/frames

### Gem for Rails 
> http://wenbin151.iteye.com/blog/599391

### Rspec
> $ bundle exec rspec spec/

### Generate Controller
> $ rails generate controller Users new --no-test-framework

### Generate Model
> $ rails generate model User name:string email:string
```
$ rails generate model User name:string email:string
      invoke  active_record
      create    db/migrate/[timestamp]_create_users.rb
      create    app/models/user.rb
      invoke    rspec
      create      spec/models/user_spec.rb
```
### Add Index
$ rails generate migration add_index_to_users_email

####Rails comes with a script for making controllers called generate; all it needs to work its magic is the controller’s name. In order to use generate with RSpec, you need to run the RSpec generator command if you didn’t run it when following the introduction to this chapter:

> $ rails generate rspec:install

### Generate Rspec  Test-driven development
> $ rails generate integration_test static_pages
```
 $ rails generate integration_test static_pages
      invoke  rspec
      create    spec/requests/static_pages_spec.rb
```
