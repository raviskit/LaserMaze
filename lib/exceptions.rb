module LaserMaze

  class FileNotFoundException < RuntimeError
    def message
      'Missing path or file name'
    end
  end

  class InvalidGridCoOrdinatesException < RuntimeError
    def message
      'Grid coordinates should be between 1 * 1 to 1000 * 1000'
    end
  end

  class InvalidCoOrdinatesException < RuntimeError
    def message
      'Coordinates should be between within grid bounds'
    end
  end

  class InvalidDirectionException < RuntimeError
    def message
      'Direction must be N S E W'
    end
  end
end