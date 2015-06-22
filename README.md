[![Build Status](https://img.shields.io/travis/gurix/helena_administration/master.svg?style=flat)](https://travis-ci.org/gurix/helena_administration)
[![Code Climate](https://img.shields.io/codeclimate/github/gurix/helena_administration.svg?style=flat)](https://codeclimate.com/github/gurix/helena_administration)
[![Dependency Status](https://img.shields.io/gem/v/helena_administration.svg?style=flat)](https://rubygems.org/gems/helena_administration)
[![Dependency Status](https://gemnasium.com/gurix/helena_administration.svg)](https://gemnasium.com/gurix/helena_administration)
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/gurix/helena?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Helena Administration

Helena Administration is a simple rails application that provides a user interface to manage apps running with the [Helena framework](https://github.com/gurix/helena).

# Features
* Manage surveys, question groups and questions
* Survey versioning
* Export answers as CSV or JSON

## Requirements
see [requirements for running an application using Helena](https://github.com/gurix/helena#requirements)

## Installation
Add this line to your application's Gemfile:

```
gem 'helena_administration', git: 'git://github.com/gurix/helena_administration.git'
```

And then execute:

```
$ bundle install
```

## Usage
Add the following line to your routes to include administration in your App

```ruby
mount HelenaAdministration::Engine, at: '/admin'
```

To protect you can use i.e devise. See https://github.com/plataformatec/devise/wiki/How-To:-Define-resource-actions-that-require-authentication-using-routes.rb

```ruby
authenticate :user do
  mount HelenaAdministration::Engine, at: '/admin'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contact

[info@markusgraf.ch](mailto: info@markusgraf.ch)

Or at [#HelenaFramework](irc://chat.freenode.net/HelenaFramework) on freenode.net

## Support

If you like helena and want to support the development, I would appreciate a donation:

[![Donate](https://www.paypalobjects.com/en_US/CH/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=info%40markusgraf%2ech&lc=CH&item_name=Helena&currency_code=CHF&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)

## License

Helena Administration is a simple rails application that provides a user interface to manage apps running with the Helena framework.
Copyright (C) 2014  Markus Graf <info@markusgraf.ch>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
