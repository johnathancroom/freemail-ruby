#
# Freemail - An email parser written in Ruby
# https://github.com/johnathancroom/freemail-ruby
# 
# USAGE:
#   (raw_email.txt)
#
#     Date: Wed, 04 Jul 2012 00:00:08 -0700
#     To: johnathancroom@gmail.com
#     Subject: Check this out!
#     From:Billy <billy@yahoo.com>
#
#     This is the message body!
#
#   (file.rb)
#
#     require 'freemail'
#     freemail = Freemail.parse(File.read('raw_email.txt'))
#       # returns the following hash
#       # { "Date" => "Wed, 04 Jul 2012 00:00:08 -0700", "To" => "johnathancroom@gmail.com", "Subject" => "Check this out!", "From" => "Billy <billy@yahoo.com>", "body" => "This is the message body!" }
#

class Freemail
  class << self
    def parse(raw_email)
      # Create empty hash
      values_hash = {}
      
      # Get body and cut it out
      raw_email = raw_email.sub(/\n\n(?<body>.+)/m) {
        @body = $1
        ''
      }
      
      # Store body into the values_hash
      values_hash['body'] = @body 
    
      # Split up values by colons (:) if they don't start with spaces
      values = raw_email.split(/^(?! )([\w-]+):/)
      
      # Convert the array into a hash
      for x in (1..(values.size-2)).step(2)
        values_hash[values[x].strip] = values[x+1].strip
      end
      
      # Return the hash of values
      values_hash
    end
  end
end