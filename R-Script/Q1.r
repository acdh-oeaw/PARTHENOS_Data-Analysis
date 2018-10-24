library(SPARQL)
library(ggplot2)
library(reshape)
library(scales)
endpoint <- "https://virtuoso.parthenos.d4science.org/sparql"

#Q4 -  List of classes with COUNT

q <- " SELECT DISTINCT ?c (count(?c) as ?count)
   WHERE {
     GRAPH ?g
       {[] a ?c .}
   FILTER regex(?g, 'clarin') }
GROUP BY ?c
ORDER BY DESC (?count)
  "

res <- SPARQL(url=endpoint, q)$results


ggplot(res, aes(x=reorder(c, -count), 
y=count, fill=c)) + theme_bw() + geom_bar(stat='identity') + 
theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) + 
ggtitle('List of classes with COUNT') + 
labs(x='Classes', y='Numbers of classes') + theme(legend.position='none')