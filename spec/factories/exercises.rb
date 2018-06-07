FactoryBot.define do
  factory :exercie do
    name { Faker::StarWars.character }
    workout_id nil
  end
end
