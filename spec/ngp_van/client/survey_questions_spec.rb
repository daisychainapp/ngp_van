# frozen_string_literal: true

require 'spec_helper'

module NgpVan
  class Client
    RSpec.describe SurveyQuestions do
      let(:client) { NgpVan::Client.new }

      describe '#survey_questions' do
        let(:params) do
          {
            statuses: 'Active,Archived',
            cycle: '2010',
            type: 'Candidate'
          }
        end

        let(:response) { fixture('survey_questions.json') }
        let(:url) { build_url(client: client, path: 'surveyQuestions') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.survey_questions(params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns an array of items' do
          survey_questions = client.survey_questions(params: params)
          expect(survey_questions['items']).to be_a(Array)
        end

        it 'returns the requested survey_questions' do
          survey_questions = client.survey_questions(params: params)
          expect(survey_questions['items'].first['surveyQuestionId'])
            .to eq(54_945)
        end
      end

      describe '#survey_question' do
        let(:params) { {} }
        let(:response) { fixture('survey_question.json') }
        let(:url) { build_url(client: client, path: 'surveyQuestions/54949') }

        before do
          stub_request(:get, url)
            .with(query: params)
            .to_return(
              body: response
            )
        end

        it 'requests the correct resource' do
          client.survey_question(id: 54_949, params: params)
          expect(
            a_request(:get, url)
              .with(query: params)
          ).to have_been_made
        end

        it 'returns a survey_question object' do
          survey_question = client.survey_question(id: 54_949, params: params)
          expect(survey_question).to be_a(Hash)
        end

        it 'returns the requested survey_question' do
          survey_question = client.survey_question(id: 54_949, params: params)
          expect(survey_question['surveyQuestionId']).to eq(54_949)
        end
      end
    end
  end
end
