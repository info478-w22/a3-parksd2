require(EpiModel)



param <- param.icm(inf.prob = 0.2, act.rate = 0.25)
init <- init.icm(s.num = 500, i.num = 1)
control <- control.icm(type = "SI", nsims = 10, nsteps = 300)
mod <- icm(param, init, control)

plot(mod)

plot(mod, y = "i.num", sim.lines = TRUE, mean.smooth = FALSE, qnts.smooth = FALSE)

# introduction

intro_page <- tabPanel(
  "Introduction",
  mainPanel(
    h3("Introduction of Models and Context from Research"),
    textOutput('intro'),
    br(),
    textOutput('research')
  )
)

# deterministic model example

inf_prob_input <- selectInput(
  "inf_prob",
  label = h5("Public Health Safety Measures
             (Probability of Infection Per Interaction)"),
  choices = c("Strict Social Distancing with Everyone Wearing Masks
              (very low probability)" = 0.05,
              "Social Distancing with Majority of Individuals Wearing Masks
              (low probability)" = 0.1,
              "Limited Social Distancing with Minority of Individuals Wearing
              Masks (moderate probability)" = 0.15,
              "Limited Social Distancing without Masks
              (high probability)" = 0.2,
              "No Social Distancing without Masks
              (very high probability)" = 0.25),
  selected = 0.15)
  
act_rate_input <- selectInput(
  "act_rate",
  label = h5("Levels of Lockdown Restrictions"),
  choices = c("Extreme Lockdown Restrictions
              (extremely lowered activity)" = 0.1,
              "High Lockdown Restrictions
              (significantly lowered activity)" = 0.2,
              "Moderate Lockdown Restriction
              (moderately lowered activity)" = 0.5,
              "Mild Lockdown Restrictions
              (mildly lowered activity)" = 0.75,
              "No Lockdown Restrictions (normal activity)" = 1),
  selected = 0.5)

infected_input <- selectInput(
  "infected",
  label = h5("Prevalence of Initial COVID-19 Infections"),
  choices = c("Very Low Population of Initial Infected Individuals (n=1)" = 1,
              "Low Population of Initial Infected Individuals (n=10)" = 10,
              "Moderate Population of Initial Infected Individuals (n=25)" = 25,
              "High Population of Initial Infected Individuals (n=50)" = 50,
              "Very High Population of Initial Infected Individuals
              (n=100)" = 100),
  selected = 25)
  
determ_page <- tabPanel(
  "Deterministic Model",
  sidebarLayout(
    sidebarPanel(
      inf_prob_input,
      act_rate_input,
      infected_input
    ),
    mainPanel(
      plotOutput("determ_plot")
    )
  )
)
  
# stochastic model

inf_prob_sto_input <- selectInput(
  "sto_inf_prob",
  label = h5("Public Health Safety Measures
             (Probability of Infection Per Interaction)"),
  choices = c("Strict Social Distancing with Everyone Wearing Masks
              (very low probability)" = 0.05,
              "Social Distancing with Majority of Individuals Wearing Masks
              (low probability)" = 0.1,
              "Limited Social Distancing with Minority of Individuals Wearing
              Masks (moderate probability)" = 0.15,
              "Limited Social Distancing without Masks
              (high probability)" = 0.2,
              "No Social Distancing without Masks
              (very high probability)" = 0.25),
  selected = 0.15)

act_rate_sto_input <- selectInput(
  "sto_act_rate",
  label = h5("Levels of Lockdown Restrictions"),
  choices = c("Extreme Lockdown Restrictions
              (extremely lowered activity)" = 0.1,
              "High Lockdown Restrictions
              (significantly lowered activity)" = 0.2,
              "Moderate Lockdown Restriction
              (moderately lowered activity)" = 0.5,
              "Mild Lockdown Restrictions (mildly lowered activity)" = 0.75,
              "No Lockdown Restrictions (normal activity)" = 1),
  selected = 0.5)


infected_sto_input <- selectInput(
  "sto_infected",
  label = h5("Prevalence of Initial COVID-19 Infections"),
  choices = c("Very Low Population of Initial Infected Individuals (n=1)" = 1,
              "Low Population of Initial Infected Individuals (n=10)" = 10,
              "Moderate Population of Initial Infected Individuals (n=25)" = 25,
              "High Population of Initial Infected Individuals (n=50)" = 50,
              "Very High Population of Initial Infected Individuals
              (n=100)" = 100),
  selected = 25)

sto_page <- tabPanel(
  "Stochastic Model",
  sidebarLayout(
    sidebarPanel(
      inf_prob_sto_input,
      act_rate_sto_input,
      infected_sto_input
    ),
    mainPanel(
      plotOutput("sto_plot")
    )
  )
)

# interpretation

interpretation_page <- tabPanel(
  "Interpretation",
    mainPanel(
      h3("Interpretation of Results"),
      textOutput('determ_interpretation'),
      br(),
      textOutput(("sto_interpretation")),
      br(),
      textOutput('limitations')
    )
  )

# ui

ui <- navbarPage(
  "COVID-19 Models",
  intro_page,
  determ_page,
  sto_page,
  interpretation_page
)
