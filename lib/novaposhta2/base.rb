module Novaposhta2
  class Base # :nodoc:
    include Post

    private

    def config
      Novaposhta2.configuration
    end
  end
end