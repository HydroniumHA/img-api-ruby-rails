class CreateUserProfilePics < ActiveRecord::Migration[8.1]
  def change
    create_table :user_profile_pics do |t|
      t.string :firebase_uid

      t.timestamps
    end
    add_index :user_profile_pics, :firebase_uid, unique: true
  end
end
