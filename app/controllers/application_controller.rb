class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  
    # beforeアクション
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      if not logged_in?
        store_location
        flash[:danger] = "ログインしてください！！"
        redirect_to login_url
      end
    end
end