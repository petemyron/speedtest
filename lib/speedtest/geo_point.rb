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
end
