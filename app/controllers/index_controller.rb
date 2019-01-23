require 'securerandom'
require "http"
require 'json'

class IndexController < ApplicationController
  CLIENT_SECRET = ""
  CLIENT_ID = ""
  BASE_URL = "" # use ngrok in development https://ngrok.com/
  URL = "#{BASE_URL}/callback"
  SCOPE = "write:repo_hook"
  STATE = SecureRandom.hex

  def login
    @url = "https://github.com/login/oauth/authorize?client_id=#{CLIENT_ID}&redirect_uri=#{URL}&scope=#{SCOPE}&state=#{STATE}"
    session[:state] = STATE
  end

  def callback
    # raise BadRequest("State does not match") unless session[:state] == params[:state] # FIXME
    response = HTTP.headers(:accept => "application/json").post("https://github.com/login/oauth/access_token", :form => {client_id: CLIENT_ID, client_secret: CLIENT_SECRET, code: params[:code] })
    hash = JSON.parse(response.body.to_s)
    session[:access_token] = hash["access_token"]
    redirect_to repositories_path
  end

  def repositories
    response = HTTP.headers(authorization: "token #{session[:access_token]}").get("https://api.github.com/user/repos")
    repositories = JSON.parse(response.body.to_s)
    puts repositories
    @repository_names = []
    repositories.each do |repository|
      @repository_names << repository["full_name"]
    end
  end

  CONFIG = {
    url: "#{URL}/webhooks",
    secret: "123"
  }.to_json

  def create_webhook
    puts "https://api.github.com/repos/#{params[:repository_name]}/hooks"
    response = HTTP
      .headers(authorization: "token #{session[:access_token]}")
      .post("https://api.github.com/repos/#{params[:repository_name]}/hooks", form: { config: CONFIG, name: 'web' } )
    puts response.body
  end

  def webhook
    puts params
  end
end
