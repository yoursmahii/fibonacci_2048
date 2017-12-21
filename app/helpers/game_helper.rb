module GameHelper
	$fibo = Array.new(20, -1)
	$fibo[0] = 0
	$fibo[1] = 1
	$fibo[2] = 1
	$fib_length = 20

	def add_fibo(row, column, r, c)
		if(row<0 || column<0 || (row+r)<0 || (column+c)<0 || row>($grid_size-1) || column>($grid_size-1) || (row+r)>($grid_size-1) || (column+c)>($grid_size-1))
			return
		end
		puts "current element #{$array[row][column]}"
		puts "next element #{$array[row+r][column+c]}"
		if((($array[row][column] == 1 && $array[row+r][column+c] == 1) || ($array[row+r][column+c] == nextFib($array[row][column])) || ($array[row][column] == nextFib($array[row+r][column+c]))) && ($array[row][column]!=0 && $array[row+r][column+c]!=0))
			$array[row+r][column+c] += $array[row][column]
			$free_size = $free_size + 1
			$array[row][column] = 0
		end
	end

	def move_to(row, column, r, c)
		puts "checking to move value #{$array[row][column]} at (#{row},#{column}) to (#{r},#{c}) positions"
		while ((c==0 and ((r==1 and row>=0 and row<($grid_size-1))||(r==-1 and row>0 and row<=($grid_size-1)))) || (r==0 and ((c==1 and column>=0 and column<($grid_size-1))||(c==-1 and column>0 and column<=($grid_size-1))))) do
			if $array[row][column]!=0 and $array[row+r][column+c] == 0
				puts "moving value #{$array[row][column]} at (#{row},#{column}) to (#{r},#{c}) positions"
				$array[row+r][column+c] = $array[row][column]
				$array[row][column] = 0
				row = row+r
				column = column+c
			else
				add_fibo(row, column, r, c) if $array[row][column]!=0 and $array[row+r][column+c]!=0
				row = row-r
				column = column-c
			end
			
		end
	end

	def move_all_down
		for column in 0.upto($grid_size-1) do 
			move_to($grid_size-2, column, 1, 0)
		end 
	end

	def move_all_left
		for row in 0.upto($grid_size-1) do 
			move_to(row, 1, 0, -1)
		end 
	end

	def move_all_right
		for row in 0.upto($grid_size-1) do 
			move_to(row, $grid_size-2, 0, 1)
		end 
	end

	def move_all_up
		for column in 0.upto($grid_size-1) do 
			move_to(1, column, -1, 0)
		end 
	end


	def get_score
		maxx = []
		$array.each do |arr|
			maxx << arr.max
		end
		return maxx.max
	end

	def save_game
		$game.array_value = $array
		$game.free_size = $free_size
		$game.score = get_score
		$game.save
	end

	def fibo(n)
		if $fibo[n] == -1
			$fibo[n] = fibo(n-1) + fibo(n-2)
		end
		return $fibo[n];
	end

	def nextFib(n)
		return 2 if n==1
		puts "fib_index of #{n} is #{fib_index(n)}"
		puts "finding nextFib of #{n} is #{fibo(fib_index(n)+1)}"
		return fibo(fib_index(n)+1)
	end

	def fib_index(n)
		for i in 0.upto($fib_length-1) do
			return 2 if n == 1
			return i if $fibo[i]==n
			if $fibo[i] == -1
				fibo(i)
				return fib_index(n)
			end
		end
		return -1
	end
end
