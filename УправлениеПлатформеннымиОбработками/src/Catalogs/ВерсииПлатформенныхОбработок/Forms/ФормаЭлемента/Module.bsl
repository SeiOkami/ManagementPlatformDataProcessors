// @strict-types

#Область ОбработчикиСобытийФормы
 
// При создании на сервере.
// 
// Параметры:
//  Отказ - Булево - Отказ
//  СтандартнаяОбработка - Булево - Стандартная обработка
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
    ТолькоПросмотр = НЕ ЗначениеЗаполнено(Объект.Родитель);
	
КонецПроцедуры

#КонецОбласти

