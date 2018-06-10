class V2::WorkoutsController < ApplicationController
  # This in place for testing and example
  def index
    json_response({ message: 'Hello from V2!'})
  end
end
