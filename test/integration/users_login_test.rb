require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path                  #ログイン用のパスを開く
    assert_template 'sessions/new'  #新しいセッションのフォームが正しく表示されたことを確認する
    post login_path, params: { session: { email: "", password: "" } }    #わざと無効なparamsハッシュを使ってセッション用パスにPOSTする
    assert_template 'sessions/new'    #新しいセッションのフォームが再度表示され、
    assert_not flash.empty?           #フラッシュメッセージが追加されることを確認する
    get root_path                     #別のページ (Homeページなど) にいったん移動する
    assert flash.empty?               #移動先のページでフラッシュメッセージが表示されていないことを確認する
  end
  
  test "login with valid information followed by logout" do
    get login_path                #ログイン用のパスを開く
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }       #セッション用パスに有効な情報をpostする
    assert is_logged_in?                  #ログインしてることの確認                                      
    assert_redirected_to @user
    follow_redirect!                  
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0       #ログイン用リンクが表示されなくなったことを確認する
    assert_select "a[href=?]", logout_path                #ログアウト用リンクが表示されていることを確認する
    assert_select "a[href=?]", user_path(@user)           #プロフィール用リンクが表示されていることを確認する
    delete logout_path                           #ログアウト
    assert_not is_logged_in?                     #ログインしていないことの確認
    assert_redirected_to root_url                #Homeページにリダイレクトしてることの確認
    follow_redirect!
    assert_select "a[href=?]", login_path                   #ログインパスがあることの確認
    assert_select "a[href=?]", logout_path,      count: 0   #ログアウトパスがないことの確認
    assert_select "a[href=?]", user_path(@user), count: 0   #ユーザープロフィールパスがないことの確認
  end
end


















