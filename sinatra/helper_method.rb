require 'securerandom'

class Helper
  
  attr_accessor :keys, :available_keys, :blocked_keys

  def initialize
    @keys = {}
    @available_keys = []
    @blocked_keys = {}

    Thread.new do
      while true do
        sleep 0.1
        reset
      end
    end
  end

  def generate_key 
    key = SecureRandom.alphanumeric(10)
    @available_keys.push(key)
    @keys[key] = Time.now + 5*60
    key
  end

  def get_available_key
    result = nil
    @available_keys.each do |key|
      result = key
      @blocked_keys[result] = Time.now + 60
      break
    end
    @available_keys.delete(result)
    result
  end

  def unblock_key(key)
    result = nil
    if @blocked_keys.include?(key)
      @blocked_keys.delete(key)
      @available_keys.push(key)
      result = key
    end
    result
  end

  def delete_key(key)
    result = nil
    @keys.delete(key)
    if @available_keys.include?(key)
      @available_keys.delete(key)
      result = key
    elsif @blocked_keys.include?(key)
      @blocked_keys.delete(key)
      result = key
    end
    result
  end

  def keep_alive(key)
    result = nil
    if @keys.include?(key)
      @keys[key] = Time.now + 5*60
      result = key
    end
    result
  end

  def reset
    current_time = Time.now
    @keys.each do |key, time|
      if time < current_time
        @available_keys.delete(key)
        @keys.delete(key)
      end
    end
    @blocked_keys.each do |key, time|
      if time < current_time
        @blocked_keys.delete(key)
        @available_keys.push(key)
      end
    end
  end
end


