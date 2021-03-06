require 'spec_helper'

describe Configuration do

  before do
    Configuration.clear
    stub_request(:any, "#{Settings.cc_api_uri}/info").
      to_return(body: JSON.generate({
        name: 'vcap',
        build: '2222',
        support: 'http://support.cloudfoundry.com',
        version: 2,
        description: 'Cloud Foundry sponsored by Pivotal',
        authorization_endpoint: 'http://login.bosh-lite.com',
        token_endpoint: 'https://uaa.bosh-lite.com',
        allow_debug: true
      }))
  end

  describe '#auth_server_url' do
    it 'uses the cc_api_uri to get the url for the auth server' do
      expect(Configuration.auth_server_url).to eql('http://login.bosh-lite.com')
      expect(a_request(:get, "#{Settings.cc_api_uri}/info")).to have_been_made
    end
  end

  describe '#auth_server_logout_url' do
    it 'uses the cc_api_uri to return the auth server logout url' do
      expect(Configuration.auth_server_logout_url).to eql('http://login.bosh-lite.com/logout.do')
    end
  end

  describe '#token_server_url' do
    it 'uses the cc_api_uri to get the url for the token server' do
      expect(Configuration.token_server_url).to eql('https://uaa.bosh-lite.com')
      expect(a_request(:get, "#{Settings.cc_api_uri}/info")).to have_been_made
    end
  end

  describe '#documentation_url' do
    it 'uses the documentationUrl of the first service in the catalog' do
      expect(Configuration.documentation_url).to eql('http://docs.run.pivotal.io')
    end

    context 'when the catalog is empty' do
      before do
        allow(Settings).to receive(:services).and_return([])
      end

      it 'is nil' do
        expect(Configuration.documentation_url).to be_nil
      end
    end
  end

  describe '#support_url' do
    it 'uses the supportUrl of the first service in the catalog' do
      expect(Configuration.support_url).to eql('http://support.run.pivotal.io/home')
    end

    context 'when the catalog is empty' do
      before do
        allow(Settings).to receive(:services).and_return([])
      end

      it 'is nil' do
        expect(Configuration.support_url).to be_nil
      end
    end
  end
end
