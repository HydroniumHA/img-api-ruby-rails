# db/migrate/20251029130000_create_solid_queue_tables.rb
class CreateSolidQueueTables < ActiveRecord::Migration[7.1]
  def change
    SolidQueue::CreateTables.new.send(:change)
  end
end