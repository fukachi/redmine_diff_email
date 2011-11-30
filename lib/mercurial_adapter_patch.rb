require_dependency 'lib/redmine/scm/adapters/mercurial_adapter'

module MercurialAdapterPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def changed_files(path=nil, rev="HEAD")
      path ||= ''
      hg_args = []
      hg_args << "status" << "--change" << rev
      unless path.blank?
        p = scm_iconv(@path_encoding, 'UTF-8', path)
        hg_args << CGI.escape(hgtarget(p))
      end
      changed_files = []
      hg *hg_args do |io|
        io.each_line do |line|
          changed_files << line
        end
      end
      changed_files
    end
  end
end
