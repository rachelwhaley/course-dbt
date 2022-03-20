What is our user repeat rate? (Repeat Rate = Users who purchased 2 or more times / users who purchased)
* 79.8%, based on this query:
```
with counts as (select 
sum (case when num_orders>1 then 1 else 0 end) as repeater_count,
sum (case when num_orders>=1 then 1 else 0 end) as purchaser_count
from dbt_rachelw.dim_users
)

select repeater_count*1.0/purchaser_count as user_repeat_rate
from counts
```

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
* 

Explain the marts models you added. Why did you organize the models in the way you did?
* 


What assumptions are you making about each model? (i.e. why are you adding each test?)
* 

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
* 

Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
* At work I set up dbt cloud to run our tests on a scheduled nightly job, so I think I would use that approach here as well.