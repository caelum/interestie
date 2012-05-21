class Interest < ActiveRecord::Base
  attr_accessible :email, :item
  validates :item, presence: true
  validates :email, length: { :minimum => 5 }
end
