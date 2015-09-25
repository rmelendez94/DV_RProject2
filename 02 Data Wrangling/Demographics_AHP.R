require(tidyr)
require(dplyr)
require(extrafont)
require(ggplot2)

#tbl_df(df)
#View(df)

#Not sure how to use group_by yet
#ahp <- df %>% group_by(HOUSING, LOAN) %>% summarize()

ahp <- df %>% select(AGE, HOUSING, LOAN, Y) %>% mutate(HASLOAN = ifelse(HOUSING == "yes" | LOAN == "yes", "yes", ifelse(HOUSING == "unknown" | LOAN == "unknown", "unknown", "no")))

#Create the Point Plot; Loan/Age
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  facet_grid(LOAN~HOUSING, labeller=label_both) +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness') +
  labs(x="Has Other Loan(s)", y=paste("Age")) +
  layer(data=ahp, 
        mapping=aes(x=as.character(HASLOAN), y=as.numeric(as.character(AGE)), color=Y, fill = Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(), 
        position=position_jitterdodge(jitter.width = 0.3)
  )
