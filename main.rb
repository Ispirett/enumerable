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
            if value == nil && !block_given?
                self.each { |item| return false unless item }
                true
            elsif value && !block_given?
                self.each { |item| return false unless item == value }
                true
            elsif value == nil && block_given?
                self.each { |item| return false unless yield(item) }
                true
            elsif value.class == Class
                my_each { |item| return false unless item.class == value }
            elsif value.class == Regexp
            end
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end

    def my_any?(value = nil)
        begin
          if value == nil && !block_given?
              self.each { |item| return true if item }
              false
          elsif value && !block_given?
              self.each { |item| return true if item == value }
              false
          elsif value == nil && block_given?
              self.each { |item| return true if yield(item) }
              false
          elsif value.class == Class
              my_each { |item| return true if item.class == value }
          elsif value.class == Regexp
              my_each { |item| return true if item =~ value }
          end
        rescue => e
            puts "Exception Class: #{e.class.name}"
      end
    end

    def my_none?(pattern = nil, &block)
        begin
          !my_any?(pattern, &block)
        rescue => e
            puts "Exception Class: #{e.class.name}"
      end
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

    def my_inject(arg1 = nil, arg2 = nil)
        begin
            new_self = is_a?(Range) ? to_a : self
            accumulator = (arg1.nil? || arg1.is_a?(Symbol)) ? new_self[0] : arg1
            new_self[0..-1].my_each { |item| accumulator = yield(accumulator, item) } if block_given? && arg1
            new_self[1..-1].my_each { |item| accumulator = yield(accumulator, item) } if block_given? && !arg1
            new_self[1..-1].my_each { |i| accumulator = accumulator.send(arg1, i) } if arg1.is_a?(Symbol)
            new_self[0..-1].my_each { |i| accumulator = accumulator.send(arg2, i) } if arg2
            accumulator
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end
end

def multiply_els
    my_inject(1) { |total, item| total * item }
end

my_array = [1, 2, 4, 2]
puts multiply_els(my_array)
