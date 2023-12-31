Процедура ПриЗаписи(Отказ)
	
Если ОбменДанными.Загрузка Тогда
     Возврат;
КонецЕсли;

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Договоры.Ссылка
	|ИЗ
	|	Справочник.Договоры КАК Договоры
	|ГДЕ
	|	Договоры.Владелец = &Владелец";

	Запрос.УстановитьПараметр("Владелец", Ссылка);

	РезультатЗапроса = Запрос.Выполнить();
	
//	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
//	
//	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
//		// Вставить обработку выборки ВыборкаДетальныеЗаписи
//	КонецЦикла;

	Если РезультатЗапроса.Пустой() Тогда
		НовыйДоговор = Справочники.Договоры.СоздатьЭлемент();
		НовыйДоговор.Наименование = "Договор с " + Строка(Ссылка);
		НовыйДоговор.Владелец = Ссылка;
		НовыйДоговор.Записать();
	КонецЕсли;
КонецПроцедуры