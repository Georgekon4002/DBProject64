-- Festivals and shows cannot be cancelled
DROP TRIGGER IF EXISTS cancel_fest;
CREATE TRIGGER cancel_fest
BEFORE DELETE ON festival
FOR EACH ROW
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Festivals cannot be cancelled';

DROP TRIGGER IF EXISTS cancel_show;
CREATE TRIGGER cancel_show
BEFORE DELETE ON shows
FOR EACH ROW
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Shows cannot be cancelled';

-- Reviews can be registered only by users with valid tickets
DROP TRIGGER IF EXISTS valid_reviews;
DELIMITER //
CREATE TRIGGER valid_reviews
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
	IF NOT EXISTS(
		SELECT 1 FROM ticket t JOIN performance p ON p.show_id=t.show_id
		WHERE t.person_id=NEW.person_id AND p.performance_id=NEW.performance_id AND t.activation=TRUE
	)
    THEN SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='Only visitors who activated their tickets can submit reviews';
  END IF;	
END//
DELIMITER ;

-- Activation only once
DROP TRIGGER IF EXISTS activate_once;
DELIMITER //
CREATE TRIGGER activate_once
BEFORE UPDATE ON ticket
FOR EACH ROW
BEGIN
	IF NEW.activation=TRUE AND OLD.activation=TRUE
		THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT='Ticket already activated';
  END IF;
END//
DELIMITER ;

-- Check capacity when buying ticket
DROP TRIGGER IF EXISTS sold_out;
DELIMITER //
CREATE TRIGGER sold_out
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
	DECLARE max_cap INT;
  DECLARE ticket_count INT;
  
  SELECT s.max_capacity INTO max_cap FROM shows e
  JOIN stage s ON s.stage_id=e.stage_id WHERE e.show_id=NEW.show_id;
  
  SELECT COUNT(*) INTO ticket_count FROM ticket t WHERE t.show_id=NEW.show_id;
  
  IF ticket_count>=max_cap THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='Sold Out Show!';
  END IF;
END//
DELIMITER ;

-- VIP Tickets=10% Capacity
DROP TRIGGER IF EXISTS vip_tickets;
DELIMITER //
CREATE TRIGGER vip_tickets
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
	DECLARE max_cap INT;
	DECLARE vip_count INT;
	IF NEW.category='VIP' THEN
		SELECT s.max_capacity INTO max_cap FROM shows e
		JOIN stage s ON s.stage_id=e.stage_id WHERE e.show_id=NEW.show_id;
        
		SELECT COUNT(*) INTO vip_count FROM ticket t 
		WHERE t.show_id=NEW.show_id AND t.category='VIP';
		
		IF vip_count>=(0.1*max_cap) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='Sold Out VIP Tickets!';
		END IF;
  END IF;
END//
DELIMITER ;

-- General Tickets Sold Out
DROP TRIGGER IF EXISTS nonvip_tickets;
DELIMITER //
CREATE TRIGGER nonvip_tickets
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
	DECLARE max_cap INT;
	DECLARE nonvip_count INT;
	IF NEW.category='General' OR NEW.category='Backstage' THEN
		SELECT s.max_capacity INTO max_cap FROM shows e
		JOIN stage s ON s.stage_id=e.stage_id WHERE e.show_id=NEW.show_id;
        
		SELECT COUNT(*) INTO nonvip_count FROM ticket t 
		WHERE t.show_id=NEW.show_id AND t.category<>'VIP';
		
		IF nonvip_count>=(0.9*max_cap) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='Sold Out Non-VIP Tickets!';
		END IF;
  END IF;
END//
DELIMITER ;

-- Security Staff>=5% Spectators AND Assistants>=2% Spectators
DROP TRIGGER IF EXISTS enough_staff;
DELIMITER //
CREATE TRIGGER enough_staff
BEFORE INSERT ON staff_req
FOR EACH ROW
BEGIN
	DECLARE spectators INT;
  SELECT COUNT(*) INTO spectators FROM ticket t
  WHERE t.show_id=NEW.show_id;
  
  IF NEW.specialty='Security' AND NEW.quantity<(spectators*0.05) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='Security requirement must be at least 5% of spectators';
  END IF;

	IF NEW.specialty='Assistants' AND NEW.quantity<(spectators*0.02) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT='Assistansts requirement must be at least 2% of spectators';
  END IF;
END//
DELIMITER ;

-- A staff member can't be at 2 shows at the same time
DROP TRIGGER IF EXISTS staff_conflict;
DELIMITER //
CREATE TRIGGER staff_conflict
BEFORE INSERT ON show_staff
FOR EACH ROW
BEGIN
  DECLARE conflict_count INT;

  SELECT COUNT(*) INTO conflict_count FROM show_staff ss
  JOIN performance p1 ON ss.show_id = p1.show_id
  JOIN shows s1 ON s1.show_id = p1.show_id
  JOIN performance p2 ON p2.show_id = NEW.show_id
  JOIN shows s2 ON s2.show_id = p2.show_id
  WHERE ss.staff_id = NEW.staff_id
    AND s1.show_date = s2.show_date
    AND (
      TIME(p1.start_time) < TIME(ADDTIME(p2.start_time, p2.duration)) AND
      TIME(p2.start_time) < TIME(ADDTIME(p1.start_time, p1.duration))
    );

  IF conflict_count>0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Staff member already assigned to overlapping show';
  END IF;
END//
DELIMITER ;

-- An artist/band can't perform on 2 stages at the same time
DROP TRIGGER IF EXISTS perf_conflict;
DELIMITER //
CREATE TRIGGER perf_conflict
BEFORE INSERT ON perfomance
FOR EACH ROW
BEGIN
	DECLARE perf_end TIME;
  SET perf_end = ADDTIME(NEW.start_time, NEW.duration);
    
  IF NEW.artist_id IS NOT NULL THEN
    IF EXISTS(
      SELECT 1 FROM performance p
      WHERE p.artist_id = NEW.artist_id
        AND p.stage_id != NEW.stage_id
        AND p.show_id = NEW.show_id
        AND p.start_time < perf_end
        AND NEW.start_time < ADDTIME(p.start_time, p.duration)
    )
      THEN SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Artist is already performing on another stage at this time';
    END IF;
  
    IF EXISTS(
      SELECT 1 FROM membership m
      JOIN performance p ON p.band_id = m.band_id
      WHERE m.artist_id = NEW.artist_id
        AND p.stage_id != NEW.stage_id
        AND p.show_id = NEW.show_id
        AND p.start_time < perf_end
        AND NEW.start_time < ADDTIME(p.start_time, p.duration)
      ) 
        THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Artist is performing with a band on another stage at this time';
      END IF;
  END IF;
  
  IF NEW.band_id IS NOT NULL THEN
    IF EXISTS(
      SELECT 1  FROM performance p
      WHERE p.band_id = NEW.band_id
        AND p.stage_id != NEW.stage_id
        AND p.show_id = NEW.show_id
        AND p.start_time < perf_end
        AND NEW.start_time < ADDTIME(p.start_time, p.duration)
    ) 
      THEN SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Band is already performing on another stage at this time';
    END IF;
      
    IF EXISTS(
      SELECT 1 FROM membership m
      JOIN performance p ON p.artist_id = m.artist_id
      WHERE m.band_id = NEW.band_id
        AND p.stage_id != NEW.stage_id
        AND p.show_id = NEW.show_id
        AND p.start_time < perf_end
        AND NEW.start_time < ADDTIME(p.start_time, p.duration)
    ) 
      THEN SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'A band member is performing solo on another stage at this time';
    END IF;
  END IF;
END//
DELIMITER ;

-- An arist/band can't perform for 3 consecutive years
DROP TRIGGER IF EXISTS max_consecutive_perf;
DELIMITER //
CREATE TRIGGER max_consecutive_perf
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
  DECLARE y INT;
  DECLARE count_years1 INT;
  DECLARE count_years2 INT;
  DECLARE count_years3 INT;

  SELECT YEAR(s.show_date) INTO y FROM shows s 
  WHERE s.show_id = NEW.show_id;

  SELECT COUNT(DISTINCT YEAR(s.show_date)) INTO count_years1
  FROM performance p
  JOIN shows s ON s.show_id = p.show_id
  WHERE 
    (p.artist_id = NEW.artist_id OR p.band_id = NEW.band_id)
    AND (YEAR(s.show_date) = y - 1 OR YEAR(s.show_date) = y - 2);

  SELECT COUNT(DISTINCT YEAR(s.show_date)) INTO count_years2
  FROM performance p
  JOIN shows s ON s.show_id = p.show_id
  WHERE 
    (p.artist_id = NEW.artist_id OR p.band_id = NEW.band_id)
    AND (YEAR(s.show_date) = y - 1 OR YEAR(s.show_date) = y + 1);

  SELECT COUNT(DISTINCT YEAR(s.show_date)) INTO count_years3
  FROM performance p
  JOIN shows s ON s.show_id = p.show_id
  WHERE 
    (p.artist_id = NEW.artist_id OR p.band_id = NEW.band_id)
    AND (YEAR(s.show_date) = y + 1 OR YEAR(s.show_date) = y + 2);

  IF (count_years1=2 OR count_years2=2 OR count_years3=2) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Artist/Band cannot perform for 3 consecutive years';
  END IF;
END//
DELIMITER ;

-- ONE ticket/day and show/person
DROP TRIGGER IF EXISTS one_ticket_per_day_show;
DELIMITER //
CREATE TRIGGER one_ticket_per_day_show
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
  DECLARE existing_ticket_count INT;

	SELECT COUNT(*) INTO existing_ticket_count
  FROM ticket t
  JOIN shows s ON s.show_id = t.show_id
  WHERE t.person_id = NEW.person_id
	  AND s.show_date = NEW.purchase_date
	  AND t.show_id = NEW.show_id;
        
  IF existing_ticket_count>0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'A person can only buy one ticket per day and show';
  END IF;
END//
DELIMITER ;    

-- Break MIN 5 mins and MAX 30 mins (Consecutive Performances)
DROP TRIGGER IF EXISTS break_time;
DELIMITER //
CREATE TRIGGER break_time
BEFORE INSERT ON performance
FOR EACH ROW
BEGIN
  DECLARE last_end TIME;

  SELECT ADDTIME(p.start_time, p.duration) INTO last_end
  FROM performance p
  WHERE p.stage_id = NEW.stage_id
    AND p.show_id = NEW.show_id
    AND p.start_time < NEW.start_time
  ORDER BY p.start_time DESC
  LIMIT 1;

  IF last_end IS NOT NULL THEN
    IF TIMESTAMPDIFF(MINUTE, prev_end_time, NEW.start_time) < 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Minimum break time between performances is 5 minutes';
    END IF;

    IF TIMESTAMPDIFF(MINUTE, prev_end_time, NEW.start_time) > 30 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Maximum break time between performances is 30 minutes';
    END IF;
  END IF;
END//
DELIMITER ;

-- EAN13
DROP TRIGGER IF EXISTS ean13_check;
DELIMITER //
CREATE TRIGGER ean13_check
BEFORE INSERT ON ticket
FOR EACH ROW
BEGIN
  DECLARE prefix INT;
  DECLARE gs1_pref INT;

  -- Check if the prefix is valid
  SET prefix=LEFT(NEW.EAN13_code, 3);
  SELECT l.gs1_prefix INTO gs1_pref
  FROM shows s
  JOIN stage st ON s.stage_id=st.stage_id
  JOIN festival f ON st.fest_year=f.fest_year
  JOIN location l ON f.latitude=l.latitude AND f.longtitude=l.longtitude
  WHERE s.show_id=NEW.show_id;

  IF prefix != gs1_pref THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'EAN-13 code prefix does not match the country of the show';
  END IF;

  -- Check if it's 13 digits
  IF LENGTH(NEW.EAN13_code) != 13 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'EAN-13 code must be 13 digits';
  END IF;

  -- Check validity of the EAN-13 code
  DECLARE sum INT DEFAULT 0;
  DECLARE i INT DEFAULT 1;
  DECLARE digit INT;
  DECLARE expected_check_digit INT;
  DECLARE check_digit INT;
  SET check_digit = RIGHT(NEW.EAN13_code, 1);

  WHILE i <= 12 DO
    SET digit = CAST(SUBSTRING(NEW.EAN13_code, i, 1) AS UNSIGNED);
    SET sum = sum + digit * IF(MOD(i, 2) = 0, 3, 1);
    SET i = i + 1;
  END WHILE;
  SET expected_check_digit = (10 - MOD(sum, 10)) % 10;
  IF expected_check_digit != check_digit THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid EAN-13 code';
  END IF;
END//
DELIMITER ;

-- Buyer/Seller FIFO

-- If we insert staff requirement we check if there is already requested
DROP TRIGGER IF EXISTS staff_req_check;
DELIMITER //
CREATE TRIGGER staff_req_check
BEFORE INSERT ON staff_req
FOR EACH ROW
BEGIN
  DECLARE existing_req_count INT;

  SELECT COUNT(*) INTO existing_req_count
  FROM staff_req sr
  WHERE sr.show_id = NEW.show_id
    AND sr.specialty = NEW.specialty;

  IF existing_req_count > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Staff requirement already exists for this show. Update it instead.';
  END IF;
END//