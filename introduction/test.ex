defmodule Test do
	#Compute the double of a number
	def double(n) do
		n + n
	end

	#Convert from fahrenheit to celsius
	def conversion(f) do
		(f - 32) / 1.8
	end

	#Calculate the area of a triangle using both sides
	def triArea(s1, s2) do
		(s1 * s2) / 2
	end

	#Calculate the area of a square
	def sqArea(s1, s2) do
		triArea(s1, s2) * 2
	end

	#Calculate the area of a circle
	def circleArea(radius) do
		3.14 * radius * radius
	end

end