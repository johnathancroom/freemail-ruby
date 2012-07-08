#Freemail
Freemail is an email parser written in Ruby.

#Getting Setup
1. Clone the repo and `cd` into it.
2. Make sure Ruby and Bundler are installed.
3. Run `bundle install` (or just `bundle`) to install the required gems.

#Running the Example
1. First, follow the steps in the Getting Setup section.
2. Run `bundle exec ruby example/server.rb`
3. View [localhost:4567](//localhost:4567) in your browser.

#Basic Usage
For a full example, see [the example directory](https://github.com/johnathancroom/freemail-ruby/tree/master/example).

`raw_email.txt`
```
Date: Wed, 04 Jul 2012 00:00:08 -0700
To: johnathancroom@gmail.com
Subject: Check this out!
From:Billy <billy@yahoo.com>

This is the message body!
```

`file.rb`
```ruby
require 'freemail'
freemail = Freemail.parse(File.read('raw_email.txt'))
# { "Date" => "Wed, 04 Jul 2012 00:00:08 -0700", "To" => "johnathancroom@gmail.com", "Subject" => "Check this out!", "From" => "Billy <billy@yahoo.com>", "body" => "This is the message body!" }
```

#Understanding the Freemail hash
The hash that gets returned is simply an associative array with the headers as the keys connecting to the header values.

The only exception is `@freemail['body']` and `@freemail['body_html']` which are automatically added depending on the content-type of your email. An HTML-only email will contain just a `body_html` key, and a plain-text email will contain just a `body` key. Multipart emails contain both keys.

```ruby
# Example Returned hash
{
  "Date"      => "Wed, 04 Jul 2012 00:00:08 -0700",
  "To"        => "johnathancroom@gmail.com",
  "Subject"   => "Check this out!",
  "From"      => "Billy <billy@yahoo.com>",
  "body"      => "Hello!\n\nThis is the message body!",
  "body_html" => "<h1>Hello!</h1> <div>This is the message body!</div>"
}
```
Here's an example that returns the HTML email if it's available and the plain text as a fallback.
```ruby
if !@freemail['body_html'].nil?
  @freemail['body_html']
else
  @freemail['body']
end
```

#Testing
Tests are written in Rspec in the tests directory and can be tested by running `bundle exec rspec tests` assuming you already setup.

#Todo
1. <del>Add support for emails with multiple MIME types.</del> Added in 8347d10dd4690cf0c6a6b2159784a0efb2a91079.
2. <del>Fix case issue with freemail hash (`@freemail["from"]` and `@freemail["From"]` should return the same value).</del> Fixed in b09d26f279f90cbc55d7aa84b30718f763757c76.
4. <del>Add support for HTML-only emails (non-multipart).</del> Added in 8347d10dd4690cf0c6a6b2159784a0efb2a91079.
3. Test parser with more emails and email clients in order to ensure it works in all situations.

#Contributing
Write tests, research, code, communicate, and have fun!