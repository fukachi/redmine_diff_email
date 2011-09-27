require 'rubygems'
require "dispatcher"
require 'redmine'
require 'changeset_patch'

# Hooks
require 'view_projects_settings_repository_hooks'

Redmine::Plugin.register :redmine_redmine_diff_email do
  name 'Redmine Diff Email Plugin'
  author 'Kah Seng Tay, Sergey Generalov, Lamar, Ivan Evtuhovich, cou2jpn'
  description 'This is a plugin for Redmine that sends diff emails on commits.'
  version 'c.1.0.0'
end

Dispatcher.to_prepare do
  Changeset.send(:include, ChangesetPatch)
end
