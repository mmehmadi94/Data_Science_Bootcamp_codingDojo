# https://r4ds.had.co.nz/data-visualisation.html

# visualistion data using ggplot2. one of the core members of the tidyverse. 
library(tidyverse)

# 3.2.4 Exercises ---------------------------------------------------------


# Run ggplot(data = mpg). What do you see?
ggplot(data = mpg) # empty plot 

# How many rows are in mpg? How many columns?
nrow(mpg)
ncol(mpg)
dim(mpg)
# What does the drv variable describe?
# Read the help for ?mpg to find out.
?mpg
# drv values f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# Make a scatterplot of hwy vs cyl.
ggplot(data=mpg) + 
  geom_point(mapping= aes(x=hwy , y= cyl))

# What happens if you make a scatterplot of class vs drv? 
# Why is the plot not useful?
ggplot(data=mpg) + 
  geom_point(mapping= aes(x=class , y= drv))

# Scatter plot is the best to showl the relationship 
# between two quantitative variables


# 3.3.1 Exercises ---------------------------------------------------------

# 1- What’s gone wrong with this code? Why are the points not blue?
  ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
# The points are not blue, because the color layer is specified within the aes mappings. 

# 2- Which variables in mpg are categorical? Which variables are continuous? (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg?
  
head(mpg, 1)
# <chr> [characters] are likely to be categorical, whereas <dbl> [double] and <int> [integer] are likely to be continuous.

# 3- Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?

# An aesthetic is a visual property of the objects in your plot. 
# Aesthetics include things like the size, the shape, or the color of your points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = manufacturer))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ, size= cyl , shape= drv))
# continuous variable can not be mapped to shape
# For continuous variables a scale is shown, otherwise the category names.

# 4- What happens if you map the same variable to multiple aesthetics?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl, size= cyl))
# both layers are applied.

# 5-  What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
?geom_point
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl, stroke= 5))
# The stroke aesthetic seems to adjust the plotted object thickness.

# 6- What happens if you map an aesthetic to something other than a variable name,
# like aes(colour = displ < 5)? Note, you’ll also need to specify x and y.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5 ))
# + comes at the end of the line



# 3.5.1 Exercises ---------------------------------------------------------


# split your plot into facets is useful for categorical variables
# To facet your plot by a single variable, use facet_wrap()
# To facet your plot by two variables, use facet_grid()

# 1- What happens if you facet on a continuous variable?
# There is one facet for each value e.g. a facet on cyl

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cyl, nrow = 2)

# 2- What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 
# How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
# The facets are empty when there is no data for the according combination e.g. rear wheel drive (r) with 4 or 5 cylinder

# 3- What plots does the following code make? What does . do?
  # not facet in the rows or columns dimension

# The facets for drv  as rows
  ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
  
# The facets for cyl  as columns
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# 4- Take the first faceted plot in this section:
  
  ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
  
# What are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages?
# How might the balance change if you had a larger dataset?
 
  # With faceting it is easier to examine the indivual classes. 
 #  With coloring it is easier to see how the classes are clustered overall.
 #  With larger datasets it’s more likely that you want to see the overall 
 # clustering instead of the individual point clouds.
  
  
# 5- Read ?facet_wrap. What does nrow do? What does ncol do? 
# What other options control the layout of the individual panels? 
# Why doesn’t facet_grid() have nrow and ncol arguments?
  
  #  Number of rows and columns
  # Facet grids do not have these configuration because the rows and cols are
  # determined by the specified attributes (variables).
  
# 6- When using facet_grid() you should usually put the variable with more unique 
# levels in the columns. Why?

  # When putting the more levels on the row axis, then the y-axis would shrink
  # so that it is harder to see which actual values are at the points as shown 
  # in the plot.
  
  
  

# 3.6.1 Exercies ----------------------------------------------------------

# 1- What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
  # geom_bar, geom_histogram , geom_area()
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_smooth()
  
# 2-  Run this code in your head and predict what the output will look like. 
# Then, run the code in R and check your predictions.

   ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
     geom_point() + 
     geom_smooth(se = FALSE)
# grouped by color 
   
# 3- What does show.legend = FALSE do? What happens if you remove it?
#   Why do you think I used it earlier in the chapter?
   
   # remove legend from the chart 
   
# 4-  What does the se argument to geom_smooth() do?
    # shows the grey area
   
# 5-  Will these two graphs look different? Why/why not?
     
    ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
     geom_point() + 
     geom_smooth()
   
   ggplot() + 
    geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
     geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
   
   # same plot .. second plot inherits the configuration from ggplot.
   
# 6- Recreate the R code necessary to generate the following graphs.
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
     geom_point(mapping = aes(stroke = 2)) + 
     geom_smooth(se = FALSE) 

  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(stroke = 2)) + 
    geom_smooth(se = FALSE, mapping = aes(group = drv) ) 
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
    geom_point(mapping = aes(stroke = 2)) + 
    geom_smooth(se = FALSE) 
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(stroke =2 , color = drv)) + 
    geom_smooth(se = FALSE) 
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color=drv)) +
    geom_smooth(se = FALSE, mapping = aes(linetype = drv))
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color=drv)) + 
    geom_point(shape = 21, color = "white", stroke = 1)
  
# theme_set(theme_gray())
# plot_grid (p1, p2, p3, p4, p5, p6, labels=c("1","2","3", "4","5","6"), ncol=2, nrow = 3)

  
# 3.7.1 Exercises ---------------------------------------------------------
 
  # 1- What is the default geom associated with stat_summary()? How could you rewrite the previous plot to use that geom function instead of the stat function?
  ggplot(data = diamonds) + 
    stat_summary(
      mapping = aes(x = cut, y = depth),
      fun.ymin = min,
      fun.ymax = max,
      fun.y = median
    )
  
  ggplot(data = diamonds) +
    geom_pointrange(
      mapping = aes(x = cut, y = depth),
      stat = "summary",
      fun.min = min,
      fun.max = max,
      fun = median
    )
  
 # 2- What does geom_col() do? How is it different to geom_bar()?
#  What is the problem with this plot? How could you improve it?
  
  ggplot(data = diamonds, mapping = aes(x = cut, y = depth)) + 
    geom_col()
  # geom_col need x and y 
  
 # 3- Most geoms and stats come in pairs that are almost always used in concert.
  #Read through the documentation and make a list of all the pairs. What do they have in common?
#  geom_col() = stat_count()

 # 4- What variables does stat_smooth() compute? What parameters control its behaviour?
   ?stat_smooth()
  
  ggplot(data = diamonds, mapping = aes(x = table, y = price)) + 
    stat_smooth(se=FALSE)
 
  # 5- In our proportion bar chart, we need to set group = 1. Why?
  # In other words what is the problem with these two graphs?
   
    ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, y = ..prop..))
    
  ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group = 1))

  
  
# 3.8.1 Exercises ---------------------------------------------------------

# 1 - What is the problem with this plot? How could you improve it?
    
    ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
    geom_point()
  
  # The values of hwy and cty are rounded so the points appear on a grid and many points overlap each other.
  # This problem is known as overplotting. 
  # This arrangement makes it hard to see where the mass of the data is
  # position = "jitter" adds a small amount of random noise to each point.  
  #This spreads the points out because no two points are likely to receive the same amount of random noise.
  # position = "jitter" adds a small amount of random noise to each point, to avoid overplotting points
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
    geom_point(  position = "jitter")
  
  
# 2-  What parameters to geom_jitter() control the amount of jittering?

  #width controls the amount of horizontal displacement, and
  # height controls the amount of vertical displacement.
  #  geom_jitter() see the difference btween two plots below 
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_jitter(width = 0)
  
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_jitter(width = 3)
  
# 3- Compare and contrast geom_jitter() with geom_count().
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_jitter()
  
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_count()
  # The geom geom_count() sizes the points 
  
# 4- What’s the default position adjustment for geom_boxplot()? 
# Create a visualisation of the mpg dataset that demonstrates it.
  
  ggplot(data = mpg) + 
    geom_boxplot(mapping = aes(x = `class`, y = displ, colour = class))
  
  
  
  
  
  
  