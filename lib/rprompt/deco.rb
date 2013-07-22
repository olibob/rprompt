module Deco
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