USE supermarket;

-- Melihat Struktur Tabel
DESCRIBE supermarket_customers;

-- Menampilkan Data Sampel
SELECT * FROM supermarket_customers LIMIT 10;

-- Menghitung Jumlah Baris
SELECT COUNT(*) AS Total_Rows FROM supermarket_customers;

-- Melihat Statistik Deskriptif Kolom Numerik
SELECT 
    MIN(Income) AS Min_Income,
    MAX(Income) AS Max_Income,
    AVG(Income) AS Avg_Income
FROM supermarket_customers;

-- Menghitung Nilai Unik pada Kolom Kategori
SELECT Education, COUNT(*) AS Count FROM supermarket_customers GROUP BY Education;

-- Data Cleaning

-- Duplikat Berdasarkan Kolom ID
SELECT ID, COUNT(*) AS Count 
FROM supermarket_customers 
GROUP BY ID 
HAVING COUNT(*) > 1;

-- Menemukan Nilai Kosong pada Kolom Income
SELECT COUNT(*) AS Null_Income 
FROM supermarket_customers 
WHERE Income IS NULL;

-- Data Analysis

-- Membuat table Total_Purchases
ALTER TABLE supermarket_customers 
ADD COLUMN Total_Purchases INT;
SET SQL_SAFE_UPDATES = 0;

UPDATE supermarket_customers
SET Total_Purchases = MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts
WHERE ID IS NOT NULL;

-- Menemukan Rata-Rata, Minimum, dan Maksimum Pembelian
SELECT 
    AVG(Total_Purchases) AS Avg_Purchases,
    MIN(Total_Purchases) AS Min_Purchases,
    MAX(Total_Purchases) AS Max_Purchases
FROM supermarket_customers;

-- Menganalisis Korelasi antara Income dan Total_Purchases

SELECT 
    CASE
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income BETWEEN 30000 AND 60000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS Income_Group,
    AVG(Total_Purchases) AS Avg_Purchases
FROM supermarket_customers
GROUP BY Income_Group;

-- Menambahkan Kolom CustomerSegment Berdasarkan Income

-- Tambahkan Kolom CustomerSegment
ALTER TABLE supermarket_customers 
ADD COLUMN CustomerSegment VARCHAR(20);

-- Perbarui Nilai CustomerSegment Berdasarkan Income 
UPDATE supermarket_customers
SET CustomerSegment = 
    CASE 
        WHEN Income < 30000 THEN 'Low'
        WHEN Income BETWEEN 30000 AND 60000 THEN 'Medium'
        ELSE 'High'
    END;


-- Menganalisis Pengaruh CustomerSegment terhadap Total_Purchases
SELECT CustomerSegment, AVG(Total_Purchases) AS Avg_Purchases
FROM supermarket_customers
GROUP BY CustomerSegment;



