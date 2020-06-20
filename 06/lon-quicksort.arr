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
            is-qsorted(r)
          end
      end
  end
where:
  is-qsorted([list: 1, 2, 3]) is true
  is-qsorted([list: 3, 0]) is false
  is-qsorted(empty) is true
end

fun qsort(l :: List<Number>) -> List<Number>%(is-sorted):
  doc: "qsorts given list of numbers in ascending order."
  cases(List) l:
    | empty => empty
    | link(pivot, r) =>
      combine(
        qsort(all-lt(pivot, r)),
        pivot,
        qsort(all-gte(pivot, r))
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

fun all-lt(p :: Number, l :: List<Number>) -> List<Number>:
  cases(List) l:
    | empty => empty
    | link(f, r) =>
      if f < p:
        link(f, all-lt(p, r))
      else:
        all-lt(p, r)
      end
  end
where:
  all-lt(3, [list: 1, 2, 3, 4, 5]) is [list: 1, 2]
  all-lt(1, [list: 1, 2, 3, 4, 5]) is [list: ]
  all-lt(7, [list: 1, 2, 3, 4, 5]) is [list: 1, 2, 3, 4, 5]
  all-lt(7, [list: ]) is [list: ]
  all-lt(1, [list: 1, 2, 3]) is [list: ]
end


fun all-gte(p :: Number, l :: List<Number>) -> List<Number>:
  cases(List) l:
    | empty => empty
    | link(f, r) =>
      if f >= p:
        link(f, all-gte(p, r))
      else:
        all-gte(p, r)
      end
  end
where:
  all-gte(3, [list: 1, 2, 3, 4, 5]) is [list: 3, 4, 5]
  all-gte(1, [list: 1, 2, 3, 4, 5]) is [list: 1, 2, 3, 4, 5]
  all-gte(7, [list: 1, 2, 3, 4, 5]) is [list: ]
  all-gte(7, [list: ]) is [list: ]
  all-gte(1, [list: 1, 2, 3]) is [list: 1, 2, 3]
end

fun combine(lt, p, gt):
  lt.append([list: p]).append(gt)
where:
  combine([list: 1, 2], 3, [list: 4, 5]) is [list: 1, 2, 3, 4, 5]
  combine([list: ], 1, [list: 2, 3]) is [list: 1, 2, 3]
end



