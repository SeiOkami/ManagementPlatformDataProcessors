﻿
#Область ПрограммныйИнтерфейс
 
Процедура ОбновитьПлатформенныеОбработки(ТолькоПриСменеВерсииПриложения = Ложь) Экспорт
	
	ВерсияПриложения = УправлениеПлатформеннымиОбработкамиКлиентСервер.ВерсияПриложения();
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВерсияПриложения", ВерсияПриложения);
	
	Если ТолькоПриСменеВерсииПриложения Тогда
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1 1 ИЗ РегистрСведений.ОбновленныеВерсииПриложения ГДЕ ВерсияПриложения = &ВерсияПриложения";
		Если Запрос.Выполнить().Пустой() Тогда
			ТекстСообщения = СтрШаблон("Обновление платформенны обработок для версии приложения %1", ВерсияПриложения);
			УправлениеПлатформеннымиОбработкамиКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Иначе
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Справочники.ПлатформенныеОбработки.ЗаполнитьЭталонныеДанные();
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПлатформенныеОбработки.Ссылка КАК Обработка,
	|	ИменаПодключенияОбработки.ПолныйПуть КАК ПолныйПуть,
	|	ИменаПодключенияОбработки.КлючевоеИмя КАК КлючевоеИмя
	|ИЗ
	|	Справочник.ПлатформенныеОбработки КАК ПлатформенныеОбработки
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВерсииПлатформенныхОбработок КАК ВерсииПлатформенныхОбработок
	|		ПО ПлатформенныеОбработки.Ссылка = ВерсииПлатформенныхОбработок.Владелец
	|			И (ВерсииПлатформенныхОбработок.Родитель = ЗНАЧЕНИЕ(Справочник.ВерсииПлатформенныхОбработок.ПустаяСсылка))
	|			И (ВерсииПлатформенныхОбработок.ВерсияПриложения = &ВерсияПриложения)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПлатформенныеОбработки.ИменаПодключения КАК ИменаПодключенияОбработки
	|		ПО ПлатформенныеОбработки.Ссылка = ИменаПодключенияОбработки.Ссылка
	|ГДЕ
	|	ВерсииПлатформенныхОбработок.Ссылка ЕСТЬ NULL";
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Выборка	= РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			СоздатьВерсиюОбработки(Выборка, ВерсияПриложения);
		КонецЦикла;
	КонецЕсли;
	
	ОбновленнаяВерсия = РегистрыСведений.ОбновленныеВерсииПриложения.СоздатьМенеджерЗаписи();
	ОбновленнаяВерсия.ВерсияПриложения = ВерсияПриложения;
	ОбновленнаяВерсия.ДатаОбновления   = ТекущаяДатаСеанса();
	ОбновленнаяВерсия.Записать(Истина);
	
КонецПроцедуры

Процедура ПодменитьПлатформенныеОбработкиПередЗапускомСистемы() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	
	#Область ТекстЗапроса
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПодменаПлатформенныхОбработок.Владелец КАК Владелец,
	|	ПодменаПлатформенныхОбработок.Обработка КАК Обработка,
	|	ПодменаПлатформенныхОбработок.Использование КАК Использование,
	|	ПодменаПлатформенныхОбработок.ВерсияОбработки КАК ВерсияОбработки,
	|	ПодменаПлатформенныхОбработок.Комментарий КАК Комментарий,
	|	ВЫБОР
	|		КОГДА ПодменаПлатформенныхОбработок.Владелец = &ТекущийПользователь
	|			ТОГДА 1
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК Приоритет
	|ПОМЕСТИТЬ ПодменыОбработок
	|ИЗ
	|	РегистрСведений.ПодменаПлатформенныхОбработок КАК ПодменаПлатформенныхОбработок
	|ГДЕ
	|	ПодменаПлатформенныхОбработок.Владелец В (&ТекущийПользователь, ЗНАЧЕНИЕ(Справочник.Пользователи.ПустаяСсылка))
	|	И ПодменаПлатформенныхОбработок.Использование = ИСТИНА
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ИменаПодключения.КлючевоеИмя КАК КлючевоеИмя,
	|	ПодменыОбработок.ВерсияОбработки КАК ВерсияОбработки
	|ИЗ
	|	(ВЫБРАТЬ
	|		ПодменыОбработок.Обработка КАК Обработка,
	|		МАКСИМУМ(ПодменыОбработок.Приоритет) КАК Приоритет
	|	ИЗ
	|		ПодменыОбработок КАК ПодменыОбработок
	|	
	|	СГРУППИРОВАТЬ ПО
	|		ПодменыОбработок.Обработка) КАК МаксимальныйПриоритет
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПодменыОбработок КАК ПодменыОбработок
	|		ПО МаксимальныйПриоритет.Обработка = ПодменыОбработок.Обработка
	|			И МаксимальныйПриоритет.Приоритет = ПодменыОбработок.Приоритет
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПлатформенныеОбработки.ИменаПодключения КАК ИменаПодключения
	|		ПО МаксимальныйПриоритет.Обработка = ИменаПодключения.Ссылка";	
	#КонецОбласти
	
	Запрос.УстановитьПараметр("ТекущийПользователь", УправлениеПлатформеннымиОбработками.ТекущийПользователь());
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Выборка	= РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			ПодключитьВерсиюОбработки(Выборка.ВерсияОбработки, Выборка.КлючевоеИмя);			
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПодключитьВерсиюОбработки(ВерсияОбработки, Знач КлючевоеИмя = "") Экспорт
	
	Если ПустаяСтрока(КлючевоеИмя) Тогда
		КлючевоеИмя = ЗначениеРеквизитаОбъекта(ВерсияОбработки, "КлючевоеИмя");
	КонецЕсли;
	
	СсылкаНаДанные = ПолучитьНавигационнуюСсылку(ВерсияОбработки, "ДанныеВерсии");
	
	ОписаниеЗащиты = Новый ОписаниеЗащитыОтОпасныхДействий;
	ОписаниеЗащиты.ПредупреждатьОбОпасныхДействиях = Ложь;
	
	ВнешниеОбработки.Подключить(СсылкаНаДанные, КлючевоеИмя, Ложь, ОписаниеЗащиты);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ОбновитьПлатформенныеОбработкиПриСменеВерсииПриложения() Экспорт

	ОбновитьПлатформенныеОбработки(Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ПодключениеОбработок

Процедура УдалитьВсеДанныеПодсистемы() Экспорт
	
	УдаляемыеМетаданные = 
	"Справочник.ПлатформенныеОбработки"
	"Справочник.ВерсииПлатформенныхОбработок"
	;
	
	УдаляемыеМетаданные = СтрРазделить(УдаляемыеМетаданные, Символы.ПС, Ложь);
	
	Для Каждого ИмяМетаданных Из УдаляемыеМетаданные Цикл
		
		Запрос = Новый Запрос;
		Запрос.Текст = СтрШаблон("ВЫБРАТЬ * ИЗ %1", ИмяМетаданных);
		РезультатЗапроса = Запрос.Выполнить();
		Если НЕ РезультатЗапроса.Пустой() Тогда
			Выборка	= РезультатЗапроса.Выбрать();
			Пока Выборка.Следующий() Цикл
				
				ТекущийОбъект = Выборка.Ссылка.ПолучитьОбъект();
				ТекущийОбъект.ОбменДанными.Загрузка = Истина;
				ТекущийОбъект.Удалить();
				
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	
	НаборЗаписей = РегистрыСведений.ПодменаПлатформенныхОбработок.СоздатьНаборЗаписей();
	НаборЗаписей.Записать(Истина);
	
КонецПроцедуры

Функция ТекущийПользователь() Экспорт
	
	Попытка
		Выполнить("ТекущийПользователь = Пользователи.ТекущийПользователь();");
	Исключение
		ТекущийПользователь = Справочники.Пользователи.ПустаяСсылка();
	КонецПопытки;
	
	Возврат ТекущийПользователь;
	
КонецФункции

// Функция возвращает ключ менеджера записи регистра сведений на основе 
//	https://fastcode.im/Templates/7545
//
// Параметры:
//  ДанныеЗаписи	- МенеджерЗаписи, Структура, Произвольный - коллекция с данными записи
//  ИмяРегистра		- Строка - Имя регистра. Если не передано, то метаданные регистра берутся из ДанныеЗаписи
// 
// Возвращаемое значение:
//  КлючЗаписи - Ключ записи регистра
//
Функция КлючМенеджераЗаписиРегистраСведений(ДанныеЗаписи, ИмяРегистра = "") Экспорт
	
	Если ПустаяСтрока(ИмяРегистра) Тогда
		МетаданныеРегистра = Метаданные.НайтиПоТипу(ТипЗнч(ДанныеЗаписи));
	Иначе
		МетаданныеРегистра = Метаданные.РегистрыСведений[ИмяРегистра];
	КонецЕсли;
	
	ЗначенияКлюча = Новый Структура("Период");
	
	Для Каждого ОписаниеИзмерения Из МетаданныеРегистра.Измерения Цикл
		ЗначенияКлюча.Вставить(ОписаниеИзмерения.Имя);
	КонецЦикла;
	
	ЗаполнитьЗначенияСвойств(ЗначенияКлюча, ДанныеЗаписи);
	
	Возврат РегистрыСведений[МетаданныеРегистра.Имя].СоздатьКлючЗаписи(ЗначенияКлюча);
	
КонецФункции

// Донастраивает форму списка так, чтобы она стала формой выбора.
// Позволяет полноценно использовать одну форму как в качестве основной формы списка, так и формы выбора
//
// Параметры:
//  Форма  - ФормаКлиентскогоПриложения - управляемая форма
//  ИмяЭлемента  - Строка - Имя элемента динамического списка
//
Процедура ИнициализироватьФормуВыбора(Форма, ИмяЭлемента = "Список") Экспорт
	
	ЭлементФормы  = Форма.Элементы.Найти(ИмяЭлемента);
	РеквизитФормы = Форма[ЭлементФормы.ПутьКДанным];
	
	ЭлементФормы.РежимВыбора = (Форма.Параметры.РежимВыбора = Истина);
	ЭлементФормы.МножественныйВыбор = (Форма.Параметры.МножественныйВыбор = Истина);
	
	РеквизитФормы.АвтоматическоеСохранениеПользовательскихНастроек = НЕ ЭлементФормы.РежимВыбора;

КонецПроцедуры

Функция ПараметрыОткрытияФормыУстановкиПодмены(ВерсияОбработки, ДляТекущегоПользователя) Экспорт
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("ВерсияОбработки", ВерсияОбработки);
	ЗначенияЗаполнения.Вставить("Использование"  , Истина);
	
    ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	ПараметрыФормы.Вставить("Модифицированность", Истина);
	
	ПараметрыЗаписи = Новый Структура;
	Если ДляТекущегоПользователя Тогда
		ПараметрыЗаписи.Вставить("Владелец", ТекущийПользователь());
	КонецЕсли;
	ПараметрыЗаписи.Вставить("Обработка", ЗначениеРеквизитаОбъекта(ВерсияОбработки, "Владелец"));

	МенеджерЗаписи = РегистрыСведений.ПодменаПлатформенныхОбработок.СоздатьМенеджерЗаписи();
	ЗаполнитьЗначенияСвойств(МенеджерЗаписи, ПараметрыЗаписи);
	МенеджерЗаписи.Прочитать();
	
	Если МенеджерЗаписи.Выбран() Тогда
		ПараметрыФормы.Вставить("Ключ", КлючМенеджераЗаписиРегистраСведений(МенеджерЗаписи));
	Иначе
		Для Каждого КлючИЗначение Из ПараметрыЗаписи Цикл
			ЗначенияЗаполнения.Вставить(КлючИЗначение.Ключ, КлючИЗначение.Значение);
		КонецЦикла;
	КонецЕсли;
	
	Возврат ПараметрыФормы;
	
КонецФункции

// Возвращает структуру, содержащую значения реквизитов, прочитанные из информационной базы по ссылке на объект.
// Рекомендуется использовать вместо обращения к реквизитам объекта через точку от ссылки на объект
// для быстрого чтения отдельных реквизитов объекта из базы данных.
//
// Если необходимо зачитать реквизит независимо от прав текущего пользователя,
// то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  Ссылка    - ЛюбаяСсылка - объект, значения реквизитов которого необходимо получить.
//            - Строка      - полное имя предопределенного элемента, значения реквизитов которого необходимо получить.
//  Реквизиты - Строка - имена реквизитов, перечисленные через запятую, в формате
//                       требований к свойствам структуры.
//                       Например, "Код, Наименование, Родитель".
//            - Структура, ФиксированнаяСтруктура - в качестве ключа передается
//                       псевдоним поля для возвращаемой структуры с результатом, а в качестве
//                       значения (опционально) фактическое имя поля в таблице.
//                       Если ключ задан, а значение не определено, то имя поля берется из ключа.
//            - Массив, ФиксированныйМассив - имена реквизитов в формате требований
//                       к свойствам структуры.
//  ВыбратьРазрешенные - Булево - если Истина, то запрос к объекту выполняется с учетом прав пользователя;
//                                если есть ограничение на уровне записей, то все реквизиты вернутся со 
//                                значением Неопределено; если нет прав для работы с таблицей, то возникнет исключение;
//                                если Ложь, то возникнет исключение при отсутствии прав на таблицу 
//                                или любой из реквизитов.
//
// Возвращаемое значение:
//  Структура - содержит имена (ключи) и значения затребованных реквизитов.
//            - если в параметр Реквизиты передана пустая строка, то возвращается пустая структура.
//            - если в параметр Ссылка передана пустая ссылка, то возвращается структура, 
//              соответствующая именам реквизитов со значениями Неопределено.
//            - если в параметр Ссылка передана ссылка несуществующего объекта (битая ссылка), 
//              то все реквизиты вернутся со значением Неопределено.
//
Функция ЗначенияРеквизитовОбъекта(Ссылка, Знач Реквизиты, ВыбратьРазрешенные = Ложь) Экспорт
	
	Попытка
		ПолноеИмяОбъектаМетаданных = Ссылка.Метаданные().ПолноеИмя(); 
	Исключение
		ВызватьИсключение 
			НСтр("ru = 'Неверный первый параметр Ссылка в функции ЗначенияРеквизитовОбъекта: 
			           |- Значение должно быть ссылкой или именем предопределенного элемента'");
	КонецПопытки;
		
	// Разбор реквизитов, если второй параметр Строка.
	Если ТипЗнч(Реквизиты) = Тип("Строка") Тогда
		Если ПустаяСтрока(Реквизиты) Тогда
			Возврат Новый Структура;
		КонецЕсли;
		
		// Удаление пробелов.
		Реквизиты = СтрЗаменить(Реквизиты, " ", "");
		// Преобразование параметра в массив полей.
		Реквизиты = СтрРазделить(Реквизиты, ",");
	КонецЕсли;
	
	// Приведение реквизитов к единому формату.
	СтруктураПолей = Новый Структура;
	Если ТипЗнч(Реквизиты) = Тип("Структура")
		Или ТипЗнч(Реквизиты) = Тип("ФиксированнаяСтруктура") Тогда
		
		СтруктураПолей = Реквизиты;
		
	ИначеЕсли ТипЗнч(Реквизиты) = Тип("Массив")
		Или ТипЗнч(Реквизиты) = Тип("ФиксированныйМассив") Тогда
		
		Для Каждого Реквизит Из Реквизиты Цикл
			
			Попытка
				ПсевдонимПоля = СтрЗаменить(Реквизит, ".", "");
				СтруктураПолей.Вставить(ПсевдонимПоля, Реквизит);
			Исключение 
				// Если псевдоним не является ключом.
				
				// Поиск ошибки доступности полей.
				Результат = НайтиОшибкуДоступностиРеквизитовОбъекта(ПолноеИмяОбъектаМетаданных, Реквизиты);
				Если Результат.Ошибка Тогда 
					ВызватьИсключение СтрШаблон(
						НСтр("ru = 'Неверный второй параметр Реквизиты в функции ОбщегоНазначения.ЗначенияРеквизитовОбъекта: %1'"),
						Результат.ОписаниеОшибки);
				КонецЕсли;
				
				// Не удалось распознать ошибку, проброс первичной ошибки.
				ВызватьИсключение;
			
			КонецПопытки;
		КонецЦикла;
	Иначе
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Неверный тип второго параметра Реквизиты в функции ОбщегоНазначения.ЗначенияРеквизитовОбъекта: %1'"), 
			Строка(ТипЗнч(Реквизиты)));
	КонецЕсли;
	
	// Подготовка результата (после выполнения запроса переопределится).
	Результат = Новый Структура;
	
	// Формирование текста запроса к выбираемым полям.
	ТекстЗапросаПолей = "";
	Для каждого КлючИЗначение Из СтруктураПолей Цикл
		
		ИмяПоля = ?(ЗначениеЗаполнено(КлючИЗначение.Значение),
						КлючИЗначение.Значение,
						КлючИЗначение.Ключ);
		ПсевдонимПоля = КлючИЗначение.Ключ;
		
		ТекстЗапросаПолей = 
			ТекстЗапросаПолей + ?(ПустаяСтрока(ТекстЗапросаПолей), "", ",") + "
			|	" + ИмяПоля + " КАК " + ПсевдонимПоля;
		
		
		// Предварительное добавление поля по псевдониму в возвращаемый результат.
		Результат.Вставить(ПсевдонимПоля);
		
	КонецЦикла;
	
	// Если предопределенного нет в ИБ.
	// - приведение результата к отсутствию объекта в ИБ или передаче пустой ссылки.
	Если Ссылка = Неопределено Тогда 
		Возврат Результат;
	КонецЕсли;
	
	ТекстЗапроса = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|&ТекстЗапросаПолей
		|ИЗ
		|	&ПолноеИмяОбъектаМетаданных КАК Таблица
		|ГДЕ
		|	Таблица.Ссылка = &Ссылка";
	
	Если Не ВыбратьРазрешенные Тогда 
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "РАЗРЕШЕННЫЕ", "");
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТекстЗапросаПолей", ТекстЗапросаПолей);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПолноеИмяОбъектаМетаданных", ПолноеИмяОбъектаМетаданных);
	
	// Выполнение запроса.
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст = ТекстЗапроса;
	
	Попытка
		Выборка = Запрос.Выполнить().Выбрать();
	Исключение
		
		// Если реквизиты были переданы строкой, то они уже конвертированы в массив.
		// Если реквизиты - массив, оставляем без изменений.
		// Если реквизиты - структура - конвертируем в массив.
		// В остальных случаях уже было бы выброшено исключение.
		Если Тип("Структура") = ТипЗнч(Реквизиты) Тогда
			Реквизиты = Новый Массив;
			Для каждого КлючИЗначение Из СтруктураПолей Цикл
				ИмяПоля = ?(ЗначениеЗаполнено(КлючИЗначение.Значение),
							КлючИЗначение.Значение,
							КлючИЗначение.Ключ);
				Реквизиты.Добавить(ИмяПоля);
			КонецЦикла;
		КонецЕсли;
		
		// Поиск ошибки доступности полей.
		Результат = НайтиОшибкуДоступностиРеквизитовОбъекта(ПолноеИмяОбъектаМетаданных, Реквизиты);
		Если Результат.Ошибка Тогда 
			ВызватьИсключение СтрШаблон(
				НСтр("ru = 'Неверный второй параметр Реквизиты в функции ОбщегоНазначения.ЗначенияРеквизитовОбъекта: %1'"), 
				Результат.ОписаниеОшибки);
		КонецЕсли;
		
		// Не удалось распознать ошибку, проброс первичной ошибки.
		ВызватьИсключение;
		
	КонецПопытки;
	
	// Заполнение реквизитов.
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Возвращает значения реквизита, прочитанного из информационной базы по ссылке на объект.
// Рекомендуется использовать вместо обращения к реквизитам объекта через точку от ссылки на объект
// для быстрого чтения отдельных реквизитов объекта из базы данных.
//
// Если необходимо зачитать реквизит независимо от прав текущего пользователя,
// то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  Ссылка    - ЛюбаяСсылка - объект, значения реквизитов которого необходимо получить.
//            - Строка      - полное имя предопределенного элемента, значения реквизитов которого необходимо получить.
//  ИмяРеквизита       - Строка - имя получаемого реквизита.
//  ВыбратьРазрешенные - Булево - если Истина, то запрос к объекту выполняется с учетом прав пользователя;
//                                если есть ограничение на уровне записей, то возвращается Неопределено;
//                                если нет прав для работы с таблицей, то возникнет исключение;
//                                если Ложь, то возникнет исключение при отсутствии прав на таблицу
//                                или любой из реквизитов.
//
// Возвращаемое значение:
//  Произвольный - зависит от типа значения прочитанного реквизита.
//               - если в параметр Ссылка передана пустая ссылка, то возвращается Неопределено;
//               - если в параметр Ссылка передана ссылка несуществующего объекта (битая ссылка), 
//                 то возвращается Неопределено.
//
Функция ЗначениеРеквизитаОбъекта(Ссылка, ИмяРеквизита, ВыбратьРазрешенные = Ложь) Экспорт
	
	Если ПустаяСтрока(ИмяРеквизита) Тогда 
		ВызватьИсключение 
			НСтр("ru = 'Неверный второй параметр ИмяРеквизита в функции ОбщегоНазначения.ЗначениеРеквизитаОбъекта: 
			           |- Имя реквизита должно быть заполнено'");
	КонецЕсли;
	
	Результат = ЗначенияРеквизитовОбъекта(Ссылка, ИмяРеквизита, ВыбратьРазрешенные);
	Возврат Результат[СтрЗаменить(ИмяРеквизита, ".", "")];
	
КонецФункции 

// Возвращает значения реквизитов, прочитанные из информационной базы для нескольких объектов.
// Рекомендуется использовать вместо обращения к реквизитам объекта через точку от ссылки на объект
// для быстрого чтения отдельных реквизитов объекта из базы данных.
//
// Если необходимо зачитать реквизит независимо от прав текущего пользователя,
// то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  Ссылки - Массив, ФиксированныйМассив - ссылки на объекты одного типа.
//                    Значения массива должны быть ссылками на объекты одного типа.
//                    если массив пуст, то результатом будет пустое соответствие.
//  Реквизиты - Строка - имена реквизитов перечисленные через запятую, в формате требований к свойствам
//                       структуры. Например, "Код, Наименование, Родитель".
//            - Массив, ФиксированныйМассив - имена реквизитов в формате требований
//                       к свойствам структуры.
//  ВыбратьРазрешенные - Булево - если Истина, то запрос к объектам выполняется с учетом прав пользователя;
//                                если какой-либо объект будет исключен из выборки по правам, то этот объект
//                                будет исключен и из результата;
//                                если Ложь, то возникнет исключение при отсутствии прав на таблицу
//                                или любой из реквизитов.
//
// Возвращаемое значение:
//  Соответствие - список объектов и значений их реквизитов:
//   * Ключ - ЛюбаяСсылка - ссылка на объект;
//   * Значение - Структура - значения реквизитов:
//    ** Ключ - Строка - имя реквизита;
//    ** Значение - Произвольный - значение реквизита.
// 
Функция ЗначенияРеквизитовОбъектов(Ссылки, Знач Реквизиты, ВыбратьРазрешенные = Ложь) Экспорт
	
	Если ТипЗнч(Реквизиты) = Тип("Массив") Или ТипЗнч(Реквизиты) = Тип("ФиксированныйМассив") Тогда
		Реквизиты = СтрСоединить(Реквизиты, ",");
	КонецЕсли;
	
	Если ПустаяСтрока(Реквизиты) Тогда 
		ВызватьИсключение 
			НСтр("ru = 'Неверный второй параметр Реквизиты в функции ОбщегоНазначения.ЗначенияРеквизитовОбъектов: 
			           |- Поле объекта должно быть указано'");
	КонецЕсли;
	
	Если СтрНайти(Реквизиты, ".") <> 0 Тогда 
		ВызватьИсключение 
			НСтр("ru = 'Неверный второй параметр Реквизиты в функции ОбщегоНазначения.ЗначенияРеквизитовОбъектов: 
			           |- Обращение через точку не поддерживается'");
	КонецЕсли;
	
	ЗначенияРеквизитов = Новый Соответствие;
	Если Ссылки.Количество() = 0 Тогда
		Возврат ЗначенияРеквизитов;
	КонецЕсли;
	
	ПерваяСсылка = Ссылки[0];
	
	Попытка
		ПолноеИмяОбъектаМетаданных = ПерваяСсылка.Метаданные().ПолноеИмя();
	Исключение
		ВызватьИсключение 
			НСтр("ru = 'Неверный первый параметр Ссылки в функции ОбщегоНазначения.ЗначенияРеквизитовОбъектов: 
			           |- Значения массива должны быть ссылками'");
	КонецПопытки;
	
	ТекстЗапроса =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	Ссылка КАК Ссылка,
		|	&Реквизиты
		|ИЗ
		|	&ПолноеИмяОбъектаМетаданных КАК Таблица
		|ГДЕ
		|	Таблица.Ссылка В (&Ссылки)";
	
	Если Не ВыбратьРазрешенные Тогда 
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "РАЗРЕШЕННЫЕ", "");
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&Реквизиты", Реквизиты);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПолноеИмяОбъектаМетаданных", ПолноеИмяОбъектаМетаданных);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылки", Ссылки);
	Запрос.Текст = ТекстЗапроса;
	
	Попытка
		Выборка = Запрос.Выполнить().Выбрать();
	Исключение
		
		// Удаление пробелов.
		Реквизиты = СтрЗаменить(Реквизиты, " ", "");
		// Преобразование параметра в массив полей.
		Реквизиты = СтрРазделить(Реквизиты, ",");
		
		// Поиск ошибки доступности полей.
		Результат = НайтиОшибкуДоступностиРеквизитовОбъекта(ПолноеИмяОбъектаМетаданных, Реквизиты);
		Если Результат.Ошибка Тогда 
			ВызватьИсключение СтрШаблон(
				НСтр("ru = 'Неверный второй параметр Реквизиты в функции ОбщегоНазначения.ЗначенияРеквизитовОбъектов: %1'"), 
				Результат.ОписаниеОшибки);
		КонецЕсли;
		
		// Не удалось распознать ошибку, проброс первичной ошибки.
		ВызватьИсключение;
		
	КонецПопытки;
	
	Пока Выборка.Следующий() Цикл
		Результат = Новый Структура(Реквизиты);
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
		ЗначенияРеквизитов[Выборка.Ссылка] = Результат;
	КонецЦикла;
	
	Возврат ЗначенияРеквизитов;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СоздатьВерсиюОбработки(ДанныеВерсии, ВерсияПриложения)
	
	ЭлементВерсии = Справочники.ВерсииПлатформенныхОбработок.СоздатьЭлемент();
	ЭлементВерсии.Владелец = ДанныеВерсии.Обработка;
	ЭлементВерсии.ВерсияПриложения = ВерсияПриложения;
	ЭлементВерсии.Наименование = СтрШаблон("%1 (Оригинальная версия %2)", ДанныеВерсии.Обработка, ВерсияПриложения);
	
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла(".epf");
	
	Попытка
		
		КопироватьФайл(ДанныеВерсии.ПолныйПуть, ИмяВременногоФайла);
		ЭлементВерсии.ДанныеВерсии = Новый ХранилищеЗначения(Новый ДвоичныеДанные(ИмяВременногоФайла));
		ЭлементВерсии.ДополнительныеСвойства.Вставить("СлужебноеОбновление", Истина);
		ЭлементВерсии.КлючевоеИмя = ДанныеВерсии.КлючевоеИмя;
		ЭлементВерсии.Записать();
		
	Исключение
		
		ОписаниеОшибки = ОписаниеОшибки();
		ПричинаОшибки  = "Ресурс не найден";
		СообщитьОшибку = Истина;
		Если СтрНайти(ОписаниеОшибки, ПричинаОшибки) > 0 Тогда
			ОписаниеОшибки = ПричинаОшибки;
			СообщитьОшибку = Ложь;
		КонецЕсли;
		
		ТекстОшибки = "Не удалось создать версию обработки %1 по причине: %2";
		ТекстОшибки = СтрШаблон(ТекстОшибки, ДанныеВерсии.Обработка, ОписаниеОшибки);
		
		ЗаписьЖурналаРегистрации("УправлениеПлатформеннымиОбработками.СозданиеВерсииОбработки", 
		УровеньЖурналаРегистрации.Ошибка, Метаданные.Справочники.ВерсииПлатформенныхОбработок, , ТекстОшибки);
		
		Если СообщитьОшибку Тогда
			УправлениеПлатформеннымиОбработкамиКлиентСервер.СообщитьПользователю(ТекстОшибки);
		КонецЕсли;
		
	КонецПопытки;
	
	УдалитьФайлы(ИмяВременногоФайла);
		
КонецПроцедуры

// Выполняет поиск проверяемых выражений среди реквизитов объекта метаданных.
// 
// Параметры:
//  ПолноеИмяОбъектаМетаданных - Строка - полное имя проверяемого объекта.
//  ПроверяемыеВыражения       - Массив - имена полей или проверяемые выражения объекта метаданных.
// 
// Возвращаемое значение:
//  Структура - Результат проверки.
//  * Ошибка         - Булево - Найдена ошибка.
//  * ОписаниеОшибки - Строка - Описание найденных ошибок.
//
// Пример:
//  
// Реквизиты = Новый Массив;
// Реквизиты.Добавить("Номер");
// Реквизиты.Добавить("Валюта.НаименованиеПолное");
//
// Результат = ОбщегоНазначения.НайтиОшибкуДоступностиРеквизитовОбъекта("Документ._ДемоЗаказПокупателя", Реквизиты);
//
// Если Результат.Ошибка Тогда
//     ВызватьИсключение Результат.ОписаниеОшибки;
// КонецЕсли;
//
Функция НайтиОшибкуДоступностиРеквизитовОбъекта(ПолноеИмяОбъектаМетаданных, ПроверяемыеВыражения)
	
	МетаданныеОбъекта = Метаданные.НайтиПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
	
	Если МетаданныеОбъекта = Неопределено Тогда 
		Возврат Новый Структура("Ошибка, ОписаниеОшибки", Истина, 
			СтрШаблон(
				НСтр("ru = 'Ошибка получения метаданных ""%1""'"), ПолноеИмяОбъектаМетаданных));
	КонецЕсли;

	// Разрешение вызова из безопасного режима внешней обработки или расширения.
	// Информация о доступности полей источника схемы при проверке метаданных не является секретной.
	УстановитьОтключениеБезопасногоРежима(Истина);
	УстановитьПривилегированныйРежим(Истина);
	
	Схема = Новый СхемаЗапроса;
	Пакет = Схема.ПакетЗапросов.Добавить(Тип("ЗапросВыбораСхемыЗапроса"));
	Оператор = Пакет.Операторы.Получить(0);
	
	Источник = Оператор.Источники.Добавить(ПолноеИмяОбъектаМетаданных, "Таблица");
	ТекстОшибки = "";
	
	Для Каждого ТекущееВыражение Из ПроверяемыеВыражения Цикл
		
		Если Не ПолеИсточникаСхемыЗапросаДоступно(Источник, ТекущееВыражение) Тогда 
			ТекстОшибки = ТекстОшибки + Символы.ПС + СтрШаблон(
				НСтр("ru = '- Поле объекта ""%1"" не найдено'"), ТекущееВыражение);
		КонецЕсли;
		
	КонецЦикла;
		
	Возврат Новый Структура("Ошибка, ОписаниеОшибки", Не ПустаяСтрока(ТекстОшибки), ТекстОшибки);
	
КонецФункции

// Используется в НайтиОшибкуДоступностиРеквизитовОбъекта.
// Выполняет проверку доступности поля проверяемого выражения в источнике оператора схемы запроса.
//
Функция ПолеИсточникаСхемыЗапросаДоступно(ИсточникОператора, ПроверяемоеВыражение)
	
	ЧастиИмениПоля = СтрРазделить(ПроверяемоеВыражение, ".");
	ДоступныеПоля = ИсточникОператора.Источник.ДоступныеПоля;
	
	ТекущаяЧастьИмениПоля = 0;
	Пока ТекущаяЧастьИмениПоля < ЧастиИмениПоля.Количество() Цикл 
		
		ТекущееПоле = ДоступныеПоля.Найти(ЧастиИмениПоля.Получить(ТекущаяЧастьИмениПоля)); 
		
		Если ТекущееПоле = Неопределено Тогда 
			Возврат Ложь;
		КонецЕсли;
		
		// Инкрементация следующей части имени поля и соответствующего списка доступности полей.
		ТекущаяЧастьИмениПоля = ТекущаяЧастьИмениПоля + 1;
		ДоступныеПоля = ТекущееПоле.Поля;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти
