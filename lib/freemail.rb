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
  def self.parse(raw_email)
    cut_out_headers = /\n\n(?<body>.+)/m
    
    # Create blank hash for the bodies
    bodies = InsensitiveHash.new
    
    # Get body and cut it out
    headers = raw_email.sub(cut_out_headers) {
      @raw_body = $1
      ''
    }
    
    # Parse headers
    headers = parse_headers(headers)
    
    # Check if the email is multipart
    if headers['content-type'] =~ /multipart/
      # Get boundary
      headers['content-type'].sub(/boundary\=\"(?<boundary>[\w\-=_]+)\"/) {
        @boundary = $1
      }
      
      # Separate bodies by the boundary
      body_array = @raw_body.split("--#{@boundary}")
      
      # Create empty hash
      @body = InsensitiveHash.new
      
      # Process each body
      body_array.each_with_index do |body, index|
        # Separate headers and content
        body_headers = body.sub(cut_out_headers) {
          # Decode quoted printable
          @temp_body = $1.unpack('M')[0]
          ''
        }
        
        # Parse headers
        headers_hash = parse_headers(body_headers)
        
        # If content has a content-type
        if !headers_hash['content-type'].nil?
          # Add content to hash where the key is the content-type
          @body[headers_hash['content-type'].gsub(/;[\n\w\=\- ]+/m, '')] = @temp_body
        end
      end
      
      # Add body and body_html to bodies hash
      bodies['body'] = @body['text/plain'] if !@body['text/plain'].nil?
      bodies['body_html'] = @body['text/html'] if !@body['text/html'].nil?
      
    # Not multipart
    else
      # Check if HTML
      if headers['content-type'] =~ /text\/html/
        # Add body_html to bodies hash after decoding quoted printable
        bodies['body_html'] = @raw_body.unpack('M')[0]
      else
        # Add body to bodies hash
        bodies['body'] = @raw_body
      end
    end
    
    # Return the header hash and bodies hash merged together
    headers.merge bodies
  end
  
  def self.parse_headers(headers)
    # Split up values by colons (:) if they don't start with spaces
    values = headers.split(/^(?! )([\w-]+):/)
    
    # Create blank hash
    headers_hash = InsensitiveHash.new
    
    # Convert the array into a hash
    for x in (1..(values.size-2)).step(2)
      headers_hash[values[x].strip] = values[x+1].strip
    end
    
    # Return hash of headers
    headers_hash
  end
end

# Hash that isn't case sensitive
class InsensitiveHash < Hash
  def [](key)
    key.respond_to?(:downcase) ? super(key.downcase) : super(key)
  end

  def []=(key, value)
    key.respond_to?(:downcase) ? super(key.downcase, value) : super(key, value)
  end
end