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

#Testing
Tests are written in Rspec in the tests directory and can be tested by running `bundle exec rspec tests` assuming you already setup.

#Todo
1. Add support for emails with multiple MIME types.
2. <del>Fix case issue with freemail hash (`@freemail["from"]` and `@freemail["From"]` should return the same value).</del>
3. Test parser with different emails and email clients in order to ensure it works in all situations.

#Contributing
Write tests, research, code, communicate, and have fun!