// @strict-types

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Эталонные данные.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - :
//  * Наименование - Строка
//  * Description - Строка
//  * КлючевыеИмена - Строка
//  * УникальныйИдентификатор - Строка
Функция ЭталонныеДанные() Экспорт
	
	ТипНаименования = Метаданные.Справочники.ПлатформенныеОбработки.СтандартныеРеквизиты.Наименование.Тип;

	ЭталонныеДанные = Новый ТаблицаЗначений;
	ЭталонныеДанные.Колонки.Добавить("Наименование", ТипНаименования);
	ЭталонныеДанные.Колонки.Добавить("Description" , ТипНаименования);
	ЭталонныеДанные.Колонки.Добавить("КлючевыеИмена", Новый ОписаниеТипов("Строка"));
	ЭталонныеДанные.Колонки.Добавить("УникальныйИдентификатор", Новый ОписаниеТипов("Строка"));
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Активные пользователи",
		"Active users",
		"StandardActiveUsers",
		"c02ea02e-8076-491a-b798-5716b51cd6c0");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Журнал регистрации",
		"Event log",
		"StandardEventLog",
		"8a7c7769-6dd4-4aa0-a95d-b293bd653a48");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Поиск ссылок на объект",
		"Find references to objects",
		"StandardFindByRef, StandardFindByReference",
		"7eb32c7d-7972-4560-8418-6db0fd14562d");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Проведение документов",
		"Document Posting",
		"StandardDocumentsPosting",
		"2cfcd406-3e56-43a9-abca-9c2a97197f3d");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные, 
		"Удаление помеченных объектов",
		"Delete Marked Objects",
		"StandardDeleteMarkedObjects",
		"1c576f2f-6850-4b5b-9583-7920e005ea12");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление внешними источниками данных",
		"Management of external data sources",
		"StandardExternalDataSourcesManagement",
		"af6329da-187b-44d7-bf6e-a056317403f6");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление итогами",
		"Totals management",
		"StandardTotalsManagement",
		"35e9d220-6f5b-4acf-9066-e3488b253e1a");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление полнотекстовым поиском",
		"Manage Full Text Search",
		"StandardFullTextSearchManagement",
		"e03b54b6-30c4-42c9-b8f4-29468acd7a79");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление расширениями конфигурации",
		"Manage configuration extensions",
		"StandardExtensionsManagement, StandardConfigurationExtensionsManagement",
		"b8d380b1-6716-447b-892f-4ca639f78b5c");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление системой взаимодействия",
		"Collaboration system management",
		"StandardECSRegister, StandardCollaborationSystemManagement",
		"0ed05d4e-1e52-4d10-9060-455ac209f4de");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Конструктор запросов на управляемых формах",
		"Query wizard",
		"QueryWizard",
		"c8f6f902-8775-4150-bffa-4df1fcd9cf2b");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"История изменений данных",
		"Data change history",
		"StandardDataChangeHistory",
		"e613cebe-8ff7-42c9-a121-0f516f766b17");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление копиями базы данных",
		"Database copies management",
		"StandardDataBaseCopiesManagement",
		"773c299c-f2e6-4755-ab07-cca27b1114d9");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление настройками обработки ошибок",
		"Management of error processing settings",
		"StandardErrorProcessingSettings",
		"2d2ff455-b8ae-4084-96af-6754d151bc49");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление серверами",
		"Servers management",
		"StandartServersControl,StandardServersManagement",
		"e965eb4c-a081-4200-9b95-c356ca6f2c45");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление сервисами интеграции",
		"Management of integration services",
		"StandardIntegrationServicesManagment",
		"264f59f6-3626-49ca-984b-515c558213be");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление системой аналитики",
		"Analytics system management",
		"StandardAnalyticsSystemManagement",
		"d174befa-b19c-4bc2-a1a4-e396b31f03d4");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Блокировка аутентификации",
		"Authentication lock",
		"StandardAuthenticationLocks",
		"60db8988-68a2-4c4a-b159-11be2ef004f3");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Дополнительные настройки аутентификации",
		"Additional authentication settings",
		"StandardAdditionalAuthenticationSettings",
		"f0c0ba42-7d53-41db-a594-2ede1a81196c");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Лицензирование конфигурации",
		"Configuration licensing",
		"StandardConfigurationLicense",
		"4bfbaf32-e755-4276-b872-563c0588d6ce");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Настройка журнала регистрации",
		"Event log settings",
		"StandardEventLogSettings",
		"d2844ed0-b856-4a7c-80b8-71ef78d2f90d");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Параметры информационной базы",
		"Infobase parameters",
		"StandardInfobaseParameters",
		"1fdd3586-6cb2-449c-82ae-fbf94bcb9ce4");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Получение лицензии",
		"License acquisition",
		"StandardLicenseAcquisition",
		"95580503-837e-4a7f-95df-b4aa1066b2bc");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Пользователи",
		"Users",
		"StandardUserList",
		"088d209c-ce54-48f5-9093-092322cfc408");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Региональные установки информационной базы",
		"Infobase regional settings",
		"StandardInfobaseRegionalSettings",
		"64d4a4d3-0d6d-4e53-835b-6c7eacf96864");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Сервис сборки мобильных приложений",
		"Mobile application build service",
		"StandardMobileAppBuildService, StandardMobileAppBuilderServiceLoader",
		"5ea10a35-a345-4878-91d2-00eb9b543c79");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление распознаванием речи",
		"Manage speech recognition",
		"StandardSpeechToText",
		"5ea10a35-a345-4878-91d2-00eb9b543c80");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление табличными пространствами базы данных",
		"Database tablespace management",
		"StandardDatabaseTablespaceManagement",
		"5ea10a35-a345-4878-91d2-00eb9b543c81");
	
	ДобавитьСтрокуЭталонныхДанных(ЭталонныеДанные,
		"Управление хранилищем двоичных данных",
		"Binary data storage management",
		"StandardBinaryDataStorageManagement",
		"5ea10a35-a345-4878-91d2-00eb9b543c82");
	
	Возврат ЭталонныеДанные;
	
КонецФункции

// Заполнить эталонные данные.
Процедура ЗаполнитьЭталонныеДанные() Экспорт
	
	ЭталонныеДанные = ЭталонныеДанные();
	ПлатформенныеОбработки.Загрузить(ЭталонныеДанные);
	
КонецПроцедуры

// Двоичные данные платформенной обработки.
// 
// Параметры:
//  ПолныйПуть - Строка
//  
// Возвращаемое значение:
//  ДвоичныеДанные, Неопределено -
Функция ДвоичныеДанныеПлатформеннойОбработки(Знач ПолныйПуть) Экспорт
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла(".epf");
	ДвоичныеДанные = Неопределено;
	
	Попытка
		
		КопироватьФайл(ПолныйПуть, ИмяВременногоФайла);
		ДвоичныеДанные = Новый ДвоичныеДанные(ИмяВременногоФайла);
		
	Исключение
		
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		ОписаниеОшибки = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
		ПричинаОшибки  = НСтр("ru='Ресурс не найден';en='Resource not found'");
		
		СообщитьОшибку = Истина;
		Если СтрЗаканчиваетсяНа(ОписаниеОшибки, ПричинаОшибки) > 0 Тогда
			ОписаниеОшибки = ПричинаОшибки;
			СообщитьОшибку = Ложь;
		КонецЕсли;
		
		Если СообщитьОшибку Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = ОписаниеОшибки;
			Сообщение.Сообщить();
		КонецЕсли;
		
		ОписаниеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке);
		ЗаписьЖурналаРегистрации("Обработки.ВыгрузкаПлатформенныхОбработок", 
			УровеньЖурналаРегистрации.Ошибка, , , ОписаниеОшибки);	
		
	КонецПопытки;
	
	УдалитьФайлы(ИмяВременногоФайла);
	
	Возврат ДвоичныеДанные;
	
КонецФункции

// Полный путь платформенной обработки.
// 
// Параметры:
//  СистемноеИмя - Строка
// 
// Возвращаемое значение:
//  Строка
Функция ПолныйПутьПлатформеннойОбработки(СистемноеИмя) Экспорт
	
	Возврат СтрШаблон("v8res://mngbase/%1.epf", СистемноеИмя);
			
КонецФункции

// Сведения о внешней обработке.
// 
// Возвращаемое значение:
//  Неопределено - 
//  - см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке
Функция СведенияОВнешнейОбработке() Экспорт
	
	Попытка
		МодулиБСП = МодулиБСП();
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	
	МетаданныеИнструмента = Метаданные();
	
	ПараметрыРегистрации = МодулиБСП.ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();
	ПараметрыРегистрации.Наименование = МетаданныеИнструмента.Синоним;
	ПараметрыРегистрации.Информация = МетаданныеИнструмента.Синоним;
	ПараметрыРегистрации.Вид = МодулиБСП.ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
	ПараметрыРегистрации.Версия = "1.4.2";
	ПараметрыРегистрации.БезопасныйРежим = Ложь;
	ПараметрыРегистрации.Информация = "Позволяет выгрузить встроенные в платформу инструменты как внешние обработки";
	
	Команда = ПараметрыРегистрации.Команды.Добавить();
	Команда.Представление = "Открытие формы обработки";
	Команда.Идентификатор = МетаданныеИнструмента.Имя;
	Команда.Использование = МодулиБСП.ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	Команда.ПоказыватьОповещение = Ложь;
	
	//@skip-check constructor-function-return-section
	Возврат ПараметрыРегистрации;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Модули БСП.
// 
// Возвращаемое значение:
//  Структура - модули БСП:
// * ДополнительныеОтчетыИОбработки - CommonModule.ДополнительныеОтчетыИОбработки
// * ДополнительныеОтчетыИОбработкиКлиентСервер - CommonModule.ДополнительныеОтчетыИОбработкиКлиентСервер
Функция МодулиБСП()
	
	ИменаМодулей = "ДополнительныеОтчетыИОбработки,ДополнительныеОтчетыИОбработкиКлиентСервер";
	Возврат ОбщиеМодули(ИменаМодулей); //@skip-check constructor-function-return-section - ЕДТ не умеет
	
КонецФункции

// Общие модули.
// 
// Параметры:
//  ИменаМодулей - Строка - Имена общих модулей, разделенные через запятую
// 
// Возвращаемое значение:
//  Структура
Функция ОбщиеМодули(ИменаМодулей)
	
	ОбщиеМодули = Новый Структура(ИменаМодулей);
	Для Каждого КлючИЗначение Из ОбщиеМодули Цикл
		
		//@skip-check server-execution-safe-mode
		// BSLLS:ExecuteExternalCode-off
		ОбщиеМодули[КлючИЗначение.Ключ] = Вычислить(КлючИЗначение.Ключ); // ОбщийМодуль
		
	КонецЦикла;
	
	Возврат ОбщиеМодули;
	
КонецФункции

// Добавить строку эталонных данных.
// 
// Параметры:
//  Данные - см. ЭталонныеДанные
//  Наименование - Строка
//  Description - Строка
//  КлючевыеИмена - Строка
//  УникальныйИдентификатор - Строка
Процедура ДобавитьСтрокуЭталонныхДанных(Данные, Наименование, Description, КлючевыеИмена, УникальныйИдентификатор)
	
	СтрокаДанных = Данные.Добавить();
	СтрокаДанных.Наименование  = Наименование;
	СтрокаДанных.Description   = Description;
	СтрокаДанных.КлючевыеИмена = КлючевыеИмена;
	СтрокаДанных.УникальныйИдентификатор = УникальныйИдентификатор;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
