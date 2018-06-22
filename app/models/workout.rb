class Workout < ApplicationRecord
  belongs_to :user
  has_many :exercises, dependent: :destroy, inverse_of: :workout
  accepts_nested_attributes_for :exercises,
                                :allow_destroy => true,
                                reject_if: proc { |attributes| attributes[:name].blank? }
  validates_presence_of :title , :workout_date
end
