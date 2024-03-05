# install.packages("tidyverse")
# install.packages("sf")
# install.packages("rnaturalearth")
# install.packages("countrycode")
# install.packages("ggrepel")

library(ggplot2)
library(plotly)
library(dplyr)
library("tidyverse")
library("sf")
library("rnaturalearth")
library("rnaturalearth")
library("countrycode")
library("ggrepel")


filtered_df <- read.csv("vaccination_mortality_df.csv")
server <- function(input, output){
  
  
  observe({
    world <- ne_countries(scale = "small", returnclass = "sf")
    
    output$dtp_vaccination <- renderPlotly({
      
      data <- filtered_df %>%
        select(Country, AboveAvgVaccination) %>%
        separate_rows(Country, sep = " and ") 
      
      data_with_iso <- data %>%
        mutate(Iso3= countrycode::countrycode(
          Country, 
          "country.name", 
          "iso3c")
        ) %>% filter(!is.na(Iso3))
      
      countries_Use <- world %>%
        select(geometry, name, iso_a3) %>%
        left_join(data_with_iso, by = c("iso_a3" = "Iso3")) %>%
        filter(AboveAvgVaccination == toupper(input$country_))
      
      my_plot <- world %>%
        st_transform(crs = "+proj=robin") %>%
        ggplot() +
        geom_sf(color = "darkgrey") + 
        geom_sf(data = countries_Use, aes(fill = AboveAvgVaccination)) +
        theme_minimal() + 
        guides(fill = FALSE)
      return (ggplotly(my_plot))
    })
    
    user_country_choice <- input$county_postneo_DTP
    indvidual_country_df <- filter(filtered_df, Country == user_country_choice)
    
    output$country_postneonatal_rate<- renderPlotly({
      my_postneo_rate <- ggplot(indvidual_country_df, aes(x=Country, y = Postneonatal)) +
        geom_bar(stat = "identity", width = .2, fill = "red") +
        labs(title = paste("Postneonatal Mortality for", user_country_choice))
      return (ggplotly(my_postneo_rate))
    })
    
    output$country_dtp_rate<- renderPlotly({
      my_dtp_rate <- ggplot(indvidual_country_df, aes(x= Country, y = DTP3)) +
        geom_bar(stat = "identity", width = .2, fill = "blue") +
        labs(title = paste("DTP3 Rate for", user_country_choice))
      return (ggplotly(my_dtp_rate))
    })
      
    output$death_per_100<- renderPlotly({
      
      data <- filtered_df %>%
        select(Country, died_per_shot_not_taken) %>%
        separate_rows(Country, sep = " and ") 
      
      data_with_iso <- data %>%
        mutate(Iso3= countrycode::countrycode(
          Country, 
          "country.name", 
          "iso3c")
        ) %>% filter(!is.na(Iso3))
      
      countries_Use <- world %>%
        select(geometry, name, iso_a3) %>%
        left_join(data_with_iso, by = c("iso_a3" = "Iso3")) %>%
        filter(died_per_shot_not_taken == input$death_choice)
      
      death_rate_per_country <- world %>%
        st_transform(crs = "+proj=robin") %>%
        ggplot() +
        geom_sf(color = "darkgrey") + 
        geom_sf(data = countries_Use, aes(fill = died_per_shot_not_taken)) +
        theme_minimal() + 
        guides(fill = FALSE)
      return (ggplotly(death_rate_per_country))
    })
    
  })
    
}
