defmodule Huffman do
	#def sample do
	#	’the quick brown fox jumps over the lazy dog
	#	this is a sample text that we will use when we build
	#	up a table we will only handle lower case letters and
	#	no punctuation symbols the frequency will of course not
	#	represent english but it is probably not that far off’
	#end

	def text, do: 'this is something that we should encode'

	#def test do
	#	sample = sample()
	#	tree = tree(sample)
	#	encode = encode_table(tree)
	#	decode = decode_table(tree)
	#	text = text()
	#	seq = encode(text, encode)
	#	decode(seq, decode)
	#end

	#Counts the frequency of each character of a given character string
	#Returns the datatype [{character, frequency}|t] ex. [{116,5}|t] which is 't' that has occured 5 times.
	def frequency (sample) do
		msort(freq(sample, []))
	end

	def freq([], acc) do acc end
	def freq([char|string], acc) do freq(string,count(char,acc)) end
	
	#Counter for the frequency counter
	def count(char, []) do [{:node,[char],1,[],[]}] end
	def count(char, [{:node,[char],v,[],[]}|t]) do [{:node,[char],v+1,[],[]}|t] end
	def count(char, [h|t]) do [h|count(char,t)] end

	#Datastructure for nodes : {:node, character list, sumtotal, leftbranch, rightbranch}
	#Empty branches mean that it is a leaf node
	#Tree is built from the bottom-up so there are now "half full" nodes
	def tree(sample) do
		freqList = frequency(sample)

	end

	def do_tree()



	#def encode_table(tree) do
		# To implement...
	#end

	#def decode_table(tree) do
		# To implement...
	#end

	#def encode(text, table) do
		# To implement...
	#end

	#def decode(seq, tree) do
		# To implement...
	#end

	#Mergesort
	def msort([]) do [] end
	def msort([e]) do [e] end
	def msort(l) do
		{left,right} = msplit(l,[],[])
		merge(msort(left),msort(right))
	end

	defp msplit([],l,r) do {l,r} end
	defp msplit([h|t],l,r) do msplit(t,r,[h|l]) end

	defp merge([],l) do l end
	defp merge([{:node,c1,v1,[],[]}|t1],[{:node,c2,v2,[],[]}|t2]) when v1 <= v2 do 
		[{:node,c1,v1,[],[]}|
			merge(t1,[{:node,c2,v2,[],[]}|t2])] 
	end
	defp merge([h1|t1],[h2|t2]) do [h2|merge(t2,[h1|t1])] end
end