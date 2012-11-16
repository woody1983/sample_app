# == Schema Information
#
# Table name: statuses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  ip          :string(255)
#  port        :string(255)
#  slave_io    :boolean
#  slave_sql   :boolean
#  database_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  dbtype      :string(255)
#

class Status < ActiveRecord::Base
  belongs_to :database
  attr_accessible :ip, :name, :port, :slave_io, :slave_sql, :type
end
