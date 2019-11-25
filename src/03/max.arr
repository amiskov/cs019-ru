# Custom Type for Non-empty List
data NEList:
    | one(n :: Number)
    | ne-link(first :: Number, rest :: NEList)
end

fun ne-lon-max(l :: NEList) -> Number:
    cases(NEList) l:
        | one(n) => n
        | ne-link(f, r) =>
            if f > ne-lon-max(r):
                f
            else:
                ne-lon-max(r)
            end
    end
where:
    ne-lon-max(ne-link(3, ne-link(2, one(0)))) is 3
end

# Predicate
fun is-non-empty(l :: List<Any>) -> Boolean:
    l.length() > 0
where:
    is-non-empty([list: 1, 2, 3]) is true
    is-non-empty(empty) is false
end

fun lon-max(l :: List<Number>%(is-non-empty)) -> Number:
    fun m(il :: List, m-num :: Number) -> Number:
        cases(List) il:
            | empty => m-num
            | link(f, r) =>
                if f > m-num:
                    m(r, f)
                else:
                    m(r, m-num)
                end
        end
    end

    cases(List) l:
        | link(f, r) => m(r, f)
    end
where:
    lon-max([list: 1, 2, 3]) is 3
    lon-max([list: -10, 1, -20, 3]) is 3
end