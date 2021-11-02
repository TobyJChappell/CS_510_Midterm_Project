# CS_510_Midterm_Project
## Description
This project consists of two main goals. The first is to provide clean visualizations for DonorSearch's Insight Models, which can be used in presentations to respective clients. The second goal is to create an animation that shows how DonorSearch's machine learning powered Aristotle Score shifts over time as client data is updated.

## How to Run
Clone this repository and open **Midterm Project.Rproj** in RStudio. 

There are two separate source files titled **DonorSearch Insights.R** and **DonorSearch Aristotle.R** (each handling one of the main focuses of this project). Proceed to install all associated libraries and run each file.

**DonorSearch Insights.R** - Creates 4 different visualizations:
- Distribution of Insight Scores over Estimated Capacity as a scatter plot
- Distribution of Estimated Capacity colored by Insight Ranks as a bar plot
- Distribution of Donors vs. Prospects colored by Constituency Type as a bar plot
- Number of Constituents over time colored by Constituency Type as a line graph

**DonorSearch Aristotle.R**: Creates an image sequence to show how the Aristotle Score will change for each constituent over time depending on the that constituent's experience with the respective organization. These images can then be used to create the animation.

## Data
Data for both files is located in the **Data** folder.

## Images
If any updates are made to **DonorSearch Insights.R** (connecting to a new client's data or visualization updates), images for the graphs will be stored in **Images** folder. These images can then be added to a presentation to the client.

## Animation
The images produced by **DonorSearch Aristotle.R** are stored in the **animAristotle** folder. The animation can then be put together using ImageJ and stored as an .AVI or a similar program. A sample animation is located in the **Animation** folder and titled **animAristotle.AVI**.

## Tests
Tests are located in the **Tests** directory. The test checks to make sure the update function works correctly in **DonorSearch Aristotle.R**.
