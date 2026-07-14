# 📱 Google Play Store Apps — Exploratory Data Analysis

## 🎯 Project Objective
This project explores the Google Play Store apps dataset to understand app ratings, installs, pricing, categories, and update trends. The workflow covers data cleaning, missing value handling, dtype optimization, and univariate/bivariate visual analysis using `pandas`, `numpy`, `matplotlib`, and `seaborn`.

## 📋 Dataset Overview
The dataset contains app-level records scraped from the Google Play Store, commonly used as a beginner-to-intermediate benchmark dataset for EDA practice. It has **10,841 rows and 13 columns**.

**Columns:**

| Column           | Description                                                        |
|------------------|---------------------------------------------------------------------|
| `App`            | Name of the application                                            |
| `Category`       | Category the app belongs to (e.g. GAME, FAMILY, TOOLS)             |
| `Rating`         | Average user rating of the app                                     |
| `Reviews`        | Number of user reviews                                             |
| `Size`           | Size of the app (in MB/KB)                                         |
| `Installs`       | Number of installs                                                 |
| `Type`           | Free or Paid                                                        |
| `Price`          | Price of the app (in $)                                            |
| `Content Rating` | Target audience (Everyone, Teen, Mature, etc.)                      |
| `Genres`         | Genre(s) the app is listed under                                   |
| `Last Updated`   | Date the app was last updated                                      |
| `Current Ver`    | Current version of the app                                         |
| `Android Ver`    | Minimum Android version required                                   |

## 🛠️ Tools Used
- Python
- pandas
- NumPy
- matplotlib
- seaborn
- Jupyter Notebook

## 🧹 Data Cleaning
- Removed **483 duplicate rows** from the dataset.
- Dropped 1 corrupted row (values were misaligned across columns).
- Cleaned `Installs` by removing `,` and `+` symbols and converting to numeric.
- Cleaned `Price` by removing `$` and converting to numeric.
- Converted `Reviews` to numeric and filled missing `Rating` values with the median.
- Cleaned `Size` by converting `M`/`K` suffixes into a consistent numeric (MB) scale, filling missing values using category-wise median.
- Filled missing `Type` values with the mode.
- Converted `Last Updated` to `datetime` and extracted `Year Updated` and `Month Updated` columns.
- Filled missing `Current Ver` and `Android Ver` values with their mode.
- Optimized dtypes: converted `Category`, `Type`, and `Content Rating` to `category` for memory efficiency.
- Final cleaned dataset: **10,357 rows and 15 columns**.

## 📊 Analysis

### 1. Rating Distribution
Shows the overall spread of app ratings on the Play Store.

<img src="images/graph1.png" width="700">

### 2. Top App Categories
Shows which categories have the most apps on the Play Store.

<img src="images/graph2.png" width="700">

### 3. Free vs Paid Apps
Compares the count of free vs paid apps.

<img src="images/graph3.png" width="700">

### 4. Content Rating Distribution
Shows the distribution of apps across content rating groups (Everyone, Teen, Mature, etc.).

<img src="images/graph4.png" width="700">

### 5. Top Categories by Total Installs
Shows which categories dominate in terms of total installs.

<img src="images/graph5.png" width="700">

### 6. Price Distribution of Paid Apps
Shows how paid apps are priced.

<img src="images/graph6.png" width="700">

### 7. Rating vs Reviews
Shows the relationship between number of reviews and rating.

<img src="images/graph7.png" width="700">

### 8. App Size vs Rating
Shows whether app size affects rating.

<img src="images/graph8.png" width="700">

### 9. Installs by Category (Boxplot)
Shows the spread of installs across the top categories.

<img src="images/graph9.png" width="700">

### 10. Correlation Heatmap
Shows the correlation between numeric features (Rating, Reviews, Size, Installs, Price).

<img src="images/graph10.png" width="700">

### 11. Apps Updated Over the Years
Shows the trend of app updates by year.

<img src="images/graph11.png" width="700">

### 12. Top 10 Most Expensive Paid Apps
Shows the highest priced apps on the store.

<img src="images/graph12.png" width="700">

### 13. Installs vs Price (Paid Apps)
Shows the relationship between app price and installs.

<img src="images/graph13.png" width="700">

### 14. Rating Distribution by App Type
Compares rating distribution between free and paid apps.

<img src="images/graph14.png" width="700">

### 15. Average Rating by Category
Shows the average rating of apps across categories.

<img src="images/graph15.png" width="700">

## ✅ Key Takeaways
- **Rating**: Most apps are rated between 4.0 and 4.5, with an average rating of **~4.2**, showing users generally rate apps positively.
- **Category**: A handful of categories — like FAMILY, GAME, and TOOLS — account for a disproportionately large share of total apps on the store.
- **Free vs Paid**: The vast majority of apps on the Play Store are free, with paid apps making up only a small fraction of the catalog.
- **Content Rating**: Most apps are rated "Everyone," indicating the store's catalog leans heavily toward general-audience content.
- **Installs by Category**: Categories like COMMUNICATION, GAME, and TOOLS dominate in total installs, driven by a few extremely popular apps.
- **Pricing**: Paid apps are mostly priced under $5, with a long tail of a few unusually expensive niche apps.
- **Reviews vs Rating**: Apps with a very high number of reviews tend to cluster around higher ratings, though rating stays fairly stable across most review counts (log scale).
- **Size vs Rating**: App size doesn't show a strong relationship with rating — both small and large apps span the full rating range.
- **Correlation**: Numeric features like Reviews, Installs, Size, and Price show weak correlation with Rating, suggesting rating is influenced more by qualitative factors than app specs.
- **Updates**: The number of apps being actively updated rose sharply toward 2017–2018, reflecting increasing developer activity in recent years.
