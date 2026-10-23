/*============================================================
 Project: Nashville Housing Data Cleaning & Transformation
 Database: Microsoft SQL Server
 Tool: SSMS 21
============================================================*/


-- ============================================
-- Step 0: Initial Data Inspection
-- Purpose: Verify data availability and inspect raw records
-- ============================================
SELECT *
FROM PortfolioProject.dbo.NashvilleHousing;


-- ============================================
-- Step 1: Data Quality Check (Row Count & Key Integrity)
-- Purpose:
-- 1) Count total number of rows in the table
-- 2) Verify uniqueness of the UniqueID field
-- 3) Identify any NULL values in the UniqueID column
-- ============================================
SELECT 
    COUNT(*) AS total_Rows,
    COUNT(DISTINCT UniqueID) AS unique_UniqueID,
    SUM(CASE WHEN UniqueID IS NULL THEN 1 ELSE 0 END) AS null_UniqueID
FROM PortfolioProject.dbo.NashvilleHousing;


-- ============================================
-- Step 2: Standardize Sale Date Format
-- Purpose:
-- Convert SaleDate from string format into a proper DATETIME
-- column to support time-based analysis
-- ============================================
SELECT 
    SaleDate, 
    CONVERT(datetime, SaleDate) AS SaleDateTime
FROM PortfolioProject.dbo.NashvilleHousing;

-- Remove column if it already exists (idempotent execution)
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN IF EXISTS SaleDateTime;

-- Add standardized datetime column
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD SaleDateTime datetime;

-- Populate new datetime column
UPDATE PortfolioProject.dbo.NashvilleHousing
SET SaleDateTime = CONVERT(datetime, SaleDate);


-- ============================================
-- Step 3: Populate Missing Property Addresses
-- Purpose:
-- Use a self-join on ParcelID to fill NULL PropertyAddress
-- values when another record with the same ParcelID exists
-- ============================================
SELECT 
    a.UniqueID AS a_UniqueID, b.UniqueID AS b_UniqueID, 
    a.ParcelID AS a_ParcelID, b.ParcelID AS b_ParcelID, 
    a.PropertyAddress AS a_PropertyAddress, b.PropertyAddress AS b_PropertyAddress,
    ISNULL(a.PropertyAddress, b.PropertyAddress) AS a_b_PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing AS a
JOIN PortfolioProject.dbo.NashvilleHousing AS b
    ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;

-- Create helper column for populated addresses
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN IF EXISTS populated_PropertyAddress;

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD populated_PropertyAddress nvarchar(50);

-- Initialize helper column
UPDATE PortfolioProject.dbo.NashvilleHousing
SET populated_PropertyAddress = PropertyAddress;

-- Populate missing values using self-join
UPDATE a
SET populated_PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing AS a
JOIN PortfolioProject.dbo.NashvilleHousing AS b
    ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;


-- ============================================
-- Step 4: Split Property Address into Address and City
-- Purpose:
-- Normalize populated_PropertyAddress into separate columns
-- to improve analytical usability
-- ============================================
SELECT 
    populated_PropertyAddress,
    SUBSTRING(populated_PropertyAddress, 1, CHARINDEX(',',populated_PropertyAddress)-1) AS address_PropertyAddress,
    SUBSTRING(populated_PropertyAddress, CHARINDEX(',',populated_PropertyAddress)+1, LEN(populated_PropertyAddress)) AS city_PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing;

-- Address column
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN IF EXISTS address_PropertyAddress;

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD address_PropertyAddress nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
SET address_PropertyAddress = SUBSTRING(populated_PropertyAddress, 1, CHARINDEX(',',populated_PropertyAddress)-1);

-- City column
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN IF EXISTS city_PropertyAddress;

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD city_PropertyAddress nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
SET city_PropertyAddress = SUBSTRING(populated_PropertyAddress, CHARINDEX(',',populated_PropertyAddress)+1, LEN(populated_PropertyAddress));


-- ============================================
-- Step 5: Split Owner Address into Address, City, and State
-- Purpose:
-- Decompose OwnerAddress into atomic fields using PARSENAME
-- after replacing commas with periods
-- ============================================
SELECT 
    OwnerAddress,
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS address_OwnerAddress,
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS city_OwnerAddress,
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS state_OwnerAddress
FROM PortfolioProject.dbo.NashvilleHousing;

-- Owner address
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN IF EXISTS address_OwnerAddress;

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD address_OwnerAddress nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
SET address_OwnerAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

-- Owner city
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN IF EXISTS city_OwnerAddress;

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD city_OwnerAddress nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
SET city_OwnerAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

-- Owner state
ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN IF EXISTS state_OwnerAddress;

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD state_OwnerAddress nvarchar(255);

UPDATE PortfolioProject.dbo.NashvilleHousing
SET state_OwnerAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);


-- ============================================
-- Step 6: Standardize SoldAsVacant Values
-- Purpose:
-- Convert binary values (0/1) into human-readable categories
-- (No/Yes) for reporting and dashboards
-- ============================================
SELECT 
    DISTINCT SoldAsVacant, 
    COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldAsVacant;

SELECT 
    SoldASVacant,
    CASE 
        WHEN SoldASVacant = 0 THEN 'No'
        WHEN SoldASVacant = 1 THEN 'Yes'
    END AS converted_SoldAsVacant
FROM PortfolioProject.dbo.NashvilleHousing;

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN IF EXISTS converted_SoldAsVacant;

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
ADD converted_SoldAsVacant varchar(3);

UPDATE PortfolioProject.dbo.NashvilleHousing
SET converted_SoldAsVacant = 
    CASE 
        WHEN SoldASVacant = 0 THEN 'No'
        WHEN SoldASVacant = 1 THEN 'Yes'
        ELSE 'Unk'
    END;


-- ============================================
-- Step 7: Identify Duplicate Records
-- Purpose:
-- Detect duplicate rows using ROW_NUMBER() based on key
-- transactional attributes
-- ============================================
WITH CTE_RWO_NUMBER AS (
SELECT 
    *,
    ROW_NUMBER() OVER (
        PARTITION BY ParcelID, populated_PropertyAddress, SalePrice, SaleDate, LegalReference
        ORDER BY UniqueID) AS row_numbers
FROM PortfolioProject.dbo.NashvilleHousing
)
SELECT *
-- DELETE [Using "DELETE" command, instead of "SELECT" command, we can get rid of the entire duplicate values]
FROM CTE_RWO_NUMBER
WHERE row_numbers > 1;


-- ============================================
-- Step 8: Optional Schema Cleanup
-- Purpose:
-- Remove unused or non-analytical columns
-- (Commented out for safety)
-- ============================================

-- ALTER TABLE PortfolioProject.dbo.NashvilleHousing
-- DROP COLUMN LandUse, TaxDistrict;


/*============================================================
 End of Script
 Result:
 - Cleaned and standardized housing dataset
 - Improved data quality and usability
 - Ready for analytics, BI, or visualization tools
============================================================*/