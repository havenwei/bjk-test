class WelcomeController < ApplicationController
  def index
    @code = params['code']
    response = RestClient.get "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx8dbaac30fa2befc4&secret=03346aacf2fca29f0edaf7eeedd3f923&code=#{@code}&grant_type=authorization_code"
    data = JSON.parse(response.body)
    @access_token = data['access_token']
    @user_openid = data['openid']

    response = RestClient.get "https://api.weixin.qq.com/sns/userinfo?access_token=#{@access_token}&openid=#{@user_openid}&lang=zh_CN"
    user_data = JSON.parse(response.body)
    @user_name = user_data['nickname']
    @user_sex = user_data['sex']
    @user_city = user_data['city']
    @user_country = user_data['country']
    @user_headimgurl = user_data['headimgurl']
  end
end
