class Freemail
  class << self
    def parse(raw_email)
      # Create empty hash
      values_hash = {}
      
      # Get body and cut it out
      raw_email = raw_email.gsub(/\n\n(?<body>.+)$/) {
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