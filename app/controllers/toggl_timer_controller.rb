class TogglTimerController < AccountController
  unloadable

  def index
    @logs_pages, @logs = paginate(
      TogglTimer::Log.order('created_at desc')
        .includes(:time_entry),
      :per_page => 25
    )
  end

  def create
    require_login || return
    if TogglTimer::Sync.new(User.current, start_date, end_date).sync
      flash[:notice] = 'Sync success'
    end
    redirect_to toggls_url
  end

  def destroy
    TogglTimer::Log.where(id: params[:id]).first.try(:destroy)
    flash[:notice] = 'Log has been deleted.'
    redirect_to toggls_url
  end

  protected

  def start_date
    Date.parse params[:sync][:start_date]
  end

  def end_date
    Date.parse params[:sync][:end_date]
  end
end
