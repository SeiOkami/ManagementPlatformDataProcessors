// @strict-types

#Область ОбработчикиСобытий

// Обработка команды.
// 
// Параметры:
//  ПараметрКоманды - СправочникСсылка.ВерсииПлатформенныхОбработок
//  ПараметрыВыполненияКоманды - ПараметрыВыполненияКоманды
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
    УправлениеПлатформеннымиОбработкамиКлиент.СпроситьИПодключитьВерсиюОбработкиДляТекущегоСеанса(ПараметрКоманды);
	
КонецПроцедуры

#КонецОбласти
