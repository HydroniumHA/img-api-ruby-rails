class CreateFullSolidDependencies < ActiveRecord::Migration[8.1]
  def change
    # --- Création des tables Solid Queue (STRUCTURE COMPLÈTE) ---
    create_table :solid_queue_jobs, id: :bigint do |t|
      t.string :queue_name, null: false
      t.string :priority, null: false
      t.text :arguments

      # Colonnes qui manquaient et causaient le crash :
      t.string :active_job_id
      t.string :class_name
      t.string :concurrency_key

      t.integer :executions, default: 0, null: false
      t.text :error_details
      t.datetime :scheduled_at
      t.timestamps
    end
    add_index :solid_queue_jobs, :queue_name
    add_index :solid_queue_jobs, :priority

    # --- Création des tables auxiliaires de Solid Queue (Ex: ready_executions) ---
    create_table :solid_queue_ready_executions, id: :bigint do |t|
      t.references :job, null: false, index: { unique: true }
      t.string :queue_name, null: false
      t.string :priority, null: false
      t.timestamps
    end
    # (Continuez avec toutes les autres tables de Solid Queue, ex: scheduled, failed, etc.)

    # --- Création des tables Solid Cache ---
    create_table :solid_cache_entries, id: :bigint do |t|
      t.binary :key, null: false, index: { unique: true }
      t.binary :value, null: false
      t.datetime :expires_at, index: true
      t.timestamps
    end
  end
end
