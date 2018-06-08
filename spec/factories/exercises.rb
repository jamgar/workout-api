FactoryBot.define do
  factory :exercise do
    name { Faker::StarWars.character }
    workout_id nil
  end
end
