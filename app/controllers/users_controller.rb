class UsersController < ApplicationController
before_filter :signed_in_user, only: [:index,:edit,:update,:destroy]
before_filter :correct_user,   only: [:edit,:update]
before_filter :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user.microposts.create(content: "Welcome to the Phoenix Data Center")
      sign_in @user
      flash[:success] = "Welcome to the Phoenix Data Center!"
      redirect_to @user #Handle a srccessful save
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @micropost = current_user.microposts.build if signed_in?
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end 	
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Destroy."
    redirect_to users_url
  end

private
  def signed_in_user
    #redirect_to signin_url, notice: "Please sign in." unless signed_in?
    #unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    #end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) #and current_user.admin?    
  end

  def admin_user #非admin 直接转回首页
    redirect_to(root_path) unless  current_user.admin?    
  end
  

end
