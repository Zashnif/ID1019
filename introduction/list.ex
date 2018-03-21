defmodule ListSimple do


	#Returns the n'th element of a list
	#n - Element position, starting from 0
	#l - The list that is operated on
	def nth(n, l) do
		do_nth(n,l)
	end

	defp do_nth(0, [h|_]) do h end
	defp do_nth(n, [_|t]) do
		do_nth(n-1, t)
	end

	#Returns the number of elements in a list
	def len(l) do
		do_len(l, 0)
	end

	defp do_len([], s) do s end
	defp do_len([_|t],s) do
		do_len(t, s + 1)
	end

	#Returns the sum of all elements in the list
	#Function assumes the inputted list only contains integers
	def sum(l) do
		do_sum(l,0)
	end

	defp do_sum([],s) do s end
	defp do_sum([h|t],s) do
		do_sum(t,h+s)
	end

	#Duplicates the elements in a list
	def duplicate(l) do
		do_duplicate(l)
	end

	defp do_duplicate([]) do [] end
	defp do_duplicate([h|t]) do
		[h,h|do_duplicate(t)]
	end

	#Adds an element x to list l if x doesn't exist in list l
	#Assumes that x is an integer
	def add(x, []) do [x] end
	def add(x,l) do
		case add_check(x,l) do
			true -> l 
			false -> [x|l]
		end
	end

	#Returns True if x is found in the list
	defp add_check(_, []) do false end
	defp add_check(x,[x|_]) do true end
	defp add_check(x,[_|t]) do add_check(x,t) end


	#Remove all occurences of x in list l
	def remove(x,l) do
		do_remove(x,l)
	end

	defp do_remove(_,[]) do [] end
	defp do_remove(x,[x|t]) do
		do_remove(x,t)
	end
	defp do_remove(x,[h|t]) do
		[h |do_remove(x,t)]
	end

	#Return a list of unique elements from a list of atoms
	def unique(l) do
		do_unique(l, [])
	end

	#Borrowing the add_check function as it is servicable for this task.		
	defp do_unique([], acc) do acc end
	defp do_unique([h|t], acc) do
		res = unique_add(h,acc)
		do_unique(t,res)
	end

	defp unique_add(e, []) do [e] end
	defp unique_add(e, [e|t]) do [e|t] end
	defp unique_add(e, [h|t]) do [h|unique_add(e,t)] end


	#Returns a list containing the elements from the inputted list compacted into separate lists [[1,1,1],[2,2],[3,3,3]] from [1,2,3,1,2,3,1,3]
	def pack(l) do
	 	do_pack(l,[])
	end

	#Part of the Pack function, traverses the inputted list and sends individual elements to match_pack for testing.
	defp do_pack([], acc) do acc end
	defp do_pack([h|t], acc) do 
		res = match_pack(h, acc)
		do_pack(t,res)
	end

	defp match_pack(e,[]) do [[e]] end
	defp match_pack(e,[[e|t1]|t2]) do
		[[e,e|t1]|t2]
	end
	defp match_pack(e,[[h|t1]|t2]) do
		t3 = match_pack(e,t2)
		head = [h|t1]
		[head|t3]
	end

	#Reverses the given list l
	def reverse(l) do
		do_reverse(l,[])
	end

	defp do_reverse([],acc) do acc end
	defp do_reverse([h|t], acc) do
		do_reverse(t,[h|acc])
	end
end