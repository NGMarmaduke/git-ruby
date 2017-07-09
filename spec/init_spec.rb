require 'spec_helper'

RSpec.describe GitRuby::Init, :within_tmp_dir do
  describe '#intialize' do
    it 'defaults to the present working directory' do
      described_class.perform()

      expect('hello').to be_a_file.with_contents('')
    end
  end
end