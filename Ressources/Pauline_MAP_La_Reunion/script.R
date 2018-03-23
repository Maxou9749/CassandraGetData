library(raster)
library(rasterVis)
library(latticeExtra)
library(sp)
# 
run_contours <- spTransform(x = shapefile("./departement/DEPARTEMENT"), 
                            CRSobj = CRS("+proj=longlat +datum=WGS84")) #Projection longlat
# 
data_to_plot <- stack("dem.tif")
# 
lvp_mapmean <- levelplot(data_to_plot, 
                         colorkey = list(width = 2,
                                         height = 1,
                                         space = 'right', 
                                         # title = expression(paste("W.", m^2), sep=""),
                                         title = "mètres",
                                         axis.line = list(col = 'black')),
                         border = "transparent",
                         margin = FALSE,
                         scales = list(cex = 0.7)) 
# 
lvp_mapmean <- lvp_mapmean + 
  latticeExtra::layer(sp.lines(run_lim, lwd = 2, col = 'black'))
# 
lvp_mapmean
# 
