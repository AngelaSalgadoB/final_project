USE gender_base_violence;

#Number of calls per link
SELECT link, COUNT(*) FROM calls GROUP BY link;


#Number of calls that denounce psychological violence
SELECT COUNT(*) FROM calls
INNER JOIN calls_violence ON calls_violence.call_id=calls.id
INNER JOIN violence ON calls_violence.violence_id=violence.id 
WHERE violence.violence_type='psychological';


#Number of calls that denounce economical violence in Buenos Aires
SELECT COUNT(*) FROM calls
INNER JOIN localization ON calls.id_localization=localization.id
INNER JOIN calls_violence ON calls_violence.call_id=calls.id
INNER JOIN violence ON calls_violence.violence_id=violence.id 
WHERE violence.violence_type='economical' 
AND localization.region_name='Buenos Aires';

#Number of calls per year
SELECT YEAR(call_date) AS year , COUNT(*) FROM calls GROUP BY year;

#Number of calls per gender of the victim
SELECT COUNT(*), victim_gender FROM calls GROUP BY victim_gender;





