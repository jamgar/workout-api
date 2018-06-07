require 'rails_helper'

RSpec.describe Workout, type: :model do
  it { should have_many(:exercises).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
