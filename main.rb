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
end
