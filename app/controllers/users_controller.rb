class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                    :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  def index
    @users = User.paginate(page:params[:page])   
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # debugger
  end
  
  def new
    @user = User.new
    # debugger
  end

  def create
    @user = User.new(user_params)   # user_paramを別メソッドとして呼び出し
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_url(@user)
      # 保存し、chckのtrue 、falseによって次のアクションを変える
      # GET "/users/#{@user.id}" => showアクションが反応
    else
      # Failure時
      render 'new' #newテンプレートを呼び出し
    end
  end
  
  # GET /users/:id/edit
  # params[:id] => :id
  def edit
    # @user = User.find(params[:id])
    # app/views/users/edit.html.erb
  end
  
  # PATCH /users/:id
  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "プロファイルがアップデートされました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーは削除されました"
    redirect_to users_url
  end
  
  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)  #paramsに:userのハッシュに戻す値を制限
    end
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
