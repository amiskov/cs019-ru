# Лекция 2
Лекция начинается с задачи:

> Напишите программу, которая получает на вход массив чисел и возвращает среднее значение чисел больше нуля, которые попадаются до -999.
>
> Write a program that takes a list/array of numbers and produces the average of non-negative numbers that occur before (an optional) `-999`.
>
> Ignore I/O - just take a list/array as input. Use any language you wish.

Эта задача известна в обучении CS, её называют Rainfall problem.

Пример: у нас есть сенсор, который считает количество осадков. Иногда его глючит и он записывает отрицательные значения. Это ок, мы их просто игнорируем. Когда его выключают, он посылает значение `-999`, а то, что идёт потом нам не интересно, потому что это шум.

## Rainfall Considered Harmful.
Начиная с семидесятых эту задачу использовали для проверки навыков студентов. Около 70% решали её с ошибками, писали неуместный код и т.д.

Эта задача — тест на декомпозицию.

Декомпозиция:

- отсечь список до -999
- убрать отрицательные значения
- просуммировать оставшиеся элементы
- посчитать количество элементов
- посчитать среднее
- обработать исключительные ситуации: пустой список, только отрицательные, только -999.

Шрирам показал [видос](https://www.youtube.com/watch?v=GyNqlOjhPCQ) про абстракцию с помощью функций на циклах. Студент ожидаемо задал вопрос про скорость вычисления: что быстрее, `for` или `map`. Шрирам ответил: мы не можем ответить на этот вопрос до тех пор, пока не узнаем, что делает компилятор. Например, в Хаскеле функции mpa/filter/fold становятся оптимизированными циклами при компиляции (см. [deforestation](https://en.wikipedia.org/wiki/Deforestation_(computer_science))).

Использовал переменную с именем sentinel (часовой, страж) (см. район 28-й минуты). Это устоявшаяся [терминология](https://en.wikipedia.org/wiki/Sentinel_value)

map/filter/fold в Хаскеле преобразуются в циклы, это называется [deforestation](https://en.wikipedia.org/wiki/Deforestation_(computer_science)).

## Материалы
- [A Challenge to Computing Education Research: Make Measurable Progress](https://computinged.wordpress.com/2010/08/16/a-challenge-to-computing-education-research-make-measurable-progress/), про rainfall problem.
