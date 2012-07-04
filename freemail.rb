class Freemail
  def initialize(raw_email)
    @freemail = raw_email.split('--') # Split up headers and bodies
  end
  
  def header(property)
    @freemail[0].each_line do |line|
      line = line.split(':')
      
      if line[0].downcase == property
        @value = line[1].strip
      end
    end
        
    @value
  end
end