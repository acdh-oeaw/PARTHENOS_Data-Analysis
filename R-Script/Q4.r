library(SPARQL)
library(ggplot2)
library(reshape)
library(scales)

endpoint <- "https://virtuoso.parthenos.d4science.org/sparql"

#Q4 - all used Subject types + frequencies

q <- " SELECT  ?type (COUNT(?type) as ?typeCount)
  WHERE {[] a ?type}
  GROUP BY ?type
ORDER BY DESC(?typeCount)
LIMIT 10
  "

res <- SPARQL(url=endpoint, q)$results


ggplot(data = res, aes(x=reorder(type, -typeCount), 
y=typeCount, fill=type)) + theme_bw() + geom_bar(stat='identity') + 
theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) + 
ggtitle(' All used Subject types + frequencies - LIMIT 10') + 
labs(x='Subject', y='Frequency') + 
theme(legend.position='none') 




