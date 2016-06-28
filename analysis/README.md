# OpenAgeFriendly: Analysis Workflow

1. Gathering the data which may be categorized into the WHO age-friendliness indicators
2. Encoding the data due to the big-5 and UTF-8 filing
3. documented the data into the google sheet for tream work (https://goo.gl/VrnMnQ)
4. Preprocessing the raw data, which including removing the unnecessary columns
5. Normalization the data and transform it into more reasonable combination
6. Construct the geographic map with the polygon filled the indexes and the ggmap for the background layer
7. Integrate the data geographically and plot the heatmap of the several indexes

## R code

- geoplot.R : cope with the GEO data and smooth the polygon, download the ggmap as the background layer
- preprocessing.R : input the raw.data and normalization
- plotresult.R: plot the indexes geographically and the heatmap reflexing each counties status
