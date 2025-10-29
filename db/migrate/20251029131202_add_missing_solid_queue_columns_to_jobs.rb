class AddMissingSolidQueueColumnsToJobs < ActiveRecord::Migration[8.1]
  def change
    change_table :solid_queue_jobs, bulk: true do |t|
      # Colonnes pour la file d'attente
      t.string :queue_name, null: false, default: "default" unless column_exists? :solid_queue_jobs, :queue_name
      t.string :priority, null: false, default: 0 unless column_exists? :solid_queue_jobs, :priority

      # Colonnes pour l'exécution et l'horaire
      t.integer :executions, default: 0, null: false unless column_exists? :solid_queue_jobs, :executions
      t.datetime :scheduled_at unless column_exists? :solid_queue_jobs, :scheduled_at
    end

    # Ajout des index sur la table jobs
    add_index :solid_queue_jobs, :queue_name unless index_exists?(:solid_queue_jobs, :queue_name)
  end
end
