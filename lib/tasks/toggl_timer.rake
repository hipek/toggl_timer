namespace :toggl_timer do
  desc "Sync redmine time entries with toggl"
  task :sync => :environment do
    TogglTimer::Sync.sync_all
  end
end
