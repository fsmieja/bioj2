class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy


  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to BioJotter!"
      redirect_to @user
    else
      @title = "Sign Up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def edit
    @title = "Edit user"
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end


  def destroy
    @user = User.find(params[:id])
    if  current_user?(@user)
      flash[:alert] = "Can't destroy self!"
    else
      @user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end


  private
  

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path)  unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
