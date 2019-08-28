module LaserMaze
  class Maze
    attr_accessor :grid
    attr_reader :width, :height

    def initialize(x, y)
      @width = x
      @height = y
      build_grid(x, y)
    end

    def empty_square?(x, y)
      @grid[y][x] == :empty
    end

    def forward_mirror?(x, y)
      @grid[y][x] == '/'
    end

    def backward_mirror?(x, y)
      @grid[y][x] == '\\'
    end

    private

    def build_grid(width, height)
      raise InvalidGridCoOrdinatesException unless (1..1000).cover?(width) && (1..1000).cover?(height)

      @grid = Array.new(height) { |i|  Array.new(width) { :empty } }
    end

  end
end
