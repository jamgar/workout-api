class Workout < ApplicationRecord
  has_many :exercises, dependent: :destroy

  validates_presence_of :title, :created_by
end
