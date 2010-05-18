class RolesToBit < ActiveRecord::Migration
  def self.up
    add_column :users, :role_mask, :integer, :default => 1, :null => false
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
