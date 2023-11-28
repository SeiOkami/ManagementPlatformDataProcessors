
#Область ОбработчикиСобытий

//@skip-check not-allowed-pragma
//@skip-check module-structure-method-in-regions
//@skip-check not-use-annotation-form-event-handlers
&После("ПередНачаломРаботыСистемы")
Процедура УПО_ПередНачаломРаботыСистемы(Отказ)
	
    УправлениеПлатформеннымиОбработкамиКлиент.ПередНачаломРаботыСистемы();
	
КонецПроцедуры

//@skip-check not-allowed-pragma
//@skip-check module-structure-method-in-regions
//@skip-check not-use-annotation-form-event-handlers
&После("BeforeStart")
Процедура УПО_BeforeStart(Отказ)
	
    УправлениеПлатформеннымиОбработкамиКлиент.ПередНачаломРаботыСистемы();
	
КонецПроцедуры

#КонецОбласти
