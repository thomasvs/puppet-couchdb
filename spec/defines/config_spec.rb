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
      should contain_file('/etc/couchdb-feat/local.ini')
    end
  end


end
