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

require 'spec_helper'

describe Table do
  pending "add some examples to (or delete) #{__FILE__}"
end
