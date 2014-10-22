class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = "Sesion iniciada..!"
      #redirect_to_target_or_default root_url, :notice => "Sesion Iniciada Correctamente."
      redirect_to root_url
    else
      flash[:danger] = "Login o Contraseña Invalido."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:danger] = "Usted acaba de cerrar sesion"
    redirect_to root_url
  end
end
