// @strict-types

#Область ОбработчикиСобытий

// Обработка команды.
// 
// Параметры:
//  ПараметрКоманды - СправочникСсылка.УПО_ВерсииПлатформенныхОбработок
//  ПараметрыВыполненияКоманды - ПараметрыВыполненияКоманды
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	УПО_Клиент.ОткрытьФормуУстановкиПодмены(ПараметрКоманды, Ложь);
	
КонецПроцедуры

#КонецОбласти
