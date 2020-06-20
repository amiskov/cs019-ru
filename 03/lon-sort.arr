fun lon-sort(l :: List<Number>) -> List<Number>%(is-sorted):
  doc: "Sorts given list of numbers in ascending order."
  cases(List) l:
    | empty => empty
    | link(f, r) => insert(f, lon-sort(r))
  end
where:
  lon-sort([list: ]) is empty
  lon-sort([list: 1, 2, 3]) is [list: 1, 2, 3]
  lon-sort([list: 5, 1, 4, 2, 3]) is [list: 1, 2, 3, 4, 5]
  lon-sort([list: 3, 2, 1]) is [list: 1, 2, 3]
end

fun insert(n :: Number, lst :: List<Number>%(is-sorted)) -> List<Number>%(is-sorted):
  doc: "Inserts `n` in right position into SORTED list `lst`."
  cases(List) lst:
    | empty => [list: n]
    | link(f, r) =>
      # list is sorted, so if predicate is true, then el is less than all elements
      # and should be the first
      if n <= f:
        link(n, lst)
      else:
        # if not, than we call function again for the rest of the list
        link(f, insert(n, r))
      end
  end
where:
  insert(3, [list: 1, 2, 10]) is [list: 1, 2, 3, 10]
  insert(0, [list: 1, 2, 3]) is [list: 0, 1, 2, 3]
  # insert(0, [list: 3, 2, 1]) is [list: 0, 1, 2, 3] # bad example, we need sorted list to insert el
end
#|
   Our contract for `insert` is `Number -> SortedListOfNumbers -> SortedListOfNumbers`.
   We evaluate this contract if we'll give unsorted list to this function.
|#


# Helper function to form sorted list type in the contract
fun is-sorted(l :: List<Number>) -> Boolean:
  doc: "Checks if `l` is sorted list of numbers."
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
