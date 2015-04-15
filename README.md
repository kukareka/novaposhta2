# Novaposhta API 2.0

Ruby gem for Nova Poshta API 2.0.
Nova Poshta ("Нова Пошта", "Новая Почта") is a popular local shipping provider in Ukraine (https://novaposhta.ua/).

## Installation

Add the gem to your `Gemfile`:

```ruby
gem 'novaposhta2', github: 'kukareka/novaposhta2'
```

And run [Bundler](http://bundler.io/):

```shell
bundle install
```

## Configuration

Store API key and sender credentials in `app/config/initializers/novaposhta2.rb`:

```ruby
Novaposhta2.configure do |config|
    config.api_key = 'Your api key'
    config.sender = {
        ref: 'Sender reference',
        city: 'City reference',
        address: 'Sender warehouse reference',
        contact: 'Sender contact reference',
        phone: 'Sender phone',
    }
end
```

You can get your own credentials on https://novaposhta.ua/.

## Usage

Manage cities:

```ruby
Novaposhta2::City.all # list all cities

Novaposhta2::City.find('Киев') # find city by name
Novaposhta2::City['Киев'] # the same
Novaposhta2['Киев'] # the same

Novaposhta2::City.match('К') # return list of cities starting with 'К'
```

Manage warehouses:

```ruby
Novaposhta2['Киев'].warehouses # list all warehouses in Kiev city
Novaposhta2['Киев'][2] # warehouse number 2 in Kiev city
```

Manage packages:

```ruby
# create package for Ivan Ivanov, shipping to warehouse number 2 in Kiev.
package = Novaposhta2['Киев'].person('Иван', 'Иванов', '380631234567').
    package(Novaposhta2['Киев'][2], volume: 0.04, cost: 100, description: 'Бомба')

package.rate # check shipping rate in UAH
package.save # commit the package

package.tracking # get tracking number
package.print # URL to print marking

package.track # track the package
Novaposhta2::Package.track('123456789') # track a package by tracking number
Novaposhta2.track('123456789') # the same
```