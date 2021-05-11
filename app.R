
####  Importing Libraries and Data Frames 

source("Libraries&DataFrames.R")

#### UI ####

ui <- dashboardPagePlus(
  
  skin = "black",
  
  # enable_preloader = TRUE,
  # loading_duration = 4,
  
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
        br(), br(), 
        not1,
        hr(), not2,
        hr(), not3,
        hr(), not4,
        hr(), not5,
        br(), br()
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
        )
      ),
      menuItem(
        "Evento y Diagnóstico", 
        icon=icon("notes-medical"), 
        tabName="tab_2"
      )
    )
  ),
  # linear-gradient(#FFFFFF, #E0E0E0)
  
  body = dashboardBody(
    
    tags$head(tags$style(HTML(css))),
    
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
                        choices = levels(df_PD$Dimensión),
                        selected = levels(df_PD$Dimensión)[3]
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
              br(),
              br(),
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  ####  TITLE_1.1  ####
                  box(
                    width = 12,
                    background = "black",
                    HTML("<h4><center><b>MEDIDAS ESTADÍSTICAS</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              fluidRow(
                ####  VB_1.1  ####
                column(
                  width = 7,
                  valueBoxOutput(
                    width = 6,
                    "valuebox_tab1.1.1"
                  ),
                  valueBoxOutput(
                    width = 6,
                    "valuebox_tab1.1.2"
                  ),
                  valueBoxOutput(
                    width = 6,
                    "valuebox_tab1.1.3"
                  ),
                  valueBoxOutput(
                    width = 6,
                    "valuebox_tab1.1.4"
                  ),
                  valueBoxOutput(
                    width = 6,
                    "valuebox_tab1.1.5"
                  ),
                  valueBoxOutput(
                    width = 6,
                    "valuebox_tab1.1.6"
                  )
                ),
                column(
                  width = 5,
                  boxPlus(
                    width = 12,
                    title = "Tabla de Z-Score", 
                    status = "primary", 
                    solidHeader = TRUE,
                    ####  TABLE_1.1.2  #### 
                    withSpinner(
                      DT::dataTableOutput("Table_tab1.1.2", height="310px"),
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
                      downloadButton("download_Table_tab1.1.2.xlsx", ".xlsx"),
                      downloadButton("download_Table_tab1.1.2.csv", ".csv")
                    )
                  )
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
                  withSpinner(
                    plotlyOutput("Plot_tab1.1.1", height="350px"),
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
                  )
                ),
                ####  TAB_1.1.2  ####
                boxPlus(
                  width = 5,
                  title = "Gráfica de Densidad", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab1.1.2", height="350px"),
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
                  )
                ),
                ####  TAB_1.1.3  ####
                boxPlus(
                  width = 4,
                  title = "Diagrama de Caja ", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab1.1.3", height="350px"),
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
              )
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
                        choices = levels(df_PD$Dimensión),
                        selected = levels(df_PD$Dimensión)[3]
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
                    background = "black",
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
                    plotlyOutput("Plot_tab1.2.1", height="550px"),
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
                  title = "Tabla Clusters", 
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
                    background = "black",
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
                      plotlyOutput("Plot_tab1.2.2", height="700px"),
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
                ),
              )
      ),
      #### ----------------------------------- TAB_2 ----------------------------------- #### 
      tabItem(tabName = "tab_2",
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
                  ####  TITLE_2  ####
                  box(
                    width = 12,
                    background = "navy",
                    HTML("<h4><center><b>EVENTO CLÍNICO Y DIAGNÓSTICO</b></h4>"),
                  )
                ),
                column(
                  width = 3
                )
              ),
              br(),
              fluidRow(
                ####  VB_2  ####
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab2.1"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab2.2"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab2.3"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab2.4"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab2.5"
                  )
                ),
                column(
                  width = 4,
                  valueBoxOutput(
                    width = 12,
                    "valuebox_tab2.6"
                  )
                )
              ),
              br(),
              fluidRow(
                column(
                  width = 1
                ),
                ####  TABLE_2.0  #### 
                boxPlus(
                  width = 10, 
                  title = "Tabla de Incidencia de Lesión", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab2.0"),
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
                      choices = levels(droplevels(df_CED$Categoría_I, exclude="NULL")),
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
                ),
                column(
                  width = 1
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_2.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Tabla Frecuencia de Combinadas", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab2.1"),
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
                      selected = c("Diagnóstico","Complemento_II"),
                      options = list(`actions-box`=TRUE)
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TAB_2.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Diagramas de Barras Múltiples",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab2.1", height="700px"),
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
        footer = actionButton(
          inputId = "pres", 
          label = strong("Acepto los Términos señalados"), 
          style = "color: white;  background: linear-gradient(60deg, #050505F2, #00C0EF);"
        )
      )
    )
  }, once = TRUE)
  observeEvent(input$pres,{
    showModal(
      modalDialog(
        includeHTML("Modals/Introduction/Basics.html"),
        easyClose = FALSE,
        footer = actionButton(
          inputId = "intro", 
          label = strong("Vamos a analizar los datos !"), 
          style = "color: white;  background: linear-gradient(60deg, #050505F2, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$intro,{
    removeModal()
  })
  
  
  ####  UI  ####
  levelsPlayers <- reactive({
    df_PD %>% 
      filter(Categoría %in% input$CategoryInput) %>%
      select(Jugador) %>%
      unique() %>% t()
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
  
  #### --------------------------- TAB_1_1 --------------------------- #### 
  
  ####  UI  ####
  levelsTypeMeters_tab1.1 <- reactive({
    df_PD %>% 
      filter(
        Dimensión %in% input$DimInput_tab1.1
      ) %>%
      select(TipoMedición) %>%
      unique() %>% t()
  })
  output$typeMetersOption_tab1.1 <- renderUI({
    selectInput(
      inputId = 'TypeMetInput_tap1.1',
      label = '',
      multiple = FALSE,
      choices = levelsTypeMeters_tab1.1(),
      selected = levelsTypeMeters_tab1.1()[2]
    )
  })
  
  levelsMeters_tab1.1 <- reactive({
    df_PD %>% 
      filter(
        Dimensión %in% input$DimInput_tab1.1,
        TipoMedición %in% input$TypeMetInput_tap1.1
      ) %>%
      select(Medición) %>%
      unique() %>% t()
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
        footer = ""
      )
    )
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
        footer = ""
      )
    )
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
        footer = ""
      )
    )
  })
  
  ####  DF_1.1  #### 
  ## General
  df.tab1.1_PD <- reactive({
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
  
  ## Filtered 
  filtered_tab1.1 <- reactive({
    df.tab1.1_PD() %>% filter(Dimensión %in% input$DimInput_tab1.1,
                              TipoMedición %in% input$TypeMetInput_tap1.1,
                              Medición %in% input$MetInput_tab1.1,)
  })
  filtered_tab1.1.2 <- reactive({
    df.tab1.1_PD() %>% filter(Dimensión %in% input$DimInput_tab1.1,
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
  
  SD_tab1.1 <- reactive({
    df <- 
      Stat.DF_tab1.1.1() %>% 
      filter(Medición %in% input$MetInput_tab1.1) %>%
      select(Promedio,Desv.)
    df$Promedio <- ifelse(df$Promedio > 100,df$Promedio %>% round(0),df$Promedio %>% round(1))
    df$Desv. <- ifelse(df$Desv. > 100,df$Desv. %>% round(0),df$Desv. %>% round(1))
    paste0("[", df$Promedio-df$Desv. , "-" , df$Promedio+df$Desv., "]")
  })
  
  output$valuebox_tab1.1.3 <- renderValueBox({
    valueBox(
      SD_tab1.1(),
      "Intervalo de Confianza", 
      icon = icon("less-than-equal"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.1.4 <- renderValueBox({
    valueBox(
      Stat.DF_tab1.1.1() %>% 
        filter(Medición %in% input$MetInput_tab1.1) %>%
        select(Outliers) %>%
        round(0) %>%
        slice(1),
      "Cantidad de Outliers", 
      icon = icon("exclamation-triangle"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.1.5 <- renderValueBox({
    valueBox(
      Stat.DF_tab1.1.1() %>% 
        filter(Medición %in% input$MetInput_tab1.1) %>%
        select(Skew) %>%
        round(1) %>%
        slice(1),
      "Índice Skew", 
      icon = icon("chart-area"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.1.6 <- renderValueBox({
    valueBox(
      Stat.DF_tab1.1.1() %>% 
        filter(Medición %in% input$MetInput_tab1.1) %>%
        select(Kurtosis) %>%
        round(1) %>%
        slice(1),
      "Índice Kurtosis", 
      icon = icon("chart-line"),
      color = "aqua"
    )
  })
  
  ####  TABLE_1.1.2  #### 
  Table_tab1.1.2 <- reactive({
    filtered_tab1.1() %>%
      mutate(
        Zscore = ( 
          (ValorMedición - mean(ValorMedición)) / sd(ValorMedición) 
        ) %>% round(2)
      ) %>%
      select(Jugador,
             Fecha = FechaDimensión,
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
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE,
        scrollX='400px', scrollY="260px", 
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
        footer = ""
      )
    )
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
                 fill = "#30E01D",
                 alpha = .5) +
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
              "Barras de Error Promedio de ", input$MetInput_tab1.1, 
              " del ", input$CategoryInput, 
              " con rango de fecha desde ", input$timeFromInput, 
              " hasta ", input$timeToInput,
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
        size = "m",
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
                     size=.5, 
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
            paste(
              "Diagrama de Densidad de ", input$MetInput_tab1.1, 
              " del ", input$CategoryInput, 
              " con rango de fecha desde ", input$timeFromInput, 
              " hasta ", input$timeToInput,
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
        size = "m",
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
        geom_boxplot(outlier.shape=1, 
                     outlier.size=.8,
                     size=.4,
                     fill = "#EBA417",
                     alpha = .5) +
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
              "Diagrama de Cajas de ", input$MetInput_tab1.1, 
              " del ", input$CategoryInput, 
              " con rango de fecha desde ", input$timeFromInput, 
              " hasta ", input$timeToInput,
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
        size = "m",
        footer = ""
      )
    )
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
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE,
        scrollX='400px', # scrollY="350px", 
        paging=FALSE, info=FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) 
    # %>% 
    #   formatStyle(
    #     'Skew', #fontWeight = 'bold',
    #     color = styleInterval(0, c('blue', 'red'))
    #   ) %>% 
    #   formatStyle(
    #     'Kurtosis', #fontWeight = 'bold',
    #     color = styleInterval(0, c('red', 'blue'))
    #   ) 
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
        footer = ""
      )
    )
  })
  
  #### --------------------------- TAB_1_2 --------------------------- #### 
  
  ####  UI  ####
  levelsTypeMeters_tabe1.2 <- reactive({
    df_PD %>% 
      filter(
        Dimensión %in% input$DimInput_tab1.2
      ) %>%
      select(TipoMedición) %>%
      unique() %>% t()
  })
  output$typeMetersOption_tab1.2 <- renderUI({
    selectInput(
      inputId = 'TypeMetInput_tap1.2',
      label = '',
      multiple = FALSE,
      choices = levelsTypeMeters_tabe1.2(),
      selected = levelsTypeMeters_tabe1.2()[2]
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
        footer = ""
      )
    ) 
  })
  observeEvent(input$Input_tab1.2.2_HELP, {
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
        footer = ""
      )
    )
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
        footer = ""
      )
    )
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
        footer = ""
      )
    )
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
        scrollX='400px', scrollY="420px", 
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
        footer = ""
      )
    )
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
  
  df.tab1.1_PD_2 <- reactive({
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
      df.G <- df.P_g %>% tidyr::spread(Medición, Valor)  
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
      df.J <- df.P_j %>% tidyr::spread(Medición, Valor)
      ## Internal Validation
      validate(need(ncol(df.J) == ncol(df.G), 
                    message = na.cl.com))
      ## Promedio Jugador segunda Capa
      df.P_j_2 <- 
        df.tab1.1_PD_2() %>% 
        group_by(Medición) %>% 
        summarise(Valor=mean(ValorMedición)) %>% 
        as.data.frame()
      for (i in seq(1, nrow(df.P_j_2))) {
        df.P_j_2[i,2] <-  
          round(df.P_j_2[i,2] / max(filter(df_PD, Medición %in% df.P_j_2[i,1])
                                    [,"ValorMedición"]) * 100, 1)
      }
      df.P_j_2 <- df.P_j_2 %>% tidyr::spread(Medición, Valor)
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
      df.P_g %>% tidyr::spread(Medición, Valor)
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
        footer = ""
      )
    )
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
        tidyr::spread(Medición, Valor)  
      ## Promedio Jugador
      df.J <- 
        df.tab1.2_PD() %>% 
        group_by(Medición) %>% 
        summarise(Valor=round(mean(ValorMedición),1)) %>% 
        as.data.frame() %>% 
        tidyr::spread(Medición, Valor)
      ## Internal Validation
      validate(need(ncol(df.J) == ncol(df.G), 
                    message = na.cl.com))
      ## Promedio Jugador
      df.J_2 <- 
        df.tab1.1_PD_2() %>% 
        group_by(Medición) %>% 
        summarise(Valor=round(mean(ValorMedición),1)) %>% 
        as.data.frame() %>% 
        tidyr::spread(Medición, Valor)
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
        tidyr::spread(Medición, Valor) %>% 
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
        footer = ""
      )
    )
  })
  
  #### --------------------------- TAB_2 --------------------------- #### 
  
  ####  VB_2  #### 
  output$valuebox_tab2.1 <- renderValueBox({
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
  output$valuebox_tab2.2 <- renderValueBox({
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
  output$valuebox_tab2.3 <- renderValueBox({
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
  output$valuebox_tab2.4 <- renderValueBox({
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
  output$valuebox_tab2.5 <- renderValueBox({
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
  Min_Exp <- reactive({
    df.tab1.1_PD() %>% 
      filter(TipoMedición %in% input$mInput_tab2.0,
             Medición %in% "Minutos de Exposición") %>%
      select(ValorMedición) %>%
      sum()
  })
  output$valuebox_tab2.6 <- renderValueBox({
    valueBox(
      Min_Exp(),
      "Minutos de Exposición", 
      icon = icon("hourglass-half"),
      color = "aqua"
    )
  })
  
  ####  TABLE_2.0  #### 
  Table_tab2.0 <- reactive({
    # Creating Df Object
    if (input$mInput_tab2.0 == "Partido") {
      Categoría_I <- df.tab1_CED() %>% 
        filter(Categoría_I %in% input$cInput_tab2.0,
               Instancia %in% c("Partido","Calentamiento partido")) %>%
        select(Categoría_I,as.character(input$cInput_tab1.0))
    } else {
      Categoría_I <- df.tab1_CED() %>% 
        filter(Categoría_I %in% input$cInput_tab2.0,
               Instancia %in% c("Entrenamiento","Acumulación de cargas físicas")) %>%
        select(Categoría_I,as.character(input$cInput_tab1.0)) 
    }
    # Internal Validation
    validate(need(!nrow(Categoría_I) == 0, 
                  na.time))
    # Building the Table 
    table.filtered <- 
      table(Categoría_I) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(Freq != 0) 
    table.DF <- 
      table.filtered %>%
      rename("Frecuencia"=Freq)
    # Droping levels
    for (i in seq(1, (ncol(table.DF)-1), by=1)) {
      table.DF[,i] <- droplevels(table.DF[,i], exclude="NULL")
    }
    # Final table
    table.DF %>% 
      tidyr::drop_na() %>% 
      mutate(
        Porcentage=round(Frecuencia/sum(Frecuencia),2),
        "Índice" = round(((Frecuencia/(Min_Exp()/60))*1000),2)
      ) %>%
      rename_at("Índice", list( ~paste0("Índice de ", input$cInput_tab2.0)))
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
          "Tabla de Incidencia de ", input$cInput_tab2.0, 
          " del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla de Incidencia de ", input$cInput_tab2.0, 
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
          "Tabla de Incidencia de ", input$cInput_tab2.0, 
          " del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla de Incidencia de ", input$cInput_tab2.0, 
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
        footer = ""
      )
    )
  })
  
  ####  INPUT_2.0  #### 
  observeEvent(input$Input_tab2.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Input_tab2.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = ""
      )
    )
  })
  
  
  ####  DF_2_MD  #### 
  df.tab1_CED <- reactive({
    if(input$Player){
      df_CED %>% filter(Categoría %in% input$CategoryInput,
                        FechaDiagnóstico >= input$timeFromInput,
                        FechaDiagnóstico <= input$timeToInput,
                        Jugador %in% input$PlayerInput)
    } else {
      df_CED %>% filter(Categoría %in% input$CategoryInput,
                        FechaDiagnóstico >= input$timeFromInput,
                        FechaDiagnóstico <= input$timeToInput)
    }
  })
  
  ####  TABLE_2.1  #### 
  Table_tab2.1 <- reactive({
    # Input Validation
    validate(need(nrow(df.tab1_CED()) != 0, 
                  na.time.med))
    validate(need(!is.na(input$cInput_tab1.1), 
                  na.cat))
    # Creating Df Object
    filtered <- df.tab1_CED() %>%
      select(as.character(input$cInput_tab1.1))
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
    table.DF %>% 
      tidyr::drop_na() %>% 
      mutate(
        Porcentage=round(Frecuencia/sum(Frecuencia),2)
      )
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
  observeEvent(input$Table_tab2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Table_tab2.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = ""
      )
    )
  })
  
  ####  INPUT_2.1  #### 
  observeEvent(input$Input_tab2.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Input_tab2.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = ""
      )
    )
  })
  
  ####  TAB_2.1  #### 
  output$Plot_tab2.1 <- renderPlotly({
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
        geom_bar(stat="count", 
                 alpha=.5, 
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
        footer = ""
      )
    )
  })
  
  ####  INPUT_2.2  #### 
  observeEvent(input$Input_tab2.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Input_tab2.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = ""
      )
    )
  })
  
  
}

####  INTERFACE  #### 

shinyApp(ui = ui, server = server)


