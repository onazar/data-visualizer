## README

Used Ruby 2.2.1, Rails 4.2.0, AngularJS 1.4.8, Bootstrap 4

Rails backend reads the 'data/session_history.csv' file ignoring columns that not used in app, and converts it to JSON;
Angular frontend render this data to charts using [Google charts library wrapped into Angular directives](https://github.com/angular-google-chart/angular-google-chart)

[Try out demo on Heroku](https://afternoon-harbor-7222.herokuapp.com/)

To run tests just run (you need installed firefox in your system)
```
rake spec
```
There are 14 tests at the moment
![tests](https://pp.vk.me/c630425/v630425426/db07/jRoLPwt6vzM.jpg)
