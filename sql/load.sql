-- Locations (10)
INSERT INTO location (latitude, longtitude, address, city, country, continent, gs1_prefix, loc_img, loc_desc)
VALUES
(37.9838, 23.7275, 'Syntagma Square', 'Athens', 'Greece', 'Europe', 520, 'https://example.com/syntagma.jpg', 'A central square in Athens, known for its historical significance.'),
(40.6401, 22.9444, 'Aristotelous Square', 'Thessaloniki', 'Greece', 'Europe', 520, 'https://example.com/aristotelous.jpg', 'The main square of Thessaloniki, a vibrant city center.'),
(41.3851, 2.1734, 'Plaça Catalunya', 'Barcelona', 'Spain', 'Europe', 840, 'https://example.com/placa_catalunya.jpg', 'A large square in the heart of Barcelona.'),
(48.8566, 2.3522, 'Champs-Élysees', 'Paris', 'France', 'Europe', 300, 'https://example.com/champs_elysees.jpg', 'Famous avenue in Paris known for its theaters and cafés.'),
(38.7169, -9.1399, 'Praça do Comércio', 'Lisbon', 'Portugal', 'Europe', 560, 'https://example.com/praca_comercio.jpg', 'A large public square in Lisbon by the Tagus River.'),
(45.4642, 9.1900, 'Piazza Duomo', 'Milan', 'Italy', 'Europe', 800, 'https://example.com/piazza_duomo.jpg', 'The main cathedral square in Milan.'),
(52.5200, 13.4050, 'Alexanderplatz', 'Berlin', 'Germany', 'Europe', 400, 'https://example.com/alexanderplatz.jpg', 'A large public square and transport hub in Berlin.'),
(59.3293, 18.0686, 'Sergels Torg', 'Stockholm', 'Sweden', 'Europe', 730, 'https://example.com/sergels_torg.jpg', 'A central square in Stockholm known for its modern architecture.'),
(50.1109, 8.6821, 'Römerberg', 'Frankfurt', 'Germany', 'Europe', 400, 'https://example.com/roemerberg.jpg', 'The historical heart of Frankfurt with medieval buildings.'),
(40.7128, -74.0060, 'Times Square', 'New York City', 'USA', 000, 'https://example.com/times_square.jpg', 'Famous commercial intersection in New York City.');

-- Festivals (10)
INSERT INTO festival (fest_year, start_date, end_date, latitude, longtitude, fest_poster, fest_desc) VALUES 
(2016, '2016-06-10', '2016-06-12', 37.9838, 23.7275, 'https://example.com/festival_2016.jpg', 'The first edition of the festival, featuring various artists.'),
(2017, '2017-06-15', '2017-06-17', 40.6401, 22.9444, 'https://example.com/festival_2017.jpg', 'The second edition with an expanded lineup.'),
(2018, '2018-07-01', '2018-07-03', 41.3851, 2.1734, 'https://example.com/festival_2018.jpg', 'A special edition with international artists.'),
(2019, '2019-06-20', '2019-06-22', 48.8566, 2.3522, 'https://example.com/festival_2019.jpg', 'A memorable year with record attendance.'),
(2020, '2020-06-25', '2020-06-27', 38.7169, -9.1399, 'https://example.com/festival_2020.jpg', 'A year of challenges but a successful festival nonetheless.'),
(2021, '2021-07-05', '2021-07-07', 45.4642, 9.1900, 'https://example.com/festival_2021.jpg', 'A comeback year with safety measures in place.'),
(2022, '2022-06-12', '2022-06-14', 52.5200, 13.4050, 'https://example.com/festival_2022.jpg', 'An exciting lineup and a great atmosphere.'),
(2023, '2023-06-18', '2023-06-20', 59.3293, 18.0686, 'https://example.com/festival_2023.jpg', 'The latest edition with new features and attractions.'),
(2024, '2025-07-01', '2025-07-03', 50.1109, 8.6821, 'https://example.com/festival_2024.jpg', 'A year of innovation and creativity in the festival scene.'),
(2025, '2026-06-10', '2026-06-12', 40.7128, -74.0060, 'https://example.com/festival_2025.jpg', 'A special edition celebrating the 10th anniversary.');

-- Stages (30)
INSERT INTO stages (stage_id, stage_name, stage_description, max_capacity, stage_img, stage_desc) VALUES 
(1, 'Main Stage Athens', 'Flagship venue in Athens', 10000, 'https://example.com/main_stage_athens.jpg', 'The main stage of the festival located in Athens.'),
(2, 'Side Stage Athens', 'Alternative acts', 3000, 'https://example.com/side_stage_athens.jpg', 'A smaller stage for indie and alternative acts.'),
(3, 'Acoustic Stage Athens', 'Low-key performances', 1500, 'https://example.com/acoustic_stage_athens.jpg', 'An intimate stage for acoustic performances.'),
(4, 'Main Stage Thessaloniki', 'Flagship venue in Thessaloniki', 9000, 'https://example.com/main_stage_thessaloniki.jpg', 'The main stage of the festival located in Thessaloniki.'),
(5, 'Side Stage Thessaloniki', 'Indie acts', 3500, 'https://example.com/side_stage_thessaloniki.jpg', 'A smaller stage for indie acts in Thessaloniki.'),
(6, 'Electro Dome', 'Electronic music only', 2000, 'https://example.com/electro_dome.jpg', 'A stage dedicated to electronic music.'),
(7, 'Placa Stage', 'City center venue', 8000, 'https://example.com/placa_stage.jpg', 'A central stage located in the heart of Barcelona.'),
(8, 'Underground Barca', 'Experimental performances', 2200, 'https://example.com/underground_barca.jpg', 'A stage for experimental and avant-garde performances.'),
(9, 'Sunset Vibes', 'Outdoor chill sets', 1800, 'https://example.com/sunset_vibes.jpg', 'An outdoor stage for relaxing sunset performances.'),
(10, 'Seine Stage', 'Paris main show floor', 9500, 'https://example.com/seine_stage.jpg', 'The main show floor located by the Seine River.'),
(11, 'Jazz Cellar', 'Jazz-focused venue', 2500, 'https://example.com/jazz_cellar.jpg', 'A cozy venue dedicated to jazz music.'),
(12, 'Electro Garden', 'Techno and house', 3200, 'https://example.com/electro_garden.jpg', 'A garden-themed stage for techno and house music.'),
(13, 'Lisbon Main', 'Central stage near water', 7000, 'https://example.com/lisbon_main.jpg', 'The main stage located near the water in Lisbon.'),
(14, 'Lisbon Local', 'Portuguese indie', 2300, 'https://example.com/lisbon_local.jpg', 'A stage dedicated to local Portuguese indie acts.'),
(15, 'Lisbon Lights', 'Visuals & effects', 1600, 'https://example.com/lisbon-lights.jpg', 'A stage known for its stunning visuals and effects.'),
(16, 'Duomo Stage', 'Piazza venue', 9800, 'https://example.com/duomo_stage.jpg', 'A stage located in the famous Duomo square.'),
(17, 'Experimental Milan', 'Avant-garde, performance art', 2100, 'https://example.com/experimental_milan.jpg', 'A stage for avant-garde and performance art.'),
(18, 'Retro Soundscape', 'Synth classics', 2500, 'https://example.com/retro_soundscape.jpg', 'A stage dedicated to retro synth music.'),
(19, 'Brandenburg Main', 'Berlin’s top stage', 12000, 'https://example.com/brandenburg_main.jpg', 'The main stage located in Berlin.'),
(20, 'Checkpoint Indie', 'East Berlin style', 3500, 'https://example.com/checkpoint_indie.jpg', 'A stage for indie acts with an East Berlin vibe.'),
(21, 'TechPark', 'Electronic Berlin', 3000, 'https://example.com/techpark.jpg', 'A stage dedicated to electronic music in Berlin.'),
(22, 'Arctic Arena', 'Big sounds, cool vibes', 7500, 'https://example.com/arctic_arena.jpg', 'A large arena with a cool atmosphere.'),
(23, 'Scandi Stage', 'Nordic pop', 2400, 'https://example.com/scandi_stage.jpg', 'A stage dedicated to Nordic pop music.'),
(24, 'Sverige Cellar', 'Acoustic sets', 1800, 'https://example.com/sverige-cellar.jpg', 'A cozy venue for acoustic sets.'),
(25, 'Romer Rock', 'Rock-oriented venue', 6700, 'https://example.com/romer-rock.jpg', 'A rock-oriented venue in Frankfurt.'),
(26, 'Electro Messe', 'Future sounds', 3400, 'https://example.com/electro-messe.jpg', 'A stage for future sounds and electronic music.'),
(27, 'Jazz Main Frankfurt', 'Jazz headliners', 2600, 'https://example.com/jazz-main-frankfurt.jpg', 'A stage for jazz headliners.'),
(28, 'Manhattan Grand', 'New York’s top venue', 10500, 'https://example.com/manhattan-grand.jpg', 'The top venue in New York City.'),
(29, 'SoHo Groove', 'Indie NY sounds', 3200, 'https://example.com/soho-groove.jpg', 'A stage for indie sounds in SoHo.'),
(30, 'Brooklyn Beats', 'Urban performance hub', 3900, 'https://example.com/brooklyn-beats.jpg','A performance hub in Brooklyn with urban vibes.');

-- Shows (X)
INSERT INTO shows (show_id, fest_year, stage_id, show_date, show_poster, show_desc) VALUES

-- Equipment
INSERT INTO equipment (device, device_img, device_desc) VALUES 


INSERT INTO equip_req(stage_id, device, quantity) VALUES 


-- Staff
INSERT INTO staff (staff_id, first_name, last_name, age, specialty, experience, staff_img, staff_desc) VALUES


INSERT INTO staff_shows (staff_id, show_id) VALUES 


INSERT INTO staff_req (show_id, stage_id, specialty, quantity) VALUES 


-- Artists and Bands (50)
INSERT INTO artists (artist_id, artist_name, alias, birthday, genre, subgenre, website, instagram, artist_img, artist_desc) VALUES 
(1, 'The Weeknd', 'Abel Tesfaye', '1990-02-16', 'R&B', 'Pop', 'https://www.theweeknd.com', '@theweeknd', 'https://example.com/the_weeknd.jpg', 'A Canadian singer-songwriter known for his unique sound.'),
(2, 'Billie Eilish', NULL, '2001-12-18', 'Pop', 'Electropop', 'https://www.billieeilish.com', '@billieeilish', 'https://example.com/billie_eilish.jpg', 'An American singer-songwriter known for her distinctive style.'),
(3, 'Ed Sheeran', NULL, '1991-02-17', 'Pop', 'Folk-pop', 'https://www.edsheeran.com', '@edsheeran', 'https://example.com/ed_sheeran.jpg', 'An English singer-songwriter known for his melodic tunes.'),
(4, 'Taylor Swift', NULL, '1989-12-13', 'Pop', 'Country', 'https://www.taylorswift.com', '@taylorswift', 'https://example.com/taylor_swift.jpg', 'An American singer-songwriter known for her narrative songwriting.'),
(5, 'Beyoncé', NULL, '1981-09-04', 'R&B', 'Pop', 'https://www.beyonce.com', '@beyonce', 'https://example.com/beyonce.jpg', 'An American singer-songwriter and actress.'),
(6, 'Ariana Grande', NULL, '1993-06-26', 'Pop', 'R&B', 'https://www.arianagrande.com', '@arianagrande', 'https://example.com/ariana_grande.jpg', 'An American singer and actress known for her wide vocal range.'),
(7, 'Justin Bieber', NULL, '1994-03-01', 'Pop', 'R&B', 'https://www.justinbiebermusic.com', '@justinbieber', 'https://example.com/justin_bieber.jpg', 'A Canadian singer and songwriter.'),
(8, 'Demi Lovato', NULL, '1992-08-20', 'Pop', 'Rock', 'https://www.demilovato.com', '@ddlovato', 'https://example.com/demi_lovato.jpg', 'An American singer and actress.'),
(9, 'Post Malone', NULL, '1995-07-04', 'Hip-hop', 'Pop', 'https://www.postmalone.com', '@postmalone', 'https://example.com/post_malone.jpg', 'An American rapper and singer-songwriter.'),
(10, 'Katy Perry', NULL, '1984-10-25', 'Pop', NULL, 'https://www.katyperry.com', '@katyperry', 'https://example.com/katy_perry.jpg', 'An American singer-songwriter known for her pop anthems.'),
(11, 'Lady Gaga', NULL, '1986-03-28', 'Pop', 'Dance-pop', 'https://www.ladygaga.com', '@ladygaga', 'https://example.com/lady_gaga.jpg', 'An American singer, songwriter, and actress.'),
(12, 'Bruno Mars', NULL, '1985-10-08', 'Pop', 'Funk', 'https://www.brunomars.com', '@brunomars', 'https://example.com/bruno_mars.jpg', 'An American singer-songwriter and music producer.'),
(13, 'Rihanna', NULL, '1988-02-20', 'Pop', 'R&B', 'https://www.rihanna.com', '@rihanna', 'https://example.com/rihanna.jpg', 'A Barbadian singer and businesswoman.'),
(14, 'Shawn Mendes', NULL, '1998-08-08', 'Pop', NULL, 'https://www.shawnmendesofficial.com', '@shawnmendes', 'https://example.com/shawn_mendes.jpg', 'A Canadian singer-songwriter.'),
(15, 'Halsey', NULL, '1994-09-29', 'Pop', NULL, 'https://www.halsey.com', '@halsey', 'https://example.com/halsey.jpg', 'An American singer and songwriter.'),
(16, 'Sam Smith', NULL, '1992-05-19', 'Pop', 'Soul', 'https://www.samsmithworld.com', '@samsmith', 'https://example.com/sam_smith.jpg', 'An English singer-songwriter known for their soulful voice.'),
(17, 'Miley Cyrus', NULL, '1992-11-23', 'Pop', 'Rock', 'https://www.mileycyrus.com', '@mileycyrus', 'https://example.com/miley_cyrus.jpg', 'An American singer and actress.'),
(18, 'Sia', NULL, '1975-12-18', 'Pop', NULL, 'https://www.siamusic.net', '@sia', 'https://example.com/sia.jpg', 'An Australian singer-songwriter known for her distinctive voice.'),
(19, 'Lorde', NULL, '1996-11-07', 'Pop', 'Electropop', 'https://www.lorde.co.nz', '@lorde', 'https://example.com/lorde.jpg', 'A New Zealand singer-songwriter known for her unique sound.'),
(20, 'Dua Lipa', NULL, '1995-08-22', 'Pop', NULL, 'https://www.dualipa.com', '@dualipa', 'https://example.com/dua_lipa.jpg', 'An English singer and songwriter.');

INSERT INTO band(band_id, band_name, formed_date, website, instagram, band_img, band_desc) VALUES 
(1, 'Coldplay', '1996-01-01', 'https://www.coldplay.com', '@coldplay', 'https://example.com/coldplay.jpg', 'A British rock band known for their melodic sound.'),
(2, 'Imagine Dragons', '2008-01-01', 'https://www.imaginedragonsmusic.com', '@imaginedragons', 'https://example.com/imagine_dragons.jpg', 'An American rock band known for their anthemic sound.'),
(3, 'Maroon 5', '2001-01-01', 'https://www.maroon5.com', '@maroon5', 'https://example.com/maroon_5.jpg', 'An American pop rock band known for their catchy tunes.');
(4, 'Linkin Park', '1996-01-01', 'https://www.linkinpark.com', '@linkinpark', 'https://example.com/linkin_park.jpg', 'An American rock band known for their nu-metal sound.'),
(5, 'The Killers', '2001-01-01', 'https://www.thekillersmusic.com', '@thekillers', 'https://example.com/the_killers.jpg', 'An American rock band known for their synth-pop sound.'),
(6, 'Foo Fighters', '1994-01-01', 'https://www.foofighters.com', '@foofighters', 'https://example.com/foo_fighters.jpg', 'An American rock band known for their energetic performances.'),
(7, 'Paramore', '2004-01-01', 'https://www.paramore.net', '@paramore', 'https://example.com/paramore.jpg', 'An American rock band known for their pop-punk sound.'),
(8, 'Panic! At The Disco', '2004-01-01', 'https://www.panicatthedisco.com', '@panicatthedisco', 'https://example.com/panic_at_the_disco.jpg', 'An American rock band known for their theatrical style.');

INSERT INTO membership(artist_id, band_id) VALUES 

-- Performances (100)
INSERT INTO performances (performance_id, style, start_time, duration, artist_id, band_id, stage_id, show_id, perf_poster, perf_desc) VALUES
(1, 'Warm Up', '18:00:00', '00:30:00', 1, NULL, 1, 1, 'https://example.com/performance_1.jpg', 'A warm-up performance to kick off the festival.'),
(2, 'Headline', '20:00:00', NULL, NULL, 1, 1, 1, 'https://example.com/performance_2.jpg', 'The headline act of the night.'),
(3, 'Special Guest', '22:00:00', NULL, 2, NULL, 2, 2, 'https://example.com/performance_3.jpg', 'A special guest performance.');
(4, 'Warm Up', '18:30:00', '00:45:00', 3, NULL, 3, 3, 'https://example.com/performance_4.jpg', 'A warm-up performance to get the crowd excited.'),
(5, 'Headline', '21:00:00', NULL, NULL, 2, 2, 4, 'https://example.com/performance_5.jpg', 'The headline act of the night.'),
(6, 'Special Guest', '23:00:00', NULL, 4, NULL, 5, 5, 'https://example.com/performance_6.jpg', 'A special guest performance.'),
(7, 'Warm Up', '19:00:00', '00:30:00', 5, NULL, 6, 6, 'https://example.com/performance_7.jpg', 'A warm-up performance to get the crowd ready.'),
(8, 'Headline', '20:30:00', NULL, NULL, 3, 3, 7, 'https://example.com/performance_8.jpg', 'The headline act of the night.'),
(9, 'Special Guest', '22:30:00', NULL, 6, NULL, 8, 8, 'https://example.com/performance_9.jpg', 'A special guest performance.'),
(10, 'Warm Up', '18:15:00', '00:40:00', 7, NULL, 9, 9, 'https://example.com/performance_10.jpg', 'A warm-up performance to get the crowd hyped.'),
(11, 'Headline', '20:45:00', NULL, NULL, 4, 4, 10, 'https://example.com/performance_11.jpg', 'The headline act of the night.'),
(12, 'Special Guest', '23:15:00', NULL, 8, NULL, 11, 11, 'https://example.com/performance_12.jpg', 'A special guest performance.'),
(13, 'Warm Up', '19:15:00', '00:50:00', 9, NULL, 12, 12, 'https://example.com/performance_13.jpg', 'A warm-up performance to get the crowd moving.'),
(14, 'Headline', '21:15:00', NULL, NULL, 5, 5, 13, 'https://example.com/performance_14.jpg', 'The headline act of the night.'),
(15, 'Special Guest', '23:45:00', NULL, 10, NULL, 14, 14, 'https://example.com/performance_15.jpg', 'A special guest performance.'),
(16, 'Warm Up', '18:45:00', '00:35:00', 11, NULL, 15, 15, 'https://example.com/performance_16.jpg', 'A warm-up performance to get the crowd excited.'),
(17, 'Headline', '20:15:00', NULL, NULL, 6, 6, 16, 'https://example.com/performance_17.jpg', 'The headline act of the night.'),
(18, 'Special Guest', '22:45:00', NULL, 12, NULL, 17, 17, 'https://example.com/performance_18.jpg', 'A special guest performance.'),
(19, 'Warm Up', '19:30:00', '00:55:00', 13, NULL, 18, 18, 'https://example.com/performance_19.jpg', 'A warm-up performance to get the crowd hyped.'),
(20, 'Headline', '21:30:00', NULL, NULL, 7, 7, 19, 'https://example.com/performance_20.jpg', 'The headline act of the night.'),
(21, 'Special Guest', '23:30:00', NULL, 14, NULL, 20, 20, 'https://example.com/performance_21.jpg', 'A special guest performance.'),
(22, 'Warm Up', '18:00:00', '00:30:00', 15, NULL, 21, 21, 'https://example.com/performance_22.jpg', 'A warm-up performance to get the crowd ready.'),
(23, 'Headline', '20:00:00', NULL, NULL, 8, 8, 22, 'https://example.com/performance_23.jpg', 'The headline act of the night.'),
(24, 'Special Guest', '22:00:00', NULL, 16, NULL, 23, 23, 'https://example.com/performance_24.jpg', 'A special guest performance.'),
(25, 'Warm Up', '18:30:00', '00:45:00', 17, NULL, 24, 24, 'https://example.com/performance_25.jpg', 'A warm-up performance to get the crowd excited.'),
(26, 'Headline', '21:00:00', NULL, NULL, 9, 9, 25, 'https://example.com/performance_26.jpg', 'The headline act of the night.'),
(27, 'Special Guest', '23:00:00', NULL, 18, NULL, 26, 26, 'https://example.com/performance_27.jpg', 'A special guest performance.'),
(28, 'Warm Up', '19:00:00', '00:30:00', 19, NULL, 27, 27, 'https://example.com/performance_28.jpg', 'A warm-up performance to get the crowd ready.'),
(29, 'Headline', '20:30:00', NULL, NULL, 10, 10, 28, 'https://example.com/performance_29.jpg', 'The headline act of the night.'),
(30, 'Special Guest', '22:30:00', NULL, 20, NULL, 29, 29,'https://example.com/performance_30.jpg','A special guest performance.'),
(31, 'Warm Up', '18:15:00', '00:40:00', 21, NULL, 30, 30, 'https://example.com/performance_31.jpg', 'A warm-up performance to get the crowd hyped.'),
(32, 'Headline', '20:45:00', NULL, NULL, 11, 11, 31, 'https://example.com/performance_32.jpg', 'The headline act of the night.'),
(33, 'Special Guest', '23:15:00', NULL, 22, NULL, 32, 32, 'https://example.com/performance_33.jpg', 'A special guest performance.'),
(34, 'Warm Up', '19:15:00', '00:50:00', 23, NULL, 33, 33,'https://example.com/performance_34.jpg','A warm-up performance to get the crowd moving.'),
(35, 'Headline', '21:15:00', NULL, NULL, 12, 12, 34,'https://example.com/performance_35.jpg','The headline act of the night.'),
(36, 'Special Guest', '23:45:00', NULL, 24,NULL ,35 ,35,'https://example.com/performance_36.jpg','A special guest performance.'),
(37, 'Warm Up', '18:45:00', '00:35:00', 25, NULL, 36, 36,'https://example.com/performance_37.jpg','A warm-up performance to get the crowd excited.'),
(38, 'Headline', '20:15:00', NULL, NULL, 13, 13, 37,'https://example.com/performance_38.jpg','The headline act of the night.'),
(39, 'Special Guest', '22:45:00', NULL, 26,NULL ,38 ,38,'https://example.com/performance_39.jpg','A special guest performance.'),
(40, 'Warm Up', '19:30:00', '00:55:00', 27,NULL ,39 ,39,'https://example.com/performance_40.jpg','A warm-up performance to get the crowd hyped.'),
(41, 'Headline', '21:30:00', NULL, NULL, 14, 14, 40,'https://example.com/performance_41.jpg','The headline act of the night.'),
(42, 'Special Guest', '23:30:00', NULL, 28,NULL ,41 ,41,'https://example.com/performance_42.jpg','A special guest performance.'),
(43, 'Warm Up', '18:00:00', '00:30:00', 29,NULL ,42 ,42,'https://example.com/performance_43.jpg','A warm-up performance to get the crowd ready.'),
(44, 'Headline', '20:00:00', NULL, NULL, 15, 15, 43,'https://example.com/performance_44.jpg','The headline act of the night.'),
(45, 'Special Guest', '22:00:00', NULL, 30,NULL ,44 ,44,'https://example.com/performance_45.jpg','A special guest performance.'),
(46, 'Warm Up', '18:30:00', '00:45:00', 31,NULL ,45 ,45,'https://example.com/performance_46.jpg','A warm-up performance to get the crowd excited.'),
(47, 'Headline', '21:00:00', NULL, NULL, 16, 16, 46,'https://example.com/performance_47.jpg','The headline act of the night.'),
(48, 'Special Guest', '23:00:00', NULL, 32,NULL ,47 ,47,'https://example.com/performance_48.jpg','A special guest performance.'),
(49, 'Warm Up', '19:00:00', '00:30:00', 33,NULL ,48 ,48,'https://example.com/performance_49.jpg','A warm-up performance to get the crowd ready.'),
(50, 'Headline', '20:30:00', NULL, NULL, 17, 17, 49,'https://example.com/performance_50.jpg','The headline act of the night.'),
(51, 'Special Guest', '22:30:00', NULL, 34,NULL ,50 ,50,'https://example.com/performance_51.jpg','A special guest performance.'),
(52, 'Warm Up', '18:15:00', '00:40:00', 35,NULL ,51 ,51,'https://example.com/performance_52.jpg','A warm-up performance to get the crowd hyped.'),
(53, 'Headline', '20:45:00', NULL, NULL, 18, 18, 52,'https://example.com/performance_53.jpg','The headline act of the night.'),
(54, 'Special Guest', '23:15:00', NULL, 36,NULL ,53 ,53,'https://example.com/performance_54.jpg','A special guest performance.'),
(55, 'Warm Up', '19:15:00', '00:50:00', 37,NULL ,54 ,54,'https://example.com/performance_55.jpg','A warm-up performance to get the crowd moving.'),
(56, 'Headline', '21:15:00', NULL, NULL, 19, 19, 55,'https://example.com/performance_56.jpg','The headline act of the night.'),
(57, 'Special Guest', '23:45:00', NULL, 38,NULL ,56 ,56,'https://example.com/performance_57.jpg','A special guest performance.'),
(58, 'Warm Up', '18:45:00', '00:35:00', 39,NULL ,57 ,57,'https://example.com/performance_58.jpg','A warm-up performance to get the crowd excited.'),
(59, 'Headline', '20:15:00', NULL, NULL, 20, 20, 58,'https://example.com/performance_59.jpg','The headline act of the night.'),
(60, 'Special Guest', '22:45:00', NULL, 40,NULL ,59 ,59,'https://example.com/performance_60.jpg','A special guest performance.'),
(61, 'Warm Up', '19:30:00', '00:55:00', 41,NULL ,60 ,60,'https://example.com/performance_61.jpg','A warm-up performance to get the crowd hyped.'),
(62, 'Headline', '21:30:00', NULL, NULL, 21, 21, 61,'https://example.com/performance_62.jpg','The headline act of the night.'),
(63, 'Special Guest', '23:30:00', NULL, 42,NULL ,62 ,62,'https://example.com/performance_63.jpg','A special guest performance.'),
(64, 'Warm Up', '18:00:00', '00:30:00', 43,NULL ,63 ,63,'https://example.com/performance_64.jpg','A warm-up performance to get the crowd ready.'),
(65, 'Headline', '20:00:00', NULL, NULL, 22, 22, 64,'https://example.com/performance_65.jpg','The headline act of the night.'),
(66, 'Special Guest', '22:00:00', NULL, 44,NULL ,65 ,65,'https://example.com/performance_66.jpg','A special guest performance.'),
(67, 'Warm Up', '18:30:00', '00:45:00', 45,NULL ,66 ,66,'https://example.com/performance_67.jpg','A warm-up performance to get the crowd excited.'),
(68, 'Headline', '21:00:00', NULL, NULL, 23, 23, 67,'https://example.com/performance_68.jpg','The headline act of the night.'),
(69, 'Special Guest', '23:00:00', NULL, 46,NULL ,68 ,68,'https://example.com/performance_69.jpg','A special guest performance.'),
(70, 'Warm Up', '19:00:00', '00:30:00', 47,NULL ,69 ,69,'https://example.com/performance_70.jpg','A warm-up performance to get the crowd ready.'),
(71, 'Headline', '20:30:00', NULL, NULL, 24, 24, 70,'https://example.com/performance_71.jpg','The headline act of the night.'),
(72, 'Special Guest', '22:30:00', NULL, 48,NULL ,71 ,71,'https://example.com/performance_72.jpg','A special guest performance.'),
(73, 'Warm Up', '18:15:00', '00:40:00', 49,NULL ,72 ,72,'https://example.com/performance_73.jpg','A warm-up performance to get the crowd hyped.'),
(74, 'Headline', '20:45:00', NULL, NULL, 25, 25, 73,'https://example.com/performance_74.jpg','The headline act of the night.'),
(75, 'Special Guest', '23:15:00', NULL, 50,NULL ,74 ,74,'https://example.com/performance_75.jpg','A special guest performance.'),
(76, 'Warm Up', '19:15:00', '00:50:00', 51,NULL ,75 ,75,'https://example.com/performance_76.jpg','A warm-up performance to get the crowd moving.'),
(77, 'Headline', '21:15:00', NULL, NULL, 26, 26, 76,'https://example.com/performance_77.jpg','The headline act of the night.'),
(78, 'Special Guest', '23:45:00', NULL, 52,NULL ,77 ,77,'https://example.com/performance_78.jpg','A special guest performance.'),
(79, 'Warm Up', '18:45:00', '00:35:00', 53,NULL ,78 ,78,'https://example.com/performance_79.jpg','A warm-up performance to get the crowd excited.'),
(80, 'Headline', '20:15:00', NULL, NULL, 27, 27, 79,'https://example.com/performance_80.jpg','The headline act of the night.'),
(81, 'Special Guest', '22:45:00', NULL, 54,NULL ,80 ,80,'https://example.com/performance_81.jpg','A special guest performance.'),
(82, 'Warm Up', '19:30:00', '00:55:00', 55,NULL ,81 ,81,'https://example.com/performance_82.jpg','A warm-up performance to get the crowd hyped.'),
(83, 'Headline', '21:30:00', NULL, NULL, 28, 28, 82,'https://example.com/performance_83.jpg','The headline act of the night.'),
(84, 'Special Guest', '23:30:00', NULL, 56,NULL ,83 ,83,'https://example.com/performance_84.jpg','A special guest performance.'),
(85, 'Warm Up', '18:00:00', '00:30:00', 57,NULL ,84 ,84,'https://example.com/performance_85.jpg','A warm-up performance to get the crowd ready.'),
(86, 'Headline', '20:00:00', NULL, NULL, 29, 29, 85,'https://example.com/performance_86.jpg','The headline act of the night.'),
(87, 'Special Guest', '22:00:00', NULL, 58,NULL ,86 ,86,'https://example.com/performance_87.jpg','A special guest performance.'),
(88, 'Warm Up', '18:30:00', '00:45:00', 59,NULL ,87 ,87,'https://example.com/performance_88.jpg','A warm-up performance to get the crowd excited.'),
(89, 'Headline', '21:00:00', NULL, NULL, 30, 30, 88,'https://example.com/performance_89.jpg','The headline act of the night.'),
(90, 'Special Guest', '23:00:00', NULL, 60,NULL ,89 ,89,'https://example.com/performance_90.jpg','A special guest performance.'),
(91, 'Warm Up', '19:00:00', '00:30:00', 61,NULL ,90 ,90,'https://example.com/performance_91.jpg','A warm-up performance to get the crowd ready.'),
(92, 'Headline', '20:30:00', NULL, NULL, 31, 31, 91,'https://example.com/performance_92.jpg','The headline act of the night.'),
(93, 'Special Guest', '22:30:00', NULL, 62,NULL ,92 ,92,'https://example.com/performance_93.jpg','A special guest performance.'),
(94, 'Warm Up', '18:15:00', '00:40:00', 63,NULL ,93 ,93,'https://example.com/performance_94.jpg','A warm-up performance to get the crowd hyped.'),
(95, 'Headline', '20:45:00', NULL, NULL, 32, 32, 94,'https://example.com/performance_95.jpg','The headline act of the night.'),
(96, 'Special Guest', '23:15:00', NULL, 64,NULL ,95 ,95,'https://example.com/performance_96.jpg','A special guest performance.'),
(97, 'Warm Up', '19:15:00', '00:50:00', 65,NULL ,96 ,96,'https://example.com/performance_97.jpg','A warm-up performance to get the crowd moving.'),
(98, 'Headline', '21:15:00', NULL, NULL, 33, 33, 97,'https://example.com/performance_98.jpg','The headline act of the night.'),
(99, 'Special Guest', '23:45:00', NULL, 66,NULL ,98 ,98,'https://example.com/performance_99.jpg','A special guest performance.'),
(100, 'Warm Up', '18:45:00', '00:35:00', 67,NULL ,99 ,99,'https://example.com/performance_100.jpg','A warm-up performance to get the crowd excited.');

-- Person
INSERT INTO person (first_name, last_name, phone_number, age) VALUES 

-- Tickets (200)
INSERT INTO tickets (ticket_id, purchase_date, category, price, payment_method, EAN13_code, activation, person_id, show_id) VALUES


-- Reviews
INSERT INTO reviews (review_id, rendition, sound_lighting, staging, organisation, total, ticket_id, performance_id) VALUES


-- Buyer/Seller FIFO
