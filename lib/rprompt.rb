require "rprompt/version"

module Rprompt
	class TerminalColors
		# initializes terminal colors
		# @param colorConfig [Hash] hash containing color names and color codes
		def initialize(colorConfig)
			@config = colorConfig
		end

		# gets color code
		# @param name [Symbol] color name
		# @return [String] color code
		def color(name)
			@config[name]
		end
	end

	class PromptItem
		# @return [String] symbol character to identify prompt item
		attr_reader :symbol

		# @param config [Hash] Prompt item configuration:
		# 	- :cmd => shell command
		# 	- :symbol => character
		# 	- :color => color name
		# @param [TerminalColors]
		def initialize(config, termColors = nil)
			@cmd        = config[:cmd]
			@symbol     = config[:symbol]
			@color      = config[:color]
			@termColors = termColors
		end

		# executes prompt item command
		# @return [String] command result
		def commandResult
			%x(#{@cmd} 2> /dev/null)
		end

		# @return [String] terminal compliant color code
		def termColor
			if @color
				@termColors.nil? ? '' : @termColors.color(@color.to_sym)
			end
		end

		# @return [String] terminal reset color code
		def resetColor
			'\[\033[0m\]'
		end
	end

	class GitNumbers < PromptItem
		# @return [Integer] number of files returned by a git command
		def numberOfFiles
			commandResult.split(/\r?\n/).count
		end

		# @return [String] terminal representation of the number of files
		def show
			if termColor
				numberOfFiles != 0 ? "#{termColor}#{symbol}#{numberOfFiles}#{resetColor}" : ""
			else
				numberOfFiles != 0 ? "#{symbol}#{numberOfFiles}" : ""
			end
		end
	end

	class GitBranch < PromptItem
		# @return [String] branch name
		def shortBranchName
			commandResult.chomp.split('/').last
		end

		# @return [String] terminal representation of the branch name
		def show
			if termColor
				"#{termColor}#{symbol}#{shortBranchName}#{resetColor}"
			else
				"#{symbol}#{shortBranchName}"
			end
		end
	end

	class GitSha < PromptItem
		# @return [String] last five numbers form the sha1
		def sha
			commandResult.chomp[-5,5]
		end

		# @return [String] terminal representation of the number returned by 'sha'
		def show
			if termColor
				"#{termColor}#{symbol}#{sha}#{resetColor}"
			else
				"#{symbol}#{sha}"
			end
		end
	end

	class GitTrack < PromptItem
		# @param (see PromptItem#initialize)
		# @param [Symbol] state ("ahead" or "behind")
		def initialize(config, termColors, state)
			@state = state
			super(config, termColors)
		end

		# @return [Integer] number of commits ahead or behind remote
		# @note works only if remote branch is tracked
		def count
			commandResult.match(/#{@state}\s+([0-9]+)/)
			$1.to_i
		end

		# @return [String] terminal representation of the tracking
		def show
			count != 0 ? "#{termColor}#{symbol}#{count}#{resetColor}" : ""
		end
	end

	class RvmRuby < PromptItem
		# @return [String] ruby used
		def ruby
			text = commandResult.chomp
			if text.include?('@')
				text.match(/ruby-(.+)@/)[1]
			else
				text.gsub!(/ruby-/, '')
			end
		end

		# @return [String] terminal representation of the ruby version
		def show
			if termColor
				"#{termColor}#{symbol}#{ruby}#{resetColor}"
			else
				"#{symbol}#{ruby}"
			end
		end
	end

	class RvmGemset < PromptItem
		# @return [String] gemset used
		def gemset
			text = commandResult.chomp
			if text.include?('@')
				text.match(/.+@(.+)/)[1]
			else
				''
			end
		end

		# @return [String] terminal representation of the gemset used
		def show
			if termColor
				"#{termColor}#{symbol}#{gemset}#{resetColor}"
			else
				"#{symbol}#{gemset}"
			end
		end
	end

end
