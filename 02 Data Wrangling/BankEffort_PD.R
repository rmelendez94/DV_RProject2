require(tidyr)
require(dplyr)
require(extrafont)
require(ggplot2)

tbl_df(df)
View(df)

pd <- df %>% select(POUTCOME, DURATION, Y)
#View(pd)
ypd <- df %>% select(POUTCOME, DURATION, Y) %>% filter(Y=="yes")
#View(ypd)
npd <- df %>% select(POUTCOME, DURATION, Y) %>% filter(Y=="no")
#View(npd)

#Create the Point Plot; POUTCOME/DURATION
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
        geom_params=list(), 
        position=position_jitter(width=0, height=0.3)
  )

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
        geom_params=list(), 
        position=position_jitter(width=0, height=0.3)
  )

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
        geom_params=list(), 
        position=position_jitter(width=0, height=0.3)
  )
