# KNIGHTS TOUR PROBLEM SOLUTION

# DATASTRUCTURE
# GRAPH DATA STRUCTURE REPRESENTING MxM CHESSBOARD
# LINKS TO THE SQUARES AS PER KNIGHTS MOVE
# Graph contents links
class Graph
  def initialize
    @path = []
  end
  # Values required to be added with current node so as to Generate next move
  MOVES_MANU = [
    { row: -2, col: -1 },
    { row: -2, col: 1 },
    { row: -1, col: -2 },
    { row: -1, col: 2 },
    { row: 1, col: -2 },
    { row: 1, col: 2 },
    { row: 2, col: -1 },
    { row: 2, col: 1 }
  ]

  def genarate_vertices(no_rows, no_cols)
    row, col = 0, 0
    @vert_list = Array.new(no_rows) { Array.new(no_cols) }
    no_rows.times do
      no_cols.times do
        @vert_list[row][col] = Vertex.new(row, col, Array.new)
        col += 1
      end
      row += 1
      col = 0
    end
  end

  def genarate_links
    @vert_list.each do |vertex_row|
      vertex_row.each do |vertex|
        MOVES_MANU.each do |move_manu|
          row = vertex.row + move_manu[:row]
          col = vertex.col + move_manu[:col]
          if row >= 0 && row < @vert_list.length && \
             col >= 0 && col < @vert_list[0].length
            vertex.links.push(@vert_list[row][col])
            vertex.succesors += 1
          end
          next
        end
      end
    end
  end

  def start(algorithm)
    algorithm.call(@vert_list[0][0], @path)
  end

  def display_path
    puts 'TOUR Taken By Knight to Cover All SQUARES of the CHESSBOARD'
    @path.each do |vertex|
      puts "(#{vertex.row}, #{vertex.col})"
    end
    check = @vert_list.length * @vert_list[0].length
    if check == @path.length
      puts "Successful with #{check} Moves"
    else
      puts "Failure with #{@path.length} Moves"
    end
  end
end # -------------------Graph

# Vertex class
class Vertex
  def initialize(row, col, links)
    @row = row
    @col = col
    @links = links
    @succesors = 0
    @visted = false
  end

  attr_reader :row, :col, :links
  attr_accessor :succesors, :visted
end # ----------------Vertex

# ALGORITHMS
# Algorithm Based on Warnsdorff(1823) Heuristic
warnsdorff_algorithm = lambda do |current_vertex, path|
  current_vertex.visted = true
  path.push(current_vertex)
  list_legal_moves = Array.new
  current_vertex.links.each do |link_vertex| # to collect list of legal moves
    link_vertex.succesors -= 1
    list_legal_moves.push(link_vertex) unless link_vertex.visted
  end
  # find mininum number of successors from list of legal ones
  min_vertex = list_legal_moves[0]
  if min_vertex.nil?
    return
  else
    list_legal_moves.each do |vertex|
      min_vertex = vertex if vertex.succesors < min_vertex.succesors
    end
    warnsdorff_algorithm.call(min_vertex, path)
  end
end # ----Lambda End

graph = Graph.new

graph.genarate_vertices 5, 5

graph.genarate_links

graph.start(warnsdorff_algorithm)

graph.display_path
