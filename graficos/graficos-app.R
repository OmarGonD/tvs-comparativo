library(tidyverse)
library(hrbrthemes)
library(forcats)
library(scales)

ecommerce.ripley <- ecommerce %>%
                    filter(ecommerce == "ripley") %>%
                    group_by(categoria) %>%
                    summarise(precio.actual = sum(precio.actual, na.rm = T)) %>%
                    mutate(categoria=factor(categoria, levels=categoria)) 




ggplot(ecommerce.ripley,
       aes(fct_reorder(categoria, precio.actual, .desc = FALSE), precio.actual, fill = categoria)) +
  geom_col() +
  labs(x="Categoría", y="Precio Actual S/.",
       title="Ripley - Totales por categoría",
       subtitle="",
       caption="Brought to you by the letter 'g'") +
  #scale_color_ipsum() +
  theme_ipsum_rc(grid="X") +
  scale_fill_ipsum() +
  geom_text(aes(label=scales::comma(precio.actual)), hjust=0, nudge_y=2000) +
  scale_y_comma(limits = c(0,1000000)) +
  coord_flip() 