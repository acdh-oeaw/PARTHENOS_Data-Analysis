library(SPARQL)
library(ggplot2)
library(reshape)
library(scales)
endpoint <- "https://virtuoso.parthenos.d4science.org/sparql"

#Q2 -   Number of triples per CLARIN graph

q <- "SELECT  ?class (count(?s) as ?count)
 WHERE {GRAPH ?g { ?s a ?class}
 FILTER regex(?g, 'clarin') }
GROUP BY ?class 
ORDER BY DESC (?count)
  "

res <- SPARQL(url=endpoint, q)$results


ggplot(res, aes(x=reorder(class, -count), 
y=count, fill=class)) + theme_bw() + geom_bar(stat='identity') + 
theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) + 
ggtitle('Which classes are in use + frequency') + 
labs(x='Classes', y='Frequency') + theme(legend.position='none')


