defmodule Recursion do
	
	#Calculate the product of two arguments
	def product(0, _) do 0 end
	def product(_, 0) do 0 end

	def product(m, n) do
		do_product(m,n,0)
	end

	defp do_product(m, _, s) when m <= 0 do
		s 
	end

	defp do_product(m, n, s) do
		do_product(m - 1, n, s + n)
	end

	# Exponentiation function
	# n - The Exponent
	# x - The base
	def exp(0,0) do IO.puts("Error, Base and Exponent cannot both be zero") end
	def exp(0,_) do 1 end
	def exp(_,0) do 0 end

	def exp(n,x) do
		#Think x * x^n-1

		do_exp(n-1,x,x)
	end

	defp do_exp(0,_,p) do p end

	defp do_exp(n,x,p) do
		do_exp(n-1,x,product(x,p))
	end

	#Fast version of exponential calculation
	def fastexp(1,x) do x end
	def fastexp(n,x) when rem(n,2) < 1 do
		fastexp(div(n,2),x) * fastexp(div(n,2),x)
	end
	def fastexp(n,x) do
		fastexp(n-1,x) * x
	end




end