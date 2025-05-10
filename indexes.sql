-- DROP INDEX idx_geoloc ON festival;
CREATE UNIQUE INDEX idx_geoloc
ON festival (latitude, longtitude);

-- DROP INDEX idx_festyear ON shows;
CREATE INDEX idx_festyear
ON shows (fest_year);

-- DROP INDEX idx_stage ON shows;
CREATE INDEX idx_stage
ON shows (stage_id);

-- DROP INDEX idx_stageq ON equip_req;
CREATE INDEX idx_stageq
ON equip_req (stage_id);

-- DROP INDEX idx_deveq ON equip_req;
CREATE INDEX idx_deveq
ON equip_req (device);

-- DROP INDEX idx_staffid ON show_staff;
CREATE INDEX idx_staffid
ON show_staff (staff_id);

-- DROP INDEX idx_showid ON show_staff;
CREATE INDEX idx_showid
ON show_staff (show_id);

-- DROP INDEX idx_showreq ON staff_req;
CREATE INDEX idx_showreq
ON staff_req (show_id);

-- DROP INDEX idx_artid ON membership;
CREATE INDEX idx_artid
ON membership (artist_id);

-- DROP INDEX idx_banid ON membership;
CREATE INDEX idx_banid
ON membership (band_id);

-- DROP INDEX idx_band ON performance;
CREATE INDEX idx_band
ON performance (band_id);

-- DROP INDEX idx_prefloc ON performance;
CREATE INDEX idx_prefloc
ON performance (stage_id);

-- DROP INDEX idx_perfshow ON performance;
CREATE INDEX idx_perfshow
ON performance (show_id);

-- DROP INDEX idx_tickhold ON ticket;
CREATE INDEX idx_tickhold
ON ticket (person_id);

-- DROP INDEX idx_tickshow ON ticket;
CREATE INDEX idx_tickshow
ON ticket (show_id);

-- DROP INDEX idx_tickint ON buyer_queue;
CREATE INDEX idx_tickint
ON buyer_queue (ticket_id);

-- DROP INDEX idx_perfint ON buyer_queue;
CREATE INDEX idx_perfint
ON buyer_queue (performance_id);

-- DROP INDEX idx_buyint ON buyer_queue;
CREATE INDEX idx_buyint
ON buyer_queue (person_id);

-- DROP INDEX idx_sellint ON seller_queue;
CREATE INDEX idx_sellint
ON seller_queue (person_id);

-- DROP INDEX idx_forsale ON seller_queue;
CREATE INDEX idx_forsale
ON seller_queue (ticket_id);

-- DROP INDEX idx_reviewer ON review;
CREATE INDEX idx_reviewer
ON review (ticket_id);

-- DROP INDEX idx_perffo ON review;
CREATE INDEX idx_perffo
ON review (performance_id);

-- DROP INDEX idx_shows_showdate_id ON Shows;
CREATE INDEX idx_shows_showdate_id 
ON Shows(show_date, show_id);

-- DROP INDEX idx_perf_solo_style_show ON performance;
CREATE INDEX idx_perf_solo_style_show 
ON performance(style, band_id, show_id, artist_id);

-- DROP INDEX idx_perf_band_style_show ON performance;
CREATE INDEX idx_perf_band_style_show 
ON performance(band_id, style, show_id);

-- DROP INDEX idx_shows_id_festyear ON shows;
CREATE INDEX idx_shows_id_festyear 
ON shows(show_id, fest_year);

-- DROP INDEX idx_membership_band_artist ON membership;
CREATE INDEX idx_membership_band_artist 
ON membership(band_id, artist_id);

-- DROP INDEX idx_artist_birth ON artist;
CREATE INDEX idx_artist_birth 
ON artist(birth_date, artist_id);

-- DROP INDEX idx_perf_band_show ON performance;
CREATE INDEX idx_perf_band_show 
ON performance(band_id, show_id);

-- DROP INDEX idx_membership_artist_band ON membership;
CREATE INDEX idx_membership_artist_band 
ON membership(artist_id, band_id);

-- DROP INDEX idx_shows_festyear_id ON shows;
CREATE INDEX idx_shows_festyear_id 
ON shows(fest_year, show_id);

-- DROP INDEX idx_showstaff_show_staff ON show_staff;
CREATE INDEX idx_showstaff_show_staff 
ON show_staff(show_id, staff_id);

-- DROP INDEX idx_staff_specialty_id ON staff;
CREATE INDEX idx_staff_specialty_id 
ON staff(specialty, staff_id);

-- DROP INDEX idx_ticket_active_show_person ON ticket;
CREATE INDEX idx_ticket_active_show_person 
ON ticket(activation, show_id, person_id);

-- DROP INDEX idx_person_id_name ON person;
CREATE INDEX idx_person_id_name 
ON person(person_id, first_name, last_name);

-- DROP INDEX idx_perf_artist_show ON performance;
CREATE INDEX idx_perf_artist_show 
ON performance(artist_id, show_id);

-- DROP INDEX idx_artist_id_name_only ON artist;
CREATE INDEX idx_artist_id_name_only 
ON artist(artist_id, artist_name);

-- DROP INDEX idx_festival_coords ON festival;
CREATE INDEX idx_festival_coords 
ON festival(latitude, longtitude, fest_year);

-- DROP INDEX idx_location_coords_continent ON location;
CREATE INDEX idx_location_coords_continent 
ON location(latitude, longtitude, continent);

-- DROP INDEX idx_review_ticket_perf_total ON review;
CREATE INDEX idx_review_ticket_perf_total 
ON review(ticket_id, performance_id, total);

-- DROP INDEX idx_perf_id_artist ON performance;
CREATE INDEX idx_perf_id_artist 
ON performance(performance_id, artist_id);