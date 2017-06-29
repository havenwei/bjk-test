namespace :dev do
  task :create_menu => :environment do
    puts "create menu button ..."
    # 获取access_token
    # response = RestClient.get "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{get_app_id}&secret=#{get_app_secret}"
    response = RestClient.get "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx8dbaac30fa2befc4&secret=03346aacf2fca29f0edaf7eeedd3f923"
    data = JSON.parse(response.body)
    access_token = data['access_token']
    puts "#{access_token}"

    #创建菜单
    post_url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=#{access_token}"
    jdata = {
      "button":[
        {
          "name": "test",
          "sub_button": [
            {
              "type": "view",
              "name": "auth",
              "url": "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8dbaac30fa2befc4&redirect_uri=http://0994e126.ngrok.io&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect",
              "appid": "wx8dbaac30fa2befc4",
              "pagepath": "/index"
            }
          ]
        }
      ]
    }
    response = RestClient.post post_url, :data => jdata, :content_type => :json, :accept => :json
    puts "#{response.body}"
  end
end
