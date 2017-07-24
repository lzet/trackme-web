class SettingsController < ApplicationController
  before_action :checkadmin, only: [:getadministrate, :putaministrate]
  before_action :checkuser, only: [:getsettings, :putsettings]
  def getsettings
    if request.method == "POST"
      current_user.password = params[:user][:password]
      current_user.password_confirmation = params[:user][:password_confirmation]
      if current_user.save
        render body: 'close', layout: false
        return
      end
    end
    render :getsettings, layout: false
  end

  def getadministrate
    if params[:newuser]
      User.create(login: params[:newuser][:login], password: 'nopassword', reset: true)
    elsif params[:format]
      user = User.find(params[:format])
      if user 
        if !params[:disabled].nil?
          user.disabled = params[:disabled]
          user.save
        elsif !params[:canmodify].nil?
          user.canmodify = params[:canmodify]
          user.save
        elsif !params[:reset].nil?
          user.reset = true
          user.save
        elsif !params[:delete].nil?
          user.destroy
        end
      end
    end
    render :getadministrate, layout: false
  end

  private
    def checkadmin
      authenticate_user!
      unless current_user.admin?
        render :accessdenided, layout: false
      end
    end

    def checkuser
      authenticate_user!
      unless current_user.canmodify?
        render :accessdenided, layout: false
      end
    end
end
