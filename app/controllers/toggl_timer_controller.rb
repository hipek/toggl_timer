class TogglTimerController < ApplicationController
  unloadable

  def index
    
  end

  def create
    redirect_to toggl_url
  end
end
