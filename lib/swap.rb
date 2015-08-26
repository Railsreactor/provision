module Sprinkle
  module Verifiers
    module Swap
      Sprinkle::Verify.register(Sprinkle::Verifiers::Swap)

      def has_swap_memory(size)
        @commands << "[ $(free -g | grep -oP '(Swap:)(\\s*)(\\d)' | grep -Po '\\d') -eq #{size} ]"
      end
    end
  end
end
