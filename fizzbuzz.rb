class Integer
  def print
    out = ""
    if (self % 3 ==0)
      out<<"fizz"
    end
    if (self % 5==0)
      out<<"buzz"
    end
    if out == ""
      out = self.to_s
    end
    puts out
  end
end

for i in 1..100
  i.print
end
