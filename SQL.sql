SELECT * 
FROM
(
    SELECT w.name, COUNT(t.task_id) as tasks
    FROM workers w
    LEFT JOIN tasks t ON w.worker_id = t.worker_id
    GROUP BY w.worker_id, w.name
) as subquery
WHERE tasks = 0 OR tasks IN 
(
    SELECT tasks
    FROM 
    (
        SELECT COUNT(t.task_id) as tasks
        FROM workers w
        LEFT JOIN tasks t ON w.worker_id = t.worker_id
        GROUP BY w.worker_id
        ORDER BY tasks DESC
        LIMIT 3
    ) as top_tasks
)
ORDER BY tasks DESC; 