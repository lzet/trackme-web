class Users::SessionsController < Devise::SessionsController
  def new
    super
  end
  def destroy
    super
  end
  def respond_to_on_destroy
    redirect_to root_path
  end
  def create
    user = User.find_by(login: params[:user][:login])
    if user && user.reset
      user.password = params[:user][:password]
      user.reset = false
      user.save
    end
    super do |resource|
      if resource.disabled?
        sign_out(resource)
      end
    end
  end
end
