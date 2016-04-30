module Speedtest
  class Result
    attr_accessor :server, :latency, :download_rate, :pretty_download_rate, :upload_rate, :pretty_upload_rate
    def initialize(values = {})
      @server = values[:server] rescue nil
      @latency = values[:latency] rescue nil
      @download_rate = values[:download_rate] rescue nil
      @upload_rate = values[:upload_rate] rescue nil
      @pretty_download_rate = values[:pretty_download_rate] rescue nil
      @pretty_upload_rate = values[:pretty_upload_rate] rescue nil
    end
  end
end
