// @strict-types

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Список.УстановитьОграниченияИспользованияВОтборе(СтрРазделить("ПредставлениеПользователя", ","));

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

// Список при получении данных на сервере.
// 
// Параметры:
//  ИмяЭлемента - Строка -  Имя элемента
//  Настройки - НастройкиКомпоновкиДанных -  Настройки :
//  * ДополнительныеСвойства - Структура -:
//  ** ПодсистемаБСП - Булево
//  Строки - Соответствие из КлючИЗначение - Баг ЕДТ не понимает строки ДС:
//  * Значение - СтрокаДинамическогоСписка - :
//  ** Данные - ДанныеФормыСтруктура - :
//  *** ПредставлениеПользователя - Строка
//  *** Владелец - УникальныйИдентификатор
&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)
	
	Для Каждого КлючИЗначение Из Строки Цикл
		
		ИдентификаторПользователя = Неопределено; //УникальныйИдентификатор
		
		Строка = КлючИЗначение.Значение;
		Если Строка.Данные.Свойство("Владелец", ИдентификаторПользователя)
			И ТипЗнч(ИдентификаторПользователя) = Тип("УникальныйИдентификатор")
			И Строка.Данные.Свойство("ПредставлениеПользователя") Тогда
			
			Строка.Данные.ПредставлениеПользователя = 
				УправлениеПлатформеннымиОбработками.ПредставлениеПользователяИБ(ИдентификаторПользователя);
				
		КонецЕсли;
		
	КонецЦикла;

КонецПроцедуры

#КонецОбласти
