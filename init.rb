require 'rubygems'
require 'redmine'

# Hooks
require 'hooks'

Redmine::Plugin.register :redmine_diff_email do
  name 'Redmine Diff Email Plugin'
  author 'Lukas Pirl (orig. by Kah Seng Tay, Sergey Generalov, Lamar, Ivan Evtuhovich, cou2jpn)'
  description 'This is a plugin for Redmine that sends diff emails on commits.'
  version '0.2.1'
  url 'https://github.com/lpirl/redmine_commit_email'
  requires_redmine :version_or_higher => '2.5.1'
end

Rails.configuration.to_prepare do
  Changeset.send(:include, ChangesetPatch)
  Repository.send(:include, RepositoryPatch)
  Redmine::Scm::Adapters::SubversionAdapter.send(:include,SubversionAdapterPatch)
  Redmine::Scm::Adapters::GitAdapter.send(:include,GitAdapterPatch)
  Redmine::Scm::Adapters::MercurialAdapter.send(:include,MercurialAdapterPatch)
end
