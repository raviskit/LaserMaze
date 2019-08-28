module LaserMaze
  class Mirror
    attr_accessor :x, :y, :type

    def initialize(x, y, type)
      @x = x
      @y = y
      @type = type
    end
  end
end