class TogglTimer::Log < ActiveRecord::Base
  self.table_name = 'toggl_timer_logs'
  unloadable

  belongs_to :time_entry, class_name: '::TimeEntry'
  validates :description, :duration, :time_entry, presence: true

  class << self
    def development_activity
      ::TimeEntryActivity.default ||
        ::TimeEntryActivity.where(name: 'Development').first
    end
  end

  def update_entry(ttime, user)
    self.class.transaction do
      self.time_entry ||= ::TimeEntry.new
      self.time_entry.update_attributes!(
        activity_id: self.class.development_activity.id,
        issue_id: ttime.r_issue_id,
        spent_on: ttime.spent_on,
        hours:    ttime.hours,
        comments: ttime.r_description,
        user: user
      )
      self.toggl_id = ttime.id
      self.description = ttime.description
      self.duration =  ttime.duration
      save!
    end
  end
end
