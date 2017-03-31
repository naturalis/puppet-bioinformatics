require 'spec_helper'
describe 'bioinformatics' do
  context 'with default values for all parameters' do
    it { should contain_class('bioinformatics') }
  end
end
