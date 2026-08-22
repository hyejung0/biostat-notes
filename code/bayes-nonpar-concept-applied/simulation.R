#This file gives R code that runs all simulation in 
#this folder. I grabbed them from README.txt file and make it 
#compartible with R script. 


# Run this script from the repository root, then set the working directory to this code folder.
setwd("./code/bayes-nonpar-concept-applied")

# Ex1: beta distribution --------------------------------------------------


# Load the functions for Example 1:
source("ex1_beta.R")

# Draw a random distribution using a beta random variable
# with parameters (1,1).
# Keep pressing enter to get more iid beta random variables.
# Press "x" and then enter when you're done.
ex1_draw_betas(1)

# The plot title may be misleading. 
#The beta(a1,a1)gives me distribution of rho1. In the plot, rho 2 is being plotted as 1-rho1.

#with a1=a2=1, rho1 is a uniform draws. Thus, rho2=1-rho1 is also uniform draw.
# ex) 
# sometimes (rho1, rho2) = (0.9, 0.1)
# sometimes (rho1, rho2) = (0.2, 0.8)
# sometimes (rho1, rho2) = (0.5, 0.5)
# The draws of the distribution vary a lot
# The distribution itself is highly random.

# Choose a very small parameter tuple
ex1_draw_betas(0.01)
# The probability of rho1 is very extreme. Either near 0 or near 1. So that 
# will appear in the plotting.

# Choose a very large parameter tuple
ex1_draw_betas(1000)
# more even distribution. In fact, it's the uniform distribution. 
# See, we are using the rho1 and rho2 as parameters of the categorical distribution
# So the categorical(rho1, rho2) is random
# She's randomly drawing the parameters of categorical distribution
# when she's drawing rhos. 
# with beta(1000, 1000), mathematically, we have mean 0.5
# and variance = 1/(8*2000) -> extremely small.
# So very single time I draw from beta(1000, 1000), 
# I will only have (rho1, rho2) \approx (0.5, 0.5)
# I'm still drawing a random categorical distribution
# But almost every draw is the same distribution. 


#therefore, :
#Beta(1,1)
# -> maximally uncertain prior over categorical distributions
#Beta(a,a), a >> 1
# -> prior concentrates on the uniform categorical distribution


# This intuition generalizes directly to the Dirichlet process:
#   Small concentration -> sparse, extreme allocations
#   Large concentration -> nearly uniform mass across components
#   Infinite-dimensional limit -> controlled growth of clusters
# That is why she is emphasizing this point so carefully.



# Note: though we didn't cover it in the tutorial,
# you can use the function "ex1_draw_betas_diffa"
# to draw random distributions using both beta parameters.
# e.g. > ex1_draw_betas_diffa(0.1,10)

# If we have different a1 and a2 values
# smaller a1 will make rho1 small
ex1_draw_betas_diffa(a1=1,a2=5) #smaller rho1




# Ex2: Dirichlet distn ----------------------------------------------------


# Load the functions for Example 2.
# Note: you may need to install the MCMCpack package first: > install.packages("MCMCpack")
source("ex2_diri.R")

# Draw a random distribution using a Dirichlet random variable
# with all parameters 1.
# Keep pressing enter to get more iid Dirichlet random variables.
# Press "x" and then enter when you're done.
ex2_draw_diris(K=4,a_scalar=1)
# This draws random probability vector of length 4
# All paramters of Dirichlet is 1. 
# Then it is uniform on the vector level, not each rho
# because here, you can intuitively think of rho1 from this 
# distribution is drawn from beta(1, 3). 
# This whole thing is uniform over simplex.


# Choose a very small shared parameter
ex2_draw_diris(K=4,a_scalar=0.01)
# IF all parameters are small, then we will assign all mass to one of the rhos.


# Choose a very large shared parameter
ex2_draw_diris(K=4,a_scalar=1000)
#Again, if the paramters are large, we will gnenerate uniform categorical distributions.

# 
# Note: though we didn't cover it in the tutorial,
# you can use the function "ex2_draw_diris_diffa"
# to draw random distributions using different Dirichlet parameters.
# e.g. > ex2_draw_diris_diffa(c(1,3,5,2))




# Ex3: large K distn ------------------------------------------------------

# Load Example 3.
# Draw a Dirichlet distribution with large K.
source("ex3_largeK_distr.R")
# Press enter to keep making draws from the random distribution.
# Press "x" and then enter when you're done.
# To repeat the default settings:
set.seed(4)
ex3_gen_largeK_diri(K=1000,a=0.01)
#So I draw rhos1,...,rhok
#There are thousand of them. Even though it may be too small for you to see them all..
#And then for each iteration, I draw a categorical for cluster assignment.
#I draw from a uniform (0,1). I put that down on the plot. That's the red arrow. 
# Wherever that arrow sits in is my cluster.

# Stop running at N=88.
# Ask people.
# Did I fill up most of the "components"? 
# No! we have filled at most 88 components out of 1000
#It's just that the rest of components are so small that it's hard to visualize.

#The number of components being filled in tersm of the 
#number of samples is log (N). That's the formula you see in Walker's paper. 
#proceed to the next example, ex4, instead of running below examples.


# For larger a, try:
ex3_gen_largeK_diri(K=1000,a=1)
# For smaller a, try:
ex3_gen_largeK_diri(K=1000,a=0.001)
# 
# Note: in the tutorial we tried out different values
# of a. Although we didn't cover it in the tutorial,
# you can use the function "ex3_gen_largeK_diri"
# to also try out different values of K.



# Ex4: large K count ------------------------------------------------------

# Load Example 4.
# Look at the cluster assignments according to a Dirichlet distribution with large K.
source("ex4_largeK_count.R")
# Press enter to keep making draws from the random distribution.
# Press "x" and then enter when you're done.



ex4_gen_largeK_count(K=1000,a=0.01)

#I'm plotting cluster assignment on the y axis
#and sample number on x.
#The process is same as the previous example. 
#I've randomly drawn a dirichlet distribution of 1000 probabilities.
#If I make a uniform draw, which cateogory would that draw belong? 
#Just show few and see how the y axis forms log(sample size)

#Two key points:

# 1. even if the rhos were not random, the number of clusters were random. (rhose were fixed after it was drawn once.)
# 2. The number of clusters is growing with growing number of data. 

# Question: What is the asymptotic behaviour of this graph?
# Answer: The number of cluster will reach 1,000 with probability 1.



# Ex5: GEM ----------------------------------------------------------------

# Load the functions for Example 5:
source("ex5_gem.R")
 
# Draw a random distribution with GEM parameter alpha.
# We tried alpha=1,10,100.
ex5_draw_gem(alpha=10)

# Here, we first begin by drawing a draw from beta(1, alpha= 10).
# That's the left most box of the graph
# Then we are doing that again and again and again
# and because these are infinity of probabilities that has to sum to one
# they are going to get smaller and smaller on average.


# What would it look like if we draw GEM(1) instead of GEM(10)? 
# Remember, this means we first draw from beta(1,alpha=1), which makes 
# the draw uniform over 0 and 1. So on average, you are going to have bigger 
# boxes at the beginning.


# Ex6: dpmm ---------------------------------------------------------------


#She said a lot of things that are not possible.
#Two of them are:
  # 1. draw infinity of means
  # 2. draw infinity those rhos
# Because of any of these will take forever.
# What can we possibly do?
# Let's say I want to make draws from this Dirichlet process mixture model.
# I want to draw data from it. What can I do?
# Previously, when she drew in ex 4, she drew 1000 rhos and then drew categorical draws from that distribution.
# Here, I cannot draw rho ne to rho infinity.
# Do it on demand.


# We drew uniform random draw before.. 
# We can do the same thing. 
# Remember the uniform random draws are independent of the rhos.
# So I can first draw a uniform random draw. Keep it.
# Keep drawing rhos (drawing proportions) until the sum of those rhos go past the uniform draw.
# As soon as we cover the uniform random draw, stop drawing the rhos because we don't need it yet.
# And whichever the rho that we stopped at, and its corresponding mean is 
# where the uniform random draw get as assigned to. 

# Load Example 6:
source("ex6_dpmm.R")

set.seed(1)

# Press enter to keep making draws from the DPMM.
# Enter a number to make a larger number of draws at once.
# Press "x" and then enter when you're done.

