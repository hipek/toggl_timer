class TogglTimer::TimeEntry < ActiveResource::Base
  self.site     = 'https://www.toggl.com/api/v8'
  self.password = 'api_token'

  if respond_to?(:include_format_in_path=)
    self.include_format_in_path = false
  else
    def self.collection_path(*args)
      super(*args).gsub(/\.json/, "")
    end
  end

  R_ISSUE_ID_REGEXP = /#(\d+)/

  class << self
    def all_by_dates(start_date = Time.now, end_date = nil)
      end_date = start_date if end_date.blank?
      all(params: {
        start_date: start_date.to_datetime.beginning_of_day.to_s,
        end_date: end_date.to_datetime.end_of_day.to_s
      }) || []
    end

    def define_schema
      schema do
        string 'description'
        float  'duration'
      end
    end
  end

  def running?
    duration.to_i < 0
  end

  def r_issue_id
    @r_issue_id ||= begin
      description.to_s =~ R_ISSUE_ID_REGEXP
      $1
    end.to_i
  end

  def r_description
    @r_description ||= description.to_s
      .gsub(R_ISSUE_ID_REGEXP, ' ').squeeze(' ').strip
  end

  def spent_on
    DateTime.parse(at).to_date.to_s
  end

  def hours
    (duration.to_f / 3600.0).round(2)
  end
end
