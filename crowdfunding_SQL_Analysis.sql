ALTER TABLE "backers" ADD CONSTRAINT "fk_backers_cf_id" FOREIGN KEY("cf_id")
REFERENCES "campaign" ("cf_id");

SELECT * FROM backers

-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id, backers_count
FROM campaign
WHERE  outcome = 'live'
ORDER BY backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT bk.cf_id, cp.backers_count
FROM backers AS bk
JOIN campaign AS cp
ON cp.cf_id = bk.cf_id
WHERE cp.outcome = 'live'
ORDER BY cp.backers_count DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT
	ct.first_name,
	ct.last_name,
	ct.email,
	(cp.goal - cp.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM campaign AS cp
INNER JOIN contacts AS ct
ON ct.contact_id = cp.contact_id
WHERE cp.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT bk.email, bk.first_name, bk.last_name, bk.cf_id, cp.description, cp.end_date, (cp.goal-cp.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers AS bk
JOIN campaign AS cp
ON cp.cf_id = bk.cf_id
WHERE cp.outcome = 'live'
ORDER BY bk.email DESC;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount
