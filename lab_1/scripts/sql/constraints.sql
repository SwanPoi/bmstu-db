ALTER TABLE clubs
    ALTER club_name SET NOT NULL,
    ALTER found_date SET NOT NULL,
    ALTER branch_count SET NOT NULL,
    ALTER town SET NOT NULL,
    ADD CONSTRAINT check_club_name
    CHECK ( club_name != '' ), 
    ADD CONSTRAINT check_branch_count
    CHECK ( branch_count > 0 ),
    ADD CONSTRAINT check_town
    CHECK ( town != '' );

ALTER TABLE fighters
    ADD FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE SET NULL,
    ALTER first_name SET NOT NULL,
    ALTER last_name SET NOT NULL,
    ALTER age SET NOT NULL,
    ALTER gender SET NOT NULL,
    ADD CONSTRAINT check_name
    CHECK ( first_name != '' AND last_name != '' ),
    ADD CONSTRAINT check_age
    CHECK ( age >= 4 AND age <= 70 ),
    ADD CONSTRAINT check_gender
    CHECK ( gender IN ('male', 'female') );

ALTER TABLE nominations
    ALTER nomination_name SET NOT NULL,
    ALTER min_age SET NOT NULL,
    ALTER max_age SET NOT NULL,
    ALTER weight_category SET NOT NULL,
    ALTER gender SET NOT NULL,
    ALTER battle_scheme SET NOT NULL,
    ADD CONSTRAINT check_nomination_name
    CHECK ( nomination_name IN ('Shield and Sword', 'Saber and Shield', 'Saber and buckler', 'Saber solo', 'Triathlon', 'Hard', 'Dueling', 'Sword and buckler', 'Longsword') ),
    ADD CONSTRAINT check_age 
    CHECK ( min_age >= 4 AND min_age < max_age ),
    ADD CONSTRAINT check_weight_category
    CHECK ( weight_category IN ('light', 'average', 'heavy', 'absolut') ),
    ADD CONSTRAINT check_gender
    CHECK ( gender IN ('male', 'female', 'united') ),
    ADD CONSTRAINT check_battle_scheme
    CHECK ( battle_scheme IN ('Circle', 'Single Elimination', 'Double Elimination') );

ALTER TABLE judges
    ALTER first_name SET NOT NULL,
    ALTER last_name SET NOT NULL,
    ALTER experience SET NOT NULL,
    ALTER category SET NOT NULL,
    ALTER salary SET NOT NULL,
    ADD CONSTRAINT check_name
    CHECK ( first_name != '' AND last_name != '' ),
    ADD CONSTRAINT check_experience
    CHECK ( experience >= 0 ), 
    ADD CONSTRAINT check_category
    CHECK ( category > 0 AND category < 4 ),
    ADD CONSTRAINT check_salary
    CHECK ( salary > 0 );

ALTER TABLE tournament
    ADD FOREIGN KEY (fighter_id) REFERENCES fighters(id) ON DELETE CASCADE,
    ADD FOREIGN KEY (nomination_id) REFERENCES nominations(id) ON DELETE CASCADE,
    ALTER warnings SET NOT NULL,
    ALTER applied_hits SET NOT NULL,
    ALTER skipped_hits SET NOT NULL,
    ADD CONSTRAINT check_warnings
    CHECK ( warnings >= 0 AND warnings < 5 ),
    ADD CONSTRAINT check_hits
    CHECK ( applied_hits >= 0 AND skipped_hits >= 0 );


ALTER TABLE judging
    ADD FOREIGN KEY (judge_id) REFERENCES judges(id) ON DELETE CASCADE,
    ADD FOREIGN KEY (nomination_id) REFERENCES nominations(id) ON DELETE CASCADE;
