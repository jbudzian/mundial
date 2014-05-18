class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :home_team_goals_90mins
      t.integer :away_team_goals_90mins
      t.integer :result_90mins
      t.boolean :home_team_eliminated
      t.integer :match_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
    add_index :bets, [:user_id]
    add_index :bets, [:match_id]
  end
end
