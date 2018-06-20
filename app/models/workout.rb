class Workout < ApplicationRecord
  has_many :exercises, dependent: :destroy
  accepts_nested_attributes_for :exercises, :allow_destroy => true
  validates_presence_of :title, :created_by, :workout_date
end
