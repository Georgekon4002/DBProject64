-- Locations (10)
INSERT INTO location (latitude, longtitude, address, city, country, continent, gs1_prefix, loc_img, loc_desc)
VALUES
(37.9838, 23.7275, 'Syntagma Square', 'Athens', 'Greece', 'Europe', 520, 'https://example.com/syntagma.jpg', 'A central square in Athens, known for its historical significance.'),
(40.6401, 22.9444, 'Aristotelous Square', 'Thessaloniki', 'Greece', 'Europe', 520, 'https://example.com/aristotelous.jpg', 'The main square of Thessaloniki, a vibrant city center.'),
(41.3851, 2.1734, 'Plaça Catalunya', 'Barcelona', 'Spain', 'Europe', 840, 'https://example.com/placa_catalunya.jpg', 'A large square in the heart of Barcelona.'),
(48.8566, 2.3522, 'Champs-Élysees', 'Paris', 'France', 'Europe', 300, 'https://example.com/champs_elysees.jpg', 'Famous avenue in Paris known for its theaters and cafés.'),
(38.7169, -9.1399, 'Praça do Comércio', 'Lisbon', 'Portugal', 'Europe', 560, 'https://example.com/praca_comercio.jpg', 'A large public square in Lisbon by the Tagus River.'),
(45.4642, 9.1900, 'Piazza Duomo', 'Milan', 'Italy', 'Europe', 800, 'https://example.com/piazza_duomo.jpg', 'The main cathedral square in Milan.'),
(33.8568, 151.2153,'Sydney Opera House', 'Sydney', 'Australia', 'Oceania', 505, 'https://example.com/sydney_opera_house.jpg', 'Iconic performing arts center in Sydney.'),
(59.3293, 18.0686, 'Sergels Torg', 'Stockholm', 'Sweden', 'Europe', 730, 'https://example.com/sergels_torg.jpg', 'A central square in Stockholm known for its modern architecture.'),
(35.6828, 139.7594, 'Shibuya Crossing', 'Tokyo', 'Japan', 'Asia', 490, 'https://example.com/shibuya_crossing.jpg', 'Famous pedestrian crossing in Tokyo.'),
(40.7128, -74.0060, 'Times Square', 'New York City', 'USA', 'North America', 000, 'https://example.com/times_square.jpg', 'Famous commercial intersection in New York City.');

-- Festivals (10)
INSERT INTO festival (fest_year, start_date, end_date, latitude, longtitude, fest_poster, fest_desc) VALUES 
(2016, '2016-06-10', '2016-06-12', 37.9838, 23.7275, 'https://example.com/festival_2016.jpg', 'Pulse University Music Festival 2016'),
(2017, '2017-06-15', '2017-06-17', 40.6401, 22.9444, 'https://example.com/festival_2017.jpg', 'Pulse University Music Festival 2017'),
(2018, '2018-07-01', '2018-07-03', 41.3851, 2.1734, 'https://example.com/festival_2018.jpg', 'Pulse University Music Festival 2018'),
(2019, '2019-06-20', '2019-06-22', 48.8566, 2.3522, 'https://example.com/festival_2019.jpg', 'Pulse University Music Festival 2019'),
(2020, '2021-06-25', '2021-06-27', 38.7169, -9.1399, 'https://example.com/festival_2021.jpg', 'APulse University Music Festival 2021: After 2 years of pandemic, we are back!'),
(2021, '2022-07-05', '2022-07-07', 45.4642, 9.1900, 'https://example.com/festival_2022.jpg', 'Pulse University Music Festival 2022'),
(2022, '2023-06-12', '2023-06-14', 33.8568, 151.2153, 'https://example.com/festival_2023.jpg', 'Pulse University Music Festival 2023'),
(2023, '2024-06-18', '2024-06-20', 59.3293, 18.0686, 'https://example.com/festival_2024.jpg', 'Pulse University Music Festival 2024'),
(2024, '2025-07-01', '2025-07-03', 35.6828, 139.7594, 'https://example.com/festival_2025.jpg', 'Pulse University Music Festival 2025'),
(2025, '2026-06-10', '2026-06-12', 40.7128, -74.0060, 'https://example.com/festival_2026.jpg', 'Pulse University Music Festival 2026: 10 years of music');

-- Stages (30 - 3 stages per festival)
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
(19, 'Sydney Main', 'Iconic venue', 12000, 'https://example.com/sydney_main.jpg', 'The main stage located at the Sydney Opera House.'),
(20, 'Harbour Stage', 'Waterfront performances', 5000, 'https://example.com/harbour_stage.jpg', 'A stage located on the waterfront.'),
(21, 'Opera House Stage', 'Classical meets modern', 3000, 'https://example.com/opera_house_stage.jpg', 'A stage that blends classical and modern music.'),
(22, 'Arctic Arena', 'Big sounds, cool vibes', 7500, 'https://example.com/arctic_arena.jpg', 'A large arena with a cool atmosphere.'),
(23, 'Scandi Stage', 'Nordic pop', 2400, 'https://example.com/scandi_stage.jpg', 'A stage dedicated to Nordic pop music.'),
(24, 'Sverige Cellar', 'Acoustic sets', 1800, 'https://example.com/sverige-cellar.jpg', 'A cozy venue for acoustic sets.'),
(25, 'Shibuya Main', 'Tokyos heart', 11000, 'https://example.com/shibuya_main.jpg', 'The main stage located in the heart of Tokyo.'),
(26, 'Harajuku Stage', 'Fashion meets music', 4000, 'https://example.com/harajuku_stage.jpg', 'A stage where fashion meets music.'),
(27, 'Tokyo Underground', 'Experimental vibes', 2700, 'https://example.com/tokyo_underground.jpg', 'A stage for experimental and underground acts.'),
(28, 'Manhattan Grand', 'New Yorks top venue', 10500, 'https://example.com/manhattan-grand.jpg', 'The top venue in New York City.'),
(29, 'SoHo Groove', 'Indie NY sounds', 3200, 'https://example.com/soho-groove.jpg', 'A stage for indie sounds in SoHo.'),
(30, 'Brooklyn Beats', 'Urban performance hub', 3900, 'https://example.com/brooklyn-beats.jpg','A performance hub in Brooklyn with urban vibes.');

-- Shows (20 - 5 performances per show and 2 shows per festival)
INSERT INTO shows (show_id, fest_year, stage_id, show_date, show_poster, show_desc) VALUES
-- MOCK

-- Equipment
INSERT INTO equipment (device, device_img, device_desc) VALUES 
('Microphone', 'https://example.com/microphone.jpg', 'A device used to amplify sound.'),
('Guitar', 'https://example.com/guitar.jpg', 'A string instrument played by plucking or strumming.'),
('Drum Kit', 'https://example.com/drum_kit.jpg', 'A set of drums and cymbals arranged for playing.'),
('Keyboard', 'https://example.com/keyboard.jpg', 'An electronic musical instrument with keys.'),
('Mixer', 'https://example.com/mixer.jpg', 'A device used to combine audio signals.'),
('Speaker', 'https://example.com/speaker.jpg', 'A device that converts electrical energy into sound.'),
('Stage Monitor', 'https://example.com/stage_monitor.jpg', 'A speaker used by performers to hear themselves.'),
('Cables', 'https://example.com/cables.jpg', 'Wires used to connect audio equipment.'),
('Amplifier', 'https://example.com/amplifier.jpg', 'A device that increases the power of audio signals.'),
('Drumsticks', 'https://example.com/drumsticks.jpg', 'Used to play drums.'),
('Guitar Picks', 'https://example.com/guitar_picks.jpg', 'Used to strum guitars.'),
('Microphone Stand', 'https://example.com/microphone_stand.jpg', 'A stand to hold microphones.'),
('Cable Ties', 'https://example.com/cable_ties.jpg', 'Used to organize cables.'),
('Stage Props', 'https://example.com/stage_props.jpg', 'Decorative items used on stage.'),
('Fog Machine', 'https://example.com/fog_machine.jpg', 'Creates fog effects on stage.'),
('Spotlight', 'https://example.com/spotlight.jpg', 'A powerful light used to illuminate performers.'),
('Laser Light', 'https://example.com/laser_light.jpg', 'A light that produces laser beams.'),
('LED Wall', 'https://example.com/led_wall.jpg', 'A wall of LED screens for visuals.');


INSERT INTO equip_req(stage_id, device, quantity) VALUES 
(1, 'Microphone', 10),
(1, 'Guitar', 5),
(1, 'Drum Kit', 2),
(1, 'Keyboard', 3),
(1, 'Mixer', 2),
(1, 'Speaker', 8),
(2, 'Microphone', 5),
(2, 'Guitar', 3),
(2, 'Drum Kit', 1),
(2, 'Keyboard', 2),
(2, 'Mixer', 1),
(2, 'Speaker', 4),
(3, 'Microphone', 3),
(3, 'Guitar', 2),
(3, 'Drum Kit', 1),
(3, 'Keyboard', 1),
(3, 'Mixer', 1),
(3, 'Speaker', 2);


-- Staff
INSERT INTO staff (staff_id, first_name, last_name, age, specialty, experience, staff_img, staff_desc) VALUES
-- MOCK

INSERT INTO staff_shows (staff_id, show_id) VALUES 
-- AUTOFILL/MOCK

INSERT INTO staff_req (show_id, stage_id, specialty, quantity) VALUES 
-- AUTOFILL

-- Artists and Bands (50)
INSERT INTO artists (artist_id, artist_name, alias, birthday, genre, subgenre, website, instagram, artist_img, artist_desc) VALUES 
(1, 'The Weeknd', NULL, '1990-02-16', 'R&B', 'Pop', 'https://www.theweeknd.com', '@theweeknd', 'https://example.com/the_weeknd.jpg', 'A Canadian singer-songwriter known for his unique sound.'),
(2, 'Billie Eilish', NULL, '2001-12-18', 'Pop', 'Electropop', 'https://www.billieeilish.com', '@billieeilish', 'https://example.com/billie_eilish.jpg', 'An American singer-songwriter known for her distinctive style.'),
(3, 'Ed Sheeran', NULL, '1991-02-17', 'Pop', 'Folk-pop', 'https://www.edsheeran.com', '@edsheeran', 'https://example.com/ed_sheeran.jpg', 'An English singer-songwriter known for his melodic tunes.'),
(4, 'Taylor Swift', NULL, '1989-12-13', 'Pop', 'Country', 'https://www.taylorswift.com', '@taylorswift', 'https://example.com/taylor_swift.jpg', 'An American singer-songwriter known for her narrative songwriting.'),
(5, 'Ashe', NULL, '1993-04-24', 'Pop', 'Alt Pop', 'https://www.ashe-music.com', '@ashemusic', 'https://example.com/ashe.jpg', 'American pop artist with emotional lyrics'),
(6, 'Ariana Grande', NULL, '1993-06-26', 'Pop', 'R&B', 'https://www.arianagrande.com', '@arianagrande', 'https://example.com/ariana_grande.jpg', 'An American singer and actress known for her wide vocal range.'),
(7, 'Declan McKenna', NULL, '1994-03-01', 'Rock', 'Indie Rock', 'https://www.declanmckenna.net', '@thedeclanmckenna', 'https://example.com/declan_mckenna.jpg', 'British musician known for social commentary'),

(8, 'Demi Lovato', NULL, '1992-08-20', 'Pop', 'Rock', 'https://www.demilovato.com', '@ddlovato', 'https://example.com/demi_lovato.jpg', 'An American singer and actress.'),
(9, 'Post Malone', NULL, '1995-07-04', 'Hip-hop', 'Pop', 'https://www.postmalone.com', '@postmalone', 'https://example.com/post_malone.jpg', 'An American rapper and singer-songwriter.'),
(10, 'Katy Perry', NULL, '1984-10-25', 'Pop', NULL, 'https://www.katyperry.com', '@katyperry', 'https://example.com/katy_perry.jpg', 'An American singer-songwriter known for her pop anthems.'),
(11, 'Lady Gaga', NULL, '1986-03-28', 'Pop', 'Dance-pop', 'https://www.ladygaga.com', '@ladygaga', 'https://example.com/lady_gaga.jpg', 'An American singer, songwriter, and actress.'),
(12, 'Bruno Mars', NULL, '1985-10-08', 'Pop', 'Funk', 'https://www.brunomars.com', '@brunomars', 'https://example.com/bruno_mars.jpg', 'An American singer-songwriter and music producer.'),
(13, 'FINNEAS', NULL, '1997-07-30', 'Pop', 'Alternative', 'https://www.finneasofficial.com', '@finneas', 'https://example.com/finneas.jpg', 'An American singer-songwriter and producer.'),
(14, 'Tame Impala', NULL, '1996-01-01', 'Psychedelic Rock', 'Indie Rock', 'https://www.tameimpala.com', '@tameimpala', 'https://example.com/tame_impala.jpg', 'An Australian musical project led by Kevin Parker.'),
(15, 'Norah Jones', NULL, '1979-03-30', 'Jazz', 'Soul', 'https://www.norahjones.com', '@norahjones', 'https://example.com/norah_jones.jpg', 'An American singer-songwriter and musician.'),
(16, 'Jack Antonoff', NULL, '1984-03-31', 'Pop', 'Indie Pop', 'https://www.jackantonoff.com', '@jackantonoff', 'https://example.com/jack_antonoff.jpg', 'An American musician and producer known for his work with Taylor Swift.'),
(17, 'Miley Cyrus', NULL, '1992-11-23', 'Pop', 'Rock', 'https://www.mileycyrus.com', '@mileycyrus', 'https://example.com/miley_cyrus.jpg', 'An American singer and actress.'),
(18, 'Sia', NULL, '1975-12-18', 'Pop', NULL, 'https://www.siamusic.net', '@sia', 'https://example.com/sia.jpg', 'An Australian singer-songwriter known for her distinctive voice.'),
(19, 'Lorde', NULL, '1996-11-07', 'Pop', 'Electropop', 'https://www.lorde.co.nz', '@lorde', 'https://example.com/lorde.jpg', 'A New Zealand singer-songwriter known for her unique sound.'),
(20, 'Dua Lipa', NULL, '1995-08-22', 'Pop', 'Disco Pop', 'https://www.dualipa.com', '@dualipa', 'https://example.com/dua_lipa.jpg', 'An English singer and songwriter.'),

(5, 'BØRNS', '1992-01-07', 'Indie Pop', 'Electropop', 'borns.jpg', 'Androgynous pop icon'),
(6, 'Norah Jones', '1979-03-30', 'Jazz', 'Vocal Jazz', 'norah.jpg', 'Soft and soulful piano-driven songs'),
(7, 'Hozier', '1990-03-17', 'Soul', 'Indie Folk', 'hozier.jpg', 'Known for poetic lyrics and blues style'),
(8, 'Dua Lipa', '1995-08-22', 'Pop', 'Disco Pop', 'dua.jpg', 'British-Albanian pop icon'),
(9, 'Anderson .Paak', '1986-02-08', 'Funk', 'R&B', 'paak.jpg', 'Fusion of hip hop, funk and soul'),
(10, 'Tame Impala', '1986-11-20', 'Psychedelic Rock', 'Indie Rock', 'tame.jpg', 'Kevin Parkers psych rock project'),
(11, 'Phoebe Bridgers', '1994-08-17', 'Indie Rock', 'Emo Folk', 'phoebe.jpg', 'Haunting lyrics and minimalist sound'),
(12, 'Frank Sinatra', '1915-12-12', 'Jazz', 'Swing', 'sinatra.jpg', 'Legendary voice of classic pop and jazz'),
(13, 'Stromae', '1985-03-12', 'Electro Pop', 'Chanson', 'stromae.jpg', 'Belgian icon blending genres'),
(14, 'Beyoncé', '1981-09-04', 'Pop', 'R&B', 'beyonce.jpg', 'Queen B of global pop'),
(15, 'Lana Del Rey', '1985-06-21', 'Indie Pop', 'Baroque Pop', 'lana.jpg', 'Melancholy and cinematic stylings'),
(16, 'Harry Styles', '1994-02-01', 'Pop Rock', 'Soft Rock', 'harry.jpg', 'From One Direction to stardom'),
(17, 'Rosalía', '1992-09-25', 'Flamenco Pop', 'Reggaeton', 'rosalia.jpg', 'Modern flamenco fusion'),
(18, 'Måneskin', '1999-01-08', 'Rock', 'Glam Rock', 'maneskin.jpg', 'Italian rock sensation'),
(19, 'Kendrick Lamar', '1987-06-17', 'Hip Hop', 'Conscious Rap', 'kendrick.jpg', 'One of the greatest lyricists'),
(20, 'Billie Eilish', '2001-12-18', 'Pop', 'Dark Pop', 'billie.jpg', 'Whispery vocals, bold themes'),
(21, 'Celeste', '1994-05-05', 'Soul', 'Jazz Pop', 'celeste.jpg', 'UK breakthrough soul voice'),
(22, 'James Blake', '1988-09-26', 'Electronic', 'Ambient Soul', 'blake.jpg', 'Experimental and moody'),
(23, 'Mitski', '1990-09-27', 'Indie Rock', 'Art Pop', 'mitski.jpg', 'Raw emotion and layered songs'),
(24, 'Childish Gambino', '1983-09-25', 'Hip Hop', 'Funk', 'gambino.jpg', 'Multi-talent with political edge'),
(25, 'Doja Cat', '1995-10-21', 'Pop', 'Rap', 'doja.jpg', 'Playful genre-blending'),
(26, 'Bon Iver', '1981-04-30', 'Indie Folk', 'Experimental Folk', 'bon.jpg', 'Layered harmonies, wintry sound'),
(27, 'Arctic Monkeys', '1986-01-05', 'Rock', 'Garage Rock', 'monkeys.jpg', 'Sheffield rock revivalists'),
(28, 'Sufjan Stevens', '1975-07-01', 'Indie Folk', 'Baroque Pop', 'sufjan.jpg', 'Orchestral and spiritual'),
(29, 'Peggy Gou', '1991-07-03', 'Electronic', 'House', 'peggy.jpg', 'DJ and producer icon'),
(30, 'The Weeknd', '1990-02-16', 'R&B', 'Synthpop', 'weeknd.jpg', 'Falsetto and drama');

INSERT INTO band(band_id, band_name, formed_date, genre, subgenre, website, instagram, band_img, band_desc) VALUES 
(1, 'Coldplay', '1996-01-01', 'Pop Rock', 'Alternative', 'https://www.coldplay.com', '@coldplay', 'https://example.com/coldplay.jpg', 'A British rock band known for their melodic sound.'),
(2, 'Imagine Dragons', '2008-01-01', 'Pop Rock', 'Electropop', 'https://www.imaginedragonsmusic.com', '@imaginedragons', 'https://example.com/imagine_dragons.jpg', 'An American rock band known for their anthemic sound.'),
(3, 'Maroon 5', '2001-01-01', 'Pop Rock', 'Funk Pop', 'https://www.maroon5.com', '@maroon5', 'https://example.com/maroon_5.jpg', 'An American pop rock band known for their catchy tunes.'),
(4, 'Paramore', '2004-01-01', 'Rock', NULL, 'https://www.paramore.net', '@paramore', 'https://example.com/paramore.jpg', 'An American rock band known for their pop-punk sound.'),

(4, 'Linkin Park', '1996-01-01', 'https://www.linkinpark.com', '@linkinpark', 'https://example.com/linkin_park.jpg', 'An American rock band known for their nu-metal sound.'),
(5, 'The Killers', '2001-01-01', 'https://www.thekillersmusic.com', '@thekillers', 'https://example.com/the_killers.jpg', 'An American rock band known for their synth-pop sound.'),
(6, 'Foo Fighters', '1994-01-01', 'https://www.foofighters.com', '@foofighters', 'https://example.com/foo_fighters.jpg', 'An American rock band known for their energetic performances.'),
(8, 'Panic! At The Disco', '2004-01-01', 'https://www.panicatthedisco.com', '@panicatthedisco', 'https://example.com/panic_at_the_disco.jpg', 'An American rock band known for their theatrical style.'),
(3, 'Muse', '1994-01-01', 'Rock', 'Progressive', 'muse.jpg', 'Dramatic and dystopian'),
(4, 'The 1975', '2002-01-01', 'Indie Pop', 'Synth Rock', '1975.jpg', 'Slick and ironic UK pop'),
(7, 'Radiohead', '1985-01-01', 'Alternative', 'Art Rock', 'radiohead.jpg', 'Innovative soundscapes'),
(8, 'Florence + The Machine', '2007-01-01', 'Indie Rock', 'Baroque Pop', 'florence.jpg', 'Epic and ethereal'),
(9, 'ABBA', '1972-01-01', 'Pop', 'Disco', 'abba.jpg', 'Swedish legends'),
(10, 'Daft Punk', '1993-01-01', 'Electronic', 'French House', 'daftpunk.jpg', 'Robotic French duo'),
(11, 'Blur', '1988-01-01', 'Britpop', 'Indie Rock', 'blur.jpg', '90s UK cool'),
(12, 'Red Hot Chili Peppers', '1983-01-01', 'Funk Rock', 'Alt Rock', 'rhcp.jpg', 'California rock legends'),
(14, 'Arcade Fire', '2001-01-01', 'Indie Rock', 'Art Rock', 'arcade.jpg', 'Grand and cathartic'),
(17, 'Kings of Leon', '1999-01-01', 'Rock', 'Southern Rock', 'kol.jpg', 'Family band turned arena stars'),

INSERT INTO membership(artist_id, band_id) 
-- MANUAL

-- Performances (100)
INSERT INTO performances (performance_id, style, start_time, duration, artist_id, band_id, stage_id, show_id, perf_poster, perf_desc) VALUES
-- MOCK

-- Person
INSERT INTO person (first_name, last_name, phone_number, age) VALUES 
-- MOCK

-- Tickets (200)
INSERT INTO tickets (ticket_id, purchase_date, category, price, payment_method, EAN13_code, activation, person_id, show_id) VALUES
-- AUTOFILL

-- Reviews
INSERT INTO reviews (review_id, rendition, sound_lighting, staging, organisation, total, ticket_id, performance_id) VALUES
-- MOCK

-- Buyer/Seller FIFO
