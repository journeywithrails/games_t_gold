class CreateSponsoreAds < ActiveRecord::Migration
  def self.up
    create_table :sponsore_ads do |t|
      t.string :filename
      t.string :content_type
      t.integer :size
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsore_ads
  end
end
