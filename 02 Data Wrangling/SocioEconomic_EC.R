require(tidyr)
require(dplyr)
require(extrafont)
require(ggplot2)

# Social Factors : Age, Education, Marital Status
#################################################################
SE_1 <- df %>% select(EDUCATION, AGE, Y) %>% filter(EDUCATION!="unknown", EDUCATION!="illiterate") %>% arrange(Y)
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness') +
  labs(x=paste("EDUCATION"), y="AGE") +
  layer(data=SE_1, 
        mapping=aes(x=as.character(EDUCATION), y=as.numeric(AGE), color=Y),
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )
#################################################################
SE_2 <- df %>% select(MARITAL, AGE, Y) %>% filter(MARITAL!="unknown") %>% arrange(Y)
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness') +
  labs(x=paste("MARITAL STATUS"), y="AGE") +
  layer(data=SE_2, 
        mapping=aes(x=as.character(MARITAL), y=as.numeric(AGE), color=Y),
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )
#################################################################
df %>% group_by(Y, MARITAL,EDUCATION) %>% filter(EDUCATION!="unknown", MARITAL!="unknown", EDUCATION!="illiterate", AGE <="65", AGE>= "10")  %>% summarise(mean_age = mean(AGE)) %>% ggplot(aes(x=MARITAL, y=mean_age, color=Y)) + geom_point() + facet_wrap(~EDUCATION)
