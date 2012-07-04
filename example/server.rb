require 'sinatra'
require 'cgi'
require_relative '../freemail'

get '/' do
  @original = File.read(File.join(File.dirname(__FILE__), 'email.txt'))
  @freemail = Freemail.parse @original
  
  erb :example
end