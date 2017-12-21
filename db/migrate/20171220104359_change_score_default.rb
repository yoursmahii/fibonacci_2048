class ChangeScoreDefault < ActiveRecord::Migration
  def change
  	change_column :games, :score, :integer, :default => 0
  end
end
