CREATE TABLE greetings (
    id SERIAL PRIMARY KEY,
    lang_code VARCHAR(10) UNIQUE NOT NULL,
    message VARCHAR(255) NOT NULL
);

INSERT INTO greetings (lang_code, message) VALUES ('kr', '안녕하세요!');
INSERT INTO greetings (lang_code, message) VALUES ('en', 'Hello!');
INSERT INTO greetings (lang_code, message) VALUES ('jp', 'こんにちは!');