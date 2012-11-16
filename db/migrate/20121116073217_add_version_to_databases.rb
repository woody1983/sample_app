class AddVersionToDatabases < ActiveRecord::Migration
  def change
    add_column :databases, :db_version, :string
  end
end
