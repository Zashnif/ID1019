defmodule Sorters do
	#Insertion sort, takes a given list l and sorts it
	def insertion_sort(l) do
		do_insertion(l, [])
	end

	defp do_insertion([],acc) do acc end
	defp do_insertion([h|t], acc) do
		res = insert(h, acc)
		do_insertion(t, res)
	end

	#Handling insertions into the resulting list
	#Insert: First/Last, Before, After
	defp insert(e, []) do [e] end
	defp insert(e, [h|t]) when e <= h do
		[e,h|t]
	end
	defp insert(e, [h|t]) do
		[h|insert(e,t)]
	end

	#Merge sort - divide and conquer strategy
	def msort([]) do [] end
	def msort([e]) do [e] end
	def msort(l) do
		{left,right} = msplit(l,[],[])
		merge(msort(left),msort(right))
	end

	defp msplit([],l,r) do {l,r} end
	defp msplit([h|t],l,r) do msplit(t,r,[h|l]) end

	defp merge([],l) do l end
	defp merge([h1|t1],[h2|t2]) when h1 <= h2 do [h1|merge(t1,[h2|t2])] end
	defp merge([h1|t1],[h2|t2]) do [h2|merge(t2,[h1|t1])] end

	#Quicksort
	#Select a pivot element (the first element in this case), partition the list into two halves one greater and
	# one less than the pivot element, repeat the process until the list is sorted.

	def qsort([]) do [] end
	def qsort([p|l]) do
		{lesserlist, greaterlist} = qsplit(p,l,[],[])
		small = qsort(lesserlist)
		large = qsort(greaterlist)
		append(small,[p|large])
	end

	defp qsplit(_,[],small,large) do {small,large} end
	defp qsplit(p,[h|t],small,large) when p > h do qsplit(p,t,[h|small],large) end
	defp qsplit(p,[h|t],small,large) do qsplit(p,t,small,[h|large]) end

	defp append([],list) do list end
	defp append([h|t],list) do [h|append(t,list)] end
end