class Plan < ApplicationBaseModel
  field :title,   type: String
  field :active,  type: Boolean, default: false

  TITLE_REGEX = /\A[0-9]{4}-[a-zA-Z]{3,20}\z/ # 0001-gold

  validates :title, format: { with: TITLE_REGEX }

  def as_json
    {
      id: id,
      title: title,
      active: active
    }
  end
end
