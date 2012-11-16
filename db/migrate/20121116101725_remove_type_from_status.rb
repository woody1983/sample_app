class RemoveTypeFromStatus < ActiveRecord::Migration
  def up
    remove_column :statuses, :type
  end

  def down
    add_column :statuses, :type, :string
  end
end
