require 'csv'
regex = /(?:<\w+>|<\/\w+>|","|<\\<td)(?!,)([.'a-zA-Z0-9,:\s-]+)(?:<\w+>)?[.'a-zA-Z0-9,:\s-]*/
contents = File.open("vehicle_reports.html","r") {|file| contents = file.read}
lines = contents.scan(/.*/)
lines.each do |line|
	valid_info = line.scan(regex)
	if valid_info[0] != nil 
		CSV.open("vehicle_reports.csv", "a") {|csv| csv << valid_info.flatten}
	end
end