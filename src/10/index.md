# Balancing BSTs
Видео: `10_Fri_9_28_18.ts`

На прошлой лекции мы рассмотрели BT и BST, и хотели логарифмическую зависимость при работе со множествами. `log n` или:

$$
T(k) = T(k/2) + c
$$

Худший случай для работы с BST — это одна ветка (когда получается простой список, BST degenerates to give a list). Значения только левые или только правые (сортированные по возрастанию или убыванию):

[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVEI7XG4gICAgUm9vdCgoNSkpLS0-TDEoKDQpKVxuICAgIFJvb3QtLT5SMSgoRW1wdHkpKTtcbiAgICBMMS0tPkwyKCgzKSlcbiAgICBMMS0tPlIxMigoRW1wdHkpKVxuICAgIEwyLS0-TDMoKC4uLikpXG4gICAgTDItLT5SMygoRW1wdHkpKVxuICAgIFxuIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)](https://mermaid-js.github.io/mermaid-live-editor/#/edit/eyJjb2RlIjoiZ3JhcGggVEI7XG4gICAgUm9vdCgoNSkpLS0-TDEoKDQpKVxuICAgIFJvb3QtLT5SMSgoRW1wdHkpKTtcbiAgICBMMS0tPkwyKCgzKSlcbiAgICBMMS0tPlIxMigoRW1wdHkpKVxuICAgIEwyLS0-TDMoKC4uLikpXG4gICAgTDItLT5SMygoRW1wdHkpKVxuICAgIFxuIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)

И в этом случае мы не получим логарифмическую зависимость.

> Last class is basicly a giant piece of trolling.

Нам нужно Balanced Binary Search Tree.

BBST ← BST ← BT, мы можем использовать функционал для BT на BST и на BBST. Но `insert` для BBST, чтобы он был оптимальным, должен быть другим.

При работе с деревьями мы обращаем внимание на следующие параметры:

- размер дерева (количество узлов в дереве)
- высота дерева (какая ветка дерева содержит больше всего узлов)

`k` может быть размером или высотой. Более наглядно рассматривать высоту, будем рассматривать её.

Высоту BT может быть:

- 1 если нет дочерних веток;
- или как `max(left, right + 1)`, если ветки есть.

Отсюда можно дать определение (не до конца точное) сбалансированному дереву: его левые и правые ветки _на всех уровнях_ имеют одинаковую высоту либо отличаются на 1.

Главная наша задача — разобраться с `insert`. Функция должна принимать BBST и возвращать BBST:

```pyret
insert(tree :: BBST, el) -> BBST:
```

Можно взять старый `insert`, который возвращает _почти_ BBST и пропустить то, что он возвращает через балансировку:

```pyret
old_insert(tree :: BBST, el) -> ~BBST:
balance(olomst_bbst :: ~BBST) -> BBST
```

Таким образом композиция `old_insert` и `balance` даст нам желаемую функцию `insert`, которая принимает сбалансированное дерево поиска и возвращает такое же (сохраняет инвариант).

`~BBST` тип, это:

- BST;
- либо BBST, в котором расхождение может быть не на 1, а на 2.

Если вызывать `balance` после каждой вставки и чинить `~BBST`, чтобы получалось `BBST`, то наша задача будет решена:

```pyret
# alias for almost balanced binary search tree
type ~BBST = BBST%(is-off-by-2)

balance(~BBST) -> BBST
```

Рассмотрим вставку в левую ветку, сбалансированная высота которой — `k` и допустимая высота: `k-1` и `k+1`. Случаи, когда высота равна `k` или `k-1` нам подходят, мы просто можем вставить. Если высота `k+1`, то при вставке дерево получится не сбалансированным и этот случай надо обрабатывать.






