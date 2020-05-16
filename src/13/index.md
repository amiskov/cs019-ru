# Infinity III: Modeling State, Pong Game (infinitely long programs, part 2)
Video: `13_Fri_10_05_18.ts`.

PID-controller (Proportional Integral Differential controller):

- Cruise-control;
- Thermostat;
- Boat steering system;
- ...

## Reactive Systems
Где-то с 40-й минуты начинается. Очень важно и интересно.

Примеры реактивных систем:

- Browser
- Phone
- Thermostat
- Cruise-control
- ...

Внешний мир влияет на систему: события в браузере, температура меняется для термостата и пр.

Система имеет Event Loop, который контролирует события внешнего мира:

- Tick Event → on-tick → to-draw
- Click Event → on-click → stop
- KeyPress k Event → on-key-press(k) → move-up
- ...

После обработки события результат отсылается обратно во внешний мир.

Наши программы — это в основном ответ на действия из внешней среды (to-draw, move-up и пр.)

Model contains the variant parts of the program.

All the interesting systems are infinite loops: OS, elevators, Car computers etc. World is full of infinite loops and the challenge is to keep them working infinitely long.