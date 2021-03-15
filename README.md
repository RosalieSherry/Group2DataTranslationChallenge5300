# Group2DataTranslationChallenge5300
Winter Quarter 2021 Data Translation Challenge for Dr. Nick Huntington-Klein's Econometrics Class


Business Problem
You work for a company in the retail sector. Your company knows how well they’re weathering the pandemic, but they are having difficulty figuring out what the effect has been on the rest of the retail sector and the rest of the economy. Everyone is being tight with their numbers!

So, they’ve brought you on and pointed you towards the IPUMS release (Links to an external site.) of the Current Population Survey (Links to an external site.), which the government often uses to understand changes in employment.

Why employment data? They figure that revenues can be misrepresented, or might be affected by government aid. But employment in an industry can tell you a lot about how well that industry is doing!

They don’t know exactly what analyses they want you to run or variables they want you to use - figuring that out is your job. But they know the general questions they’d like to be answered, each of which will probably require more than one regression analysis.

How has COVID affected the health of the retail industry, as measured by employment?
How has retail fared relative to other industries?
Retail needs to worry about who has money to spend - what has changed about who is working and earning money?
Analysis
Explore the data on the IPUMS CPS website and see what is in there.
Figure out which analyses to run that will help answer these questions
Run those analyses
Write up your results in an RMarkdown document with your analysis code inside, and prepare a presentation of your results (RMarkdown works here too, or Google Slides or Powerpoint or whatever you like)
Your entire project should be kept track of as an R Project (.Rproj), in a folder with files kept in a standard file structure (code/, data/, results/, etc), and uploaded to a GitHub repository
You may bring in outside information aside from your data (for example, “lockdowns strengthened in month X, so our analysis will…”) but this is not expected/required.

Communication
In the Writeup
Your writeup should be in an RMarkdown document. Don’t worry about length - if you’re hitting all the points below for each of your analyses, that is what you want. Format the writeup as a report with sections for the main questions, not a list of bullet points. Information to include:

Why you are running the analyses you are running
How the analyses answer the question being asked, and what the result is
Carefully interpreting the results
Presenting the results in an appealing way. Graphs are great, sumtable() is great, export_summs() is great - put a little effort into formatting tables and figures to make them look nice! At the very least, variable names should be in English rather than statistics-package (‘Education’ not ‘EDUC’). If you aren’t comfortable enough with ggplot to make its visualizations look nice, feel free to make graphics in Excel or Tableau or anything you like, and include them in your RMarkdown doc as images. Econometric analyses should be in R.
Acknowledging the assumptions you are making in each analysis, how plausible those assumptions are in the context of your data, and any evidence you can provide backing up those assumptions
After doing all analyses related to a given question, provide a generalized answer to the main questions.
I do not expect undisputable flawless results - the data can only do so much, and we always have to rely on assumptions. However, an analysis with big flaws goes down a lot easier if you can very accurately interpret the results, point out the flaws or implausible assumptions, discuss how those flaws affect the results, and perhaps suggest an improved analysis you would run if it were feasible. Don’t claim more than your results can actually show.

You can work collaboriatively on a Markdown file using GitHub, which is recommended. If you prefer, you can instead use Google Docs with the Markdown Preview (Links to an external site.) add-in, or you can use Draft (Links to an external site.). These will not run the R code in the document, but they will let you work together on text and code.

In the Presentation
Your group presentation should be between 15 and 20 minutes long, plus a few minutes for questions. As many or as few of the people in your group can present as you like. There are no bonus points for being a presenter.

For your presentation:

Choose two of the main questions you feel you can answer best
Present your analyses related to those questions. Depending on how many you have you may want to select only a subset of them.
Make clear to the audience how your analysis works, how to interpret the results, and what the general answer to the question is
Be prepared to answer questions about your analyses and the assumptions behind them
