Simple speedtest.net command line tool in ruby.

Heavily inspired by https://github.com/fopina/pyspeedtest

Usage:
=====

    $ ruby speedtest.rb
    Your IP: 171.23.129.xxx
    Your coordinates: [59.9167, 10.75]
    Automatically selected server: http://speedtest.hafslundtelekom.net - 8.60475 ms
    Server http://speedtest.hafslundtelekom.net
    Took 11.492421 seconds to download 22345012 bytes in 8 threads
    Download: 14.83 Mbps
    Took 3.301095 seconds to upload 2728856 bytes in 8 threads
    Upload: 6.31 Mbps

Interesting links
===========
* http://www.phuket-data-wizards.com/blog/2011/09/17/speedtest-vs-dslreports-analysis/
* https://github.com/fopina/pyspeedtest
* http://tech.ivkin.net/wiki/Run_Speedtest_from_command_line
=======
speedtest.rb
============

A ruby client for speedtest.net