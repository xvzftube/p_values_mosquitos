import pandas as pd
from plotnine import theme_set, ggplot, geom_histogram, xlab, ggtitle, geom_vline, theme_538, aes
#palette = ['red','yellow', 'blue']
palette = ['#ee1d52','#f2d803', '#69c9d0']

# read csv
df = pd.read_csv("./df_diff.csv")

# quick plot of time series
theme_set(theme_538)
p = (
        ggplot(df, aes(x='diff')) +
        geom_histogram(fill = palette[2], color = 'white', bins=15) +
        geom_vline(aes(xintercept = 4.4), color = palette[0])+
        xlab('Either we observed a data set that has a probability of 0.0006 or beer made these subjects more tasty')+
        ggtitle('Histogram of Resampled Differences')
        )
p.save(filename='./assets/plot_diff.jpg', width=12, height=6)
p

