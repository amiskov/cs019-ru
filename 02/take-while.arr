fun take-while(l :: List<Number>, sentinel :: Number) -> List<Number>:
    cases(List) l:
        | empty => empty
        | link(f, r) =>
            if f <= sentinel:
                empty
            else if f > 0:
                link(f, take-while(r, sentinel))
            else:
                take-while(r, sentinel)
            end
    end
where:
    take-while([list: 1, 2, 3], -999) is [list: 1, 2, 3]
    take-while([list: 1, 2, -999, 3], -999) is [list: 1, 2]
    take-while([list: -10, 20, -3, 1, 2, -999, 3, 4], -999)
        is [list: 20, 1, 2]
end