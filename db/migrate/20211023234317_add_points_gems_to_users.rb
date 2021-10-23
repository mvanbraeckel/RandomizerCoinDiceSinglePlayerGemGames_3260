class AddPointsGemsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :points, :integer
    add_column :users, :gems, :integer
  end
end
