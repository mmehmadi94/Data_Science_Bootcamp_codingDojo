

#         p(y=0)  p(y=5) p(y=10) p(y=15)  total
# p(x=0)  0.02    0.06    0.02    0.10    0
# p(x=5)  0.04    0.15    0.20    0.10    0
# p(x=10) 0.01    0.15    0.14    0.01    0
# total   0       0       0       0       0
p <- matrix(c(.02,.04,.01,.06,.15,.15,.02,.20,.14,.10,.10,.01), ncol = 4)
p

# Computing marginals probabilites
# sum of all the elements in each raw/ccolumn of matrix p 

calculate_condprobability_x5_y5 <- function(){
  
  py <- apply(p, 1, sum) # 1 rows
  px <- apply(p, 2, sum) # 2 = columns
  p <- cbind(p, py)  
  p <- rbind(p, px)  
  p
  con_x5_y5 <- p[2,2]/py[2,5] # p(x=5 | y=5)= 0.15/0.49 = 0.306
  con_x5_y5
}

calculate_condprobability_x5_y5()
