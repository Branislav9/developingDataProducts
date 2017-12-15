library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {

        output$plot1<-renderPlot({
        
                #filtering data according to class of a car
                
                mpgf<- filter(mpg, grepl(input$class1, class))
                               
                
                #slider input
                displInput<-input$sliderDispl
                
                #build linear regression model
                model1<-lm(cty~displ, data = mpgf)
                model2<-lm(hwy~displ, data = mpgf)
                
                #prediction of mileage in city
                model1pred<-reactive({
                        displInput<-input$sliderDispl
                        predict(model1, newdata=data.frame(displ=displInput, class=input$class1))
                })
                
                #prediction of mileage on highway
                model2pred<-reactive({
                        displInput<-input$sliderDispl
                        predict(model2, newdata=data.frame(displ=displInput, class=input$class1))
                })
                
                #building a plot using basic plot
                plot(mpgf$displ, mpgf$cty, xlab = "Displacement", ylab = "Miles Per Gallon", bty="l", pch=16, xlim = c(0, 7), ylim = c(0, 50))
                
                if(input$showModel1){
                        abline(model1, col="red", lwd=2)
                }
                
                if(input$showModel2){
                        model2lines<-predict(model2, newdata=data.frame(displ=0:7))
                        lines(0:7, model2lines, col="green", lwd=2)
                }
                
                if(input$showPred){
                        abline(v=input$sliderDispl, col="blue")
                }
                
                if(input$showModel1 | input$showModel2){
                        legend(5, 50, c(if(input$showModel1){"City MPG"}, if(input$showModel2){"Highway MPG"}), pch = 18, 
                       col = c(if(input$showModel1){"red"}, if(input$showModel2){"green"}), bty = "n", cex = 1.5)
                }
                
                
                if(input$showModel1){
                        points(displInput, model1pred(), col="red", pch=18, cex=2.5)
                }
                
                if(input$showModel2){
                        points(displInput, model2pred(), col="green", pch=18, cex=2.5)
                }
        })
        
        #renders predictions below the graph as a text
                output$pred1<-renderText({
                
                mpgf<-filter(mpg, grepl(input$class1, class))
                
                model1<-lm(cty~displ, data = mpgf)
                
                model1pred<-reactive({
                        displInput<-input$sliderDispl
                        predict(model1, newdata=data.frame(displ=displInput, class=input$class1))
                        })
                model1pred()
        })
        
        output$pred2<-renderText({
                
                mpgf<-filter(mpg, grepl(input$class1, class))
                
                model2<-lm(hwy~displ, data = mpgf)
                
                model2pred<-reactive({
                        displInput<-input$sliderDispl
                        predict(model2, newdata=data.frame(displ=displInput, class=input$class1))
                })
                model2pred()
        })
})
