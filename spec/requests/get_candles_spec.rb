describe 'GET get ticker service', type: :request do
  let!(:ticker_service) {create :service, url: 'https://api-pub.bitfinex.com/v2/candles/', name: 'bitfinex_candles', service_type: 'candle'}
  let(:headers) { admin_token }
  let(:params) { {TimeFrame: "1m", Symbol: "tBTCUSD", Section: "last"} }
  before {get(api_v1_get_candles_path("fUSD"), headers, params)}

  context 'with valid params' do
    it {expect(response.status).to eq(200)}


    it 'should response hash with key bitfenix' do
      expect(response_json).to have_key(:bitfinex_candles)
    end

  end
end
