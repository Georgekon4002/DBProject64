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

-- Location different each year

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

    IF conflict_count > 0 THEN
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
		 IF EXISTS (
            SELECT 1 FROM performance p
            WHERE p.artist_id = NEW.artist_id
              AND p.stage_id != NEW.stage_id
              AND p.show_id = NEW.show_id
              AND p.start_time < perf_end
              AND NEW.start_time < ADDTIME(p.start_time, p.duration)
			) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Artist is already performing on another stage at this time';
        END IF;
		
		IF EXISTS (
            SELECT 1 FROM membership m
            JOIN performance p ON p.band_id = m.band_id
            WHERE m.artist_id = NEW.artist_id
              AND p.stage_id != NEW.stage_id
              AND p.show_id = NEW.show_id
              AND p.start_time < perf_end
              AND NEW.start_time < ADDTIME(p.start_time, p.duration)
			) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Artist is performing with a band on another stage at this time';
        END IF;
	END IF;
    
    IF NEW.band_id IS NOT NULL THEN
        IF EXISTS (
            SELECT 1  FROM performance p
            WHERE p.band_id = NEW.band_id
              AND p.stage_id != NEW.stage_id
              AND p.show_id = NEW.show_id
              AND p.start_time < perf_end
              AND NEW.start_time < ADDTIME(p.start_time, p.duration)
			) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Band is already performing on another stage at this time';
        END IF;
        
        IF EXISTS (
            SELECT 1 FROM membership m
            JOIN performance p ON p.artist_id = m.artist_id
            WHERE m.band_id = NEW.band_id
              AND p.stage_id != NEW.stage_id
              AND p.show_id = NEW.show_id
              AND p.start_time < perf_end
              AND NEW.start_time < ADDTIME(p.start_time, p.duration)
			) THEN
            SIGNAL SQLSTATE '45000'
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
  DECLARE count_years INT;

  SELECT YEAR(s.show_date) INTO y FROM shows s 
  WHERE s.show_id = NEW.show_id;

  SELECT COUNT(DISTINCT YEAR(s.show_date)) INTO count_years
  FROM performance p
  JOIN shows s ON s.show_id = p.show_id
  WHERE 
    (p.artist_id = NEW.artist_id OR p.band_id = NEW.band_id)
    AND YEAR(s.show_date) = y - 1 OR YEAR(s.show_date) = y - 2;

  IF count_years = 2 THEN
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
        
    IF existing_ticket_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A person can only buy one ticket per day and show';
    END IF;
END//
DELIMITER ;        
    
    



-- Staff requirements met VIEW

-- Break MIN 5 mins and MAX 30 mins (Consecutive Performances)
-- EAN13
-- Buyer/Seller FIFO

