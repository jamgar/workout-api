class ChangeWorkoutDateTo8Bit < ActiveRecord::Migration[5.2]
  def change
    change_column :workouts, :workout_date, :integer, :limit => 8
  end
end
