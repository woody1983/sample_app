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

require 'spec_helper'

describe Status do
  pending "add some examples to (or delete) #{__FILE__}"
end
