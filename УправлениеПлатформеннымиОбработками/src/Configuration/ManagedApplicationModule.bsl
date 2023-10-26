
#Область ОбработчикиСобытий

//@skip-check not-allowed-pragma
//@skip-check module-structure-method-in-regions
//@skip-check not-use-annotation-form-event-handlers
&После("ПередНачаломРаботыСистемы")
Процедура УПО_ПередНачаломРаботыСистемы(Отказ)
	
    УправлениеПлатформеннымиОбработкамиКлиент.ПередНачаломРаботыСистемы();
	
КонецПроцедуры

#КонецОбласти
