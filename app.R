
####  Importing Libraries and Data Frames 

source("Libraries&DataFrames.R")

#### UI ####

ui <- dashboardPagePlus(
  
  skin = "black",
  
  enable_preloader = TRUE,
  loading_duration = 3,
  
  collapse_sidebar = TRUE,
  sidebar_fullCollapse = FALSE,
  
  footer = dashboardFooter(
    left = div(h4("Triceps MDA"),
               h5("Providencia, Chile")), 
    right = div(h6("Desarrollador:"),
                h6("davidignacioam@gmail.com"))
  ),
  
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
          width = "210px",
          inputId = 'CategoryInput', 
          label = "Selección del Plantel",
          choices = levels(df_PD$Categoría),
          selected = "Plantel Adulto Masculino"
        ),
        materialSwitch(
          inputId = "Player", 
          label = strong("Análisis por Jugador"),
          status = "primary",
          right = TRUE
        ),
        conditionalPanel(
          condition = "input.Player == true",
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
          width = "150px",
          inputId = "timeFromInput", 
          label = "desde:",
          value = min(date.range),
          min = NULL,
          max = NULL,
          startview = "month",
          language = "es"
        ),
        dateInput(
          width = "150px",
          inputId = "timeToInput", 
          label = "hasta:",
          value = max(date.range),
          min = NULL,
          max = NULL,
          startview = "month",
          language = "es"
        ),
        br()
      ),
      ####  INFO  ####
      dropdownBlock(
        #title = "Orientaciones",
        id = "dropdownBlock_info",
        badgeStatus = NULL,
        icon = "info", 
        br(),
        not1,
        # hr(), not2,
        # hr(), not3,
        # hr(), not4,
        # hr(), not5,
        # hr(), not6,
        # hr(), not7,
        not2,
        not3,
        not4,
        not5,
        not6,
        not7,
        br()
      )
    )
  ),
  
  sidebar = dashboardSidebar(
    collapsed = TRUE,
    # width = 300,
    # id = "sidebarID"
    ####  SIDEBAR  ####
    sidebarMenu(
      id = "leftSidebar",
      menuItem(
        "Dimensones Jugador", 
        icon = icon("running"), 
        startExpanded = TRUE,
        menuSubItem(
          "Univariado", 
          tabName="tab_1_1", 
          icon=icon("chart-bar")
        ),
        menuSubItem(
          "Multivariable", 
          tabName="tab_1_2", 
          icon=icon("project-diagram")
        ),
        menuSubItem(
          "Auto-Reporte",
          tabName="tab_1_3",
          icon=icon("file-medical-alt")
        )
      ),
      menuItem(
        selected = TRUE,
        "Evento Clínico", 
        icon=icon("notes-medical"), 
        tabName="tab_2"
      ),
      menuItem(
        "Gestión Médica", 
        icon=icon("hourglass-half"), 
        tabName="tab_3"
      ),
      menuItem(
        "Time Loss", 
        icon=icon("calendar-alt"), 
        tabName="tab_4"
      )
    )
  ),
  
  body = dashboardBody(
    
    tags$head(tags$style(HTML(css))),
    
    # fresh::use_theme(
    #   fresh::create_theme(
    #     fresh::adminlte_color(
    #       green = "#0B3B0B",
    #       aqua = "#142c59"
    #   )
    # )),
    
    tabItems(
      #### ----------------------------------- TAB_1_1 ----------------------------------- #### 
      tabItem(tabName = "tab_1_1",
              br(),
              br(),
              br(),
              br(),
              fluidRow(
                column(
                  width = 1
                ),
                column(
                  width = 3, 
                  boxPlus(
                    width = 12, 
                    solidHeader = TRUE,
                    title = "Dimensión",
                    status = "primary",
                    column(
                      width = 12,
                      ####  INPUT_1.1.1  #### 
                      selectInput(
                        label = "",
                        inputId = "DimInput_tab1.1", 
                        multiple = FALSE,
                        choices = levels(df_PD$Dimensión %>% droplevels(exclude=c("Masoterápea","Nutrición"))) ,
                        selected = levels(df_PD$Dimensión)[1]
                      )
                    ),
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    enable_dropdown = TRUE,
                    dropdown_icon = TRUE,
                    dropdown_menu = list(
                      actionButton(
                        inputId = "Input_tab1.1.1_HELP",
                        label = "",
                        icon = icon("file-alt")
                      )
                    )
                  )
                ),
                column(
                  width = 1
                ),
                boxPlus(
                  width = 2, 
                  solidHeader = TRUE,
                  title = "Tipo",
                  status = "primary",
                  column(
                    width = 12,
                    ####  INPUT_1.1.2  #### 
                    uiOutput("typeMetersOption_tab1.1")
                  ),
                  collapsible = TRUE,
                  collapsed = FALSE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Input_tab1.1.2_HELP",
                      label = "",
                      icon = icon("file-alt")
                    )
                  )
                ),
                column(
                  width = 1
                ),
                column(
                  width = 3, 
                  boxPlus(
                    width = 12, 
                    solidHeader = TRUE,
                    title = "Medición",
                    status = "primary",
                    column(
                      width = 12,
                      ####  INPUT_1.1.3  #### 
                      uiOutput("metersOption_tab1.1")
                    ),
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    enable_dropdown = TRUE,
                    dropdown_icon = TRUE,
                    dropdown_menu = list(
                      actionButton(
                        inputId = "Input_tab1.1.3_HELP",
                        label = "",
                        icon = icon("file-alt")
                      )
                    )
                  )
                )
              ),
              # br(),
              # fluidRow(
              #   column(
              #     width = 4
              #   ),
              #   column(
              #     width = 4,
              #     align = "center",
              #     ####  TITLE_1.1  ####
              #     box(
              #       width = 12,
              #       solidHeader = TRUE,
              #       status = "success", 
              #       HTML("<h4><center><b>MEDIDAS ESTADÍSTICAS</b></h4>")
              #     )
              #   ),
              #   column(
              #     width = 4
              #   )
              # ),
              br(),
              fluidRow(
                ####  TAB_1.1.1  ####
                boxPlus(
                  width = 3,
                  title = "Gráfica de Error", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab1.1.1", height="280px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
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
                  ),
                  footer = fluidRow(
                    column(
                      width = 12,
                      uiOutput("Plot_tab1.1.1_Footer")
                    )
                  )
                ),
                ####  TAB_1.1.2  ####
                boxPlus(
                  width = 5,
                  title = "Gráfica de Densidad", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab1.1.2", height="280px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
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
                  ),
                  footer = fluidRow(
                    column(
                      width = 6,
                      uiOutput("Plot_tab1.1.2_Footer_A")
                    ),
                    column(
                      width = 6,
                      uiOutput("Plot_tab1.1.2_Footer_B")
                    )
                  )
                ),
                ####  TAB_1.1.3  ####
                boxPlus(
                  width = 4,
                  title = "Gráfica de Caja ", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab1.1.3", height="280px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
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
                    ####  TABLE_1.1.0  #### 
                    downloadButton("download_Table_tab1.1.0.xlsx", ".xlsx")
                  ),
                  footer = fluidRow(
                    column(
                      width = 12,
                      uiOutput("Plot_tab1.1.3_Footer")
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                boxPlus(
                  width = 12,
                  title = "Tabla de Estadística Descriptiva General", 
                  status = "primary", 
                  solidHeader = TRUE,
                  ####  TABLE_1.1.1  #### 
                  withSpinner(
                    DT::dataTableOutput("Table_tab1.1.1"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Table_tab1.1.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab1.1.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab1.1.1.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  VB_1  ####
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab1.1.1"
                  ),
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab1.1.2"
                  ),
                  valueBox(
                    width = 12,
                    "Z-score",
                    paste("(Valor - Promedio) / Desv.Est."),
                    icon = icon("divide"),
                    color = "yellow"
                  )
                ),
                boxPlus(
                  width = 8,
                  title = "Tabla de Z-Score", 
                  status = "primary", 
                  solidHeader = TRUE,
                  ####  TABLE_1.1.2  #### 
                  withSpinner(
                    DT::dataTableOutput("Table_tab1.1.2", height="350px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Table_tab1.1.2_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab1.1.2.xlsx", ".xlsx"), # icon = icon("file-excel)
                    downloadButton("download_Table_tab1.1.2.csv", ".csv") # icon = icon("file-csv)
                  )
                )
              ),
              br()
      ),
      #### ----------------------------------- TAB_1_2 ----------------------------------- #### 
      tabItem(tabName = "tab_1_2",
              br(),
              br(),
              br(),
              br(),
              fluidRow(
                column(
                  width = 1
                ),
                column(
                  width = 3, 
                  boxPlus(
                    width = 12, 
                    solidHeader = TRUE,
                    title = "Dimensión",
                    status = "primary",
                    column(
                      width = 12,
                      ####  INPUT_1.2.1  #### 
                      selectInput(
                        label = "",
                        inputId = "DimInput_tab1.2", 
                        multiple = FALSE,
                        choices = levels(df_PD$Dimensión %>% droplevels(exclude=c("Masoterápea","Nutrición"))) ,
                        selected = levels(df_PD$Dimensión)[1]
                      )
                    ),
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    enable_dropdown = TRUE,
                    dropdown_icon = TRUE,
                    dropdown_menu = list(
                      actionButton(
                        inputId = "Input_tab1.2.1_HELP",
                        label = "",
                        icon = icon("file-alt")
                      )
                    )
                  )
                ),
                column(
                  width = 1
                ),
                boxPlus(
                  width = 2, 
                  solidHeader = TRUE,
                  title = "Tipo",
                  status = "primary",
                  column(
                    width = 12,
                    ####  INPUT_1.2.2  #### 
                    uiOutput("typeMetersOption_tab1.2")
                  ),
                  collapsible = TRUE,
                  collapsed = FALSE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Input_tab1.2.2_HELP",
                      label = "",
                      icon = icon("file-alt")
                    )
                  )
                ),
                column(
                  width = 1
                ),
                column(
                  width = 3, 
                  boxPlus(
                    width = 12, 
                    solidHeader = TRUE,
                    title = "Mediciones",
                    status = "primary",
                    column(
                      width = 12,
                      ####  INPUT_1.2.3  #### 
                      uiOutput("metersOption_tab1.2")
                    ),
                    collapsible = TRUE,
                    collapsed = FALSE,
                    closable = FALSE,
                    enable_dropdown = TRUE,
                    dropdown_icon = TRUE,
                    dropdown_menu = list(
                      actionButton(
                        inputId = "Input_tab1.2.3_HELP",
                        label = "",
                        icon = icon("file-alt")
                      )
                    )
                  )
                )
              ),
              br(),
              br(),
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4, 
                  align = "center",
                  ####  TITLE_1.2.1  ####
                  box(
                    width = 12, 
                    solidHeader = TRUE,
                    status = "success", 
                    HTML("<h4><center><b>ANÁLISIS CLUSTER</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              fluidRow(
                ####  TAB_1.2.1  ####
                boxPlus(
                  width = 8,
                  title = "Gráfica de Clusters", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab1.2.1", height="450px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
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
                    )
                  ),
                  enable_sidebar = TRUE,
                  sidebar_width = 25,
                  sidebar_background = "#0A0A0AAD",
                  sidebar_start_open = TRUE,
                  sidebar_icon = "sliders-h",
                  sidebar_content = tagList(
                    ####  INPUT_2.1  #### 
                    br(),
                    selectInput(
                      inputId = "mClusters2.1", 
                      label = "Método:",
                      choices = c("kmeans","pam","clara","fanny"),
                      selected = "kmeans"
                    ),
                    sliderTextInput(
                      inputId = 'nClusters2.1',
                      label = 'Número Clusters:',
                      choices = c("2","3","4","5","6","7","8","9","10")
                    )
                  )
                ),
                ####  TABLE_1.2.1  ####
                boxPlus(
                  width = 4,
                  title = "", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab1.2.1"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Table_tab1.2.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab1.2.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab1.2.1.csv", ".csv")
                  )
                )
              ),
              br(),
              br(),
              fluidRow(
                column(
                  width = 3
                ),
                column(
                  width = 6, 
                  align = "center",
                  ####  TITLE_1.2.2  ####
                  box(
                    width = 12, 
                    solidHeader = TRUE,
                    status = "success", 
                    HTML("<h4><center><b>DESCRIPCIONES MULTIVARIABLES</b></h4>"),
                  )
                ),
                column(
                  width = 3
                )
              ),
              br(),
              fluidRow(
                ####  TAB_1.2.2  #### 
                column(
                  width = 12,
                  boxPlus(
                    width = 12, 
                    title = "Gráfica Spyder de Promedios Proporcionales", 
                    status = "primary", 
                    solidHeader = TRUE,
                    withSpinner(
                      plotlyOutput("Plot_tab1.2.2", height="600px"),
                      type = 6,
                      color = "#0D9AE0DA",
                      size = 0.7
                    ),
                    collapsible = TRUE,
                    closable = FALSE,
                    enable_dropdown = TRUE,
                    dropdown_icon = FALSE,
                    dropdown_menu = list(
                      actionButton(
                        inputId = "Plot_tab1.2.2_HELP",
                        label = "",
                        icon = icon("question-circle")
                      )
                    ),
                    enable_sidebar = TRUE,
                    sidebar_width = 25,
                    sidebar_background = "#0A0A0AAD",
                    sidebar_start_open = FALSE,
                    sidebar_icon = "sliders-h",
                    sidebar_content = tagList(
                      br(),
                      materialSwitch(
                        inputId = "Fill_tab1.2.2", 
                        label = strong("Relleno Pligonal"),
                        status = "primary",
                        right = TRUE
                      ),
                      br(),
                      uiOutput("Player_tab1.2.2_Option_1"),
                      uiOutput("Player_tab1.2.2_Option_2"),
                    )
                  )
                )
              ),
              fluidRow(
                column(
                  width = 1
                ),
                ####  TABLE_1.2.2  ####
                boxPlus(
                  width = 10,
                  title = "Tabla Promedios", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab1.2.2"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Table_tab1.2.2_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab1.2.2.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab1.2.2.csv", ".csv")
                  )
                ),
                column(
                  width = 1
                )
              ),
              br()
      ),
      #### ----------------------------------- TAB_1_3 ----------------------------------- #### 
      tabItem(tabName = "tab_1_3",
              br(),
              br(),
              br(),
              br(),
              fluidRow(
                column(
                  width = 3
                ),
                column(
                  width = 6,
                  align = "center",
                  ####  TITLE_1.3.1  ####
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success", 
                    HTML("<h4><center><b>PROMEDIO SEMANAL BIENESTAR</b></h4>")
                  )
                ),
                column(
                  width = 3
                )
              ),
              fluidRow(
                ####  TAB_1.3.1  #### 
                boxPlus(
                  width = 9, 
                  title = "Gráfica de Promedios de Bienestar Semanal",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab1.3.1", height="450px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab1.3.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab1.3.1_HELP",
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
                    br(),
                    uiOutput("metersOption_tab1.3")
                  )
                ),
                boxPlus(
                  width = 3,
                  title = "", 
                  status = "primary", 
                  solidHeader = TRUE,
                  ####  TABLE_1.3.1  #### 
                  withSpinner(
                    DT::dataTableOutput("Table_tab1.3.1"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Table_tab1.3.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab1.3.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab1.3.1.csv", ".csv")
                  )
                )
              ),
              # br(),
              # br(),
              # fluidRow(
              #   column(
              #     width = 3
              #   ),
              #   column(
              #     width = 6,
              #     align = "center",
              #     ####  TITLE_1.3.1  ####
              #     box(
              #       width = 12,
              #       solidHeader = TRUE,
              #       status = "success", 
              #       HTML("<h4><center><b>PERCEPCIÓN DE ESFUERZO SEMANAL</b></h4>")
              #     )
              #   ),
              #   column(
              #     width = 3
              #   )
              # ),
              #
              # fluidRow(
              #   ####  TAB_1.3.2  #### 
              #   boxPlus(
              #     width = 8, 
              #     title = "Gráfica de Percepción de Esfuerzo Semanal",
              #     status = "primary", 
              #     solidHeader = TRUE,
              #     withSpinner(
              #       plotlyOutput("Plot_tab1.3.2", height="500px"),
              #       type = 6,
              #       color = "#0D9AE0DA",
              #       size = 0.7
              #     ),
              #     collapsible = TRUE,
              #     closable = FALSE,
              #     enable_dropdown = TRUE,
              #     dropdown_icon = TRUE,
              #     dropdown_menu = list(
              #       actionButton(
              #         inputId = "Plot_tab1.3.2_HELP",
              #         label = "",
              #         icon = icon("question-circle")
              #       ),
              #       actionButton(
              #         inputId = "Input_tab1.3.2_HELP",
              #         label = "",
              #         icon = icon("file-alt")
              #       )
              #     )
              #   ),
              #   boxPlus(
              #     width = 4,
              #     title = "", 
              #     status = "primary", 
              #     solidHeader = TRUE,
              #     ####  TABLE_1.3.2  #### 
              #     withSpinner(
              #       DT::dataTableOutput("Table_tab1.3.2"),
              #       type = 6,
              #       color = "#0D9AE0DA",
              #       size = 0.7
              #     ),
              #     collapsible = TRUE,
              #     closable = FALSE,
              #     enable_dropdown = TRUE,
              #     dropdown_icon = FALSE,
              #     dropdown_menu = list(
              #       actionButton(
              #         inputId = "Table_tab1.3.2_HELP",
              #         label = "",
              #         icon = icon("question-circle")
              #       ),
              #       downloadButton("download_Table_tab1.3.2.xlsx", ".xlsx"),
              #       downloadButton("download_Table_tab1.3.2.csv", ".csv")
              #     )
              #   )
              # ),
              # br(),
              # br(),
              # fluidRow(
              #   column(
              #     width = 3
              #   ),
              #   column(
              #     width = 6,
              #     align = "center",
              #     ####  TITLE_1.3.1  ####
              #     box(
              #       width = 12,
              #       solidHeader = TRUE,
              #       status = "success", 
              #       HTML("<h4><center><b>LESIONES SEGÚN ACWR</b></h4>")
              #     )
              #   ),
              #   column(
              #     width = 3
              #   )
              # ),
              # fluidRow(
              #   ####  TAB_1.3.3  #### 
              #   boxPlus(
              #     width = 9, 
              #     title = "Gráfica de Lesiones por Contacto Indirecto según ACWR",
              #     status = "primary", 
              #     solidHeader = TRUE,
              #     withSpinner(
              #       plotlyOutput("Plot_tab1.3.3", height="450px"),
              #       type = 6,
              #       color = "#0D9AE0DA",
              #       size = 0.7
              #     ),
              #     collapsible = TRUE,
              #     closable = FALSE,
              #     enable_dropdown = TRUE,
              #     dropdown_icon = TRUE,
              #     dropdown_menu = list(
              #       actionButton(
              #         inputId = "Plot_tab1.3.3_HELP",
              #         label = "",
              #         icon = icon("question-circle")
              #       )
              #     )
              #   ),
              #   boxPlus(
              #     width = 3,
              #     title = "", 
              #     status = "primary", 
              #     solidHeader = TRUE,
              #     ####  TABLE_1.3.3  #### 
              #     withSpinner(
              #       DT::dataTableOutput("Table_tab1.3.3"),
              #       type = 6,
              #       color = "#0D9AE0DA",
              #       size = 0.7
              #     ),
              #     collapsible = TRUE,
              #     closable = FALSE,
              #     enable_dropdown = TRUE,
              #     dropdown_icon = FALSE,
              #     dropdown_menu = list(
              #       actionButton(
              #         inputId = "Table_tab1.3.3_HELP",
              #         label = "",
              #         icon = icon("question-circle")
              #       ),
              #       downloadButton("download_Table_tab1.3.3.xlsx", ".xlsx"),
              #       downloadButton("download_Table_tab1.3.3.csv", ".csv")
              #     )
              #   )
              # ),
              br()
      ),
      #### ----------------------------------- TAB_2 ----------------------------------- #### 
      tabItem(tabName = "tab_2",
              br(),
              br(),
              br(),
              # br(),
              # fluidRow(
              #   column(
              #     width = 4
              #   ),
              #   column(
              #     width = 4,
              #     align = "center",
              #     ####  TITLE_2  ####
              #     box(
              #       width = 12,
              #       solidHeader = TRUE,
              #       status = "success", 
              #       HTML("<h4><center><b>EVENTO CLÍNICO</b></h4>"),
              #     )
              #   ),
              #   column(
              #     width = 4
              #   )
              # ),
              br(),
              ####  VB_2  ####
              fluidRow(
                column(
                  width = 3
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab2.0.1"
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab2.0.2"
                ),
                column(
                  width = 3
                )
              ),
              fluidRow(
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab2.1"
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab2.2"
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab2.3"
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab2.4"
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_2.0  #### 
                boxPlus(
                  width = 12, 
                  title = "Tabla de Epidemiología", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab2.0", height="300px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Table_tab2.0_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab2.0_HELP",
                      label = "",
                      icon = icon("file-alt")
                    ),
                    downloadButton("download_Table_tab2.0.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab2.0.csv", ".csv")
                  ),
                  enable_sidebar = TRUE,
                  sidebar_width = 25,
                  sidebar_background = "#0A0A0AAD",
                  sidebar_start_open = TRUE,
                  sidebar_icon = "sliders-h",
                  sidebar_content = tagList(
                    ####  INPUT_2.0  #### 
                    br(),
                    pickerInput(
                      inputId = 'cInput_tab2.0',
                      label = 'Tipo:',
                      multiple = FALSE,
                      choices = levels(
                        droplevels(df_CED$Categoría_I[!is.na(df_CED$Categoría_I)], exclude=c("NULL"))
                      ),
                      selected = "Lesión",
                      options = list(`actions-box`=TRUE)
                    ),
                    pickerInput(
                      inputId = 'mInput_tab2.0',
                      label = 'Momento:',
                      multiple = FALSE,
                      choices = c("Partido","Entrenamiento"),
                      selected = c("Entrenamiento"),
                      options = list(`actions-box`=TRUE)
                    ),
                    pickerInput(
                      inputId = 'cInput_tab1.0',
                      label = 'Subdivisiones:',
                      multiple = TRUE,
                      choices = df.S.0,
                      selected = c("Categoría_II"),
                      options = list(`actions-box`=TRUE)
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_2.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Tabla de Frecuencia Combinadas", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab2.1", height="350px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Table_tab2.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab2.1_HELP",
                      label = "",
                      icon = icon("file-alt")
                    ),
                    downloadButton("download_Table_tab2.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab2.1.csv", ".csv")
                  ),
                  enable_sidebar = TRUE,
                  sidebar_width = 25,
                  sidebar_background = "#0A0A0AAD",
                  sidebar_start_open = TRUE,
                  sidebar_icon = "sliders-h",
                  sidebar_content = tagList(
                    ####  INPUT_2.1  #### 
                    br(),
                    pickerInput(
                      inputId = 'cInput_tab1.1',
                      label = 'Variables Cruzadas',
                      multiple = TRUE,
                      choices = df.S.2,
                      selected = c("Categoría_I","Diagnóstico"),
                      options = list(`actions-box`=TRUE)
                    )
                  ),
                  footer = fluidRow(
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.1_Footer_A")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.1_Footer_B")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.1_Footer_C")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.1_Footer_D")
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TAB_2.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Diagrama de Barras Múltiples",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab2.1", height="600px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab2.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab2.2_HELP",
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
                    ####  INPUT_2.2  #### 
                    br(),
                    varSelectInput(
                      inputId = 'cInput_tab1.2',
                      label = 'Variable Eje X:',
                      data = df.S.1,
                      multiple = FALSE,
                      selectize = TRUE,
                      selected="Categoría_I"
                    ),
                    varSelectInput(
                      inputId = 'cInput_tab1.3',
                      label = 'Variable Color:',
                      data = df.S.1,
                      multiple = FALSE,
                      selectize = TRUE,
                      selected="Categoría_II"
                    )
                  )
                )
              ),
              br()
      ),
      #### ----------------------------------- TAB_3 ----------------------------------- #### 
      tabItem(tabName = "tab_3",
              br(),
              br(),
              br(),
              # br(),
              # fluidRow(
              #   column(
              #     width = 4
              #   ),
              #   column(
              #     width = 4,
              #     align = "center",
              #     ####  TITLE_3  ####
              #     box(
              #       width = 12,
              #       solidHeader = TRUE,
              #       status = "success", 
              #       HTML("<h4><center><b>GESTIÓN MÉDICA</b></h4>"),
              #     )
              #   ),
              #   column(
              #     width = 4
              #   )
              # ),
              # br(),
              # fluidRow(
              #   ####  VB_3  ####
              #   valueBoxOutput(
              #     width = 4,
              #     "valuebox_tab3.1"
              #   ),
              #   valueBoxOutput(
              #     width = 4,
              #     "valuebox_tab3.2"
              #   ),
              #   valueBoxOutput(
              #     width = 4,
              #     "valuebox_tab3.3"
              #   )
              # ), 
              br(),
              fluidRow(
                ####  TAB_3.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Diagrama Temporal de Frequencia de Eventos, Tratamientos y Masajes",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab3.1", height="400px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab3.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    )
                  ),
                  footer = fluidRow(
                    column(
                      width = 4,
                      uiOutput("Plot_tab3.1_Footer_A")
                    ),
                    column(
                      width = 4,
                      uiOutput("Plot_tab3.1_Footer_B")
                    ),
                    column(
                      width = 4,
                      uiOutput("Plot_tab3.1_Footer_C")
                    ),
                    column(
                      width = 4,
                      uiOutput("Plot_tab3.1_Footer_D")
                    ),
                    column(
                      width = 4,
                      uiOutput("Plot_tab3.1_Footer_E")
                    ),
                    column(
                      width = 4,
                      uiOutput("Plot_tab3.1_Footer_F")
                    )
                  )
                )
              ),
              fluidRow(
                ####  TABLE_3.1  #### 
                boxPlus(
                  width = 8, 
                  title = "Tabla Temporal de Frequencia", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab3.1"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_tab3.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab3.1.csv", ".csv")
                  )
                ),
                ####  TABLE_3.2  #### 
                boxPlus(
                  width = 4, 
                  title = "", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab3.2"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_tab3.2.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab3.2.csv", ".csv")
                  )
                )
              ),
              br()
      ),
      #### ----------------------------------- TAB_4 ----------------------------------- #### 
      tabItem(tabName = "tab_4",
              br(),
              br(),
              br(),
              br(),
              fluidRow(
                column(
                  width = 2
                ),
                ####  VB_4  ####
                valueBoxOutput(
                  width = 4,
                  "valuebox_tab4.1"
                ),
                valueBoxOutput(
                  width = 4,
                  "valuebox_tab4.2"
                ),
                column(
                  width = 2
                )
              ),
              br(),
              fluidRow(
                ####  TAB_4.1  #### 
                boxPlus(
                  width = 6, 
                  title = "Diagrama de Severidad de Lesión",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab4.1", height="400px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab4.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    )
                  )
                ),
                ####  TAB_4.1  #### 
                boxPlus(
                  width = 6, 
                  title = "Diagrama de Severidad de Enfermedad",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab4.2", height="400px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    actionButton(
                      inputId = "Plot_tab4.2_HELP",
                      label = "",
                      icon = icon("question-circle")
                    )
                  )
                )
              ),
              fluidRow(
                ####  TABLE_4.1  #### 
                boxPlus(
                  width = 12, 
                  title = "", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab4.1"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_tab4.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab4.1.csv", ".csv")
                  )
                )
              ),
              br()
      )
    )
  )
)


server <- function(input, output, session) {
  
  ####  INTRO  #### 
  # observeEvent("", {
  #   showModal(
  #     modalDialog(
  #       includeHTML("Modals/Introduction/Presentation.html"),
  #       easyClose = TRUE,
  #       footer = actionButton(
  #         inputId = "pres", 
  #         label = strong("Necesitas orientación?"), 
  #         style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
  #       )
  #     )
  #   )
  # }, once = TRUE)
  # observeEvent(input$pres,{
  #   showModal(
  #     modalDialog(
  #       includeHTML("Modals/Introduction/Basics.html"),
  #       easyClose = TRUE,
  #       footer = actionButton(
  #         inputId = "intro", 
  #         label = strong("Ahora sí, vamos a analizar los datos !"), 
  #         style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
  #       )
  #     )
  #   )
  # })
  # observeEvent(input$intro,{
  #   removeModal()
  # })
  
  
  ####  UI  ####
  levelsPlayers <- reactive({
    df_CED %>% 
      filter(Categoría %in% input$CategoryInput) %>%
      select(Jugador) %>%
      unique() %>% 
      drop_na() %>%
      t()
  })
  output$playerOption <- renderUI({
    if(input$Player){
      selectInput(
        width = "210px",
        inputId = 'PlayerInput', 
        label = "Seleccione el Jugador:",
        choices = levelsPlayers()
      )
    } 
  })
  
  ####  DF  ####
  
  ## Player Dimension Numeric
  df_PD_fil <- reactive({
    if(input$Player){
      df_PD %>% filter(Categoría %in% input$CategoryInput,
                       FechaDimensión >= input$timeFromInput,
                       FechaDimensión <= input$timeToInput,
                       Jugador %in% input$PlayerInput)
    } else {
      df_PD %>% filter(Categoría %in% input$CategoryInput,
                       FechaDimensión >= input$timeFromInput,
                       FechaDimensión <= input$timeToInput)
    }
  })
  ## Clinical Event
  df_CED_fil <- reactive({
    if(input$Player){
      df_CED %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDiagnóstico >= input$timeFromInput,
               FechaDiagnóstico <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_CED %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDiagnóstico >= input$timeFromInput,
               FechaDiagnóstico <= input$timeToInput)
    }
  })
  df_CED_C <- reactive({
    df_CED %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaDiagnóstico >= input$timeFromInput,
             FechaDiagnóstico <= input$timeToInput)
  })
  ## Kinesic Tratement
  df_KT_fil <- reactive({
    if(input$Player){
      df_KT %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaTratamientoKinésico >= input$timeFromInput,
               FechaTratamientoKinésico <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_KT %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaTratamientoKinésico >= input$timeFromInput,
               FechaTratamientoKinésico <= input$timeToInput)
    }
  })
  ## Player Dimension Factor
  df_PD_F_fil <- reactive({
    if(input$Player){
      df_PD_Factor %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDimensión >= input$timeFromInput,
               FechaDimensión <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_PD_Factor %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDimensión >= input$timeFromInput,
               FechaDimensión <= input$timeToInput)
    }
  })
  ## Time Loss
  df_TL_fil <- reactive({
    if(input$Player){
      df_TL %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaTérmino_TimeLoss >= input$timeFromInput,
               FechaTérmino_TimeLoss <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_TL %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaTérmino_TimeLoss >= input$timeFromInput,
               FechaTérmino_TimeLoss <= input$timeToInput)
    }
  })
  
  # Exposure Time
  Min_Exp.DF <- reactive({
    df_PD_fil() %>% 
      filter(
        TipoMedición %in% input$mInput_tab2.0,
        Medición %in% "Total Duration"
      ) %>%
      select(ValorMedición) 
  })
  Min_Exp <- reactive({
    if (nrow(Min_Exp.DF()) == 0) {
      0
    } else {
      Min_Exp.DF() %>% sum()
    }
  })
  
  #### --------------------------- TAB_1_1 --------------------------- #### 
  
  ####  UI  ####
  levelsTypeMeters_tab1.1 <- reactive({
    df_PD %>% 
      filter(
        Dimensión %in% input$DimInput_tab1.1
      ) %>%
      select(TipoMedición) %>%
      unique() %>% 
      drop_na() %>%
      t()
  })
  output$typeMetersOption_tab1.1 <- renderUI({
    selectInput(
      inputId = 'TypeMetInput_tap1.1',
      label = '',
      multiple = FALSE,
      choices = levelsTypeMeters_tab1.1(),
      selected = levelsTypeMeters_tab1.1()[1]
    )
  })
  
  levelsMeters_tab1.1 <- reactive({
    df_PD %>% 
      filter(
        Dimensión %in% input$DimInput_tab1.1,
        TipoMedición %in% input$TypeMetInput_tap1.1
      ) %>%
      select(Medición) %>%
      unique() %>% 
      drop_na() %>%
      t()
  })
  output$metersOption_tab1.1 <- renderUI({
    selectInput(
      inputId = 'MetInput_tab1.1',
      label = '', 
      multiple = FALSE,
      choices = levelsMeters_tab1.1()
    )
  })
  
  ####  HELP_1.1  #### 
  observeEvent(input$Input_tab1.1.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Input_tab1.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab1.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab1.1_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab1.1.2_HELP, {
    showModal(
      modalDialog(
        includeHTML(
          ifelse(
            input$DimInput_tab1.1 %in% "Nutrición", 
            "Modals/Tab_1/Input_tab1.2_TipoMedición_Nutrición_HELP.html",
            ifelse(
              input$DimInput_tab1.1 %in% "Autoreporte", 
              "Modals/Tab_1/Input_tab1.2_TipoMedición_Autoreporte_HELP.html",
              ifelse(
                input$DimInput_tab1.1 %in% "Mediciones Diarias", 
                "Modals/Tab_1/Input_tab1.2_TipoMedición_MedicionesDiarias_HELP.html",
                ifelse(
                  input$DimInput_tab1.1 %in% "Biomecánica", 
                  "Modals/Tab_1/Input_tab1.2_TipoMedición_Biomecánica_HELP.html",""
                )
              )
            )
          )
        ),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab1.1.2_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab1.1.2_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab1.1.3_HELP, {
    showModal(
      modalDialog(
        includeHTML(
          ifelse(
            input$DimInput_tab1.1 %in% "Nutrición", 
            "Modals/Tab_1/Input_tab1.3_Medición_Nutrición_HELP.html",
            ifelse(
              input$DimInput_tab1.1 %in% "Autoreporte", 
              "Modals/Tab_1/Input_tab1.3_Medición_Autoreporte_HELP.html",
              ifelse(
                input$DimInput_tab1.1 %in% "Mediciones Diarias", 
                "Modals/Tab_1/Input_tab1.3_Medición_MedicionesDiarias_HELP.html",
                ifelse(
                  input$DimInput_tab1.1 %in% "Biomecánica", 
                  "Modals/Tab_1/Input_tab1.3_Medición_Biomecánica_HELP.html",
                  ""
                )
              )
            )
          )
        ),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab1.1.3_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab1.1.3_Modal,{
    removeModal()
  })
  
  ####  DF_1.1  #### 
  
  ## Filtered 
  filtered_tab1.1 <- reactive({
    df_PD_fil() %>% filter(Dimensión %in% input$DimInput_tab1.1,
                           TipoMedición %in% input$TypeMetInput_tap1.1,
                           Medición %in% input$MetInput_tab1.1)
  })
  filtered_tab1.1.2 <- reactive({
    df_PD_fil() %>% filter(Dimensión %in% input$DimInput_tab1.1,
                           TipoMedición %in% input$TypeMetInput_tap1.1)
  })
  filtered_tab1.1.3 <- reactive({
    filtered_tab1.1() %>% 
      filter(
        ValorMedición %in% c(
          boxplot.stats(filtered_tab1.1()$ValorMedición)$out
        )
      ) %>%
      select(Jugador,Dimensión,TipoMedición,Medición,ValorMedición,FechaDimensión) %>%
      arrange(ValorMedición)
  })
  
  ####  VB_1.1  #### 
  output$valuebox_tab1.1.1 <- renderValueBox({
    valueBox(
      Stat.DF_tab1.1.1() %>% 
        filter(Medición %in% input$MetInput_tab1.1) %>%
        select(Promedio) %>%
        round(0) %>%
        slice(1),
      "Promedio", 
      icon = icon("divide"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.1.2 <- renderValueBox({
    valueBox(
      Stat.DF_tab1.1.1() %>% 
        filter(Medición %in% input$MetInput_tab1.1) %>%
        select(Desv.) %>%
        round(1) %>%
        slice(1),
      "Desviación Estándar", 
      icon = icon("sort-amount-down"),
      color = "aqua"
    )
  })
  
  ####  TAB_1.1.1 #### 
  output$Plot_tab1.1.1 <- renderPlotly({
    # Input Validation
    validate(need(!nrow(filtered_tab1.1()) < 2, 
                  message = na.time.med))
    # Creating Object
    Xvar <- select(filtered_tab1.1(), 'Xvar'=ValorMedición)
    summarise <- data.frame(Prom = mean(Xvar$Xvar) %>% round(1), 
                            Desv. = sd(Xvar$Xvar) %>% round(1),
                            Var = 0, 
                            color = 0)
    for (i in seq(1, nrow(summarise), by=1)) {
      summarise$color[i] = if (summarise$Prom[i]>2*summarise$Desv.[i]) { "black" } else { "red" } 
    }
    
    # Visualization
    ggplotly(
      ggplot(summarise) +
        geom_bar(aes(x = Var,
                     y = Prom), 
                 stat = "identity", 
                 color="black",
                 size=.3,
                 fill = "#30E01D",
                 alpha = .7) +
        geom_errorbar(aes(x = Var,
                          ymin = Prom-Desv., 
                          ymax = Prom+Desv.), 
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
              panel.background=element_rect(fill="transparent",colour=NA)),
      tooltip = c("y","ymin","ymax")
    ) %>%
      layout(
        hovermode = 'compare',
        showlegend = FALSE
      ) %>%
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                   "zoomOut2d", "lasso2d", 
                                   "toggleSpikelines"), 
        toImageButtonOptions = list(
          format = "jpeg",
          filename =
            if(input$Player){
              paste(
                "Barras de Error Promedio del Jugador ", input$PlayerInput,
                " del ", input$CategoryInput, 
                " con rango de fecha desde ", input$timeFromInput, 
                " hasta ", input$timeToInput,
                sep = ""
              )
            } else {
              paste(
                "Barras de Error Promedio de ", input$MetInput_tab1.1, 
                " del ", input$CategoryInput, 
                " con rango de fecha desde ", input$timeFromInput, 
                " hasta ", input$timeToInput,
                sep = ""
              )
            },
          scale = 2
        )
      ) %>% toWebGL()
  }) 
  SD_tab1.1 <- reactive({
    df <-
      Stat.DF_tab1.1.1() %>%
      filter(Medición %in% input$MetInput_tab1.1) %>%
      select(Promedio,Desv.)
    df$Promedio <- 
      ifelse(df$Promedio > 100,df$Promedio %>% round(0),df$Promedio %>% round(1))
    df$Desv. <- 
      ifelse(df$Desv. > 100,df$Desv. %>% round(0),df$Desv. %>% round(1))
    paste0("[ ", df$Promedio-df$Desv. , " - " , df$Promedio+df$Desv., " ]")
  })
  SD_tab1.1_color <- reactive({
    Stat.DF_tab1.1.1() %>%
      filter(Medición %in% input$MetInput_tab1.1) %>%
      select(Promedio,Desv.)
  })
  output$Plot_tab1.1.1_Footer <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "less-than-equal",
      numberColor = ifelse(
        SD_tab1.1_color()$Promedio > 2*SD_tab1.1_color()$Desv.,
        "green","red"
      ),
      header = SD_tab1.1(),
      text = "Intervalo Confianza"
    )
  })
  observeEvent(input$Plot_tab1.1.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.1.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab1.1.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab1.1.1_Modal,{
    removeModal()
  })
  
  ####  TAB_1.1.2  #### 
  output$Plot_tab1.1.2 <- renderPlotly({
    # Input Validation
    validate(need(!nrow(filtered_tab1.1()) < 2, 
                  na.time.med))
    # Creating Object
    filtered <- filtered_tab1.1()
    # Visualization
    if (input$DimInput_tab1.1 %in% "Autoreporte") {
      ggplotly(
        ggplot(filtered, aes(x=ValorMedición)) +
          geom_bar(stat="count", 
                   fill = "#E31D31",
                   alpha=.7, 
                   width=.7, 
                   color="black", 
                   size=.3)  + 
          scale_x_discrete(
            limits = seq(min(filtered$ValorMedición), max(filtered$ValorMedición),1)
          ) +
          labs(x = NULL, y = NULL) +
          theme(panel.grid.major.x = element_blank(),
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
              if(input$Player){
                paste(
                  "Diagrama de Densidad del Jugador ", input$PlayerInput,
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              } else {
                paste(
                  "Diagrama de Densidad de ", input$MetInput_tab1.1, 
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              },
            scale = 2
          )
        ) %>% toWebGL()
    } else {
      ggplotly(
        ggplot(filtered, aes(x=ValorMedición)) +
          geom_density(aes(y=..density..), 
                       size=.7, 
                       fill = "#E31D31",
                       alpha = .5) +
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
              if(input$Player){
                paste(
                  "Diagrama de Densidad del Jugador ", input$PlayerInput,
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              } else {
                paste(
                  "Diagrama de Densidad de ", input$MetInput_tab1.1, 
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              },
            scale = 2
          )
        ) %>% toWebGL()
    }
  })
  output$Plot_tab1.1.2_Footer_A <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "chart-bar",
      numberColor = "aqua", 
      header = Stat.DF_tab1.1.1() %>% 
        filter(Medición %in% input$MetInput_tab1.1) %>%
        select(Skew) %>%
        round(1) %>%
        slice(1),
      text = "Índice Skew"
    )
  })
  output$Plot_tab1.1.2_Footer_B <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "chart-area",
      numberColor = "aqua", 
      header = Stat.DF_tab1.1.1() %>% 
        filter(Medición %in% input$MetInput_tab1.1) %>%
        select(Kurtosis) %>%
        round(1) %>%
        slice(1),
      text = "Índice Kurtosis"
    )
  })
  observeEvent(input$Plot_tab1.1.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.1.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab1.1.2_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab1.1.2_Modal,{
    removeModal()
  })
  
  ####  TAB_1.1.3  #### 
  output$Plot_tab1.1.3 <- renderPlotly({
    # Input Validation
    validate(need(!nrow(filtered_tab1.1()) < 2, 
                  na.time.med))
    # Creating Object
    filtered <- filtered_tab1.1()
    # Visualization
    plot_ly(
      type = 'box',  
      showlegend = FALSE
    ) %>% 
      add_boxplot(
        y = filtered$ValorMedición,
        name = ".",
        boxpoints = 'outliers',
        marker = list(color = 'red',  
                      size = 9, 
                      line = list(
                        color = 'black',
                        width = 1
                      )),
        line = list(color = 'black'),
        hoverinfo = 'y'
      ) %>%
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                   "zoomOut2d", "lasso2d", 
                                   "toggleSpikelines"), 
        toImageButtonOptions = list(
          format = "jpeg",
          filename = 
            if(input$Player){
              paste(
                "Diagrama de Cajas del Jugador ", input$PlayerInput,
                " del ", input$CategoryInput, 
                " con rango de fecha desde ", input$timeFromInput, 
                " hasta ", input$timeToInput,
                sep = ""
              )
            } else {
              paste(
                "Diagrama de Cajas de ", input$MetInput_tab1.1, 
                " del ", input$CategoryInput, 
                " con rango de fecha desde ", input$timeFromInput, 
                " hasta ", input$timeToInput,
                sep = ""
              )
            },
          scale = 2
        )
      ) %>% toWebGL()
  })
  output$Plot_tab1.1.3_Footer <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "exclamation-triangle",
      numberColor = "red", 
      header =  Stat.DF_tab1.1.1() %>% 
        filter(Medición %in% input$MetInput_tab1.1) %>%
        select(Outliers) %>%
        round(0) %>%
        slice(1),
      text = "Cantidad Outliers"
    )
  })
  observeEvent(input$Plot_tab1.1.3_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.1.3_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer =  actionButton(
          inputId = "Plot_tab1.1.3_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab1.1.3_Modal,{
    removeModal()
  })
  
  ####  TABLE_1.1.0  #### 
  output$download_Table_tab1.1.0.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla con Datos Atítpicos de la medida ", input$yInput_tab1.0, 
          " del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )
      } else {
        paste(
          "Tabla con Datos Atítpicos de la medida ", input$yInput_tab1.0, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )
      }
    },
    content = function(file) {
      write.xlsx(filtered_tab1.1.3(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.1.0.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla con Datos Atítpicos de la medida ", input$yInput_tab1.0, 
          " del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )
      } else {
        paste(
          "Tabla con Datos Atítpicos de la medida_", input$yInput_tab1.0, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
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
        size = "m",
        footer = ""
      )
    )
  })
  
  ####  TABLE_1.1.1  #### 
  Stat.DF_tab1.1.1 <- reactive({
    # Input Validation
    validate(need(!nrow(filtered_tab1.1.2()) < 2, 
                  na.time.med))
    # Creating Object
    filtered <- filtered_tab1.1.2()
    outliers <- filtered %>% 
      group_by(Medición) %>% 
      summarise(
        boxplot.stats(ValorMedición)$out %>% 
          as.data.frame() %>% 
          count()
      ) %>%
      as.data.frame() 
    # Defining the Table 
    df_t <- 
      filtered %>%
      group_by(Medición) %>%
      summarize(
        as.data.frame(
          psych::describe(ValorMedición, 
                          quant=c(.25,.75))
        )[,-c(1:2,6:7,13)]
      ) %>%
      mutate(
        Outliers = outliers$n
      ) %>% 
      relocate(
        Medición,  
        "mean","median","sd","range", "Outliers", "min",
        "Q0.25","Q0.75","max","skew","kurtosis"
      ) %>% 
      as.data.frame() %>%
      rename("Promedio"=mean,
             "Mediana"=median,
             "Desv."=sd,
             "Rango"=range,
             "Min"=min,
             "Max"=max,
             "Skew"=skew,
             "Kurtosis"=kurtosis) 
    # Loop for removing decimals
    for (i in seq(2, ncol(df_t), by=1)) {
      df_t[,i] <- df_t[,i] %>% as.numeric() %>% round(2)
    }
    df_t[,1] <- droplevels(df_t[,1], exclude="PCR")
    # Showing the final Object
    df_t
  })
  output$Table_tab1.1.1 <- DT::renderDataTable({
    DT::datatable(
      Stat.DF_tab1.1.1(),
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",    
      filter = 'top',
      selection="multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE,
        scrollX='400px', # scrollY="350px", 
        paging=FALSE, info=FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) 
  })
  output$download_Table_tab1.1.1.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla Medidas Estadísticas del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )
      } else {
        paste(
          "Tabla Medidas Estadísticas del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )
      }
    },
    content = function(file) {
      write.xlsx(Stat.DF_tab1.1.1(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.1.1.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla Medidas Estadísticas del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )
      } else {
        paste(
          "Tabla Medidas Estadísticas del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )
      }
    },
    content = function(file) {
      write.csv(Stat.DF_tab1.1.1(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab1.1.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Table_tab1.1.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab1.1.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab1.1.1_Modal,{
    removeModal()
  })
  
  ####  TABLE_1.1.2  #### 
  Table_tab1.1.2 <- reactive({
    filtered_tab1.1() %>%
      mutate(
        Medición = input$MetInput_tab1.1,
        Zscore = ( 
          (ValorMedición - mean(ValorMedición)) / sd(ValorMedición) 
        ) %>% round(2)
      ) %>%
      select(Jugador,
             Fecha = FechaDimensión,
             Medición,
             Valor = ValorMedición,
             Zscore) %>%
      arrange(desc(Fecha))
  })
  output$Table_tab1.1.2 <- DT::renderDataTable({
    DT::datatable(
      Table_tab1.1.2(),
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",    
      #filter = 'top',
      selection="multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE,
        scrollX='400px', scrollY="300px", 
        paging=FALSE, info=FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) %>% 
      formatStyle(
        'Zscore', #fontWeight = 'bold',
        color = styleInterval(-1.99, c('red', 'black'))
      ) %>% 
      formatStyle(
        'Zscore', #fontWeight = 'bold',
        color = styleInterval(1.99, c('black', 'red'))
      ) 
  })
  output$download_Table_tab1.1.2.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla Zscore de ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " en ", input$cInput_tab1.0,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )
      } else {
        paste(
          "Tabla Zscore de ", input$CategoryInput, 
          " en ", input$cInput_tab1.0,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )
      }
    },
    content = function(file) {
      write.xlsx(Table_tab1.1.2(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.1.2.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla Zscore de ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " en ", input$cInput_tab1.0,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )
      } else {
        paste(
          "Tabla Zscore de ", input$CategoryInput, 
          " en ", input$cInput_tab1.0,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )
      }
    },
    content = function(file) {
      write.csv(Table_tab1.1.2(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab1.1.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Table_tab1.1.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer =  actionButton(
          inputId = "Table_tab1.1.2_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab1.1.2_Modal,{
    removeModal()
  })
  
  
  #### --------------------------- TAB_1_2 --------------------------- #### 
  
  ####  UI  ####
  levelsTypeMeters_tabe1.2 <- reactive({
    df_PD %>% 
      filter(
        Dimensión %in% input$DimInput_tab1.2
      ) %>%
      select(TipoMedición) %>%
      unique() %>% 
      drop_na() %>%
      t()
  })
  output$typeMetersOption_tab1.2 <- renderUI({
    selectInput(
      inputId = 'TypeMetInput_tap1.2',
      label = '',
      multiple = FALSE,
      choices = levelsTypeMeters_tabe1.2(),
      selected = levelsTypeMeters_tabe1.2()[1]
    )
  })
  
  levelsMeters_tab1.2 <- reactive({
    df_PD %>% 
      filter(
        Dimensión %in% input$DimInput_tab1.2,
        TipoMedición %in% input$TypeMetInput_tap1.2
      ) %>%
      select(Medición) %>%
      unique() %>% t()
  })
  output$metersOption_tab1.2 <- renderUI({
    pickerInput(
      inputId = 'MetInput_tab1.2',
      label = '',
      multiple = TRUE,
      choices = levelsMeters_tab1.2(),
      selected = levelsMeters_tab1.2()[1:4],
      options = list(
        #style = "btn-info",
        `actions-box` = TRUE,
        `selected-text-format` = "count > 2",
        `count-selected-text` = "{0}/{1} Mediciones"
      )
    )
  })
  
  ####  HELP_1.2  #### 
  observeEvent(input$Input_tab1.2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Input_tab1.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab1.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab1.1_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab1.1_Modal, {
    showModal(
      modalDialog(
        includeHTML(
          ifelse(
            input$DimInput_tab1.2 %in% "Nutrición", 
            "Modals/Tab_1/Input_tab1.2_TipoMedición_Nutrición_HELP.html",
            ifelse(
              input$DimInput_tab1.2 %in% "Autoreporte", 
              "Modals/Tab_1/Input_tab1.2_TipoMedición_Autoreporte_HELP.html",
              ifelse(
                input$DimInput_tab1.2 %in% "Mediciones Diarias", 
                "Modals/Tab_1/Input_tab1.2_TipoMedición_MedicionesDiarias_HELP.html",
                ifelse(
                  input$DimInput_tab1.2 %in% "Biomecánica", 
                  "Modals/Tab_1/Input_tab1.2_TipoMedición_Biomecánica_HELP.html",""
                )
              )
            )
          )
        ),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab1.2.2_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab1.2.2_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab1.2.3_HELP, {
    showModal(
      modalDialog(
        includeHTML(
          ifelse(
            input$DimInput_tab1.2 %in% "Nutrición", 
            "Modals/Tab_1/Input_tab1.3_Medición_Nutrición_HELP.html",
            ifelse(
              input$DimInput_tab1.2 %in% "Autoreporte", 
              "Modals/Tab_1/Input_tab1.3_Medición_Autoreporte_HELP.html",
              ifelse(
                input$DimInput_tab1.2 %in% "Mediciones Diarias", 
                "Modals/Tab_1/Input_tab1.3_Medición_MedicionesDiarias_HELP.html",
                ifelse(
                  input$DimInput_tab1.2 %in% "Biomecánica", 
                  "Modals/Tab_1/Input_tab1.3_TipoMedición_Biomecánica_HELP.html",""
                )
              )
            )
          )
        ),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab1.2.3_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab1.2.3_Modal,{
    removeModal()
  })
  
  ####  TAB_1.2.1  ####
  df.PD.s <- reactive({
    df_PD %>% 
      filter(
        Categoría %in% input$CategoryInput,
        Dimensión %in% input$DimInput_tab1.2,
        TipoMedición %in% input$TypeMetInput_tap1.2,
        Medición %in% input$MetInput_tab1.2,
        FechaDimensión >= input$timeFromInput,
        FechaDimensión <= input$timeToInput
      )
  })
  df.Cl <- reactive({
    data.frame(
      "Jugador" = df.PD.s()$Jugador %>% as.numeric(),
      "Medición" = df.PD.s()$Medición %>% as.numeric(),
      "Valor" = df.PD.s()$ValorMedición %>% as.numeric()
    ) 
  })
  output$Plot_tab1.2.1 <- renderPlotly({
    # Input Validation
    validate(need(!df.Cl() %>% nrow() == 0, 
                  message = na.time.med))
    validate(need(!df.Cl()$Jugador %>% unique() %>% table() %>% nrow() == 1, 
                  message = na.time.med))
    validate(need(!df.Cl() %>% nrow() <= input$nClusters2.1, 
                  message = na.time.med))
    ggplotly(
      fviz_cluster(
        eclust(
          df.Cl(), 
          FUNcluster = input$mClusters2.1, 
          k = input$nClusters2.1,
          graph = FALSE
        ),
        data = df.Cl(),
        show.clust.cent = FALSE,
        ellipse.alpha = 0.4,
        palette = "jco",
        pointsize = 1.7, 
        geom = "point" # geom = "text" labelsize = 1
      ) + 
        labs(x=NULL, y=NULL, title=NULL, fill=NULL, color=NULL, shape=NULL) +
        theme(panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA))
    ) %>% 
      layout(showlegend=FALSE) %>%
      config(
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                   "zoomOut2d", "lasso2d", 
                                   "toggleSpikelines"), 
        toImageButtonOptions = list(
          format = "jpeg",
          filename = paste(
            input$nClusters2.1, 
            " Clusters de Partición en ", input$mClusters2.1, 
            " del ", input$CategoryInput, 
            " en ", input$DimInput_tab1.2,
            " con rango de fecha desde ", input$timeFromInput, 
            " hasta ", input$timeToInput,
            sep = ""
          ),
          scale = 2
        )
      ) %>% toWebGL()
  }) 
  observeEvent(input$Plot_tab1.2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.2.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab1.2.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab1.2.1_Modal,{
    removeModal()
  })
  
  ####  TABLE_1.2.1  ####
  Table_tab1.2.1 <- reactive({
    # Input Validation
    validate(need(!df.PD.s() %>% nrow() == 0, 
                  message = na.time.med))
    validate(need(!df.Cl() %>% nrow() <= input$nClusters2.1, 
                  message = na.time.med))
    data.frame(
      "Jugador" =  df.PD.s()$Jugador,
      "Cluster" = eclust(
        df.Cl(), 
        FUNcluster = input$mClusters2.1, 
        k = input$nClusters2.1,
        graph = FALSE
      )$cluster %>% as.factor()
    ) %>% 
      arrange(desc(Cluster))
  })
  output$Table_tab1.2.1 <- DT::renderDataTable({
    # Input Validation
    validate(need(!Table_tab1.2.1()$Jugador %>% 
                    as.numeric() %>% unique() %>% table() %>% nrow() == 1, 
                  message = na.time.med))
    DT::datatable(
      Table_tab1.2.1(), 
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      width = "100%",
      filter = 'top',
      selection="multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, info=FALSE,
        scrollX='400px', scrollY="360px", 
        scrollCollapse=TRUE, paging=FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    )
  })
  output$download_Table_tab1.2.1.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Grupos de ", input$nClusters2.1, 
        " Clusters en ", input$mClusters2.1, 
        " del ", input$CategoryInput, 
        " en ", input$DimInput_tab1.2,
        " con rango de fecha desde ", input$timeFromInput, 
        " hasta ", input$timeToInput,
        ".xlsx", 
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(Table_tab1.2.1(), file, 
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.2.1.csv <- downloadHandler(
    filename = function() {
      paste(
        "Grupos de ", input$nClusters2.1, 
        " Clusters en ", input$mClusters2.1, 
        " del ", input$CategoryInput, 
        " en ", input$DimInput_tab1.2,
        " con rango de fecha desde ", input$timeFromInput, 
        " hasta ", input$timeToInput,
        ".csv", 
        sep = ""
      )
    },
    content = function(file) {
      write.csv(Table_tab1.2.1(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab1.2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Table_tab1.2.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab1.2.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab1.2.1_Modal,{
    removeModal()
  })
  
  ####  DF_1.2 PD #### 
  df.tab1.2_PD <- reactive({
    if(input$Player){
      df_PD %>% 
        filter(
          Categoría %in% input$CategoryInput,
          Dimensión %in% input$DimInput_tab1.2,
          TipoMedición %in% input$TypeMetInput_tap1.2,
          Medición %in% input$MetInput_tab1.2,
          FechaDimensión >= input$timeFromInput,
          FechaDimensión <= input$timeToInput,
          Jugador %in% input$PlayerInput
        )
      
    } else {
      df_PD %>% 
        filter(
          Categoría %in% input$CategoryInput,
          Dimensión %in% input$DimInput_tab1.2,
          TipoMedición %in% input$TypeMetInput_tap1.2,
          Medición %in% input$MetInput_tab1.2,
          FechaDimensión >= input$timeFromInput,
          FechaDimensión <= input$timeToInput,
        )
    }
  })
  
  output$Player_tab1.2.2_Option_1 <- renderUI({
    if(input$Player){
      dateInput(
        inputId = "timeFromInput_tab1.2.2", 
        label = "Fecha desde:",
        value = min(date.range),
        min = NULL,
        max = NULL,
        startview = "month",
        language = "es"
      )
    }
  })
  output$Player_tab1.2.2_Option_2 <- renderUI({
    if(input$Player){
      dateInput(
        inputId = "timeToInput_tab1.2.2", 
        label = "hasta:",
        value = max(date.range),
        min = NULL,
        max = NULL,
        startview = "month",
        language = "es"
      )
    }
  })
  
  df_PD_fil_w <- reactive({
    if(input$Player){
      df_PD %>% 
        filter(
          Categoría %in% input$CategoryInput,
          Dimensión %in% input$DimInput_tab1.2,
          TipoMedición %in% input$TypeMetInput_tap1.2,
          Medición %in% input$MetInput_tab1.2,
          FechaDimensión >= input$timeFromInput_tab1.2.2,
          FechaDimensión <= input$timeToInput_tab1.2.2,
          Jugador %in% input$PlayerInput
        )
    }
  })
  
  ####  TAB_1.2.2  #### 
  
  df.Cl_t <- reactive({
    # Input Validation
    validate(need(!df.PD.s() %>% nrow() == 0, 
                  message = na.time.med))
    if(input$Player){
      ## Promedio General
      df.P_g <- 
        df.PD.s() %>%
        group_by(Medición) %>% 
        summarise(Valor=mean(ValorMedición)) %>% 
        as.data.frame()
      for (i in seq(1, nrow(df.P_g))) {
        df.P_g[i,2] <-  
          round(df.P_g[i,2] / max(filter(df_PD, Medición %in% df.P_g[i,1])
                                  [,"ValorMedición"]) * 100, 1)
      }
      df.G <- df.P_g %>% spread(Medición, Valor)  
      ## Promedio Jugador capa Principal
      df.P_j <- 
        df.tab1.2_PD() %>% 
        group_by(Medición) %>% 
        summarise(Valor=mean(ValorMedición)) %>% 
        as.data.frame()
      for (i in seq(1, nrow(df.P_j))) {
        df.P_j[i,2] <-  
          round(df.P_j[i,2] / max(filter(df_PD, Medición %in% df.P_j[i,1])
                                  [,"ValorMedición"]) * 100, 1)
      }
      df.J <- df.P_j %>% spread(Medición, Valor)
      ## Internal Validation
      validate(need(ncol(df.J) == ncol(df.G), 
                    message = na.cl.com))
      ## Promedio Jugador segunda Capa
      df.P_j_2 <- 
        df_PD_fil_w() %>% 
        group_by(Medición) %>% 
        summarise(Valor=mean(ValorMedición)) %>% 
        as.data.frame()
      for (i in seq(1, nrow(df.P_j_2))) {
        df.P_j_2[i,2] <-  
          round(df.P_j_2[i,2] / max(filter(df_PD, Medición %in% df.P_j_2[i,1])
                                    [,"ValorMedición"]) * 100, 1)
      }
      df.P_j_2 <- df.P_j_2 %>% spread(Medición, Valor)
      ## DF Final
      rbind(df.G, df.J, df.P_j_2)
    } else {
      ## Promedio General
      df.P_g <- 
        df.tab1.2_PD() %>% 
        group_by(Medición) %>% 
        summarise(Valor=mean(ValorMedición)) %>% 
        as.data.frame()
      for (i in seq(1, nrow(df.P_g), 1)) {
        df.P_g[i,2] <-  
          round(df.P_g[i,2] / max(filter(df_PD, Medición %in% df.P_g[i,1])
                                  [,"ValorMedición"]) * 100, 1)
      }
      ## DF Final
      df.P_g %>% spread(Medición, Valor)
    }
  })
  
  output$Plot_tab1.2.2 <- renderPlotly({
    if(input$Player){
      plot_ly(
        type = 'scatterpolar',
        mode = "lines+markers",
        opacity = 0.8,
        fill = if (input$Fill_tab1.2.2) {
          'toself'
        } else {
          NULL
        }
      ) %>%
        add_trace(
          r = c(as.numeric(df.Cl_t()[1,]), as.numeric(df.Cl_t()[1,])[1]),
          theta = c(colnames(df.Cl_t()), colnames(df.Cl_t())[1]),
          name = "Plantel",
          marker = list(
            size = 14
          ),
          line = list(
            width = 4
          )
        ) %>%
        add_trace(
          r = c(as.numeric(df.Cl_t()[2,]), as.numeric(df.Cl_t()[2,])[1]),
          theta = c(colnames(df.Cl_t()), colnames(df.Cl_t())[1]),
          name = paste(input$PlayerInput," 1"),
          marker = list(
            size = 14
          ),
          line = list(
            width = 4
          )
        ) %>%
        add_trace(
          r = c(as.numeric(df.Cl_t()[3,]), as.numeric(df.Cl_t()[3,])[1]),
          theta = c(colnames(df.Cl_t()), colnames(df.Cl_t())[1]),
          name = paste(input$PlayerInput," 2"),
          marker = list(
            size = 14
          ),
          line = list(
            width = 4
          )
        ) %>%
        layout(
          hovermode = 'compare',
          showlegend = TRUE
        ) %>%
        config(
          displaylogo = FALSE,
          modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                     "zoomOut2d", "lasso2d", 
                                     "toggleSpikelines"), 
          toImageButtonOptions = list(
            format = "jpeg",
            filename = paste(
              "Gráfica Spyder de Promedios Proporcionales del_", input$CategoryInput, 
              " y del Jugador ", input$PlayerInput,
              " en ", input$DimInput_tab1.2,
              " con rango de fecha (1) desde ", input$timeFromInput, 
              " hasta ", input$timeToInput,
              " y (2) desde ", input$timeFromInput_tab1.2.2,
              " hasta ", input$timeToInput_tab1.2.2,
              sep = ""
            ),
            scale = 2
          )
        ) %>% toWebGL()
    } else {
      plot_ly(
        type = 'scatterpolar',
        mode = "lines+markers",
        fill = if (input$Fill_tab1.2.2) {
          'toself'
        } else {
          NULL
        }
      ) %>%
        add_trace(
          r = c(as.numeric(df.Cl_t()[1,]), as.numeric(df.Cl_t()[1,])[1]),
          theta = c(colnames(df.Cl_t()), colnames(df.Cl_t())[1]),
          name = "Plantel",
          marker = list(
            size = 14
          ),
          line = list(
            width = 4
          )
        ) %>%
        layout(
          hovermode = 'compare',
          showlegend = TRUE
        ) %>%
        config(
          displaylogo = FALSE,
          modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                     "zoomOut2d", "lasso2d", 
                                     "toggleSpikelines"), 
          toImageButtonOptions = list(
            format = "jpeg",
            filename = paste(
              "Gráfica Spyder de Promedios Proporcionales del ", input$CategoryInput, 
              " en ", input$DimInput_tab1.2,
              " con rango de fecha desde ", input$timeFromInput, 
              " hasta ", input$timeToInput,
              sep = ""
            ),
            scale = 2
          )
        ) %>% toWebGL()
    }
  })
  observeEvent(input$Plot_tab1.2.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.2.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab1.2.2_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab1.2.2_Modal,{
    removeModal()
  })
  
  ####  TABLE_1.2.2  ####
  
  Table_tab1.2.2 <- reactive({
    if(input$Player){
      ## Promedio General
      df.G <- 
        df.PD.s() %>%
        group_by(Medición) %>% 
        summarise(Valor=round(mean(ValorMedición),1)) %>% 
        as.data.frame() %>% 
        spread(Medición, Valor)  
      ## Promedio Jugador
      df.J <- 
        df.tab1.2_PD() %>% 
        group_by(Medición) %>% 
        summarise(Valor=round(mean(ValorMedición),1)) %>% 
        as.data.frame() %>% 
        spread(Medición, Valor)
      ## Internal Validation
      validate(need(ncol(df.J) == ncol(df.G), 
                    message = na.cl.com))
      ## Promedio Jugador
      df.J_2 <- 
        df_PD_fil_w() %>% 
        group_by(Medición) %>% 
        summarise(Valor=round(mean(ValorMedición),1)) %>% 
        as.data.frame() %>% 
        spread(Medición, Valor)
      ## DF Final
      df <- 
        rbind(df.G,df.J,df.J_2) %>% 
        mutate(Categoría=c("Plantel", input$PlayerInput, "Jugador2")) %>% 
        t()
      colnames(df) <- df["Categoría",1:3]
      df.T <- 
        df %>% as.data.frame() %>% filter(!Plantel %in% "Plantel") %>% 
        as.data.frame() %>% 
        tibble::rownames_to_column(var = "Medición") %>%
        mutate_at(
          c("Plantel",input$PlayerInput,"Jugador2"), 
          as.numeric
        )
      ## Min & Max DT
      df_MM <- 
        df.PD.s() %>% 
        group_by(Medición) %>% 
        summarise(Máximo=max(ValorMedición)) %>%
        select(!Medición)
      ## Mergin
      cbind(df.T,df_MM) %>% 
        relocate(Medición,Máximo,Plantel,input$PlayerInput,Jugador2) %>%
        rename(
          "Valor Máximo" = Máximo,
          "Promedio Plantel" = Plantel
        ) %>%
        rename_at(input$PlayerInput, list( ~paste0("Promedio ",input$PlayerInput, " 1"))) %>%
        rename_at("Jugador2", list( ~paste0("Promedio ",input$PlayerInput, " 2")))
    } else {
      ## DF Final
      df.T <- 
        df.tab1.2_PD() %>% 
        group_by(Medición) %>% 
        summarise(Valor=round(mean(ValorMedición),1)) %>% 
        as.data.frame() %>% 
        spread(Medición, Valor) %>% 
        mutate(Categoría=c("Plantel")) %>% 
        t() %>% 
        as.data.frame() %>% 
        rename("Plantel"=V1) %>% 
        filter(!Plantel %in% "Plantel") %>% 
        tibble::rownames_to_column(var = "Medición") %>%
        mutate_at(
          "Plantel", 
          as.numeric
        )
      ## Min & Max DT
      df_MM <- 
        df.PD.s() %>% 
        group_by(Medición) %>% 
        summarise(Máximo=max(ValorMedición)) %>%
        select(!Medición)
      ## Mergin
      cbind(df.T,df_MM) %>% 
        relocate(Medición,Máximo,Plantel) %>%
        rename(
          "Valor Máximo" = Máximo,
          "Promedio Plantel" = Plantel
        )
    }
  })
  
  output$Table_tab1.2.2 <- DT::renderDataTable({
    DT::datatable(
      Table_tab1.2.2(), 
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching=FALSE, info=FALSE,
        scrollX='400px', scrollY="520px", 
        scrollCollapse=TRUE, paging=FALSE,
        columnDefs=list(list(className="dt-center", targets="_all")))
    ) 
  }) 
  output$download_Table_tab1.2.2.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla de Promedios Proporcionales del ", input$CategoryInput, 
          " y del Jugador ", input$PlayerInput,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", 
          sep = ""
        )
      } else {
        paste(
          "Tabla de Promedios Proporcionales del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", 
          sep = ""
        )
      }
    },
    content = function(file) {
      write.xlsx(Table_tab1.2.2(), file, 
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.2.2.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla de Promedios Proporcioanles del ", input$CategoryInput, 
          " y del Jugador ", input$PlayerInput,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", 
          sep = ""
        )
      } else {
        paste(
          "Tabla de Promedios Proporcioanles del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", 
          sep = ""
        )    
      }
    },
    content = function(file) {
      write.csv(Table_tab1.2.2(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab1.2.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Table_tab1.2.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab1.2.2_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab1.2.2_Modal,{
    removeModal()
  })
  
  #### --------------------------- TAB_1_3 --------------------------- #### 
  
  ####  UI  ####
  levelsMeters_tab1.3 <- reactive({
    df_PD %>% 
      filter(
        Dimensión %in% "Autoreporte",
        !Medición %in% "Nivel de percepción por el esfuerzo"
      ) %>%
      select(Medición) %>%
      unique() %>% 
      drop_na() %>%
      t()
  })
  output$metersOption_tab1.3 <- renderUI({
    pickerInput(
      inputId = 'MetInput_tab1.3',
      label = '',
      multiple = TRUE,
      choices = levelsMeters_tab1.3(),
      selected = levelsMeters_tab1.3()[1],
      options = list(
        #style = "btn-info",
        `actions-box` = TRUE,
        `selected-text-format` = "count > 2",
        `count-selected-text` = "{0}/{1} Mediciones"
      )
    )
  })
  
  ####  DF_1.3  #### 
  
  df.tab1.3.0.1_PD <- reactive({
    df_PD %>%
      mutate("Semana" = lubridate::week(FechaDimensión) %>% as.factor(),
             "Mes" = lubridate::month(FechaDimensión) %>% as.factor()) %>%
      group_by(Mes, Semana) %>%
      summarise(n()) %>%
      select(Mes, Semana) %>%
      mutate("Semana/Mes"=stringr::str_c(Semana," / ",Mes))
  })
  
  df.tab1.3.0.2_PD <- reactive({
    df_PD %>%
      mutate("Semana" = lubridate::week(FechaDimensión) ,
             "Mes" = lubridate::month(FechaDimensión)) %>%
      group_by(Mes, Semana) %>%
      summarise(n()) %>%
      select(Mes, Semana) %>%
      mutate("Semana/Mes"=stringr::str_c(Semana," / ",Mes))
  })
  
  df.tab1.3.1_PD <- reactive({
    if(input$Player){
      df_PD %>%
        filter(
          Categoría %in% input$CategoryInput,
          Jugador %in% input$PlayerInput,
          Dimensión %in% "Autoreporte",
          Medición %in% input$MetInput_tab1.3
        ) %>%
        group_by(FechaDimensión) %>%
        summarise(
          Suma = sum(ValorMedición)
        ) %>%
        mutate("Semana" = lubridate::week(FechaDimensión) %>% as.factor()) %>%
        group_by(Semana) %>%
        summarise(
          Promedio = mean(Suma) %>% round(1)
        ) %>%
        mutate(
          Zscore = (
            (Promedio  - mean(Promedio )) / sd(Promedio )
          ) %>% round(2)
        ) 
    } else {
      df_PD %>%
        filter(
          Categoría %in% input$CategoryInput,
          Dimensión %in% "Autoreporte",
          Medición %in% input$MetInput_tab1.3
        ) %>%
        group_by(FechaDimensión) %>%
        summarise(
          Suma = sum(ValorMedición)
        ) %>%
        mutate("Semana" = lubridate::week(FechaDimensión) %>% as.factor()) %>%
        group_by(Semana) %>%
        summarise(
          Promedio = mean(Suma) %>% round(1)
        ) %>%
        mutate(
          Zscore = (
            (Promedio  - mean(Promedio )) / sd(Promedio )
          ) %>% round(2)
        ) 
    }
  })
  # df.tab1.3.2_PD <- reactive({
  #   if(input$Player){
  #     # Main DF
  #     df.W <- 
  #       left_join(
  #         df_PD %>% 
  #           filter(
  #             Categoría %in% input$CategoryInput,
  #             Jugador %in% input$PlayerInput,
  #             Medición %in% "Minutos de Exposición"
  #           ) %>% 
  #           group_by(Jugador, FechaDimensión) %>% 
  #           summarise(
  #             Suma.Min.Exp = sum(ValorMedición)
  #           ) %>% 
  #           mutate("Semana" = lubridate::week(FechaDimensión)), 
  #         df_PD %>% 
  #           filter(
  #             Categoría %in% input$CategoryInput,
  #             Jugador %in% input$PlayerInput,
  #             Medición %in% "Nivel de percepción del esfuerzo"
  #           ) %>% 
  #           group_by(Jugador, FechaDimensión) %>% 
  #           summarise(
  #             Suma.D.Med = sum(ValorMedición) 
  #           ), 
  #         by = c(
  #           "FechaDimensión" = "FechaDimensión", 
  #           "Jugador" = "Jugador"
  #         )
  #       ) %>%
  #       mutate(
  #         Suma.Diaria = Suma.Min.Exp*Suma.D.Med
  #       ) %>% 
  #       group_by(FechaDimensión) %>% 
  #       summarise(
  #         Promedio.Diario = mean(Suma.Diaria)
  #       ) %>% 
  #       mutate("Semana" = lubridate::week(FechaDimensión)) %>% 
  #       select(!FechaDimensión)  %>% 
  #       group_by(Semana) %>% 
  #       summarise(
  #         Acute.Workload = sum(Promedio.Diario) %>% round(0)
  #       ) 
  #     # New Object
  #     Chronic.Workload <- 
  #       data.frame(
  #         "Chronic.Workload" = numeric()
  #       )
  #     # Defining new means
  #     for (i in 5:nrow(df.W)) {
  #       Chronic.Workload[i,1] <- 
  #         round(sum(df.W[i-1,2]+df.W[i-2,2]+df.W[i-3,2]+df.W[i-4,2]) / 4 , 0)
  #     }
  #     # Final DF
  #     left_join(
  #       cbind(df.W,Chronic.Workload) %>%
  #         mutate(
  #           Chronic.Workload.Ratio  = round(Acute.Workload / Chronic.Workload, 2),
  #           Zscore = ( 
  #             (Acute.Workload  - mean(Acute.Workload )) / sd(Acute.Workload ) 
  #           ) %>% round(2)
  #         ) %>%
  #         rename(
  #           "Agudo" = Acute.Workload,
  #           "Crónico" = Chronic.Workload,
  #           "ACWR" = Chronic.Workload.Ratio
  #         ) %>% 
  #         arrange(desc(Semana)),
  #       df.tab1.3.0.2_PD(),
  #       by = "Semana"
  #     ) %>% 
  #       relocate("Semana/Mes", .before = Semana) 
  #   } else {
  #     # Main DF
  #     df.W <- 
  #       left_join(
  #         df_PD %>% 
  #           filter(
  #             Categoría %in% input$CategoryInput,
  #             Medición %in% "Minutos de Exposición"
  #           ) %>% 
  #           group_by(Jugador, FechaDimensión) %>% 
  #           summarise(
  #             Suma.Min.Exp = sum(ValorMedición)
  #           ) %>% 
  #           mutate("Semana" = lubridate::week(FechaDimensión)), 
  #         df_PD %>% 
  #           filter(
  #             Categoría %in% input$CategoryInput,
  #             Medición %in% "Nivel de percepción del esfuerzo"
  #           ) %>% 
  #           group_by(Jugador, FechaDimensión) %>% 
  #           summarise(
  #             Suma.D.Med = sum(ValorMedición) 
  #           ), 
  #         by = c(
  #           "FechaDimensión" = "FechaDimensión", 
  #           "Jugador" = "Jugador"
  #         )
  #       ) %>%
  #       mutate(
  #         Suma.Diaria = Suma.Min.Exp*Suma.D.Med
  #       ) %>% 
  #       group_by(FechaDimensión) %>% 
  #       summarise(
  #         Promedio.Diario = mean(Suma.Diaria)
  #       ) %>% 
  #       mutate("Semana" = lubridate::week(FechaDimensión)) %>% 
  #       select(!FechaDimensión)  %>% 
  #       group_by(Semana) %>% 
  #       summarise(
  #         Acute.Workload = sum(Promedio.Diario) %>% round(0)
  #       ) 
  #     # New Object
  #     Chronic.Workload <- 
  #       data.frame(
  #         "Chronic.Workload" = numeric()
  #       )
  #     # Defining new means
  #     for (i in 5:nrow(df.W)) {
  #       Chronic.Workload[i,1] <- 
  #         round(sum(df.W[i-1,2]+df.W[i-2,2]+df.W[i-3,2]+df.W[i-4,2]) / 4 , 0)
  #     }
  #     # Final DF
  #     left_join(
  #       cbind(df.W,Chronic.Workload) %>%
  #         mutate(
  #           Chronic.Workload.Ratio  = round(Acute.Workload / Chronic.Workload, 2),
  #           Zscore = ( 
  #             (Acute.Workload  - mean(Acute.Workload )) / sd(Acute.Workload ) 
  #           ) %>% round(2)
  #         ) %>%
  #         rename(
  #           "Agudo" = Acute.Workload,
  #           "Crónico" = Chronic.Workload,
  #           "ACWR" = Chronic.Workload.Ratio
  #         ) %>% 
  #         arrange(desc(Semana)),
  #       df.tab1.3.0.2_PD(),
  #       by = "Semana"
  #     ) %>% 
  #       relocate("Semana/Mes", .before = Semana)
  #   }
  # })
  # df.tab1.3.3_PD <- reactive({
  #   # 
  #   df.W <- 
  #     left_join(
  #       df_PD %>% 
  #         filter(Medición %in% "Minutos de Exposición") %>% 
  #         group_by(FechaDimensión) %>% 
  #         summarise(
  #           Suma.Min.Exp = sum(ValorMedición)
  #         ) %>% 
  #         mutate("Semana" = lubridate::week(FechaDimensión)), 
  #       df_PD %>% 
  #         filter(Medición %in% "Nivel de percepción del esfuerzo") %>% 
  #         group_by(FechaDimensión) %>% 
  #         summarise(
  #           Suma.D.Med = sum(ValorMedición) 
  #         ) , 
  #       by = "FechaDimensión"
  #     ) %>%
  #     mutate(
  #       Suma.Diaria = Suma.Min.Exp*Suma.D.Med
  #     ) %>% 
  #     select(!FechaDimensión) %>% 
  #     group_by(Semana) %>% 
  #     summarise(
  #       Acute.Workload = sum(Suma.Diaria)
  #     ) 
  #   # ACWR
  #   Chronic.Workload <- 
  #     data.frame(
  #       "Chronic.Workload" = numeric()
  #     )
  #   for (i in 5:nrow(df.W)) {
  #     Chronic.Workload[i,1] <- 
  #       round(sum(df.W[i-1,2]+df.W[i-2,2]+df.W[i-3,2]+df.W[i-4,2]) / 4 , 0)
  #   }
  #   # Final DF
  #   left_join(
  #     cbind(df.W,Chronic.Workload) %>%
  #       mutate(
  #         Chronic.Workload.Ratio  = round(Acute.Workload / Chronic.Workload, 2),
  #         Zscore = ( 
  #           (Acute.Workload  - mean(Acute.Workload )) / sd(Acute.Workload ) 
  #         ) %>% round(2)
  #       ) %>%
  #       rename(
  #         "Agudo" = Acute.Workload,
  #         "Crónico" = Chronic.Workload,
  #         "ACWR" = Chronic.Workload.Ratio
  #       ),
  #     df_CED %>%
  #       filter(
  #         Categoría_I %in% "Lesión",
  #         MecanismoGeneral %in% "Contacto indirecto"  
  #       ) %>% 
  #       mutate(
  #         "Semana" = lubridate::week(FechaDiagnóstico)
  #       ) %>%
  #       group_by(
  #         Semana,
  #         MecanismoGeneral,
  #         Categoría_I
  #       ) %>% 
  #       tally(),
  #     by = "Semana") %>% 
  #     rename("Frequencia" = n) %>% 
  #     drop_na()
  # })
  # 
  ####  TAB_1.3.1 ####
  output$Plot_tab1.3.1 <- renderPlotly({
    # Selecting Rows
    filtered <- df.tab1.3.1_PD()
    # Visualization
    plot_ly() %>%
      add_trace(
        type='bar',
        x=filtered$Semana,
        y=filtered$Promedio,
        color = I("#0077FFA5"),
        name = "Promedio"
      ) %>%
      add_trace(
        type='scatter',
        x=filtered$Semana,
        y=filtered$Zscore,
        color = I("#1DDE64D1"),
        marker = list(
          size = 8
        ),
        line = list(
          width = 4
        ),
        yaxis = "y2",
        name = "Zscore"
      ) %>%
      layout(
        hovermode = 'compare',
        legend = list(
          x = 36
        ),
        yaxis2 = list(
          overlaying = "y",
          side = "right"
        )
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
              "Diagrama de Esfuerzo del ", input$CategoryInput,
              sep = ""
            ),
          scale = 2
        )
      ) %>% toWebGL()
  })
  observeEvent(input$Plot_tab1.3.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Plot_tab1.3.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab1.3.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab1.3.1_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab1.3.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Input_tab1.3.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab1.3.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab1.3.1_Modal,{
    removeModal()
  })
  
  ####  TABLE_1.3.1  ####
  output$Table_tab1.3.1 <- DT::renderDataTable({
    DT::datatable(
      df.tab1.3.1_PD(),
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      width = "100%",
      selection="multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, info=FALSE,
        scrollX='400px', scrollY="340px",
        scrollCollapse=TRUE, paging=FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    )
  })
  output$download_Table_tab1.3.1.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Promedios de ", input$TypeMetInput_tap1.3,
        " del ", input$CategoryInput,
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(df.tab1.3.1_PD(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.3.1.csv <- downloadHandler(
    filename = function() {
      paste(
        "Promedios de ", input$TypeMetInput_tap1.3,
        " del ", input$CategoryInput,
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(df.tab1.3.1_PD(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab1.3.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Table_tab1.3.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab1.3.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab1.3.1_Modal,{
    removeModal()
  })
  # 
  # ####  TAB_1.3.2 #### 
  # output$Plot_tab1.3.2 <- renderPlotly({
  #   # Selecting Rows
  #   filtered <- 
  #     df.tab1.3.2_PD() %>% 
  #     arrange(Semana) %>%
  #     slice((nrow(df.tab1.3.2_PD())-5):nrow(df.tab1.3.2_PD())-1)
  #   # Visualization
  #   plot_ly() %>% 
  #     add_trace(
  #       type='bar', 
  #       x=filtered$Semana, 
  #       y=filtered$Agudo, 
  #       color = I("#0077FFA5"),
  #       name = "Agudo"
  #     ) %>% 
  #     add_trace(
  #       type='bar', 
  #       x=filtered$Semana, 
  #       y=filtered$Crónico, 
  #       color = I("#1DDE64D1"), 
  #       name = "Crónico"
  #     ) %>% 
  #     add_trace(
  #       type='scatter', 
  #       x=filtered$Semana, 
  #       y=filtered$ACWR, 
  #       color = I("#FF0900DF"), 
  #       marker = list(
  #         size = 8
  #       ),
  #       line = list(
  #         width = 4
  #       ),
  #       yaxis = "y2",
  #       name = "ACWR"
  #     ) %>% 
  #     layout(
  #       hovermode = 'compare',
  #       legend = list(
  #         x = 36
  #       ),
  #       yaxis2 = list(
  #         overlaying = "y",
  #         side = "right"
  #       )
  #     )  %>%
  #     config(
  #       displaylogo = FALSE,
  #       modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
  #                                  "zoomOut2d", "lasso2d", 
  #                                  "toggleSpikelines"), 
  #       toImageButtonOptions = list(
  #         format = "jpeg",
  #         filename = 
  #           paste(
  #             "Diagrama de Esfuerzo del ", input$CategoryInput,
  #             sep = ""
  #           ),
  #         scale = 2
  #       )
  #     ) %>% toWebGL()
  # }) 
  # observeEvent(input$Plot_tab1.3.2_HELP, {
  #   showModal(
  #     modalDialog(
  #       includeHTML("Modals/Tab_1/Plot_tab1.3.2_HELP.html"),
  #       easyClose = TRUE,
  #       size = "m",
  #       footer = actionButton(
  #         inputId = "Plot_tab1.3.2_Modal", 
  #         icon = icon("times-circle"),
  #         label = "Cerrar", 
  #         style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
  #       )
  #     )
  #   )
  # })
  # observeEvent(input$Plot_tab1.3.2_Modal,{
  #   removeModal()
  # })
  # observeEvent(input$Input_tab1.3.2_HELP, {
  #   showModal(
  #     modalDialog(
  #       includeHTML("Modals/Tab_1/Input_tab1.3.2_HELP.html"),
  #       easyClose = TRUE,
  #       size = "m",
  #       footer = actionButton(
  #         inputId = "Input_tab1.3.2_Modal", 
  #         icon = icon("times-circle"),
  #         label = "Cerrar", 
  #         style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
  #       )
  #     )
  #   )
  # })
  # observeEvent(input$Input_tab1.3.2_Modal,{
  #   removeModal()
  # })
  # 
  # ####  TABLE_1.3.2  ####
  # output$Table_tab1.3.2 <- DT::renderDataTable({
  #   DT::datatable(
  #     df.tab1.3.2_PD() %>% select(!c(Semana,Mes)), 
  #     style="bootstrap",
  #     rownames=FALSE,
  #     class="cell-border stripe",
  #     width = "100%",
  #     selection="multiple",
  #     options=list(
  #       ordering=F,
  #       sDom  = '<"top">lrt<"bottom">ip',
  #       searching=TRUE, info=FALSE,
  #       scrollX='400px', scrollY="400px", 
  #       scrollCollapse=TRUE, paging=FALSE,
  #       columnDefs=list(list(className="dt-center", targets="_all"))
  #     )
  #   )
  # })
  # output$download_Table_tab1.3.2.xlsx <- downloadHandler(
  #   filename = function() {
  #     paste(
  #       "Promedios de ", input$TypeMetInput_tap1.3, 
  #       " del ", input$CategoryInput,
  #       ".xlsx", 
  #       sep = ""
  #     )
  #   },
  #   content = function(file) {
  #     write.xlsx(df.tab1.3.2_PD(), file, 
  #                col.names = TRUE, row.names = TRUE, append = FALSE)
  #   }
  # )
  # output$download_Table_tab1.3.2.csv <- downloadHandler(
  #   filename = function() {
  #     paste(
  #       "Promedios de ", input$TypeMetInput_tap1.3, 
  #       " del ", input$CategoryInput,
  #       ".csv", 
  #       sep = ""
  #     )
  #   },
  #   content = function(file) {
  #     write.csv(df.tab1.3.2_PD(), file, row.names = FALSE)
  #   }
  # )
  # observeEvent(input$Table_tab1.3.2_HELP, {
  #   showModal(
  #     modalDialog(
  #       includeHTML("Modals/Tab_1/Table_tab1.3.2_HELP.html"),
  #       easyClose = TRUE,
  #       size = "m",
  #       footer = actionButton(
  #         inputId = "Table_tab1.3.2_Modal", 
  #         icon = icon("times-circle"),
  #         label = "Cerrar", 
  #         style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
  #       )
  #     )
  #   )
  # })
  # observeEvent(input$Table_tab1.3.2_Modal,{
  #   removeModal()
  # })
  # 
  # ####  TAB_1.3.3 #### 
  # output$Plot_tab1.3.3 <- renderPlotly({
  #   ggplotly(
  #     ggplot(df.tab1.3.3_PD(), aes(x=ACWR, y=Frequencia, group=1)) +
  #       geom_point(size=1.3) +
  #       stat_smooth(color="#FC4E07", fill="#FC4E07", 
  #                   size=.7, alpha=0.2,
  #                   method="lm", formula = y~I(x^2)) +
  #       annotate(geom="rect", alpha=.05, fill="black", color="black",
  #                xmin=max(df.tab1.3.3_PD()$ACWR)*.1, 
  #                xmax=max(df.tab1.3.3_PD()$ACWR)*.4,
  #                ymin=max(df.tab1.3.3_PD()$Frequencia)*.9, 
  #                ymax=max(df.tab1.3.3_PD()$Frequencia)*1.2) +
  #       labs(x=NULL, y=NULL, colour=NULL, fill=NULL) +
  #       theme(panel.grid.major=element_line(colour="#00000018"),
  #             panel.grid.minor=element_line(colour="#00000018"),
  #             panel.background=element_rect(fill="transparent",colour=NA))
  #   ) %>% 
  #     add_annotations(
  #       x=max(df.tab1.3.3_PD()$ACWR)*.25, 
  #       y=max(df.tab1.3.3_PD()$Frequencia)*1.1, 
  #       text=paste("Correlación: ", 
  #                  cor(df.tab1.3.3_PD()$ACWR,df.tab1.3.3_PD()$Frequencia, 
  #                      use="complete.obs") %>% round(2)),
  #       showarrow=FALSE
  #     ) %>% 
  #     add_annotations(
  #       x=max(df.tab1.3.3_PD()$ACWR)*.25,
  #       y=max(df.tab1.3.3_PD()$Frequencia)*1,
  #       text=paste("P valor: ",
  #                  cor.test(df.tab1.3.3_PD()$ACWR,
  #                           df.tab1.3.3_PD()$Frequencia)$p.value %>% round(3)),
  #       showarrow=FALSE
  #     ) %>%
  #     config(
  #       displaylogo = FALSE,
  #       modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
  #                                  "zoomOut2d", "lasso2d", 
  #                                  "toggleSpikelines"), 
  #       toImageButtonOptions = list(
  #         format = "jpeg",
  #         filename = 
  #           paste(
  #             "Gráfica de Lesiones por Contacto Indirecto según ACWR",
  #             sep = ""
  #           ),
  #         scale = 2
  #       )
  #     ) 
  # })
  # observeEvent(input$Plot_tab1.3.3_HELP, {
  #   showModal(
  #     modalDialog(
  #       includeHTML("Modals/Tab_1/Plot_tab1.3.3_HELP.html"),
  #       easyClose = TRUE,
  #       size = "m",
  #       footer = actionButton(
  #         inputId = "Plot_tab1.3.3_Modal", 
  #         icon = icon("times-circle"),
  #         label = "Cerrar", 
  #         style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
  #       )
  #     )
  #   )
  # })
  # observeEvent(input$Plot_tab1.3.3_Modal,{
  #   removeModal()
  # })
  # 
  # ####  TABLE_1.3.3  ####
  # output$Table_tab1.3.3 <- DT::renderDataTable({
  #   DT::datatable(
  #     df.tab1.3.3_PD() %>% select(c(ACWR, Frequencia)) %>% arrange(ACWR), 
  #     style="bootstrap",
  #     rownames=FALSE,
  #     class="cell-border stripe",
  #     width = "100%",
  #     selection="multiple",
  #     options=list(
  #       ordering=F,
  #       sDom  = '<"top">lrt<"bottom">ip',
  #       searching=TRUE, info=FALSE,
  #       scrollX='400px', scrollY="400px", 
  #       scrollCollapse=TRUE, paging=FALSE,
  #       columnDefs=list(list(className="dt-center", targets="_all"))
  #     )
  #   )
  # })
  # output$download_Table_tab1.3.3.xlsx <- downloadHandler(
  #   filename = function() {
  #     paste(
  #       "Tabla de Lesiones por Contacto Indirecto según ACWR",
  #       ".xlsx", 
  #       sep = ""
  #     )
  #   },
  #   content = function(file) {
  #     write.xlsx(df.tab1.3.3_PD(), file, 
  #                col.names = TRUE, row.names = TRUE, append = FALSE)
  #   }
  # )
  # output$download_Table_tab1.3.3.csv <- downloadHandler(
  #   filename = function() {
  #     paste(
  #       "Tabla de Lesiones por Contacto Indirecto según ACWR",
  #       ".csv", 
  #       sep = ""
  #     )
  #   },
  #   content = function(file) {
  #     write.csv(df.tab1.3.3_PD(), file, row.names = FALSE)
  #   }
  # )
  # observeEvent(input$Table_tab1.3.3_HELP, {
  #   showModal(
  #     modalDialog(
  #       includeHTML("Modals/Tab_1/Table_tab1.3.3_HELP.html"),
  #       easyClose = TRUE,
  #       size = "m",
  #       footer = actionButton(
  #         inputId = "Table_tab1.3.3_Modal", 
  #         icon = icon("times-circle"),
  #         label = "Cerrar", 
  #         style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
  #       )
  #     )
  #   )
  # })
  # observeEvent(input$Table_tab1.3.3_Modal,{
  #   removeModal()
  # })
  
  #### --------------------------- TAB_2 --------------------------- #### 
  
  ####  VB_2  #### 
  # ValueBox 2.0.1
  valuebox_tab2.0.1 <- reactive({
    df_PD_F_fil() %>% 
      filter(Medición %in% "PCR",
             ValorMedición %in% "Negativo") %>%
      nrow()
  })
  output$valuebox_tab2.0.1 <- renderValueBox({
    valueBox(
      valuebox_tab2.0.1(),
      "PCR Negativos", 
      icon = icon("virus-slash"),
      color = "green"
    )
  })
  # ValueBox 2.0.2
  valuebox_tab2.0.2 <- reactive({
    df_PD_F_fil() %>% 
      filter(Medición %in% "PCR",
             ValorMedición %in% "Positivo") %>%
      nrow()
  })
  output$valuebox_tab2.0.2 <- renderValueBox({
    valueBox(
      valuebox_tab2.0.2(),
      "PCR Positivos", 
      icon = icon("virus"),
      color = "red"
    )
  })
  # ValueBox 2.1
  valuebox_tab2.1 <- reactive({
    table(
      df_CED_C() %>%
        select(c("ID_Diagnóstico","Categoría_I","Jugador")) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(
          Categoría_I %in% "Lesión"
        )
    ) %>% 
      as.data.frame() %>%
      filter(Freq != 0)%>%
      select(Jugador) %>%
      unique() %>%
      drop_na() %>% 
      nrow()
  })
  output$valuebox_tab2.1 <- renderValueBox({
    valueBox(
      if (valuebox_tab2.1() == 0) { 0 } else { valuebox_tab2.1() },
      "Deportistas Lesionados", 
      icon = icon("crutch"),
      color = "aqua"
    )
  })
  # ValueBox 2.2
  valuebox_tab2.2 <- reactive({
    table(
      df_CED_C() %>%
        select(c("ID_Diagnóstico","Categoría_I","Jugador")) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(
          Categoría_I %in% "Enfermedad"
        )
    ) %>% 
      as.data.frame() %>%
      filter(Freq != 0) %>%
      select(Jugador) %>%
      unique() %>%
      drop_na() %>% 
      nrow()
  })
  output$valuebox_tab2.2 <- renderValueBox({
    valueBox(
      if (valuebox_tab2.2() == 0) { 0 } else { valuebox_tab2.2() },
      "Deportistas Enfermos", 
      icon = icon("stethoscope"),
      color = "aqua"
    )
  })
  # ValueBox 2.3
  Injury <- reactive({
    df_CED_fil() %>%
      select(c("ID_Diagnóstico","Categoría_I")) %>% 
      distinct() %>% 
      select(!ID_Diagnóstico) %>%
      filter(
        Categoría_I %in% "Lesión"
      ) %>%
      table() %>% 
      as.data.frame() %>%
      arrange(desc(Freq)) %>%
      select(Freq) %>%
      slice(1) %>% 
      as.numeric()
  })
  output$valuebox_tab2.3 <- renderValueBox({
    valueBox(
      if (is.na(Min_Exp()) == TRUE || Min_Exp() == 0 || Injury() == 0) { 0 } 
      else { round(((Injury()/(Min_Exp()/60))),2) },
      paste("Incidencia Lesión ", input$mInput_tab2.0),
      icon = icon("hospital-user"),
      color = "aqua"
    )
  })
  output$valuebox_tab2.4 <- renderValueBox({
    valueBox(
      if (
        df_CED_C() %>% 
        select(Jugador) %>%
        unique() %>%
        drop_na() %>%
        nrow() == 0
      ) {
        0
      } else {
        (
          (
            (
              df_CED_C() %>%
                select(c("ID_Diagnóstico","Categoría_I","Jugador")) %>% 
                distinct() %>% 
                select(!ID_Diagnóstico) %>%
                group_by(Jugador, Categoría_I) %>% 
                tally() %>% 
                filter(Categoría_I %in% "Lesión") %>% 
                nrow()
            ) / (
              df_CED_C() %>%
                select(c("ID_Diagnóstico","Categoría_I","Jugador")) %>% 
                distinct() %>% 
                select(Jugador) %>%
                unique() %>%
                drop_na() %>% 
                nrow()
            )
          ) * 100
        ) %>% round(1)
      },
      "Índice Lesión Jugador", 
      icon = icon("user-injured"),
      color = "aqua"
    )
  })
  
  ####  TABLE_2.0  #### 
  
  Table_tab2.0 <- reactive({
    # Creating Df Object
    if (input$mInput_tab2.0 == "Partido") {
      Categoría_I <- 
        df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Instancia",
                 as.character(input$cInput_tab1.0))) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(Categoría_I %in% input$cInput_tab2.0,
               Instancia %in% c("Partido","Calentamiento partido")) %>%
        select(Categoría_I,as.character(input$cInput_tab1.0)) %>%
        drop_na()
    } else {
      Categoría_I <- 
        df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Instancia",
                 as.character(input$cInput_tab1.0))) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(Categoría_I %in% input$cInput_tab2.0,
               Instancia %in% c("Entrenamiento","Acumulación de cargas físicas")) %>%
        select(Categoría_I,as.character(input$cInput_tab1.0)) %>%
        drop_na()
    }
    # Internal Validation
    validate(need(!nrow(Categoría_I) == 0, 
                  na.time))
    # Building the Table 
    table.DF <- 
      table(Categoría_I) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(Freq != 0) %>%
      rename("Frecuencia"=Freq)
    # Droping levels
    for (i in seq(1, (ncol(table.DF)-1), by=1)) {
      table.DF[,i] <- droplevels(table.DF[,i], exclude="NULL")
    }
    # Final table
    table.DF %>% 
      drop_na() %>% 
      mutate(
        Porcentage=round(Frecuencia/sum(Frecuencia),2),
        "Incidencia" = round(((Frecuencia/(Min_Exp()/60))*1000),2)
      ) %>%
      rename_at("Incidencia", list( ~paste0("Incidencia ", input$cInput_tab2.0)))
  }) 
  output$Table_tab2.0 <- DT::renderDataTable({
    DT::datatable(
      Table_tab2.0(), 
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      filter = 'top',
      selection="multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        scrollX='400px', scrollY="400px", 
        info=FALSE, paging=FALSE, 
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) %>% 
      formatPercentage("Porcentage") %>%
      formatStyle(
        'Porcentage',
        background = styleColorBar(Table_tab2.0()$Porcentage, 'lightblue'),
        backgroundSize = '40%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      )
  })
  output$download_Table_tab2.0.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla de Epidemiología de ", input$cInput_tab2.0, 
          " del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla de Epidemiología de ", input$cInput_tab2.0, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(Table_tab2.0(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab2.0.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla de Epidemiología de ", input$cInput_tab2.0, 
          " del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla de Epidemiología de ", input$cInput_tab2.0, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(Table_tab2.0(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab2.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Table_tab2.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab2.0_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab2.0_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab2.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Input_tab2.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab2.0_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab2.0_Modal,{
    removeModal()
  })
  
  ####  TABLE_2.1  #### 
  Table_tab2.1 <- reactive({
    # Input Validation
    validate(need(nrow(df_CED_fil()) != 0, 
                  na.time.med))
    validate(need(!is.na(input$cInput_tab1.1), 
                  na.cat))
    # Creating Df Object
    filtered <- df_CED_fil() %>%
      select(
        "ID_Diagnóstico", 
        as.character(input$cInput_tab1.1)
      ) %>% 
      distinct() %>% 
      select(!ID_Diagnóstico) %>%
      drop_na()
    # Internal Validation
    validate(need(!nrow(filtered) == 0, 
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
    table.DF <- 
      table.DF %>% 
      drop_na() %>% 
      mutate(
        Porcentage=round(Frecuencia/sum(Frecuencia),2)
      )
    if (as.character(input$cInput_tab1.1) %>% as.data.frame() %>% nrow() == 1) {
      colnames(table.DF)[1] <- input$cInput_tab1.1
    }
    if (is.element('Diagnóstico', colnames(table.DF)) & 
        is.element('Categoría_I', colnames(table.DF))) {
      table.DF <- table.DF %>% filter(Categoría_I != "Molestia")
    } else{
      table.DF
    } 
  }) 
  output$Table_tab2.1 <- DT::renderDataTable({
    DT::datatable(
      Table_tab2.1(), 
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      filter = 'top',
      selection="multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        scrollX='400px', scrollY="450px", 
        info=FALSE, paging=FALSE, 
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) %>% 
      formatPercentage("Porcentage") %>%
      formatStyle(
        'Porcentage',
        background = styleColorBar(Table_tab2.1()$Porcentage, 'lightblue'),
        backgroundSize = '40%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      )
  })
  output$download_Table_tab2.1.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla de Frecuencias Combinadas del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frecuencias Combinadas del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(Table_tab2.1(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab2.1.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla de Frecuencias Combinadas del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frecuencias Combinadas del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(Table_tab2.1(), file, row.names = FALSE)
    }
  )
  Plot_tab2.1_Footer_A <- reactive({
    table(
      df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Jugador")) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(
          Categoría_I %in% "Cirugía"
        )
    ) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(
        Freq != 0
      ) %>%
      select(Freq) %>%
      slice(1)
  })
  output$Plot_tab2.1_Footer_A <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "prescription-bottle",
      numberColor = "aqua", 
      header =  
        if (nrow(Plot_tab2.1_Footer_A()) == 0) { 0 } else { Plot_tab2.1_Footer_A() },
      text = " Cirugías"
    )
  })
  Plot_tab2.1_Footer_B <- reactive({
    table(
      df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Categoría_II")) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(
          Categoría_I %in% "Molestia",
          Categoría_II %in% "Muscular Fascia"
        )
    ) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(
        Freq != 0
      ) %>%
      select(Freq) %>%
      slice(1)
  })
  output$Plot_tab2.1_Footer_B <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "file-medical",
      numberColor = "aqua", 
      header =  
        if (nrow(Plot_tab2.1_Footer_B()) == 0) { 0 } else { Plot_tab2.1_Footer_B() },
      text = "Molestias Musculares"
    )
  })
  Plot_tab2.1_Footer_C <- reactive({
    table(
      df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Categoría_II")) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(
          Categoría_I %in% "Lesión",
          Categoría_II %in% "Muscular Fascia"
        )
    ) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(
        Freq != 0
      ) %>%
      select(Freq) %>%
      slice(1)
  })
  output$Plot_tab2.1_Footer_C <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "file-medical",
      numberColor = "aqua", 
      header =  
        if (nrow(Plot_tab2.1_Footer_C()) == 0) { 0 } else { Plot_tab2.1_Footer_C() },
      text = "Lesiones Musculares"
    )
  })
  Plot_tab2.1_Footer_D <- reactive({
    table(
      df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Categoría_II")) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(
          Categoría_I %in% "Lesión",
          Categoría_II %in% "Tendones"
        )
    ) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(
        Freq != 0
      ) %>%
      select(Freq) %>%
      slice(1) %>% 
      as.numeric()
  })
  Plot_tab2.1_Footer_D_A <- reactive({
    table(
      df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Categoría_II")) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(
          Categoría_I %in% "Molestia",
          Categoría_II %in% "Tendones"
        )
    ) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(
        Freq != 0
      ) %>%
      select(Freq) %>%
      slice(1) %>% 
      as.numeric() 
  })
  Plot_tab2.1_Footer_D_B <- reactive({
    table(
      df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Categoría_II")) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(
          Categoría_I %in% "Lesión",
          Categoría_II %in% "Tendones"
        )
    ) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(
        Freq != 0
      ) %>%
      select(Freq) %>%
      slice(1) %>% 
      as.numeric()
  })
  output$Plot_tab2.1_Footer_D <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "file-medical",
      numberColor = "aqua", 
      header =  
        if (is.na(Plot_tab2.1_Footer_D_A()) == TRUE) { 0 } else { Plot_tab2.1_Footer_D_A() } + 
        if (is.na(Plot_tab2.1_Footer_D_B()) == TRUE) { 0 } else { Plot_tab2.1_Footer_D_B() },      
      text = "Lesiones/Molestias Tendón"
    )
  })
  observeEvent(input$Table_tab2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Table_tab2.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab2.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab2.1_Modal,{
    removeModal()
  })
  
  ####  INPUT_2.1  #### 
  observeEvent(input$Input_tab2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Input_tab2.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab2.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab2.1_Modal,{
    removeModal()
  })
  
  ####  TAB_2.1  #### 
  output$Plot_tab2.1 <- renderPlotly({
    # Input Validation
    validate(need(nrow(df_CED_fil()) != 0, 
                  na.time))
    # Creating Df Object
    filtered <- df_CED_fil() %>%
      select(
        "ID_Diagnóstico",
        input$cInput_tab1.2,
        input$cInput_tab1.3
      ) %>% 
      distinct() %>% 
      select(!ID_Diagnóstico) %>% 
      mutate_all(~na_if(.,"NULL")) %>% 
      drop_na()
    if (is.element('Diagnóstico', colnames(filtered)) & 
        is.element('Categoría_I', colnames(filtered))) {
      filtered <- 
        filtered %>% filter(Categoría_I != "Molestia")
    } 
    # Visualization
    ggplotly(
      ggplot(filtered, aes(x=!!input$cInput_tab1.2, 
                           fill=!!input$cInput_tab1.3)) +
        geom_bar(stat="count", 
                 alpha=.7, 
                 width=.7, 
                 color="black", 
                 size=.3) +
        labs(x=NULL, y=NULL, fill=NULL) +
        #scale_fill_brewer(palette = "Paired") +
        #scale_color_gradientn(colours = rainbow(18)) +
        theme(panel.grid.major.x = element_blank(),
              axis.text.x=element_text(angle=45, hjust=1),
              panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA)),
      tooltip = c(input$cInput_tab1.2, input$cInput_tab1.3, "y")
    ) %>% 
      layout(
        hovermode = 'compare' # = "x unified"
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
              "Diagrama de Densidad de ", input$cInput_tab1.2, 
              " con ", input$cInput_tab1.3,  
              " del ", input$CategoryInput, 
              " con rango de fecha desde ", input$timeFromInput, 
              " hasta ", input$timeToInput,
              sep = ""
            ),
          scale = 2
        )
      ) 
  }) 
  observeEvent(input$Plot_tab2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Plot_tab2.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab2.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab2.1_Modal,{
    removeModal()
  })
  
  ####  INPUT_2.2  #### 
  observeEvent(input$Input_tab2.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Input_tab2.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab2.2_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab2.2_Modal,{
    removeModal()
  })
  
  #### --------------------------- TAB_3 --------------------------- #### 
  
  ####  DF_3  #### 
  df.tab3_Matchs <- reactive({
    matchs <- 
      df_PD_fil() %>% 
      filter(TipoMedición %in% "Partido") %>%
      select(FechaDimensión) %>%
      unique() %>%
      drop_na()
    matchs$FechaDimensión
  })
  
  ####  VB_3  #### 
  # output$valuebox_tab3.1 <- renderValueBox({
  #   valueBox(
  #     df_CED_fil() %>% 
  #       filter(!ID_TratamientoKinésico %in% "NULL") %>%
  #       select(c("ID_Diagnóstico","Categoría_I","Jugador")) %>% 
  #       distinct() %>% 
  #       select(Jugador) %>%
  #       unique() %>%
  #       drop_na() %>%
  #       nrow(),
  #     "Deportistas Atención Kinésica", 
  #     icon = icon("user-injured"),
  #     color = "aqua"
  #   )
  # })
  # output$valuebox_tab3.2 <- renderValueBox({
  #   valueBox(
  #     df_PD_fil() %>% 
  #       filter(TipoMedición %in% "Entrenamiento") %>%
  #       select(FechaDimensión) %>%
  #       unique() %>%
  #       drop_na() %>%
  #       nrow(),
  #     "Entrenamientos", 
  #     icon = icon("futbol"),
  #     color = "aqua"
  #   )
  # })
  # output$valuebox_tab3.3 <- renderValueBox({
  #   valueBox(
  #     df_PD_fil() %>% 
  #       filter(TipoMedición %in% "Partido") %>%
  #       select(FechaDimensión) %>%
  #       unique() %>%
  #       drop_na() %>%
  #       nrow(),
  #     "Partidos/Competencias", 
  #     icon = icon("trophy"),
  #     color = "aqua"
  #   )
  # })
  
  ####  TAB_3.1  #### 
  output$Plot_tab3.1 <- renderPlotly({
    ## DF
    df.ID <- 
      rbind(
        df_CED_fil() %>% 
          group_by(FechaDiagnóstico) %>% 
          summarise(
            Cantidad=n_distinct(ID_EventoClínico)
          ) %>% 
          mutate(Grupo="Eventos Clínicos") %>%
          rename(Fecha=FechaDiagnóstico),
        df_KT_fil() %>% 
          group_by(FechaTratamientoKinésico) %>% 
          summarise(
            Cantidad=n_distinct(ID_TratamientoKinésico)
          ) %>% 
          mutate(Grupo="KTR") %>%
          rename(Fecha=FechaTratamientoKinésico),
        df_PD_F_fil() %>% 
          filter(Dimensión %in% "Masoterápea") %>% 
          group_by(Jugador, FechaDimensión) %>% 
          summarise(
            Cantidad_1=n_distinct(Medición)
          ) %>%
          rename(Fecha=FechaDimensión) %>%
          group_by(Fecha) %>% 
          summarise(
            Cantidad=sum(Cantidad_1)
          ) %>% 
          mutate(Grupo="Masajes")
      ) %>%
      filter(!is.na(Fecha)) %>%
      arrange(Fecha)
    ## Empty Range Date
    date.range <- 
      seq.Date(
        from = min(df.ID$Fecha),
        to = max(df.ID$Fecha),
        by = "day"
      )
    ## Join & Final Data Frame
    df.ID <- 
      full_join(
        rbind(
          data.frame(
            Fecha = seq.Date(
              from = min(df.ID$Fecha),
              to = max(df.ID$Fecha),
              by = "day"
            ),
            Cantidad = 0,
            Grupo = "KTR"
          ),
          data.frame(
            Fecha = seq.Date(
              from = min(df.ID$Fecha),
              to = max(df.ID$Fecha),
              by = "day"
            ),
            Cantidad = 0,
            Grupo = "Masajes"     
          ),
          data.frame(
            Fecha = seq.Date(
              from = min(df.ID$Fecha),
              to = max(df.ID$Fecha),
              by = "day"
            ),
            Cantidad = 0,
            Grupo = "Eventos Clínicos"
          )
        ),
        df.ID
      ) %>%
      mutate(Fecha = Fecha %>% as.Date()) %>%
      group_by(Fecha, Grupo) %>%
      summarise(Cantidad = sum(Cantidad))
    ## Matchs
    matchs <- 
      df_PD %>% 
      filter(TipoMedición %in% "Partido") %>%
      select(FechaDimensión) %>%
      unique() %>%
      drop_na()
    ## Visualization
    ggplotly(
      ggplot(df.ID, aes(x=Fecha, y=Cantidad)) +
        # Vertical Lines
        geom_vline(xintercept=as.numeric(as.Date(
          matchs$FechaDimensión
        )), 
        linetype="dashed", color="#E31414", size=.5, alpha=.5) +
        # Variables
        geom_line(aes(colour=Grupo), alpha=0.8, size=0.7) +
        scale_colour_manual(values=c('KTR'="#10B534", 
                                     'Eventos Clínicos'="#1348C2", 
                                     'Masajes'="#C916C0")) + 
        geom_point(aes(colour=Grupo), alpha=1, size=1) +
        # Graph & Axis
        scale_y_continuous(
          limits = c(0, ifelse(max(df.ID$Cantidad) > 15, 
                               sum(max(df.ID$Cantidad),2), 
                               sum(max(df.ID$Cantidad),1))),
          breaks = seq(0, ifelse(max(df.ID$Cantidad) > 15, 
                                 sum(max(df.ID$Cantidad),2), 
                                 sum(max(df.ID$Cantidad),1)),
                       ifelse(max(df.ID$Cantidad) > 28, 3,
                              ifelse(max(df.ID$Cantidad) > 15, 2, 1)))
        ) +
        scale_x_date(
          date_labels="%b-%d", 
          date_breaks= ifelse(difftime(max(df.ID$Fecha), min(df.ID$Fecha), units = "days") %>% 
                                as.numeric() > 150, 
                              "month",
                              ifelse(difftime(max(df.ID$Fecha), min(df.ID$Fecha), units = "days") %>% 
                                       as.numeric() > 31, 
                                     "week", "day"))
        ) +
        labs(y=NULL, x=NULL, colour=NULL) +
        theme(axis.text.x = element_text(angle = 45),
              panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA))
    ) %>% 
      layout(
        legend = list(orientation = 'h'),
        hovermode = "x unified", # = "x unified"
        hoverlabel = list(bordercolor = 'black')
      ) %>% 
      config( 
        displaylogo = FALSE,
        modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                   "zoomOut2d", "lasso2d", 
                                   "toggleSpikelines"), 
        toImageButtonOptions = list(
          format = "jpeg",
          filename = 
            if(input$Player){
              paste(
                "Diagrama de Frequencia de Eventos, Trastamientos y Masajes del Jugador ", input$PlayerInput,
                " del ", input$CategoryInput, 
                " con rango de fecha desde ", input$timeFromInput, 
                " hasta ", input$timeToInput,
                sep = ""
              )
            } else {
              paste(
                "Diagrama de Frequencia de Eventos, Trastamientos y Masajes del ", input$CategoryInput, 
                " con rango de fecha desde ", input$timeFromInput, 
                " hasta ", input$timeToInput,
                sep = ""
              )
            },
          scale = 2
        )
      ) %>% toWebGL()
  })
  Plot_tab3.1_Footer_A <- reactive({
    df_KT_fil() %>% 
      select(ID_TratamientoKinésico) %>% 
      unique() %>% 
      drop_na() %>%
      nrow()
  })
  output$Plot_tab3.1_Footer_A <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "stethoscope",
      numberColor = "aqua", 
      header =  Plot_tab3.1_Footer_A(),
      text = "Total de KTR"
    )
  })
  Plot_tab3.1_Footer_B <- reactive({
    if (df_PD_F_fil() %>% filter(Dimensión %in% "Masoterápea") %>% nrow() == 0) {
      0
    } else {
      df_PD_F_fil() %>% 
        filter(Dimensión %in% "Masoterápea") %>% 
        group_by(Jugador, FechaDimensión) %>% 
        summarise(
          Cantidad_1=n_distinct(Medición)
        ) %>%
        rename(Fecha=FechaDimensión) %>%
        group_by(Fecha) %>% 
        summarise(
          Cantidad=sum(Cantidad_1)
        ) %>% 
        select(Cantidad) %>% 
        sum()
    }
  })
  output$Plot_tab3.1_Footer_B <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "hand-holding-medical",
      numberColor = "aqua", 
      header = Plot_tab3.1_Footer_B(),
      text = "Total de Masajes"
    )
  })
  Plot_tab3.1_Footer_C <- reactive({
    df_CED_fil() %>% 
      select(ID_EventoClínico) %>% 
      unique() %>% 
      drop_na() %>%
      nrow()
  })
  output$Plot_tab3.1_Footer_C <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "notes-medical",
      numberColor = "aqua", 
      header =  Plot_tab3.1_Footer_C(),
      text = "Total de Eventos Clínicos"
    )
  })
  Plot_tab3.1_Footer_D <- reactive({
    df_KT %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaTratamientoKinésico >= input$timeFromInput,
             FechaTratamientoKinésico <= input$timeToInput) %>%
      filter(!ID_TratamientoKinésico %in% "NULL") %>%
      select(Jugador) %>%
      unique() %>%
      drop_na() %>%
      nrow()
  })
  output$Plot_tab3.1_Footer_D <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "",
      numberIcon = "user-friends",
      numberColor = "aqua",
      header = Plot_tab3.1_Footer_D(),
      text = "Total de Deportistas con KTR"
    )
  })
  Plot_tab3.1_Footer_E <- reactive({
    df_PD_fil() %>%
      filter(TipoMedición %in% "Entrenamiento") %>%
      select(FechaDimensión) %>%
      unique() %>%
      drop_na() %>%
      nrow()
  })
  output$Plot_tab3.1_Footer_E <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "",
      numberIcon = "futbol",
      numberColor = "aqua",
      header = Plot_tab3.1_Footer_E(),
      text = "Total de Entrenamientos"
    )
  })
  Plot_tab3.1_Footer_F <- reactive({
    df_PD_fil() %>%
      filter(TipoMedición %in% "Partido") %>%
      select(FechaDimensión) %>%
      unique() %>%
      drop_na() %>%
      nrow()
  })
  output$Plot_tab3.1_Footer_F <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "",
      numberIcon = "trophy",
      numberColor = "aqua",
      header = Plot_tab3.1_Footer_F(),
      text = "Total de Partidos"
    )
  })
  observeEvent(input$Plot_tab3.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_3/Plot_tab3.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab3.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab3.1_Modal,{
    removeModal()
  })
  
  ####  TABLE_3.1  #### 
  Table_tab3.1 <- reactive({
    # Joining DFs
    df.T <- 
      full_join(
        full_join(
          df_CED_fil() %>% 
            group_by(FechaDiagnóstico) %>% 
            summarise(
              'Eventos Clínicos'=n_distinct(ID_EventoClínico)
            ) %>%
            rename(Fecha=FechaDiagnóstico),
          df_KT_fil() %>% 
            group_by(FechaTratamientoKinésico) %>% 
            summarise(
              'Tratamientos Kinésicos'=n_distinct(ID_TratamientoKinésico)
            ) %>%
            rename(Fecha=FechaTratamientoKinésico),
          by = "Fecha"
        ),
        df_PD_F_fil() %>% 
          filter(Dimensión %in% "Masoterápea") %>%  
          group_by(Jugador, FechaDimensión) %>% 
          summarise(
            Cantidad_1=n_distinct(Medición)
          ) %>%
          rename(Fecha=FechaDimensión) %>%
          group_by(Fecha) %>% 
          summarise(
            'Masajes'=sum(Cantidad_1)
          )
      ) %>%
      filter(!is.na(Fecha)) %>%
      arrange(Fecha) %>% 
      as.data.frame()
    for (i in 2:ncol(df.T)) {
      df.T[,i] <- df.T[,i] %>% replace_na(0)
    }
    df.T
  })
  output$Table_tab3.1 <- DT::renderDataTable({
    DT::datatable(
      Table_tab3.1(), 
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      selection="multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        scrollX='400px', scrollY="250px", 
        info=FALSE, paging=FALSE, 
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) 
  })
  output$download_Table_tab3.1.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla de Frequencia de Eventos, Tratamientos y Masajes del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frequencia de Eventos, Tratamientos y Masajes del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(Table_tab3.1(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab3.1.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla de Frequencia de Eventos, Tratamientos y Masajes del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frequencia de Eventos, Tratamientos y Masajes del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(Table_tab3.1(), file, row.names = FALSE)
    }
  )
  
  ####  TABLE_3.2  #### 
  Table_tab3.2 <- reactive({
    data.frame(
      Medida = c(
        "Total KTR",
        "Total Masajes",
        "Total EventosClínicos",
        "Deportistas con KTR",
        "Total Entrenamientos",
        "Total Partidos"
      ),
      Valor = c(
        Plot_tab3.1_Footer_A(),
        Plot_tab3.1_Footer_B(),
        Plot_tab3.1_Footer_C(),
        Plot_tab3.1_Footer_D(),
        Plot_tab3.1_Footer_E(),
        Plot_tab3.1_Footer_F()
      )
    )
  })
  output$Table_tab3.2 <- DT::renderDataTable({
    DT::datatable(
      Table_tab3.2(),
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      selection="multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        info=FALSE, paging=FALSE, 
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) 
  })
  output$download_Table_tab3.2.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla Resumen de Gestión Médica del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla Resumen de Gestión Médica del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(Table_tab3.2(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab3.2.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla Resumen de Gestión Médica del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla Resumen de Gestión Médica del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(Table_tab3.2(), file, row.names = FALSE)
    }
  )
  
  #### --------------------------- TAB_4 --------------------------- #### 
  
  ####  VB_4  #### 
  output$valuebox_tab4.1 <- renderValueBox({
    valueBox(
      df_TL_fil()$TimeLoss %>%
        sum(),
      "Time Loss Total",
      icon = icon("calendar-day"),
      color = "aqua"
    )
  })
  output$valuebox_tab4.2 <- renderValueBox({
    valueBox(
      ifelse(Min_Exp() == 0,
             0,
             (((df_TL_fil()$TimeLoss %>%
                  sum()
             ) / Min_Exp()
             ) * 1000)) %>% round(2),
      "Injury Burden",
      icon = icon("hourglass-half"),
      color = "aqua"
    )
  })
  
  ####  TAB_4.1  #### 
  output$Plot_tab4.1 <- renderPlotly({
    # Creating Cross Tab DF
    df_TL_table <- 
      df_TL_fil() %>% 
      filter(Categoría_I %in% "Lesión") %>%
      select(Severidad) %>% 
      table() %>% 
      as.data.frame() %>% 
      rename("Severidad"='.',"TimeLoss"=Freq)
    # Visualization
    plot_ly(
      df_TL_table, 
      labels = ~Severidad, 
      values = ~TimeLoss, 
      type = 'pie',
      textposition = 'inside',
      textinfo = 'label+percent',
      insidetextfont = list(color = '#FFFFFF'),
      hoverinfo = 'text',
      text = ~paste(TimeLoss, ifelse(TimeLoss == 1, ' Registro', ' Registros')),
      textfont = list(color = '#000000', size = 16),
      marker = list(line = list(color = '#FFFFFF', width = 6)),
      showlegend = FALSE) %>% 
      layout(
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
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
              if(input$Player){
                paste(
                  "Diagrama de Severidad de Lesión del Jugador ", input$PlayerInput, 
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )  
              } else {
                paste(
                  "Diagrama de Severidad de Lesión del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )  
              } 
            ),
          scale = 2
        )
      ) %>%
      toWebGL()
  }) 
  observeEvent(input$Plot_tab4.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_4/Plot_tab4.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab4.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab4.1_Modal,{
    removeModal()
  })
  
  ####  TAB_4.2  #### 
  output$Plot_tab4.2 <- renderPlotly({
    # Creating Cross Tab DF
    df_TL_table <- 
      df_TL_fil() %>% 
      filter(Categoría_I %in% "Enfermedad") %>%
      select(Severidad) %>% 
      table() %>% 
      as.data.frame() %>% 
      rename("Severidad"='.',"TimeLoss"=Freq)
    # Visualization
    plot_ly(
      df_TL_table, 
      labels = ~Severidad, 
      values = ~TimeLoss, 
      type = 'pie',
      textposition = 'inside',
      textinfo = 'label+percent',
      insidetextfont = list(color = '#FFFFFF'),
      hoverinfo = 'text',
      text = ~paste(TimeLoss, ifelse(TimeLoss == 1, ' Registro', ' Registros')),
      textfont = list(color = '#000000', size = 16),
      marker = list(line = list(color = '#FFFFFF', width = 6)),
      showlegend = FALSE) %>% 
      layout(
        xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
        yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
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
              if(input$Player){
                paste(
                  "Diagrama de Severidad de Enfermedad del Jugador ", input$PlayerInput, 
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )  
              } else {
                paste(
                  "Diagrama de Severidad de Lesión del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )  
              } 
            ),
          scale = 2
        )
      ) %>%
      toWebGL()
  }) 
  observeEvent(input$Plot_tab4.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_4/Plot_tab4.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab4.2_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab4.1_Modal,{
    removeModal()
  })
  
  ####  TABLE_4.1  #### 
  output$Table_tab4.1 <- DT::renderDataTable({
    DT::datatable(
      df_TL_fil() %>% 
        arrange(desc(FechaTérmino_TimeLoss)) %>% 
        select(!c("FechaInicio_TimeLoss","Categoría")) %>%
        rename(
          'Fecha Término' = FechaTérmino_TimeLoss,
          Categoría = Categoría_I
        ), 
      style="bootstrap",
      rownames=FALSE,
      class="cell-border stripe",
      selection="multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        scrollX='400px',
        info=FALSE, paging=FALSE, 
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) 
  })
  output$download_Table_tab4.1.xlsx <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla Temporal de Frequencia de Eventos, Tratamientos y Masajes del ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla Temporal de Frequencia de Eventos, Tratamientos y Masajes del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(df_TL_fil(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab4.1.csv <- downloadHandler(
    filename = function() {
      if(input$Player){
        paste(
          "Tabla Temporal de Frequencia de Eventos, Tratamientos y Masajes del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla Temporal de Frequencia de Eventos, Tratamientos y Masajes del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(df_TL_fil(), file, row.names = FALSE)
    }
  )
  
}

####  INTERFACE  #### 

shinyApp(ui = ui, server = server)

