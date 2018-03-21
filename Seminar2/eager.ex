defmodule Eager do
    def eval_expr({:atm,id},_) do   {:ok, id} end
    def eval_expr({:var, id}, env) do
        case Env.lookup(id,env) do
            nil ->                  :error
            {_,str} ->              {:ok, str}  
        end
    end
    def eval_expr({:cons,head,tail}, env) do
        case eval_expr(head, env) do
            :error ->               :error
            {:ok, str} ->
                case eval_expr(tail, env) do
                :error ->           :error
                {:ok,ts} ->         {:ok,{str,ts}} 
                end
        end
    end
    def eval_expr({:case,expression,clauses},env) do
        case eval_expr(expression,env) do
            :error ->               :error
            {:ok,str} ->
                eval_cls(clauses,str,env)
        end
    end

    def eval_expr({:lambda,param,free,seq},env) do
        case Env.closure(free,env) do
            :error -> :error
            closure ->
                    {:ok,{:closure,param,seq,closure}}
        end
    end

    def eval_expr({:apply,expr,args},env) do
        case eval_expr(expr,env) do
            :error -> :error
            {:ok,{:closure,param,seq,closure}} ->
                case eval_args(args,env,[]) do
                    :error -> :foo
                    strs ->
                            env = Env.args(param,strs,closure)
                            eval_seq(seq,env)
                end
        end
    end

    def eval_expr({:call,id,args}, env, prg) when is_atom(id) do
        case List.keyfind(prg,id,0) do
            :false ->
                :error
            {_,par,seq} ->
                case eval_args(...,...,prg)
                    :error ->
                        :error
                    strs ->
                        env = Env.args(...,...,...)
                        eval_seq(...,...,prg)
                end
        end
    end


    # Evaluates a list of arguments
    # Structure returned [{:ok, str}|rest] 
    def eval_list([],_,acc) do acc end
    def eval_list([exp|args],env,acc) do
        case eval_expr(exp, env) do
            :error -> :error
            {:ok, str} -> eval_args(args,env,[{:ok,str}|acc])
        end
    end

    def eval_cls([],_,_) do :error end
    def eval_cls([{:clause,pattern,sequence}|clauses],structure,environment) do
        ext_env = scope(pattern, environment)
        case eval_match(pattern,structure,ext_env) do
            :fail -> eval_cls(clauses,structure,environment)
            new_env -> eval_seq(sequence, new_env)
        end
    end

    def eval_match(:ignore,_,env)       do {:ok, env} end
    def eval_match({:atm,id},id,env)    do {:ok, env} end
    def eval_match({:var,id},str,env)   do
        case Env.lookup(id,env) do
            nil -> 
                {:ok, Env.add(id,str,env)}
            {_, ^str} -> 
                {:ok, env}
            _ -> 
                :fail                
        end
    end
    def eval_match({:cons,head,tail},{str,tail2},env) do
        case eval_match(head,str,env) do
            {:ok,ext_env} -> 
                eval_match(tail,tail2,ext_env)
            :fail -> 
                :fail
        end    
    end
    def eval_match(_,_,_) do :fail end

    # Evaluate the final part of the sequence, the expression, with the extended environment.
    def eval_seq([exp],env) do
        eval_expr(exp,env)
    end
    # Evaluate the pattern matches in order to extend the environment, pass the extended environment on to the next
    # part of the sequence to be evaluated.
    def eval_seq([{:match,pattern,expression}|sequence],environment) do
        case eval_expr(expression,environment) do
            :error ->
                :error
            {:ok, exp_str} ->
                scope = scope(pattern,environment)

                case eval_match(pattern,exp_str,scope) do
                    :fail ->   
                        :error
                    {:ok, ext_env} ->
                        eval_seq(sequence,ext_env)
                end
        end
    end

    def scope(pattern, environment) do
        vars = extract_vars(pattern)
        Env.remove(vars,environment) 
    end
    # Returns a list of all variables in the pattern
    def extract_vars({:var, id}) do [id] end
    def extract_vars({:cons, head, tail}) do
        extract_vars(head) ++ extract_vars(tail)
    end
    def extract_vars(_) do [] end

    def eval() do
    seq =   [   {:match, {:var, :x}, {:atm,:a}},
                {:case, {:var, :x}, 
                [
                    {:clause,{:atm,:b},[{:atm,:ops}]},
                    {:clause,{:atm,:a},[{:atm,:yes}]}    
                ]}
            ]
        case eval_seq(seq,[]) do
            :error ->
                :error
            str ->
                str
        end
    end 
         
end