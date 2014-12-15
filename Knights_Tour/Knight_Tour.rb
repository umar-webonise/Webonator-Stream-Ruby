#DATASTRUCTURE
#GRAPH DATA STRUCTURE REPRESENTING MxM CHESSBOARD WITH LINKS TO THE SQUARES AS PER KNIGHTS MOVE 
class Graph

   def initialize
      @path = Array.new
   end

	def genarate_vertices no_rows, no_cols
		row=0
		col=0
		@vert_list = Array.new(no_rows) { Array.new(no_cols) }

		no_rows.times do
			no_cols.times do
				@vert_list[row][col] = Vertex.new(row, col, Array.new)
				col = col + 1
			end
			row = row + 1
			col = 0
		end
	end

   def genarate_links
      add_link = Proc.new do |row_substraction, col_substraction, vertex|
         row = vertex.row + row_substraction
         col = vertex.col + col_substraction
         if row >= 0 and row < @vert_list.length
            if col >= 0 and col < @vert_list[0].length
               vertex.links.push(@vert_list[row][col])
               vertex.succesors = vertex.succesors + 1
            end
         end
      end

      @vert_list.each do |vertex_row|
          vertex_row.each do |vertex|            

            add_link.call(-2, -1, vertex)
            add_link.call(-2, 1, vertex)

            add_link.call(-1, -2, vertex)
            add_link.call(-1, 2, vertex)
            
            add_link.call(1, -2, vertex)
            add_link.call(1, 2, vertex)

            add_link.call(2, -1, vertex)
            add_link.call(2, 1, vertex)            
         end
       end
   end

   def start algorithm
      algorithm.call(@vert_list[0][0], @path)
   end

   def display_path 
      puts "TOUR Taken By Knight to Cover All SQUARES of the CHESSBOARD"
      @path.each do |vertex|
         puts "(#{vertex.row}, #{vertex.col})"
      end
      check = @vert_list.length * @vert_list[0].length
      if check == @path.length
         puts "Successful with #{check} Moves"
      else
         puts "Failure with #{check} Moves"
      end

   end

end#-------------------Graph


class Vertex

	def initialize(row, col, links)
      @row = row
      @col = col
      @links = links
      @succesors = 0
      @visted = false
   end

   attr_reader :row, :col, :links, :visted, :succesors
   attr_writer :succesors , :visted

end#----------------Vertex

#ALGORITHMS
#Algorithm Based on Warnsdorff(1823) Heuristic
warnsdorff_algorithm = lambda do |current_vertex, path|
      
      current_vertex.visted = true
      path.push(current_vertex)            
      list_legal_moves = Array.new
      current_vertex.links.each do |link_vertex|#to collect list of legal moves
         link_vertex.succesors = link_vertex.succesors - 1
         if link_vertex.visted == false
            list_legal_moves.push(link_vertex)
         end
      end
      min_vertex = list_legal_moves[0]#find mininum number of successors from list of legal ones
      
      if min_vertex == nil
         return
      else
         list_legal_moves.each do |vertex|
            if vertex.succesors < min_vertex.succesors
               min_vertex = vertex
            end
         end
         warnsdorff_algorithm.call(min_vertex ,path)
      end
end#----Lambda End




graph = Graph.new

graph.genarate_vertices 8, 8

graph.genarate_links

graph.start warnsdorff_algorithm

graph.display_path
