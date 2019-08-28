module LaserMaze
  class App
    attr_accessor :input_file, :output_file

    def initialize(input_file = ARGV[0], output_file = ARGV[1])
      raise FileNotFoundException if input_file.nil? || output_file.nil?

      @input_file = input_file
      @output_file = output_file

      validate_input_and_output_files

      parser = LaserMaze::Parser
      parser.parse_input_file(@input_file)
      @maze = LaserMaze::Maze.new(parser.maze_x, parser.maze_y)
      place_mirrors_in_maze(parser.mirrors)
      @beam = LaserMaze::Beam.new(parser.current_x, parser.current_y, parser.current_direction, @maze)
    end

    def run
      while @beam.in_grid_bounds? && !@beam.hit_the_walls?
        break if @beam.in_loop
        @beam.traverse_next_square
      end
      write_output
    end

    private

    def validate_input_and_output_files
      raise FileNotFoundException unless File.file?(@input_file) && File.file?(@output_file)
    end

    def place_mirrors_in_maze(mirrors)
      mirrors.each do |mirror|
        @maze.grid[mirror.y][mirror.x] = mirror.type
      end
    end

    def write_output
      File.open(@output_file, 'w+') do |f|
        if @beam.in_loop
          f.puts '-1'
        else
          f.puts @beam.traversed_squares.count
          f.puts "#{@beam.current_x} #{@beam.current_y}"
        end
      end
    end
  end
end