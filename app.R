

####  Importing Libraries and Data Frames 

source("Libraries&DataFrames.R")



#### UI ####

ui <- dashboardPage(
  
  #skin = "blue",
  #preloader = list(html = tagList(waiter::spin_1(), "Cargando ..."), color = "#3c8dbc"),
  #footer = dashboardFooter(left = "By Divad Nojnarg",right = "Zurich, 2019"),
  
  header = dashboardHeaderPlus(
    fixed = TRUE,
    title = customLogo,
    ####  INPUT_0  ####
    left_menu = tagList(
      dropdownBlock(
        id = 1,
        title = "Filtro por Jugadores",
        badgeStatus = NULL,
        icon = "users",
        br(),
        selectInput(
          inputId = 'CategoryInput_tab1', 
          label = "Selección del Plantel",
          choices = levels(df_CED$Categoría),
          selected = "Plantel Adulto Masculino"
        ),
        materialSwitch(inputId = "Player_tab1", 
                       label = strong("Análisis por Jugador"),
                       status = "primary",
                       right = TRUE
        ),
        conditionalPanel(
          condition = "input.Player_tab1 == true",
          uiOutput("playerOption")
        ),
        br()
      ),
      dropdownBlock(
        id = 2,
        title = "Filtro por Fecha",
        icon = "calendar-alt",
        badgeStatus = NULL,
        br(),
        dateInput(
          inputId = "timeFrom_tab1", 
          label = "desde:",
          value = min(date.range_tab1),
          min = NULL,
          max = NULL,
          startview = "month",
          language = "es"
        ),
        dateInput(
          inputId = "timeTo_tab1", 
          label = "hasta:",
          value = max(date.range_tab1),
          min = NULL,
          max = NULL,
          startview = "month",
          language = "es"
        ),
        br()
      )
    ),
    ####  NOTIF  ####
    dropdownMenu(
      type = "notification", 
      icon = icon("info"), 
      badgeStatus = "danger",
      notificationItem(
        text = not1,
        icon = icon("")
      ),
      notificationItem(
        text = not2,
        icon = icon("")
      ),
      notificationItem(
        text = not3,
        icon = icon("")
      ),
      notificationItem(
        text = not4,
        icon = icon("")
      ),
      notificationItem(
        text = not5,
        icon = icon("")
      )
    )
  ),
  
  sidebar = dashboardSidebar(
    collapsed = TRUE,
    sidebarMenu(
      menuItem("Estadística Descriptiva", tabName="tab_1", icon=icon("chart-bar"))
    )
  ),
  # linear-gradient(#FFFFFF, #E0E0E0)
  body = dashboardBody(
    
    tags$head(tags$style(HTML(css))),
    
    tabItems(
      #### ----------------------------------- TAB_1 ----------------------------------- #### 
      tabItem(tabName = "tab_1",
              ####  __ 0 ROW  ####
              br(),
              br(),
              br(),
              br(),
              fluidRow(
                ####  VB  ####
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab1.1"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab1.2"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab1.3"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab1.4"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab1.5"
                  )
                )
              ),
              ####  __ 1 ROW  ####
              br(),
              br(),
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4, 
                  align = "center",
                  box(
                    width = 12, 
                    background = "blue",
                    HTML("<h3><center><b>Mediciones Diarias</b></h3>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              fluidRow(
                ####  TAB_1.1.1  ####
                boxPlus(
                  width = 3,
                  title = "Error del Promedio", 
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    withSpinner(
                      plotlyOutput("Plot_tab1.1.1", height="350px"),
                      type = 6,
                      color = "#0D9AE0DA",
                      size = 0.7
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab1.1.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    )
                  )
                ),
                ####  TAB_1.1.2  ####
                boxPlus(
                  width = 4,
                  title = "Gráfica de Densidad", 
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    withSpinner(
                      plotlyOutput("Plot_tab1.1.2", height="350px"),
                      type = 6,
                      color = "#0D9AE0DA",
                      size = 0.7
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab1.1.2_HELP",
                      label = "",
                      icon = icon("question-circle")
                    )
                  )
                ),
                ####  TAB_1.1.3  ####
                boxPlus(
                  width = 3,
                  title = "Diagrama de Caja ", 
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    withSpinner(
                      plotlyOutput("Plot_tab1.1.3", height="350px"),
                      type = 6,
                      color = "#0D9AE0DA",
                      size = 0.7
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab1.1.3_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    ####  TABLE_0  #### 
                    downloadButton("download_Table_tab0.xlsx", ".xlsx")
                  )
                ),
                boxPlus(
                  width = 2, 
                  solidHeader = TRUE,
                  title = "",
                  status = "primary",
                  column(
                    width = 12,
                    ####  INPUT_1.0  #### 
                    selectInput(
                      inputId = "yInput_tab1.0", 
                      label = "Tipo de Medición:",
                      choices = levels(df_MD$TipoMedición)[
                        levels(df_MD$TipoMedición) != "PCR"
                      ],
                      selected = "Peso (kg)"
                    ),
                    hr(),
                    selectInput(
                      inputId = "cInput_tab1.0", 
                      label = "Momento de Medición:",
                      choices = levels(df_MD$MomentoMedición),
                      selected = "Entrenamiento"
                    )
                  ),
                  collapsible = TRUE,
                  collapsed = FALSE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Input_tab1.0_HELP",
                      label = "",
                      icon = icon("file-alt")
                    )
                  )
                )
              ),
              fluidRow(
                column(
                  width = 12,
                  boxPlus(
                    width = 12,
                    title = "Tabla de Estadística Descriptiva", 
                    status = "primary", 
                    solidHeader = TRUE,
                    column(
                      width = 12,
                      ####  TABLE_1.0  #### 
                      withSpinner(
                        DT::dataTableOutput("Table_tab1.0"),
                        type = 6,
                        color = "#0D9AE0DA",
                        size = 0.7
                      )
                    ),
                    collapsible = TRUE,
                    closable = FALSE,
                    enable_dropdown = TRUE,
                    dropdown_icon = FALSE,
                    dropdown_menu = list(
                      actionButton(
                        inputId = "Table_tab1.0_HELP",
                        label = "",
                        icon = icon("question-circle")
                      ),
                      downloadButton("download_Table_tab1.0.xlsx", ".xlsx"),
                      downloadButton("download_Table_tab1.0.csv", ".csv")
                    )
                  )
                )
              ),
              ####  __ 2 ROW  ####
              br(),
              br(),
              fluidRow(
                column(
                  width = 3
                ),
                column(
                  width = 6, 
                  align = "center",
                  box(
                    width = 12, 
                    background = "blue",
                    HTML("<h3><center><b>Evento Clínico y Diagnóstico</b></h3>"),
                  )
                ),
                column(
                  width = 3
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_1.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Tabla Frecuencia de Combinadas", 
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    withSpinner(
                      DT::dataTableOutput("Table_tab1.1"),
                      type = 6,
                      color = "#0D9AE0DA",
                      size = 0.7
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Table_tab1.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab1.1_HELP",
                      label = "",
                      icon = icon("file-alt")
                    ),
                    # contol + shift + c
                    # actionBttn(
                    #   inputId = "Table_tab1.1_HELP",
                    #   label = "",
                    #   icon = icon("question-circle"),
                    #   size = "sm",
                    #   color = "primary",
                    #   style = "jelly"
                    # ),
                    # actionBttn(
                    #   inputId = "Input_tab1.1_HELP",
                    #   label = "",
                    #   icon = icon("file-alt"),
                    #   size = "sm",
                    #   color = "primary",
                    #   style = "jelly"
                    # ),
                    downloadButton("download_Table_tab1.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab1.1.csv", ".csv")
                  ),
                  enable_sidebar = TRUE,
                  sidebar_width = 25,
                  sidebar_background = "#0A0A0AAD",
                  sidebar_start_open = TRUE,
                  sidebar_icon = "sliders-h",
                  sidebar_content = tagList(
                    ####  INPUT_1.1  #### 
                    br(),
                    pickerInput(
                      inputId = 'cInput_tab1.1',
                      label = 'Variables Cruzadas',
                      multiple = TRUE,
                      choices = df.S.2,
                      selected = c("Diagnóstico","Complemento_II"),
                      options = list(`actions-box`=TRUE)
                    )
                  )
                )
              ),
              ####  __ 3 ROW  ####
              br(),
              fluidRow(
                ####  TAB_1.2.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Diagramas de Barras Múltiples",
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    withSpinner(
                      plotlyOutput("Plot_tab1.2.1", height="800px"),
                      type = 6,
                      color = "#0D9AE0DA",
                      size = 0.7
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab1.2.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab1.2_HELP",
                      label = "",
                      icon = icon("file-alt")
                    )
                  ),
                  enable_sidebar = TRUE,
                  sidebar_width = 25,
                  sidebar_background = "#0A0A0AAD",
                  sidebar_start_open = TRUE,
                  sidebar_icon = "sliders-h",
                  sidebar_content = tagList(
                    ####  INPUT_1.2  #### 
                    br(),
                    varSelectInput(
                      inputId = 'cInput_tab1.2',
                      label = 'Variable Eje X:',
                      data = df.S.1,
                      multiple = FALSE,
                      selectize = TRUE,
                      selected="Complemento_II"
                    ),
                    varSelectInput(
                      inputId = 'cInput_tab1.3',
                      label = 'Variable Color:',
                      data = df.S.1,
                      multiple = FALSE,
                      selectize = TRUE,
                      selected="MecanismoGeneral"
                    )
                  )
                )
              ),
              hr(),
              div(
                class = "footer",
                h4("Triceps MDA"),
                h5("Providencia, Chile"),
                HTML("<h6><i>Desarrollador</i>: davidignacioam@gmail.com</h6>")
              )
      )
    )
  )
)


server <- function(input, output, session) {
  
  ####  INTRO  #### 
  
  observeEvent("", {
    showModal(
      modalDialog(
        includeHTML("Modals/Introduction/Presentation.html"),
        easyClose = FALSE,
        footer = actionBttn(inputId="pres", 
                            label="Acepto los Términos señalados", 
                            icon = icon("exclamation-triangle"),
                            style = "fill", #stretch
                            color = "danger")
      )
    )
  }, once = TRUE)
  observeEvent(input$pres,{
    showModal(
      modalDialog(
        includeHTML("Modals/Introduction/Basics.html"),
        easyClose = FALSE,
        footer = actionBttn(inputId="intro", 
                            label="Vamos a analizar los datos !", 
                            icon = icon(""),
                            size = "md",
                            style = "fill", #stretch
                            color = "primary")
      )
    )
  })
  observeEvent(input$intro,{
    removeModal()
  })
  
  ####  DF_General  #### 
  df.tab1_MD <- reactive({
    if(input$Player_tab1){
      df_MD %>% filter(Categoría %in% input$CategoryInput_tab1,
                       FechaMedición >= input$timeFrom_tab1,
                       FechaMedición <= input$timeTo_tab1,
                       Jugador %in% input$PlayerInput_tab1)
    } else {
      df_MD %>% filter(Categoría %in% input$CategoryInput_tab1,
                       FechaMedición >= input$timeFrom_tab1,
                       FechaMedición <= input$timeTo_tab1)
    }
  })
  
  #### --------------------------- TAB_1 --------------------------- #### 
  
  ####  UI  ####
  levelsPlayers <- reactive({
    if(input$Player_tab1){
      df_MD %>% 
        filter(
          Categoría %in% input$CategoryInput_tab1,
          FechaMedición >= input$timeFrom_tab1,
          FechaMedición <= input$timeTo_tab1
        ) %>%
        select(Jugador) %>%
        unique()
    } 
  })
  output$playerOption <- renderUI({
    if(input$Player_tab1){
      selectInput(
        inputId = 'PlayerInput_tab1', 
        label = "Seleccione el Jugador",
        choices = levelsPlayers()
      )
    } 
  })
  
  ####  VB  #### 
  output$valuebox_tab1.1 <- renderValueBox({
    valueBox(
      df.tab1_CED() %>% 
        select(ID_EventoClínico) %>% 
        unique() %>% 
        nrow(),
      "Total de Eventos Clínicos", 
      icon = icon("file-medical-alt"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.2 <- renderValueBox({
    valueBox(
      df.tab1_CED() %>% 
        select(ID_Diagnóstico) %>% 
        unique() %>% 
        nrow(),
      "Total de Diagnósticos", 
      icon = icon("notes-medical"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.3 <- renderValueBox({
    valueBox(
      df.tab1_CED() %>% 
        select(ID_TratamientoKinésico) %>% 
        unique() %>% 
        nrow(),
      "Total de Tratamientos", 
      icon = icon("stethoscope"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.4 <- renderValueBox({
    valueBox(
      df.tab1_CED() %>% 
        select(ID_ObjetivoEvaluación) %>% 
        unique() %>% 
        nrow(),
      "Total de Evaluaciones", 
      icon = icon("user-md"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.5 <- renderValueBox({
    valueBox(
      df.tab1_CED() %>% 
        select(ID_Medicamento) %>% 
        filter(ID_Medicamento != "NULL") %>%
        nrow(),
      "Total de Medicamentos", 
      icon = icon("capsules"),
      color = "aqua"
    )
  })
  
  ## DF_tab1
  filtered_tab1.1 <- reactive({
    df.tab1_MD() %>% filter(TipoMedición %in% input$yInput_tab1.0,
                            MomentoMedición %in% input$cInput_tab1.0)
  })
  filtered_tab1.1.2 <- reactive({
    df.tab1_MD() %>% filter(MomentoMedición %in% input$cInput_tab1.0)
  })
  filtered_tab1.1.3 <- reactive({
    filtered_tab1.1() %>% 
      filter(
        ValorMedición %in% c(
          boxplot.stats(filtered_tab1.1()$ValorMedición)$out
        )
      ) %>%
      select(Jugador,MomentoMedición,TipoMedición,ValorMedición,FechaMedición) %>%
      arrange(ValorMedición)
  })
  
  ####  TAB_1.1.1 #### 
  output$Plot_tab1.1.1 <- renderPlotly({
    # Input Validation
    validate(need(!nrow(filtered_tab1.1()) < 2, 
                  message = na.time.med))
    # Creating Object
    Xvar <- select(filtered_tab1.1(), 'Xvar'=ValorMedición)
    summarise <- data.frame(mean = mean(Xvar$Xvar), 
                            sd = sd(Xvar$Xvar),
                            Var = 0, 
                            color = 0)
    for (i in seq(1, nrow(summarise), by=1)) {
      summarise$color[i] = if (summarise$mean[i]>2*summarise$sd[i]) { "black" } else { "red" } 
    }
    # Visualization
    ggplotly(
      ggplot(summarise) +
        geom_bar(aes(x = Var,
                     y = mean), 
                 stat = "identity", 
                 color="black",
                 size=.3,
                 fill = "#63D640D8") +
        geom_errorbar(aes(x = Var,
                          ymin = mean-sd, 
                          ymax = mean+sd), 
                      width = 0.1, 
                      alpha = 0.9, 
                      size = .6,
                      colour = ifelse(summarise$color=="black",
                                      "black","red")) +
        labs(x=NULL, y=NULL, fill=NULL) +
        theme(panel.grid.major.x = element_blank(),
              axis.text.x = element_blank(),
              panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA))
    ) %>%
      layout(showlegend = FALSE) %>%
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                   "zoomOut2d", "lasso2d", 
                                   "toggleSpikelines"), 
        toImageButtonOptions = list(
          format = "jpeg",
          filename = 
            paste(
              "Barras de Error Promedio de_", input$yInput_tab1.0, 
              "_del_", input$CategoryInput_tab1, 
              "_en_", input$cInput_tab1.0,
              "_con rango de fecha desde_", input$timeFrom_tab1, 
              "_hasta_", input$timeTo_tab1,
              sep = ""
            ),
          scale = 2
        )
      ) %>% toWebGL()
  }) 
  observeEvent(input$Plot_tab1.1.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.1.1_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
  ####  TAB_1.1.2  #### 
  output$Plot_tab1.1.2 <- renderPlotly({
    # Input Validation
    validate(need(!nrow(filtered_tab1.1()) < 2, 
                  na.time.med))
    # Creating Object
    filtered <- filtered_tab1.1()
    # Visualization
    ggplotly(
      ggplot(filtered, aes(x=ValorMedición)) +
        geom_density(aes(y=..density..), 
                     size=.3, 
                     fill="#F08482D8") +
        labs(x = NULL, y = NULL) +
        theme(panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA))
    ) %>%
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                   "zoomOut2d", "lasso2d", 
                                   "toggleSpikelines"), 
        toImageButtonOptions = list(
          format = "jpeg",
          filename = 
            paste(
              "Diagrama de Densidad de_", input$yInput_tab1.0, 
              "_del_", input$CategoryInput_tab1, 
              "_en_", input$cInput_tab1.0,
              "_con rango de fecha desde_", input$timeFrom_tab1, 
              "_hasta_", input$timeTo_tab1,
              sep = ""
            ),
          scale = 2
        )
      ) %>% toWebGL()
  })
  observeEvent(input$Plot_tab1.1.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.1.2_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
  ####  TAB_1.1.3  #### 
  output$Plot_tab1.1.3 <- renderPlotly({
    # Input Validation
    validate(need(!nrow(filtered_tab1.1()) < 2, 
                  na.time.med))
    # Creating Object
    filtered <- filtered_tab1.1()
    # Visualization
    ggplotly(
      ggplot(filtered, aes(x=factor(0), 
                           y=ValorMedición))+
        geom_boxplot(fill="#FF9A52D8", 
                     outlier.shape=1, 
                     outlier.size=.8,
                     size=.4) +
        labs(x = NULL, y = NULL) +
        theme(panel.grid.major.x = element_blank(),
              axis.text.x = element_blank(),
              panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA))
    ) %>%
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                   "zoomOut2d", "lasso2d", 
                                   "toggleSpikelines"), 
        toImageButtonOptions = list(
          format = "jpeg",
          filename = 
            paste(
              "Diagrama de Cajas de_", input$yInput_tab1.0, 
              "_del_", input$CategoryInput_tab1, 
              "_con rango de fecha desde_", input$timeFrom_tab1, 
              "_hasta_", input$timeTo_tab1,
              sep = ""
            ),
          scale = 2
        )
      ) %>% toWebGL()
  })
  observeEvent(input$Plot_tab1.1.3_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.1.3_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
  ####  TABLE_0  #### 
  output$download_Table_tab0.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player_tab1){
        paste(
          "Tabla con Datos Atítpicos de la medida_", input$yInput_tab1.0, 
          "_del Jugador_", input$PlayerInput_tab1, 
          "_del_", input$CategoryInput_tab1, 
          "_en_", input$cInput_tab1.0,
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".xlsx", sep = ""
        )
      } else {
        paste(
          "Tabla con Datos Atítpicos de la medida_", input$yInput_tab1.0, 
          "_del_", input$CategoryInput_tab1, 
          "_en_", input$cInput_tab1.0,
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".xlsx", sep = ""
        )
      }
    },
    content = function(file) {
      write.xlsx(filtered_tab1.1.3(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab0.csv <- downloadHandler(
    filename = function() {
      if(input$Player_tab1){
        paste(
          "Tabla con Datos Atítpicos de la medida_", input$yInput_tab1.0, 
          "_del Jugador_", input$PlayerInput_tab1, 
          "_del_", input$CategoryInput_tab1, 
          "_en_", input$cInput_tab1.0,
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".csv", sep = ""
        )
      } else {
        paste(
          "Tabla con Datos Atítpicos de la medida_", input$yInput_tab1.0, 
          "_del_", input$CategoryInput_tab1, 
          "_en_", input$cInput_tab1.0,
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".csv", sep = ""
        )
      }
    },
    content = function(file) {
      write.csv(filtered_tab1.1.3(), file, row.names = FALSE)
    }
  )
  
  ####  INPUT_1.0  #### 
  observeEvent(input$Input_tab1.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Input_tab1.0_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
  ####  TABLE_1.0  #### 
  Table_tab1.0 <- reactive({
    # Input Validation
    validate(need(!nrow(filtered_tab1.1.2()) < 2, 
                  na.time.med))
    # Creating Object
    filtered <- filtered_tab1.1.2()
    outliers <- filtered %>% 
      group_by(TipoMedición) %>% 
      summarise(
        boxplot.stats(ValorMedición)$out %>% 
          as.data.frame() %>% 
          count()
      ) %>%
      as.data.frame() 
    # Defining the Table 
    df_t <- 
      filtered %>%
      group_by(TipoMedición) %>%
      summarize(
        as.data.frame(
          psych::describe(ValorMedición, 
                          quant=c(.25,.75))
        )[,-c(1:2,6:7,13)]
      ) %>%
      mutate(
        Momento= input$cInput_tab1.0,
        Outliers = outliers$n
      ) %>%
      filter(TipoMedición != "PCR") %>% 
      relocate(
        TipoMedición, Momento, 
        "mean","median","sd","range", "Outliers", "min",
        "Q0.25","Q0.75","max","skew","kurtosis"
      ) %>% 
      as.data.frame() %>%
      rename("Promedio"=mean,
             "Mediana"=median,
             "Desv.Estan."=sd,
             "Rango"=range,
             "Min"=min,
             "Max"=max,
             "Skew"=skew,
             "Kurtosis"=kurtosis) 
    # Loop for removing decimals
    for (i in seq(3, ncol(df_t), by=1)) {
      df_t[,i] <- df_t[,i] %>% as.numeric() %>% round(2)
    }
    df_t[,1] <- droplevels(df_t[,1], exclude="PCR")
    # Showing the final Object
    df_t
  })
  output$Table_tab1.0 <- DT::renderDataTable({
    DT::datatable(
      Table_tab1.0() %>% select(!Momento), 
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",    
      filter = 'top',
      options=list(
        searching=TRUE, scrollCollapse=TRUE,
        scrollX='400px', scrollY="150px", 
        paging=FALSE, info=FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) %>% 
      formatStyle(
        'Skew', #fontWeight = 'bold',
        color = styleInterval(0, c('blue', 'red'))
      ) %>% 
      formatStyle(
        'Kurtosis', #fontWeight = 'bold',
        color = styleInterval(0, c('red', 'blue'))
      ) 
  })
  output$download_Table_tab1.0.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player_tab1){
        paste(
          "Tabla Medidas Estadísticas del Jugador_", input$PlayerInput_tab1, 
          "_del_", input$CategoryInput_tab1, 
          "_en_", input$cInput_tab1.0,
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".xlsx", sep = ""
        )
      } else {
        paste(
          "Tabla Medidas Estadísticas del_", input$CategoryInput_tab1, 
          "_en_", input$cInput_tab1.0,
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".xlsx", sep = ""
        )
      }
    },
    content = function(file) {
      write.xlsx(Table_tab1.0(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.0.csv <- downloadHandler(
    filename = function() {
      if(input$Player_tab1){
        paste(
          "Tabla Medidas Estadísticas del Jugador_", input$PlayerInput_tab1, 
          "_del_", input$CategoryInput_tab1, 
          "_en_", input$cInput_tab1.0,
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".csv", sep = ""
        )
      } else {
        paste(
          "Tabla Medidas Estadísticas del_", input$CategoryInput_tab1, 
          "_en_", input$cInput_tab1.0,
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".csv", sep = ""
        )
      }
    },
    content = function(file) {
      write.csv(Table_tab1.0(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab1.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Table_tab1.0_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
  ####  DF.2_MD  #### 
  df.tab1_CED <- reactive({
    if(input$Player_tab1){
      df_CED %>% filter(Categoría %in% input$CategoryInput_tab1,
                        FechaDiagnóstico >= input$timeFrom_tab1,
                        FechaDiagnóstico <= input$timeTo_tab1,
                        Jugador %in% input$PlayerInput_tab1)
    } else {
      df_CED %>% filter(Categoría %in% input$CategoryInput_tab1,
                        FechaDiagnóstico >= input$timeFrom_tab1,
                        FechaDiagnóstico <= input$timeTo_tab1)
    }
  })
  
  ####  TABLE_1.1  #### 
  Table_tab1.1 <- reactive({
    # Input Validation
    validate(need(nrow(df.tab1_CED()) != 0, 
                  na.time.med))
    validate(need(!is.na(input$cInput_tab1.1), 
                  na.cat))
    # Creating Df Object
    filtered <- df.tab1_CED() %>%
      select(as.character(input$cInput_tab1.1))
    # Internal Validation
    validate(need(nrow(filtered) != 0, 
                  na.time))
    # Building the Table 
    table.DF <- 
      table(filtered) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(
        Freq != 0
      ) %>% 
      rename("Frecuencia"=Freq)
    # Droping levels
    for (i in seq(1, (ncol(table.DF)-1), by=1)) {
      table.DF[,i] <- droplevels(table.DF[,i], exclude="NULL")
    }
    # Final table
    table.DF %>% 
      tidyr::drop_na() %>% 
      mutate(
        Porcentage=round(Frecuencia/sum(Frecuencia),2)
      )
  }) 
  output$Table_tab1.1 <- DT::renderDataTable({
    DT::datatable(
      Table_tab1.1(), 
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      filter = 'top',
      options=list(
        searching=TRUE, scrollCollapse=TRUE,
        scrollX='400px', scrollY="420px",
        paging=FALSE, info=FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) %>% 
      formatPercentage("Porcentage") %>%
      formatStyle(
        'Porcentage',
        background = styleColorBar(Table_tab1.1()$Porcentage, 'lightblue'),
        backgroundSize = '40%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      )
  })
  output$download_Table_tab1.1.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player_tab1){
        paste(
          "Tabla de Frecuencias Combinadas del Jugador_", input$PlayerInput_tab1, 
          "_del_", input$CategoryInput_tab1, 
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frecuencias Combinadas del_", input$CategoryInput_tab1, 
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(Table_tab1.1(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.1.csv <- downloadHandler(
    filename = function() {
      if(input$Player_tab1){
        paste(
          "Tabla de Frecuencias Combinadas del Jugador_", input$PlayerInput_tab1, 
          "_del_", input$CategoryInput_tab1, 
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frecuencias Combinadas del_", input$CategoryInput_tab1, 
          "_con rango de fecha desde_", input$timeFrom_tab1, 
          "_hasta_", input$timeTo_tab1,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(Table_tab1.1(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab1.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Table_tab1.1_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
  ####  INPUT_1.1  #### 
  observeEvent(input$Input_tab1.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Input_tab1.1_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
  ####  TAB_1.2.1  #### 
  output$Plot_tab1.2.1 <- renderPlotly({
    # Input Validation
    validate(need(nrow(df.tab1_CED()) != 0, 
                  na.time))
    # Creating Df Object
    filtered <- df.tab1_CED() %>%
      select(input$cInput_tab1.2,input$cInput_tab1.3)
    filtered[filtered == "NULL"] <- NA
    filtered <- filtered %>% tidyr::drop_na()
    # Internal Validation
    validate(
      need(nrow(filtered) != 0, 
           na.time
      )
    )
    # Visualization
    ggplotly(
      ggplot(filtered, aes(x=!!input$cInput_tab1.2, 
                           fill=!!input$cInput_tab1.3)) +
        geom_bar(stat="count", alpha=.7, width=.7, 
                 color="black", size=.3) +
        labs(x=NULL, y=NULL, fill=NULL) +
        #scale_fill_brewer(palette = "Paired") +
        #scale_color_gradientn(colours = rainbow(18)) +
        theme(panel.grid.major.x = element_blank(),
              axis.text.x=element_text(angle=45, hjust=1),
              panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA)) 
    )  %>% 
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                   "zoomOut2d", "lasso2d", 
                                   "toggleSpikelines"), 
        toImageButtonOptions = list(
          format = "jpeg",
          filename = 
            paste(
              "Diagrama de Densidad de_", input$cInput_tab1.2, 
              "_con_", input$cInput_tab1.3, 
              "_del_", input$CategoryInput_tab1, 
              "_con rango de fecha desde_", input$timeFrom_tab1, 
              "_hasta_", input$timeTo_tab1,
              sep = ""
            ),
          scale = 2
        )
      )
  }) 
  observeEvent(input$Plot_tab1.2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.2.1_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
  ####  INPUT_1.2  #### 
  observeEvent(input$Input_tab1.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Input_tab1.2_HELP.html"),
        easyClose = TRUE,
        size = "l",
        footer = ""
      )
    )
  })
  
}

####  INTERFACE  #### 

shinyApp(ui = ui, server = server)








