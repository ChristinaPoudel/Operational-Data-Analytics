
-- Toronto Field Operations & Service Performance Tracker
-- Dataset: Toronto 311 Service Requests, 2025

-- 1. Overall data quality
SELECT
    COUNT(*) AS total_records,
    COUNT(creation_date) AS records_with_creation_date,
    COUNT(*) - COUNT(creation_date) AS missing_creation_date
FROM public.service_requests;

-- 2. Requests by status
SELECT
    status,
    COUNT(*) AS total_requests,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM public.service_requests),
        2
    ) AS percentage
FROM public.service_requests
GROUP BY status
ORDER BY total_requests DESC;

-- 3. Requests by division
SELECT
    division,
    COUNT(*) AS total_requests
FROM public.service_requests
GROUP BY division
ORDER BY total_requests DESC;

-- 4. Top 15 request types
SELECT
    service_request_type,
    COUNT(*) AS total_requests
FROM public.service_requests
GROUP BY service_request_type
ORDER BY total_requests DESC
LIMIT 15;

-- 5. Monthly request volume
SELECT
    TO_CHAR(creation_date, 'YYYY-MM') AS request_month,
    COUNT(*) AS total_requests
FROM public.service_requests
WHERE creation_date IS NOT NULL
GROUP BY TO_CHAR(creation_date, 'YYYY-MM')
ORDER BY request_month;

-- 6. Top request types in February 2025
SELECT
    service_request_type,
    COUNT(*) AS total_requests
FROM public.service_requests
WHERE creation_date >= TIMESTAMP '2025-02-01'
  AND creation_date < TIMESTAMP '2025-03-01'
GROUP BY service_request_type
ORDER BY total_requests DESC
LIMIT 10;
