# OpenAgeFriendly
Using R with Taiwan Government Open Data to create a tool for monitoring the city's age-friendliness status and easily to interact for the local citizen

**Project Progress**: 89%

**Discussion Board on [hackpad](https://dsp.hackpad.com/ivLa4Zookfn)**

The idea of the project was came out from a team work in [the Winter Data Science Camp] (https://dsp.im/),and the team members were from the different universities and departments working together in order to use the open data for the social good.

**Author**

- **Ting Wei,Lin**
  - System Genome and Biology Program, National Taiwan University, Taiwan
- **Wen Tsai,Hsu**
  - Department of Financial and Computational Mathematics,Providence University, Taiwan
- **Zheng Wan,Lin**
  - Department of Information Management, Providence university, Taiwan
- **Yu Wen,Kao**
  - Department of Statistics and Informatics Science, Providence University, Taiwan
- **Po Shang,Yang**
  - Department of Computer Science and Engineering, National Chung-Hsing University, Taiwan
- **Chi Tse,Teng**
  - Department of Computer Science and Information Engineering, Providence university, Taiwan

======
Due to rapidly growing aging population,to create a aging-friendly city is a important goal of modern government. Some indexes to reflect the city's age-friendliness may help the local government to monitor and improve the policy practice and these information also should be open and interactive to the citizen who caring about this issue. And the R language provides a great flexibility in dealing with the diversity of the file formats from government. Besides, the data visualization and web application supported by R can make the analysis result more understandable and interactive.

According to WHO 2015 age-friendly city guidelines, there are eight aspects for a comfort of elder living (outdoor spaces, transportation, housing, social participation, social respect, civic participation, communication, health and community support ).And we use the Taiwan OpenGovernment data to integrate indexes  with normalization and to visualize the indexes geographically. In the end, we create a shiny application with interactive Plotly to let the result easily be approached. The result may show how R can easily to utilize the government data and provide a great application turning WHO guideline into a monitor tool helping the government practice in age-friendly policy.

![Heatmap of the indexes for seperate county and city]
(https://github.com/weitinglin/OpenAgeFriendly/blob/master/figs/4coreindicators.png)

![Equity](https://github.com/weitinglin/OpenAgeFriendly/blob/master/figs/Equity1000.png) ![Physical nvironemnt](https://github.com/weitinglin/OpenAgeFriendly/blob/master/figs/PhysicalEnvironment1000.png) ![Quality of life](https://github.com/weitinglin/OpenAgeFriendly/blob/master/figs/QualityOfLife1000.png) ![Social Environment]!(https://github.com/weitinglin/OpenAgeFriendly/blob/master/figs/SocialEnvironment1000.png)
