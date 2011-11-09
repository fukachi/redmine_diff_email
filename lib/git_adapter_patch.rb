require_dependency 'lib/redmine/scm/adapters/git_adapter'

module GitAdapterPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def changed_files(path=nil, rev="HEAD")
      path ||= ''
      cmd_args = []
      cmd_args << "log" << "--no-color" << "--pretty=format:%cd" << "--name-status" << "-1" << rev
      cmd_args << "--" <<  scm_iconv(@path_encoding, 'UTF-8', path) unless path.empty?
      changed_files = []
      scm_cmd *cmd_args do |io|
        io.each_line do |line|
          changed_files << line
        end
      end
      changed_files
    end
  end
end
