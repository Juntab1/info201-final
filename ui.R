library(ggplot2)
library(plotly)
library(dplyr)

vacc_df <- read.csv("vaccination_mortality_df.csv")

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Introduction",
   h1("Project Overview: Exploring Child Mortality and Vaccination Coverage"),
   p("Welcome to our project on exploring the relationship between child mortality rates and vaccination coverage 
     worldwide. Vaccinations play a crucial role in protecting children from deadly diseases, yet millions of children 
     globally still lack access to essential immunizations. Our project seeks to shed light on this issue by analyzing 
     two key datasets: one focused on child mortality rates and the other on vaccination coverage, specifically the 
     Diphtheria, Tetanus, and Pertussis (DTP3) vaccine."),
   tags$img(src = "intro_image_1.jpeg"),
   h2("Major Questions:"),
   tags$ol(
     tags$li("How have vaccination rates changed over time?"),
     tags$li("What is the correlation between postneonatal mortality rates and DTP3 coverage?"),
     tags$li("What regions show disparities in vaccination coverage and child mortality rates?"),
     tags$li("How can this data inform targeted health initiatives and policy decisions?")
   ),
   h2("Data Sources:"),
   tags$ol(tags$b("Mortality Data:") ,"Provided by the Institute for Health Metrics and Evaluation (IHME), 
           this dataset spans from 1990 to 2011 and includes estimates of child mortality rates, number 
           of child deaths, and annualized rate of decline in child mortality. We'll focus on postneonatal 
           mortality rates.",  tags$a(href = "https://ghdx.healthdata.org/record/ihme-data/child-mortality-estimates-and-mdg-4-attainment-country-1990-2011", target = "blank_", "IHME Child Mortality Data")),
   tags$ol(tags$b("Vaccination Coverage Data:") ,"Sourced from Our World in Data, this dataset covers the period from 1980 to 2021 and includes coverage 
           of the DTP3 vaccine among one-year-olds. It is based on data from the World Health Organization (WHO) and UNICEF.",  
           tags$a(href = "https://ourworldindata.org/vaccination", target = "blank_", "OWID Vaccination Coverage Data")),
   h2("Ethical Considerations:"),
   tags$ol(tags$b("Data Privacy:"), "Ensuring the anonymity and privacy of individuals represented in the datasets."),
   tags$ol(tags$b("Equity:"), "Recognizing disparities in access to healthcare and vaccination services among different populations."),
   tags$ol(tags$b("Transparency:"), "Providing clear and accurate information about the sources and methodologies used in data collection and analysis."),
   tags$img(src = "intro_image_1.jpeg"),
   p("Through our analysis, we aim to advocate for increased vaccination efforts and raise awareness about the importance of immunizations 
     n improving global health outcomes. Join us on this journey to understand and address the challenges of child mortality and 
     vaccination coverage worldwide.")
)

## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("Options for graph"),
  radioButtons("country_", "Select Plot Type:",
               choices = c("True", "False")),
  p("By selecting true or false, viewers are able to see which 
    countries are above the average DTP3 vaccination rate. When 
    selecting the “True” button, the red colored countries on 
    the map signify that that country is above the average 
    DTP3 vaccination rate (around 93.1%), compared to when you 
    press the “False” button, those countries that remain 
    gray/white colored do not have a vaccination rate above 
    the average value. This page aims to contribute to the 
    monitoring and evaluation of immunization programs worldwide, 
    with the ultimate goal of achieving high and equitable vaccine 
    coverage to protect children from vaccine-preventable diseases.")
)

viz_1_main_panel <- mainPanel(
  h2("Above or Below 93.1% DTP3 Vaccination Coverage"),
  plotlyOutput(outputId = "dtp_vaccination")
)

viz_1_tab <- tabPanel("Above or Below DTP3 Vaccination Rate",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Options for graph"),
  selectInput(
    "county_postneo_DTP",
    "Choose Country",
    vacc_df$Country,
  ),
  p("For each country, we were able to code for the postneonatal rate 
    as well as the DTP3 vaccination rate using our combined data frames 
    that we used for the basis of the project. By selecting any country 
    within the drop down menu, viewers are able to see on a bar chart the 
    postneonatal mortality rate as well as the DTP3 vaccination rate in one 
    year olds. Using this data, we can better understand the effectiveness 
    of public health interventions. For instance, identifying regions with 
    high child mortality rates but low vaccination coverage can highlight 
    areas in need of targeted health initiatives.")
  
)

viz_2_main_panel <- mainPanel(
  h2("Postneonatal and DTP3 Rate for a Country"),
  plotlyOutput(outputId = "country_postneonatal_rate"),
  plotlyOutput(outputId = "country_dtp_rate")
)

viz_2_tab <- tabPanel("Postneonatal and DTP3 rates",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  radioButtons("death_choice", "Select Number of Dead per a Hundred People in a Country:",
               choices = c(0, 1, 2, 3, 4, 5)),
  p("Our last interactive page includes a world map diagram 
    of several countries, as well as a selecting button feature 
    using the numbers 0-6. The numbers 0-6 represent the number of 
    individuals (per 100) who died per shot not taken. This 
    can connect to other portions of our data including the postneonatal 
    death rate as the number of deaths generally increase as the number 
    of individuals who died per shot not taken increases. When selecting 
    a number, the diagram will turn blue for the countries that correlate 
    with that number, which is the number of individuals who died per shot not taken. ")
)

viz_3_main_panel <- mainPanel(
  h2("Death per a Hundred People in a Country"),
  plotlyOutput(outputId = "death_per_100")
)

viz_3_tab <- tabPanel("Death per a Hundred People in Population",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion",
 h1("Conclusion: Key Takeaways"),
 tags$img(src = "conclusion_image_1"),
 p("After analyzing the relationship between child 
   mortality rates and vaccination coverage, several 
   key insights emerge that underscore the importance 
   of immunization efforts in global health initiatives. 
   Here are three major takeaways from our analysis:"),
 h2("1. Vaccination Coverage Trends:"),
 p("Our analysis reveals significant progress in vaccination coverage rates 
   over the past few decades. The data from Our World in Data shows a steady 
   increase in DTP3 vaccine coverage among one-year-olds in many countries. 
   This upward trend indicates successful vaccination programs and efforts 
   to reach vulnerable populations. However, it also highlights the need 
   for continued investment and advocacy to ensure that all children have 
   access to life-saving vaccines. Our first page on the site allows users 
   to explore global trends and regional variations in vaccination coverage 
   and connected mortality rates. The map depicts which of these countries 
   have the resources to allow the majority of the child population to have 
   access to getting the DTP3 vaccination and which ones do not. By highlighting 
   the countries that are above average, one can think about different factors 
   that influence an individual's access to healthcare. "),
 h2("2. Correlation Between Vaccination Coverage and Child Mortality:"),
 p("We found a strong correlation between higher vaccination coverage rates 
   and lower postneonatal mortality rates. Regions with higher DTP3 coverage 
   tend to experience lower child mortality rates, highlighting the lifesaving 
   impact of immunizations. This correlation underscores the importance of 
   prioritizing vaccination efforts as a key strategy for reducing child mortality 
   and improving public health outcomes globally. Looking at interactive page 2, 
   viewers are able to pick a country and see the selected countries’ postneonatal 
   death rate in one bar chart, as well as the DTP3 vaccination rate in another. 
   With the following visuals, viewers are able to see the relationship between 
   DTP3 vaccination rates among one-year-olds as well as the mortality rate 
   among one-year-olds. "),
 h2("3. Regional Disparities and Targeted Interventions:"),
 p("Despite overall progress, our analysis also reveals significant disparities 
   in vaccination coverage and child mortality rates across regions. Certain areas, 
   particularly in low- and middle-income countries, continue to face challenges in 
   accessing and delivering vaccines effectively. These findings underscore the 
   importance of targeted interventions and investment in health infrastructure 
   to address regional disparities and ensure equitable access to vaccines for 
   all children. Referring to our first interactive page, we have coded a map 
   that is color coded according to whether or not a country is above the average 
   DTP3 vaccination rate (specifically for children ages 1-3). This visual depicts 
   which countries are able to have access to healthcare and which countries 
   can access a high amount of DTP3 vaccine coverage."),
 tags$img(src = "conclusion_image_2"),
 p("In conclusion, our analysis highlights the critical role of vaccinations in 
   reducing child mortality and improving global health outcomes. By prioritizing 
   vaccination efforts, addressing regional disparities, and investing in health 
   systems, we can continue to make progress toward achieving universal 
   immunization coverage and saving millions of lives worldwide.")
)



ui <- navbarPage("Child Mortality and Vaccination",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
