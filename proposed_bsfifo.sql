-- ✅ Constraint: Different Location Each Year (via UNIQUE index)
ALTER TABLE festival
ADD CONSTRAINT unique_location_per_year UNIQUE (fest_year, latitude, longtitude);

-- ✅ FIFO: Buyer/Seller Ticket Exchange Implementation

-- Buyer Queue (interested in ticket category or specific ticket)
CREATE TABLE buyer_queue (
  buyer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  visitor_id INT NOT NULL,
  perf_interest INT,
  category_interest VARCHAR(50),
  ticket_interest INT,
  request_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_buyer_visitor FOREIGN KEY (visitor_id) REFERENCES visitor(visitor_id),
  CONSTRAINT fk_buyer_perf FOREIGN KEY (perf_interest) REFERENCES performance(performance_id),
  CONSTRAINT fk_buyer_ticket FOREIGN KEY (ticket_interest) REFERENCES ticket(ticket_id),
  CHECK ((ticket_interest IS NOT NULL AND perf_interest IS NULL AND category_interest IS NULL)
      OR (ticket_interest IS NULL AND perf_interest IS NOT NULL AND category_interest IS NOT NULL))
);

-- Seller Queue (offering a ticket for resale)
CREATE TABLE seller_queue (
  seller_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  ticket_id INT NOT NULL,
  offer_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_seller_ticket FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
  CHECK ((SELECT activated FROM ticket WHERE ticket_id = seller_queue.ticket_id) = 0)
);

-- Matching Procedure (simplified logic for matching buyer & seller)
DELIMITER //
CREATE PROCEDURE match_resale_queue()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE t_id INT;
  DECLARE b_id INT;

  -- Cursor over seller queue
  DECLARE seller_cursor CURSOR FOR
    SELECT ticket_id FROM seller_queue ORDER BY offer_time;

  -- Iterate through seller queue
  OPEN seller_cursor;
  seller_loop: LOOP
    FETCH seller_cursor INTO t_id;
    IF done THEN LEAVE seller_loop; END IF;

    -- Try to find matching buyer
    SELECT buyer_id INTO b_id
    FROM buyer_queue b
    JOIN ticket t ON t_id = t.ticket_id
    JOIN shows s ON t.show_id = s.show_id
    JOIN performance p ON b.perf_interest = p.performance_id AND p.show_id = s.show_id
    WHERE b.ticket_interest = t_id OR (b.category_interest = t.ticket_type AND b.perf_interest = p.performance_id)
    ORDER BY b.request_time ASC
    LIMIT 1;

    -- If match found, transfer ownership and remove from queues
    IF b_id IS NOT NULL THEN
      UPDATE ticket SET visitor_id = (SELECT visitor_id FROM buyer_queue WHERE buyer_id = b_id)
      WHERE ticket_id = t_id;

      DELETE FROM buyer_queue WHERE buyer_id = b_id;
      DELETE FROM seller_queue WHERE ticket_id = t_id;
    END IF;
  END LOOP;
  CLOSE seller_cursor;
END//
DELIMITER ;