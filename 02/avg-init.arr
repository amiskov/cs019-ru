fun sum(l :: List<Number>) -> Number:
    l.foldl(lam(el, acc): el + acc end, 0)
where:
    sum([list: ]) is 0
    sum([list: 1, 2, 3]) is 1 + 2 + 3
    sum([list: -10, 20, 30]) is -10 + 20 + 30
end

fun get-positive-before-noise(l :: List<Number>) -> List<Number>:
    cases(List) l:
        | empty => empty
        | link(f, r) =>
            if f <= -999:
                empty
            else if f > 0:
                link(f, get-positive-before-noise(r))
            else:
                get-positive-before-noise(r)
            end
    end
where:
    get-positive-before-noise([list: 1, 2, 3]) is [list: 1, 2, 3]
    get-positive-before-noise([list: 1, 2, -999, 3]) is [list: 1, 2]
    get-positive-before-noise([list: -10, 20, -3, 1, 2, -999, 3, 4])
        is [list: 20, 1, 2]
end

fun avg(l :: List<Number>) -> Number:
    doc: "Produces the average of non-negative numbers."
    cases(List) l:
        | empty => raise("No average for empty list.")
        | link(f, r) => 
            only-positive-whithout-noise = get-positive-before-noise(l)
            if only-positive-whithout-noise.length() > 0:
                only-positive-whithout-noise
                    . foldl(lam(el, acc): el + acc end, 0)
                    / only-positive-whithout-noise.length()
            else:
                raise("Invalid values in list.")
            end
    end
where:
    avg([list: 1, 2, 3]) is (1 + 2 + 3) / 3
    avg([list: ]) raises "No average for empty list."
    avg([list: -10, 20, -3, 1, 2, -999, 3, 4]) is (20 + 1 + 2) / 3
    avg([list: -1, -2, -999]) raises "Invalid values in list."
    avg([list: -999]) raises "Invalid values in list."
end