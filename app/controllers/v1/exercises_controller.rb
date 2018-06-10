module V1
  class ExercisesController < ApplicationController
    before_action :set_workout
    before_action :set_workout_exercise, only: [:show, :update, :destroy]

    def index
      json_response(@workout.exercises)
    end

    def show
      json_response(@exercise)
    end

    def create
      @workout.exercises.create!(exercise_params)
      json_response(@workout, :created)
    end

    def update
      @exercise.update(exercise_params)
      head :no_content
    end

    def destroy
      @exercise.destroy
      head :no_content
    end

    private

      def exercise_params
        params.permit(:name)
      end

      def set_workout
        @workout = Workout.find(params[:workout_id])
      end

      def set_workout_exercise
        @exercise = @workout.exercises.find_by!(id: params[:id]) if @workout
      end
  end
end
