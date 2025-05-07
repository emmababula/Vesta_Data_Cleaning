# Vesta Data Cleaning (SQL)
## Cleaning and preparing 10 years of photometric and observational data on asteroid Vesta using SQL


## Project Structure

- `sql/` – SQL scripts for combining, cleaning, and validating the dataset
- `data/` – (Optional) Example raw data files or summaries
- `.gitignore` – Files to exclude from version control (e.g., large CSVs)
- `LICENSE` – Open-source license (MIT)
- `README.md` – Project overview and instructions

## Goals

- Combine multiple Vesta datasets spanning 2015–2025
- Remove duplicate, noisy, and poor-quality data
- Apply filters based on magnitude errors, flux SNR, and sky background
- Prepare a clean, analyzable dataset suitable for photometric study

## Data

The dataset includes:
- Modified Julian Dates (MJD)
- Apparent magnitudes and errors
- Flux and flux uncertainty in microJanskys
- Observational metadata: RA, Dec, sky brightness, image shape parameters

Raw data is divided into two source tables (`vesta_2015_2020`, `vesta_2020_2025`) and combined during cleaning.

## Cleaning Steps Overview

- Merged source tables into a unified dataset
- Removed:
  - Duplicate observations
  - Rows with magnitude ≤ 0 or error > 0.3
  - Low SNR observations (SNR < 3)
  - Observations with sky brightness < 17
  - Invalid coordinates, sizes, or aperture fits
- Dropped unused columns like `err` and `chi/N`

## Results

The original dataset contains 2890 rows, and the cleaned dataset contains 228 rows of high-quality data. The cleaned data is ready for lightcurve generation or additional time-series analysis.


## Technologies

- MySQL (Workbench)
- GitHub for version control

## How to Run

1. Clone this repository
2. Download raw data (`vesta_2015_2020`, `vesta_2020_2025`)
3. Open the `.sql` scripts in MySQL Workbench
4. Execute in order to recreate and clean the dataset
