
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
    end

    fun insert(n :: Number, lst :: List<Number>%(is-sorted)) -> List<Number>%(is-sorted):
        doc: "Inserts `n` in right position in sorted list `lst`."
        cases(List) lst:
            | empty => [list: n]
            | link(f, r) =>
                if n < f:
                    link(n, lst)
                else:
                    link(f, insert(n, r))
                end
        end
    end


fun lon-sort(l :: List<Number>) -> List<Number>%(is-sorted):
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
