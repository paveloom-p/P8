
     # Make-файл с правилами для запуска
     # MIDAS в текущей директории и для 
     # очистки файлов последней сессии

     # Заглушка
     .SILENT :

     # Правило по умолчанию
     .ALL : launch

     # Правило для запуска MIDAS в текущей директории

     launch : 
	         inmidas -m .

     # Список паттернов
     patterns := .inmidas* FOR*.KEY FOR*.LOG Midas_info* midtemp*.prg

     # Сбор файлов
     files := $(wildcard $(patterns))

     # Правило для удаления файлов сессии

     clean : 
	        rm $(files)