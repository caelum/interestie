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

  def self.rank
    Hash[db[:interests].group_and_count(:item).map{|i| [ i[:item], i[:count] ]}]
  end
end
