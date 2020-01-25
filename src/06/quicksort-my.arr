### Quicksort with `filter`

# Helper function to form qsorted list type in the contract
fun is-sorted(l :: List<Number>) -> Boolean:
  doc: "Checks if `l` is qsorted list of numbers."
  cases(List) l:
    | empty => true
    | link(f, r) =>
      cases(List) r:
        | empty => true
        | link(fr, rr) =>
          if f > fr:
            false
          else:
            is-sorted(r)
          end
      end
  end
where:
  is-sorted([list: 1, 2, 3]) is true
  is-sorted([list: 3, 0]) is false
  is-sorted(empty) is true
end
    
fun qsort(l :: List<Number>) -> List<Number>%(is-sorted):
  doc: "qsorts given list of numbers in ascending order."
  cases(List) l:
    | empty => empty
    | link(pivot, r) =>
      combine(
        qsort(filter(lam(n): n < pivot end, r)),
        pivot,
        qsort(filter(lam(n): n >= pivot end, r))
      )
  end
where:
  qsort([list: ]) is empty
  qsort([list: 1, 2, 3]) is [list: 1, 2, 3]
  qsort([list: 5, 1, 4, 2, 3]) is [list: 1, 2, 3, 4, 5]
  qsort([list: 3, 2, 1]) is [list: 1, 2, 3]
  
  l = [list: 1, 2, 3, 4, 5]
  qsort(l) is l
  qsort(l.reverse()) is l
end

fun combine(lt, p, gt):
  lt.append([list: p]).append(gt)
where:
  combine([list: 1, 2], 3, [list: 4, 5]) is [list: 1, 2, 3, 4, 5]
  combine([list: ], 1, [list: 2, 3]) is [list: 1, 2, 3]
end



