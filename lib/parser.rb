module LaserMaze
  class Parser
    class << self
      attr_accessor :mirrors, :maze_x, :maze_y, :current_x, :current_y, :current_direction

      def parse_input_file(input_file)
        @mirrors = []
        File.open(input_file).map(&:chomp).each_with_index do |line, index|
          l = line.split(' ')
          if index.zero?
            @maze_x, = l[0].to_i
            @maze_y = l[1].to_i
          elsif index == 1
            @current_x = l[0].to_i
            @current_y = l[1].to_i
            @current_direction = l[2].to_sym
          else
            build_mirrors(l)
          end
        end
      end

      def build_mirrors(line)
        @mirrors << LaserMaze::Mirror.new(line[0].to_i, line[1].to_i, line[2])
      end
    end
  end
end
