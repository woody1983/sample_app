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

require 'spec_helper'

describe Circle do
  pending "add some examples to (or delete) #{__FILE__}"
end
