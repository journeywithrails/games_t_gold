class AddExtraLaddersAttributes < ActiveRecord::Migration
  def self.up
    change_table :tournaments do |t|
      t.text :equipment
    end
  end

  def self.down
    change_table :tournaments do |t|
      t.remove :equipment
    end
  end
end
