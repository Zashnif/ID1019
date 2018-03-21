defmodule Philosopher do

    defp sleep(t) do
        :timer.sleep(:rand.uniform(t))
    end

    def start(hunger, c1, c2, name, ctrl) do
        spawn_link(fn -> dreaming(hunger, c1, c2, name, ctrl) end)
    end

    defp dreaming(hunger, c1, c2, name, ctrl) do
        IO.puts("#{name} is thinking")
        case hunger do
            0 -> 
                send(ctrl, :done)
            _ ->
                sleep(hunger) # Thinking
                waiting(hunger, c1, c2, name, ctrl)
        end
    end

    defp waiting(hunger, c1, c2, name, ctrl) do
        send(c1,{:request,self()})
        receive do
            :ok -> 
                IO.puts("#{name} received their first chopstick")
                send(c2,:request)
                receive do
                    :ok -> 
                        IO.puts("#{name} received their second chopstick")
                        eating(hunger, c1, c2, name, ctrl)
                end
        end
    end

    defp eating(hunger, c1, c2, name, ctrl) do
        IO.puts("#{name} is eating")
        sleep(hunger)

        send(c1, :return)
        send(c2, :return)

        dreaming(hunger - 1, c1, c2, name, ctrl)
    end

end