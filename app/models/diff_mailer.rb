class DiffMailer < Mailer

  def diff_notification(changeset, is_attached)

    changed_files = changeset.repository.changed_files("", changeset.revision)
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
    subject "[#{project.name}: #{l(:label_repository)}] #{changeset.format_identifier} #{changeset.short_comments}"
    body :project => project,
         :author => author,
         :changeset => changeset,
         :changed_files => changed_files,
         :changeset_url => url_for(:controller => 'repositories', :action => 'revision', :rev => changeset.revision, :id => project)
    if !diff.nil? && is_attached == true
      content_type  "multipart/mixed"
      part :content_type => "multipart/alternative" do |p|
        p.part :content_type => "text/plain" do |t|
          t.body = render(:file => "diff_notification.text.erb", :body => body, :layout => 'mailer.text.erb')
        end
        p.part :content_type => "text/html" do |h|
          h.body = render_message("diff_notification.html.erb", body)
        end
      end
      attachment :content_type => 'text/x-patch', :body => diff.join, :filename => "changeset_r#{changeset.revision}.diff"
    else
      render_multipart('diff_notification', body)
    end
  end

end
