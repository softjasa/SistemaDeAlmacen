class UsersController < ApplicationController
#  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Usuario creado!"
      redirect_to :controller => :users, :action => "index"
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Su contraseña ha sido cambiada!"
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

  def index
    @users = User.order(params[:sort]).paginate(:per_page => 6, :page => params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "Usuario eliminado!"
    redirect_to :controller => :users, :action => "index"
  end
end
