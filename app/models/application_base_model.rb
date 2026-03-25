class ApplicationBaseModel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer, default: 0

  before_create :update_incremental_id

  private

  def update_incremental_id
    return self.id = self.class.last.id + 1 unless self.class.last.nil?

    self.id = self.class.count + 1
  end
end
