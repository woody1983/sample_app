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

# == Schema Information
#
# Table name: databases
#
#  id         :integer          not null, primary key
#  db_name    :string(255)
#  db_project :string(255)
#  db_user    :string(255)
#  db_pm      :string(255)
#  db_desc    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Database < ActiveRecord::Base
  before_save { |database| database.db_name = database.db_name.upcase }
  attr_accessible :db_desc, :db_name, :db_pm, :db_project, :db_user, :db_version
  has_many :tables
  has_many :circles
  has_many :statuses
end
