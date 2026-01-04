-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

SELECT 
    message_date,
    user_name,
    messages_sent
FROM (
    SELECT 
        DATE(sent_at) AS message_date,
        u.user_name,
        COUNT(*) AS messages_sent,
        RANK() OVER (
            PARTITION BY DATE(sent_at) 
            ORDER BY COUNT(*) DESC
        ) as rank_val
    FROM npn_messages m
    JOIN npn_users u ON m.sender_id = u.user_id
    GROUP BY DATE(sent_at), u.user_id
) 
WHERE rank_val = 1;
