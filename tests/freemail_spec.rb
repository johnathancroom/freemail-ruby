require_relative '../lib/freemail'

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
      @freemail['body'].should eql "This is the body of the email.\n\nMultiline? I think yes!\n\nhttp://google.com\n\nSincerely,\nJohn"
    end
  end
  
  describe 'sender' do
    it 'returns sender' do
      @freemail['From'].should eql 'Billy <billy@yahoo.com>'
    end
  end
  
  describe 'received' do
    it 'returns received header' do
      @freemail['Received'].should eql "from builtbyalpha.com by n23.c09.mtsvc.net with local (Exim 4.72)\n\t(envelope-from <serveradmin@builtbyalpha.com>)\n\tid 1SmJZI-0001En-7C\n\tfor johnathancroom@gmail.com; Wed, 04 Jul 2012 00:00:08 -0700"
    end
  end
end