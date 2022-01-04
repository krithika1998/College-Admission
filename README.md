# College-Admission

Every year, more than thousands of applicants apply to different colleges either for their undergraduate or post-graduation studies. There are various factors that one must see in order to come to a conclusion whether to admit one student or not. Some of the criteria that they look in a university in USA are as follows
a)	GPA
b)	GRE score
c)	TOEFL score 
d)	Extra curriculars 
e)	Statement of Purpose
f)	Letter of Recommendation etc

In this task, a database was provided which has the following attributes
a)	GRE
b)	GPA
c)	Rank
d)	Socioeconomic status
e)	Gender
f)	Race

During my analysis, I had found the attributes Race, SES, Gender had a significance level of more than 0.05, making it attributes with very less contribution to the model. 

Outliers were found for GRE and GPA which were removed.

All the attributes shows a normal distribution while plotting in the graph. 

3 models were used with the same database

a)	Logistic Regression: The model showed an accuracy of 67% making it a less reliable model. But while noticing the confusion matrix, false positive value is less compared to true negative. We can also observe that false negative and true positive value are almost equal. 

b)	SVM model: The model showed an accuracy of 68% making it a less reliable model. The false positive value is extremely high while comparing it with the true positive value.

c)	Decision Tree: The model showed an accuracy of 44% making it the least reliable model. Although the false negative value is less compared to true positive value in the confusion matrix, we can also see that the false positive value is high compared to the true negative values which makes it a bad confusion matrix.

Conclusion:

Overall, while comparing all the models, in this scenario, Logistic Regression proves to be a better model for the training of the model. Also, it can also be observed that, while deciding whether a student should be given admission or not in the university, factors such as the GRE score, GPA and Rank play an important role. 
