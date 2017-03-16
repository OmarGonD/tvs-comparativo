tapply(rsl$precio, rsl$ecommerce,
       median)



rsl.median <- tableGrob(tapply(rsl$precio, list(rsl$ecommerce, rsl$marca), 
                               median))


grid.newpage()
grid.draw(rsl.median)



rsl.max <- tableGrob(tapply(rsl$precio, list(rsl$ecommerce, rsl$marca), 
                            max))


grid.newpage()
grid.draw(rsl.max)



p <- ggplot(rsl, aes(x = precio, fill = marca)) + geom_histogram(binwidth = 1000) + facet_wrap(~ ecommerce)

p + scale_fill_brewer(palette="Set3")
