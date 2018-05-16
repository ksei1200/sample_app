class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
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


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)  #paramsに:userのハッシュに戻す値を制限
    end
end
