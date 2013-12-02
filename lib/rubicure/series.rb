module Rubicure
  class Series < Hash
    include Hashie::Extensions::MethodAccess

    def on_air?(date)
      if respond_to?(:started_date)
        if respond_to?(:ended_date)
          # ended title
          return (started_date .. ended_date).cover?(date)
        else
          # on air title
          return started_date <= date
        end
      end

      false
    end

    # @return [Array<Rubicure::Girl>]
    def girls
      response = []
      fetch(:girls).each do |info|
        response << Rubicure::Girl.new(info.deep_symbolize_keys)
      end
      response
    end
  end
end
