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


ggplot(res, aes(x = type, y = typeCount,  fill = typeCount, label = type)) +

  geom_col() +

  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +

  scale_fill_gradient(low = "blue", high = "red", name = "TypeCount", labels = comma) +

  ylim(c(0, 1000000)) +

  ggtitle("Q4 - all used Subject types + frequencies") +

    theme(plot.title = element_text(hjust = 0.5))


