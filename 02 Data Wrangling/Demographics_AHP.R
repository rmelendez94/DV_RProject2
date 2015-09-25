require(tidyr)
require(dplyr)


tbl_df(df)
View(df)

ahp <- df %>% select(AGE, HOUSING, LOAN, Y) %>% arrange(Y) %>% mutate()


require(extrafont)
require(ggplot2)

#Create the Point Plot; Loan/Age
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  facet_grid(LOAN~HOUSING, labeller=label_both) +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness') +
  labs(x="Age", y=paste("Has Other Loans")) +
  layer(data=ahp, 
        mapping=aes(x=as.numeric(as.character(AGE)), y=as.character(LOAN), color=Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )
