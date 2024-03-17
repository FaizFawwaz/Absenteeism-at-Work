select *
from [Absenteeism at work]..Absenteeism_at_work abw
left join Compensation com
on abw.ID = com.ID
left join Reasons rea
on abw.Reason_for_absence = rea.Number

--find the healtiest staff
select *
from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25 and
Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) 
from Absenteeism_at_work)

--compensation rate increase for non-smoker/budget $983,221 
--so increase 0.68% per hour ( $1,414.4 per year)
select count(*) as non_smokers
from Absenteeism_at_work
where Social_smoker = 0

--optimize query
select
abw.ID,
rea.Reason,
Body_mass_index,
Month_of_absence,
case when Body_mass_index < 18.5 then 'Underweight'
	 when Body_mass_index between 18.5 and 25 then 'Healthy Weight'
	 when Body_mass_index between 25 and 30 then 'Overweight'
	 when Body_mass_index > 30 then 'Obese'
	 else 'UNKNOWN' 
end as BMI_Category,
case when Month_of_absence in (12,1,2) Then 'Winter'
	 when Month_of_absence in (3,4,5) Then 'Spring'
	 when Month_of_absence in (6,7,8) Then 'Summer'
	 when Month_of_absence in (9,10,11) Then 'Fall'
	 else 'UNKNOWN' 
end as Season_Name,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
from [Absenteeism at work]..Absenteeism_at_work abw
left join Compensation com
on abw.ID = com.ID
left join Reasons rea
on abw.Reason_for_absence = rea.Number

