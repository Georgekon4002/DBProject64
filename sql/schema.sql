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
