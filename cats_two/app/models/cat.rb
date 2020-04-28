require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  # .freeze renders a constant immutable.
  CAT_COLORS = %w(black white orange brown).freeze

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)
  validates :birth_date, :color, :name, :sex, presence: true

  has_many :rental_requests,
    class_name: :CatRentalRequest,
    dependent: :destroy

  belongs_to :owner, foreign_key: :owner_id, class_name: :User

  def age
    time_ago_in_words(birth_date)
  end
end
