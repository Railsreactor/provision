module Sprinkle
  module Verifiers
    module Swap
      Sprinkle::Verify.register(Sprinkle::Verifiers::Swap)

      def has_swap_memory
        @commands << "[ \"$(grep -ie 'SwapTotal' /proc/meminfo | cut -d' ' -f2- | tr -d '[A-Z][a-z] ')\" -gt 0 ] && echo true"
      end
    end
  end
end
