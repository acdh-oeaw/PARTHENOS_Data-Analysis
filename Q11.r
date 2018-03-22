
library(tabplot)

library(SPARQL)


endpoint <- "https://virtuoso.parthenos.d4science.org/sparql"

#QNumber of single triples between two nodes

q <- " 
SELECT ?s ?o (COUNT (*) AS ?tNum)
WHERE {
    { ?s ?p ?o }
    UNION
    { ?o ?q ?s }
}
GROUP BY ?s ?o

LIMIT 30


  "

res <- SPARQL(url=endpoint, q)$results

tableplot(res, select = c(s, o,tNum), sortCol = tNum, 

    from = 0, to = 100)
 
 