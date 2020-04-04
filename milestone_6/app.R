

library(shiny)

# Underneath library(), I used to have all of my code from my RMD from 
# milestone 5 that gave me all the votes_cast data. I talked with one of the
# CAs (Yao) and he told me that if I had all of my code on here, my app
# wouldn't run correctly, which it wasn't. Once I used readRDS, my shiny app
# ran much faster and my code worked correctly.

final_votes <- readRDS("votes_cast_voting_age_2018.RDS")
numeric_votes <- readRDS("votes_cast_voting_age_2018_numeric.RDS")
character_votes <- readRDS("votes_cast_voting_age_2018_character.RDS")
options(scipen = 999)

# I came into this shiny app with the goal of, first, successfully creating
# a shiny app, and second, making it so the person could choose both what
# state would appear on the x axis and what variable they want to measure on 
# the y axis. Unfortunately, I wasn't able to attain my second goal because of
# some coding problems that I will elucidate later.

ui <- fluidPage(
    
    
    titlePanel("Votes Cast by Voting Age 2018"),
    
    # This sidebar layout I put in place just to show that I know how to use
    # shiny functions, and because I thought it was fun to do. This is a multi-
    # optioned checkbox function.
    
    sidebarLayout(
        sidebarPanel(
            helpText("Examine voting with 
               voting data from 2018."),
            fluidRow(
                column(5,
                       checkboxGroupInput("checkGroup", 
                                          h3("Does This Checkbox Say CT?"),
                                          choices = list("CT" = 1,
                                                         "Yes" = 2,
                                                         "No" = 3,
                                                         "I mean, one of them does..." = 4,
                                                         "I am extremely confused by your question" = 5)))
            )
            
            # The code below was what I originaly had for fluidRow and for selectInput.
            # The code is correct in that I produced two boxes where you can specify what 
            # state you would like to look at and a separate box where you can choose what
            # variable you want on the y-axis. At first, the values of my y-variable didn't
            # show up on the y-axis, at which point I got on zoom with Yao so we could
            # figure it out. On a side note, Yao is awesome and has helped me thoguh a lot
            # this semester, and I am extremely grateful. We eventually got that problem
            # sorted out after using pivot_longer and by using filter, which was really
            # helpful. However, we still faced the problem that the numbers wouldn't change
            # when I changed the state, meaning the numbers were consistent across all the
            # y variables for all the states, which is simply incorrect.
            
            # fluidRow(selectInput("state", "Choose a state:", final_votes$state_abbreviation),
            # selectInput("y_var", "Choose what you want to measure:", choices = c(colnames(final_votes))))
        ),
        
        mainPanel(
            plotOutput("voting_data"),
            br(), br(),
            tableOutput("results")
        )
    )
)

# Unfortunately, Yao and I couldn't figure out why the y variables were staying
# the same, and so he suggested that I plot one state and one variable for this
# milestone. So, I decided to choose my home state of Connecticut and the
# variable Votes Cast to plot for this milestone. I am hoping I can go to June
# sometime in the near future to figure out what went wrong and to fix it.

server <- function(input, output) {
    output$voting_data <- renderPlot({
        final_votes %>%
            # pivot_longer(cols = `Votes Cast`:`Margin of Error for Voting Rate`, names_to = "variables", values_to = "n") %>%
            # filter(variables == input$y_var) %>%
            filter(state_abbreviation == "CT") %>%
            ggplot(aes(state_abbreviation, `Votes Cast`)) + 
            geom_bar(stat = "identity") + theme_classic() +
            labs(
                title = "Votes Cast by Connecticut in 2018",
                x = "State (Connecticut)",
                y = "Votes Cast"
            )
    })
}

shinyApp(ui = ui, server = server)

