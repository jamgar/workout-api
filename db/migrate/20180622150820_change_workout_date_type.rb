class ChangeWorkoutDateType < ActiveRecord::Migration[5.2]
  def change
    remove_column :workouts, :workout_date
    add_column :workouts, :workout_date, :integer
  end
end
