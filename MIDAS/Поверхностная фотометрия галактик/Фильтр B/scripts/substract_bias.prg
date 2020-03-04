! Отключение вывода команд
ECHO/OFF

! Смена директории для поиска файлов на bias
SET/MIDAS_SYSTEM DPATH=bias

! Вычисление MeanBias

WRITE/OUT
WRITE/OUT "     Вычисление MeanBias. "
WRITE/OUT

COMPUTE/IMAGE MeanBias = (S13051115.FTS + S13051116.FTS) / 2

! Смена директории для поиска файлов на flats
SET/MIDAS_SYSTEM DPATH=flats

! Вычитание MeanBias из flats файлов

WRITE/OUT
WRITE/OUT "     Вычитание MeanBias из S13051014.FTS (Flats, 1)"
WRITE/OUT

COMPUTE/IMAGE FlatBias1 = S13051014.FTS - MeanBias

WRITE/OUT
WRITE/OUT "     Вычитание MeanBias из S13051015.FTS (Flats, 2)"
WRITE/OUT

COMPUTE/IMAGE FlatBias2 = S13051015.FTS - MeanBias

! Вычитание MeanBias из файла объекта

WRITE/OUT
WRITE/OUT "     Вычитание MeanBias из S13050712.FTS (Object)"
WRITE/OUT

COMPUTE/IMAGE ObjectBias = S13050712.FTS - MeanBias

! Вычисление MeanFlat

WRITE/OUT
WRITE/OUT "     Вычисление MeanFlat"
WRITE/OUT

COMPUTE/IMAGE MeanFlat = (FlatBias1 + FlatBias2) / 2

! Медианное сглаживание MeanFlat

WRITE/OUT "     Медианное сглаживание MeanFlat"
WRITE/OUT

FILTER/MEDIAN MeanFlat MedFlat 10, 10

! Вычисление и вывод максимума на MeanFlat 

WRITE/OUT
WRITE/OUT "     Вычисление и вывод максимума на MeanFlat"
WRITE/OUT

STATISTICS/IMAGE MedFlat OPTION=MS

! Деление исходного плоского поля на максимум MeanFlat

WRITE/OUT
WRITE/OUT "     Деление исходного плоского поля на максимум MeanFlat"
WRITE/OUT

COMPUTE/IMAGE NFlat = MeanFlat / 3.027000e+04

! Деление объекта на нормированное среднее плоское поле

WRITE/OUT "     Деление объекта на нормированное среднее плоское поле"
WRITE/OUT

COMPUTE/IMAGE ObjectFlat = ObjectBias / NFlat