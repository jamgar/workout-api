class AddDateAndNoteToWorkouts < ActiveRecord::Migration[5.2]
  def change
    add_column :workouts, :workout_date, :datetime
    add_column :workouts, :note, :text
  end
end
