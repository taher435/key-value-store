require "redis"

class Store

  attr_accessor :redis_client

  def initialize
    @redis_client = Redis.new(:url => Rails.application.config.redis_url)
  end


  def add(key, value)
    value_object = {value: value, ts: Time.now.utc.to_i}
    key_value = @redis_client.get(key)

    if key_value.present?
      key_value = JSON.parse(key_value)
      key_value << value_object
    else
      key_value = [value_object]
    end

    @redis_client.set(key, key_value.to_json)

    key_value
  end

  def get(key, timestamp = nil)
    key_value = @redis_client.get(key)

    result_object = nil

    if key_value.present?
      key_value = JSON.parse(key_value)
      if timestamp.present?
        timestamp = timestamp.to_i
        result_object = key_value.find {|kv| kv["ts"] == timestamp} #first check if we can find exact match

        if result_object.nil?
          #now we will attempt to find the entry created just before the given time
          previous_objects = key_value.select{ |kv| kv["ts"] < timestamp }

          if previous_objects.present? && previous_objects.length > 0
            result_object = previous_objects.pop #get the most recent before the given time
          end
        end
      else
        result_object = key_value.pop
      end
    end

    result_object
  end

  def remove(key)
    @redis_client.del(key)
  end
end