module Deco
	# @param args [Hash]
	# 	- :color: color [String]
	# 	- :symbol: character [String]
	# 	- :content: content [String]
	# @return [String] colorized content string and symbol according to configuration
	def termShow(args)
		color = args[:color]
		symbol = args[:symbol]
		content = args[:content]

		if color
				if symbol
					"#{symbol}#{content}".send(color)
				else
					"#{content}".send(color)
				end
			else
				if symbol
					"#{symbol}#{content}"
				else
					"#{content}"
				end
			end
	end
end