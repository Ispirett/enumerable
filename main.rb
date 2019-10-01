module Enumerable
    def my_each
        begin
            i = 0
            while i < self.size
                yield (self[i])
                i += 1
            end
            self
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end

    def my_each_with_index
        begin
            i = 0
            while i < self.size
                yield(self[i], i)
                i += 1
                self
            end
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end

    def my_select
        begin
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
          end
        rescue => e
            puts "Exception Class: #{e.class.name}"
      end
    end

    def my_none?
        begin
          result = true
          self.my_each do |item|
              if yield(item)
                  result = false
                  break
              end
          end
          result
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

    def my_inject(sum = nil)
        i = 1

        begin
            if sum.nil?
                sum = + self[0]
            end

            while i < self.size
                sum = yield(sum, self[i])
                i += 1
            end
            sum
        rescue => e
            puts "Exception Class: #{e.class.name}"
        end
    end
end

def multiply_els(array)
    array.my_inject { |product, item| product * item }
end

my_array = [1, 2, 4, 2]
puts multiply_els(my_array)
