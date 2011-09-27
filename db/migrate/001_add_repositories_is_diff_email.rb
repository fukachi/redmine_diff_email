class AddRepositoriesIsDiffEmail < ActiveRecord::Migration
  def self.up
    add_column :repositories, :is_diff_email, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :repositories, :is_diff_email
  end
end
