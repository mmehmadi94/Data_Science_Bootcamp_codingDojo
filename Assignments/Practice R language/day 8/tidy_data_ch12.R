
###########   Tidy Data Ch12: Excerices soluation of R for Data Science  ################

# 12.2.1 Exercises --------------------------------------------------------

# 1- Using prose, describe how the variables and observations are organised in each of the sample tables.
# table 1- it is tidy table 
# table 2- it is untidy as each observation must have its own row 
# (repeat info-count column represents the unique value for the variable type.)
table2
# table 3 - it is untidy as each value have its own cell
table3
# table 4a/4b - it is untidy as each variable/ feature must have its own column
table4a
table4b

# 2- Compute rate per 10,000
tidyTable2 <- table2 %>% pivot_wider(names_from = type, values_from = count)

tidyTable2 %>%  mutate(rate = cases / population * 10000)

# 3- Recreate the plot showing change in cases over time using table2 instead of table1.
# What do you need to do first?

ggplot(tidyTable2, aes(year, cases )) +
  geom_line(mapping = aes(group = country), color = 'grey50') +
  geom_point(mapping = aes(color = country)) + labs(y = 'cases')

tidyTable2

# 12.3.3 Exercises --------------------------------------------------------

# 1- Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
#  Carefully consider the following example:
  
  stocks <- tibble(
    year   = c(2015, 2015, 2016, 2016),
    half  = c(   1,    2,     1,    2),
    return = c(1.88, 0.59, 0.92, 0.17)
  )
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")
#(Hint: look at the variable types and think about column names.)
# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). What does it do?
  
# Answer: because column type information is lost when a data frame is converted from wide to long.

# 3-  Why does this code fail?
  
  table4a %>% 
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")
#> Error: Can't subset columns that don't exist.
#> ✖ Locations 1999 and 2000 don't exist.
#> ℹ There are only 3 columns.

# Answer: we need to add backticks around column name
  table4a %>% 
    pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
  
# 3- What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?
  
  people <- tribble(
    ~name,             ~names,  ~values,
    #-----------------|--------|------
    "Phillip Woods",   "age",       45,
    "Phillip Woods",   "height",   186,
    "Phillip Woods",   "age",       50,
    "Jessica Cordero", "age",       37,
    "Jessica Cordero", "height",   156
  )

# Answer: two age values for Phillip. The problem is each row not uniquely identify 
  
  pivot_wider(people, names_from="names", values_from = "values")

# We could solve the problem by adding a row with a distinct observation count 
# for each combination of name and key.
  
  people2 <- people %>%
    group_by(name, names) %>%
    mutate(obs = row_number())  
  people2
  
# 4- Tidy the simple tibble below. Do you need to make it wider or longer? What are the variables?
  
  preg <- tribble(
    ~pregnant, ~male, ~female,
    "yes",     NA,    10,
    "no",      20,    12
  )
# Answer: It is untidy as each variable must have its own column - we need to do pivot longer 
  preg_tidy <- preg %>%
    pivot_longer(c(male, female), names_to = "sex", values_to = "count")
  

# 12.4.3 Exercises --------------------------------------------------------

# 1- What do the extra and fill arguments do in separate()? 
# Experiment with the various options for the following two toy datasets.
  
  tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
    separate(x, c("one", "two", "three"))
#  extra = "merge", then the extra values will be merged (try to replace merge with drop)
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
    separate(x, c("one", "two", "three"), extra = "merge")
  
  tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
    separate(x, c("one", "two", "three"))
  
# fill = to fill with missing values from the right. (try to replace right with left)
  tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
    separate(x, c("one", "two", "three"), fill = "right")
  
# 2 - Both unite() and separate() have a remove argument. What does it do?
# Why would you set it to FALSE?

# Answer: The remove argument discards input columns in the result data frame. 
#You would set it to FALSE if you want to create a new variable, but keep the old one.
  
# 3- Compare and contrast separate() and extract().
# Why are there three variations of separation (by position, by separator, and with groups),
# but only one unite? 
  table3
  # The function separate(), splits a column into multiple columns by separator
  table3 %>% 
    separate(rate, into = c("cases", "population"), convert = TRUE) 
  # The function extract() uses a regular expression to specify groups in character vector 
  # and split that single character vector into multiple columns
  tibble(x = c("X1", "X20", "AA11", "AA2")) %>%
    extract(x, c("variable", "id"), regex = "([A-Z]+)([0-9]+)")  
  
  

# 12.5.1 Exercises --------------------------------------------------------

# 1-  Compare and contrast the fill arguments to pivot_wider() and complete().
  
  stocks <- tibble(
    year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
    qtr    = c(   1,    2,    3,    4,    2,    3,    4),
    return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
  )
  stocks %>% 
    complete(year, qtr, fill=list(return=0))
  
# 2-  What does the direction argument to fill() do?  
  
  treatment <- tribble(
    ~ person,           ~ treatment, ~response,
    "Derrick Whitmore", 1,           7,
    NA,                 2,           10,
    NA,                 3,           9,
    "Katherine Burke",  1,           4
  )
  
  treatment %>% 
    fill(person)
  
  # fill() takes a set of columns where you want missing values to be replaced by 
  # the most recent non-missing value  (sometimes called last observation carried forward).
  
  

  
  
