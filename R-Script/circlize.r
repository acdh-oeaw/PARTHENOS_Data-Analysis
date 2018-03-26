library(circlize)
library(SPARQL)


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
 


chordDiagram(res, annotationTrack = c("grid", "axis"), preAllocateTracks = list(track.height = 0.3)) 
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
xlim = get.cell.meta.data("xlim")
ylim = get.cell.meta.data("ylim")
sector.name = get.cell.meta.data("sector.index") 
circos.text(mean(xlim), ylim[1], sector.name, facing = "clockwise",
niceFacing = TRUE, adj = c(0, 0.5)) }, bg.border = NA)







