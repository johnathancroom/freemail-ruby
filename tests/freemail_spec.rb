require_relative '../freemail'

describe Freemail do
  # Create instance before all tests
  before :each do
    @freemail = Freemail.parse File.read('tests/emails/email.txt')
  end
  
  # Test Initialize
  describe '#new' do
    it 'takes one parameter and returns a Hash object' do
      @freemail.should be_an_instance_of Hash
    end
  end
  
  # Test Retrievals
  describe 'body' do
    it 'returns body of email' do
      @freemail['body'].should eql 'This is the body of the email.'
    end
  end
  
  describe 'sender' do
    it 'returns sender' do
      @freemail['From'].should eql 'Billy <billy@yahoo.com>'
    end
  end
  
  describe 'received' do
    it 'returns received header' do
      @freemail['Received'].should eql 'from builtbyalpha.com by n23.c09.mtsvc.net with local (Exim 4.72)
	(envelope-from <serveradmin@builtbyalpha.com>)
	id 1SmJZI-0001En-7C
	for johnathancroom@gmail.com; Wed, 04 Jul 2012 00:00:08 -0700'
    end
  end
end