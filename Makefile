
     ## Это шаблон make-файла для публикации кода на GitHub.

     ## Репозиторий на GitHub: https://github.com/Paveloom/B1
     ## Документация: https://www.notion.so/paveloom/B1-fefcaf42ddf541d4b11cfcab63c2f018

     ## Версия релиза: 2.1.2
     ## Версия документации: 2.1.0

     ## Автор: Павел Соболев (http://paveloom.tk)

     ## Для корректного отображения содержимого
     ## символ табуляции должен визуально иметь
     ## ту же длину, что и пять пробелов.

     # Настройки make-файла

     ## Имя координатора
     make_name := make

     ## Заглушка на вывод сообщений указанными правилами
     ## (без указания имён подавляет вывод со стороны make-файла у всех правил)

     .SILENT :

     ## Правила-псевдоцели
     .PHONY : git, git-am, git-new, git-clean

     ## Правило, выполняющееся при вызове координатора без аргументов
     ALL : git



     # Блок правил для разработки и публикации кода на GitHub

     ## Имя пользователя на GitHub
     username := Paveloom

     ## Сообщение стартового коммита
     start_message := "Стартовый коммит."

     ## Правило для создания и публикации коммита

     git :
	      git add -A
	      git commit -e
	      git push

     ## Правило для обновления последнего коммита до текущего состояния локального репозитория

     git-am :
	         git add -A
	         git commit --amend
	         git push --force-with-lease

     ## Правило для подключения удалённого репозитория и
     ## загрузки в него стартового make-файла

     ifeq (git-new, $(firstword $(MAKECMDGOALS)))
          new_rep := $(wordlist 2, 2, $(MAKECMDGOALS))
          $(eval $(new_rep):;@#)
     endif

     git-new :
	          $(make_name) git-clean
	          git init
	          git remote add origin git@github.com:$(username)/$(new_rep).git
	          git add Makefile
	          git commit -m $(start_message)
	          git push -u origin master

     ## Правило для удаления репозитория в текущей директории

     git-clean :
	            rm -rf .git

     # Правило для создания архивов

     archive :
	          zip -q "Публикация кода на GitHub.zip" "Публикация кода на GitHub"
	          zip -qr Make-файлы.zip ../Make-файлы/
