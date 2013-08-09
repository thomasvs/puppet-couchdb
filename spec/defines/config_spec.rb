require 'spec_helper'

describe 'couchdb::config' do

  context 'config for feat' do
    let(:title) { 'feat' }

    it do
      expect {
        should contain_file('/etc/feat/local.ini')
      }.to raise_error(Puppet::Error, /namevar must start with couchdb/)
    end
  end

  context 'config for couchdb-feat' do
    let(:title) { 'couchdb-feat' }

    it do
      should include_class('couchdb::install')

      should contain_file('/etc/couchdb-feat/local.ini')
    end
  end

  context 'config for couchdb-feat with password' do
    let(:title) { 'couchdb-feat' }
    let(:params) { {
        :admins => { 'admin1' => 'password1', 'admin2' => 'password2' },
        :require_valid_user => true
    } }

    it do
      should contain_file('/etc/couchdb-feat/local.ini') \
        .with_content(/admin1 = password1/) \
        .with_content(/^require_valid_user = true/)
    end
  end

  context 'config for couchdb-feat with require_valid_user false' do
    let(:title) { 'couchdb-feat' }
    let(:params) { {
        :require_valid_user => false
    } }

    it do
      should contain_file('/etc/couchdb-feat/local.ini') \
        .with_content(/^require_valid_user = false/)
    end
  end

  context 'config for couchdb-feat with require_valid_user undef' do
    let(:title) { 'couchdb-feat' }

    it do
      should contain_file('/etc/couchdb-feat/local.ini') \
        .with_content(/^; require_valid_user = false/)
    end
  end

  context 'config for couchdb-feat with bind_address 0.0.0.0' do
    let(:title) { 'couchdb-feat' }
    let(:params) { {
        :bind_address => '0.0.0.0'
    } }

    it do
      should contain_file('/etc/couchdb-feat/local.ini') \
        .with_content(/^bind_address = 0.0.0.0/)
    end
  end


end
