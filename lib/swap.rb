module Sprinkle
  module Verifiers
    module Swap
      Sprinkle::Verify.register(Sprinkle::Verifiers::Swap)

      def has_swap_memory(size)
        @commands << "[ $(swapon -s | grep -oP '[0-9]+' | head -n 1) -gt #{size - 1025} -a $(swapon -s | grep -oP '[0-9]+' | head -n 1) -lt #{size + 1025} ]"
      end
    end
  end
end
