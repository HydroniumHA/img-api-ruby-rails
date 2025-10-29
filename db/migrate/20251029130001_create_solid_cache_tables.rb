# db/migrate/20251029130001_create_solid_cache_tables.rb
class CreateSolidCacheTables < ActiveRecord::Migration[7.1]
  def change
    SolidCache::CreateTables.new.send(:change)
  end
end