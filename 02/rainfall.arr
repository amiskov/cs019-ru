include math

d = [list: 1, 2, 3, -4, 10, -999, 30, 20]

fun takeTilNoise(l):
  fun aux(acc, l-inner):
    cases (List) l-inner:
      | empty => acc
      | link(f, r) =>
        if (f > 0):
          aux(acc.push(f), r)
        else:
          aux(acc, r)
        end        
    end 
  end
  aux(empty, l)
end

fun nonNegative(l):
  l.filter(lam(n): n > 0 end)
end

nn = nonNegative(takeTilNoise(d))
sum(nn) / nn.length()


