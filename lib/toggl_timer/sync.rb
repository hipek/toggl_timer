class TogglTimer::Sync < Struct.new(:user, :start_date, :end_date)
  class << self
    def sync_all
      User.find_each do |user|
        new(user, Date.today, Date.today).sync
      end
    end
  end

  def sync
    return if api_key.blank?
    toggl_times.each do |ttime|
      next if ttime.running?

      log = TogglTimer::Log.where(
        toggl_id: ttime.id
      ).first || TogglTimer::Log.new

      begin
        log.update_entry(ttime, user)
      rescue ActiveRecord::RecordInvalid => e
        puts ["user_id: #{user.id}", ttime.attributes.to_json, e].join ', '
      end
    end
  end

  def toggl_times
    time_entries.all_by_dates(start_date, end_date)
  end

  def api_key
    user.custom_field_value(UserCustomField.find_by_name('Toggl API Key'))
  end

  protected

  def time_entries
    @time_entries ||= begin
      key = api_key
      Class.new(TogglTimer::TimeEntry) do
        def self.name; 'TimeEntry'; end
        self.user = key
        define_schema
      end
    end
  end
end
