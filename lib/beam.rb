module LaserMaze
  class Beam
    FORWARD_DIRECTION_CHANGE = { E: :N, N: :E, S: :W, W: :S }
    BACKWARD_DIRECTION_CHANGE = { W: :N, N: :W, S: :E, E: :S }
    
    attr_accessor :current_x, :current_y, :current_direction, :maze, :traversed_squares, :in_loop

    def initialize(x, y, direction, maze)
      raise InvalidCoOrdinatesException unless (0..maze.width - 1).cover?(x) && (0..maze.height - 1).cover?(y)
      raise InvalidDirectionException unless [:N, :W, :S, :E].include?(direction)

      @current_x = x
      @current_y = y
      @current_direction = direction
      @maze = maze
      @traversed_squares = []
      @in_loop = false
    end

    def in_grid_bounds?
      (0..@maze.width - 1).cover?(@current_x)  && (0..@maze.height - 1).cover?(@current_y)
    end

    def traverse_next_square
      traverse_in_current_direction
      update_direction
      if !@traversed_squares.include? [current_x, current_y, current_direction]
        @traversed_squares << [current_x, current_y, current_direction]
      else
        @in_loop = true
      end
    end

    def traverse_in_current_direction
      case @current_direction
      when :N
        @current_y += 1
      when :E
        @current_x += 1
      when :S
        @current_y -= 1
      when :W
        @current_x -= 1
      end
    end

    def hit_the_walls?
      return true if (@current_x == 0 && @current_direction == :W) || (@current_x == @maze.width - 1 && @current_direction == :E)
      return true if (@current_y == 0 && @current_direction == :S) || (@current_y == @maze.height - 1 && @current_direction == :N)

      false
    end

    def update_direction
      return if @maze.empty_square?(@current_x, @current_y)

      @current_direction = FORWARD_DIRECTION_CHANGE[@current_direction] if @maze.forward_mirror?(@current_x, @current_y)
      @current_direction = BACKWARD_DIRECTION_CHANGE[@current_direction] if @maze.backward_mirror?(@current_x, @current_y)
    end
  end
end