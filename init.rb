require 'rubygems'
require "dispatcher"
require 'redmine'

# Hooks
require 'view_projects_settings_repository_hooks'

Redmine::Plugin.register :redmine_redmine_diff_email do
  name 'Redmine Diff Email Plugin'
  author 'Kah Seng Tay, Sergey Generalov, Lamar, Ivan Evtuhovich, cou2jpn'
  description 'This is a plugin for Redmine that sends diff emails on commits.'
  version 'c.1.3.0'
  requires_redmine :version_or_higher => '1.3.0'
end

Dispatcher.to_prepare do
  Changeset.send(:include, ChangesetPatch)
  Repository.send(:include, RepositoryPatch)
  Redmine::Scm::Adapters::SubversionAdapter.send(:include,SubversionAdapterPatch)
  Redmine::Scm::Adapters::GitAdapter.send(:include,GitAdapterPatch)
  Redmine::Scm::Adapters::MercurialAdapter.send(:include,MercurialAdapterPatch)
end
