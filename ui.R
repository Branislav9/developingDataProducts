library(shiny)
library(ggplot2)

shinyUI(fluidPage(
        titlePanel("Predict MPG from Displacement"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderDispl", "What is the displacement of the car?", 1, 7, step= 0.1, value = 3),
                        selectInput("class1", "Car Class", mpg$class),
                        checkboxInput("showModel1", "Show/Hide city model", value=TRUE),
                        checkboxInput("showModel2", "Show/Hide highway model", value=TRUE),
                        checkboxInput("showPred", "Show/Hide input line", value = TRUE)
                ),
                mainPanel(
                        plotOutput("plot1"),
                        h4("Predicted MPG in city:"),
                        h3(textOutput("pred1")),
                        h4("Predicted MPG on highway:"),
                        h3(textOutput("pred2"))
                )
        )
))