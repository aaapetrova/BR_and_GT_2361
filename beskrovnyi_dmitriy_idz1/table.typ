#set text(size: 12pt, lang: "ru", hyphenate: true)

#set page(margin: (1cm), flipped: true)

#figure(
  placement: top, caption: [Свойства бинарных отношений.], table(
    columns: (13%, 12%, 12%, 12%, 12%, 12%, 12%), align: (center + horizon), [], "Рефлексивность", "Транзитивность", "Симметричность", "Асимметричность", "Антисимметричность", "Aрефлексивность",
    //ro
    [Описание], $ forall a in M: \
    f(a, a) = 1 $, $ forall a, b, c in M:\
    cases(f(a, b) = 1, f(b, c) = 1) \
    => f(a, c) = 1 $, $ forall a, b in M: \
    f(a, b) = 1 <=> \
    f(b, a) = 1 $, $ forall a, b in M: \
    f(a, b) = 1 => \
    f (b, a) = 0 $, $ forall a, b in M:\
    cases(f(a, b) = 1, f(b, a) = 1) \
    => a = b $, $ forall a in M: \
    f(a, a) = 0 $,
    //row
    "Толерантность", $ #sym.checkmark $, "", $ #sym.checkmark $, "", "", "",
    //row
    "Эквивалентность", $ #sym.checkmark $, $ #sym.checkmark $, $ #sym.checkmark $, "", "", "",
    //row
    "Предпорядок", $ #sym.checkmark $, $ #sym.checkmark $, "", "", "", "",
    //row
    "Частичный
        (нестрогий)
        порядок", $ #sym.checkmark $, $ #sym.checkmark $, "", "", $ #sym.checkmark $, "",
    ///row
    $ "Линейный
        порядок"\
    forall a, b in M:\
    f(a, b) union f(b, a) = 1\
    + $, $ #sym.checkmark $, $ #sym.checkmark $, "", "", $ #sym.checkmark $, "",
    //row
    "Строгий порядок", "", $ #sym.checkmark $, "", $ #sym.checkmark $, "", $ #sym.checkmark $,
    //row
    "Матрица", "'1' на главной диагонали", $cases(m_ (i\,j) = 1, m_ (j\,k) = 1) =>\ m_ (i,k) = 1$, $A = A^T$, "ни одной 1 на главной диагонали, при транспонировании все 1->0", "'1' могут быть только на главной диагонали", "'0' на главной диагонали",
    //row
    "Граф", "петли на всех вершинах", "Если есть путь длины n, то есть путь длины 1", "двунаправленные рёбра (все дуги — рёбра)", "Нет петель и двунаправленных рёбер", "Могут быть петли, но не двунаправленные рёбра", "Без петель",
  ),
)

