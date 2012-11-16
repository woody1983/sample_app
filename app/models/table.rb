# == Schema Information
#
# Table name: tables
#
#  id          :integer          not null, primary key
#  table_name  :string(255)
#  table_desc  :string(255)
#  database_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# == Schema Information
#
# Table name: tables
#
#  id          :integer          not null, primary key
#  table_name  :string(255)
#  table_desc  :string(255)
#  database_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Table < ActiveRecord::Base
  before_save { |table| table.table_name = table.table_name.upcase }
  belongs_to :database
  attr_accessible :table_desc, :table_name
  has_many :columns
  has_many :circles
end
