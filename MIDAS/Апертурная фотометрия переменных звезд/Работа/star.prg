ECHO/OFF

SET/MIDAS_SYSTEM DPATH=../Данные/J
DEFINE/LOCAL R_2/I/1/1 2
DEFINE/LOCAL R_3/I/1/1 2

DEFINE/PARAMETER P1 + I ! Изображение
DEFINE/PARAMETER P2 + N ! Начать снова?
DEFINE/PARAMETER P3 + N ! Выключить ожидание?
DEFINE/PARAMETER P4 + N ! Номер изображения

WRITE/OUT
WRITE/OUT "    " Запущена процедура star.prg для объекта {P1}
WRITE/OUT

IF P1 .EQ. "+" THEN

    WRITE/OUT "     Не было передано изображение в качестве аргумента."
    WRITE/OUT

    RETURN

ELSEIF P2 .NE. "+" .AND. P2 .NE. "1" THEN

    IF P2 .NE. "0" THEN

        WRITE/OUT "     Недопустимое значение второго аргумента."
        WRITE/OUT

        RETURN

    ENDIF

ELSEIF P3 .NE. "+" .AND. P3 .NE. "1" THEN

    IF P3 .NE. "0" THEN

        WRITE/OUT "     Недопустимое значение третьего аргумента."
        WRITE/OUT

        RETURN

    ENDIF

ELSEIF P4 .EQ. "+" THEN

    P4 = 1

ENDIF

CLEAR/DISPLAY
LOAD/IMA {P1} CUTS=F SCALE=F

WRITE/OUT "     Определение размера апертуры."
WRITE/OUT

CENTER/GAUSS CURSOR FWHM

CLEAR/DISPLAY

IF P3 .EQ. "+" .OR. P3 .EQ. "0" THEN

    WRITE/OUT
    WRITE/OUT "     Ждем 5 секунд, чтобы было время прекратить выполнение в случае ошибки."
    WRITE/OUT

    WAIT/SECS 5

ENDIF

STAT/TAB FWHM.tbl :XFWHM
DEFINE/LOCAL XFWHM_MEAN/D/1/1 {OUTPUTR(3)}

WRITE/OUT

STAT/TAB FWHM.tbl :YFWHM
DEFINE/LOCAL YFWHM_MEAN/D/1/1 {OUTPUTR(3)}

DEFINE/LOCAL FWHM_MEAN/D/1/1
FWHM_MEAN = ({XFWHM_MEAN} + {YFWHM_MEAN})/2

DEFINE/LOCAL R_1/I/1/1
R_1 = M$NINT(3 * {FWHM_MEAN} / 0.000288 + 1 + 1) ! Ещё единица для округления в большую сторону

WRITE/OUT
WRITE/OUT "    " Размер апертуры будет положен равным {R_1}
WRITE/OUT

LOAD/IMA {P1} CUTS=F SCALE=F

WRITE/OUT "     Измерение потока переменной звезды (ПКМ после выбора)."
WRITE/OUT

IF P2 .EQ. "+" .OR. P2 .EQ. "0" THEN
    MAGNITUDE/CIRCLE ? var.tbl @{R_1},@{R_2},@{R_3} A 1 2
ELSE
    MAGNITUDE/CIRCLE ? var.tbl @{R_1},@{R_2},@{R_3} ? 1 2
ENDIF


WRITE/OUT
WRITE/OUT "     Результат записан в таблицу var.tbl."
WRITE/OUT

COPY/DKEY {P1} MJD_OBS DATA

IF P2 .EQ. "1" THEN
    CREATE/COLUMN var.tbl :DATA "JD" E24.15 R*8
ENDIF

WRITE/TAB var.tbl :DATA {P4} {DATA}

WRITE/OUT "    " Записана дата {DATA} в строку {P4} таблицы var.tbl.
WRITE/OUT

WRITE/OUT "     Измерение потока первой звезды стандарта (ПКМ после выбора)."
WRITE/OUT

IF P2 .EQ. "+" .OR. P2 .EQ. "0" THEN
    MAGNITUDE/CIRCLE ? st1.tbl @{R_1},@{R_2},@{R_3} A 1 2
ELSE
    MAGNITUDE/CIRCLE ? st1.tbl @{R_1},@{R_2},@{R_3} ? 1 2
ENDIF

WRITE/OUT
WRITE/OUT "     Измерение потока второй звезды стандарта (ПКМ после выбора)."
WRITE/OUT

IF P2 .EQ. "+" .OR. P2 .EQ. "0" THEN
    MAGNITUDE/CIRCLE ? st2.tbl @{R_1},@{R_2},@{R_3} A 1 2
ELSE
    MAGNITUDE/CIRCLE ? st2.tbl @{R_1},@{R_2},@{R_3} ? 1 2
ENDIF
