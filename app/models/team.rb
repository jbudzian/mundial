class Team < ActiveRecord::Base
  attr_accessible :name, :group, :placeholder
  
  has_many :matches
end
