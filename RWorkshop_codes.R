
#### Read the libraries:

library("ggplot2")
library("patchwork")
library("RColorBrewer")
library("astsa")
library("MASS")
library("viridis")

## Geoms and Aesthetic mappings:

### Example: Edgar Anderson's Iris Data

head(iris)

### Building a plot from scratch

p <- ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length))
p

p + geom_point()

p + geom_point(aes(color= Species))

p + geom_point(aes(color= Species, size= Petal.Length))

p + geom_point(aes(shape=Species, size= Petal.Length))

p + geom_point(aes(color= Species, size= Petal.Length, alpha= Petal.Width))

p <- ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length))


#### Adding labels to the plot:

p1<- p + geom_point(aes(color= Species, size= Petal.Length, alpha= Petal.Width)) +
  labs(x = "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       color = "Species",
       size = "Petal Length (cm)",
       alpha = "Petal Width (cm)",
       title = "Measurement of iris",
       subtitle = paste("Fisher's or Anderson's data on measurement of flower: iris"),
       caption = "Data Source: R datasets")

p1

### Adding more geoms:

p+ geom_point()+
  geom_smooth(aes(color = "loess"), method = "loess", se = F) + 
  geom_smooth(aes(colour = "lm"), method = "lm", se = F) +
  labs(color= "Method", x= "Sepal Width (cm)", 
       y = "Sepal Length (cm)", color = "Species",
       title = "Measurements of iris",
       subtitle = paste("Fisher's or Anderson's data on measurement of flower: iris"),
       caption = "Data Source: R datasets")

p+ geom_point()+
  geom_smooth(aes(color = "loess", linewidth=2), method = "loess", se = F) + 
  geom_smooth(aes(colour = "lm", linewidth=2), method = "lm", se = F) +
  labs(colour = "Method")+
  labs(color= "Method", x= "Sepal Width (cm)", 
       y = "Sepal Length (cm)", color = "Species",
       title = "Measurements of iris",
       subtitle = paste("Fisher's or Anderson's data on measurement of flower: iris"),
       caption = "Data Source: R datasets")

p+ geom_point()+
  geom_smooth(aes(color = "loess", linewidth=2), method = "loess", se = T) + 
  geom_smooth(aes(colour = "lm", linewidth=2), method = "lm", se = T) +
  labs(colour = "Method") +
  labs(color= "Method", x= "Sepal Width (cm)", 
       y = "Sepal Length (cm)", color = "Species",
       title = "Measurement of iris",
       subtitle = paste("Fisher's or Anderson's data on measurement of flower: iris"),
       caption = "Data Source: R datasets")


### Histograms

p <- ggplot(iris, aes(Petal.Length))

p1 <- p + geom_histogram() +
  labs(x = "Petal Length (cm)", title = "Histogram of 20 bins")

p2 <- p + geom_histogram(bins=30) +
  labs(x = "Petal Length (cm)", title = "Histogram of 30 bins")

p3 <- p + geom_histogram(bins = 40) +
  labs(x = "Petal Length (cm)", title = "Histogram of 40 bins")

p4 <- p + geom_histogram(bins = 50) +
  labs(x = "Petal Length (cm)", title = "Histogram of 50 bins")

(p1+p2) / (p3+p4) # this is enabled by the patchwork package

p + geom_histogram(aes(fill= Species, alpha= 0.5), bins = 30, 
                   position = "identity")

p + geom_histogram(aes(fill= Species, color= Species, alpha=0.4), position = "identity")+
  labs(x = "Petal Length (cm)", title = "Histogram in position: identity")

p + geom_histogram(aes(fill= Species, color= Species, alpha=0.4), position = "stack")+
  labs(x = "Petal Length (cm)", title = "Histogram in position: stack")

p + geom_histogram(aes(fill= Species, color= Species, alpha=0.4), position = "dodge")+
  labs(x = "Petal Length (cm)", title = "Histogram in position: dodge")

p + geom_histogram(aes(fill= Species, alpha= 0.5), 
                   color = "black", position = "identity", lwd = 0.75,
                   linetype = 1)+
  labs(title = "Measurements of iris data", x= "Petal Length (cm)")


ggplot(iris, aes(x= Petal.Length, fill = Species)) +
  geom_histogram(aes(y=after_stat(density), alpha = 0.5), color = "black",
                 lwd = 0.75, position = "identity",
                 linetype = 1)+
  labs(title = "Measurements of iris data", x= "Petal Length (cm)") +
  geom_density(alpha=.2)+
  geom_rug()

### Densities of the data

p <- ggplot(iris, aes(Petal.Width))
p + geom_density()

p1<- p + geom_density(aes(fill=Species))
p1

p2<- ggplot(iris, aes(Petal.Width)) + geom_density(aes(colour = Species))
p2


p11<- ggplot(iris, aes(Petal.Length)) + geom_density(aes(fill = Species))+
  labs(title = "Petal Lengths: iris data", x= "Petal Length (cm)")

p12<-  ggplot(iris, aes(Petal.Width)) + geom_density(aes(fill = Species))+
  labs(title = "Petal Widths: iris data", x= "Petal Widths (cm)")

p13<-  ggplot(iris, aes(Sepal.Length)) + geom_density(aes(fill = Species))+
  labs(title = "Sepal Lengths: iris data", x= "Sepal Length (cm)")

p14<-  ggplot(iris, aes(Sepal.Width)) + geom_density(aes(fill = Species)) +
  labs(title = "Sepal Widths: iris data", x= "Sepal Widths (cm)")

(p11+p12)/(p13+p14)


### Boxplots for the iris data

p<- ggplot(iris, aes(x= Species, y=Sepal.Length))

p + geom_boxplot() + 
  labs(title = "Sepal length data grouped", y= "Sepal Length (cm)")

p+  geom_boxplot(aes(fill= Species)) + 
  labs(title = "Sepal length grouped: fill", y= "Sepal Length (cm)")+
  
  p+  geom_boxplot(aes(color= Species)) + 
  labs(title = "Sepal length grouped: color", y= "Sepal Length (cm)")

p+  geom_boxplot(aes(fill= Species), outlier.shape = NA) + 
  labs(title = "Sepal length grouped: color and jitter", y= "Sepal Length (cm)")+
  geom_jitter()+
  
  p+  geom_boxplot(aes(color= Species), outlier.shape = NA) + 
  labs(title = "Sepal length grouped: fill and jitter", y= "Sepal Length (cm)")+
  geom_jitter()

p+  geom_boxplot(aes(fill= Species), outlier.shape = NA) + 
  labs(title = "Sepal length grouped: fill and jitter", y= "Sepal Length (cm)")+
  geom_jitter(aes(color= Species))+
  
  p+  geom_boxplot(aes(color= Species), outlier.shape = NA) + 
  labs(title = "Sepal length grouped: color and jitter", y= "Sepal Length (cm)")+
  geom_jitter(color= 2)

p+  geom_boxplot(aes(color= Species), outlier.shape = NA) + 
  labs(title = "Sepal length grouped: jitters shaped", y= "Sepal Length (cm)")+
  geom_jitter(aes(shape= Species)) 

p+  geom_boxplot(aes(color= Species), outlier.shape = NA) + 
  labs(title = "Sepal length grouped: jitters shaped and colored", y= "Sepal Length (cm)")+
  geom_jitter(aes(color= Species, shape= Species)) 


### Grouped boxplots:

iris_plot<- data.frame(Measurement= c(iris$Sepal.Length, iris$Petal.Length,
                                      iris$Sepal.Width, iris$Petal.Width),
                       Dissection= rep(c("Sepal Length", "Petal Length",
                                         "Sepal Width", "Petal Width"), each= nrow(iris)),
                       Species= rep(iris$Species, 4) )

head(iris_plot,10)

ggplot(iris_plot, aes(x= Dissection, y= Measurement, fill =Species))+
  geom_boxplot()+
  labs(y= "Measurements (cm)",
       title = "Grouped boxplots")

### Example: Lynx-Hare time series data

### geom_line vs geom_path:

dat <- data.frame(hare = as.numeric(Hare), lynx = as.numeric(Lynx), year = as.numeric(time(Hare))
)

head(dat)

p<- ggplot(dat, aes(hare, lynx)) + geom_point()+
  labs(title = "pelts (in thousands)")

p1<- ggplot(dat, aes(hare, lynx)) +
  geom_path() +
  geom_point()+
  labs(title = "geom path")

p2<- ggplot(dat, aes(hare, lynx)) +
  geom_line() +
  geom_point()+
  labs(title = "geom line")

p

p1 + p2


p1<- ggplot(dat, aes(hare, lynx, color= year)) +
  geom_path() +
  geom_point() +
  labs(title = "geom path")+ 
  labs(
    x = "Hare pelts (in thousands)",
    y = "Lynx pelts (in thousands)",
    color = "Year",
    caption = "Source: astsa (R package)"
  )

p2<- ggplot(dat, aes(hare, lynx, color= year)) +
  geom_line() +
  geom_point() +
  labs(title = "geom line")+
  labs(
    x = "Hare pelts (in thousands)",
    y = "Lynx pelts (in thousands)",
    color = "Year",
    caption = "Source: astsa (R package)"
  )

p1 + p2


dat_extnd<- data.frame(year= rep(dat$year, 2), pelts= c(dat$hare, dat$lynx),
                       animal= rep(c("hare","lynx"), each= nrow(dat)) )
head(dat_extnd)
tail(dat_extnd)

p1<- ggplot(dat_extnd, aes(year, pelts, color= animal)) +
  geom_path() +
  geom_point() +
  labs(title = "geom path",
       x = "year",
       y = "pelts (in thousands)",
       caption = "Source: astsa (R package)"
  )

p2<- ggplot(dat_extnd, aes(year, pelts, color= animal)) +
  geom_line() +
  geom_point() +
  labs(title = "geom line",
       x = "year",
       y = "pelts (in thousands)",
       caption = "Source: astsa (R package)"
  )

p1 / p2


### Heatmaps and Contour plots: behaviour of tri-variate data

### Example: 2d density of the Old Faithful Geyser Data

#### Description

head(faithful)
head(faithfuld)

p1 <- ggplot(faithfuld, aes(waiting, eruptions)) + 
  geom_raster(aes(fill = density))+
  labs(title= "geom raster")

p2 <- ggplot(faithfuld, aes(waiting, eruptions)) + 
  geom_tile(aes(fill = density))+
  labs(title= "geom tile")

p1 
p2

u<- max(faithfuld$density)
l<- min(faithfuld$density)

sq <- seq(l, u+0.001, len=8)
sq
ffd2 <- cbind.data.frame(faithfuld, level= NA)

for(i in 1:nrow(faithfuld)) {
  for (j in 1:length(sq)) {
    if(faithfuld$density[i] >= sq[j] & faithfuld$density[i] < sq[j+1]) {
      ffd2$level[i] <- paste("level", j, sep ="")
    }
  }
  
}

p1<- ggplot(ffd2, aes(x=waiting, y=eruptions, z = density, color = after_stat(level))) +
  geom_contour() +
  labs(color = "height", title = "Contour Lines") 

p2<- ggplot(ffd2, aes(x=waiting, y=eruptions, z = density, fill = after_stat(level))) +
  geom_contour_filled() +
  labs(fill = "height", title = "Filled Contours")

p1
p2


### Example: Boston Housing data.

#### Description 

#The Boston data frame has 506 rows and 14 columns.

boston_cor <- cor(Boston)

datc<- data.frame(Correlation= c(boston_cor), 
                  Row= rep(colnames(boston_cor), each= nrow(boston_cor)),
                  Col= rep(colnames(boston_cor), nrow(boston_cor)))

# create the expanded dataset
head(datc)

ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_tile() + 
  labs(title = "geom tiles")

ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_raster() +
  labs(title = "geom raster")



## Scales (color adjustment):
  
#The following arre the color palettes:
  
display.brewer.all(type = "seq") # represent a hierarchy

display.brewer.all(type = "qual") # no nierarchy 


### Some discrete scales for 'fill' option of the aes() function

# scale_fill_brewer

# scale_fill_fermenter

# scale_fill_binned which defaults to scale_fill_steps

# scale_fill_steps: produces a two-colour gradient

# scale_fill_steps2: produces a three-colour gradient with specified midpoint

# scale_fill_stepsn: produces an n-colour gradient

# They have their versions of Scale_color_* as well.

ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_density(shape = 1) +
  labs(x = "Sepal Length (cm)",
       caption = "Source: E. Anderson (1935)")+
  labs(title = "Set1") +
  scale_fill_brewer(palette = "Set1") +
  
  ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_density(shape = 1) +
  labs(x = "Sepal Length (cm)",
       caption = "Source: E. Anderson (1935)")+
  labs(title = "Dark2") +
  scale_fill_brewer(palette = "Dark2")

ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_raster() +
  labs(title = "geom raster with RdBu (6 breaks)")+
  scale_fill_fermenter(limits = c(-1, 1), palette = "RdBu", n.breaks = 6)

ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_raster() +
  labs(title = "geom raster with Reds (8 breaks)")+
  scale_fill_fermenter(limits = c(-1, 1), palette = "Reds", n.breaks = 8)


ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_raster() +
  scale_fill_steps(low = "grey", high = "brown")

ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_raster() +
  scale_fill_steps2(
    low = "grey", 
    mid = "white", 
    high = "brown", 
    midpoint = .02
  )

ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_raster() +
  scale_fill_stepsn(n.breaks = 12, colours = terrain.colors(12))



### Some continuous scales for the 'fill' option of the aes() function:

# scale_fill_viridis_c (from viridis package)

# scale_fill_distiller

# scale_fill_continuous which defaults to scale_fill_gradient

# scale_fill_gradient: produces a two-colour gradient

# scale_fill_gradient2: produces a three-colour gradient with specified midpoint

# scale_fill_gradientn: produces an n-colour gradient

# They have their versions of Scale_color_* as well.


ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_raster() +
  labs(title = "geom raster with viridis (12 breaks)")+
  scale_fill_viridis_c(limits = c(-1, 1), n.breaks = 12)

ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_raster() +
  labs(title = "geom raster with viridis (12 breaks)")+
  scale_fill_viridis_c(limits = c(-1, 1), n.breaks = 12, option = "magma")

#### For the old faithful density data:


ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster() + 
  theme(legend.position = "none")+
  scale_fill_distiller()+
  
  ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster() + 
  theme(legend.position = "none")+
  scale_fill_distiller(palette = "RdPu") +
  
  ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster() + 
  theme(legend.position = "none")+ scale_fill_distiller(palette = "YlOrBr")


ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster()+ theme(legend.position = "none")+ scale_fill_gradient(low = "grey", high = "brown") +
  
  ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster()+ theme(legend.position = "none")+
  scale_fill_gradient2(
    low = "grey", 
    mid = "white", 
    high = "brown", 
    midpoint = .02
  )+
  ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster()+ theme(legend.position = "none")+
  scale_fill_gradientn(colours = terrain.colors(7))


## Guides:
  
#### Examples:

p2 <- ggplot(faithfuld, aes(waiting, eruptions)) + 
  geom_tile(aes(fill = density))+
  labs(title= "geom tile")

p2 + guides(x = guide_axis(title = NULL, position = "top"))

ggplot(datc, aes(x= Col, y=Row, fill = Correlation))+
  geom_tile() + 
  labs(title = "geom tile: x labels and tickers missing") + 
  guides(x = guide_axis(title = NULL, position = "NULL"))


ggplot(iris, aes(x= Sepal.Width, y= Sepal.Length))+
  geom_point() +
  geom_smooth(aes(color = "loess", linewidth=2), method = "loess", se = T) + 
  geom_smooth(aes(colour = "lm", linewidth=2), method = "lm", se = T) +
  labs(colour = "Method") +
  labs(color= "Method", x= "Sepal Width (cm)", 
       y = "Sepal Length (cm)", color = "Species",
       title = "with linewidth legend",
       caption = "Data Source: R datasets") +
  
  ggplot(iris, aes(x= Sepal.Width, y= Sepal.Length))+
  geom_point()+
  geom_smooth(aes(color = "loess", linewidth=2), method = "loess", se = T) + 
  geom_smooth(aes(colour = "lm", linewidth=2), method = "lm", se = T) +
  labs(colour = "Method") +
  labs(color= "Method", x= "Sepal Width (cm)", 
       y = "Sepal Length (cm)", color = "Species",
       title = "linewidth legend gone",
       caption = "Data Source: R datasets") +
  guides(linewidth = "none")


ggplot(iris, aes(x= Petal.Length, fill = Species)) +
  geom_histogram(aes(y=after_stat(density), alpha = 0.5), color = "black",
                 lwd = 0.75, position = "identity",
                 linetype = 1)+
  labs(title = "with legend for alpha", x= "Petal Length (cm)") +
  geom_density(alpha=.2)+
  geom_rug() +
  
  ggplot(iris, aes(x= Petal.Length, fill = Species)) +
  geom_histogram(aes(y=after_stat(density), alpha = 0.5), color = "black",
                 lwd = 0.75, position = "identity",
                 linetype = 1)+
  labs(title = "legend for alpha gone", x= "Petal Length (cm)") +
  geom_density(alpha=.2)+
  geom_rug()+
  guides(alpha = "none")


ggplot(iris, aes(x= Sepal.Width, y= Sepal.Length))+
  geom_point(aes(color= Species, size= Petal.Length))+
  
  ggplot(iris, aes(x= Sepal.Width, y= Sepal.Length))+
  geom_point(aes(color= Species, size= Petal.Length))+
  guides(size = guide_legend(reverse=TRUE), color= guide_legend(reverse=TRUE) )


#### override the color parameter 


ggplot(iris, aes(x= Sepal.Width, y= Sepal.Length))+
  geom_point(aes(color= Species, size= Petal.Length, alpha= Petal.Width))+
  guides(color = guide_legend(override.aes = list(shape = 7, size = 3)))


##  Faceting:
  
ggplot(iris_plot, aes(y= Measurement, fill =Species))+
  geom_boxplot()+
  facet_wrap(~ Dissection)

ggplot(iris_plot, aes(y= Measurement, fill =Dissection))+
  geom_boxplot()+
  facet_wrap(~ Species)

ggplot(iris_plot, aes(y= Measurement, fill =Dissection))+
  geom_boxplot()+
  facet_wrap(~ Species)+ 
  theme(panel.spacing = unit(2, "lines"))

ggplot(iris_plot, aes(x= Measurement, fill =Dissection))+
  geom_density()+
  facet_wrap(~ Species)+ 
  theme(panel.spacing = unit(2, "lines"))

ggplot(iris_plot, aes(x= Measurement, fill =Dissection))+
  geom_density()+
  facet_wrap(~ Species, scales= "free_x")+ 
  theme(panel.spacing = unit(2, "lines"))+
  labs(title ="free x")

ggplot(iris_plot, aes(x= Measurement, fill =Dissection))+
  geom_density()+
  facet_wrap(~ Species, scales= "free_y")+ 
  theme(panel.spacing = unit(2, "lines"))+
  labs(title ="free y")

ggplot(iris_plot, aes(x= Measurement, fill =Dissection))+
  geom_density()+
  facet_wrap(~ Species, scales= "free")+ 
  theme(panel.spacing = unit(2, "lines"))+
  labs(title ="free x and y")

ggplot(iris_plot, aes(x= Measurement, fill =Dissection))+
  geom_density()+
  facet_wrap(~ Species, scales= "free", nrow=2)+ 
  theme(panel.spacing = unit(2, "lines"))

ggplot(iris_plot, aes(x=Measurement))+
  geom_density()+
  facet_wrap(~ Species+Dissection, scales= "free")

ggplot(iris_plot, aes(x=Measurement, fill =Species))+
  geom_density()+
  facet_grid(.~ Dissection, scales= "free")

ggplot(iris_plot, aes(x=Measurement, fill =Species))+
  geom_density()+
  facet_grid(Dissection~., scales= "free")

ggplot(iris_plot, aes(x=Measurement))+
  geom_density()+
  facet_grid(Dissection~ Species)



## Themes

ggplot(iris, aes(Sepal.Width, Petal.Width, color = Species, shape = Species)) +
  geom_jitter(alpha = 0.5) +
  labs( x = "Sepal Width (cm)", y = "Petal Width (cm)", caption = "Source: Edgar Anderson (1935)") +
  guides(color = guide_legend(override.aes = list(alpha = 1, size = 3)))+
  labs(title = "Default Theme")

ggplot(iris, aes(Sepal.Width, Petal.Width, color = Species, shape = Species)) +
  geom_jitter(alpha = 0.5) +
  labs( x = "Sepal Width (cm)", y = "Petal Width (cm)", caption = "Source: Edgar Anderson (1935)") +
  guides(color = guide_legend(override.aes = list(alpha = 1, size = 3)))+
  labs(title = "Theme black and white") +
  theme_bw()

ggplot(iris, aes(Sepal.Width, Petal.Width, color = Species, shape = Species)) +
  geom_jitter(alpha = 0.5) +
  labs( x = "Sepal Width (cm)", y = "Petal Width (cm)", caption = "Source: Edgar Anderson (1935)") +
  guides(color = guide_legend(override.aes = list(alpha = 1, size = 3)))+
  labs(title = "Theme minimal") +
  theme_minimal()

ggplot(iris, aes(Sepal.Width, Petal.Width, color = Species, shape = Species)) +
  geom_jitter(alpha = 0.5) +
  labs( x = "Sepal Width (cm)", y = "Petal Width (cm)", caption = "Source: Edgar Anderson (1935)") +
  guides(color = guide_legend(override.aes = list(alpha = 1, size = 3)))+
  labs(title = "Theme minimal") +
  theme(
    panel.grid.major = element_line(color = "brown"),
    plot.title = element_text(
      family = "serif",
      face = "bold",
      hjust = 0.5
    )
  ) +
  labs(title = "Adjusted Theme")


ggplot(iris, aes(Sepal.Width, Petal.Width, color = Species, shape = Species)) +
  geom_jitter(alpha = 0.5) +
  labs( x = "Sepal Width (cm)", y = "Petal Width (cm)", caption = "Source: Edgar Anderson (1935)") +
  guides(color = guide_legend(override.aes = list(alpha = 1, size = 3)))+
  labs(title = "Theme minimal") +
  theme(
    panel.grid.major = element_line(color = "brown"),
    plot.title = element_text(
      family = "serif",
      face = "bold",
      hjust = 0.5),
    axis.text.x=element_text(size=12),
    axis.title.x=element_text(size=12),
    axis.text.y=element_text(size=12),
    axis.title.y=element_text(size=12),
    legend.text=element_text(size=12),
    legend.title=element_text(size=12),
    title = element_text(size=12),
    strip.text = element_text(size=12)
  )+
  labs(title = "Adjusted Theme with magnified texts")


