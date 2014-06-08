require_dependency 'changeset'

module ChangesetPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      after_create :send_notification
    end
  end
  module InstanceMethods
    def send_notification
      if repository.is_diff_email?
        Mailer.changeset_added(self, repository.is_diff_email_attached?).deliver
      end
    end
  end
end
