module V1
  class WorkoutsController < ApplicationController
    before_action :set_workout, only: [:show, :update, :destroy]

    def index
      @workouts = current_user.workouts.paginate(page: params[:page], per_page: 20)
      json_response(@workouts)
    end

    def show
      json_response(@workout)
    end

    def create
      @workout = current_user.workouts.create!(workout_params) # Note: use create! so model can throw exception
      json_response(@workout, :created)
    end

    def update
      @workout.update(workout_params)
      head :no_content
    end

    def destroy
      @workout.destroy
      head :no_content
    end

    private

      def workout_params
        params.permit(:title, :created_by, :workout_date, :note, exercises_attributes: [ :id, :name ])
      end

      def set_workout
        @workout = Workout.find(params[:id])
      end
  end
end
