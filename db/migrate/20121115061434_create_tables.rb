class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :table_name
      t.string :table_desc
      t.references :database

      t.timestamps
    end
    add_index :tables, :database_id
  end
end
