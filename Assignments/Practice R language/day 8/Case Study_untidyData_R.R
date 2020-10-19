# The tidyr::who dataset contains tuberculosis (TB) cases broken down by
# year, country, age, gender, and diagnosis method.

df <- who


# The first three letters of each column denote whether the column contains new or old cases of TB.
# In this dataset, each column contains new cases.
 
# The next two letters describe the type of TB:
# rel stands for cases of relapse
# ep stands for cases of extrapulmonary TB
# sn stands for cases of pulmonary TB that could not be diagnosed by a pulmonary smear (smear negative)
# sp stands for cases of pulmonary TB that could be diagnosed by a pulmonary smear (smear positive)
# The sixth letter gives the sex of TB patients. The dataset groups cases by males (m) and females (f).
 
# The remaining numbers gives the age group. The dataset groups cases into seven age groups:
# 014 = 0 – 14 years old
# 1524 = 15 – 24 years old
# 2534 = 25 – 34 years old
# 3544 = 35 – 44 years old
# 4554 = 45 – 54 years old
# 5564 = 55 – 64 years old
# 65 = 65 or older

# new_sp_m014:newrel_f65 columns are values not variables. 
df <- df %>% 
  pivot_longer(
    cols = new_sp_m014:newrel_f65, 
    names_to = "key", 
    values_to = "cases", 
    values_drop_na = TRUE
  )

# some values in key feature are new_ep_f014 and some newrel_f1524. so, we need to consolidate that
df <- df %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))

df <- df %>% 
  separate(key, c("new", "type", "sexage"), sep = "_") # ex: new_sp_m014 = new , type=sp , sexage = m014

#drop the new column as well iso2 and iso3 since they’re redundant.
df <- df %>% 
  select(-new, -iso2, -iso3)


# separate sexage into sex and age by splitting after the first character:
df <- df %>% 
  separate(sexage, c("sex", "age"), sep = 1)


# The who dataset is now tidy!

# For each country, year, and sex compute the total number of cases of TB.
# Make an informative visualization of the data.


df %>%
  group_by(country, year, sex) %>%
  filter(year > 1995) %>%
  summarise(cases = sum(cases)) %>%
  unite(country_sex, country, sex, remove = FALSE) %>%
  ggplot(aes(x = year, y = cases, group = country_sex, colour = sex)) +
  geom_line()
#> `summarise()` regrouping output by 'country', 'year' (override with `.groups` argument)









