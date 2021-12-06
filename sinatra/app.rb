require 'sinatra'
require './helper_method'
require 'securerandom'

class App < Sinatra::Base

  helper = Helper.new

  post '/generate' do
    key = helper.generate_key
    "Generated key #{key}"
  end

  get '/get_key' do
    key = helper.get_available_key
    key ? "#{key} is available and blocked for 1 minute" : 404
  end

  delete '/delete' do 
    key = params[:key]
    result = helper.delete_key(key)
    if result
      "Deleted key #{key}"
    else
      "No #{key} found to delete"
    end
  end

  patch '/unblock' do
    key = params[:key]
    result = helper.unblock_key(key)
    if result
      "Unblocked key #{key}"
    else
      "No blocked key #{key} found"
    end
  end

  patch '/keep_alive' do
    key = params[:key]
    result = helper.keep_alive(key)
    if result
      "Key #{key} kept alive"
    else
      "No key #{key} found"
    end
  end

  get '/all_keys' do
    helper.keys.to_s
  end

  get '/blocked_keys' do
    helper.blocked_keys.to_s
  end

  get '/available_keys' do
    helper.available_keys.to_s
  end
end

