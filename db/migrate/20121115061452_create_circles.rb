class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :circle_desc
      t.integer :database_id
      t.integer :table_id
      t.integer :circle_source

      t.timestamps
    end
  end
end
