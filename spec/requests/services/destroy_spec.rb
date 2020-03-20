describe 'DELETE destroy service', type: :request do

  let!(:service) {create :service, url: 'test.ru', name: 'test', service_type: 'ticker'}

  context 'without logged' do
    let(:headers) { nil }
    let(:params) { nil }
    before { delete(api_v1_service_path(service.id), headers, params) }

    it { expect(response.status).to eq(401) }
    it { expect(response_json[:errors]).to eq(['Not Authenticated']) }
  end

  context 'when service not exist' do
    let(:headers) { admin_token }
    id = 0
    before { put(api_v1_service_path(id), headers, nil) }

    it { expect(response.status).to eq(404) }

    it {
      expect(response_json[:message]).to eq("Couldn't find Service with 'id'=#{id}")
    }
  end

  context 'with valid params' do
    let(:headers) { admin_token }
    before { delete(api_v1_service_path(service.id),headers , nil) }

    it { expect(response.status).to eq(200) }
    it { expect(Service.count).to eq(0) }
    it {
      expect(response_json[:message]).to eq("Service deleted")
    }
  end
end
