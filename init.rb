Redmine::Plugin.register :toggl_timer do
  name 'Toggl Timer plugin'
  author 'Jacek Hiszpanski'
  description 'Toggle integration with redmine'
  version '0.0.1'
  url 'https://github.com/hipek/toggl_timer'
  author_url 'https://github.com/hipek'
  menu :top_menu, :toggl,
    { :controller => 'toggl_timer', :action => 'index' },
    :caption => 'Toggl',
    :require => :loggedin,
    :if => Proc.new { User.current.logged? }
end
