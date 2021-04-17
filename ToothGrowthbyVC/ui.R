#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Choose Plot Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("selectX",
                        label = "Dose Levels of Supplement Vitamin C (milligrams/day):",
                        choices = c("All" = "",0.5,1,2),
                        selected =  "",
                        selectize = FALSE),
            radioButtons("vcCheckboxGroup", "Supplement Delivery Methods:",
                         c("Orange Juice - OJ", "Ascorbic Acid - VC", "Both"),
                         selected = "Both"),
            checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
            checkboxInput("show_ylab", "Show/Hide y Axis Label", value = TRUE),
            checkboxInput("show_title", "Show/Hide Title", value = TRUE)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("Plot1"),
            h4("The Supplement Dose (grams/day):"),
            textOutput("text1")
        )
    )
))
