# Data Scientist Role Play: Profiling and Analyzing the Yelp Dataset Coursera Worksheet

This is a 2-part assignment. In the first part, you are asked a series of questions that will help you profile and understand the data just like a data scientist would. For this first part of the assignment, you will be assessed both on the correctness of your findings, as well as the code you used to arrive at your answer. You will be graded on how easy your code is to read, so remember to use proper formatting and comments where necessary.

In the second part of the assignment, you are asked to come up with your own inferences and analysis of the data for a particular research question you want to answer. You will be required to prepare the dataset for the analysis you choose to do. As with the first part, you will be graded, in part, on how easy your code is to read, so use proper formatting and comments to illustrate and communicate your intent as required.

For both parts of this assignment, use this "worksheet." It provides all the questions you are being asked, and your job will be to transfer your answers and SQL coding where indicated into this worksheet so that your peers can review your work. You should be able to use any Text Editor (Windows Notepad, Apple TextEdit, Notepad ++, Sublime Text, etc.) to copy and paste your answers. If you are going to use Word or some other page layout application, just be careful to make sure your answers and code are lined appropriately.
In this case, you may want to save as a PDF to ensure your formatting remains intact for you reviewer.

_____

## Part 1: Yelp Dataset Profiling and Understanding

1. Profile the data by finding the total number of records for each of the tables below:
	
    i. Attribute table = 10000 `select Count(*) from Attribute` \
    ii. Business table = 10000 `select Count(*) from Attribute`\
    iii. Category table = 10000 `select Count(*) from Business`\
    iv. Checkin table = 10000 `select Count(*) from Checkin`\
    v. elite_years table = 10000\
    vi. friend table = 10000\
    vii. hours table = 10000 \
    viii. photo table = 10000 \
    ix. review table =  10000 \
    x. tip table =  10000 \
    xi. user table = 10000 

2. Find the total distinct records by either the foreign key or primary key for each table. If two foreign keys are listed in the table, please specify which foreign key.

    i. Business = 10000\
    ii. Hours = 1562\
    iii. Category = 2643 \
    iv. Attribute = 1115 \
    v. Review = 8090 by `business_id`; 9581 by `user_id` \
    vi. Checkin = 493 \
    vii. Photo = 10000 \
    viii. Tip = 537 by `user_id`, 3979 by `business_id` \
    ix. User = 10000 \
    x. Friend = 11 \
    xi. Elite_years = 2780 

    Note: Primary Keys are denoted in the ER-Diagram with a yellow key icon

3. Are there any columns with null values in the Users table? Indicate "yes," or "no."

	Answer: No
	
	SQL code used to arrive at answer: 

    I counted the number of entries in each column of table `Users` and compared them to the number of primary keys (`id`). If the count of one column is smaller than the count of primary keys, then that column contains null values. 
    ``` sql
    SELECT count(id)
        , count(name)
        , count(review_count)
        , count(yelping_since)
        , count(useful)
        , count(funny)
        , count(cool)
        , count(fans)
        , count(average_stars)
        , count(compliment_hot)
        , count(compliment_more)
        , count(compliment_profile)
        , count(compliment_cute)
        , count(compliment_list)
        , count(compliment_note)
        , count(compliment_plain)
        , count(compliment_cool)
        , count(compliment_funny)
        , count(compliment_writer)
        , count(compliment_photos)
    from user
    ```
    all columns count to the same amount as the primary key, therefore no column has null value

	
4. For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields:

	i. Table: Review, Column: Stars
	
		min: 1.0		max: 5.0		avg: 3.7082
		
	
	ii. Table: Business, Column: Stars
	
		min: 1.0     	max: 5.0		avg:  3.6549
		
	
	iii. Table: Tip, Column: Likes
	
		min:	0	max:	2	avg:    0.0144
		
	
	iv. Table: Checkin, Column: Count
	
		min:	1	max:	53	avg:    1.9414
		
	
	v. Table: User, Column: Review_count
	
		min:	0	max:	2000	avg:    24.2995
		


5. List the cities with the most reviews in descending order:

	SQL code used to arrive at answer:
	``` sql
    select city
        , sum(review_count) total_rv
    from business 
    group by city
    order by total_rv desc
	```
	Copy and Paste the Result Below:
    ```
    +-----------------+----------+
    | city            | total_rv |
    +-----------------+----------+
    | Las Vegas       |    82854 |
    | Phoenix         |    34503 |
    | Toronto         |    24113 |
    | Scottsdale      |    20614 |
    | Charlotte       |    12523 |
    | Henderson       |    10871 |
    | Tempe           |    10504 |
    | Pittsburgh      |     9798 |
    | Montréal        |     9448 |
    | Chandler        |     8112 |
    | Mesa            |     6875 |
    | Gilbert         |     6380 |
    | Cleveland       |     5593 |
    | Madison         |     5265 |
    | Glendale        |     4406 |
    | Mississauga     |     3814 |
    | Edinburgh       |     2792 |
    | Peoria          |     2624 |
    | North Las Vegas |     2438 |
    | Markham         |     2352 |
    | Champaign       |     2029 |
    | Stuttgart       |     1849 |
    | Surprise        |     1520 |
    | Lakewood        |     1465 |
    | Goodyear        |     1155 |
    +-----------------+----------+
    (Output limit exceeded, 25 of 362 total rows shown)
    ```

	
6. Find the distribution of star ratings to the business in the following cities:

    i. Avon

    SQL code used to arrive at answer:
    ``` sql
    select stars
        , count(*)
    from business
    where city = 'Avon'
    group by stars
    ```

    Copy and Paste the Resulting Table Below (2 columns – star rating and count): \
    ```
    +-------+----------+
    | stars | count(*) |
    +-------+----------+
    |   1.5 |        1 |
    |   2.5 |        2 |
    |   3.5 |        3 |
    |   4.0 |        2 |
    |   4.5 |        1 |
    |   5.0 |        1 |
    +-------+----------+ 
    ```

    ii. Beachwood

    SQL code used to arrive at answer:
    ``` sql
    select stars
        , count(*)
    from business
    where city = 'Beachwood'
    group by stars
    ```

    Copy and Paste the Resulting Table Below (2 columns – star rating and count):
    ```
    +-------+----------+
    | stars | count(*) |
    +-------+----------+
    |   2.0 |        1 |
    |   2.5 |        1 |
    |   3.0 |        2 |
    |   3.5 |        2 |
    |   4.0 |        1 |
    |   4.5 |        2 |
    |   5.0 |        5 |
    +-------+----------+
    ```

7. Find the top 3 users based on their total number of reviews: \
	The top 3 users are Gerald, Sara, and Yuri \
	SQL code used to arrive at answer:
	``` sql
    select id
        , name
        , review_count
    from user
    order by review_count desc
    limit 3;
    ```
		
	Copy and Paste the Result Below:
    ```
    +------------------------+--------+--------------+
    | id                     | name   | review_count |
    +------------------------+--------+--------------+
    | -G7Zkl1wIWBBmD0KRy_sCw | Gerald |         2000 |
    | -3s52C4zL_DHRK0ULG6qtg | Sara   |         1629 |
    | -8lbUNlXVSoXqaRRiHiSNg | Yuri   |         1339 |
    +------------------------+--------+--------------+
    ```


8. Does posing more reviews correlate with more fans? \
	Please explain your findings and interpretation of the results: 

    Overall, users with larger fans base tend to also have more review counts. But there are lots of variations among individuals, and the ratio of review number to fan count (`r_f_ratio` in the code below) can vary from 2 to 70.
    And among the users with more review counts, the trend is not very obviouse:
    ``` sql
    select id
        , name
        , review_count
        , fans
        , round((review_count * 1.0 / fans), 3) r_f_ratio
    from user
    order by review_count desc
    ```
    The result is as such: 
    ```
    +------------------------+-----------+--------------+------+-----------+
    | id                     | name      | review_count | fans | r_f_ratio |
    +------------------------+-----------+--------------+------+-----------+
    | -G7Zkl1wIWBBmD0KRy_sCw | Gerald    |         2000 |  253 |     7.905 |
    | -3s52C4zL_DHRK0ULG6qtg | Sara      |         1629 |   50 |     32.58 |
    | -8lbUNlXVSoXqaRRiHiSNg | Yuri      |         1339 |   76 |    17.618 |
    | -K2Tcgh2EKX6e6HqqIrBIQ | .Hon      |         1246 |  101 |    12.337 |
    | -FZBTkAZEXoP7CYvRV2ZwQ | William   |         1215 |  126 |     9.643 |
    | --2vR0DIsmQ6WfcSzKWigw | Harald    |         1153 |  311 |     3.707 |
    | -gokwePdbXjfS0iF7NsUGA | eric      |         1116 |   16 |     69.75 |
    | -DFCC64NXgqrxlO8aLU5rg | Roanna    |         1039 |  104 |      9.99 |
    | -8EnCioUmDygAbsYZmTeRQ | Mimi      |          968 |  497 |     1.948 |
    | -0IiMAZI2SsQ7VmyzJjokQ | Christine |          930 |  173 |     5.376 |
    | -fUARDNuXAfrOn4WLSZLgA | Ed        |          904 |   38 |    23.789 |
    | -hKniZN2OdshWLHYuj21jQ | Nicole    |          864 |   43 |    20.093 |
    | -9da1xk7zgnnfO1uTVYGkA | Fran      |          862 |  124 |     6.952 |
    | -B-QEUESGWHPE_889WJaeg | Mark      |          861 |  115 |     7.487 |
    | -kLVfaJytOJY2-QdQoCcNQ | Christina |          842 |   85 |     9.906 |
    | -kO6984fXByyZm3_6z2JYg | Dominic   |          836 |   37 |    22.595 |
    | -lh59ko3dxChBSZ9U7LfUw | Lissa     |          834 |  120 |      6.95 |
    | -g3XIcCb2b-BD0QBCcq2Sw | Lisa      |          813 |  159 |     5.113 |
    | -l9giG8TSDBG1jnUBUXp5w | Alison    |          775 |   61 |    12.705 |
    | -dw8f7FLaUmWR7bfJ_Yf0w | Sui       |          754 |   78 |     9.667 |
    | -AaBjWJYiQxXkCMDlXfPGw | Tim       |          702 |   35 |    20.057 |
    | -jt1ACMiZljnBFvS6RRvnA | L         |          696 |   10 |      69.6 |
    | -IgKkE8JvYNWeGu8ze4P8Q | Angela    |          694 |  101 |     6.871 |
    | -hxUwfo3cMnLTv-CAaP69A | Crissy    |          676 |   25 |     27.04 |
    | -H6cTbVxeIRYR-atxdielQ | Lyn       |          675 |   45 |      15.0 |
    +------------------------+-----------+--------------+------+-----------+
    (Output limit exceeded, 25 of 10000 total rows shown)
    ```

	
9. Are there more reviews with the word "love" or with the word "hate" in them?

	Answer: Yes, there are 1780 comments with word "love" while only 232 with 'hate'. 

	
	SQL code used to arrive at answer:
    ``` sql
    select count(*) 
    from review
    where text like '%love%';

    select count(*) 
    from review
    where text like '%hate%'
    ```	
	
10. Find the top 10 users with the most fans:
    
	SQL code used to arrive at answer: 
	``` sql
    select name 
        , fans
        , id
    from user
    order by fans desc
    limit 10
    ```
	Copy and Paste the Result Below:
    ```
    +-----------+------+------------------------+
    | name      | fans | id                     |
    +-----------+------+------------------------+
    | Amy       |  503 | -9I98YbNQnLdAmcYfb324Q |
    | Mimi      |  497 | -8EnCioUmDygAbsYZmTeRQ |
    | Harald    |  311 | --2vR0DIsmQ6WfcSzKWigw |
    | Gerald    |  253 | -G7Zkl1wIWBBmD0KRy_sCw |
    | Christine |  173 | -0IiMAZI2SsQ7VmyzJjokQ |
    | Lisa      |  159 | -g3XIcCb2b-BD0QBCcq2Sw |
    | Cat       |  133 | -9bbDysuiWeo2VShFJJtcw |
    | William   |  126 | -FZBTkAZEXoP7CYvRV2ZwQ |
    | Fran      |  124 | -9da1xk7zgnnfO1uTVYGkA |
    | Lissa     |  120 | -lh59ko3dxChBSZ9U7LfUw |
    +-----------+------+------------------------+
    ```
		
____

## Part 2: Inferences and Analysis

1. Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.
	

    i. Do the two groups you chose to analyze have a different distribution of hours? 

    The city I chose: `'Toronto'`; Category I chose: `'Restaurants'`. \
    Yes Toronto businesses or Restaurant businesses have different opening hours among 2-3 star businesses and 4-5 star ones. \
    For businesses in Toronto, take the example of opening hours on Wednesday, businesses between 2 to 3 stars overall opens earlier and opens for longer hours than businesses between 4 to 5 stars. All 2-3 star businesses open from between early morning and before noon (6h - 11h) to between night and after midnight (21h - 2h next day), while most of the 4-5 star businesses open in afternoon between 14h to 18h until night or past midnight. 

    For category Restaurants: the opening hours are different. It seems that 2-3 star businesses open for longer hours than 4-5 star ones. 

    ii. Do the two groups you chose to analyze have a different number of reviews? \
    Yes, Both groups have way more businesses with an average rating of 4-5 stars than with average rating between 2-3 stars. \
    For Toronto, there are 307 2-3 star businesses while 439 4-5 star businesses. \
    For restaurants, there are 24 2-3 star businesses while 29 4-5 star ones. 
    ``` sql
    select city
    -- select category
        , sum(b.stars2_3) n_23
        , sum(b.stars4_5) n_45
    from (
        select * 
            , case when 2 <= stars and stars <= 3 then 1
                else 0
                end stars2_3
            , case when 4 <= stars and stars <= 5 then 1
                else 0
                end stars4_5
        from business bz 
        -- inner join category c on bz.id = c.business_id
    ) b
    group by city
    -- group by category
    having n_23 > 0 or n_45 > 0
    order by n_23 desc
    ```

    iii. Are you able to infer anything from the location data provided between these two groups? Explain. \
    Most cities have more businesses between 4 and 5 stars than those between 2 and 3 star ratings. \
    Most cities have more 4-5 star businesses than 2-3 stars (except for Richmond Hill); and most categories have more 4-5 star businesses than 2-3 star ones. 

    SQL code used for analysis: \
    question i: compare the opening hour distribution for businesses in Toronto. 
    ``` sql
    select h.hours
        , sum(b.stars2_3) n_23
        , sum(b.stars4_5) n_45
    from (
        select * 
            , case when 2 <= stars and stars <= 3 then 1
                else 0
                end stars2_3
            , case when 4 <= stars and stars <= 5 then 1
                else 0
                end stars4_5
        from business bz 
        -- inner join category c on bz.id = c.business_id
    ) b
    inner join hours h on b.id = h.business_id
    where b.city = 'Toronto'
    group by hours
    having n_23 > 0 or n_45 > 0
    order by hours desc
    ```
    This returns the result: 
    ```
    +-----------------------+------+------+
    | h.hours               | n_23 | n_45 |
    +-----------------------+------+------+
    | Wednesday|9:00-23:00  |    1 |    0 |
    | Wednesday|8:00-22:00  |    1 |    0 |
    | Wednesday|6:00-22:00  |    1 |    0 |
    | Wednesday|18:00-2:00  |    0 |    1 |
    | Wednesday|18:00-23:00 |    0 |    1 |
    | Wednesday|17:00-22:00 |    0 |    1 |
    | Wednesday|15:00-21:00 |    0 |    1 |
    | Wednesday|14:00-19:00 |    0 |    1 |
    | Wednesday|11:00-2:00  |    1 |    0 |
    | Wednesday|11:00-23:00 |    1 |    1 |
    | Wednesday|11:00-19:00 |    0 |    1 |
    | Wednesday|10:30-21:00 |    1 |    0 |
    | Tuesday|9:00-23:00    |    1 |    0 |
    | Tuesday|9:00-19:00    |    0 |    1 |
    | Tuesday|8:00-22:00    |    1 |    0 |
    | Tuesday|6:00-22:00    |    1 |    0 |
    | Tuesday|18:00-2:00    |    0 |    1 |
    | Tuesday|18:00-22:00   |    0 |    1 |
    | Tuesday|15:00-21:00   |    0 |    1 |
    | Tuesday|11:30-18:00   |    0 |    1 |
    | Tuesday|11:00-2:00    |    1 |    0 |
    | Tuesday|11:00-23:00   |    1 |    1 |
    | Tuesday|11:00-19:00   |    0 |    1 |
    | Tuesday|10:30-21:00   |    1 |    0 |
    | Thursday|9:00-23:00   |    1 |    0 |
    +-----------------------+------+------+
    (Output limit exceeded, 25 of 81 total rows shown)
    ```
    comparing the opening hour for businesses in the category 'Restaurants'
    ``` sql
    select h.hours
        , sum(b.stars2_3) n_23
        , sum(b.stars4_5) n_45
    from (
        select * 
            , case when 2 <= stars and stars <= 3 then 1
                else 0
                end stars2_3
            , case when 4 <= stars and stars <= 5 then 1
                else 0
                end stars4_5
        from business bz 
        inner join category c on bz.id = c.business_id
    ) b
    inner join hours h on b.id = h.business_id
    where b.category = 'Restaurants'
    group by hours
    having n_23 > 0 or n_45 > 0
    order by hours desc
    ```
    This returns the result: 
    ```
    +-----------------------+------+------+
    | h.hours               | n_23 | n_45 |
    +-----------------------+------+------+
    | Wednesday|9:00-23:00  |    1 |    0 |
    | Wednesday|9:00-21:00  |    1 |    0 |
    | Wednesday|6:00-23:00  |    1 |    0 |
    | Wednesday|6:00-15:30  |    1 |    0 |
    | Wednesday|6:00-15:00  |    0 |    1 |
    | Wednesday|6:00-14:30  |    0 |    1 |
    | Wednesday|6:00-14:00  |    0 |    1 |
    | Wednesday|5:00-23:00  |    1 |    0 |
    | Wednesday|18:00-2:00  |    0 |    1 |
    | Wednesday|18:00-23:00 |    0 |    1 |
    | Wednesday|17:00-1:00  |    1 |    0 |
    | Wednesday|16:00-22:00 |    0 |    1 |
    | Wednesday|12:00-23:00 |    1 |    0 |
    | Wednesday|12:00-22:30 |    0 |    1 |
    | Wednesday|12:00-22:00 |    1 |    0 |
    | Wednesday|11:30-23:00 |    1 |    0 |
    | Wednesday|11:30-20:00 |    0 |    1 |
    | Wednesday|11:00-2:30  |    1 |    0 |
    | Wednesday|11:00-23:00 |    2 |    1 |
    | Wednesday|11:00-22:00 |    0 |    1 |
    | Wednesday|11:00-21:00 |    0 |    1 |
    | Wednesday|11:00-20:00 |    0 |    2 |
    | Wednesday|11:00-18:00 |    0 |    1 |
    | Wednesday|11:00-0:30  |    1 |    0 |
    | Wednesday|11:00-0:00  |    3 |    1 |
    +-----------------------+------+------+
    (Output limit exceeded, 25 of 201 total rows shown)
    ```
  
    For comparing the location distribution of the 2 groups: 
    ``` sql
    select city
        , sum(stars2_3)
        , sum(stars4_5)
    from (
        select *
            , case when 2 <= avg_stars and avg_stars <= 3 then 1
                else 0
                end stars2_3
            , case when 4 <= avg_stars and avg_stars <= 5 then 1
                else 0
                end stars4_5
        from business_rating
    ) b_rt
    where city is not null
    group by city
    order by sum(stars4_5) desc;
    ```
    This returns the following result: 
    ```
    +-----------------+---------------+---------------+
    | city            | sum(stars2_3) | sum(stars4_5) |
    +-----------------+---------------+---------------+
    | Las Vegas       |            17 |            93 |
    | Phoenix         |            11 |            31 |
    | Toronto         |             9 |            24 |
    | Scottsdale      |             7 |            21 |
    | Tempe           |             3 |            18 |
    | Pittsburgh      |             4 |            17 |
    | Henderson       |             3 |            15 |
    | Chandler        |             2 |            10 |
    | Montréal        |             4 |            10 |
    | Charlotte       |             4 |             9 |
    | Mesa            |             1 |             8 |
    | Madison         |             3 |             7 |
    | Gilbert         |             1 |             6 |
    | Cleveland       |             4 |             5 |
    | Edinburgh       |             1 |             4 |
    | Champaign       |             0 |             3 |
    | Glendale        |             0 |             3 |
    | Cave Creek      |             0 |             2 |
    | Goodyear        |             0 |             2 |
    | Lakewood        |             1 |             2 |
    | Matthews        |             0 |             2 |
    | North Las Vegas |             0 |             2 |
    | North York      |             0 |             2 |
    | Surprise        |             1 |             2 |
    | Urbana          |             0 |             2 |
    +-----------------+---------------+---------------+
    (Output limit exceeded, 25 of 67 total rows shown)
    ```
		
		
2. Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.
		
    i. Difference 1:\
    There are a lot more businesses that are open (8480) than those that are closed (1520), and the average rating of the open businesses (3.68 stars) is overall higher than that of closed ones (3.52). 
            
    ii. Difference 2:\
    The open businesses have almost 1/3 more review counts (at 31.76) than the closed businesses (at 23.20 average). 
            
    iii. SQL code used for analysis:\
    To compare the average stars of open and closed businesses: 
    ``` sql
    select is_open
        , avg(stars)
        , avg(review_count)
        , count(*)
    from business
    where stars not null
    group by is_open
    ```
    this returns the result: 
    ```
    +---------+---------------+-------------------+----------+
    | is_open |    avg(stars) | avg(review_count) | count(*) |
    +---------+---------------+-------------------+----------+
    |       0 | 3.52039473684 |     23.1980263158 |     1520 |
    |       1 | 3.67900943396 |     31.7570754717 |     8480 |
    +---------+---------------+-------------------+----------+    
    ```
	
3. For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.

    Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, and so on. These are just a few examples to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
        
    i. Indicate the type of analysis you chose to do:

    To study the relation between the number of fans a user has and the number of reviews, usefulness, funniness, coolness of their reviews and how long they have been yelping from.    
            
    ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:

    First, I need to group the fans counts for easier classification: I separated fan counts into 5 groups: zero fans, 1-10 fans (`below10`), 11-30 fans (`below30`), 31-100 fans (`below100`), over 100 fans (`over100`) and created a view with this classification as an additional column; \
    Then I need to have calculate the average usefulness, average review count, average funniness, average yelping age, etc., for for each fan count group. 
                            
                    
    iii. Output of your finished dataset:
    ```
    +----------+---------+------------+-----------+-----------+---------+----------+------+
    | fans_bin |  avg_rv | avg_useful | avg_funny |  avg_cool | avg_age | avg_fans |    n |
    +----------+---------+------------+-----------+-----------+---------+----------+------+
    | 0        |   7.426 |      2.604 |     0.784 |      0.47 |   8.728 |      0.0 | 7707 |
    | below010 |  46.361 |     29.421 |    12.321 |    11.457 |   10.58 |     2.31 | 2015 |
    | below030 | 257.552 |    300.878 |   100.492 |   152.282 |   12.11 |   17.475 |  181 |
    | below100 | 388.457 |     749.58 |    470.58 |   541.358 |  12.519 |   49.914 |   81 |
    | over100  |   891.5 |  11627.375 |   10047.0 | 10954.063 |  12.688 |   189.75 |   16 |
    +----------+---------+------------+-----------+-----------+---------+----------+------+
    ```
    By observing and comparing the output data, we can conclude that the number of fans a user accumulates is directly correlated with the number of reviews they left, how useful, how funny, and how cool they are rated, and how long they have been using yelp. \
    Overall, the more reviews that a user left, the more fans they have; \
    The more funny, useful, cool they are perceived by other users, they more fans they have; \
    The longer they use yelp, the more likely they are to attract more fans. 

    iv. Provide the SQL code you used to create your final dataset:
    ``` sql
    select fans_bin
        , round(avg(review_count), 3) avg_rv
        , round(avg(useful), 3) avg_useful
        , round(avg(funny), 3) avg_funny
        , round(avg(cool), 3) avg_cool
        , round(avg(date('now') - yelping_since), 3) avg_age
        , round(avg(fans), 3) avg_fans
        , count(*) n
    from (
        select *
            , case 
                when fans = 0 then '0'
                when fans > 0 and fans <= 10 then 'below010'
                when fans > 10 and fans <= 30 then 'below030'
                when fans > 30 and fans <= 100 then 'below100'
                else 'over100'
            end fans_bin
        from user
    )
    group by fans_bin
    ```