module Errors
  class IncorrectFile < StandardError
    def initialize(msg = 'Please provide a correct file!')
      super
    end
  end

  class MissingImage < StandardError
    def initialize(msg = 'Bitmap image missing!')
      super
    end
  end

  class InvalidObject < StandardError
    def initialize(msg = 'Non-bitmap object!')
      super
    end
  end

  class InvalidType < StandardError
    def initialize(given, expected)
      super("Invalid type of arguments (#{given} given, #{expected} expected)")
    end
  end

  class InvalidColor < StandardError
    def initialize(given)
      super("Invalid color specified. (\'#{given}\' given, capital letters expected)")
    end
  end

  class OutOfRange < StandardError
    def initialize(msg = "Bitmap size invalid. Provide col and row number between 1 and 250")
      super
    end
  end
end