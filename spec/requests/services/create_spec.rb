describe 'POST create service', type: :request do

  before { post(api_v1_services_path, headers, params) }

  context 'without logged' do
    let(:headers) { nil }
    let(:params) { nil }

    it { expect(response.status).to eq(401) }
    it { expect(response_json[:errors]).to eq(['Not Authenticated']) }
  end

  context 'without params' do
    let(:headers) { admin_token }
    let(:params) { nil }

    it { expect(response.status).to eq(422) }

    it 'should response errors' do
      expect(response_json[:errors]).to match_array([
                                                        {source: 'url', message: 'Url can\'t be blank'}
                                                    ])
    end
  end

  context 'with valid params' do
    let(:headers) { admin_token }
    let(:params) do
      {
          url: 'test.ru',
          service_type: 'ticker'
      }
    end

    it { expect(response.status).to eq(201) }

    it 'should response new project' do
      id = Service.last.id
      expect(response_json[:id]).to eq(id)
      expect(response_json[:url]).to eq('test.ru')
      expect(response_json[:service_type]).to eq('ticker')
    end
  end
end
