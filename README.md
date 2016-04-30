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

Configure a new test with whatever options you want&mdash;all are optional:
* download_runs - The number of attempts to download each file
* upload_runs - The number of attempts to upload each file
* ping_runs - The number of ping attempts to establish latency
* download_sizes - an array of .jpg dimensions (must be one or more of `[350, 500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000]`)
* upload_sizes
* debug

```ruby
test = Speedtest::Test.new(
  download_runs: 4,
    upload_runs: 4,
    ping_runs: 4,
    download_sizes: [750, 1500],
    upload_sizes: [10000, 400000],
    debug: true
 )
 => #<Speedtest::Test:0x007fac5ac9dca0 @download_runs=4, @upload_runs=4, @ping_runs=4, @download_sizes=[750, 1500], @upload_sizes=[10000, 400000], @debug=true>
```

test.run() returns some results:
```ruby
results = test.run
```
With debug set to true, this produces:
```ruby
Your IP: 97.126.32.16
Your coordinates: [47.4356, -122.1141]
Automatically selected server: http://lg.sea-z.fdcservers.net - 32.985 ms
Server http://lg.sea-z.fdcservers.net

starting download tests:
  downloading: http://lg.sea-z.fdcservers.net/speedtest/random1500x1500.jpg
  downloading: http://lg.sea-z.fdcservers.net/speedtest/random750x750.jpg
  downloading: http://lg.sea-z.fdcservers.net/speedtest/random1500x1500.jpg
  downloading: http://lg.sea-z.fdcservers.net/speedtest/random750x750.jpg
  downloading: http://lg.sea-z.fdcservers.net/speedtest/random750x750.jpg
  downloading: http://lg.sea-z.fdcservers.net/speedtest/random750x750.jpg
  downloading: http://lg.sea-z.fdcservers.net/speedtest/random1500x1500.jpg
  downloading: http://lg.sea-z.fdcservers.net/speedtest/random1500x1500.jpg
Took 6.10022 seconds to download 22345012 bytes in 8 threads
Download: 27.95 Mbps

starting upload tests:
  uploading size 10000: http://lg.sea-z.fdcservers.net/speedtest/upload.php
  uploading size 10000: http://lg.sea-z.fdcservers.net/speedtest/upload.php
  uploading size 10000: http://lg.sea-z.fdcservers.net/speedtest/upload.php
  uploading size 10000: http://lg.sea-z.fdcservers.net/speedtest/upload.php
  uploading size 400000: http://lg.sea-z.fdcservers.net/speedtest/upload.php
  uploading size 400000: http://lg.sea-z.fdcservers.net/speedtest/upload.php
  uploading size 400000: http://lg.sea-z.fdcservers.net/speedtest/upload.php
  uploading size 400000: http://lg.sea-z.fdcservers.net/speedtest/upload.php
Took 3.437126 seconds to upload 1644080 bytes in 8 threads
Upload: 3.65 Mbps

  => #<Speedtest::Result:0x007fac5ac1e680 @server="http://lg.sea-z.fdcservers.net", @latency=32.985, @download_rate=29303876.909357365, @upload_rate=3826638.883765099, @pretty_download_rate="27.95 Mbps", @pretty_upload_rate="3.65 Mbps">
```

## Interesting links
* https://github.com/lacostej/speedtest.rb
* http://www.phuket-data-wizards.com/blog/2011/09/17/speedtest-vs-dslreports-analysis/
* https://github.com/fopina/pyspeedtest
* http://tech.ivkin.net/wiki/Run_Speedtest_from_command_line
