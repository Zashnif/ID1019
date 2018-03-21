defmodule Convert do

	defp append([],list) do list end
	defp append([h|t],list) do [h|append(t,list)] end
	
	# Integer to binary
	def binary(0) do 0 end
	def binary(n) do to_binary(n,[]) end

	defp to_binary(0, acc) do acc end
	# These two "to_binary" functions below can be mashed into one
	# Think rem(n,2) = 0 or 1.
	defp to_binary(n, acc) when rem(n,2) == 0 do
		to_binary(div(n,2), [0|acc])
	end
	defp to_binary(n, acc) do to_binary(div(n,2), [1|acc]) end

	def n_binary(0) do [] end
	def n_binary(n) do
		append(n_binary(div(n,2)),[rem(n,2)])
	end

	def integer([]) do [] end
	def integer(list) when is_list(list) do
		to_integer(list,1,0)
	end

	defp to_integer([],_,acc) do acc end
	defp to_integer([h|t],m,acc) do
		res = acc + h*m
		multiplier = m * 2
		to_integer(t, multiplier, res)
	end
end