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
    let(:params) { { :admins => { 'admin1' => 'password1', 'admin2' => 'password2' } } }

    it do
      should contain_file('/etc/couchdb-feat/local.ini') \
        .with_content(/admin1 = password1/)
    end
  end


end
