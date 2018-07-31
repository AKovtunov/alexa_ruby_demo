class Project < ActiveRecord::Base
  has_many :accounts
  belongs_to :owner, class_name: "Account", foreign_key: "owner_id"
end
