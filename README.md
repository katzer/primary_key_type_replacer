PrimaryKeyTypeReplacer
========================

ActiveRecord plugin to replace the primary key type of your database tables.

Should work with all supported activerecord adapters. Tested with
- mysql2
- sqlite3
- oracle_enhanced

by Sebastián Katzer ([github.com/katzer](https://github.com/katzer))

## Installation

Add this line to your application's Gemfile:

    gem 'primary_key_type_replacer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install primary_key_type_replacer

## Usage
This gem adds the **singleton method** `replace_primary_key_type_with(_type_)` to your migration files.<br>
See example below how to use it to disable the *autoincrement* feature.
```ruby
class CreateTableWithoutAutoIncrement < ActiveRecord::Migration
  # Setzt den Typ des Primärschlüssels
  replace_primary_key_type_with case adapter_name
                                when 'Mysql2'
                                  'int(11) NOT NULL PRIMARY KEY'
                                when 'SQLite'
                                  'INTEGER PRIMARY KEY NOT NULL'
                                end

  def change
    # Erstellt die Tabelle mit dem neuen Primärschlüsseltypen
    create_table :table_without_auto_increment_id do |t|
      # ...
    end
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
