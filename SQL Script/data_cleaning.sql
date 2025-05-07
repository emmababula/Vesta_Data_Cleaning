-- Vesta Asteroid Photometry Cleaning Script
-- Author: Emma Babula
-- Description: This SQL script performs data cleaning on a combined
--              10-year dataset of Vesta observations by removing noisy, 
--              low-quality, and high uncertainty values.
-- ----------------------------------------------------------

-- Step 1: Combine Raw Data from 2015-2020 and 2020-2025

CREATE TABLE vesta.vesta_data
LIKE vesta.vesta_2015_2020;

INSERT INTO vesta.vesta_data
SELECT *
FROM vesta.vesta_2015_2020;

INSERT INTO vesta.vesta_data
SELECT *
FROM vesta.vesta_2020_2025;

-- Create Working Dataset for Cleaning

CREATE TABLE vesta_working
LIKE vesta_data;

INSERT vesta_working
SELECT *
FROM vesta_data;

ALTER TABLE vesta_working
RENAME COLUMN `ï»¿###MJD` TO MJD;

-- Step 2. Check for Duplicate Rows (None Found)

SELECT MJD, Obs, COUNT(*) as duplicate_count
FROM vesta_working
GROUP BY MJD, Obs
HAVING COUNT(*) > 1;

-- Step 3: Remove Physically Invalid or Unusable Data

DELETE 
FROM vesta_working
WHERE m <= 0 OR dm > 0.3;

DELETE
FROM vesta_working
where dm = 0 AND duJy = 0;

DELETE
FROM vesta_working
WHERE mag5sig < m;

DELETE 
FROM vesta_working
WHERE Sky < 17;

DELETE
FROM vesta_working
WHERE (x < 100 OR x > 10460); 

DELETE
FROM vesta_working
WHERE (y < 100 OR y > 10460);

DELETE
FROM vesta_working
WHERE (maj > 5 OR maj < 1.6);

DELETE
FROM vesta_working
WHERE (min > 5 OR min < 1.6);

DELETE
FROM vesta_working
WHERE apfit < -1 OR apfit > -0.1;

-- Check Coordinates Validity

SELECT *
FROM vesta_working
WHERE RA < 0 OR RA > 360
   OR `Dec` < -90 OR `Dec` > 90;

-- Step 4: Remove Noisy Data Based on SNR and chi/N

ALTER TABLE vesta_working
ADD COLUMN SNR DOUBLE
AFTER duJy;

UPDATE vesta_working
SET SNR = uJy / duJy
WHERE ujy IS NOT NULL 
  AND dujy IS NOT NULL 
  AND dujy != 0;

DELETE
FROM vesta_working
WHERE SNR < 3;

DELETE 
FROM vesta_working
WHERE `chi/N` > 5;

-- Drop Unuseful Columns

ALTER TABLE vesta_working
DROP COLUMN `chi/N`,
DROP COLUMN err;

-- Step 5: Cleaned Dataset is Ready for Analysis!

CREATE TABLE vesta_cleaned
LIKE vesta_working;

INSERT INTO vesta_cleaned
SELECT *
FROM vesta_working;











