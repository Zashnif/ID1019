defmodule Brot do

    def mandelbrot(c, n) do
        z0 = Cmplx.new(0,0) # z0 = 0
        i = 0
        test(i, z0, c, n)
    end

    def test(_, _, _, 0) do 0 end
    def test(i, z, c, n) do
        case Cmplx.abs(z) do
            abs when abs > 2 -> i
            _ -> test(i + 1, Cmplx.add(Cmplx.sqr(z),c),c,n-1)
        end
    end

end