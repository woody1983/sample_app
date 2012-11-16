class AddConfigurationToDatabases < ActiveRecord::Migration
  def change
    add_column :databases, :db_configuration, :text
  end
end
