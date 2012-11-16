# == Schema Information
#
# Table name: databases
#
#  id               :integer          not null, primary key
#  db_name          :string(255)
#  db_project       :string(255)
#  db_user          :integer
#  db_pm            :integer
#  db_desc          :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  db_version       :string(255)
#  db_configuration :text
#

require 'spec_helper'

describe Database do
  pending "add some examples to (or delete) #{__FILE__}"
end
