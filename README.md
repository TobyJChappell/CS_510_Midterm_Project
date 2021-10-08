# CS_510_Midterm_Project
## How to Run
Clone this repository and open **Midterm Project.Rproj** in RStudio. 

There are two separate source files titled **DonorSearch Insights.R** and **DonorSearch Aristotle.R**.

**DonorSearch Insights.R** - Creates 4 different visualizations:
- Distribution of Insight Scores over Estimated Capacity as a scatter plot
- Distribution of Estimated Capacity colored by Insight Ranks as a bar plot
- Distribution of Donors vs. Prospects colored by Constituency Type as a bar plot
- Number of Constituents over time colored by Constituency Type as a line graph

**DonorSearch Aristotle.R**: Creates an image sequence to show how the Aristotle Score will change for each constituent over time depending on the that constituent's experience with the respective organization. This can then be used to create the animation.

Data is taken from the **Data** folder. If any updates are made to **DonorSearch Insights.R**, images for the graphs will be stored in **Images** folder. Similarly, if any updates are made to **DonorSearch Aristotle.R**, images for the graphs will be stored in **animAristotle** folder.

The animation is put together using ImageJ and stored as an .AVI. 
