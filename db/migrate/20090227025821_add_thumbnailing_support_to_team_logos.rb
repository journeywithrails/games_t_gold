class AddThumbnailingSupportToTeamLogos < ActiveRecord::Migration
  def self.up
    add_column :teams, :parent_id, :integer
    add_column :teams, :thumbnail, :string
  end

  def self.down
    remove_column :teams, :thumbnail
    remove_column :teams, :parent_id
  end
end
