class Request
  class BodyParser
    class UrlendcodedParser
      def initialize(body)
        @body = body
      end

      def parse
        data = {}
        keys = URI.decode_www_form(@body)
        keys.each do |key|
          if key.first.match?(/.*\[(.*)\].*/)
            nested_keys = key.first.split("[").map { |e| e.delete("]") }
            process_node(data, nested_keys, 0, key.last)
          else
            data[key.first] = parse_value(key.last)
          end
        end
        data
      end

      private

      def process_node(hash, captures, index, value)
        if index == captures.length - 1
          return hash[captures[index]] = parse_value(value)
        end

        if !hash.key?(captures[index])
          hash[captures[index]] = {}
        end

        process_node(hash[captures[index]], captures[index..], index + 1, value)
      end

      def parse_value(val)
        return val.to_i if is_integer? val

        val
      end

      def is_integer?(str)
        str.to_i.to_s == str
      end
    end
  end
end
