select 
    b.city
    , round(avg(r.stars), 2) avg_stars
    , count(*) n_reviews
from review r 
inner join business b on r.business_id = b.id
where r.business_id in(
    select distinct business_id from hours
) -- makes sure that all the businesses selected also in hours table
group by b.city
order by n_reviews desc;
-- lists out # reviews received by city with opening hours available
-- biggest city being 'Cleveland' & 'Phoenix' with 3 
-- (only 9 reviews in total )

select city
    , round(avg(stars), 2) avg_stars
    , sum(review_count) n_reviews
    , count(id) n_businesses
from business 
where id in(
    select distinct business_id from hours
)
group by city
order by n_businesses desc;
-- lists out # reviews and # of businesses received by city with opening hours available
-- biggest city being 'Toronto' with 15 businesses


select c.category
    , sum(review_count) n_reviews
    , count(id) n_bz
from business b
inner join category c on b.id = c.business_id
where id in(
    select distinct business_id from hours
)
group by c.category
order by n_bz desc; 
-- lists out number of reviews received by businesses in each category 
-- category with most reviews being 'Restaurants', with 43 businesses


select 
    c.category
    , round(avg(r.stars), 2) avg_stars
    , count(*) n_reviews
from review r 
inner join category c on r.business_id = c.business_id
where r.business_id in(
    select distinct business_id from hours
) -- makes sure that all the businesses selected also in hours table
group by c.category
order by n_reviews desc;
-- lists out number of reviews received by businesses in each category 
-- category with most reviews being 'Restaurants', with 76

select r.business_id
    , count(*) n_reviews
    , avg(r.stars) avg_stars
from review r 
left join business b on r.business_id = b.id 
-- selects all entries in reviews table, returns 10000
where b.id is NULL 
-- select reviews from reviews table whose business is 
-- not in businesses table, returns 9364
-- inner join business b on r.business_id = b.id 
-- -- selects only entries in both tables, returns 646 rows
group by r.business_id
order by n_reviews desc; -- returns 7583 distinct id

select h.hours
    , sum(stars2_3)
    , sum(stars4_5)
-- group by opening hours and count the amount of 2-3 stars businesses
-- and the amount of 4-5 star businesses for each opening hour category 
from (
    select *
        , case when 2 <= avg_stars and avg_stars <= 3 then 1
            else 0
            end stars2_3
        , case when 4 <= avg_stars and avg_stars <= 5 then 1
            else 0
            end stars4_5
    from (
        -- creates a view that the city,  category, and name of businesses
        -- and calculates the average ratings for each one
        select 
            r.business_id
            , round(avg(r.stars), 2) avg_stars
            , count(*) n_reviews
            , b.city
            , c.category
            , b.name
        from review r 
        left join business b on r.business_id = b.id
        left join category c on r.business_id = c.business_id 
        -- using left join instead of inner join ensures more matching results
        -- avoids missing data where, e.g., business id only exists in one of 
        -- category / business table 
        group by r.business_id
        order by n_reviews desc
    )
) b_rt
inner join hours h on b_rt.business_id = h.business_id
where category = 'Restaurants'
-- where city = 'Cleveland'
group by h.hours
;

select city
    , sum(stars2_3)
    , sum(stars4_5)
-- group by opening hours and count the amount of 2-3 stars businesses
-- and the amount of 4-5 star businesses for each opening hour category 
from (
    select *
        , case when 2 <= avg_stars and avg_stars <= 3 then 1
            else 0
            end stars2_3
        , case when 4 <= avg_stars and avg_stars <= 5 then 1
            else 0
            end stars4_5
    from (
        -- creates a view that the city,  category, and name of businesses
        -- and calculates the average ratings for each one
        select 
            r.business_id
            , round(avg(r.stars), 2) avg_stars
            , count(*) n_reviews
            , b.city
            , c.category
            , b.name
        from review r 
        left join business b on r.business_id = b.id
        left join category c on r.business_id = c.business_id 
        -- using left join instead of inner join ensures more matching results
        -- avoids missing data where, e.g., business id only exists in one of 
        -- category / business table 
        group by r.business_id
        order by n_reviews desc
    )
) b_rt
where city is not null
group by city
order by sum(stars4_5) desc

-- comparing the average stars from the reviews table
select is_open
    -- , round(avg(avg_stars), 2) avg_business
    , avg(avg_stars)
    , count(*)
from (
    select *
        , (1 - is_open) as closed
    from business b
    left join (
        select business_id
            , round(avg(stars), 2) avg_stars
        from review 
        group by business_id        
    ) b_rt
    on b.id = b_rt.business_id


-- compare opening rate for each city: 
select *
    , (n_open * 1.0 / n_business) open_rate
from (
    select city
        , sum(is_open) n_open
        , sum(closed) n_closed
        , count(*) n_business
        -- , avg(avg_stars)
        , round(avg(avg_stars), 2) city_rating
    from (
        select *
            , (1 - is_open) as closed
        from business b
        left join (
            select business_id
                , round(avg(stars), 2) avg_stars
            from review 
            group by business_id        
        ) b_rt
        on b.id = b_rt.business_id
    )
    -- where avg_stars not null
    group by city
    order by n_open desc
)

-- For comparing the opening hours of businesses with different ratings, first we create a view of the table that joins the `review` table  to `business` and `category` table and that calculates the average ratings of businesses. We use left join to connect the tables so as keep more matching results: 
create view business_rating
as 
select 
    r.business_id
    , round(avg(r.stars), 2) avg_stars
    , count(*) n_reviews
    , b.city
    , c.category
    , b.name
from review r 
left join business b on r.business_id = b.id
left join category c on r.business_id = c.business_id 
-- using left join instead of inner join ensures more matching results
-- avoids missing data where, e.g., business id only exists in one of 
-- category / business table 
group by r.business_id
order by n_reviews desc;

-- Then group by opening hours and count the amount of 2-3 stars businesses  and the amount of 4-5 star businesses for each opening hour category:
select h.hours
    , sum(stars2_3)
    , sum(stars4_5)
from (
    -- creates extra columns of boolean values of whether the business
    -- has average rating of 2-3 stars or 4-5 stars
    select *
        , case when 2 <= avg_stars and avg_stars <= 3 then 1
            else 0
            end stars2_3
        , case when 4 <= avg_stars and avg_stars <= 5 then 1
            else 0
            end stars4_5
    from business_rating
) b_rt
inner join hours h on b_rt.business_id = h.business_id
where category = 'Restaurants' -- for comparing businesses of 'Restaurants' category
-- where city = 'Cleveland' -- for comparing businesses of city Cleveland
group by h.hours;


------------------------------------------
select h.hours
    , sum(stars2_3) n_23
    , sum(stars4_5) n_45
from (
    select * 
        , case when 2 <= stars and stars <= 3 then 1
            else 0
            end stars2_3
        , case when 4 <= stars and stars <= 5 then 1
            else 0
            end stars4_5
    from business bz 
    left join category c on bz.id = c.business_id
) b
inner join hours h on b.id = h.business_id
where city = 'Toronto'
group by h.hours;

--------------------------
-- select the number of businesses in each rating bin and compare the differences
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


