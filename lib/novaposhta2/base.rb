module Novaposhta2
  class Base
    include Post

    def config
      Novaposhta2.configuration
    end
  end
end