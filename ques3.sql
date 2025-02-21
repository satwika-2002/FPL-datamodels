select s.supplier_name,s.country,s.reliability_score from suppliers s where
exists(select 1 from products p join inventory i on p.product_id = i.product_id where i.quantity < 100)
order by s.reliability_score desc;
#semi join just matches the value 
#it will display only one tables values(first tables)
#we will just check the condition if it matches then it will return firstvtable values