defmodule Env do

	# Return an empty environment
	def new() do
		[]
	end

	# Return an environment where the binding between id and str has been added.
	def add(id, str, env) do		
		[{id,str}|env]
	end

	# Returns the structure {id, str} or nil depending on if id is bound within the environment
	def lookup(_, []) do :nil end
	def lookup(id, [{id, str}|_]) do {id,str} end
	def lookup(id,[_|t]) do lookup(id,t) end

	# Removes all the bindings in the environment specified by the list ids
	def remove(_, []) do [] end
	def remove([h|t], [h|env]) do
		remove(t,env)
	end
	def remove(ids, [h|env]) do
		[h|remove(ids,env)]
	end

	# Creates the closure environment for an unnamed function, lambda expression
	def closure(free, env) do
		do_closure(free,env,[])
	end

	def do_closure([],_,acc) do acc end
	def do_closure([id|free],env,acc) do
		case lookup(id,env) do
			:nil -> :error
			{^id,str} -> do_closure(free,env,[{id,str}|acc])
		end
	end

	# Adds the relevant variable/struct bindings to the closure environment
	def args([],[],env) do env end
	def args([id|rest1],[{:ok,str}|rest2], env) do
		ext_env = add(id,str,env)
		args(rest1,rest2,ext_env)
	end
end