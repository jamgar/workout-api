class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :update, :destroy]

  def index
    @workouts = Workout.all
    json_response(@workouts)
  end

  def create
    @workout = Workout.create!(workout_params) # Note: use create! so model can throw exception
    json_response(@workout, :created)
  end

  def show
    json_response(@workout)
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
      params.permit(:title, :created_by)
    end

    def set_workout
      @workout = Workout.find(params[:id])
    end
end
