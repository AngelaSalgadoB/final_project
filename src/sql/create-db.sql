-- Active: 1666457244468@@127.0.0.1@3306@gender_base_violence

CREATE DATABASE IF NOT EXISTS gender_base_violence;

USE gender_base_violence;

CREATE TABLE
    localization(
        id INT AUTO_INCREMENT,
        region_name VARCHAR(250) UNIQUE,
        mean_age FLOAT,
        PRIMARY KEY (id)
    );

CREATE TABLE
    IF NOT EXISTS violence(
        id INT AUTO_INCREMENT,
        violence_type VARCHAR(250) UNIQUE,
        PRIMARY KEY (id)
    );

CREATE TABLE
    IF NOT EXISTS modality(
        id INT AUTO_INCREMENT,
        modality_type VARCHAR(250) UNIQUE,
        PRIMARY KEY (id)
    );

CREATE TABLE
    IF NOT EXISTS calls(
        id INT AUTO_INCREMENT,
        call_date DATE NULL,
        id_localization INT null,
        victim_gender VARCHAR(250) null,
        victim_age FLOAT null,
        aggressor_gender VARCHAR(250) null,
        link VARCHAR(250)  NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(id_localization) REFERENCES localization(id)
    );

CREATE TABLE IF NOT EXISTS calls_violence (
  id INT AUTO_INCREMENT,
  call_id INT,
  violence_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (call_id) REFERENCES calls(id),
  FOREIGN KEY (violence_id) REFERENCES violence(id)
);

CREATE TABLE IF NOT EXISTS calls_modality (
  id INT AUTO_INCREMENT,
  call_id INT,
  modality_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (call_id) REFERENCES calls(id),
  FOREIGN KEY (modality_id) REFERENCES modality(id)
);