class Fixnum
  alias_method :super_to_s, :to_s
  def to_s
    out = ""
    if (self%3==0)
      out<<"fizz"
    end
    if (self%5==0)
      out<<"buzz"
    end
    if out == ""
      out = self.super_to_s
    end
    out
  end
end

for i in 1..100
  puts i.to_s
end
