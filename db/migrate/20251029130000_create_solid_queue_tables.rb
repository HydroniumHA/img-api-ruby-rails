# db/migrate/20251029130000_create_solid_queue_tables.rb
class CreateSolidQueueTables < ActiveRecord::Migration[7.1]
  def change
    # Crée les tables principales pour Solid Queue
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :priority, null: false
      t.text :arguments
      t.integer :executions, default: 0, null: false
      t.text :error_details
      t.datetime :scheduled_at
      t.timestamps
    end
    add_index :solid_queue_jobs, :queue_name

    # Crée la table pour Active Job (Solid Queue utilise un ensemble de tables)
    create_table :solid_queue_active_jobs, primary_key: :job_id do |t|
      t.timestamps
    end
    # Ajoutez d'autres tables Solid Queue ici si vous les avez dans votre Gemfile, 
    # mais ces deux-là sont souvent le minimum pour le démarrage.
  end
end