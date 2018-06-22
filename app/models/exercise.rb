class Exercise < ApplicationRecord
  belongs_to :workout, inverse_of: :exercises

  validates_presence_of :name
end
