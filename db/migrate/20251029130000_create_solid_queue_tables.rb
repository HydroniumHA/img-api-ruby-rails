# db/migrate/20251029130000_create_solid_queue_tables.rb
class CreateSolidQueueTables < SolidQueue::Migration[5.2]
  def change
    SolidQueue::Migration.all.each do |migration|
      next if migration.name == "SolidQueue::CreateTables"
      up if migration.version.to_i <= version
    end
    SolidQueue::CreateTables.new.send(:change)
  end
end