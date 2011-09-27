class DiffMailer < Mailer

  def diff_notification(changeset)
    diff = changeset.repository.diff("", changeset.revision, nil)
    project = changeset.repository.project
    author = changeset.author.to_s

    redmine_headers 'Project' => project,
                    'committer' => author,
                    'revision' => changeset.revision
    set_language_if_valid changeset.user.language unless changeset.user.nil?
    # Only send to users permitted :browse_repository.
    recipients project.members.collect {|m| m.user}.select {|user| user.allowed_to?(:browse_repository, project)}.collect {|u| u.mail}
    from Setting.mail_from
    subject "[#{project.name}: #{l(:label_repository)}] #{changeset.short_comments}"
    body :project => project,
         :author => author,
         :diff => diff,
         :changeset => changeset,
         :changeset_url => url_for(:controller => 'repositories', :action => 'revision', :rev => changeset.revision, :id => project)
    render_multipart('diff_notification', body)
    attachment :content_type => 'text/x-patch', :body => diff.join, :filename => "changeset_r#{changeset.revision}.diff" unless diff.nil?

  end
end
