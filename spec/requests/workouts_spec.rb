require 'rails_helper'

RSpec.describe 'Workout API', type: :request do
  let!(:workouts) { create_list(:workout, 10) }
  let(:workout_id) { workouts.first.id }

  describe 'GET /workouts' do
    before { get '/workouts' }

    it 'returns workouts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /workouts/:id' do
    before { get "/workouts/#{workout_id}" }

    context 'when the record exist' do
      it 'returns the workout' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(workout_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:workout_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Workout/)
      end
    end
  end

  describe 'POST /workouts' do
    let(:valid_attributes) { { title: 'Run Intervals', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/workouts', params: valid_attributes }

      it 'creates a workout' do
        expect(json['title']).to eq('Run Intervals')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid title' do
      before { post '/workouts', params: { created_by: '1' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end

    context 'when the request is invalid created by' do
      before { post '/workouts', params: { title: 'weights' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe 'PUT /workouts/:id' do
    let(:valid_attributes) { { title: 'Swim' } }

    context 'when the record exist' do
      before { put "/workouts/#{workout_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /workouts/:id' do
    before { delete "/workouts/#{workout_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
