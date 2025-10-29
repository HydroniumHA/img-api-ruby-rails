# db/migrate/20251029130001_create_solid_cache_tables.rb
class CreateSolidCacheTables < SolidCache::Migration[5.2]
  def change
    SolidCache::Migration.all.each do |migration|
      up if migration.version.to_i <= version
    end
    SolidCache::CreateTables.new.send(:change)
  end
end