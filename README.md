# Palmer Penguins Body Mass Shiny App Development

This repository contains the code for the Shiny app Palmer Penguins Body Mass.

The code for the Assignment 3 version of this app can be found at https://gracem25.shinyapps.io/assignment-b3-gracem25/

The code for the Assignment 4 version of this app can be found at https://gracem25.shinyapps.io/assignment-b4-gracem25/

This Shiny app uses the shiny, tidyverse, palmerpenguins, DT, bslib and thematic packages.

Data credit goes to the developers of the palmerpenguins package, as I used the penguins dataset in my Shiny app. Credit to:  Horst AM, Hill AP, Gorman KB (2020). palmerpenguins: Palmer Archipelago (Antarctica) penguin data. R package version 0.1.0. https://allisonhorst.github.io/palmerpenguins/. doi: 10.5281/zenodo.3960218.

This app explores penguin body mass of the three species of penguin within the penguins dataset: Adelie, Chinstrap and Gentoo. 

For Assignment B3 of STAT 545B, I developed this such such that users are able to filter the data they view by island, and the data is presented in both a boxplot of body mass by species and also an interactive table that explores the data for each individual penguin filtered by island as well. An image shows to the users what each of the three penguin species in the dataset looks like.

For Assignment B4 of STAT 545B, I improved this app in several ways: I added a black and white theme, sketchy, from Bootswatch that fits in well with the focal bird of the app, penguins, and made the app more exciting to look at and easier to interact with. I added a button for users to download the penguins dataset that was used in this Shiny app, and also added a bookmark button to the plot tab that allows users to save a url that saves the settings they have customized by island selection and send it to others.