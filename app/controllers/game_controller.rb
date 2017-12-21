class GameController < ApplicationController
	include GameHelper
	before_action :authenticate_user!, only: [:show]


	def create
		user = User.find_or_create_by(name: params[:username])
		game = Game.new
		game.user = user
		game.grid = params[:grid]
		game.free_size = game.grid * game.grid
		game.array_value = Array.new(game.grid){Array.new(game.grid, 0)}
		if user.save and game.save
			$array = game.array_value
			$free_size = game.free_size
			$grid_size = game.grid
			redirect_to game_path game.id
		else
			flash[:errors] = "FAILED TO CREATE GAME"
			redirect_to :back
		end
	end

	def new
		@user = User.find_by(name: params[:username])
	end

	def play
		puts "Free Size: #{$free_size}"
		if $free_size==0
			flash[:errors] = "GAME OVER"
			$game.finished = true
			puts "#{$array}"
			maxx = []
			$array.each do |arr|
				maxx << arr.max
			end
			$game.score = maxx.max
			$game.array_value = $array
			$game.free_size = 0
			$game.save
			redirect_to user_path $game.user.id
		end
	end

	def setRandomNumber(r, c)
		if r==-1
			row = rand($game.grid) 
			column = c
		end
		if c==-1
			column = rand($game.grid)
			row = r
		end
		if $array[row][column]==0
			$free_size = $free_size - 1 
			puts "decreasing free_size to #{$free_size}"
			$array[row][column]=1
		else 
			setRandomNumber(r, c)
		end

	end


	def show
		$game = Game.find(params[:id])
		puts "#{$game.inspect}"
		if not $game.finished
			$grid_size = $game.grid
			$free_size = $game.free_size
			$array = $game.array_value
			$array = [[]] if not $array
			play 
		else
			redirect_to user_path $game.user.id
		end
	end

	def move_down
		puts "move_down"
		move_all_down
		setRandomNumber(0, -1)
		save_game
		redirect_to :back
	end

	def move_left
		puts "move_left"
		move_all_left
		setRandomNumber(-1, $grid_size-1)
		save_game
		redirect_to :back
	end

	def move_right
		puts "move_right"
		move_all_right
		setRandomNumber(-1, 0)
		save_game
		redirect_to :back
	end

	def move_up
		puts "move_up"
		move_all_up
		setRandomNumber($grid_size-1, -1)
		save_game
		redirect_to :back
	end

	private def game_params
		params(:game).permit(:grid, :username)
	end
end
