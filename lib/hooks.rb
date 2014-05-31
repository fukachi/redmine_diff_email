class ViewHooks < Redmine::Hook::ViewListener
  render_on :view_repository_form, :partial => 'diff_mailer_settings/diff_email_settings'
end
