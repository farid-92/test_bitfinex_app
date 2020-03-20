describe 'GET get ticker service', type: :request do
  let!(:ticker_service) {create :service, url: 'https://api-pub.bitfinex.com/v2/ticker/', name: 'bitfinex', service_type: 'ticker'}
  let(:headers) { admin_token }
  before {get(api_v1_get_ticker_path("fUSD"), headers, nil)}

  context 'with valid params' do
    it {expect(response.status).to eq(200)}


    it 'should response hash with key bitfenix' do
      expect(response_json).to have_key(:bitfinex)
    end

  end
end
