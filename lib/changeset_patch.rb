require_dependency 'changeset'

module ChangesetPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      after_create :send_diff_emails
    end
  end
  module InstanceMethods
    def send_diff_emails
      if @repository.is_diff_email?
        DiffMailer.deliver_diff_notification(self, @repository.is_diff_email_attached?)
      end
    end
  end
end
