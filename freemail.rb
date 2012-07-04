class Freemail
  def initialize(raw_email)
    # Split up headers and bodies
    @freemail = raw_email.split('--')
  end
  
  def header(property)
    # Process through each line in the header
    @freemail[0].each_line do |line|
      # Split the line by a colon
      line = line.split(':')
      
      # Check if the left of the colon is the property we want
      if line[0].downcase == property
        # Return the value of this property stripped
        @value = line[1].strip
      end
    end
    
    # Return the value we retrieved
    @value
  end
end