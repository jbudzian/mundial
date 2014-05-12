class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :tournament_stage
      t.integer :match_no
      t.datetime :match_date
      t.integer :home_team_id, :null => false
      t.string :away_team_id, :null => false
      t.string :venue

      t.timestamps
    end
  end
end
