# db/migrate/20251029130001_create_solid_cache_tables.rb
class CreateSolidCacheTables < ActiveRecord::Migration[7.1]
  def change
    create_table :solid_cache_entries do |t|
      t.binary :key, null: false, index: { unique: true }
      t.binary :value, null: false
      t.datetime :expires_at, index: true
      t.timestamps
    end
  end
end