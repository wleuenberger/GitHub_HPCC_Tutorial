# Tutorial: Using the HPCC and GitHub through RStudio

### Wendy Leuenberger

### 3/27/2024

### leuenbe9@msu.edu

This repository goes along with the lecture and demonstration.

---------------------------------

# Repository contents

### [Tutorial](Tutorial/)

`HPCC.*`: The R markdown (`.Rmd`), markdown (`.md`; easiest viewing on GitHub) and `.html` documents for setting up your GitHub and HPCC. 

`Tutorial.*`: The R markdown (`.Rmd`), markdown (`.md`; easiest viewing on GitHub) and `.html` documents for using this repository to commit changes and run a job on the HPCC. 

### [Code](Code/)
`WarblerForHPCC.R`: Code file used in this tutorial. 

### [Data](Data/)
`warbler-data.rda`: Data used in `WarblerForHPCC.R`

### [Output](Output/)
Save your model output here

`Placeholder.R`: Just here so that I can remove out.RData after running tutorials without deleting the entire folder. 

### [Lecture](Lecture/)
#### Recording
[Click here for the recording from IBIO 831](https://mediaspace.msu.edu/media/831%20Mar%2026/1_k423gjwz)

#### Presentation
`HPCC_Presentation.*`: Rmd and html files of the brief slides accompanying this tutorial. Formatting isn't great - some images might not show up.

`HPCC_diagram.jpeg`: Image from lecture depicting the layout of the HPCC. We start on our personal computer, log onto a gateway node, log onto a development node (can run jobs $leq$4 hours), and submit jobs to the clusters. (might not be in the slides)

### Submit a job
`runWarbler.sb`: File used to submit a job to a cluster on the HPCC. I usually place the `.sb` file in the main part of the repository, and file references are relative to the folder the `.sb` file is in. Those settings can be changed if you want a different file structure though. 
