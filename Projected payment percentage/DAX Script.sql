-- DAX Script

VAR JulyPaid = 
    CALCULATE(
        COUNTROWS('Таблица1');
        FILTER(
            ALL('Таблица1');
            'Таблица1'[Дата отправки] >= DATE(2021;7;1) &&
            'Таблица1'[Дата отправки] <= DATE(2021;7;31) &&
            'Таблица1'[Статус отправления] = "оплачено"
        )
    )
VAR JulyTotal = 
    CALCULATE(
        COUNTROWS('Таблица1');
        FILTER(
            ALL('Таблица1');
            'Таблица1'[Дата отправки] >= DATE(2021;7;1) &&
            'Таблица1'[Дата отправки] <= DATE(2021;7;31)
        )
    )
VAR AugustPaid = 
    CALCULATE(
        COUNTROWS('Таблица1');
        FILTER(
            ALL('Таблица1');
            'Таблица1'[Дата отправки] >= DATE(2021;8;1) &&
            'Таблица1'[Дата отправки] <= DATE(2021;8;31) &&
            'Таблица1'[Статус отправления] = "оплачено"
        )
    )
VAR AugustTotal = 
    CALCULATE(
        COUNTROWS('Таблица1');
        FILTER(
            ALL('Таблица1');
            'Таблица1'[Дата отправки] >= DATE(2021;8;1) &&
            'Таблица1'[Дата отправки] <= DATE(2021;8;31)
        )
    )
VAR HasJulyData = JulyTotal > 0
VAR HasAugustData = AugustTotal > 0

VAR JulyRate = IF(HasJulyData; DIVIDE(JulyPaid; JulyTotal); BLANK())
VAR AugustRate = IF(HasAugustData; DIVIDE(AugustPaid; AugustTotal); BLANK())

VAR AverageRate = 
    SWITCH(TRUE();
        HasJulyData && HasAugustData; (JulyRate + AugustRate) / 2;
        HasJulyData; JulyRate;
        HasAugustData; AugustRate;
        BLANK()  
    )
RETURN
IF(
    NOT(ISBLANK(AverageRate));
    ROUND(AverageRate*100; 0);
    BLANK()
)
