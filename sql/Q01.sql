SELECT
  YEAR(s.show_date) AS year,
  t.payment_method,
  t.category,
  SUM(t.price) AS total_revenue
FROM
  Tickets t
JOIN
  Shows s ON t.show_id = s.show_id
GROUP BY
  YEAR(s.show_date),
  t.payment_method,
  t.category
ORDER BY
  year,
  t.payment_method,
  t.category;
