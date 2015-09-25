require(tidyr)
require(dplyr)
require(extrafont)
require(ggplot2)

tbl_df(df)
View(df)

# Social and Economic Context : Euribor & CPI
ahp <- df %>% select(EURIBOR3M, CONS_PRICE_IDX, Y) %>% arrange(Y)

ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Portuguese Bank Marketing Campaign Effectiveness') +
  labs(x="Euribor", y=paste("Consumer Price Index")) +
  layer(data=ahp, 
        mapping=aes(x=as.numeric(EURIBOR3M), y=as.numeric(CONS_PRICE_IDX), color=Y), 
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )
