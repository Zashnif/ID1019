defmodule Chopstick do
    
    def start() do
        spawn_link(fn -> available() end)
    end

    defp available() do
        receive do
            {:request,pid} -> 
                send(pid, :ok)
                gone()
            :quit -> :ok
        end
    end

    defp gone() do
        receive do
            :return -> available()
            :quit -> :ok
        end
    end

    def request(stick) do
        send(stick, {:request, self()})
        receive do
            :ok -> :ok
        end
    end

    def quit(process) do
        send(process, :quit)
    end
end