# Infinity II: Animations (infinitely long programs, part 1)
Video: `12_Wed_10_3_18.ts`.

Термины Model (или State) — основа программы/системы. Её самые главные данные.

Модель отделена от представления, потому что так гораздо проще:

- меняющиеся данные вынесены отдельно;
- легко делать тестирование, что очень сложно, если бы просто менялись картинки (функция не Model->Img, а Img->Img);
- дебажить проще: логика в модели дебажится отдельно, рендеринг — отдельно.

Это MVC, роль контроллера выполняет встроенная функция `interact`.

Пример интерактивной программы:

```pyret
include reactors
include image

UFO = image-url("https://cs.brown.edu/~sk/tmp/ufo.png")
BG = rectangle(400, 400, "solid", "gray")
INIT = { x: 10, y: 10 }

type Pos = { x :: Number, y :: Number }

fun update(p :: Pos) -> Pos:
  { x: p.x + 3,
    y: p.y + 5 }
where:
  update({x: 2, y: 3}) is {x: 5, y: 8}
end

fun drawer(p :: Pos) -> Image:
  place-image(UFO, p.x, p.y, BG)
end

fun stopper(p :: Pos) -> Boolean:
  (p.x < 0) or (p.x > 200) or (p.y < 0) or (p.y > 300)
end

fun typer(p :: Pos, k :: String) -> Pos:
  ask:
    | k == "up" then: {x: p.x, y: p.y - 10}
    | k == "down" then: {x: p.x, y: p.y + 10}
    | otherwise: p
  end
end

r = reactor:
  init: INIT,
  on-tick: update,
  to-draw: drawer,
  stop-when: stopper,
  on-key: typer
end

# interact(r)
# interact-trace(r)
```