require 'rails_helper'

RSpec.describe 'Exercise API' do
  let(:user) { create(:user) }
  let!(:workout) { create(:workout, created_by: user.id) }
  let!(:exercises) { create_list(:exercise, 20, workout_id: workout.id) }
  let(:workout_id) { workout.id }
  let(:id) { exercises.first.id }
  let(:headers) { valid_headers }

  describe 'GET /workouts/:workout_id/exercises' do
    before { get "/workouts/#{workout_id}/exercises", params: {}, headers: headers }

    context 'when workout exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all workout exercises' do
        expect(json.size).to eq(20)
      end
    end

    context 'when workout does not exist' do
      let(:workout_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Workout/)
      end
    end
  end

  describe 'GET /workouts/:workout_id/exercises/:id' do
    before { get "/workouts/#{workout_id}/exercises/#{id}", params: {}, headers: headers }

    context 'when workout exercise exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the exercise' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when workout exercise does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Exercise/)
      end
    end
  end

  describe 'POST /workouts/:workout_id/exercises' do
    let(:valid_attributes) { { name: '5x100s' }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/workouts/#{workout_id}/exercises", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/workouts/#{workout_id}/exercises", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /workouts/:workout_id/exercises/:id' do
    let(:valid_attributes) { { name: '5x400s' }.to_json }

    before do
      put "/workouts/#{workout_id}/exercises/#{id}", params: valid_attributes, headers: headers
    end

    context 'when exercise exist' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the exercise' do
        updated_exercise = Exercise.find(id)
        expect(updated_exercise.name).to match(/5x400s/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Exercise/)
      end
    end
  end

  describe 'DELETE /workouts/:workout_id/exercises/:id' do
    before { delete "/workouts/#{workout_id}/exercises/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
