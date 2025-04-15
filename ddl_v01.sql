CREATE DATABASE music_festival;
USE music_festival;

-- Να τσεκάρουμε τα NOT NULL
-- Να τσεκάρουμε τα participation
DROP TABLE IF EXISTS festival; -- ΔΕΝ μπορεί να ακυρωθεί
CREATE TABLE festival(
	edition INT NOT NULL PRIMARY KEY, -- Κάθε χρόνο ΕΝΑ φεστιβάλ
    start_date DATE NOT NULL,
    end_date DATE NOT NULL, -- 1 ή περισσότερες συνεχόμενες ημέρες
    latitude DOUBLE NOT NULL, -- Διαφορετική τοποθεσία ανά έτος
	longtitude DOUBLE NOT NULL,
    CONSTRAINT fest_loc FOREIGN KEY (latitude, longtitude) REFERENCES location (latitude, longtitude)
);

DROP TABLE IF EXISTS location;
CREATE TABLE location(
	latitude DOUBLE NOT NULL,
    longtiutde DOUBLE NOT NULL,
    address VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    continent VARCHAR(50) NOT NULL,
    PRIMARY KEY (latitude,longtitude)
);

DROP TABLE IF EXISTS shows; -- ΔΕΝ μπορεί να ακυρωθεί. Κάθε παράσταση μπορεί να έχει μόνο μία εμφάνιση κάθε στιγμή
CREATE TABLE shows(
	show_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    edition INT NOT NULL,
    stage_id INT NOT NULL,
    show_date DATE NOT NULL, -- Να είναι μέσα στις ημερομηνίες του φεστιβάλ
    CONSTRAINT fest_show FOREIGN KEY (edition) REFERENCES festival (edition),
    CONSTRAINT show_loc FOREIGN KEY (stage_id) REFERENCES stage (stage_id)
);

DROP TABLE IF EXISTS stage;
CREATE TABLE stage(
	stage_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stage_name VARCHAR(50) NOT NULL,
    stage_description VARCHAR(150) NOT NULL,
    max_capacity INT NOT NULL
);

DROP TABLE IF EXISTS performance; -- Δεν αναφέρεται για ακύρωση
CREATE TABLE performance(
	performance_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	style ENUM('Warm Up', 'Headline', 'Special Guest') NOT NULL,
    start_time TIME NOT NULL,
    duration TIME NOT NULL CHECK(duration < '03:00:00'),
    artist_id INT,
    band_id INT,
    CONSTRAINT solo FOREIGN KEY (artist_id) REFERENCES artist (artist_id),
    CONSTRAINT bands FOREIGN KEY (band_id) REFERENCES band (band_id),
    CHECK ((artist_id IS NOT NULL AND band_id IS NULL) OR (artist_id IS NULL AND band_id IS NOT NULL))
    CONSTRAINT perf_loc FOREIGN KEY (stage_id) REFERENCES stage (stage_id),
    CONSTRAINT perf_show FOREIGN KEY (show_id) REFERENCES shows (show_id)
);
-- Υποχρεωτικά διάλειμμα μεταξύ performances
-- Min: 5 min + Max: 30 min

DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment(
	device VARCHAR(50) PRIMARY KEY
);

DROP TABLE IF EXISTS equip_req;
CREATE TABLE equip_req(
	stage_id INT NOT NULL,
    device VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (stage_id, device),
    CONSTRAINT stage_equipment FOREIGN KEY (stage_id) REFERENCES stage(stage_id),
    CONSTRAINT device_equipment FOREIGN KEY (device) REFERENCES equipment(device)
);

DROP TABLE IF EXISTS staff;
CREATE TABLE staff(
	staff_ID INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    specialty ENUM('Technical', 'Security', 'Assistants') NOT NULL,
    experience ENUM('Intern','Beginner', 'Intermediate', 'Experienced', 'Master')
);

DROP TABLE IF EXISTS staff_req;
CREATE TABLE staff_req(
	stage_id INT NOT NULL,
    specialty ENUM('Technical', 'Security', 'Assistants') NOT NULL,
    quality INT NOT NULL, -- Παίζεται...
    PRIMARY KEY (stage_id, specialty),
    CONSTRAINT stage_staff FOREIGN KEY (stage_id) REFERENCES stage(stage_id),
    CONSTRAINT specialty_req FOREIGN KEY (device) REFERENCES equipment(device)
);
-- SECURITY: 5% των θεατών
-- ASSISTANTS: 2% των θεατών

DROP TABLES IF EXISTS artist;
CREATE TABLE artist(
	artist_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    artist_name VARCHAR(50) NOT NULL,
    alias VARCHAR(50),
    birthday DATE NOT NULL,
    genre VARCHAR(50) NOT NULL,
    subgenre VARCHAR(50) NOT NULL,
    website VARCHAR(100) CHECK (website LIKE 'https://%'),
    instagram VARCHAR(31) CHECK (instagram LIKE '@%')
);

DROP TABLES IF EXISTS band;
CREATE TABLE band(
	band_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    band_name VARCHAR(50) NOT NULL,
    formed_date DATE NOT NULL,
	website VARCHAR(100) CHECK (website LIKE 'https://%'),
    instagram VARCHAR(31) CHECK (instagram LIKE '@%')
);
-- Ένας καλλιτέχνης (συγκρότημα) ΔΕΝ μπορεί να εμφανίζεται σε δύο σκηνές ταυτόχρονα
-- Δεν μπορεί ένας καλλιτέχνης να τραγουδάει 3 συνεχόμενα χρόνια. ΠΟΣΑ ΛΕΦΤΑ ΘΑ ΦΑΕΙ ΠΙΑ;

DROP TABLE IF EXISTS membership;
CREATE TABLE membership(
	artist_id INT NOT NULL,
    band_id INT NOT NULL,
    PRIMARY KEY (artist_id, band_id),
    FOREIGN KEY (artist_id) REFERENCES artist (artist_id),
    FOREIGN KEY (band_id) REFERENCES band (band_id)
);

DROP TABLE IF EXISTS person;
CREATE TABLE person(
	person_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number 
    age INT NOT NULL,
    property
);

DROP TABLE IF EXISTS 