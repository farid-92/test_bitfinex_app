describe 'GET index services', type: :request do
  let!(:service1) {create :service, url: 'test.ru', name: 'test', service_type: 'ticker'}
  let!(:service2) {create :service, url: 'test-2.ru', name: 'test2', service_type: 'candle'}

  before {get(api_v1_services_path, headers, nil)}

  context 'with valid params' do
    it {expect(response.status).to eq(200)}


    it 'should response urls' do
      expect(response_json.map {|s| s["url"]}).to eq(['test-2.ru', 'test.ru'])
    end

    it 'should response service_types' do
      expect(response_json.map {|s| s["service_type"]}).to eq(['candle', 'ticker'])
    end
  end
end
