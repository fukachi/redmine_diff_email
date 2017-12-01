require_dependency 'redmine/scm/adapters/subversion_adapter'

module RedmineDiffEmail
  module Patches
    module SubversionAdapterPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
        end
      end

      module InstanceMethods

        def changed_files(path = nil, rev = 'HEAD')
          path ||= ''
          cmd = "#{self.class.sq_bin} log --xml -v -q -r #{rev} #{target(path)}"
          cmd << credentials_string
          changed_files = []
          shellout(cmd) do |io|
            output = io.read.force_encoding('UTF-8')
            begin
              doc = parse_xml(output)
              each_xml_element(doc['log'], 'logentry') do |logentry|
                paths = []
                each_xml_element(logentry['paths'], 'path') do |path|
                  changed_files << path['action'] + " " + path['__content__'] + "\n"
                end
              end
            rescue
            end
          end
          changed_files
        end
      end

    end
  end
end

unless Redmine::Scm::Adapters::SubversionAdapter.included_modules.include?(RedmineDiffEmail::Patches::SubversionAdapterPatch)
  Redmine::Scm::Adapters::SubversionAdapter.send(:include, RedmineDiffEmail::Patches::SubversionAdapterPatch)
end
