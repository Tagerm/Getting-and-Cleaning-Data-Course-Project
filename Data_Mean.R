##DATABASE MEAN

library(plyr)
library(reshape2)
melted <- melt(data, id.vars = c("subject", "activities"))
meandata <- ddply(melted, c("subject", "activities", "variable"), summarise,
                  average = mean(value))
write.table(meandata, file = "./Data_Average.txt", row.names = F)      
