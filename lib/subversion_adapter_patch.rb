require_dependency 'lib/redmine/scm/adapters/subversion_adapter'

module SubversionAdapterPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def changed_files(path=nil, rev="HEAD")
      path ||= ''
      cmd = "#{self.class.sq_bin} log -v -q -r #{rev} #{target(path)}"
      cmd << credentials_string
      changed_files = []
      shellout(cmd) do |io|
        io.each_line do |line|
          changed_files << line
        end
      end
      changed_files
    end
  end
end
