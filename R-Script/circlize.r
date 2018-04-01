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

#par(mar = c(0.01, 0.01, 0.01, 0.01)) # Set the margin on all sides to 6
par( cex= 0.5 )

chordDiagram(res, annotationTrack = c("grid", "axis"), preAllocateTracks = list(track.height = 0.5)) 

circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y)  {
    xlim = get.cell.meta.data("xlim")
    xplot = get.cell.meta.data("xplot")
    ylim = get.cell.meta.data("ylim")
    sector.name = get.cell.meta.data("sector.index")
   
    circos.text(mean(xlim), 0, sector.name,  cex = 0.7, 
         facing = "clockwise", niceFacing = TRUE, adj = c(0,0))
   
        
}, bg.border = NA) # here set bg.border to NA is important



circos.clear()

