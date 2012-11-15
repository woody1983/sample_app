# == Schema Information
#
# Table name: columns
#
#  id             :integer          not null, primary key
#  column_name    :string(255)
#  column_type    :string(255)
#  column_size    :string(255)
#  column_desc    :string(255)
#  column_null    :string(255)
#  column_key     :string(255)
#  column_default :string(255)
#  table_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Column < ActiveRecord::Base
  before_save { |column| column.column_name = column.column_name.upcase }
  belongs_to :table
  attr_accessible :column_name, :column_type, :column_desc, :column_size, :column_null, :column_key, :column_default
end
