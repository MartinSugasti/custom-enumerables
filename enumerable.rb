module Enumerable
  def my_inject(result = nil, &block)
    return to_enum(:my_inject) unless block_given?

    if result.nil?
      result = self.first
      drop(1).my_each { |e| result = block.call(result, e) }
    else
      my_each { |e| result = block.call(result, e) }
    end

    result
  end

  def my_map(procedure = nil, &block)
    return to_enum(:my_map) if !block_given? && procedure.nil?

    result = []
    if procedure
      my_each do |k, v|
        result << procedure.call(k, v)
      end
    else
      my_each do |k, v|
        result << block.call(k, v)
      end
    end
    result
  end

  def my_count(argument = nil, &block)
    total = 0
    procedure = if block_given?
                  proc { |e| total += 1 if block.call(e) }
                elsif argument
                  proc { |e| total += 1 if argument === e }
                else
                  return length
                end

    my_each { |e| procedure.call(e) }
    total
  end

  def my_none?(pattern = nil, &block)
    procedure = if block_given?
                  proc { |e| return false if block.call(e) }
                elsif pattern
                  proc { |e| return false if pattern === e }
                else
                  proc { |e| return false if e }
                end

    my_each { |e| procedure.call(e) }
    true
  end

  def my_any?(pattern = nil, &block)
    procedure = if block_given?
                  proc { |e| return true if block.call(e) }
                elsif pattern
                  proc { |e| return true if pattern === e }
                else
                  proc { |e| return true if e }
                end

    my_each { |e| procedure.call(e) }
    false
  end

  def my_all?(pattern = nil, &block)
    procedure = if block_given?
                  proc { |e| return false unless block.call(e) }
                elsif pattern
                  proc { |e| return false unless pattern === e }
                else
                  proc { |e| return false unless e }
                end

    my_each { |e| procedure.call(e) }
    true
  end

  def my_select(&block)
    return to_enum(:my_select) unless block_given?

    if self.is_a?(Hash)
      result = {}
      my_each { |k, v| result[k] = v if block.call(k, v) }
    else
      result = []
      my_each { |e| result << e if block.call(e) }
    end

    result
  end

  def my_each_with_index(&block)
    return to_enum(:my_each_with_index) unless block_given?

    for i in 0..(self.length - 1)
      block.call(self[i], i)
    end
    self
  end

  def my_each(&block)
    return to_enum(:my_each) unless block_given?

    for k, v in self
      block.call(k, v)
    end
    self
  end
end
