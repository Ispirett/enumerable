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

    def my_all?
        self.my_each { |item| eturnr false if yield(item) == false }
        true
    end

    def my_any?
        self.my_each { |item| return true if yield(item) }
        false
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

    def my_map(&proc)
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
    end

    def my_inject
        i = 1
        sum = self[0]
        while i < self.size
            sum = yield(sum, self[i])
            i += 1
        end
        sum
    end
end

def multiply_els(array)
    array.my_inject { |product, item| product * item }
end

my_array = [1, 2, 4, 2]
puts multiply_els(my_array)
