-- 1. Все активные заявки клиента
SELECT application_id, status, created_at, updated_at
FROM brokerage_application
WHERE customer_id = :customer_id
  AND status NOT IN ('REJECTED', 'ACCOUNT_OPENED')
ORDER BY created_at DESC;

-- 2. История статусов заявки
SELECT old_status, new_status, changed_at
FROM status_history
WHERE application_id = :application_id
ORDER BY changed_at;

-- 3. Количество заявок по статусам
SELECT status, COUNT(*) AS applications_count
FROM brokerage_application
GROUP BY status
ORDER BY applications_count DESC;

-- 4. Конверсия в открытый счёт (упрощённо)
SELECT
    COUNT(*) FILTER (WHERE status = 'ACCOUNT_OPENED')::decimal
    / NULLIF(COUNT(*), 0) AS open_rate
FROM brokerage_application;

-- 5. Проверка наличия обязательных согласий
SELECT ba.application_id
FROM brokerage_application ba
LEFT JOIN consent c
  ON ba.application_id = c.application_id
WHERE ba.application_id = :application_id
GROUP BY ba.application_id
HAVING COUNT(c.consent_id) < 2;

-- 6. Среднее время от заявки до открытия счёта
SELECT AVG(a.opened_at - ba.created_at) AS avg_time_to_open
FROM brokerage_application ba
JOIN brokerage_account a
  ON a.application_id = ba.application_id;
