&НаКлиентеНаСервереБезКонтекста
Процедура ИзменитьСумму(ТекСтрока)
	ТекСтрока.Сумма = ТекСтрока.Цена * ТекСтрока.Количество;
КонецПроцедуры

&НаКлиенте
Процедура Подбор(Команда)
	Парам = Новый Структура();
	Парам.Вставить("Склад", Объект.Склад);
	Парам.Вставить("АдресВХ", ПолучитьАдресВХ());
	ОткрытьФорму("Документ.ПродажаТоваров.Форма.ФормаПодбора", Парам, ЭтаФорма);
КонецПроцедуры


&НаКлиенте
Процедура ДатьСкидкуВМО(Команда)
	ДатьСкидкуВМОНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДатьСкидкуВМОНаСервере()
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	ДокументОбъект.ДатьСкидкуОбъект();
	ЗначениеВРеквизитФормы(ДокументОбъект, "Объект");
КонецПроцедуры


&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	ТекущийОбъект.СуммаДокумента = Объект.Товары.Итог("Сумма");
КонецПроцедуры


&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	ТекСтрока = Элементы.Товары.ТекущиеДанные;
	ИзменитьСумму(ТекСтрока);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	ТекСтрока = Элементы.Товары.ТекущиеДанные;
	ИзменитьСумму(ТекСтрока);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыТоварПриИзменении(Элемент)
	ТекСтрока = Элементы.Товары.ТекущиеДанные;
	Товар = ТекСтрока.Товар;
	ТекСтрока.Цена = ПолучитьЦенуТовара(Товар);
	ИзменитьСумму(ТекСтрока);
КонецПроцедуры

&НаКлиенте
Процедура ДатьСкидку(Команда)
	ДатьСкидкуНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДатьСкидкуНаСервере()
	Для Каждого стр Из Объект.Товары Цикл
		стр.Цена = стр.Цена * 0.9;
		ИзменитьСумму(стр);
	КонецЦикла;
КонецПроцедуры


&НаСервереБезКонтекста
Функция ПолучитьЦенуТовара(Товар)
	
	Возврат Товар.ЦенаПродажи;
	
КонецФункции

&НаСервере
Функция ПолучитьАдресВХ()
	Возврат ПоместитьВоВременноеХранилище(Объект.Товары.Выгрузить(), УникальныйИдентификатор);
КонецФункции

&НаКлиенте
Процедура ОбработатьПодбор(АдресВХ) Экспорт
	ОбработатьПодборНаСервере(АдресВХ);
КонецПроцедуры

&НаСервере
Процедура ОбработатьПодборНаСервере(АдресВХ)
	Объект.Товары.Загрузить(ПолучитьИзВременногоХранилища(АдресВХ));	
КонецПроцедуры
