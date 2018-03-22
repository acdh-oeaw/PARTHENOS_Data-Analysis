library(ggplot2)
library(ggalluvial)
library(SPARQL)
library(ggrepel)
library(ggfittext)

endpoint <- "https://virtuoso.parthenos.d4science.org/sparql"

#Enumerate classes linked from a given class and predicates that link instances of the given class and the target classes.

q <- " 
SELECT ?p ?c (COUNT(?p) AS ?pc) {
  ?f a <http://parthenos.d4science.org/CRMext/CRMpe.rdfs/PE13_Software_Computing_E-Service> .
  ?t a ?c .
  ?f ?p ?t .
  FILTER(?c != owl:Class)
} GROUP BY ?p ?c


  "

res <- SPARQL(url=endpoint, q)$results



ggplot(data = res,
       aes(axis1 = c, axis2 = p, axis3 = pc,
           weight = pc)) +
  scale_x_discrete(limits = c("c", "p","pc"), expand = c(.0, .0), labels = c("Classes", "Properties", "PC")) +
  geom_alluvium(aes(fill = as.factor(pc),), width = 1/5, discern = FALSE) +
 
  geom_stratum(width = 1/5,color = "grey") +
 
  geom_text_repel(stat = "stratum", size = 3, label.strata = TRUE) +

   ggtitle("PE13 Enumerate classes linked from a given class and predicates that link", 
   "instances of the given class and the target classes.") +
 
  theme_minimal() +
  theme(
    legend.position = "bottom",
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_text(size = 18, face = "bold")
  )