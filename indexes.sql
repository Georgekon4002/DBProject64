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
CREATE INDEX idx_stageq
ON equip_req (device);

--DROP INDEX idx_staffid;
CREATE INDEX idx_staffid
ON show_staff (staff_id);

--DROP INDEX idx_staffid;
CREATE INDEX idx_showid
ON show_staff (show_id);

--DROP INDEX idx_staffid;
CREATE INDEX idx_showid
ON show_staff (show_id);



