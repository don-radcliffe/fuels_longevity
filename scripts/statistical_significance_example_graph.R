require(here)
require(dplyr)
require(tidyr)
require(ggplot2)
require(stringr)

import_dir_ma <- here::here('data')
export_dir_ma <- here::here('plots')

example_data <- read.csv(file.path(import_dir_ma, 'statistical_significance_example.csv')) %>%
  mutate(Treatment = str_replace_all(Treatment, c('Control' = 'Untreated stand', 'Treatment' = 'Treated stand'))) %>%
  mutate(Treatment = factor(Treatment, levels = c('Untreated stand', 'Treated stand')))

example_graph <- ggplot(example_data, aes(x = years_post, y = mean_fuel_load, color = Treatment)) +
  geom_errorbar(aes(ymin = lower_bound, ymax = upper_bound), position = position_dodge(width = 1), size = 1.1, width = 0.8) +
  geom_point(aes(x = years_post, y = mean_fuel_load, color = Treatment), size = 3, position = position_dodge(width = 1)) +
  geom_abline(intercept = 0, slope = 100000000, lty = 'dotted') +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line = element_line(size = 0.2, color = 'black')) +
  theme(legend.key=element_blank(), legend.background=element_blank(), legend.title = element_blank()) +
  scale_color_manual(values = c('gray15', 'gray45')) +
  scale_x_continuous(breaks = c(0, 5, 10, 15, 20, 25)) +
  scale_y_continuous(limits = c(0, 50)) +
  ggtitle('Hypothetical example of statistical significance underestimating treatment longevity') +
  xlab('Years after treatment') + 
  ylab('Fuel load')
example_graph

ggsave(plot = example_graph, filename = 'graphs/statistical_significance_example_graph.jpg', height = 5, width = 9, units = 'in', dpi = 500)
