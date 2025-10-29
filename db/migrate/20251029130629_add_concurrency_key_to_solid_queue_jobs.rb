class AddConcurrencyKeyToSolidQueueJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :solid_queue_jobs, :concurrency_key, :string
    add_index :solid_queue_jobs, :concurrency_key
  end
end
