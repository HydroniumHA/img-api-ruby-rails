class CreateFullSolidQueueSchema < ActiveRecord::Migration[8.1]
  def change
    # 1. Mise à jour des tables existantes (jobs)
    add_column :solid_queue_jobs, :active_job_id, :string unless column_exists?(:solid_queue_jobs, :active_job_id)
    add_column :solid_queue_jobs, :class_name, :string unless column_exists?(:solid_queue_jobs, :class_name)
    add_column :solid_queue_jobs, :concurrency_key, :string unless column_exists?(:solid_queue_jobs, :concurrency_key)

    # 2. Création des tables manquantes de Solid Queue
    create_table :solid_queue_scheduled_executions, id: :bigint do |t|
      t.references :job, null: false, index: { unique: true }
      t.string :queue_name, null: false
      t.string :concurrency_key
      t.datetime :scheduled_at, null: false
      t.timestamps
    end
    add_index :solid_queue_scheduled_executions, [:scheduled_at, :priority, :job_id], name: "index_solid_queue_scheduled_executions_ordering"

    create_table :solid_queue_ready_executions, id: :bigint do |t|
      t.references :job, null: false, index: { unique: true }
      t.string :queue_name, null: false
      t.string :priority, null: false
      t.timestamps
    end
    add_index :solid_queue_ready_executions, [:priority, :job_id], name: "index_solid_queue_ready_executions_ordering"
    add_index :solid_queue_ready_executions, [:queue_name, :priority, :job_id], name: "index_solid_queue_ready_executions_compound_ordering"
  end
end
