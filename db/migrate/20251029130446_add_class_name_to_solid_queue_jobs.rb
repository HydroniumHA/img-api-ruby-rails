class AddClassNameToSolidQueueJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :solid_queue_jobs, :class_name, :string
  end
end
