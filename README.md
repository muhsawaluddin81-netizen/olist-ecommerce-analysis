# 🛒 Olist E-Commerce Performance Analysis

## 📌 Project Overview
This project analyzes the business performance of **Olist**, a Brazilian e-commerce platform, using a public dataset from Kaggle. The analysis covers **7 business questions** across four key dimensions sales, product performance, logistics, and customer satisfaction to generate actionable insights for business decision making.

**Tools Used:** PostgreSQL · Power BI  
**Dataset:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)  
**Total Tables:** 9 relational tables · ~100K orders

---

## 🗂️ Dataset Schema
The dataset consists of 9 interrelated tables connected through a relational schema with `olist_orders` as the central table.

```
olist_orders (central)
├── olist_customers       → via customer_id
├── olist_order_items     → via order_id
│   ├── olist_products    → via product_id
│   │   └── product_category_name_translation → via product_category_name
│   └── olist_sellers     → via seller_id
├── olist_order_payments  → via order_id
└── olist_order_reviews   → via order_id

olist_customers → olist_geolocation → via customer_zip_code_prefix
```

---

## ❓ Business Questions

| No | Business Question |
|---|---|
| 1 | Kota mana yang memiliki rata-rata nilai transaksi tertinggi dan terendah? |
| 2 | Produk apa yang penjualannya paling tinggi dan paling rendah? (Top 3 & Bottom 3) |
| 3 | Di kota mana produk terlaris paling banyak terjual? (Top 10) |
| 4 | Daerah mana yang memiliki rata-rata waktu pengiriman paling cepat dan paling lambat? |
| 5 | Bagaimana distribusi review customer positif (4-5), netral (3), negatif (1-2)? |
| 6 | Apakah keterlambatan pengiriman berkorelasi dengan review negatif? |
| 7 | Bagaimana tren volume transaksi dari waktu ke waktu? |

---

## 🔧 Workflow

```
📥 Download Dataset (Kaggle)
        ↓
🗄️ Import to PostgreSQL
   └── Create 9 tables with proper data types & constraints
   └── Import CSV files into each table
        ↓
🔍 SQL Analysis
   └── Write queries to answer 7 business questions
   └── Techniques: JOIN, GROUP BY, HAVING, CASE WHEN,
       DATE_PART, TO_CHAR, UNION ALL, Subquery, Window Function
        ↓
📊 Power BI Dashboard
   └── Connect Power BI directly to PostgreSQL via Native Query
   └── Build interactive dashboard with cross-filtering
```

---

## 📊 Key Findings

### 1. Rata-rata Transaksi per Kota
- **Tertinggi:** Campina Grande (281.28 reais) dari kota-kota dengan min. 50 transaksi
- **Terendah:** Tupa (91.70 reais)
- *Rekomendasi: Pertahankan performa di Campina Grande dan investigasi faktor rendahnya transaksi di Tupa.*

### 2. Produk Terlaris & Paling Tidak Laku
| Top 3 Terlaris | Jumlah | Bottom 3 Tidak Laku | Jumlah |
|---|---|---|---|
| Bed Bath Table | 11,115 | Security & Services | 2 |
| Health Beauty | 9,670 | Fashion Children's Clothes | 8 |
| Sports Leisure | 8,641 | CDs DVDs Musicals | 14 |

### 3. Distribusi Produk Terlaris per Kota
- **São Paulo** mendominasi penjualan Bed Bath Table dengan **1,984 item** — lebih dari 2x lipat kota kedua (Rio de Janeiro, 854 item)

### 4. Durasi Pengiriman per Kota
- **Tercepat:** Biritiba Mirim — rata-rata **3.20 hari**
- **Terlambat:** Lagarto — rata-rata **33.36 hari** (selisih 10x lipat)

### 5. Distribusi Review Customer
| Kategori | Jumlah | Persentase |
|---|---|---|
| Positif (4-5) | 76,470 | 77.07% |
| Negatif (1-2) | 14,575 | 14.69% |
| Netral (3) | 8,179 | 8.24% |

### 6. Korelasi Keterlambatan & Review Negatif
- **54.01%** customer yang mengalami keterlambatan memberikan review negatif
- Hanya **9.23%** dari customer yang menerima pesanan tepat waktu memberikan review negatif
- ⚠️ *Keterlambatan pengiriman terbukti berkorelasi kuat dengan ketidakpuasan pelanggan*

### 7. Tren Volume Transaksi (Jan 2017 — Aug 2018)
- Volume transaksi tumbuh **8x lipat** dalam 20 bulan (800 → 6,512 transaksi/bulan)
- Puncak tertinggi: **November 2017 (7,544 transaksi)** — bertepatan dengan **Black Friday**

---

## 💡 Business Insight
Olist menunjukkan pertumbuhan bisnis yang sehat dengan volume transaksi tumbuh 8x lipat dalam 20 bulan, didukung oleh mayoritas customer (77.07%) yang memberikan review positif. Namun, performa logistik menjadi perhatian utama  keterlambatan pengiriman terbukti berkorelasi kuat dengan review negatif, dimana 54% customer yang mengalami keterlambatan memberikan penilaian buruk. Prioritas perbaikan utama terletak pada optimalisasi jaringan distribusi dan kemitraan kurir, terutama di daerah-daerah dengan rata-rata durasi pengiriman tinggi.

---

## 📸 Dashboard Preview
<img width="1398" height="751" alt="Screenshot 2026-05-07 193528" src="https://github.com/user-attachments/assets/51f89b76-1d06-4067-a29d-b1a6281109b0" />

--- 

## 🛠️ SQL Techniques Used
`JOIN` · `GROUP BY` · `HAVING` · `WHERE` · `CASE WHEN` · `DATE_PART` · `TO_CHAR` · `ROUND` · `AVG` · `COUNT` · `SUM OVER()` · `UNION ALL` · `Subquery` · `SERIAL PRIMARY KEY` · `Composite Primary Key`

---

## 📁 Project Structure
```
olist-ecommerce-analysis/
├── sql/
│   ├── create_tables.sql      # DDL queries for all 9 tables
│   ├── bq1_avg_transaction.sql
│   ├── bq2_top_bottom_product.sql
│   ├── bq3_product_distribution.sql
│   ├── bq4_delivery_duration.sql
│   ├── bq5_review_distribution.sql
│   ├── bq6_delivery_vs_review.sql
│   └── bq7_transaction_trend.sql
├── dashboard/
│   └── olist_dashboard.pbix
├── assets/
│   └── dashboard_preview.png
└── README.md
```

---

*Dataset Source: [Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle*
