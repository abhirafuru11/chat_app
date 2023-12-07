require 'rails_helper'

RSpec.describe LoadBalancerService do
  let(:server_list) { ['http://server1.com', 'http://server2.com'] }

  before do
    allow(described_class).to receive(:get_servers).and_return(server_list)
  end

  context 'when we call loadbalancer service in iteration' do
    it 'return available servers in a round robin manner' do
      100.times do |i|
        server_number = (i%2 != 0 ? 2 : 1)
        val = LoadBalancerService.call
        expect(val).to eq("http://server#{server_number}.com")
      end
    end
  end
end
