-- 1) Find the total revenue generated from ticket sales per year of all categories. Provide analysis for each payment method

SELECT s.fest_year AS fest, t.payment_method, t.category, SUM(t.price) AS total_revenue
FROM tickets t
JOIN shows s ON t.show_id = s.show_id
GROUP BY s.fest_year, t.payment_method, t.category
ORDER BY s.fest_year, t.payment_method, t.category;

-- Q: Analysis for each payment method NOT for each ticket category. Just take into account ALL ticket categories.
