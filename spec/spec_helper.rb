$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'git_ruby'
require 'rspec'

require 'tmpdir'

RSpec.configure do |config|
  config.around(:each, :within_tmp_dir) do |example|
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        example.run
      end
    end
  end
end

RSpec::Matchers.define :be_a_file do
  match do |file_name|
    return false unless File.file?(file_name)

    if @contents
      File.read(file_name) == @contents
    else
      true
    end
  end

  chain :with_contents { |contents| @contents = contents}
end