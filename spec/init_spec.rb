require 'spec_helper'

RSpec.describe GitRuby::Init, :within_tmp_dir do
  describe '#perform' do
    it 'creates an empty git repo' do
      described_class.perform()

      expect(system('git status')).to be true
    end
  end
end