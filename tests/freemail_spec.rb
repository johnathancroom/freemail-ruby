require_relative '../freemail'

describe Freemail do
  # Create instance before all tests
  before :each do
    @freemail = Freemail.new File.read('tests/emails/iMail.txt')
  end
  
  describe '#new' do
    it 'takes one parameter and returns a Freemail object' do
      @freemail.should be_an_instance_of Freemail
    end
  end
  
  describe '#sender' do
    it 'returns sender' do
      @freemail.header('from').should eql 'Dr. Nobody <nobody@gmail.com>'
    end
  end
end