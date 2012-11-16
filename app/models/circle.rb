# == Schema Information
#
# Table name: circles
#
#  id            :integer          not null, primary key
#  circle_desc   :string(255)
#  database_id   :integer
#  table_id      :integer
#  circle_source :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# == Schema Information
#
# Table name: circles
#
#  id            :integer          not null, primary key
#  circle_desc   :string(255)
#  database_id   :integer
#  table_id      :integer
#  circle_source :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Circle < ActiveRecord::Base
  #belongs_to :database
  before_save { |circle| circle.circle_desc = circle.circle_desc.strip }
  attr_accessible :circle_desc, :database_id, :table_id, :circle_source
end
