class CreateTogglTimerLogs < ActiveRecord::Migration
  def change
    create_table :toggl_timer_logs do |t|
      t.integer :issue_id
      t.integer :toggl_id
      t.integer :time_entry_id
      t.string :description
      t.integer :duration
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
