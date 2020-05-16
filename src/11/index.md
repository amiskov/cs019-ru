# Infinity I: Lazy Sequences (infinitely long data)
Video: `11_Mon_10_01_18.ts`.

Функции в CS (например, `y(x) = x + 5`):

- Позволяют создавать параметризированные выражения.
- Позволяют задерживать вычисление тела до тех пор, пока не будет предоставлен параметр `x`. Задержать вычисление до тех пор, пока мы не захотим его выполнить.

Orthogonal means completely independent.

Функция может быть выполнена сразу же. Так делаются байндинги. Например, `let`-expression фактически выполняется так:

```lisp
(let ([x 3])
  (+ x x))

;; Under the hood `let` works like this
((λ (x)
   (+ x x)) 3)
```

Задача `let` — дать имя значению `3`, выполнить выражение с этим именем и исчезнуть.

В такого рода функциях мы не используем возможность задержать вычисление.

А чем может быть полезна функция без параметров?

Дальше разговор пойдёт про откладывание вычислений. Например, для формирования больших деревьев, где нужно откладывать формирование всего дерева.

Recursive binding in Pyret:

```pyret
rec ones = link(1, ones)
```

Pyret syntax for a lambda:

```pyret
# Two equal constructions:

{(x): x + 3}(3) # shorter

(lam(x): x + 3 end)(3)
```

Пример потока (stream, lazy list):

```pyret
data Lz<T>:
  | lzlink(e :: T, r :: ( -> Lz<T>))
end

fun fst<T>(s :: Lz<T>) -> T:
  s.e
end

fun rst<T>(s :: Lz<T>) -> Lz<T>:
  s.r()
end

fun take<T>(s :: Lz<T>, n :: Number) -> List<T>:
  if n == 0:
    empty
  else:
    link(fst(s), take(rst(s), n - 1))
  end
end


# Stream of ones: 1, 1, 1, ...
rec ones = 
  lzlink(1,
    {(): ones})

fun natsfrom(n :: Number):
  doc: "Returns a stream of natural numbers."
  lzlink(n, {(): natsfrom(n + 1)})
end

# Stream of natural numbers from 0: 0, 1, 2, ...
nats = natsfrom(0)

check:
  take(ones, 5) is [list: 1, 1, 1, 1, 1]
  take(nats, 5) is [list: 0, 1, 2, 3, 4]
end
```

Lists are finite, streams are infinite.

Thunk is a function with no parameters, like lambda in stream above. Thunk is a lambda with no arguments.

Индукция и программирование по индукции не работает на потоках, потому что нет базового случая. Тут работает коиндукция.

Примеры мап-функций для одного и двух потоков:

```pyret
fun lzmap<A, B>(
    fn :: (A -> B),
    s :: Lz<A>) -> Lz<B>:
  lzlink(
    fn(fst(s)),
    {(): lzmap(fn, rst(s))})
end

fun lzmap2<A, B, C>(
    fn:: (A, B -> C),
    s1 :: Lz<A>,
    s2 :: Lz<B>) -> Lz<C>:
  lzlink(
    fn(fst(s1), fst(s2)),
    {(): lzmap2(fn, rst(s1), rst(s2))})
end

check:
  take(lzmap({(n): n + 111}, nats), 5) is [list: 111, 112, 113, 114, 115]
  take(lzmap((_ - 1), nats), 5) is [list: -1, 0, 1, 2, 3]
end
```

Базового случая нет, но анонимная функция (thunk) предотвращает бесконечную рекурсию.

С помощью `lzmap2` можно сгенерировать бесконечную последовательность чисел Фибоначчи:

```pyret
rec fib-seq =
  lzlink(0,
    {(): lzlink(1,
        {(): lzmap2({(
                a :: Number,
                b :: Number):
              a + b},
            fib-seq,
            rst(fib-seq))})})

# 0 1 1 2 3 5 ...
#   0 1 1 2 3 ...
#   1 2 3 5 8 ...

check:
  take(fib-seq, 10) is [list: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
end
```

## Материлы
- [13. Functions as Data](https://papl.cs.brown.edu/2019/func-as-data.html), PAPL.
