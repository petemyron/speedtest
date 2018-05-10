module Speedtest
  class Result
    attr_accessor :server, :latency, :download_size, :upload_size, :download_time, :upload_time

    def initialize(values = {})
      @server = values[:server]
      @latency = values[:latency]
      @download_size = values[:download_size]
      @upload_size = values[:upload_size]
      @download_time = values[:download_time]
      @upload_time = values[:upload_time]
    end
  end
end
