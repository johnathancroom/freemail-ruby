require_relative '../freemail'

describe Freemail do
  # Create instance before all tests
  before :each do
    @freemail = Freemail.new File.read('tests/emails/iMail.txt')
  end
  
  # Test Initialize
  describe '#new' do
    it 'takes one parameter and returns a Freemail object' do
      @freemail.should be_an_instance_of Freemail
    end
  end
  
  # Test headers
  describe "#header('from')" do
    it 'returns sender' do
      @freemail.header('from').should eql 'Dr. Nobody <nobody@gmail.com>'
    end
  end
  
  describe "#header('subject')" do
    it 'returns subject' do
      @freemail.header('subject').should eql 'This is my subject, yo'
    end
  end
  
  describe "#header('to')" do
    it 'returns recipient' do
      @freemail.header('to').should eql 'Johnathan Croom <johnathancroom@gmail.com>'
    end
  end
  
  describe "#header('nonexistent_property')" do
    it 'returns nil' do
      @freemail.header('nonexistent_property').should eql nil
    end
  end
end