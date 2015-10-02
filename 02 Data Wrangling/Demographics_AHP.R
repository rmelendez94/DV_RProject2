require(tidyr)
require(dplyr)
require(extrafont)
require(ggplot2)

#tbl_df(df)
#View(df)

ahp <- df %>% select(AGE, HOUSING, LOAN, Y) %>% group_by(HOUSING, LOAN, Y) %>% summarise(medianAge = median(AGE), meanAge = mean(AGE), sdAge = sd(AGE), count = n())

ahp

#function to relabel facet grid label for histogram
result_labeller <- function(var, value){
  value <- as.character(value)
  if (var=="Y") { 
    value[value=="yes"] <- "Campaign Successful"
    value[value=="no"]   <- "Campaign Unsuccessful"
  }
  return(value)
}

#Create the Point Plot; Loan/Age
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_fill_discrete(name = "Campaign Result",
                      breaks = c("yes", "no"),
                      labels = c("Successful", "Unsuccessful")) +
  facet_grid(LOAN~HOUSING~Y, labeller = labeller(Y = result_labeller, LOAN = label_both, HOUSING = label_both)) + 
  labs(title='Age and Campaign Effectiveness Based on Loan History') +
  labs(x="Age", y="Frequency") +
  layer(data=df, 
        mapping=aes(x = AGE, fill = Y),
        stat="bin",
        binwidth = 5,
        geom="histogram")

ggplot() +
  coord_cartesian() +
  scale_x_continuous() +
  scale_fill_discrete(name = "Campaign Result",
                      breaks = c("yes", "no"),
                      labels = c("Successful", "Unsuccessful")) +
  facet_grid(LOAN~HOUSING, labeller=label_both) +
  labs(title ='Density Plot of Age on Campaign Effectiveness') +
  labs(x="Age", y="Density") + 
  layer(data = df,
        mapping = aes(x = AGE, fill=Y),
        stat = "density",
        geom = "density",
        alpha = 0.25)

# relative to those who have personal loans, those who do not have personal loans are more likely to say yes regardless of if they have a housing loan. results may be inconclusive however because there is more data of those who do not have personal loans
