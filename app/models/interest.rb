class Interest < Sequel::Model
  set_allowed_columns :email, :item

  plugin :validation_helpers
  def validate
    validates_presence :item
    validates_min_length 5, :email
  end

  def before_create
    self.created_at ||= Time.now
    self.updated_at ||= Time.now
    super
  end

=begin
  attr_accessible :email, :item
  validates :item, presence: true
  validates :email, length: { :minimum => 5 }
  
  def self.rank
    Hash[Interest.all.group_by(&:item).map{|k,v| [k, v.length]}]
  end
=end
end
