class TogglTimer::Log < ActiveRecord::Base
  self.table_name = 'toggl_timer_logs'
  unloadable
end
