require 'sinatra' # Server of choice
require 'cgi' # Needed to escape HTML in the view
require_relative '../lib/freemail' # Include the Freemail class

# Process HTML GET requests at the root URL
get '/' do
  # Read the contents of our example email
  @original = File.read(File.join(File.dirname(__FILE__), 'email.txt'))
  # Use Freemail to parse the contents (returns hash of contents)
  @freemail = Freemail.parse @original
  
  # Render views/example.erb
  erb :example
end