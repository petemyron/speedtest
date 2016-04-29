module Speedtest
  class Result
    attr_accessor :server, :latency, :download_rate, :upload_rate
    def initialize(values = {})
      @server = values[:server] rescue nil
      @latency = values[:latency] rescue nil
      @download_rate = values[:download_rate] rescue nil
      @upload_rate = values[:upload_rate] rescue nil
    end
  end
end
