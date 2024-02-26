#import "head.typ": *
#import "@preview/diagraph:0.2.1": *

#show: doc => conf(
  title: "
              Студент: Бескровный Дмитрий
              Группа: 2361
              Вариант: 52
              Дата: 21.02.2024", subject: [Комбинаторика и теория графов], hwNumber: 1, doc,
)

#show "б. о.": "бинарное отношение"
#let M = (98, 67, 18, 51, 86, 87, 24, 56).sorted()
#task(
  tasknum: "(вводные данные)",
)[
  Дано множество $M = $ {#str(M.map((x) => str(x)).join(", "))} и следующие
  бинарные отношения на нём:
  $ F_1(x, y) = 1 <=> exists z in M: (x - z)(y - z) < 0 $
  $ F_2(x, y) = 1 <=> x >= y "поразрядно" $
  $ F_3(x, y) = 1 <=> [x/3] = [y/3] $
  $ F_4(x, y) = 1 <=> x^2 - y^3 "нечётно" $
  $ F_5(x, y) = 1 <=> |x - y| < 5 $
  Задания подразумевают выполнение для каждого из отношений.
]

Нумерация соответствует нумерации отношений. Дополнительные пояснения приведены
в приложении (код #sym.dash.em в файле ``` table.typ```).

#let basic_data = (
  range(M.len() + 1), range(M.len() + 1), range(M.len() + 1), range(M.len() + 1), range(M.len() + 1), range(M.len() + 1), range(M.len() + 1), range(M.len() + 1), range(M.len() + 1),
)
#{
  basic_data.at(0).at(0) = "x/y"
  for i in range(M.len()){
    for j in range(M.len()){
      //header
      basic_data.at(i + 1).at(0) = M.at(i)
      basic_data.at(0).at(j + 1) = M.at(j)
    }
  }
}
#let rel_1_constructor = () => {
  let data_1 = basic_data
  let graph_1 = ""
  let flag = 0
  for i in range(M.len()){
    let x = M.at(i)
    for j in range(M.len()){
      let y = M.at(j)
      flag = 0
      for k in range(M.len()){
        let z = M.at(k)
        if (x - z) * (y - z) < 0 {
          flag = 1
          graph_1 += str(x) + "->" + str(y) + "\n"
          break
        }
      }
      data_1.at(i + 1).at(j + 1) = flag
    }
  }
  return (data_1, graph_1)
}
#let rel_2_constructor = () =>{
  let data_2 = basic_data
  let graph_2 = ""
  for i in range(M.len()){
    let x = M.at(i)
    for j in range(M.len()){
      let y = M.at(j)
      let res = str(x) >= str(y)
      data_2.at(i + 1).at(j + 1) = int(res)
      if (res) { graph_2 += str(x) + "->" + str(y) + "\n" }
    }
  }
  return (data_2, graph_2)
}

#let rel_3_constructor = () => {
  let data_3 = basic_data
  let graph_3 = ""
  for i in range(M.len()){
    let x = M.at(i)
    for j in range(M.len()){
      let y = M.at(j)
      let res = int(x / 3) == int(y / 3)
      data_3.at(i + 1).at(j + 1) = int(res)
      if (res) { graph_3 += str(x) + "->" + str(y) + "\n" }
    }
  }
  return (data_3, graph_3)
}
#let rel_4_constructor = () => {
  let data_4 = basic_data
  let graph_4 = ""
  for i in range(M.len()){
    let x = M.at(i)
    for j in range(M.len()){
      let y = M.at(j)
      let res = calc.rem(calc.abs((x * x - calc.pow(y, 3))), 2) == 1
      data_4.at(i + 1).at(j + 1) = int(res)
      if (res) { graph_4 += str(x) + "->" + str(y) + "\n" }
    }
  }
  return (data_4, graph_4)
}
#let rel_5_constructor = () => {
  let data_5 = basic_data
  let graph_5 = ""
  for i in range(M.len()){
    let x = M.at(i)
    for j in range(M.len()){
      let y = M.at(j)
      let res = calc.abs(x - y) < 5
      data_5.at(i + 1).at(j + 1) = int(res)
      if (res) { graph_5 += str(x) + "->" + str(y) + "\n" }
    }
  }
  return (data_5, graph_5)
}
#let explanation_1(ref: "", aref: "", trans: "", symm: "", asymm: "", antisymm: "") = grid(
  columns: 2, gutter: 4pt, column-gutter: 2pt, "Рефлексивность: ", ref + ".", "Арефлексивность: ", aref + ".", "Транзитивность: ", trans + ".", "Симметричность: ", symm + ".", "Асимметричность: ", asymm + ".", "Антисимметричность: ", antisymm + ".",
)
#let explanation_3(eq: "", part_o: "", lin_o: "", strict_o: "") = grid(
  columns: 2, gutter: 4pt, column-gutter: 2pt, "Эквивалентность: ", eq + ".", "Частичный порядок: ", part_o + ".", "Линейный порядок: ", lin_o + ".", "Строгий порядок: ", strict_o + ".",
)

#task(
  tasknum: 1,
)[
  Проверить, является ли б. о. рефлексивным, арефлексивным, симметричным,
  антисимметричным, асимметричным, транзитивным (с обоснованием).
]

#proof(
  )[

  Составим матрицы бинарных отношений и воспользуемся таблицей. Здесь и далее
  строка соответствует y, стобец #sym.dash.em x.

  #counter(math.equation).update(0)
  #grid(
    columns: 2, gutter: 5pt, column-gutter: 11pt, {
      let m1 = math.mat(..rel_1_constructor().at(0))
      $ m1 $
    }, explanation_1(
      ref: "нет, 0 на главной диагонали", aref: "да, 0 на главной диагонали", trans: "нет, " + $F_1(56, 18) = F_1(18, 67) = 1$ + ", но " + $F_1(56, 67) = 0$, symm: "да, матрица равна своей транспонированной", asymm: "нет, все 1 симметричны 1", antisymm: "нет, " + $F_1(18, 51) = F_1(51, 18)$ + ", но " + $18 != 51$,
    ), {
      let m2 = math.mat(..rel_2_constructor().at(0))
      $ m2 $
    }, explanation_1(
      ref: "да, 1 на главной диагонали", aref: "нет, 1 на главной диагонали", trans: "да, по определению", symm: "нет, матрица не равна своей транспонированной", asymm: "нет, есть 1 на главной диагонали", antisymm: "да, по определению",
    ), {
      let m3 = math.mat(..rel_3_constructor().at(0))
      $ m3 $
    }, explanation_1(
      ref: "да, 1 на главной диагонали", aref: "нет, 1 на главной диагонали", trans: "да, 1 только на главной диагонали", symm: "да, матрица равна своей транспонированной", asymm: "нет, на главной диагонали есть 1", antisymm: "да, по определению",
    ), {
      let m4 = math.mat(..rel_4_constructor().at(0))
      $ m4 $
    }, explanation_1(
      ref: "нет, 0 на главной диагонали", aref: "да, 0 на главной диагонали", trans: "нет, " + $F_4(67, 24) = F_4(24, 51) = 1$ + ", но " + $F_4(67, 51) = 0$, symm: "да, матрица равна своей транспонированной", asymm: "нет, все 1 симметричны 1", antisymm: "нет, " + $F_4(54, 21) = F_4(21, 54) = 1$ + ", но " + $24 != 51$,
    ), {
      let m5 = math.mat(..rel_5_constructor().at(0))
      $ m5 $
    }, explanation_1(
      ref: "да, 1 на главной диагонали", aref: "нет, 1 на главной диагонали", trans: "да, по определению", symm: "да, матрица равна своей транспонированной", asymm: "нет, на главной диагонали есть единицы", antisymm: "нет, " + $F_5(86, 87) = F_5(87, 86) = 1$ + ", но " + $86 != 87$,
    ),
  )
]

#task(tasknum: 2)[
  Построить матрицу и граф этого бинарного отношения.
]

#proof(
  )[
  Матрицы были построены в предыдущем задании.
  + #render(engine: "circo", "digraph { " + rel_1_constructor().at(1) + " }")
  + #render(engine: "circo", "digraph { " + rel_2_constructor().at(1) + " }")
  + #render(engine: "circo", "digraph { " + rel_3_constructor().at(1) + " }")
  + #render(engine: "circo", "digraph { " + rel_4_constructor().at(1) + " }")
  + #render(engine: "circo", "digraph { " + rel_5_constructor().at(1) + " }")
]

#task(
  tasknum: 3,
)[
  Определить, является ли это б. о. отношением эквивалентности, частичного
  порядка, линейного порядка, строгого порядка (с обоснованием).
]

#proof(
  )[
  Соответствие наборов свойств бинарных отношений и их типов см. в таблице.
  #grid(
    columns: 2, gutter: 4%, column-gutter: 5%, text(
      )[1. #explanation_3(
          eq: "нет, нет рефлексивности", part_o: "нет, нет рефлексивности", lin_o: "нет, нет рефлексивности", strict_o: "нет, нет транзитивности",
        )], text(
      )[2. #explanation_3(
          eq: "нет, нет транзитивности", part_o: "да", lin_o: "да, " + $forall a, b in M: F_1(a, b) union F_1(b, a) = 1 $, strict_o: "нет, нет асимметричности",
        )], text(
      )[3. #explanation_3(
          eq: "да", part_o: "да", lin_o: "нет, " + $F_3(18, 24) union F_3(24, 18) = 0$, strict_o: "нет, нет арефлексивности",
        )], text(
      )[4. #explanation_3(
          eq: "нет, нет рефлексивности", part_o: "нет, нет рефлексивности", lin_o: "нет, нет рефлексивности", strict_o: "нет, нет транзитивности",
        )], text(
      )[5. #explanation_3(
          eq: "да", part_o: "нет, нет антисимметричности", lin_o: "нет, нет антисимметричности", strict_o: "нет, нет арефлексивности",
        )],
  )
]

#task(tasknum: 4)[
  Если это отношение эквивалентности, построить классы эквивалентности
]

#proof(
  )[
  3. В силу того что целые части от деления на 3 всех элементов $M$ различны, $F_3$ можно
    рассматривать как отношение равенства на этом множестве; для него существует
    единственный тривиальный вариант разбиения:\ $M\/F_3 = {$
    #for x in M{
      "{" + str(x) + "}"
      if (x != M.at(-1)) {
        ", "
      }
    }
    $}$.
  5. Модуль разности 86 и 87 меньше 5, в то время как модули разности остальных чисел
    больше. Таким образом получаем следующее фактор-множество:\
    $M\/F_5 = { {86, 87}, {18, 24, 51, 56, 67, 98} }$.
]

#task(
  tasknum: 5,
)[
  Если это отношение частичного порядка, применить алгоритм топологической
  сортировки и получить отношение линейного порядка.
]

#proof(
  )[
  2. Начиная с вершины 86, проведём поиск в глубину, получим следующий порядок
    вершин: 18, 24, 51, 56, 67, 86, 87, 98. Пронумеруем их в обратном порядке,
    получим один из вариантов топологической сортировки для этого графа: 98, 87, 86,
    67, 56, 51, 24, 18.

    Это уже отношение линейного порядка.
  3. Имеем дело с вырожденным случаем, когда поиск в глубину равносилен перебору
    вершин. Построим его, начиная с вершины 98: 98, 87, 86, 67, 56, 51, 24, 18. Один
    из вариантов топологической сортировки: 18, 24, 51, 56, 67, 86, 87, 98.

    Чтобы отношение стало отношением линейного порядка, необходимо, чтобы все
    вершины были соединены рёбрами, но не двунаправленными, и сохранялось
    транзитивное свойство. Следующий граф будет удовлетворять заданным условиям:
    #let graph_5_1 = ""
    #for i in range(M.len()){
      for j in range(i, M.len()){
        graph_5_1 += str(M.at(i)) + "->" + str(M.at(j)) + "\n"
      }
    }
    #render(engine: "circo", "digraph{ " + graph_5_1 + "}")
]

#task(
  tasknum: 6,
)[
  Если это нетранзитивное отношение, построить транзитивное замыкание, используя
  алгоритм Уоршелла.
]

#proof(
  )[
  Используем классическую реализацию: выбираем i-ю строку и i-й столбец матрицы ($i in (1, n)$, $n$ #sym.dash.em количество
  столбцов (строк) в матрице); остальные элементы становятся 1, если на обоих "перпедикулярах",
  опущенных на выбранные столбцы, стоят 1.
  #let worshell = (mat) => {
    for i in range(1, mat.len()){
      for j in range(1, mat.len()){
        for k in range(1, mat.len()){
          if (mat.at(j).at(i) * mat.at(i).at(k) == 1) {
            mat.at(j).at(k) = 1
          }
        }
      }
    }
    math.mat(..mat)
  }

  1. #math.mat(..rel_1_constructor().at(0)) $->$ #worshell(rel_1_constructor().at(0)).
  \
  4. #math.mat(..rel_4_constructor().at(0)) $->$ #worshell(rel_4_constructor().at(0)).
]
