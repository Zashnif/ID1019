defmodule Cmplx do
    # Structure : {:cmplx, Real, Imaginary}
    # Complex numbers
    # This modules data type is abstract -- Verify that it is!

    def new(r,i) do
        {:cmplx,r,i}
    end

    def add(a,b) do
        {:cmplx,r1,i1} = a
        {:cmplx,r2,i2} = b
        {:cmplx,r1+r2,i1+i2}
    end

    # input * input
    def sqr(a) do
        {:cmplx, r, i} = a
        real = r*r - i*i
        im = 2*r*i
        {:cmplx,real,im}
    end
    
    # |a| 
    def abs(a) do
        {:cmplx,real,im} = a
        temp = (real * real) + (im * im)
        :math.sqrt(temp)
    end



end