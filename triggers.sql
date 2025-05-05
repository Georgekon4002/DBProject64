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

-- Staff requirements met VIEW

-- A staff member can't be at 2 shows at the same time


-- An artist/band can't perform on 2 stages at the same time
-- An arist/band can't perform for 3 consecutive years
-- Break MIN 5 mins and MAX 30 mins (Consecutive Performances)

-- EAN13
-- ONE ticket/day and show/person
-- Buyer/Seller FIFO

