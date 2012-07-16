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
    count_by_item = db[:interests].group_and_count :item
    grouped_count = count_by_item.map { |i| [i[:item], i[:count]] }
    Hash[grouped_count]
  end
end
