require_dependency 'repository'

module RepositoryPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def changed_files(path, rev)
      if scm.respond_to?('changed_files')
        scm.changed_files(path, rev).join
      else
        return ""
      end
    end
  end
end
