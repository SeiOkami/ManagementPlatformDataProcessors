
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
    УправлениеПлатформеннымиОбработками.ИнициализироватьФормуВыбора(ЭтотОбъект);
	
	ОбновитьВладельцаСпискаНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура СписокОбработкиПриАктивизацииСтроки(Элемент)
	
    Обработка = ТекущаяОбработкаИзСписка();
	Если Обработка = ТекущаяОбработка Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяОбработка = Обработка;
	ПодключитьОбработчикОжидания("ОбновитьВладельцаСписка", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
 
&НаСервере
Процедура ОбновитьВладельцаСпискаНаСервере()

	Список.Параметры.УстановитьЗначениеПараметра("Владелец", ТекущаяОбработка);
	СписокПодмены.Параметры.УстановитьЗначениеПараметра("Обработка", ТекущаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВладельцаСписка()
	
	ОбновитьВладельцаСпискаНаСервере();
	
КонецПроцедуры

&НаКлиенте
Функция ТекущаяОбработкаИзСписка()
	
	Обработка = Элементы.СписокОбработки.ТекущаяСтрока;
	Если ТипЗнч(Обработка) <> Тип("СправочникСсылка.ПлатформенныеОбработки") Тогда
		Обработка = ПредопределенноеЗначение("Справочник.ПлатформенныеОбработки.ПустаяСсылка");
	КонецЕсли;
	
	Возврат Обработка;
	
КонецФункции

#КонецОбласти

