! Подавление вывода команд
ECHO/OFF

! [Определение параметров]

! Коэффициенты квадратного уравнения

DEFINE/PARAMETER P1 + N
DEFINE/PARAMETER P2 + N
DEFINE/PARAMETER P3 + N

! Определение максимального числа параметров
DEFINE/MAXPAR 3

! Проверка, заданы ли параметры

IF P1 .EQ. "+" THEN
     
     WRITE/OUT
     WRITE/OUT "     Не был передан в качестве параметра коэффициент a "
     WRITE/OUT "     — выполнение процедуры остановлено."
     WRITE/OUT

     RETURN

ELSEIF P2 .EQ. "+" THEN

     WRITE/OUT
     WRITE/OUT "     Не был передан в качестве параметра коэффициент b "
     WRITE/OUT "     — выполнение процедуры остановлено."
     WRITE/OUT

     RETURN

ELSEIF P3 .EQ. "+" THEN

     WRITE/OUT
     WRITE/OUT "     Не был передан в качестве параметра коэффициент c "
     WRITE/OUT "     — выполнение процедуры остановлено."
     WRITE/OUT

     RETURN

ENDIF

! [Инициализация переменных]

! Вершина параболы
DEFINE/LOCAL TIP/D/1/1 0.D0

! Значение 1.D0 / (2.D0 * a)
DEFINE/LOCAL DAI/D/1/1 0.D0

! Корень из дискриминанта, деленный на 2.D0 * a
DEFINE/LOCAL DSD/D/1/1 0.D0

! Корни квадратного уравнения

DEFINE/LOCAL X1/D/1/1 0.D0
DEFINE/LOCAL X2/D/1/1 0.D0

! [Вычисления]

! Вычисление значения 1.D0 / (2.D0 * a)
DAI = 1.D0 / (2.D0 * {P1})

! Вычисление вершины параболы
TIP = -{P2} * {DAI}

! Вычисление корня из дискриминанта
DSD = M$SQRT( {P2} * {P2} - 4.D0 * {P1} * {P3} ) * {DAI}

! [Проверка на знак дискриминанта]

IF {DSD} .LT. 0.D0 THEN

     ! Вывод сообщения об отсутствии решения

     WRITE/OUT
     WRITE/OUT "     Дискриминант меньше нуля, решений нет."
     WRITE/OUT

ELSEIF {DSD} .GT. 0.D0 THEN

     ! Вычисление первого корня
     X1 = {TIP} + {DSD}

     ! Вычисление второго корня
     X2 = {TIP} - {DSD}

     ! Вывод результата

     WRITE/OUT
     WRITE/OUT "     Решение: "
     WRITE/OUT
     WRITE/OUT "     X1 =" {X1}
     WRITE/OUT "     X2 =" {X2}
     WRITE/OUT

ELSE

     ! Вычисление корня
     X1 = {TIP} + {DSD}

     ! Вывод результата

     WRITE/OUT
     WRITE/OUT "     Решение: "
     WRITE/OUT
     WRITE/OUT "     X =" {X1}
     WRITE/OUT

ENDIF