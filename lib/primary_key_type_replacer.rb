require 'primary_key_type_replacer/version'
require 'active_record/migration'

module PrimaryKeyTypeReplacer
  # Manipuliert die Klasse `ActiveRecord::Migration`
  ActiveRecord::Migration.class_eval do
    # Ermöglicht das Setzen des Typs des Primärschlüssels.
    #
    # @param {String} primary_key_type
    def self.replace_primary_key_type_with primary_key_type
      @@_primary_key_type = primary_key_type
    end

    # Gibt den Namen des Adapters an.
    #
    def adapter_name
      ActiveRecord::Base.connection.adapter_name
    end

    # Legt eine Kopie der originalen Methode an
    alias _exec_migration_without_primary_key_type_hook exec_migration

    # Führt die Migration aus.
    #
    # @override
    def exec_migration *args
      # Der originale Typ des Primärschlüssels
      origin_primary_key_type = _native_database_types[:primary_key]
      # Der Typ der Primärschlüssels
      primary_key_type        = @@_primary_key_type || _native_database_types[:primary_key]

      # Stellt sicher, dass der Adapter beim Aufruf von `native_database_types` einen konstanten Hash zurück gibt
      _freeze_native_database_types!

      # Setzt den neuen Typ des Primärschlüssels
      _native_database_types[:primary_key] = primary_key_type

      # Führt die eigentliche Methode aus
      _exec_migration_without_primary_key_type_hook(*args)
    ensure
      # Setzt den Typ des Primärschlüssels zurück
      _native_database_types[:primary_key] = origin_primary_key_type
    end

    private

    # Gibt die Definition der DB-Typen zurück.
    #
    def _native_database_types
      ActiveRecord::Base.connection.native_database_types
    end

    # Stellt sich, dass der Adapter beim Aufruf von `native_database_types` einen konstanten Hash zurück gibt.
    #
    def _freeze_native_database_types!
      ActiveRecord::Base.connection.singleton_class.class_eval do
        # Kopie der DB-Typen
        native_database_types = ActiveRecord::Base.connection.native_database_types

        define_method('native_database_types') { native_database_types }
      end
    end
  end
end
