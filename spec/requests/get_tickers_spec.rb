describe 'GET get tickers service', type: :request do
  let!(:ticker_service) {create :service, url: 'https://api-pub.bitfinex.com/v2/tickers/', name: 'bitfinex2', service_type: 'tickers'}
  let(:headers) { admin_token }
  let(:params) {  { symbols: 'tBTCUSD,tLTCUSD,fUSD' } }
  before {get(api_v1_get_tickers_path, headers, params)}

  context 'with valid params' do
    it {expect(response.status).to eq(200)}


    it 'should response has hash with key bitfenix2' do
      expect(response_json).to have_key(:bitfinex2)
    end

    it 'should response has hash with key bitfenix2 with two-dimensional array' do
      expect(response_json[:bitfinex2][0][0]).to eq('tBTCUSD')
    end

  end
end
