create table universal_studio(
	id INT AUTO_INCREMENT PRIMARY KEY,
	reviewer varchar(255),
	rating int,
	written_date varchar(255),
	title varchar(255),
	review_text LONGTEXT,
	branch varchar(255)
)

update universal_studio 
set written_date = STR_TO_DATE(written_date, '%M %d, %Y')

WITH DuplicateReviews AS (
  SELECT
    reviewer,
    rating,
    written_date,
    title,
    review_text,
    branch,
    ROW_NUMBER() OVER (PARTITION BY reviewer, rating, written_date, title, review_text, branch) AS row_num
  FROM
    universal_studio
)
SELECT
  reviewer,
  rating,
  written_date,
  title,
  review_text,
  branch
FROM
  DuplicateReviews
WHERE
  row_num = 1;
 