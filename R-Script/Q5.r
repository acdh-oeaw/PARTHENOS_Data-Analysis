library(SPARQL)
library(ggplot2)
library(reshape)
library(scales)

endpoint <- "https://virtuoso.parthenos.d4science.org/sparql"

#Q4 - all used Subject types + frequencies

q <- " 	select distinct ?class count(distinct ?instanceURI)
( GROUP_CONCAT(distinct ?class_labelX, \"/\") as ?class_label)
where{
graph ?gRecord  {
?instanceURI a ?class.
}

optional{
?class rdfs:label ?class_labelX.
}

GRAPH <provenance> {?gRecord <dnetcollectedFrom> ?api . ?api <dnetisApiOf> \"PARTHENOS\"^^<http://www.w3.org/2001/XMLSchema#string>}
}
group by ?class
order by ?class
"

res <- SPARQL(url = endpoint, q)$results


ggplot(data = res, aes(
  x = factor(1),
  y = class,
  fill = factor(class)
)) + geom_bar(width = 1, stat = "identity") + coord_polar(theta = "y")

