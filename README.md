# MachanismsOOP
Задание №1:
Реализовать подсчет определителя матрицы N x N. Алгоритм по созданию матрицы и подсчету определителя обернуть в class, struct или enum, соответствующий протоколу MatrixTestable. Конструктор должен получать на вход размерность матрицы, и замыкание преобразующее координаты элемента в значение. Например, номер колонки умноженный на два минус номер строки.
protocol MatrixTestable  

    // Constructor
    // dimension: Matrix size
    init(dimension: Int)
    // Determinant calculating function
    func determinant() -> Int
    
/*Задание№2:
Реализовать перечисление кодов состояния http (10 любых) с исходным значением кода ошибки и хранимым значением описания ошибки

Задание№3:
Реализовать в программе логику проведения футбольного (или любого другого) турнира в соответствии со следующими требованиями: - Генерируются 12 случайных команд. Команда имеет название и позицию в рейтинге. - Программа генерирует расписание турнира так, чтобы каждая команда сыграла со всеми другими дважды. Расписание представляет собой список строк, вида "(команда 1) vs. (команда 2): (очки первой команды)-(очки второй команды). День: (номер дня)." - Расписание должно соответствовать следующим требованиям: - в один день не может быть более двух матчей; - одна и та же команда не может играть два дня подряд; - результаты матчей определяются случайно (очки команды в диапазоне [0, 7]). - Должна быть возможность запросить рейтинговую таблицу команд на любой из матчевых дней, вывести расписание всех сыгранных матчей вплоть до определенного дня - Программа должна отдельно выводить тройку призеров и их счет на последний день турнира. Если на момент окончания турнира на первых местах команды с одинаковым числом очков, то их порядок определяется по алфавиту (по названию команды).*/

