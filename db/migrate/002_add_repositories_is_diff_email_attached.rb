class AddRepositoriesIsDiffEmailAttached < ActiveRecord::Migration
  def self.up
    add_column :repositories, :is_diff_email_attached, :boolean, :default => false, :null => false
    Repository.update_all("is_diff_email_attached = 1", "is_diff_email = 1")
  end

  def self.down
    remove_column :repositories, :is_diff_email_attached
  end
end
