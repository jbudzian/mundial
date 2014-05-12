class AddPlaceholderToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :placeholder, :boolean, default: false
  end
end
