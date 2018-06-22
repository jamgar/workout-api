class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :title, :workout_date, :note, :created_at, :updated_at, :user_id

  has_many :exercises
end
