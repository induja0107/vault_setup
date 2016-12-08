require 'spec_helper'
describe 'vault_config' do
  context 'with default values for all parameters' do
    it { should contain_class('vault_config') }
  end
end
