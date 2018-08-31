module Support
  module Database
    module_function

    def clear_db
      Item.delete_all
    end

    def seed_db
    end

    def setup_db
      ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

      ActiveRecord::Schema.define(version: 1) do
        create_table :items do |t|
          t.column :position, :integer
        end
      end
    end
  end
end
