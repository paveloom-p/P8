! Отключение вывода команд
ECHO/OFF

! Смена директории для поиска файлов на bias
SET/MIDAS_SYSTEM DPATH=bias

! Вычисление среднего bias

WRITE/OUT
WRITE/OUT "     Вычисление MeanBias. "
WRITE/OUT

COMP/IMA MeanBias = (S13051115.FTS + S13051116.FTS) / 2

! Смена директории для поиска файлов на flats
SET/MIDAS_SYSTEM DPATH=flats

! Вычитание MeanBias из flats файлов.

WRITE/OUT
WRITE/OUT "     Вычитание MeanBias из S13051014.FTS (Flats, 1). "
WRITE/OUT

COMP/IMA FlatBias1 = S13051014.FTS - MeanBias

WRITE/OUT
WRITE/OUT "     Вычитание MeanBias из S13051015.FTS (Flats, 2). "
WRITE/OUT

COMP/IMA FlatBias2 = S13051015.FTS - MeanBias

! Вычитание MeanBias из файла объекта.

WRITE/OUT
WRITE/OUT "     Вычитание MeanBias из S13050712.FTS (Object). "
WRITE/OUT

COMP/IMA ObjectBias = S13050712.FTS - MeanBias