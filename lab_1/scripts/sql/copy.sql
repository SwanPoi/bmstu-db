copy clubs(club_name, found_date, branch_count, town) 
FROM E'C:\\Program Files\\PostgreSQL\\15\\clubs.csv' delimiter '|';


copy fighters(first_name, last_name, age, gender, club_id) 
FROM E'C:\\Program Files\\PostgreSQL\\15\\fighters.csv' delimiter '|';


copy nominations(nomination_name, min_age, max_age, weight_category, gender, battle_scheme) 
FROM E'C:\\Program Files\\PostgreSQL\\15\\nominations.csv' delimiter '|';


copy judges(first_name, last_name, experience, category, salary) 
FROM E'C:\\Program Files\\PostgreSQL\\15\\judges.csv' delimiter '|';
 

copy tournament(fighter_id, nomination_id, warnings, applied_hits, skipped_hits) 
FROM E'C:\\Program Files\\PostgreSQL\\15\\tournament.csv' delimiter '|';


copy judging(judge_id, nomination_id) 
FROM E'C:\\Program Files\\PostgreSQL\\15\\judging.csv' delimiter '|';