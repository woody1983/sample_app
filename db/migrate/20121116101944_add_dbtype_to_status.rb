class AddDbtypeToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :dbtype, :string
  end
end
