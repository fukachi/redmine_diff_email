class DiffMailer < Mailer

  def diff_notification(changeset, is_attached)
    diff = changeset.repository.diff("", changeset.revision, nil)
    project = changeset.repository.project
    author = changeset.author.to_s
    @author = changeset.user unless changeset.user.nil?

    redmine_headers 'Project' => project.identifier,
                    'committer' => @author.nil? ? author : @author.login,
                    'revision' => changeset.revision
    set_language_if_valid changeset.user.language unless changeset.user.nil?
    # Only send to users permitted :browse_repository.
    recipients project.members.collect {|m| m.user}.select {|user| user.allowed_to?(:browse_repository, project)}.collect {|u| u.mail}
    subject "[#{project.name}: #{l(:label_repository)}] r.#{changeset.format_identifier} #{changeset.short_comments}"
    body :project => project,
         :author => author,
         :changeset => changeset,
         :changeset_url => url_for(:controller => 'repositories', :action => 'revision', :rev => changeset.revision, :id => project)
    render_multipart('diff_notification', body)
    if !diff.nil? && is_attached == true
      attachment :content_type => 'text/x-patch', :body => diff.join, :filename => "changeset_r#{changeset.revision}.diff"
    end
  end

end
