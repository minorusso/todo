class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    if logged_in?
      redirect_to tasks_path, notice:'ログインページに戻る際はログアウトしてください'
    end
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = 'ログインに成功しました'
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
