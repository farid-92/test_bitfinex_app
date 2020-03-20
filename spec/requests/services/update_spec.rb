describe 'PUT update service', type: :request do
  let!(:service) do
    create :service, url: 'test.ru', service_type: 'ticker'
  end

  context 'without logged' do
    let(:headers) { nil }
    let(:params) { nil }
    before { put(api_v1_service_path(service.id), headers, params) }

    it { expect(response.status).to eq(401) }
    it { expect(response_json[:errors]).to eq(['Not Authenticated']) }
  end

  context 'when service not exist' do
    id = 0
    before { put(api_v1_service_path(id), admin_token, nil) }

    it { expect(response.status).to eq(404) }

    it {
      expect(response_json[:message]).to eq("Couldn't find Service with 'id'=#{id}")
    }
  end

  context 'with invalid params' do
    let(:params) do
      {
          url: '',
          service_type: 'candle'
      }
    end

    before { put(api_v1_service_path(service.id), admin_token, params) }

    it { expect(response.status).to eq(422) }

    it 'should response errors' do
      expect(response_json[:errors]).to match_array([
                                                        {source: 'url', message: 'Url can\'t be blank'}
                                                    ])
    end
  end

  context 'without params' do
    before { put(api_v1_service_path(service.id), admin_token, nil) }

    it { expect(response.status).to eq(202) }

    it 'should not update service' do
      service.reload
      expect(service.url).to eq('test.ru')
      expect(service.service_type).to eq('ticker')
    end
  end

  context 'with valid params' do
    let(:params) do
      {
          url: 'new-test.ru',
          service_type: 'candle',
      }
    end

    before { put(api_v1_service_path(service.id), admin_token, params) }

    it { expect(response.status).to eq(202) }

    it 'should update service' do
      service.reload
      expect(service.url).to eq('new-test.ru')
      expect(service.service_type).to eq('candle')
    end
  end
end
