### libraries
library(dplyr)

### Load Data
df = read.csv("./dataset/co_e.csv", header = TRUE, sep = ",", dec = ".")

### Config data
df = df[,-c(1:5)] # remove columns 

df =  df %>% # group data
      group_by(Flow_desc,Year) %>%
      summarise(sm = sum(Value))

import = df[38:74,] 
export = df[1:37,]
year = c(1980:2016)

df = data.frame(Years = year, Import = import$sm, Export = export$sm)

format(c(df$Import,df$Export),big.mark=",",scientific=FALSE)

### Insert Variation % gain

df = mutate(df, saldo = Export - Import)

### Plot
plot = plot(year, df$Import, type = "l", 
            main = "Balança Comercial - Brazil", 
            sub = "1980-2016",
            col = "red",
            ylab = "Valores em USD",
            xlab = "Ano")
lines(year,df$Export)

### Export Data
write.csv(df, file="./export/df.csv")




