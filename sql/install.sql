-- I) Schema

DROP SCHEMA IF EXISTS music_festival;
CREATE SCHEMA music_festival;
USE music_festival;

DROP TABLE IF EXISTS location;
CREATE TABLE location(
    latitude DOUBLE NOT NULL CHECK (latitude BETWEEN -90 AND 90),
    longtitude DOUBLE NOT NULL CHECK (longtitude BETWEEN -180 AND 180),
    address VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    continent VARCHAR(50) NOT NULL CHECK (continent IN ('Europe', 'Asia', 'North America', 'South America', 'Africa', 'Oceania')),
    PRIMARY KEY (latitude,longtitude),
    loc_img TEXT,
    loc_desc TEXT
);

DROP TABLE IF EXISTS festival; 
CREATE TABLE festival(
    fest_year YEAR UNIQUE NOT NULL PRIMARY KEY,
    start_date DATE UNIQUE NOT NULL,
    end_date DATE UNIQUE NOT NULL,
    CHECK (end_date>=start_date AND EXTRACT(YEAR FROM start_date)=EXTRACT(YEAR FROM end_date)),
    latitude DOUBLE NOT NULL CHECK (latitude BETWEEN -90 AND 90), 
    longtitude DOUBLE NOT NULL CHECK (longtitude BETWEEN -180 AND 180),
    CONSTRAINT fest_loc FOREIGN KEY (latitude, longtitude) REFERENCES location(latitude, longtitude),
    fest_poster TEXT,
    fest_desc TEXT
);

DROP TABLE IF EXISTS stage;
CREATE TABLE stage(
    stage_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stage_name VARCHAR(50) NOT NULL,
    stage_description TEXT NOT NULL,
    max_capacity INT NOT NULL,
    stage_img TEXT,
    stage_desc TEXT
);

DROP TABLE IF EXISTS shows; 
CREATE TABLE shows(
    show_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fest_year YEAR NOT NULL,
    stage_id INT NOT NULL,
    show_date DATE NOT NULL,
    CONSTRAINT fest_show FOREIGN KEY (fest_year) REFERENCES festival(fest_year),
    CONSTRAINT show_loc FOREIGN KEY (stage_id) REFERENCES stage(stage_id),
    show_poster TEXT,
    show_desc TEXT
);

DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment(
    device VARCHAR(50) PRIMARY KEY,
    device_img TEXT,
    device_desc TEXT
);

DROP TABLE IF EXISTS equip_req;
CREATE TABLE equip_req(
    stage_id INT NOT NULL,
    device VARCHAR(50) NOT NULL,
    quantity INT NOT NULL CHECK (quantity>0),
    PRIMARY KEY (stage_id, device),
    CONSTRAINT stage_equipment FOREIGN KEY (stage_id) REFERENCES stage(stage_id),
    CONSTRAINT device_equipment FOREIGN KEY (device) REFERENCES equipment(device)
);

DROP TABLE IF EXISTS staff;
CREATE TABLE staff(
    staff_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT NOT NULL CHECK (age>0),
    specialty VARCHAR(50) CHECK (specialty IN ('Technical', 'Security', 'Assistants')),
    experience VARCHAR(50) CHECK (experience IN ('Intern','Beginner', 'Intermediate', 'Experienced', 'Master')),
    staff_img TEXT,
    staff_desc TEXT
);

DROP TABLE IF EXISTS show_staff;
CREATE TABLE show_staff(
    staff_id INT NOT NULL,
    show_id INT NOT NULL,
    PRIMARY KEY (staff_id,show_id),
    CONSTRAINT FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

DROP TABLE IF EXISTS staff_req;
CREATE TABLE staff_req(
    show_id INT NOT NULL,
    specialty VARCHAR(50) CHECK (specialty IN ('Technical', 'Security', 'Assistants')),
    quantity INT NOT NULL CHECK (quantity>0),
    PRIMARY KEY (stage_id, specialty),
    CONSTRAINT show_req FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

DROP TABLES IF EXISTS artist;
CREATE TABLE artist(
    artist_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    artist_name VARCHAR(50) NOT NULL,
    alias VARCHAR(50),
    birthday DATE NOT NULL,
    genre VARCHAR(50) NOT NULL,
    subgenre VARCHAR(50) NOT NULL,
    website VARCHAR(100) CHECK (website LIKE 'https://%'),
    instagram VARCHAR(31) CHECK (instagram LIKE '@%'),
    artist_img TEXT,
    artist_desc TEXT
);

DROP TABLES IF EXISTS band;
CREATE TABLE band(
    band_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    band_name VARCHAR(50) NOT NULL,
    formed_date DATE NOT NULL,
    website VARCHAR(100) CHECK (website LIKE 'https://%'),
    instagram VARCHAR(31) CHECK (instagram LIKE '@%'),
    band_img TEXT,
    band_desc TEXT
);

DROP TABLE IF EXISTS membership;
CREATE TABLE membership(
    artist_id INT NOT NULL,
    band_id INT NOT NULL,
    PRIMARY KEY (artist_id, band_id),
    CONSTRAINT FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
    CONSTRAINT FOREIGN KEY (band_id) REFERENCES band(band_id)
);

DROP TABLE IF EXISTS performance;
CREATE TABLE performance(
    performance_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    style VARCHAR(50) CHECK (style IN ('Warm Up', 'Headline', 'Special Guest')),
    start_time TIME NOT NULL,
    duration TIME NOT NULL CHECK (duration<'03:00:00'),
    artist_id INT,
    band_id INT,
    stage_id INT NOT NULL,
    show_id INT NOT NULL,
    CONSTRAINT solo FOREIGN KEY (artist_id) REFERENCES artist (artist_id),
    CONSTRAINT bands FOREIGN KEY (band_id) REFERENCES band (band_id),
    CHECK ((artist_id IS NOT NULL AND band_id IS NULL) OR (artist_id IS NULL AND band_id IS NOT NULL)),
    CONSTRAINT perf_loc FOREIGN KEY (stage_id) REFERENCES stage(stage_id),
    CONSTRAINT perf_show FOREIGN KEY (show_id) REFERENCES shows(show_id),
    perf_poster TEXT,
    perf_desc TEXT
);

DROP TABLE IF EXISTS person;
CREATE TABLE person(
    person_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(16) NOT NULL CHECK (phone_number LIKE '+%'),
    age INT NOT NULL CHECK (age>0)
);

DROP TABLE IF EXISTS ticket;
CREATE TABLE ticket(
    ticket_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    purchase_date DATE NOT NULL,
    category VARCHAR(50) NOT NULL CHECK (category IN ('General', 'VIP', 'Backstage')),
    price DECIMAL(5,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('Credit Card', 'Debit Card', 'Bank Account')),
    EAN13_code BIGINT UNIQUE NOT NULL,
    activation BOOL NOT NULL,
    person_id INT NOT NULL,
    show_id INT NOT NULL,
    CONSTRAINT holder FOREIGN KEY (person_id) REFERENCES person(person_id),
    CONSTRAINT show_info FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

DROP TABLE IF EXISTS buyer_queue;
CREATE TABLE buyer_queue(
    buyer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    category_interest VARCHAR(50),
    btimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ticket_id INT,
    performance_id INT,
    person_id INT NOT NULL,
    CONSTRAINT ticket_interest FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
    CONSTRAINT perf_interest FOREIGN KEY (performance_id) REFERENCES performance(performance_id),
    CONSTRAINT buying_interest FOREIGN KEY (person_id) REFERENCES person(person_id),
    CHECK ((ticket_id IS NOT NULL AND performance_id IS NULL AND category_interest IS NULL) OR (ticket_id IS NULL AND performance_id IS NOT NULL AND category_interest IS NOT NULL))
);

DROP TABLE IF EXISTS seller_queue;
CREATE TABLE seller_queue(
    seller_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    stimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    person_id INT NOT NULL,
    ticket_id INT NOT NULL,
    CONSTRAINT selling_interest FOREIGN KEY (person_id) REFERENCES person(person_id),
    CONSTRAINT for_sale FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id)
);

DROP TABLE IF EXISTS review;
CREATE TABLE review(
    review_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    rendition INT CHECK (rendition BETWEEN 1 AND 5),
    sound_lighting INT CHECK (sound_lighting BETWEEN 1 AND 5),
    staging INT CHECK (staging BETWEEN 1 AND 5),
    organisation INT CHECK (organisation BETWEEN 1 AND 5),
    total INT CHECK (total BETWEEN 1 AND 5),
    ticket_id INT NOT NULL,
    performance_id INT NOT NULL,
    CONSTRAINT reviewer FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
    CONSTRAINT perf_info FOREIGN KEY (performance_id) REFERENCES performance(performance_id)
);

-- II) Indexing

--DROP INDEX idx_geoloc;
CREATE UNIQUE INDEX idx_geoloc
ON festival (latitude, longtitude);

--DROP INDEX idx_festyear;
CREATE INDEX idx_festyear
ON shows (fest_year);

--DROP INDEX idx_stage;
CREATE INDEX idx_stage
ON shows (stage_id);

--DROP INDEX idx_stegeq;
CREATE INDEX idx_stageq
ON equip_req (stage_id);

--DROP INDEX idx_deveq;
CREATE INDEX idx_deveq
ON equip_req (device);

--DROP INDEX idx_staffid;
CREATE INDEX idx_staffid
ON show_staff (staff_id);

--DROP INDEX idx_showid;
CREATE INDEX idx_showid
ON show_staff (show_id);

--DROP INDEX idx_showreq;
CREATE INDEX idx_showreq
ON staff_req (show_id);

--DROP INDEX idx_artid;
CREATE INDEX idx_artid
ON membership (artist_id);

--DROP INDEX idx_banid;
CREATE INDEX idx_banid
ON membership (band_id);

--DROP INDEX idx_soloart;
CREATE INDEX idx_artid
ON performance (artist_id);

--DROP INDEX idx_band;
CREATE INDEX idx_band
ON performance (band_id);

--DROP INDEX idx_prefloc;
CREATE INDEX idx_prefloc
ON performance (stage_id);

--DROP INDEX idx_perfshow;
CREATE INDEX idx_perfshow
ON performance (show_id);

--DROP INDEX idx_tickhold;
CREATE INDEX idx_tickhold
ON ticket (person_id);

--DROP INDEX idx_tickshow;
CREATE INDEX idx_tickshow
ON ticket (show_id);

--DROP INDEX idx_tickint;
CREATE INDEX idx_tickint
ON buyer_queue (ticket_id);

--DROP INDEX idx_perfint;
CREATE INDEX idx_perfint
ON buyer_queue (performance_id);

--DROP INDEX idx_buyint;
CREATE INDEX idx_buyint
ON buyer_queue (person_id);

--DROP INDEX idx_sellint;
CREATE INDEX idx_sellint
ON seller_queue (person_id);

--DROP INDEX idx_forsale;
CREATE INDEX idx_forsale
ON seller_queue (ticket_id);

--DROP INDEX idx_reviewer;
CREATE INDEX idx_reviewer
ON review (ticket_id);

--DROP INDEX idx_perffo;
CREATE INDEX idx_perffo
ON review (performance_id);

-- III) Triggers

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

-- Staff requirements met VIEW???

-- Break MIN 5 mins and MAX 30 mins (Consecutive Performances)

-- EAN13
-- Buyer/Seller FIFO
