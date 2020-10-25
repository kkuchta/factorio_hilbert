require "pry-byebug"

# A quick translation from https://en.wikipedia.org/wiki/Hilbert_curve
module Hilbert
  extend self
  # Given a certain distance along the line of a hilbert curve from the start,
  # returns the x/y coordinates of that point.
  #
  # n = n x n grid, n is power of 2
  # d = distance along curve
  def d2xy(n, d)
    # rx = nil
    # ry = nil
    t = d
    x = 0
    y = 0
    s = 1
    while s < n
      rx = 1 & (t / 2)
      ry = 1 & (t ^ rx)
      (x, y) = rot(s, x, y, rx, ry)
      x += s * rx
      y += s * ry
      t /= 4
      s *= 2
    end
    [x, y]
  end

  def rot(n, x, y, rx, ry)
    if ry == 0
      if rx == 1
        x = n - 1 - x
        y = n - 1 - y
      end

      # Swap x and y
      t = x
      x = y
      y = t
    end
    [x, y]
  end
end
