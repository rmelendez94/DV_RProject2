require(tidyr)
require(dplyr)
require(extrafont)
require(ggplot2)
# Uncomment the following to view the original data
# tbl_df(df)
# View(df)

# This shows how many total people had the same duration and past outcome, ex: 2 poeple with past failure and duration of 6 and said no to current term loan
pd <- df %>% select(POUTCOME, DURATION, Y) %>% group_by(POUTCOME, DURATION, Y) %>% summarise(NumInCategory=n()) %>% arrange(DURATION)
#View(pd) # Uncomment to view the results
ypd <- df %>% select(POUTCOME, DURATION, Y) %>% filter(Y=="yes") 
#View(ypd) # Uncomment to view the results
npd <- df %>% select(POUTCOME, DURATION, Y) %>% filter(Y=="no")
#View(npd) # Uncomment to view the results

# Create the Point Plot; POUTCOME/DURATION
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=pd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME), color=Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(alpha=.8), 
        position=position_jitter(width=0, height=0.3)
  )

# Create the Point Plot; POUTCOME/DURATION with only yes filtered 
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  labs(title='Term Loan Success') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=ypd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME)), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(colour="#0033CC", alpha=.55), 
        position=position_jitter(width=0, height=0.3)
  )

# Create the Point Plot; POUTCOME/DURATION with only no filtered 
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  labs(title='Term Loan Failure') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=npd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME)), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(colour="#CC0000", alpha=.55), 
        position=position_jitter(width=0, height=0.3)
  )
