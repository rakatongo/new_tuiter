class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    #@user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
    	flash[:success] = "Bienvenido a The Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to root_path
  end

  private

    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please log in." unless signed_in?
    end

      # Sacando el correct usuario con los parametros 
    def correct_user
      @user = User.find(params[:id])    # Sacando parametros id 
      redirect_to(root_path) unless current_user?(@user)  # current_user?  compara variable @user con el verdadero user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
