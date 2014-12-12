class Graph

	def genarate_vertices no_rows, no_cols
		row=0
		col=0
		@vertList = Array.new
		no_rows.times do

			no_cols.times do
				@vertList.push(Vertex.new(row, col, Array.new))
				col = col + 1
			end

			row = row + 1
			col = 0
		end
	end

	def display
		@vertList.each do |vertex|
			puts "row=#{vertex.row} col=#{vertex.col} links=#{vertex.links} visted?=#{vertex.visted}"
		end
	end

	def genarate_links

	end

end

class Vertex
	def initialize(row, col, links)
      @row = row
      @col = col
      @links = links
      @visted = false
   end

   attr_reader :row, :col, :links, :visted
   attr_writer :links, :visted

   #def get_row
   #		@row
   #end

   #def get_col
   #		@col	
   #end

   #def get_links
   #		@links
   #end

   #def get_visted
   #		@visted
   #end

   #def set_links
   
   #end

   #def set_visted
   #		@visted = true
   #end


end

graph = Graph.new

graph.genarate_vertices 5, 5

graph.display



puts "No ERROS"






