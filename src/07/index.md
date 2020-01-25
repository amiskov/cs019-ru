# Mutual recoursive data definitions, trees
Guest lecture.

## Data definitions
List of numbers data definition:

```pyret
data NumList:
    | empty
    | link(first :: Number, r :: NumList)
end
```

What is data definition for a `link`?

На этой лекции разбирается определение структур данных, которые не являются линейными цепочками, как списки.

Будем обсуждать деревья. В частности, family trees. Вместо `first` будет имя человека, вместо `rest` будет два биологических родителя.

## Just start coding
Определим данные для человека:

```pyret
data Person:
    person(name :: String, parent1 :: Person, parent2 :: Person)
end
```

Сразу же напишем функцию, которая работает с этим определением. Пусть она считает количество людей в дереве, которое начинается с какого-то человека (корень).

```pyret
fun count-people(p :: Person) -> Number:
    cases(Person) p:
        | person(name, p1, p2) =>
            1 + count-people(p1) + count-people(p2)
    end
end
```

Написали функцию, которая не работает. Потому что структура данных не завершена. А следовали бы рецепту, то на примерах сразу бы увидели, что у нас есть эти проблемы.

## Just follow the recipe
Теперь сделаем нормально:

```pyret
data Person:
  | Unknown
  | person(name :: String, parent1 :: Person, parent2 :: Person)
end

# Examples
petya = person("Petya", Unknown, Unknown)
masha = person("Masha", Unknown, Unknown)
ivan = person("Ivan", petya, masha)

sveta = person("Sveta", Unknown, Unknown)
vasya = person("Vasya",
  ivan,
  person("Sveta", Unknown, Unknown))

fun count-people(p :: Person) -> Number:
    cases(Person) p:
        | Unknown => 0
        | person(name, p1, p2) =>
            1 + count-people(p1) + count-people(p2)
    end
end

check:
  count-people(vasya) is 5
end
```

Похоже на список, но на каждом уровне (поколении) происходит два рекурсивных вызова.

Теперь определим тип данных для генеалогического древа, где верхний узел — человек, а остальные узлы — его дети и дети его детей:

```
          John
            |
    -----------------
    |   
  Jack  ...
    |
   ---
```

Моя версия:

```pyret
data Tree:
    | person
    # ошибка, у Person из определения выше есть родители, а не дети
    | tree(person :: Person, child :: Tree, child :: Tree)
end
```

Из лекции, один из способов представить эти типы:

```pyret
data Person:
  | person(name :: String, children :: ChildList)
end

data ChildList:
  | NoChildren
  | child(c :: Person, rest :: ChildList)
end

sveta = person("Sveta", NoChildren)
vasya = person("Vasya", child(sveta, NoChildren))
```

В определении `Person` нет базового случая (когда дети пустые). Но он уже и так доступен, можно проверять список детей на пустоту.

Эти определения связаны друг с другом. `ChildList` в себе использует `Person` и наоборот. Циклическая зависимость. Mutual recursion between data types.

Напишем функцию, которая считает всех детей человека, включая его самого:

```pyret
fun count(t :: Person):
  cases(Person) t:
    | person(n, c) =>
      cases(ChildList) c:
        | NoChildren => 0
        | child(p, r) => 1 + count(p) # but how to handle `rest`?
        # we need a way to handle this mutual recursion somehow...
        # We need a new function for counting `ChildList`s.
        # Separation of concerns.
      end
  end
end
```

Разделим ответственность, вынесем в отдельную функцию подсчёт количества детей:

```pyret

data Person:
  | person(name :: String, children :: ChildList)
end

data ChildList:
  | NoChildren
  | child(c :: Person, rest :: ChildList)
end

sveta = person("Sveta", NoChildren)
masha = person("Masha", child(sveta, NoChildren))

vasya = person("Vasya", child(masha, NoChildren))

fun count(t :: Person):
  cases(Person) t:
    | person(n, cs) =>
      1 + countList(cs) # теперь за подсчёт детей отвечает `countList`
  end
end

fun countList(cs :: ChildList):
  cases(ChildList) cs:
    | NoChildren => 0
    | child(f, r) =>
      1 + countList(r) # something suspicious
  end
end

check:
  count(vasya) is 3
  count(sveta) is 1
end
```

Вроде работает. Но если у ребёнка будет ребёнок, то он не посчитается. Мы имеем взаимно-рекурсивные определения данных, но в функции `countList` это не отражено! Мы не вызываем `count` из `countList`, а надо её вызывать на отдельном человеке, чтобы посчитать и его детей.

Так надо:

```pyret
fun countList(cs :: ChildList):
  cases(ChildList) cs:
    | NoChildren => 0
    | child(f, r) =>
      count(f) + countList(r)
  end
end
```

:::
При обработке взаимно рекурсивных типов данных соответствующие функции также должны иметь взаимно рекурсивные вызовы.
:::

Итог:

```pyret

data Person:
  | person(name :: String, children :: ChildList)
end

data ChildList:
  | NoChildren
  | child(c :: Person, rest :: ChildList)
end

sveta = person("Sveta", NoChildren)
masha = person("Masha", child(sveta, NoChildren))

vasya = person("Vasya", child(masha, NoChildren))

fun count(t :: Person):
  cases(Person) t:
    | person(n, cs) =>
      1 + countList(cs)
  end
end

fun countList(cs :: ChildList):
  cases(ChildList) cs:
    | NoChildren => 0
    | child(f, r) =>
      count(f) + countList(r)
  end
end

check:
  count(vasya) is 3
  count(sveta) is 1
end
```
