require 'yaml'
require 'erubis'
require 'sinatra'
require 'sinatra/reloader'

before do
  @users = YAML.load_file('users.yaml')
end

helpers do
  def number_of_interests
    @users.map { |_, data| data[:interests].size }.sum
  end
end

get '/' do
  erb :display
end

get '/:username' do
  @name = params['username'].to_sym
  @email = @users[@name][:email]
  @interests = @users[@name][:interests]

  erb :user
end
