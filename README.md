# beetle-mortality-glm
Analysis of classical beetle mortality data using GLMs (logit, probit, cloglog) and a sex × dose mortality study, including model comparison, diagnostics, and visualization. Implemented in R.

This repository contains an analysis of classical beetle mortality data using
generalized linear models (GLMs). The analysis is divided into two main parts:

1. **Dose–Response Modeling** using logit, probit, and complementary log-log (cloglog) links.
2. **Sex × Dose Mortality Study** examining differences in mortality between males and females across dose levels.

All analyses are implemented in **R**.

## Repository Structure

beetle-mortality-glm/

│

├── data/

│ ├── beetle-grouped.txt # Grouped dose–response data

│

├── scripts/

│ ├── dose_response_glm.R # Part 1: Dose–Response GLMs

│ └── sex_dose_study.R # Part 2: Sex × Dose Study

│

├── figs/

│ └── mortality_curves.png 

│
├── README.md

└── .gitignore


## Analysis Overview

### 1. Dose–Response Modeling (`scripts/dose_response_glm.R`)

- Fits GLMs on grouped beetle mortality data using three link functions:
  - **Logit**
  - **Probit**
  - **Complementary log-log (cloglog)**
- Visualizes the observed proportion of deaths vs log dose.
- Computes correlations between observed and fitted proportions.

### 2. Sex × Dose Mortality Study (`scripts/sex_dose_study.R`)

- Analyzes mortality data for males and females across different dose levels.
- Fits several models:
  1. Sex-only model
  2. Dose-only model
  3. Additive model: sex + dose
  4. Interaction model: sex × dose
- Compares models using **AIC** and **likelihood ratio tests**.
- Computes confidence intervals, Fisher information, predicted probabilities, residuals, and dispersion estimates.


## Running the Analysis

1. Open R or RStudio.
2. Set your working directory to the repository root.
3. Run either script:

```r
# Dose–Response GLMs
source("scripts/dose_response_glm.R")

# Sex × Dose Study
source("scripts/sex_dose_study.R")
```

4. Ensure the data/ folder is present with the required files.

## License

MIT License
























