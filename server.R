library(ggplot2)
library(plotly)
library(dplyr)
filtered_df <- read.csv("vaccination_mortality_df.csv")
server <- function(input, output){
  
  # TODO Make outputs based on the UI inputs here
  output$your_viz_1_output_id <- renderPlotly({
    my_plot <- ggplot(data = filtered_df) +
    geom_line(mapping = 
                aes(x = Country, 
                    y = DTP3))
    return (ggplotly(my_plot))
  })
  
  observe({
    
    user_country_choice <- input$county_postneo_DTP
    indvidual_country_df <- filter(filtered_df, Country == user_country_choice)
    
    output$country_postneonatal_rate<- renderPlotly({
      my_postneo_rate <- ggplot(indvidual_country_df, aes(x=Country, y = Postneonatal)) +
        geom_bar(stat = "identity", width = .2, fill = "red") +
        labs(title = paste("Postneonatal Mortality for ", user_country_choice))
      return (ggplotly(my_postneo_rate))
    })
    
    output$country_dtp_rate<- renderPlotly({
      my_dtp_rate <- ggplot(indvidual_country_df, aes(x=Country, y = DTP3)) +
        geom_bar(stat = "identity", width = .2, fill = "blue") +
        labs(title = paste("DTP3 Rate for ", user_country_choice))
      return (ggplotly(my_dtp_rate))
    })
    
  })
  
}