/*

Cleaning Data in SQL Queries

*/

SELECT *
FROM PortifolioProject..NashvilleHousing

------------------------------------------------------------------------------------------
-- Convert Date Time Format


SELECT SaleDateConverted, CONVERT (DATE, SaleDate)
From PortifolioProject..NashvilleHousing

UPDATE PortifolioProject..NashvilleHousing
SET SaleDate = CONVERT (DATE, SaleDate)

ALTER TABLE PortifolioProject..NashvilleHousing
ADD SaleDateConverted DATE;

UPDATE PortifolioProject..NashvilleHousing
SET SaleDateConverted = CONVERT (DATE, SaleDate)



------------------------------------------------------------------------------------------
-- Populate Property Address Data


SELECT *
FROM PortifolioProject..NashvilleHousing
-- WHERE PropertyAddress is NULL
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortifolioProject..NashvilleHousing a
JOIN PortifolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress is NULL;


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortifolioProject..NashvilleHousing a
JOIN PortifolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress is NULL;



------------------------------------------------------------------------------------------
-- Splitting out Address into Individual columns (Address, City, State)


SELECT PropertyAddress
FROM PortifolioProject..NashvilleHousing
-- WHERE PropertyAddress is NULL
-- ORDER BY ParcelID

SELECT 
SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
,	SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address

FROM PortifolioProject..NashvilleHousing


ALTER TABLE PortifolioProject..NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE PortifolioProject..NashvilleHousing
SET PropertySplitAddress = SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


ALTER TABLE PortifolioProject..NashvilleHousing
ADD PropertySplitCity  DATE;

UPDATE PortifolioProject..NashvilleHousing
SET PropertySplitCity= SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) 



Select *
From PortifolioProject..NashvilleHousing




Select OwnerAddress
From PortifolioProject..NashvilleHousing

Select

PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortifolioProject..NashvilleHousing






ALTER TABLE PortifolioProject..NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE PortifolioProject..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)




ALTER TABLE PortifolioProject..NashvilleHousing
ADD OwnerSplitCity  Nvarchar(255);

UPDATE PortifolioProject..NashvilleHousing
SET OwnerSplitCity= PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)




ALTER TABLE PortifolioProject..NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

UPDATE PortifolioProject..NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)



Select *
FROM PortifolioProject..NashvilleHousing






------------------------------------------------------------------------------------------
-- Change Y and N to YES  and NO in "Sold as Vacant" field



Select DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortifolioProject..NashvilleHousing
Group by SoldAsVacant
Order by 2




Select SoldAsVacant
, CASE WHEN  SoldAsVacant = 'Y' THEN 'YES'
	WHEN SoldAsVacant = 'N' THEN 'NO'
	ELSE SoldAsVacant
	END
FROM PortifolioProject..NashvilleHousing


UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN  SoldAsVacant = 'Y' THEN 'YES'
	WHEN SoldAsVacant = 'N' THEN 'NO'
	ELSE SoldAsVacant
	END




------------------------------------------------------------------------------------------
-- Remove duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
		PropertyAddress,
		SalePrice,
		SaleDate,
		LegalReference
		ORDER BY
			UniqueID
			) row_num

FROM PortifolioProject..NashvilleHousing
-- ORDER BY ParcelID
)
select *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress




Select *
FROM PortifolioProject..NashvilleHousing



------------------------------------------------------------------------------------------
-- Delete Unused Culumns



Select *
FROM PortifolioProject..NashvilleHousing


ALTER TABLE PortifolioProject..NashvilleHousing
DROP COLUMN OwnerAddress,TaxDistrict, PropertyAddress


ALTER TABLE PortifolioProject..NashvilleHousing
DROP COLUMN SaleDate