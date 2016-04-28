require 'mechanize'
require 'nokogiri'
require 'byebug'
require 'httparty'

module Speedtest
  class GeoPoint
    attr_accessor :lat, :lon
    def initialize(lat, lon)
      @lat = Float(lat)
      @lon = Float(lon)
    end
    def to_s
      "[#{lat}, #{lon}]"
    end
    def distance(point)
      Math.sqrt((point.lon - lon)**2 + (point.lat - lat)**2)
    end
  end

  def self.time_millis(time)
    (time.to_f * 1000).to_i
  end

  DOWNLOAD_FILES = [
    'speedtest/random750x750.jpg',
    'speedtest/random1500x1500.jpg',
  ]

  UPLOAD_SIZES = [
    197190,
    483960
  ]

  DOWNLOAD_RUNS = 4
  UPLOAD_RUNS = 4
  PING_RUNS = 4

  def self.initialize(argv)
    #nothing yet
  end

  def self.run(debug = false)
  	@debug == true ? debug = true : debug = false

    @a = Mechanize.new
    @a.user_agent_alias = 'Mac Safari'
    @a.open_timeout = 1
    @a.read_timeout = 1

    server = pick_server
    @server_root = server[:url]
    log "Server #{@server_root}"

    latency = server[:latency]

    download_rate = download
    log "Download: #{pretty_speed download_rate}"

    upload_rate = upload
    log "Upload: #{pretty_speed upload_rate}"

    { server: @server_root, latency: latency, download_rate: download_rate, upload_rate: upload_rate }
  end

  def self.pretty_speed(speed)
    units = [ "bps", "Kbps", "Mbps", "Gbps"]
    idx = 0
    while speed > 1024
      speed /= 1024
      idx += 1
    end
    "%.2f #{units[idx]}" % speed
  end

  def self.log(msg)
    if @debug
      puts msg
    end
  end

  def self.downloadthread(url)
    log "url: #{url}"
    page = HTTParty.get(url)
    Thread.current["downloaded"] = page.body.length
  end

  def self.download
    threads = []

    start_time = Time.new
    DOWNLOAD_FILES.each { |f|
      1.upto(DOWNLOAD_RUNS) { |i|
        threads << Thread.new(f) { |myPage|
          msec = Speedtest::time_millis(Time.new)
          downloadthread("#{@server_root}/#{myPage}?x=#{msec}&y=#{i}")
        }
      }
    }

    total_downloaded = 0
    threads.each { |t|
      t.join
      total_downloaded += t["downloaded"]
    }

    total_time = Time.new - start_time
    log "Took #{total_time} seconds to download #{total_downloaded} bytes in #{threads.length} threads"

    total_downloaded * 8 / total_time
  end

  def self.uploadthread(url, myData)
    page = HTTParty.post(url, body: { "content": myData })
    Thread.current["uploaded"] = page.body.split('=')[1].to_i
  end

  def self.randomString(alphabet, size)
    (1.upto(size)).map {alphabet[rand(alphabet.length)] }.join
  end

  def self.upload
    data = []
    UPLOAD_SIZES.each { |size|
      1.upto(UPLOAD_RUNS) {
        data << randomString(('A'..'Z').to_a, size)
      }
    }

    threads = []
    start_time = Time.new
    threads = data.map { |data|
      Thread.new(data) { |myData|
        log "uploading size #{myData.size}: #{@server_root}/speedtest/upload.php"
        msec = Speedtest::time_millis(Time.new)
        uploadthread("#{@server_root}/speedtest/upload.php", myData)
      }
    }
    total_uploaded=0
    threads.each { |t|
      t.join
      total_uploaded += t["uploaded"]
    }
    total_time = Time.new - start_time
    log "Took #{total_time} seconds to upload #{total_uploaded} bytes in #{threads.length} threads"
    total_uploaded * 8 / total_time
  end

  def self.pick_server
    page = @a.get("http://www.speedtest.net/speedtest-config.php")
    ip,lat,lon = page.body.scan(/<client ip="([^"]*)" lat="([^"]*)" lon="([^"]*)"/)[0]
    orig = GeoPoint.new(lat, lon)
    log "Your IP: #{ip}\nYour coordinates: #{orig}\n"

    page = @a.get("http://www.speedtest.net/speedtest-servers.php")
    sorted_servers=page.body.scan(/<server url="([^"]*)" lat="([^"]*)" lon="([^"]*)/).map { |x| {
      :distance => orig.distance(GeoPoint.new(x[1],x[2])),
      :url => x[0].split(/(http:\/\/.*)\/speedtest.*/)[1]
    } }
    .reject { |x| x[:url].nil? } # reject 'servers' without a domain
    .sort_by { |x| x[:distance] }

    # sort the nearest 10 by download latency
    latency_sorted_servers = sorted_servers[0..9].map { |x|
      {
      :latency => ping(x[:url]),
      :url => x[:url]
      }}.sort_by { |x| x[:latency] }
    selected = latency_sorted_servers[0]
    log "Automatically selected server: #{selected[:url]} - #{selected[:latency]} ms"
    selected
  end

  def self.ping(server)
    times = []
    1.upto(PING_RUNS) {
      start = Time.new
      msec = Speedtest::time_millis(start)
      begin
        page = HTTParty.get("#{server}/speedtest/latency.txt?x=#{msec}")
        times << Time.new-start
      rescue Timeout::Error
        times << 999999
      rescue Net::HTTPNotFound
        times << 999999
      end
    }
    times.sort
    times[1,PING_RUNS].inject(:+) * 1000 / PING_RUNS # average in milliseconds
  end

if __FILE__ == $PROGRAM_NAME
  x = Speedtest::SpeedTest.new(ARGV)
  x.run.each { |x,y| puts "#{x} => #{y}"}
end

end
