class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :type
      t.string :ip
      t.string :port
      t.boolean :slave_io
      t.boolean :slave_sql
      t.references :database

      t.timestamps
    end
    add_index :statuses, :database_id
  end
end
