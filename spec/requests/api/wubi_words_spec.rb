# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Wubi Words api' do
  path '/api/wubi_words' do
    post '创建五笔字' do
      produces 'application/json'
      consumes 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          word: { type: :string, description: '五笔字' },
          code: { type: :string, description: '五笔码' }
        }
      }, required: false

      response '200', 'create success' do
        let(:body) do
          { word: '五', code: 'GG', context: '五福临门' }
        end
        run_test! do
          expect(json['word']).to eq('五')
          expect(json['code']).to eq('GG')
          expect(json['context']).to eq('五福临门')
          expect(json['active']).to eq(true)
        end
      end

      response '422', 'create fail for dumplicate' do
        let(:body) do
          { word: '五', code: 'GG', context: '五福临门' }
        end

        before do
          create(:wubi_word, word: '五', code: 'GG', context: '五福临门')
        end
        run_test! do
          expect(json['msg']).to include('taken')
        end
      end
    end
  end
end
