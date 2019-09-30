# frozen_string_literal: true

module Enumerable
    def my_each
        i = 0
        while i < self.size
            yield (self[i])
            i += 1
        end
        self
    end

    def my_each_with_index
        i = 0
        while i < self.size
            yield(self[i], i)
            i += 1
            self
        end
    end

    def my_select
        result = []
        self.my_each { |item| result.push(item) if yield(item) }
        result
    end

    def my_any?
        self.my_each { |item| return true if yield(item) }
    end

    def my_none?
        result = true
        self.my_each do |item|
            if yield(item)
                result = false
                break
            end
        end
        result
    end

    def my_count
        count = 0
        if block_given?
            self.my_each { |item| count += 1 if yield(item) }
        else
            count = self.size
        end
        count
    end
end

my_array = [1, 2, 4, 2]
puts my_array.my_count
