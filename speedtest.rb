#!/usr/bin/ruby -Ilib
require 'rubygems'
require 'speedtest/speedtest'

if __FILE__ == $PROGRAM_NAME
  x = Speedtest::SpeedTest.new(ARGV)
  x.run.each { |x,y| puts "#{x} => #{y}"}
end