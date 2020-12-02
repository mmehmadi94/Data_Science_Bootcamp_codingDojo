# Resume Scoring 


The objective of the project is to create a Resume Scoring algorithm to identify the most suitable candidates. The algorithm will parse resumes one by one and will give a score for the similarity between it and the job description. 

### Problem Statement

When a company post a job offer, it receives hundreds resumes. so, manual CV screening needs a lot of effort and time.

for instance, among 250 resume, there are just 4 to 6 resume match job requirement and they are eligible to move to next phase which is interviews.

<p align="center"><img src="https://github.com/mmehmadi94/Data_Science_Bootcamp_codingDojo/blob/master/Resume_Scoring/Resumes-Stats.jpg" width="700" height="400"></p>

### Data Gathering

- Job description of Data Scientist role in Elm company in document format from [Data Scientist in Elm company](https://www.linkedin.com/jobs/view/data-scientist-deep-learning-consultant-at-%D8%B4%D8%B1%D9%83%D8%A9-%D8%B9%D9%84%D9%85-1468946631/?refId=3c37fe28-5f30-42c9-b9da-02866f173575&originalSubdomain=sa)

- 15 randomly resumes were collected from Resume Genius website for various fileds [resume Genius website](https://resumegenius.com/)  
for example Data Analyst, Data Scientist, Business Analyst, BI analyst, IT manager, Web developer and Java developer....

### Scoring

Cosine similarity  is the  simplest way to build a vector from text by count the words.

It’s simply measures the angle between the two vectors and returns a real value between -1 and 1.


### Visualization

The output is a bar chart sorted descending to show the best candidates for the job description.

<p align="center"><img src="https://github.com/mmehmadi94/Data_Science_Bootcamp_codingDojo/blob/master/Resume_Scoring/Resumes_scores.png" width="700" height="400"></p>

The distribution of resume scores

<p align="center"><img src="https://github.com/mmehmadi94/Data_Science_Bootcamp_codingDojo/blob/master/Resume_Scoring/score_distribution.png" width="700" height="400"></p>

