class Interest
=begin
  attr_accessible :email, :item
  validates :item, presence: true
  validates :email, length: { :minimum => 5 }
  
  def self.rank
    Hash[Interest.all.group_by(&:item).map{|k,v| [k, v.length]}]
  end
=end
end
