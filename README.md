# Vesta Data Cleaning (SQL)
## Cleaning and preparing 10 years of photometric and observational data on asteroid Vesta using SQL


## Project Structure

- `sql/` – SQL scripts for combining, cleaning, and validating the dataset
- `data/` – Raw and cleaned data files
- `.gitignore` – Files to exclude from version control
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

The data was obtained from the [ATLAS forced photometry server](https://fallingstar-data.com/forcedphot/), which provides full public access to photometric measurements over the full history of the ATLAS survey.
- [Tonry et al. (2018)](https://ui.adsabs.harvard.edu/abs/2018PASP..130f4505T/abstract)
- [Shingles et al. (2021)](https://ui.adsabs.harvard.edu/abs/2021TNSAN...7....1S/abstract)

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

### Acknowledgments
This work has made use of data from the Asteroid Terrestrial-impact Last Alert System (ATLAS) project. The Asteroid Terrestrial-impact Last Alert System (ATLAS) project is primarily funded to search for near earth asteroids through NASA grants NN12AR55G, 80NSSC18K0284, and 80NSSC18K1575; byproducts of the NEO search include images and catalogs from the survey area. This work was partially funded by Kepler/K2 grant J1944/80NSSC19K0112 and HST GO-15889, and STFC grants ST/T000198/1 and ST/S006109/1. The ATLAS science products have been made possible through the contributions of the University of Hawaii Institute for Astronomy, the Queen’s University Belfast, the Space Telescope Science Institute, the South African Astronomical Observatory, and The Millennium Institute of Astrophysics (MAS), Chile.
