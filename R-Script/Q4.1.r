library(SPARQL)
library(ggplot2)
library(reshape)
library(scales)
endpoint <- "https://virtuoso.parthenos.d4science.org/sparql"

#Q4.1 - Which PE entities are used in CLARIN graphs

q <- "SELECT ?class (count(?s) as ?count)
 WHERE {GRAPH ?g { ?s a ?class}
 FILTER regex(?g, 'clarin')
 FILTER(STRSTARTS(STR(?class), 'http://parthenos.d4science.org/CRMext/CRMpe.rdfs/')) }
GROUP BY ?class 
ORDER BY DESC (?count)
  "

res <- SPARQL(url=endpoint, q)$results


ggplot(res, aes(x=reorder(class, -count), 
y=count, fill=class)) + theme_bw() + geom_bar(stat='identity') + 
theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) + 
ggtitle(' Which PE entities are used in CLARIN graphs') + 
labs(x='Classes', y='Frequency') + theme(legend.position='none')


