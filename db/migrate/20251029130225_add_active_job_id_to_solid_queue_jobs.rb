class AddActiveJobIdToSolidQueueJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :solid_queue_jobs, :active_job_id, :string
    add_index :solid_queue_jobs, :active_job_id
  end
end
