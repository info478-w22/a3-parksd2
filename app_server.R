require(EpiModel)


server <- function(input, output) {
  
  output$intro <- renderText(paste("Both of the interactive COVID-19 models in
  this application use the same inputs. The variable the model uses are
  predetermined by the EpiModel package. The variables the model takes in are:
  inf.prob (probability of infection for any given interaction), act.rate (
  rate of human activity per time interval), and the two initial condition
  variables are s.num (number of initially susceptible individuals), and i.num
  (number of initially infected individuals). The user will be able to input
  conditions for all of these variables, with the exception of s.num, because
  it has not real impact on the outcome of the model, so it remains constant at
  10,000 individuals. Instead of the user deciding the exact numeric input of
  each variable, drop down selections are available allowing them to change the
  conditions of the public response and safety measures, such as the level of
  implemeneted lockdown or stay at home orders (tied to act.rate), and the
  proportion of mask wearing and social distancing (tied to inf.prob). Users can
  also alter the intital prevalence of the virus (tied to i.num)."))
  
  
  output$research <- renderText(paste('The differing levels of public health
  measures that are tied to different values of variable inputs into the models
  have a basis in research that has been done on the spread of COVID-19. The
  impact that the usage of masks and participating in social distancing has on
  the spread of covid has been heavily researched. An article in "Scientific
  Reports Journal" (https://www.nature.com/articles/s41591-020-1132-9) looks at
  just how much these measures can limit spread. The models relies on their
  overall findings that spread increases as the proportion of individuals not
  wearing face masks increases, and that spread is even further reduced by
  combining face masks with social distancing practices. This enables the
  inf.prob variable to be linked to the significance of saftey measures in
  place, and the input by the user to be 5 categories ranging from "No Social
  Distancing without Masks" to "Strict Social Distancing with Everyone Wearing
  Masks". The presence and severity of any lock-down or stay-at-home mandates
  also influences spread as a result of its impact on activity, which in turn
  allows the act.rate variable to be linked the level of lockdown a specific
  area decides upon and abides by. More research has been done on the impact
  of these mandates and mask wearing, published in "Nature Medicine" journal (
  https://www.nature.com/articles/s41591-020-1132-9).'))
  
  
  output$determ_plot <- renderPlot({
    
    param <- param.dcm(inf.prob = as.numeric(input$inf_prob),
                       act.rate = as.numeric(input$act_rate))
  
    init <- init.dcm(s.num = 1000, i.num = as.numeric(input$infected))
  
    control <- control.dcm(type = "SI", nsteps = 500)
  
    mod <- dcm(param, init, control)
  
    plot(mod)
  })
  
  output$determ_interpretation <- renderText(paste("The initialized settings of
  the deterministic models inputs are all of the moderate levels. This outputs
  a plot where number infected increases very rapidly, getting up to 100%
  infection in around 100 time units. Altering the initial infected population
  does not impact the general path of the model, simply delaying or expiditing
  the process slightly. What makes more significant differences in the outcome
  of spread is the alteration of public health safety measures. Without any 
  restrictions and safety measures, the spread of the virus is incredibly rapid
  at any starting infection level. When comparing the impact of masks and social
  distancing with lockdowns (lowered activity rate), lockdowns seem to be more
  effective in slowing spread. However, if only one of these is implemented as
  a safety measure the infections still increase quite rapidly. It is only when
  they are combined that significant resistance of spread is seen. When
  combining the two most strict measures, the spread is decelerated to a point
  where even at very high levels of intial infection, it takes over 400 time
  units for the model to show that the infected number of people is higher than
  the suseceptible amount. When initial infections is as low as 1, these strict
  measures essentially prevent any noticable spread within 500 time units."))
  
  output$sto_plot <- renderPlot({
    
    param_sto <- param.icm(inf.prob = as.numeric(input$sto_inf_prob),
                           act.rate = as.numeric(input$sto_act_rate))
    
    init_sto <- init.icm(s.num = 1000, as.numeric(input$sto_infected))
    
    control_sto <- control.icm(type = "SI", nsims = 10, nsteps = 500)
    
    mod_sto <- icm(param, init, control)
    
    plot(mod_sto)
    
  })
  
  output$sto_interpretation <- renderText(paste("The stochastic model uses the
  exact same input parameters as the deterministic model, but changes in these
  inputs are much less impactful on the output of the model. This is likely a
  result of the stochastic model operating with individuals as the units, rather
  than a population, as well as the different interpretation of time between
  the two models. The individual variance of the stochastic model makes the
  public health measures rather ineffective compared to the deterministic model
  where the entire aggregate population can be controlled. The stochastic
  model's output also allows for a uncertainty of outcome, which can be clearly
  seen when all inputs are set to 'moderate', which shows the variance that
  exists when using discrete time intervals and individual representation."))
  
  output$limitations <- renderText(paste("The main limiatations of these models
  is that the inputs are not perfectly correlated with the variable parameters
  that the model takes, so it is not really possible to make a model that
  accurately represents the true impact of these measures. What modelling allows
  for though is seeing the potential outcomes of different scenarios when the
  future outcome is very uncertain. This is where the stochastic model has an
  advantage over the deterministic model because it sets a wider range of
  outcomes based on its structure. Whereas, the deterministic model produces
  and exact estimate that has the potential to be significantly off based on
  just one input."))
  
}