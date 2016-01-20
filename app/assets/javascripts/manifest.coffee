## Bower components

#= require angular/angular
#= require angular-ui-router/release/angular-ui-router
#= require angular-rails-templates.js.erb
#= require angularjs/rails/resource
#= require angular-google-chart/ng-google-chart
#= require jquery
#= require jquery_ujs
#= require bootstrap-sass-official/assets/javascripts/bootstrap-sprockets


## Libraries

#= #require_tree ./libraries


## Application

#= require_tree ./modules
#= require app
#= require router
#= require_tree ./models
#= require_tree ./services
#= require_tree ./controllers
#= require_tree ../templates