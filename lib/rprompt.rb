require "rprompt/version"

require "term/ansicolor"
# Usage as Mixin into String or its Subclasses
class String
  include Term::ANSIColor
end

module Rprompt
	class PromptItem

		# @return [String] symbol character to identify prompt item
		attr_reader :symbol, :color

		# @param config [Hash] Prompt item configuration:
		# 	- :cmd => shell command
		# 	- :symbol => character
		# 	- :color => color name
		def initialize(config)
			@cmd        = config[:cmd]
			@symbol     = config[:symbol]
			@color      = config[:color]
		end

		# executes prompt item command
		# @return [String] command result
		def commandResult
			%x(#{@cmd} 2> /dev/null)
		end
	end

	class GitNumbers < PromptItem
		# @return [Integer] number of files returned by a git command
		def numberOfFiles
			commandResult.split(/\r?\n/).count
		end

		# @return [String] terminal representation of the number of files
		def show
			if color
				numberOfFiles != 0 ? "#{symbol}#{numberOfFiles}".send(color) : ""
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
			if color
				"#{symbol}#{shortBranchName}".send(color)
			else
				"#{symbol}#{shortBranchName}"
			end
		end
	end

	class GitSha < PromptItem
		# @return [String] last five numbers form the sha1
		def sha
			commandResult.chomp[-6,6]
		end

		# @return [String] terminal representation of the number returned by 'sha'
		def show
			if color
				"#{symbol}#{sha}".send(color)
			else
				"#{symbol}#{sha}"
			end
		end
	end

	class GitTrack < PromptItem
		# @param (see PromptItem#initialize)
		# @param [Symbol] state ("ahead" or "behind")
		def initialize(config, state)
			@state = state
			super(config)
		end

		# @return [Integer] number of commits ahead or behind remote
		# @note works only if remote branch is tracked
		def count
			commandResult.match(/#{@state}\s+([0-9]+)/)
			$1.to_i
		end

		# @return [String] terminal representation of the tracking
		def show
			if color
				count != 0 ? "#{symbol}#{count}".send(color) : ""
			else
				count != 0 ? "#{symbol}#{count}" : ""
			end
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
			if color
				"#{symbol}#{ruby}".send(color)
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
			if !gemset.empty?
				if color
					"#{symbol}#{gemset}".send(color)
				else
					"#{symbol}#{gemset}"
				end
			else
				''
			end
		end
	end

end
