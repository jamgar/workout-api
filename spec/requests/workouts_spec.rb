require 'rails_helper'

RSpec.describe 'Workout API', type: :request do
  let(:user) { create(:user) }
  let!(:workouts) { create_list(:workout, 10, created_by: user.id) }
  let(:workout_id) { workouts.first.id }
  let(:headers) { valid_headers }

  describe 'GET /workouts' do
    before { get '/workouts', params: {}, headers: headers }

    it 'returns workouts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /workouts/:id' do
    before { get "/workouts/#{workout_id}", params: {}, headers: headers }

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
    let(:valid_attributes) do
      { title: 'Run Intervals', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/workouts', params: valid_attributes, headers: headers }

      it 'creates a workout' do
        expect(json['title']).to eq('Run Intervals')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid title' do
      let(:invalid_attributes) { { title: nil, created_by: user.id.to_s }.to_json }
      before { post '/workouts', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /workouts/:id' do
    let(:valid_attributes) { { title: 'Swim' }.to_json }

    context 'when the record exist' do
      before { put "/workouts/#{workout_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /workouts/:id' do
    before { delete "/workouts/#{workout_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
