require 'fileutils'

module GitRuby
  class Init
    attr_reader :dir

    def self.perform(*args)
      new(*args).perform
    end

    def initialize(dir: Dir.pwd)
      @dir = dir 
    end

    def perform
      FileUtils.touch('hello')
    end
  end
end