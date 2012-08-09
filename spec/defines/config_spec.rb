require 'spec_helper'

describe 'couchdb::config' do

  context 'for feat' do
    let(:title) { 'feat' }

    it do
      should contain_file('/etc/feat/local.ini')
    end
  end
end
