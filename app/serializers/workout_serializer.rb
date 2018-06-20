class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_by, :workout_date, :note, :created_at, :updated_at

  has_many :exercises
end
