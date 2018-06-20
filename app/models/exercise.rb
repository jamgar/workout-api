class Exercise < ApplicationRecord
  belongs_to :workout, optional: true

  validates_presence_of :name
end
