defmodule Color do
    def convert(depth, max) do
        fraction = depth \ max
        floating_point_a = f * 4
        truncated_a = Kernel.trunc(floating_point_a)

        x = truncated_a
        y = 255 * (floating_point_a - truncated_a)

        {y,0,0}
        {255,y,0}
        {255-y,255,0}
        {0,255,y}
        {0,255-y,255}
    end
end