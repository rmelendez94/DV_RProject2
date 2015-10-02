require(tidyr)
require(dplyr)
require(extrafont)
require(ggplot2)
# Uncomment the following to view the original data
# tbl_df(df)
# View(df)

# This shows only those who fall below the 40th and above the 90th percentile for call duration during the Marketing campaign
pd <- df %>% mutate(DURATIONPERCENT = ntile(DURATION, 100)) %>% arrange(DURATIONPERCENT) %>% select(POUTCOME, DURATION, Y, DURATIONPERCENT) %>% filter(DURATIONPERCENT < 20 | DURATIONPERCENT > 80) 
#View(pd) # Uncomment to view the results

#This shows below the 20th percentile for call duration during the Marketing campaign 
npd <- df %>% mutate(DURATIONPERCENT = ntile(DURATION, 100)) %>% arrange(DURATIONPERCENT) %>% select(POUTCOME, DURATION, Y, DURATIONPERCENT) %>% filter(DURATIONPERCENT < 20) 
#View(npd) # Uncomment to view the results

#This shows above the 80th percentile for call duration during the Marketing campaign 
ypd <- df %>% mutate(DURATIONPERCENT = ntile(DURATION, 100)) %>% arrange(DURATIONPERCENT) %>% select(POUTCOME, DURATION, Y, DURATIONPERCENT) %>% filter(DURATIONPERCENT > 80) 
#View(ypd) # Uncomment to view the results

# Create the Point Plot; POUTCOME/DURATION lower percentile
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  facet_grid(Y~.) +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness 
       (Percentile < 40th & Percentile > 90)') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=pd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME), color=Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(alpha=.8), 
        position=position_jitter(width=0, height=0.3)
  )

# Create the Point Plot; POUTCOME/DURATION Below 20th Percentile
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  facet_grid(Y~.) +
  labs(title='Marketing Effectiveness (Percentile < 40th)') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=npd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME), color = Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(alpha=.55), 
        position=position_jitter(width=0, height=0.3)
  )

# Create the Point Plot; POUTCOME/DURATION Above 80th Percentile 
ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_discrete() +
  facet_grid(Y~.) +
  labs(title='Marketing Effectiveness (Percentile > 80th)') +
  labs(x="Duration", y=paste("Past Marketing Effectiveness")) +
  layer(data=ypd, 
        mapping=aes(x=as.numeric(as.character(DURATION)), y=as.character(POUTCOME), color = Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(alpha=.55), 
        position=position_jitter(width=0, height=0.3)
  )
