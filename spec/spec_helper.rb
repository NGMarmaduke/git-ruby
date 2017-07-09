$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'git_ruby'
require 'rspec'

require 'fileutils'
require 'securerandom'

RSpec.configure do |config|
  config.around(:each, :within_tmp_dir) do |example|
    dir_name = File.join('tmp', SecureRandom.hex)
    FileUtils.mkdir_p(dir_name)

    Dir.chdir(dir_name) do 
      example.run
    end

    FileUtils.rm_rf(dir_name)
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