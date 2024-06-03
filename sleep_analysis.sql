select *
from sleep_health_and_lifestyle_dataset ;

-- which occupation have good sleep
with cte as (select *
from sleep_health_and_lifestyle_dataset 
where `Sleep Duration` between 6 and 10
)
select Occupation, round(avg(`Sleep Duration`), 2) as good_sleep
from cte 
group by Occupation
order by good_sleep desc;

-- which profession have highest sleep disorder
select Occupation, count(`Sleep Disorder`) as total_disorder_count
from sleep_health_and_lifestyle_dataset 
where `Sleep Disorder` <> 'None'
group by Occupation 
order by total_disorder_count desc;

-- which Occupation have highest average physical activity level
select Occupation ,round(avg(`Physical Activity Level`),0) as average_physical_activity
from sleep_health_and_lifestyle_dataset 
group by Occupation 
order by average_physical_activity desc;

-- which age group have good sleep duration
select 
      sum(case when Age between  25 and  35 then 1 else 0 end) as '25 to 35',
      sum(case when Age between  35 and  45 then 1 else 0 end) as '35 to 45',
      sum(case when Age between  45 and  55 then 1 else 0 end) as '45 to 55',
      sum(case when Age between  55 and  65 then 1 else 0 end) as '55 to 65'
from sleep_health_and_lifestyle_dataset 
where `Sleep Duration` between 8 and 10;

-- which age people have Insomnia, sleep apnea and no disorder
with people_with_isnomnia as(
select Age,  count(*) as Insomnia_people
from sleep_health_and_lifestyle_dataset 
where `Sleep Disorder` = 'Insomnia'
group by Age
),
 people_with_sleep_apnea as(
select Age,  count(*) as Sleep_apnea_people
from sleep_health_and_lifestyle_dataset 
where `Sleep Disorder`= 'Sleep Apnea'
group  by Age
),
people_with_no_disorder as( 
select Age,  count(*) as no_sleep_disorder
from sleep_health_and_lifestyle_dataset 
where `Sleep Disorder`= 'None'
group  by Age
)
select t.Age, p.Sleep_apnea_people, t.Insomnia_people, n.no_sleep_disorder
from people_with_isnomnia t
left join people_with_sleep_apnea p
on t.Age = p.Age
left join people_with_no_disorder n
on t.Age = n.Age;	

-- which Age category have highest  stress level
select 
      sum(case when Age between  25 and  35 then 1 else 0 end) as '25 to 35',
      sum(case when Age between  35 and  45 then 1 else 0 end) as '35 to 45',
      sum(case when Age between  45 and  55 then 1 else 0 end) as '45 to 55',
      sum(case when Age between  55 and  65 then 1 else 0 end) as '55 to 65'
from sleep_health_and_lifestyle_dataset 
where `Stress Level`  between 6 and 18;

-- which age group have high blood pressure (more then 130/80)
select 
      sum(case when Age between  25 and  35 then 1 else 0 end) as '25 to 35',
      sum(case when Age between  35 and  45 then 1 else 0 end) as '35 to 45',
      sum(case when Age between  45 and  55 then 1 else 0 end) as '45 to 55',
      sum(case when Age between  55 and  65 then 1 else 0 end) as '55 to 65'
from sleep_health_and_lifestyle_dataset 
where cast(substring_index(`Blood Pressure`, '/', 1) as unsigned) >130
      or
      cast(substring_index(`Blood Pressure`, '/',-1) as unsigned) > 80;

     


























