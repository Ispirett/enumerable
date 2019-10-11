module Enumerable
    def my_each
        begin
            return to_enum unless block_given?

            i = 0
            if block_given?
                while i < self.size
                    yield (self[i])
                    i += 1
                end
                self
            end
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end

    def my_each_with_index
        begin
            return to_enum unless block_given?

            i = 0
            if block_given?
                while i < self.size
                    yield(self[i], i)
                    i += 1
                    self
                end
            end
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end

    def my_select
        begin
            return to_enum unless block_given?

            result = []
            self.my_each { |item| result.push(item) if yield(item) }
            result
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end

    def my_all?(value = nil)
        begin
            if block_given?
                self.each { |item| return false unless yield(item) }
            elsif value.class == Class
                self.each { |item| return false unless item.class == value }
            elsif value.class == Regexp
                self.each { |item| return false if (item =~ value).nil? }
            elsif !value.nil?
                self.each { |item| return false unless item == value }
            elsif value.nil?
                self.each { |item| return false unless item }
            end
            true
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end

    def my_any?(value = nil)
        begin
            if block_given?
                self.each { |item| return true if yield(item) }
            elsif value.class == Class
                self.each { |item| return true if item.class == value }
            elsif value.class == Regexp
                self.each { |item| return true if item =~ value }
            elsif value.nil?
                self.each { |item| return true if item }
            else
                self.each { |item| return true if item == value }
            end
            false
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end

    def my_none?(value = nil)
        if block_given?
            self.each { |item| return false if yield(item) }
        elsif value.class == Class
            self.each { |item| return false if item.class == value }
        elsif value.class == Regexp
            self.each { |item| return false if item =~ value }
        elsif value.nil?
            self.each { |item| return false if item }
        else
            self.each { |item| return false if item == value }
        end
        true
    end

    def my_count(value = nil)
        begin
          count = 0

          if value == nil && !block_given?
              count = self.size
          elsif value && !block_given?
              self.each { |item| count += 1 if item == value }

          elsif value == nil && block_given?
              self.my_each { |item| count += 1 if yield(item) }
          end

          count
        rescue => e
            puts "Exception Class: #{e.class.name}"
      end
    end

    def my_map(&proc)
        begin
          return self.to_enum unless block_given?

          new_array = []
          if self.class == Hash
              self.each do |k, v|
                  new_array << proc.call(k, v)
              end
              new_array
          else
              self.my_each do |x|
                  new_array << proc.call(x)
              end
              new_array
          end
        rescue => e
            puts "Exception Class: #{e.class.name}"
      end
    end

    def my_inject(accumulator = nil, symbol = nil)
        begin
            array = to_a
            if !accumulator.nil? && !symbol.nil?
                array.my_each { |num| accumulator = accumulator.method(symbol).call(num) }
                accumulator
            elsif !accumulator.nil? && accumulator.is_a?(Symbol) && symbol.nil?
                new_arr = clone.to_a
                memo = new_arr.shift
                new_arr.my_each { |num| memo = memo.method(accumulator).call(num) }
                memo
            elsif !accumulator.nil? && accumulator.is_a?(Integer) && symbol.nil?
                array.my_each { |num| accumulator = yield(accumulator, num) }
                accumulator
            elsif accumulator.nil? && symbol.nil?
                new_arr = clone.to_a
                accumulator = new_arr.shift
                new_arr.my_each { |num| accumulator = yield(accumulator, num) }
                accumulator
            end
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end
end

def multiply_els(array)
    array.my_inject { |product, value| p product * value }
end

my_array = [1, 2, 4, 2]
puts multiply_els(my_array)
