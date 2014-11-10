class TogglTimerController < AccountController
  unloadable

  def index
    require_login || return
  end

  def create
    require_login || return
    if TogglTimer::Sync.new(User.current, start_date, end_date).sync
      flash[:notice] = 'Sync success'
    end
    redirect_to toggl_url
  end

  protected

  def start_date
    Date.parse params[:sync][:start_date]
  end

  def end_date
    Date.parse params[:sync][:end_date]
  end
end
