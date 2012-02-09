class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.string :first_name, :last_name, :nickname, :limit => 255
      t.string :ethnicity, :limit => 255

      t.text :interests, :gaming_philosophy, :gaming_counsel
      t.text :equipment_used
      t.text :venues

      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
