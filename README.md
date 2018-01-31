![inc exp tracker!](https://raw.githubusercontent.com/krabique/inc_exp_tracker/master/logo.jpg "track it!")

[![Build Status](https://travis-ci.org/krabique/inc_exp_tracker.svg?branch=master)](https://travis-ci.org/krabique/inc_exp_tracker) 
[![Maintainability](https://api.codeclimate.com/v1/badges/3544fccd364f99feb039/maintainability)](https://codeclimate.com/github/krabique/inc_exp_tracker/maintainability) 
[![Test Coverage](https://api.codeclimate.com/v1/badges/3544fccd364f99feb039/test_coverage)](https://codeclimate.com/github/krabique/inc_exp_tracker/test_coverage)

# Personal income/expense tracking app

It's time to take your life seriously and start tracking your money! 'Couse, y'know, every coin counts (even if it doesn't). Let's see how long will it take you to make [Jeff Bezos](https://www.cbsnews.com/pictures/richest-people-in-world-forbes/) nervous! Start now! Since what you sow today you reap tomorrow! (wow, that's deep)

## Live preview

Live preview is available at https://pacific-springs-78455.herokuapp.com/ (you won't need to approve your email, and there will be no message sent)

## Features

- incomes/expenses categories (user specific)
- entries filtering by date range and category
- safe and secure
- tracks your damn money!
- etc.

### Entries

Looks like this, behaves intuitively, simply awesome. 

![entries filter!](https://raw.githubusercontent.com/krabique/inc_exp_tracker/master/1.png "entries filter")

It's also adaptive!

![adaprive!](https://raw.githubusercontent.com/krabique/inc_exp_tracker/master/2.png "adaptive")

## Getting Started

What you basically need to do to get the app running is:

1. Use `rvm` to define proper ruby and Rails versions, something like that
```
rvm install ruby-2.4.3
rvm gemset create inc_exp_tracker
rvm 2.4.3@inc_exp_tracker
gem install rails -v 5.1.4
```
2. Clone the repo and install the gems
```
git clone git@github.com:krabique/inc_exp_tracker.git
cd inc_exp_tracker
gem install bundle
bundle install
```
3. Start postgresql and setup the database (and don't look at me if you encounter any problems with postgresql...)
```
sudo service postgresql start
rails db:setup
```
4. Now you're good to go! Run that server!
```
rails s
```

You can run the test suite with
```
bundle exec rake spec
```

## License

MIT

## Authors

* **Oleg Larkin** - *Initial work* - [krabique](https://github.com/krabique) (krabique48@gmail.com)
