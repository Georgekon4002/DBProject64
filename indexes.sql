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