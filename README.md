# Step By Step

## Seting the scene

This project was created to practise the folowing aspects:

* MVC
* Polymorphic Models
* User authentication with Devise
* Active storage atachments with Cloudinary(SaaS)
* AJAX

## 1. Environment

```  console
$ rails new Blog --database=postgresql
```

### 1.1 Webpack - dependencies

```  console
$ yarn add bootstrap jquery@~3.4.1 poppers @fortawesome/fontawesome-free
```

*#webpacker.yml*

```  ruby
resolved_paths: [app/assets]
```

### 1.2 Bootstrap

*#config/webpack/environment*

``` ruby

  const webpack = require('webpack')
  environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      Popper: ['popper.js', 'default']
    })
  )

```

/////// "Heroku needs this localhost don't" ///////

*#app/assets/stylesheets/application.css*

``` ruby
*= require bootstrap/scss/bootstrap
```

*#app/javascript/packs/application.js*

``` ruby
require('jquery')
global.$ = jQuery;
import "@fortawesome/fontawesome-free/js/all"
import "./bootstrapjs"
```

Create <addr>..packs/stylesheets/bootstrapjs.js</addr>

``` javascript

$(function() {
  $('[data-toggle="tooltip"]').tooltip();
});

$(function() {
  $('[data-toggle="popover"]').popover();
});

```

### 2. Gemfile
Gems on top of the default stack:

``` ruby
gem 'cloudinary'
gem 'devise'
gem 'dotenv-rails', groups: [:development, :test]
gem 'faker'
gem 'friendly_id'
gem 'simple_form'
gem 'will_paginate'

group :development, :test do
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.4'
  gem 'rspec-rails', '~> 4.0'
end
```
```
$ bundle
```

### 2.1 Devise

``` ruby
$ rails g devise:install
```

*#config/environments/development.rb*

``` ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

*#app/views/leyouts/application.html.erb*

``` ruby

<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>

```

### 2.2 Simple_form

``` console
$ rails generate simple_form:install
```

### 2.3 Dotenv-rails

``` console
$ touch .env
$ echo '.env*' >> .gitignore
```

### 2.4 Cloudinary

Save Environment variable into the .env file.

``` console
$ rails active_storage:install
```
*config/storage.yml*
```
cloudinary:
  service: Cloudinary
```
*config/environments/development.rb*
*config/environments/production.rb*

```rails
config.active_storage.service = :cloudinary
```

Push CLOUDINARY_URL env variable to Heroku

``` console
$ heroku config:set CLOUDINARY_URL
```

# Tests

``` console
$ rake spec
```
or
``` console
$ rails spec
```
