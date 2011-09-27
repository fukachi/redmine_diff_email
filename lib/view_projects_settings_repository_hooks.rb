class ViewProjectsSettingsRepositoryHooks < Redmine::Hook::ViewListener
  render_on :view_projects_settings_repository, :partial => 'diff_mailer_settings/diff_email_settings'
end
