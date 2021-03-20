###employment rate 
ggplot(data = month_group_stats, aes( x= yearmo, y = retailemployment_rate )) + geom_point()


##before Covid Regression - Employment
summary(BeforeCovid_Employmentregression)

ggplot(data = BeforeCovid_Employmentregression, aes( x= RetailEmployed, y = Employment)) + geom_point() + geom_smooth()


hist(rstandard(BeforeCovid_Employmentregression), 
     xlab = "Standardized residuals", main = 'Standardized Residuals of ')


#After COVID Regression - Employment 
summary(AfterCovid_Employmentregression)

ggplot(data = AfterCovid_Employmentregression, aes( x= RetailEmployed, y = Employment)) + geom_point() + geom_smooth()


hist(rstandard(AfterCovid_Employmentregression), 
     xlab = "Standardized residuals", main = 'Standardized Residuals of ')

#Overall Other Industries
ggplot(data = otherindustries_df_stats, aes( x = yearmo)) +
  geom_point(aes(y = art_rate), color = "darkred") +
  geom_point(aes(y = construction_rate), color = "red") +
  geom_point(aes(y = edu_rate), color = "pink") +
  geom_point(aes(y = finance_rate), color = "orange") +
  geom_point(aes(y = info_rate), color = "yellow") +
  geom_point(aes(y = military_rate), color = "green") +
  geom_point(aes(y = other_rate), color = "blue") +
  geom_point(aes(y = public_rate), color = "purple") +
  geom_point(aes(y = retail_rate), color = "brown") +
  geom_point(aes(y = transport_rate), color = "blueviolet") +
  geom_point(aes(y = ws_rate), color = "gold")

## Before Covid - Other Industries

summary(BeforeCovid_OtherIndRegression)

ggplot(data = BeforeCovid_OtherIndRegression, aes( x= retail_count, y = Employment)) + geom_point() + geom_smooth()


hist(rstandard(BeforeCovid_OtherIndRegression), 
     xlab = "Standardized residuals", main = 'Standardized Residuals of ')


##After Covid -- Other Industries

summary(AfterCovid_OtherIndRegression)

ggplot(data = AfterCovid_OtherIndRegression, aes( x= retail_count, y = Employment)) + geom_point() + geom_smooth()


##COVID DATA 


summary(covid_regression)
