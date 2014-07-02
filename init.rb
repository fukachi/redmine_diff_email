# coding: utf-8

require 'redmine'

require 'redmine_diff_email'

Redmine::Plugin.register :redmine_diff_email do
  name 'Redmine Diff Email Plugin'
  author 'Lukas Pirl (orig. by Kah Seng Tay, Sergey Generalov, Lamar, Ivan Evtuhovich, cou2jpn)'
  description 'This is a plugin for Redmine that sends diff emails on commits.'
  version '0.3.0'
  url 'https://github.com/lpirl/redmine_diff_email'
end
