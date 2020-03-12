! Отключение вывода команд
ECHO/OFF

! Смена директории для поиска файлов на bias
SET/MIDAS_SYSTEM DPATH=../bias

! Вычисление MeanBias

WRITE/OUT
WRITE/OUT "     Вычисление MeanBias. "
WRITE/OUT

COMPUTE/IMAGE MeanBias = (S13051113.FTS + S13051116.FTS) / 2

! Смена директории для поиска файлов на flats
SET/MIDAS_SYSTEM DPATH=../flats

! Вычитание MeanBias из flats файлов

WRITE/OUT "     Вычитание MeanBias из S13051014.FTS (Flats, 1)"
WRITE/OUT

COMPUTE/IMAGE FlatBias1 = S13051014.FTS - MeanBias

WRITE/OUT "     Вычитание MeanBias из S13051015.FTS (Flats, 2)"
WRITE/OUT

COMPUTE/IMAGE FlatBias2 = S13051013.FTS - MeanBias

! Вычитание MeanBias из файла объекта

WRITE/OUT "     Вычитание MeanBias из S13050712.FTS (Object)"
WRITE/OUT

! Смена директории для поиска файлов на директорию выше
SET/MIDAS_SYSTEM DPATH=../

COMPUTE/IMAGE ObjectBias = S13050712.FTS - MeanBias

! Вычисление MeanFlat

WRITE/OUT "     Вычисление MeanFlat"
WRITE/OUT

COMPUTE/IMAGE MeanFlat = (FlatBias1 + FlatBias2) / 2

! Медианное сглаживание MeanFlat

WRITE/OUT "     Медианное сглаживание MeanFlat"
WRITE/OUT

FILTER/MEDIAN MeanFlat MedFlat 10,10

! Вычисление и вывод максимума на MeanFlat 

WRITE/OUT
WRITE/OUT "     Вывод статистики MeanFlat"
WRITE/OUT

STATISTICS/IMAGE MedFlat OPTION=XS

! Деление исходного плоского поля на среднее MeanFlat

WRITE/OUT
WRITE/OUT "     Деление исходного плоского поля на среднее MeanFlat"
WRITE/OUT

COMPUTE/IMAGE NFlat = MeanFlat / 3.534500e+04

! Деление объекта на нормированное среднее плоское поле

WRITE/OUT "     Деление объекта на нормированное среднее плоское поле"

COMPUTE/IMAGE ObjectFlat = ObjectBias / NFlat

! Создание таблицы с координатами образца фона

CREATE/TABLE BackgroundCoords 4 1

CREATE/COLUMN BackgroundCoords XSTART "pixel" I6 I*4
CREATE/COLUMN BackgroundCoords YSTART "pixel" I6 I*4

CREATE/COLUMN BackgroundCoords XEND "pixel" I6 I*4
CREATE/COLUMN BackgroundCoords YEND "pixel" I6 I*4

WRITE/TABLE BackgroundCoords :XSTART @1 719
WRITE/TABLE BackgroundCoords :YSTART @1 657

WRITE/TABLE BackgroundCoords :XEND @1 759
WRITE/TABLE BackgroundCoords :YEND @1 697

! Открыть изображение объекта

CLEAR/DISPLAY
LOAD/IMAGE ObjectFlat cuts=1000,6000 scale=2

! Интерполяция фона в область объекта

WRITE/OUT
WRITE/OUT "     Интерполяция фона в область объекта"
WRITE/OUT

FIT/FLAT ObjectInterpolated = ObjectFlat CURSOR 1,1 SkyFrame.bdf

! Запись данных из шапки объекта
DEFINE/LOCAL z/D/1/1 43.9D0 ! Зенитное расстояние объекта
DEFINE/LOCAL t/D/1/1 300.D0 ! Время экспозиции  сек.
DEFINE/LOCAL S/D/1/1 0.357D0 ! Площадь пиксела в кв. угл. секундах

! Приведение яркости пиксела к 
! единичной площадке в единицу
! времени в зв. величинах

WRITE/OUT
WRITE/OUT "     Приведение яркости пиксела к"
WRITE/OUT "     единичной площадке в единицу"
WRITE/OUT "     времени в зв. величинах"
WRITE/OUT

COMPUTE/IMAGE ObjectMu = -2.5 * LOG(ObjectInterpolated / {t}) + 2.5 * LOG({S})

! Запись коэффициента поглощения в текущей цветовой полосе
DEFINE/LOCAL K_B/D/1/1 0.34

! Вынос за атмосферу

WRITE/OUT "     Вынос за атмосферу"
WRITE/OUT

COMPUTE/IMAGE ObjectZ = ObjectMu - {K_B} / COS({z})

! Запись константы стандартизации
DEFINE/LOCAL C_UGC1198_B/D/1/1 26.5

! Стандартизация

WRITE/OUT "     Приведение в стандартную систему звёздных величин"
WRITE/OUT

COMPUTE/IMAGE ObjectC = ObjectZ + {C_UGC1198_B}

! Построение изофот

CREAT/GRA
PLOT/CONT ObjectC [@412,@427:@604,@612] ? 19:26:1 ? 1

