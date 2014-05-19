class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :home_team_goals_90mins, :null => false
      t.integer :away_team_goals_90mins, :null => false
      t.integer :result_full_time, :null => false
      t.integer :match_id, :null => false

      t.timestamps
    end
  end
end
