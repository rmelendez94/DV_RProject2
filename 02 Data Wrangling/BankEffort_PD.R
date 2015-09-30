require(tidyr)
require(dplyr)
require(extrafont)
require(ggplot2)
# Uncomment the following to view the original data
# tbl_df(df)
# View(df)

# This shows the 40th percentile and below for call duration during the Marketing campaign
pd <- df %>% mutate(DURATIONPERCENT = ntile(DURATION, 100)) %>% arrange(DURATIONPERCENT) %>% select(POUTCOME, DURATION, Y, DURATIONPERCENT) %>% filter(DURATIONPERCENT < 40) 
#View(pd) # Uncomment to view the results

# This shows the 90th percentile and above for call duration during the Marketing campaign
pdn <- df %>% mutate(DURATIONPERCENT = ntile(DURATION, 100)) %>% arrange(DURATIONPERCENT) %>% select(POUTCOME, DURATION, Y, DURATIONPERCENT) %>% filter(DURATIONPERCENT > 80) 
#View(pdn) 

npd <- df %>% mutate(DURATIONPERCENT = ntile(DURATION, 100)) %>% arrange(DURATIONPERCENT) %>% select(POUTCOME, DURATION, Y, DURATIONPERCENT) %>% filter(Y=="no", DURATIONPERCENT < 40) 
#View(npd) # Uncomment to view the results

#This shows the 90th percentile and above for call duration during the Marketing campaign also filtering only yes
ypd <- df %>% mutate(DURATIONPERCENT = ntile(DURATION, 100)) %>% arrange(DURATIONPERCENT) %>% select(POUTCOME, DURATION, Y, DURATIONPERCENT) %>% filter(Y=="yes", DURATIONPERCENT > 80) 
#View(ypd) # Uncomment to view the results

# Create the Point Plot; POUTCOME/DURATION lower percentile
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness (Percentile < 40th)') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=pd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME), color=Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(alpha=.8), 
        position=position_jitter(width=0, height=0.3)
  )

# Create the Point Plot; POUTCOME/DURATION higher percentile
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness (Percentile > 80th)') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=pdn, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME), color=Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(alpha=.8), 
        position=position_jitter(width=0, height=0.3)
  )

# Create the Point Plot; POUTCOME/DURATION with only no filtered 
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  labs(title='Term Loan Failure (Percentile < 40th)') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=npd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME)), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(colour="#CC0000", alpha=.55), 
        position=position_jitter(width=0, height=0.3)
  )

# Create the Point Plot; POUTCOME/DURATION with only yes filtered 
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  labs(title='Term Loan Success (Percentile > 80th)') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=ypd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME)), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(colour="#0033CC", alpha=.55), 
        position=position_jitter(width=0, height=0.3)
  )
