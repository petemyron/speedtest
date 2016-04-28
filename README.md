# Speedtest
A ruby gem for speedtest.net results

Adapted from https://github.com/lacostej/speedtest.rb

## Installation
  ```ruby
    $ gem install speedtest
  ```
  or put it in your Gemfile
  ```ruby
    gem 'speedtest'
  ```
  and install with
  ```ruby
    $ bundle install
  ```

## Usage:
  require it in your script
  ```ruby
  require 'speedtest'
  ```

  get results from run()
  ```ruby
  results = Speedtest.run(true) # optional debug param, default is false
    => {:server=>"http://lg.sea-z.fdcservers.net", :latency=>32.91975, :download_rate=>33392966.409413688, :upload_rate=>4517231.51788253}
  ```

## Interesting links
* https://github.com/lacostej/speedtest.rb
* http://www.phuket-data-wizards.com/blog/2011/09/17/speedtest-vs-dslreports-analysis/
* https://github.com/fopina/pyspeedtest
* http://tech.ivkin.net/wiki/Run_Speedtest_from_command_line
