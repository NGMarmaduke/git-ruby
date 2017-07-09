require 'fileutils'
require 'active_support/core_ext/string/strip.rb'

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
      # Required
      FileUtils.mkdir('.git')
      FileUtils.mkdir(File.join('.git', 'objects'))
      FileUtils.mkdir(File.join('.git', 'refs'))

      File.write(File.join('.git', 'HEAD'), head)

      # Nice to haves
      FileUtils.mkdir(File.join('.git', 'branches'))
      FileUtils.mkdir(File.join('.git', 'hooks'))
      FileUtils.mkdir(File.join('.git', 'info'))
      FileUtils.mkdir(File.join('.git', 'objects', 'info'))
      FileUtils.mkdir(File.join('.git', 'objects', 'pack'))
      FileUtils.mkdir(File.join('.git', 'refs', 'heads'))
      FileUtils.mkdir(File.join('.git', 'refs', 'tags'))

      File.write(File.join('.git', 'config'), config) 
      FileUtils.touch(File.join('.git', 'description'))
      FileUtils.touch(File.join('.git', 'info', 'exclude'))
    end

    private

    def head
      <<-HEAD.strip_heredoc
        ref: refs/heads/master
      HEAD
    end

    def config
      <<-CONFIG.strip_heredoc
        [core]
          repositoryformatversion = 0
          filemode = true
          bare = false
          logallrefupdates = true
      CONFIG
    end

  end
end