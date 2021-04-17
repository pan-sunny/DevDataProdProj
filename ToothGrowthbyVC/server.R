#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
data("ToothGrowth")
options(scipen = 200)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    selectedDose <- reactive({as.numeric(input$selectX)/1000})
    output$text1 <- renderText(selectedDose())
    output$Plot1 <- renderPlot({
        set.seed(2021-04-14)
        mydata <- ToothGrowth
        vcDose <- input$selectX
        if (vcDose != ""){
                mydata <- mydata %>% filter(dose == as.numeric(input$selectX))
        } 
        else if (input$selectX == ""){
                mydata <- mydata
        }

        vcType <- input$vcCheckboxGroup
        if (vcType == "Orange Juice - OJ"){
              vcType = "OJ"
        } 
        else if (vcType == "Ascorbic Acid - VC"){
              vcType = "VC" 
        }
        else if (vcType == "Both"){
                vcType = c("OJ", "VC")
        }
        
        mydata <- mydata %>%
                filter(supp %in% vcType) %>%
                group_by(dose, supp) %>%
                summarise(meanLen = mean(len))
        
        xlab <- ifelse(input$show_xlab, "Supplement Vitamin C Dose (milligrams/day)", "")
        ylab <- ifelse(input$show_ylab, "ToothGrowth Length", "")
        main <- ifelse(input$show_title, "The Effect of VitaminC on ToothGrowth in Guinea Pigs", "")

        # draw the plot with the specified data
        ggplot(mydata, aes(x=as.factor(dose), y=meanLen, fill=supp))+
                geom_bar(stat = "identity", width=0.5, position = "dodge")+
                labs(x = xlab,y = ylab, title = main)+
                geom_text(aes(label = meanLen),position=position_dodge(width = 0.5),size = 3,vjust = -0.25)

    })


})
