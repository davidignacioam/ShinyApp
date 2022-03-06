
####  Importing Libraries and Data Frames 

source("LD.R")


#### UI ####

ui <- dashboardPagePlus(
  
  skin = "black",
  
  enable_preloader = TRUE,
  loading_duration = 3,

  collapse_sidebar = TRUE,
  sidebar_fullCollapse = FALSE,
  
  footer = dashboardFooter(
    left = div(h4(""),
               h5("Providencia, Chile")), 
    right = div(h6("Desarrollador:"),
                h6("davidignacioam@gmail.com"))
  ),
  
  header = dashboardHeaderPlus(
    fixed = TRUE,
    title = customLogo,
    ####  INPUT_0  ####
    left_menu = tagList(
      uiOutput("categoryOption"),
      dropdownBlock(
        #title = "Orientaciones",
        id = "dropdownBlock_info",
        badgeStatus = NULL,
        icon = "info",
        br(),
        not1,
        not2,
        not3,
        not4,
        not5,
        not6,
        not7,
        br()
      ),
      dropdownBlock(
        id = 1,
        title = "Filtro por Jugadores",
        badgeStatus = NULL,
        icon = "users",
        br(),
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
        hr(),
        materialSwitch(
          inputId = "ExternalData", 
          label = strong("Incluir clubes externos"),
          status = "primary",
          right = TRUE
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
          value = min(date_range),
          min = NULL,
          max = NULL,
          startview = "month",
          language = "es"
        ),
        dateInput(
          width = "150px",
          inputId = "timeToInput", 
          label = "hasta:",
          value = max(date_range),
          min = NULL,
          max = NULL,
          startview = "month",
          language = "es"
        ),
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
        "Estadística Descriptiva", 
        icon = icon("chart-area"), 
        startExpanded = TRUE,
        menuSubItem(
          "Univariada", 
          tabName="tab_1_1", 
          icon=icon("chart-bar")
        ),
        menuSubItem(
          "Multivariada", 
          tabName="tab_1_2", 
          icon=icon("project-diagram")
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
        icon=icon("chart-line"), 
        tabName="tab_3"
      ),
      menuItem(
        "Time Loss", 
        icon=icon("hourglass-half"), 
        tabName="tab_4"
      ),
      menuItem(
        "Auto-Reporte",
        tabName="tab_5",
        icon=icon("clipboard-list")
      ),
      menuItem(
        "Nutrición",
        tabName="tab_6",
        icon=icon("weight")
      ),
      menuItem(
        "Biomecánica",
        tabName="tab_7",
        icon=icon("prescription-bottle")
      ),
      menuItem(
        "Tablas Base de Datos",
        tabName="tab_API",
        icon=icon("table")
      ),
      menuItem(
        "Reporte y Actualización",
        tabName="tab_RELOAD_REPORT",
        icon=icon("file-invoice") #database
      )
    )
  ),
  
  body = dashboardBody(
    
    ## Loading Spinner
    use_busy_spinner(
      spin = "double-bounce",
      color = "#142c59",
      position = "full-page",
      margins = c(20, 20),
      spin_id = NULL,
      height = "200px",
      width = "200px"
    ),
    
    ## CSS
    tags$head(tags$style(HTML(css))),
    
    ## Shiny JS
    shinyjs::useShinyjs(),
    
    tabItems(
      #### ----------------------------------- TAB_1_1 ----------------------------------- #### 
      tabItem(tabName = "tab_1_1",
              br(),
              br(),
              br(),
              br(),
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>ESTADÍSTICA UNIVARIADA</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
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
                        choices = df_PD$Dimensión %>% 
                          droplevels(exclude=c("Masoterápea")) %>% 
                          levels(),
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
                # column(
                #   width = 1
                # ),
                boxPlus(
                  width = 4, 
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
                # column(
                #   width = 1
                # ),
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
                ####  TABLE_1.1.0  #### 
                boxPlus(
                  width = 8,
                  title = "Tabla de Z-Score", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab1.1.0"),
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
                      inputId = "Table_tab1.1.0_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab1.1.0.xlsx", ".xlsx"), 
                    downloadButton("download_Table_tab1.1.0.csv", ".csv") 
                  )
                )
              ),
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
                    downloadButton("download_Table_tab1.1_outliers.xlsx", ".xlsx")
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
                ####  TABLE_1.1.1  #### 
                boxPlus(
                  width = 12,
                  title = "Tabla de Estadística Descriptiva General", 
                  status = "primary", 
                  solidHeader = TRUE,
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
              br()
      ),
      #### ----------------------------------- TAB_1_2 ----------------------------------- #### 
      tabItem(tabName = "tab_1_2",
              br(),
              br(),
              br(),
              br(),
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>ESTADÍSTICA MULTIVARIADA</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
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
                        choices = levels(df_PD$Dimensión %>% 
                                           droplevels(exclude=c("Masoterápea"))) ,
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
                # column(
                #   width = 1
                # ),
                boxPlus(
                  width = 4, 
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
                # column(
                #   width = 1
                # ),
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
      #### ----------------------------------- TAB_2 ----------------------------------- #### 
      tabItem(tabName = "tab_2",
              br(),
              br(),
              br(),
              br(),
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>EVENTO CLÍNICO</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              ####  VB_2  ####
              fluidRow(
                column(
                  width = 1
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab2.0.1"
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab2.0.2"
                ),
                valueBoxOutput(
                  width = 4,
                  "valuebox_tab2.0.3"
                ),
                column(
                  width = 1
                ),
              ),
              br(),
              fluidRow(
                ####  TAB_2.0  #### 
                boxPlus(
                  width = 12, 
                  title = "Diagrama Temporal de Frequencia de Enfermedades, Lesiones y Molestias",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab2.0", height="360px"),
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
                      inputId = "Plot_tab2.0_HELP",
                      label = "",
                      icon = icon("question-circle")
                    )
                  ),
                  footer = fluidRow(
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.0_Footer_A")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.0_Footer_B")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.0_Footer_C")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.0_Footer_D")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.0_Footer_E")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.0_Footer_F")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.0_Footer_G")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab2.0_Footer_H")
                    )
                  )
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
                    DT::dataTableOutput("Table_tab2.0", height="260px"),
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
                      choices = c("Partido","Entrenamiento","Total"),
                      selected = c("Total"),
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
                      width = 4,
                      uiOutput("Plot_tab2.1_Footer_A")
                    ),
                    column(
                      width = 4,
                      uiOutput("Plot_tab2.1_Footer_B")
                    ),
                    column(
                      width = 4,
                      uiOutput("Plot_tab2.1_Footer_C")
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                boxPlus(
                  width = 12, 
                  title = "Diagrama de Barras Múltiples",
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    tabsetPanel(
                      ####  TAB_2.1  #### 
                      tabPanel(
                        "General",
                        withSpinner(
                          plotlyOutput("Plot_tab2.1", height="500px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TAB_2.2  #### 
                      tabPanel(
                        "Semanal",
                        withSpinner(
                          plotlyOutput("Plot_tab2.1.2", height = "500px")  ,
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      )
                    )
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
                      label = 'Variable Eje Y:',
                      data = df.S.1,
                      multiple = FALSE,
                      selectize = TRUE,
                      selected="Categoría_I"
                    ),
                    varSelectInput(
                      inputId = 'cInput_tab1.3',
                      label = 'Variable Color:',
                      data = df.S.1 %>% select(!c(Disponibilidad,Diagnóstico,Instancia)),
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
              br(),
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>GESTIÓN MÉDICA</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              fluidRow(
                ####  TAB_3.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Diagrama Temporal de Frequencia de Eventos, Acciones, Tratamientos y Masajes",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab3.1", height="460px"),
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
              br(),
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
                    actionButton(
                      inputId = "Table_tab3.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
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
              br(),
              fluidRow(
                boxPlus(
                  width = 8, 
                  title = "Frecuencia de Acciones Terapéuticas y Tratamientos Kinésicos",
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    tabsetPanel(
                      ####  TAB_3.2.1  #### 
                      tabPanel(
                        "Total Acciones",
                        withSpinner(
                          plotlyOutput("Plot_tab3.2.1", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TAB_3.2.2  #### 
                      tabPanel(
                        "Semanal Acciones",
                        withSpinner(
                          plotlyOutput("Plot_tab3.2.2", height = "520px")  ,
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TAB_3.2.3  #### 
                      tabPanel(
                        "Total Tratamientos",
                        withSpinner(
                          plotlyOutput("Plot_tab3.2.3", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TAB_3.2.4  #### 
                      tabPanel(
                        "Semanal Tratamientos",
                        withSpinner(
                          plotlyOutput("Plot_tab3.2.4", height = "520px")  ,
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      )
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE
                ),
                ####  TABLE_3.3.1 #### 
                boxPlus(
                  width = 4,
                  title = "Acciones", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab3.3.1"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_tab3.3.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab3.3.1.csv", ".csv")
                  )
                ),
                ####  TABLE_3.3.2 #### 
                boxPlus(
                  width = 4,
                  title = "Tratamientos", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab3.3.2"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_tab3.3.2.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab3.3.2.csv", ".csv")
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
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>TIME LOSS</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              ####  VB_4  ####
              fluidRow(
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab4.1"
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab4.2"
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab4.3"
                ),
                valueBoxOutput(
                  width = 3,
                  "valuebox_tab4.4"
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
              br(),
              fluidRow(
                ####  TABLE_4.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Tabla de Lesión Time Loss", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab4.1", height="300px"),
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
                  ),
                  enable_sidebar = TRUE,
                  sidebar_width = 25,
                  sidebar_background = "#0A0A0AAD",
                  sidebar_start_open = TRUE,
                  sidebar_icon = "sliders-h",
                  sidebar_content = tagList(
                    br(),
                    materialSwitch(
                      inputId = "TimeLoss_Injuries", 
                      label = strong("ver Molestias"),
                      status = "success",
                      right = TRUE
                    ),
                    hr(),
                    materialSwitch(
                      inputId = "TimeLoss_Diseases", 
                      label = strong("ver Enfermedades"),
                      status = "success",
                      right = TRUE
                    ),
                    hr(),
                    materialSwitch(
                      inputId = "TimeLoss_0", 
                      label = strong("ver datos Sin Ausencia"),
                      status = "success",
                      right = TRUE
                    )
                  )
                )
              ),
              br()
              
      ),
      #### ----------------------------------- TAB_5 ----------------------------------- #### 
      tabItem(tabName = "tab_5",
              br(),
              br(),
              br(),
              br(),
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>AUTOREPORTE</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_5.0.1  #### 
                boxPlus(
                  width = 12,
                  title = "Tabla General de Autoreporte", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab5.0.1"),
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
                      inputId = "Table_tab5.0.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab5.0.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab5.0.1.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TAB_5.0  #### 
                boxPlus(
                  width = 8, 
                  title = "Total Wellness y Carga Interna Diaria por Jugador",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab5.0", height="350px"),
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
                      inputId = "Plot_tab5.0_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab5.0_HELP",
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
                    uiOutput("playerOption_tab5")
                  )
                ),
                ####  TABLE_5.0  #### 
                boxPlus(
                  width = 4,
                  title = "", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab5.0"),
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
                      inputId = "Table_tab5.0_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab5.0.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab5.0.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TAB_5.1  #### 
                boxPlus(
                  width = 8, 
                  title = "Total Wellness y Carga Interna del Plantel por Fecha",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab5.1", height="420px"),
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
                      inputId = "Plot_tab5.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab5.1_HELP",
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
                    uiOutput("dateOption_tab5")
                  )
                ),
                ####  TABLE_5.1  #### 
                boxPlus(
                  width = 4,
                  title = "", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab5.1"),
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
                      inputId = "Table_tab5.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab5.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab5.1.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TAB_5.2  ####
                boxPlus(
                  width = 8,
                  title = "Percepción de Esfuerzo por Semana",
                  status = "primary",
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab5.2", height="350px"),
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
                      inputId = "Plot_tab5.2_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    actionButton(
                      inputId = "Input_tab5.2_HELP",
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
                    pickerInput(
                      inputId = 'dateInput_tab5.2',
                      label = 'Año:',
                      multiple = FALSE,
                      choices = data_years,
                      selected = max(data_years),
                      options = list(`actions-box`=TRUE)
                    )
                  )
                ),
                ####  TABLE_5.2  ####
                boxPlus(
                  width = 4,
                  title = "",
                  status = "primary",
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab5.2"),
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
                      inputId = "Table_tab5.2_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab5.2.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab5.2.csv", ".csv")
                  )
                )
              ),
              br(),
              br(),
              # fluidRow(
              #   column(
              #     width = 3
              #   ),
              #   column(
              #     width = 6,
              #     align = "center",
              #     box(
              #       width = 12,
              #       solidHeader = TRUE,
              #       status = "success",
              #       HTML("<h4><center><b>HISTÓRICO LESIONES SEGÚN ACWR</b></h4>")
              #     )
              #   ),
              #   column(
              #     width = 3
              #   )
              # ),
              # fluidRow(
              #   ####  TAB_5.3  ####
              #   boxPlus(
              #     width = 9,
              #     title = "Gráfica de Lesiones por Contacto Indirecto según ACWR",
              #     status = "primary",
              #     solidHeader = TRUE,
              #     withSpinner(
              #       plotlyOutput("Plot_tab5.3", height="450px"),
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
              #         inputId = "Plot_tab5.3_HELP",
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
              #     ####  TABLE_5.3  ####
              #     withSpinner(
              #       DT::dataTableOutput("Table_tab5.3"),
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
              #         inputId = "Table_tab5.3_HELP",
              #         label = "",
              #         icon = icon("question-circle")
              #       ),
              #       downloadButton("download_Table_tab5.3.xlsx", ".xlsx"),
              #       downloadButton("download_Table_tab5.3.csv", ".csv")
              #     )
              #   )
              # ),
              br()
      ),
      #### ----------------------------------- TAB_6 ----------------------------------- #### 
      tabItem(tabName = "tab_6",
              br(),
              br(),
              br(),
              br(),
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>NUTRICIÓN</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              fluidRow(
                ####  TAB_6.1  #### 
                boxPlus(
                  width = 6, 
                  title = "Porcentaje Masa Grasa",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab6.1", height="280px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = FALSE
                ),
                ####  TAB_6.2  #### 
                boxPlus(
                  width = 6, 
                  title = "Porcentaje Masa Muscular",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab6.2", height="280px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = FALSE
                )
              ),
              fluidRow(
                ####  TAB_6.3  #### 
                boxPlus(
                  width = 6, 
                  title = "Sumatoria 6 Pliegues",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab6.3", height="280px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = FALSE
                ),
                ####  TAB_6.4  #### 
                boxPlus(
                  width = 6, 
                  title = "Peso Actual",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab6.4", height="280px"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = FALSE
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_6.0  ####
                boxPlus(
                  width = 12,
                  title = "Tabla de Nutrición según Posición",
                  status = "primary",
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab6.0"),
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
                      inputId = "Table_tab6.0_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab6.0.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab6.0.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TAB_6.5  #### 
                boxPlus(
                  width = 12, 
                  title = "Comparativa Mensual de Variables por Jugador",
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    plotlyOutput("Plot_tab6.5", height="450px"),
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
                      inputId = "Plot_tab6.5_HELP",
                      label = "",
                      icon = icon("question-circle")
                    )
                    # ,
                    # actionButton(
                    #   inputId = "Input_tab2.2_HELP",
                    #   label = "",
                    #   icon = icon("file-alt")
                    # )
                  ),
                  enable_sidebar = TRUE,
                  sidebar_width = 25,
                  sidebar_background = "#0A0A0AAD",
                  sidebar_start_open = TRUE,
                  sidebar_icon = "sliders-h",
                  sidebar_content = tagList(
                    br(),
                    materialSwitch(
                      inputId = "Mean_Zscore", 
                      label = strong("Promedio/Zscore"),
                      status = "primary",
                      right = TRUE
                    ),
                    uiOutput("uiTab6.1"),
                    uiOutput("uiTab6.2"),
                    uiOutput("uiTab6.3")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_6.1  ####
                boxPlus(
                  width = 12,
                  title = "Tabla Estadística de Nutrición",
                  status = "primary",
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_tab6.1"),
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
                      inputId = "Table_tab6.1_HELP",
                      label = "",
                      icon = icon("question-circle")
                    ),
                    downloadButton("download_Table_tab6.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab6.1.csv", ".csv")
                  )
                )
              ),
              br()
      ),
      #### ----------------------------------- TAB_7 ----------------------------------- #### 
      tabItem(tabName = "tab_7",
              br(),
              br(),
              br(),
              br(),
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>BIOMECÁNICA</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_7.1  #### 
                boxPlus(
                  width = 12, 
                  title = "Último valor de Biomecánica por Jugador",
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    tabsetPanel(
                      ####  TABLE_7.1.1  #### 
                      tabPanel(
                        "Plataforma Fuerza",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.1.1", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.1.2  #### 
                      tabPanel(
                        "Miotone",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.1.2", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.1.3  #### 
                      tabPanel(
                        "Nórdicos Isquio.",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.1.3", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.1.4  #### 
                      tabPanel(
                        "Índice Postural",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.1.4", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.1.5  #### 
                      tabPanel(
                        "Fuerza Isom.",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.1.5", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.1.6  #### 
                      tabPanel(
                        "Isocinética",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.1.6", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.1.7  #### 
                      tabPanel(
                        "Core Plank",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.1.7", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.1.8  #### 
                      tabPanel(
                        "Consumo Oxigeno",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.1.8", height="520px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      )
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    # actionButton(
                    #   inputId = "Table_tab7.1_HELP",
                    #   label = "",
                    #   icon = icon("question-circle")
                    # ),
                    downloadButton("download_Table_tab7.1.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab7.1.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                boxPlus(
                  width = 12, 
                  title = "Frequencia Biomecánica por Jugador y Dimensión",
                  status = "primary", 
                  solidHeader = TRUE,
                  tabsetPanel(
                    ####  TAB_7.1  #### 
                    tabPanel(
                      "Diagrama",
                      withSpinner(
                        plotlyOutput("Plot_tab7.1", height="450px"),
                        type = 6,
                        color = "#0D9AE0DA",
                        size = 0.7
                      )
                    ),
                    ####  TABLE_7.3  #### 
                    tabPanel(
                      "Tabla",
                      withSpinner(
                        DT::dataTableOutput("Table_tab7.3", height="450px"),
                        type = 6,
                        color = "#0D9AE0DA",
                        size = 0.7
                      )
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    # actionButton(
                    #   inputId = "Plot_tab7.1_HELP",
                    #   label = "",
                    #   icon = icon("question-circle")
                    # ),
                    downloadButton("download_Table_tab7.3.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab7.3.csv", ".csv")
                  ),
                  footer = fluidRow(
                    column(
                      width = 3,
                      uiOutput("Plot_tab7.1_Footer_A")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab7.1_Footer_B")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab7.1_Footer_C")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab7.1_Footer_D")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab7.1_Footer_E")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab7.1_Footer_F")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab7.1_Footer_G")
                    ),
                    column(
                      width = 3,
                      uiOutput("Plot_tab7.1_Footer_H")
                    )
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_7.2  #### 
                boxPlus(
                  width = 12, 
                  title = "Valor Plantel Promedio de Biomecánica por Posición",
                  status = "primary", 
                  solidHeader = TRUE,
                  column(
                    width = 12,
                    tabsetPanel(
                      ####  TABLE_7.2.1  #### 
                      tabPanel(
                        "Plataforma Fuerza",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.2.1", height="420px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.2.2  #### 
                      tabPanel(
                        "Miotone",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.2.2", height="420px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.2.3  #### 
                      tabPanel(
                        "Nórdicos Isquio.",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.2.3", height="420px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.2.4  #### 
                      tabPanel(
                        "Índice Postural",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.2.4", height="420px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.2.5  #### 
                      tabPanel(
                        "Fuerza Isom.",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.2.5", height="420px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.2.6  #### 
                      tabPanel(
                        "Isocinética",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.2.6", height="420px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.2.7  #### 
                      tabPanel(
                        "Core Plank",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.2.7", height="420px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      ),
                      ####  TABLE_7.2.8  #### 
                      tabPanel(
                        "Consumo Oxigeno",
                        withSpinner(
                          DT::dataTableOutput("Table_tab7.2.8", height="420px"),
                          type = 6,
                          color = "#0D9AE0DA",
                          size = 0.7
                        )
                      )
                    )
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = TRUE,
                  dropdown_menu = list(
                    # actionButton(
                    #   inputId = "Table_tab7.2_HELP",
                    #   label = "",
                    #   icon = icon("question-circle")
                    # ),
                    downloadButton("download_Table_tab7.2.xlsx", ".xlsx"),
                    downloadButton("download_Table_tab7.2.csv", ".csv")
                  )
                )
              ),
              br()
      ),
      #### ----------------------------------- TAB_API ----------------------------------- #### 
      tabItem(tabName = "tab_API",
              br(),
              br(),
              br(),
              br(),
              ####  TITLE  ####
              fluidRow(
                column(
                  width = 4
                ),
                column(
                  width = 4,
                  align = "center",
                  box(
                    width = 12,
                    solidHeader = TRUE,
                    status = "success",
                    HTML("<h4><center><b>BASE DE DATOS</b></h4>"),
                  )
                ),
                column(
                  width = 4
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_API_1  #### 
                boxPlus(
                  width = 12,
                  title = "Tabla General Dimensiones del Jugador", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_API_1"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_API_1.xlsx", ".xlsx"),
                    downloadButton("download_Table_API_1.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_API_2  #### 
                boxPlus(
                  width = 12,
                  title = "Tabla General Condición de Disponibilidad", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_API_2"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_API_2.xlsx", ".xlsx"),
                    downloadButton("download_Table_API_2.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_API_3  #### 
                boxPlus(
                  width = 12,
                  title = "Tabla General Evento Clínico y Diagnóstico", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_API_3"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_API_3.xlsx", ".xlsx"),
                    downloadButton("download_Table_API_3.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_API_4  #### 
                boxPlus(
                  width = 12,
                  title = "Tabla General Tratamiento Kinésico", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_API_4"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_API_4.xlsx", ".xlsx"),
                    downloadButton("download_Table_API_4.csv", ".csv")
                  )
                )
              ),
              br(),
              fluidRow(
                ####  TABLE_API_5  #### 
                boxPlus(
                  width = 12,
                  title = "Tabla General Medicina", 
                  status = "primary", 
                  solidHeader = TRUE,
                  withSpinner(
                    DT::dataTableOutput("Table_API_5"),
                    type = 6,
                    color = "#0D9AE0DA",
                    size = 0.7
                  ),
                  collapsible = TRUE,
                  closable = FALSE,
                  enable_dropdown = TRUE,
                  dropdown_icon = FALSE,
                  dropdown_menu = list(
                    downloadButton("download_Table_API_5.xlsx", ".xlsx"),
                    downloadButton("download_Table_API_5.csv", ".csv")
                  )
                )
              ),
              br()
      ),
      #### ----------------------------------- TAB_RELOAD_REPORT ----------------------------------- #### 
      tabItem(tabName = "tab_RELOAD_REPORT",
              br(),
              br(),
              br(),
              br(),
              fluidRow(
                ####  REPORT  #### 
                column(
                  width = 6,
                  fluidRow(
                    column(
                      width = 1
                    ),
                    column(
                      width = 10,
                      align = "center",
                      box(
                        width = 12,
                        solidHeader = TRUE,
                        status = "success",
                        HTML("<h4><center><b>GENERACIÓN DE REPORTES</b></h4>"),
                      )
                    ),
                    column(
                      width = 1
                    )
                  ),
                  br(),
                  br(),
                  fluidRow(
                    box(
                      width = 12, 
                      solidHeader = TRUE,
                      title = " ",
                      status = "primary",
                      column(
                        width = 12,
                        column(
                          width = 12,
                          br(),
                          column(
                            width = 12,
                            conditionalPanel(
                              condition = "input.Player == true",
                              br(),
                              materialSwitch(
                                inputId = "conditionReport", 
                                label = strong("Especificar Condiciones del Jugador"),
                                status = "primary",
                                right = TRUE
                              )
                            )
                          ),
                          column(
                            width = 12,
                            conditionalPanel(
                              condition = "input.conditionReport == true",
                              br(),
                              uiOutput("initialCondition")
                            ),
                            conditionalPanel(
                              condition = "input.conditionReport == true",
                              uiOutput("finalCondition")
                            )
                          ),
                          column(
                            width = 12,
                            column(
                              width = 6,
                              conditionalPanel(
                                condition = "input.conditionReport == true",
                                uiOutput("entryDate")
                              )
                            ),
                            column(
                              width = 6,
                              conditionalPanel(
                                condition = "input.conditionReport == true",
                                uiOutput("leaveDate")
                              ),
                            )
                          ),
                          column(
                            width = 12,
                            br(),
                            strong(
                              "Escriba el correo al cual desea enviar el Link para la descarga del Reporte:"
                            ),
                            br(),
                            br(),
                            textInput(
                              width = "300px",
                              label = NULL, 
                              inputId = "ReportEmailInput",
                              value = "email@gmail.com"
                            ),
                            br(),
                            actionButton(
                              inputId = "generate_report",
                              label = strong("Generar Reporte"),
                              style = "color: white;  
                                       padding:14px; 
                                       background: linear-gradient(60deg, #142c59, #00C0EF);",
                              icon = icon("paper-plane")
                            ),
                            br(),
                            br(),
                            br()
                          ),
                          br(),
                          br(),
                          br()
                        )
                      )
                    )
                  )
                ),
                ####  RELOAD  #### 
                column(
                  width = 6,
                  fluidRow(
                    column(
                      width = 1
                    ),
                    column(
                      width = 10,
                      align = "center",
                      box(
                        width = 12,
                        solidHeader = TRUE,
                        status = "success",
                        HTML("<h4><center><b>ACTUALIZACIÓN DE DATOS</b></h4>"),
                      )
                    ),
                    column(
                      width = 1
                    )
                  ),
                  br(),
                  br(),
                  fluidRow(
                    box(
                      width = 12, 
                      solidHeader = TRUE,
                      title = " ",
                      status = "primary",
                      column(
                        width = 12,
                        column(
                          width = 12,
                          br(),
                          br(),
                          strong("Selecciones la fecha de inicio para la recarga de datos:"),
                          br(),
                          br(),
                          dateInput(
                            width = "100px",
                            inputId = "timeReloadFromInput", 
                            label = NULL,
                            value = (Sys.Date() - 30),
                            min = NULL,
                            max = NULL,
                            startview = "month",
                            language = "es"
                          ),
                          br(), # hr(), # style = "border-top: 0.5px solid #142c59;"
                          actionButton(
                            inputId = "update",
                            label = strong("Recargar Datos"),
                            style = "color: white;  
                                     padding:14px; 
                                     background: linear-gradient(60deg, #142c59, #00C0EF);",
                            icon = icon("sync-alt")
                          ),
                          br(),
                          br(),
                          br()
                        )
                      )
                    )
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
  
  ####  LOGIN  ####
  ## ?benutzer=66  |  ?benutzer=402
  url_search <- reactive({
    parseQueryString(session$clientData$url_search)
  })
  url_ID_User <- reactive({
    if (!is.null(url_search())) {
      url_search()[[
        'benutzer'
      ]] %>% 
        as.character()
    } 
  })
  userCategoriesLogin <- reactive({
    if (!is.null(url_search())) {
      df_USER %>%
        filter(ID_Usuario %in% url_ID_User()) %>%
        pull(Categoría) %>%
        as.vector() %>% 
        as.factor()
    } else {
      levels(df_PD$Categoría)
    }
  })
  userEmail <- reactive({
    df_USER %>%
      filter(ID_Usuario %in% url_ID_User()) %>%
      pull(Email)
  })
  
  ####  GENERAL UI  ####
  output$categoryOption <- renderUI({
    selectInput(
      width = "210px",
      inputId = 'CategoryInput', 
      label = NULL,
      choices = levels(df_PD$Categoría), # userCategoriesLogin()
      selected = 1 # levels(df_PD$Categoría)[1]
    )
  })
  levelsPlayers <- reactive({
    df_PD %>% 
      filter(Categoría %in% input$CategoryInput) %>%
      select(Jugador) %>%
      unique() %>% 
      drop_na() %>%
      t()
  })
  output$playerOption <- renderUI({
    if (input$Player) {
      selectInput(
        width = "210px",
        inputId = 'PlayerInput', 
        label = "Seleccione el Jugador:",
        choices = levelsPlayers()
      )
    } 
  })
  
  ####  GENERAL DF  ####
  
  ## Player Dimension Numeric
  df_PD_fil <- reactive({
    if (input$Player) {
      df_PD %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDimensión >= input$timeFromInput,
               FechaDimensión <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_PD %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDimensión >= input$timeFromInput,
               FechaDimensión <= input$timeToInput)
    }
  })
  df_PD_CAT_T <- reactive({
    df_PD %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaDimensión >= input$timeFromInput,
             FechaDimensión <= input$timeToInput)
  })
  df_PD_CAT <- reactive({
    df_PD %>% 
      filter(Categoría %in% input$CategoryInput)
  })
  
  ## Player Dimension Factor
  df_PD_F_fil <- reactive({
    if (input$Player) {
      df_PD_F %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDimensión >= input$timeFromInput,
               FechaDimensión <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_PD_F %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDimensión >= input$timeFromInput,
               FechaDimensión <= input$timeToInput)
    }
  })
  df_PD_F_C <- reactive({
    df_PD_F %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaDimensión >= input$timeFromInput,
             FechaDimensión <= input$timeToInput)
  })
  
  ## Clinical Event
  df_CED_fil <- reactive({
    if (input$Player) {
      if (input$ExternalData) {
        df_CED %>% 
          filter(Categoría %in% input$CategoryInput,
                 FechaDiagnóstico >= input$timeFromInput,
                 FechaDiagnóstico <= input$timeToInput,
                 Jugador %in% input$PlayerInput)
      } else {
        df_CED %>% 
          filter(Categoría %in% input$CategoryInput,
                 !Instancia %in% "Evento clínico externo (Selección/Club)",
                 FechaDiagnóstico >= input$timeFromInput,
                 FechaDiagnóstico <= input$timeToInput,
                 Jugador %in% input$PlayerInput)
      }
    } else {
      if (input$ExternalData) {
        df_CED %>% 
          filter(Categoría %in% input$CategoryInput,
                 FechaDiagnóstico >= input$timeFromInput,
                 FechaDiagnóstico <= input$timeToInput)
      } else {
        df_CED %>% 
          filter(Categoría %in% input$CategoryInput,
                 !Instancia %in% "Evento clínico externo (Selección/Club)",
                 FechaDiagnóstico >= input$timeFromInput,
                 FechaDiagnóstico <= input$timeToInput)
      }
    }
  })
  df_CED_TE_fil <- reactive({
    if (input$Player) {
      if (input$ExternalData) {
        df_CED_TE %>% 
          filter(Categoría %in% input$CategoryInput,
                 FechaDiagnóstico >= input$timeFromInput,
                 FechaDiagnóstico <= input$timeToInput,
                 Jugador %in% input$PlayerInput) %>%
          select(!Instancia)
      } else {
        df_CED_TE %>% 
          filter(Categoría %in% input$CategoryInput,
                 !Instancia %in% "Evento clínico externo (Selección/Club)",
                 FechaDiagnóstico >= input$timeFromInput,
                 FechaDiagnóstico <= input$timeToInput,
                 Jugador %in% input$PlayerInput) %>%
          select(!Instancia)
      }
    } else {
      if (input$ExternalData) {
        df_CED_TE %>% 
          filter(Categoría %in% input$CategoryInput,
                 FechaDiagnóstico >= input$timeFromInput,
                 FechaDiagnóstico <= input$timeToInput) %>%
          select(!Instancia)
      } else {
        df_CED_TE %>% 
          filter(Categoría %in% input$CategoryInput,
                 !Instancia %in% "Evento clínico externo (Selección/Club)",
                 FechaDiagnóstico >= input$timeFromInput,
                 FechaDiagnóstico <= input$timeToInput) %>%
          select(!Instancia)
      }
    }
  })
  df_CED_C <- reactive({
    if (input$ExternalData) {
      df_CED %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDiagnóstico >= input$timeFromInput,
               FechaDiagnóstico <= input$timeToInput)
    } else {
      df_CED %>% 
        filter(Categoría %in% input$CategoryInput,
               !Instancia %in% "Evento clínico externo (Selección/Club)",
               FechaDiagnóstico >= input$timeFromInput,
               FechaDiagnóstico <= input$timeToInput)
    }
  })
  
  ## Kinesic Tratement
  df_KT_fil <- reactive({
    if (input$Player) {
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
  df_KT_C <- reactive({
    df_KT %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaTratamientoKinésico >= input$timeFromInput,
             FechaTratamientoKinésico <= input$timeToInput)
  })
  
  ## Kinesic Tratement
  df_KA_fil <- reactive({
    if (input$Player) {
      df_KA %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaAcciónTerapéutica >= input$timeFromInput,
               FechaAcciónTerapéutica <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_KA %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaAcciónTerapéutica >= input$timeFromInput,
               FechaAcciónTerapéutica <= input$timeToInput)
    }
  })
  df_KA_C <- reactive({
    df_KA %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaAcciónTerapéutica >= input$timeFromInput,
             FechaAcciónTerapéutica <= input$timeToInput)
  })
  
  ## Time Loss
  df_TL_fil <- reactive({
    if (input$Player) {
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
  df_TL_C <- reactive({
    df_TL %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaTérmino_TimeLoss >= input$timeFromInput,
             FechaTérmino_TimeLoss <= input$timeToInput)
  })
  
  ## Availability Condition
  df_AC_fil <- reactive({
    if (input$Player) {
      df_AC %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaCondición >= input$timeFromInput,
               FechaCondición <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_AC %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaCondición >= input$timeFromInput,
               FechaCondición <= input$timeToInput)
    }
  })
  df_AC_C <- reactive({
    df_AC %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaCondición >= input$timeFromInput,
             FechaCondición <= input$timeToInput)
  })
  
  ## Availability Condition
  df_MED_fil <- reactive({
    if (input$Player) {
      df_MED %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDiagnóstico >= input$timeFromInput,
               FechaDiagnóstico <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_MED %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDiagnóstico >= input$timeFromInput,
               FechaDiagnóstico <= input$timeToInput)
    }
  })
  df_MED_C <- reactive({
    df_MED %>% 
      filter(Categoría %in% input$CategoryInput,
             FechaDiagnóstico >= input$timeFromInput,
             FechaDiagnóstico <= input$timeToInput)
  })
  df_EO_fil <- reactive({
    if (input$Player) {
      df_EO %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDiagnóstico >= input$timeFromInput,
               FechaDiagnóstico <= input$timeToInput,
               Jugador %in% input$PlayerInput)
    } else {
      df_EO %>% 
        filter(Categoría %in% input$CategoryInput,
               FechaDiagnóstico >= input$timeFromInput,
               FechaDiagnóstico <= input$timeToInput)
    }
  })
  
  ## Minutos de exposición
  Min_Exp.DF <- reactive({
    if (input$mInput_tab2.0 %in% "Total") {
      df_PD_fil() %>% 
        filter(
          Medición %in% "Minutos de exposición"
        ) %>%
        select(ValorMedición) 
    } else {
      df_PD_fil() %>% 
        filter(
          TipoMedición %in% input$mInput_tab2.0,
          Medición %in% "Minutos de exposición"
        ) %>%
        select(ValorMedición) 
    }
  })
  Min_Exp <- reactive({
    if (nrow(Min_Exp.DF()) == 0) {
      0
    } else {
      Min_Exp.DF() %>% sum()
    }
  })
  
  ## Games and Trainings
  df_G_T <- reactive({
    df_PD_fil() %>% 
      mutate(
        TipoMedición = case_when(
          stringr::str_detect(tolower(TipoMedición), 
                              "entrenamiento") ~ "Entrenamiento",
          stringr::str_detect(tolower(TipoMedición), 
                              "partido") ~ "Partido",
        ) %>% as.factor()
      ) %>%
      drop_na() %>% 
      select(TipoMedición,
             Fecha=FechaDimensión) %>%
      unique()
  })
  
  ## Biomechanics
  df_BM_CAT<- reactive({
    df_BM %>% 
      filter(Categoría %in% input$CategoryInput)
  })
  
  #### --------------------------- TAB_1_1 --------------------------- #### 
  
  ####  UI  ####
  levelsTypeMeters_tab1.1 <- reactive({
    df_PD_CAT_T()%>% 
      filter(
        Dimensión %in% input$DimInput_tab1.1
      ) %>% 
      drop_na() %>%
      pull(TipoMedición) %>%
      unique() 
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
    df_PD_CAT_T()%>% 
      filter(
        Dimensión %in% input$DimInput_tab1.1,
        TipoMedición %in% input$TypeMetInput_tap1.1
      ) %>% 
      drop_na() %>%
      pull(Medición) %>%
      unique() 
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
    df_PD_fil() %>% 
      filter(Dimensión %in% input$DimInput_tab1.1,
             TipoMedición %in% input$TypeMetInput_tap1.1,
             Medición %in% input$MetInput_tab1.1)
  })
  filtered_tab1.1.2 <- reactive({
    df_PD_fil() %>% 
      filter(Dimensión %in% input$DimInput_tab1.1,
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
      ifelse(
        nrow(Stat.DF_tab1.1.1()) < 1, 
        'Indf',
        Stat.DF_tab1.1.1() %>% 
          filter(Medición %in% input$MetInput_tab1.1) %>%
          select(Promedio) %>%
          round(0) %>%
          slice(1)
      ),
      "Promedio", 
      icon = icon("divide"),
      color = "aqua"
    )
  })
  output$valuebox_tab1.1.2 <- renderValueBox({
    valueBox(
      ifelse(
        nrow(Stat.DF_tab1.1.1()) < 3, 
        'Indf',
        Stat.DF_tab1.1.1() %>% 
          filter(Medición %in% input$MetInput_tab1.1) %>%
          select(Desviación) %>%
          round(1) %>%
          slice(1)
      ),
      "Desviación Estándar", 
      icon = icon("sort-amount-down"),
      color = "aqua"
    )
  })
  
  ####  TABLE_1.1.0  #### 
  Table_tab1.1.0 <- reactive({
    filtered_tab1.1() %>%
      mutate(
        Medición = input$MetInput_tab1.1,
        Zscore = ( 
          (ValorMedición - mean(ValorMedición)) / sd(ValorMedición) 
        ) %>% round(2)
      ) %>%
      select(
        Jugador,
        Fecha = FechaDimensión,
        Medición,
        Valor = ValorMedición,
        Zscore
      ) %>%
      arrange(desc(Fecha))
  })
  output$Table_tab1.1.0 <- DT::renderDataTable({
    DT::datatable(
      Table_tab1.1.0(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",    
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "300px", 
        paging=FALSE, info=FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) %>%
      formatStyle(
        'Valor',
        background = styleColorBar(Table_tab1.1.0()$Valor, 'lightblue'),
        backgroundSize = '100%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      formatStyle(
        'Zscore', 
        fontWeight = styleInterval(1.99, c('bold','normal')),
        color = styleInterval(1.99, c('black', 'white'))
      ) %>%
      formatStyle(
        'Zscore', 
        fontWeight = styleInterval(-1.99, c('bold','normal')),
        color = styleInterval(-1.99, c('white', 'black'))
      ) %>% 
      formatStyle(
        'Zscore', #fontWeight = 'bold',
        backgroundColor = styleInterval(1.99, c('white', 'red'))
      ) %>% 
      formatStyle(
        'Zscore', #fontWeight = 'bold',
        backgroundColor = styleInterval(-1.99, c('red', 'white'))
      ) 
  })
  output$download_Table_tab1.1.0.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
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
      write.xlsx(Table_tab1.1.0(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab1.1.0.csv <- downloadHandler(
    filename = function() {
      if (input$Player) {
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
      write.csv(Table_tab1.1.0(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab1.1.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_1/Table_tab1.1.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer =  actionButton(
          inputId = "Table_tab1.1.0_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab1.1.0_Modal,{
    removeModal()
  })
  
  ####  TAB_1.1.1 #### 
  output$Plot_tab1.1.1 <- renderPlotly({
    
    # Visualization
    if ( filtered_tab1.1() %>% nrow() < 3 ) { 
      
      emptyChart(
        paste(
          "No se registran <br> suficientes datos <br>",
          "<b>de esta Variable</b> <br>",
          "para generar <br> la Visualización"
        )
      )
      
    } else {
      
      # Creating Object
      Xvar <- select(filtered_tab1.1(), 'Xvar'=ValorMedición)
      summarise <- data.frame(Prom = mean(Xvar$Xvar) %>% round(1), 
                              Desv. = sd(Xvar$Xvar) %>% round(1),
                              Var = 0, 
                              color = 0)
      for (i in seq(1, nrow(summarise), by=1)) {
        summarise$color[i] <- 
          if ( summarise$Prom[i] > 2*summarise$Desv.[i] ) { "black" } else { "red" } 
      }
      
      # Visualization
      ggplotly(
        ggplot(summarise) +
          geom_bar(
            aes(x = Var, y = Prom), 
            stat = "identity", 
            color="black",
            size=.3,
            fill = "#30E01D",
            alpha = .7
          ) +
          geom_errorbar(
            aes(x = Var, ymin = Prom-Desv., ymax = Prom+Desv.), 
            width = 0.1, 
            alpha = 0.9, 
            size = .6,
            colour = ifelse(summarise$color=="black", "black", "red")
          ) +
          labs(x=NULL, y=NULL, fill=NULL) +
          theme(
            panel.grid.major.x = element_blank(),
            axis.text.x = element_blank(),
            panel.grid.major=element_line(colour="#00000018"),
            panel.grid.minor=element_line(colour="#00000018"),
            panel.background=element_rect(fill="transparent",colour=NA)
          ),
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
              if (input$Player) {
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
            scale = 3
          )
        )
      
    }
  }) 
  SD_tab1.1 <- reactive({
    df <-
      Stat.DF_tab1.1.1() %>%
      filter(Medición %in% input$MetInput_tab1.1) %>%
      select(Promedio,Desviación)
    df$Promedio <- 
      ifelse(df$Promedio > 100,df$Promedio %>% round(0),df$Promedio %>% round(1))
    df$Desviación <- 
      ifelse(df$Desviación > 100,df$Desviación %>% round(0),df$Desviación %>% round(1))
    paste0("[ ", df$Promedio-df$Desviación , " - " , df$Promedio+df$Desviación, " ]")
  })
  SD_tab1.1_color <- reactive({
    Stat.DF_tab1.1.1() %>%
      filter(Medición %in% input$MetInput_tab1.1) %>%
      select(Promedio,Desviación)
  })
  output$Plot_tab1.1.1_Footer <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "less-than-equal",
      numberColor = ifelse(
        SD_tab1.1_color()$Promedio > 2*SD_tab1.1_color()$Desviación,
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
    
    # Visualization
    if ( filtered_tab1.1() %>% nrow() < 3 ) { 
      
      emptyChart(
        emptyMessage('esta Variable')      
      )
      
    } else {
      
      # Creating Object
      filtered <- filtered_tab1.1()
      
      # Visualization
      if (
        
        input$MetInput_tab1.1 %in% c("Nivel de energía",
                                     "Humor / Estado de ánimo",
                                     "Estado general muscular",
                                     "Calidad del sueño",
                                     "Percepción subjetiva del esfuerzo",
                                     "T.Q.R",
                                     "Minutos de exposición")
      ) {
        
        ggplotly(
          ggplot(filtered, aes(x=ValorMedición)) +
            geom_bar(
              stat="count", 
              fill = "#E31D31",
              alpha=.7, 
              width=.7, 
              color="black", 
              size=.3
            )  + 
            scale_x_discrete(
              limits = seq(min(filtered$ValorMedición), max(filtered$ValorMedición),1)
            ) +
            labs(x = NULL, y = NULL) +
            theme(
              panel.grid.major.x = element_blank(),
              panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA)
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
                if (input$Player) {
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
              scale = 3
            )
          ) 
        
      } else {
        
        ggplotly(
          ggplot(filtered, aes(x=ValorMedición)) +
            geom_density(
              aes(y=..density..), 
              size=.7, 
              fill = "#E31D31",
              alpha = .5
            ) +
            labs(x = NULL, y = NULL) +
            theme(
              panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA)
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
                if (input$Player) {
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
              scale = 3
            )
          ) 
        
      }
      
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
    
    # Visualization
    if ( filtered_tab1.1() %>% nrow() < 3 ) { 
      
      emptyChart(
        paste(
          "No se registran <br> suficientes datos <br>",
          "<b>de esta Variable</b> <br>",
          "para generar <br> la Visualización"
        )
      )
      
    } else {
      
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
          marker = list(
            color = 'red',  
            size = 9, 
            line = list(
              color = 'black',
              width = 1
            )
          ),
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
              if (input$Player) {
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
            scale = 3
          )
        ) 
      
    }
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
  
  ####  TABLE_1_out  #### 
  output$download_Table_tab1.1_outliers.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
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
      if (input$Player) {
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
             "Desviación"=sd,
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
    df_t %>%
      mutate(
        'Intervalo Confianza' = paste("[",round((Promedio-Desviación),1), 
                                      "-",
                                      round((Promedio+Desviación),1),"]"),
        .before = "Rango"
      )
  })
  output$Table_tab1.1.1 <- DT::renderDataTable({
    DT::datatable(
      Stat.DF_tab1.1.1(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",    
      filter = 'top',
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE,
        scrollX = '400px', # scrollY = "350px", 
        paging=FALSE, info=FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) 
  })
  output$download_Table_tab1.1.1.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
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
      if (input$Player) {
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
  
  
  #### --------------------------- TAB_1_2 --------------------------- #### 
  
  ####  UI  ####
  levelsTypeMeters_tabe1.2 <- reactive({
    df_PD_CAT_T()%>% 
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
    df_PD_CAT_T()%>% 
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
    df_PD_CAT_T()%>% 
      filter(
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
    
    # Visualization
    if ( df.Cl() %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('esta Variable')      
      )
      
    } else {
      
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
            scale = 3
          )
        ) 
      
    }
    
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
    DT::datatable(
      Table_tab1.2.1(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "360px", 
        scrollCollapse = TRUE, paging = FALSE,
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
    if (input$Player) {
      df_PD_CAT_T()%>% 
        filter(
          Dimensión %in% input$DimInput_tab1.2,
          TipoMedición %in% input$TypeMetInput_tap1.2,
          Medición %in% input$MetInput_tab1.2,
          Jugador %in% input$PlayerInput
        )
      
    } else {
      df_PD_CAT_T()%>% 
        filter(
          Dimensión %in% input$DimInput_tab1.2,
          TipoMedición %in% input$TypeMetInput_tap1.2,
          Medición %in% input$MetInput_tab1.2
        )
    }
  })
  
  output$Player_tab1.2.2_Option_1 <- renderUI({
    if (input$Player) {
      dateInput(
        inputId = "timeFromInput_tab1.2.2", 
        label = "Fecha desde:",
        value = min(date_range),
        min = NULL,
        max = NULL,
        startview = "month",
        language = "es"
      )
    }
  })
  output$Player_tab1.2.2_Option_2 <- renderUI({
    if (input$Player) {
      dateInput(
        inputId = "timeToInput_tab1.2.2", 
        label = "hasta:",
        value = max(date_range),
        min = NULL,
        max = NULL,
        startview = "month",
        language = "es"
      )
    }
  })
  
  df_PD_fil_w <- reactive({
    if (input$Player) {
      df_PD_CAT() %>% 
        filter(
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
    if (input$Player) {
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
    
    # Visualization
    if ( df.tab1.2_PD() %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('esta Variable')      
      )
      
    } else {
      
      if (input$Player) {
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
              scale = 3
            )
          ) 
      } else {
        plot_ly(
          type = 'scatterpolar',
          mode = "lines+markers",
          fill = if (input$Fill_tab1.2.2) {'toself'} else {NULL}
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
              scale = 3
            )
          ) 
      }
      
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
    if (input$Player) {
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
          "Valor Máximo Plantel" = Máximo,
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
          "Valor Máximo Plantel" = Máximo,
          "Promedio Plantel" = Plantel
        )
    }
  })
  
  output$Table_tab1.2.2 <- DT::renderDataTable({
    DT::datatable(
      Table_tab1.2.2(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching=FALSE, info=FALSE,
        scrollX = '400px', scrollY = "520px", 
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    ) 
  }) 
  output$download_Table_tab1.2.2.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
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
      if (input$Player) {
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
  # ValueBox 2.0.3
  valuebox_tab2.0.3 <- reactive({
    if (
      valuebox_tab2.0.1() == 0 &
      valuebox_tab2.0.2() == 0
    ) {
      0
    } else {
      paste(
        round(((valuebox_tab2.0.2() / (valuebox_tab2.0.1() + valuebox_tab2.0.2())) * 100 ),1),
        "%"
      )
    }
  })
  output$valuebox_tab2.0.3 <- renderValueBox({
    valueBox(
      valuebox_tab2.0.3(),
      "Índice General de Positividad", 
      icon = icon("shield-virus"),
      color = "aqua"
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
      else { round((((Injury()/(Min_Exp()/60))) * 1000), 1) },
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
        (((
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
        )) * 100
        ) %>% round(1)
      },
      "Índice Lesión Jugador", 
      icon = icon("user-injured"),
      color = "aqua"
    )
  })
  
  ####  TAB_2.0  #### 
  output$Plot_tab2.0 <- renderPlotly({
    
    if ( 
      df_CED_fil() %>% nrow() == 0
    ) { 
      
      emptyChart(
        emptyMessage('Molestias, Lesiones y Enfermedades')      
      )
      
    } else {
      
      # Defining DF
      df_CE_T <- 
        df_CED_fil() %>% 
        select(
          ID_EventoClínico,
          Fecha = FechaEventoClínico, 
          Categoría = Categoría_I
        ) %>% 
        distinct() %>%
        select(!ID_EventoClínico) %>%
        drop_na() %>% 
        table() %>% 
        as.data.frame() %>% 
        rename(Cantidad = Freq) %>%
        mutate(
          Fecha = Fecha %>% as.Date(),
          Cantidad = Cantidad %>% as.numeric()
        )
      ## Join & Final Data Frame
      df_CE_T <- 
        full_join(
          rbind(
            data.frame(
              Fecha = seq.Date(
                from = min(df_CE_T$Fecha), # input$timeFromInput
                to = max(df_CE_T$Fecha),   # input$timeToInput
                by = "day"
              ),
              Categoría = "Enfermedad",
              Cantidad = 0
            ),
            data.frame(
              Fecha = seq.Date(
                from = min(df_CE_T$Fecha),
                to = max(df_CE_T$Fecha),
                by = "day"
              ),
              Categoría = "Lesión",
              Cantidad = 0     
            ),
            data.frame(
              Fecha = seq.Date(
                from = min(df_CE_T$Fecha),
                to = max(df_CE_T$Fecha),
                by = "day"
              ),
              Categoría = "Molestia",
              Cantidad = 0
            )
          ),
          df_CE_T
        ) %>%
        mutate(
          Fecha = Fecha %>% as.Date(),
          Cantidad = Cantidad %>% as.numeric()
        ) %>%
        group_by(Fecha, Categoría) %>%
        summarise(Cantidad = sum(Cantidad)) %>%
        as.data.frame()
      # NA Loop
      df_CE_T$Cantidad <- 
        df_CE_T$Cantidad %>% 
        replace_na("0") %>% 
        as.numeric()
      ## General DF
      DF_CE_F <- 
        df_CE_T %>% 
        spread(Categoría,Cantidad) %>%
        mutate(
          Fecha=Fecha %>% as.Date(),
          Molestia=Molestia %>% as.integer(),
          Lesión=Lesión %>% as.integer(),
          Enfermedad=Enfermedad %>% as.integer()
        ) %>%
        arrange(Fecha)
      ## Games
      games_CE_F  <- 
        inner_join(
          DF_CE_F %>% 
            select(Fecha) %>% 
            unique(),
          df_G_T() %>%
            filter(TipoMedición %in% "Partido") %>%
            select(Fecha),
          by='Fecha'
        ) %>% 
        pull(Fecha)
      
      if (
        DF_CE_F$Fecha %>% unique() %>% length() < 2 
      ) { 
        
        emptyChart(
          emptyMessage('Molestias, Lesiones y Enfermedades')      
        )
        
      } else {
        
        ## Max value
        max_value <- max(c(
          max(DF_CE_F$`Molestia`),
          max(DF_CE_F$`Lesión`),
          max(DF_CE_F$`Enfermedad`)
        ))
        
        ## Visualization
        Plotly_1 <- 
          plot_ly( 
            DF_CE_F,
            x = ~Fecha
          ) %>% 
          add_trace(
            name = 'Molestias',
            color = I("#C916C0"), 
            DF_CE_F, x = ~Fecha, y = ~Molestia,
            type = 'scatter', 
            mode = 'lines+markers',
            alpha = 1,
            line = list(width = 2),
            marker = list(
              opacity = 1,
              size = ifelse(DF_CE_F$Molestia == 0, 1, 5)
            )        
          ) %>% 
          add_trace(
            name = 'Lesiones', 
            color = I("#1348C2"), 
            DF_CE_F, x = ~Fecha, y = ~Lesión,
            type = 'scatter', mode = 'lines+markers',
            alpha = 1,
            line = list(width = 2),
            marker = list(
              opacity = 1,
              size = ifelse(DF_CE_F$Lesión == 0, 1, 5)
            )        
          ) %>% 
          add_trace(
            name = 'Enfermedades',
            color = I("#10B534"), 
            DF_CE_F, x = ~Fecha, y = ~Enfermedad,
            type = 'scatter', mode = 'lines+markers',
            alpha = 1,
            line = list(width = 2),
            marker = list(
              opacity = 1,
              size = ifelse(DF_CE_F$Enfermedad == 0, 1, 5)
            )        
          ) %>% 
          layout(
            xaxis = list(
              title = "",
              type = "date",
              #range = c(min(df_CE_T$Fecha),max(df_CE_T$Fecha)),
              zeroline = F,
              rangeselector = list(
                buttons = list(
                  list(count = 10,
                       label = "10 días",
                       step = "day",
                       stepmode = "todate"),
                  list(count = 20,
                       label = "20 días",
                       step = "day",
                       stepmode = "todate"),
                  list(count = 30,
                       label = "30 días",
                       step = "day",
                       stepmode = "todate"),
                  list(label = "Completo",
                       step = "all")
                ))
            ),
            yaxis = list(
              title = "",
              zeroline = F
            )
          ) %>% 
          rangeslider(
            type = "date", 
            borderwidth = 1, 
            thickness = .1
          ) %>% 
          layout(
            yaxis = list(range = c(-1, (max(max_value) + 2))),
            legend = list(orientation = 'h'),
            hovermode = "x unified",
            hoverlabel = list(
              bordercolor = 'black',
              font = list(size = 13),
              namelength = 30
            )
          ) %>% 
          config( 
            displaylogo = FALSE,
            modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                       "zoomOut2d", "lasso2d", 
                                       "toggleSpikelines")
          ) 
        ## Condition
        if (length(games_CE_F) != 0) {
          Plotly_1 <- 
            Plotly_1 %>%
            add_segments(
              name = "Fecha Partido",
              hoverinfo = 'text',
              text = paste("Fecha Partido: ", as.Date(games_CE_F), sep=""),
              color = I("red"), 
              alpha=.6, 
              line = list(dash = "dash"),
              y = 0, 
              yend = 6,
              x = as.Date(games_CE_F),
              xend = as.Date(games_CE_F)
            )
        }
        ## Second Plot
        Plotly_2 <- 
          plot_ly( 
            name = 'Cantidad',
            y = df_CE_T$Cantidad,
            type = 'histogram', 
            mode = 'lines', 
            color = I("#00AAD6"), 
            fill = 'tozeroy',
            showlegend = FALSE,
            alpha = .8
          ) %>% 
          layout(
            bargap = 0.4,
            xaxis = list(
              title = "",
              zeroline = FALSE,
              showline = FALSE,
              showticklabels = FALSE,
              showgrid = FALSE
            )
          )
        
        # Final Subplot
        subplot(
          Plotly_1, 
          Plotly_2, 
          nrows = 1, 
          margin = 0.0, 
          widths = c(0.93, 0.07), 
          shareY = TRUE
        )  %>% 
          layout(
            yaxis = list(range = c(-1, (max(max_value) + 2))),
            legend = list(orientation = 'h'),
            hovermode = "x unified",
            hoverlabel = list(
              bordercolor = 'black',
              font = list(size = 13),
              namelength = 30
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
                if (input$Player) {
                  paste(
                    "Diagrama Temporal de Frequencia de Enfermedades, Lesiones y Molestias de ", 
                    input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Diagrama Temporal de Frequencia de Enfermedades, Lesiones y Molestias del ", 
                    input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
        
      }
      
    }
    
  }) 
  Plot_tab2.0_Footer_A <- reactive({
    df_CED_fil() %>% 
      select(ID_Diagnóstico,Categoría_I) %>%
      distinct() %>%
      select(!ID_Diagnóstico) %>%
      select(Categoría_I) %>%
      filter(Categoría_I %in% "Molestia") %>% 
      table() %>% 
      as.data.frame() %>% 
      select(Freq) %>% 
      sum()
  })
  output$Plot_tab2.0_Footer_A <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "diagnoses",
      numberColor = "aqua", 
      header =  Plot_tab2.0_Footer_A(),
      text = "Total de Molestias"
    )
  })
  Plot_tab2.0_Footer_B <- reactive({
    df_CED_fil() %>% 
      select(ID_Diagnóstico,Categoría_I) %>%
      distinct() %>%
      select(!ID_Diagnóstico) %>%
      select(Categoría_I) %>%
      filter(Categoría_I %in% "Lesión") %>% 
      table() %>% 
      as.data.frame() %>% 
      select(Freq) %>% 
      sum()
  })
  output$Plot_tab2.0_Footer_B <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "crutch",
      numberColor = "aqua", 
      header =  Plot_tab2.0_Footer_B(),
      text = "Total de Lesiones"
    )
  })
  Plot_tab2.0_Footer_C <- reactive({
    df_CED_fil() %>% 
      select(ID_Diagnóstico,Categoría_I) %>%
      distinct() %>%
      select(!ID_Diagnóstico) %>%
      select(Categoría_I) %>%
      filter(Categoría_I %in% "Enfermedad") %>% 
      table() %>% 
      as.data.frame() %>% 
      select(Freq) %>% 
      sum()
  })
  output$Plot_tab2.0_Footer_C <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "viruses",
      numberColor = "aqua", 
      header =  Plot_tab2.0_Footer_C(),
      text = "Total de Enfermedades"
    )
  })
  Plot_tab2.0_Footer_D <- reactive({
    df_CED_fil() %>% 
      select(ID_Diagnóstico,Categoría_I) %>%
      distinct() %>%
      select(!ID_Diagnóstico) %>%
      select(Categoría_I) %>%
      filter(Categoría_I %in% "Cirugía") %>% 
      table() %>% 
      as.data.frame() %>% 
      select(Freq) %>% 
      sum()
  })
  output$Plot_tab2.0_Footer_D <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "syringe",
      numberColor = "aqua", 
      header =  Plot_tab2.0_Footer_D(),
      text = "Total de Cirugías"
    )
  })
  Plot_tab2.0_Footer_E <- reactive({
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
  output$Plot_tab2.0_Footer_E <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "crutch",
      numberColor = "aqua", 
      header =  Plot_tab2.0_Footer_E(),
      text = "Deportistas que se han Lesionado"
    )
  })
  Plot_tab2.0_Footer_F <- reactive({
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
  output$Plot_tab2.0_Footer_F <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "stethoscope",
      numberColor = "aqua", 
      header =  Plot_tab2.0_Footer_F(),
      text = "Deportistas que se han Enfermado"
    )
  })
  Plot_tab2.0_Footer_G <- reactive({
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
  output$Plot_tab2.0_Footer_G <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "hospital-user",
      numberColor = "aqua", 
      header =   if (is.na(Min_Exp()) == TRUE || Min_Exp() == 0 || Plot_tab2.0_Footer_G() == 0) { 0 } 
      else { round((((Plot_tab2.0_Footer_G()/(Min_Exp()/60))) * 1000), 1) },
      text = paste("Incidencia de Lesión ", input$mInput_tab2.0)
    )
  })
  Plot_tab2.0_Footer_H <- reactive({
    if (
      df_CED_C() %>% 
      select(Jugador) %>%
      unique() %>%
      drop_na() %>%
      nrow() == 0
    ) {
      0
    } else {
      (((
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
      )) * 100
      ) %>% round(0)
    }
  })
  output$Plot_tab2.0_Footer_H <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "user-injured",
      numberColor = "aqua", 
      header =  paste(Plot_tab2.0_Footer_H(),"%",sep=""),
      text = "Índice Lesión Jugador" # Porcentage de Jugadores que se han Lesionado
    )
  })
  
  observeEvent(input$Plot_tab2.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_2/Plot_tab2.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab2.0_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab2.0_Modal,{
    removeModal()
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
    } else if (input$mInput_tab2.0 == "Entrenamiento") {
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
    } else {
      Categoría_I <- 
        df_CED_fil() %>%
        select(c("ID_Diagnóstico","Categoría_I","Instancia",
                 as.character(input$cInput_tab1.0))) %>% 
        distinct() %>% 
        select(!ID_Diagnóstico) %>%
        filter(Categoría_I %in% input$cInput_tab2.0) %>%
        select(Categoría_I,as.character(input$cInput_tab1.0)) %>%
        drop_na()
    }
    # Building the Table 
    table.DF <- 
      table(Categoría_I) %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(Freq != 0) %>%
      rename("Frecuencia"=Freq)
    # Droping levels
    for (i in seq(1, (ncol(table.DF)-1), by=1)) {
      table.DF[,i] <- 
        droplevels(table.DF[,i], exclude="NULL")
    }
    # Final table
    table.DF %>% 
      drop_na() %>% 
      mutate(
        Porcentage = round(Frecuencia/sum(Frecuencia),2),
        "Incidencia" = round(((Frecuencia/(Min_Exp()/60))*1000),2)
      ) %>%
      rename_at("Incidencia", list( ~paste0("Incidencia ", input$cInput_tab2.0)))
  }) 
  output$Table_tab2.0 <- DT::renderDataTable({
    DT::datatable(
      Table_tab2.0(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom = '<"top">lrt<"bottom">ip',
        searching = TRUE, scrollCollapse = TRUE, 
        scrollX = '400px', scrollY = "400px", 
        info = FALSE, paging = FALSE, 
        columnDefs = list(list(className="dt-center", targets="_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
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
      if (input$Player) {
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
      if (input$Player) {
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
    # Creating Df Object
    filtered <- df_CED_fil() %>%
      select(
        "ID_Diagnóstico", 
        as.character(input$cInput_tab1.1)
      ) %>% 
      distinct() %>% 
      select(!ID_Diagnóstico) %>%
      drop_na()
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
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        scrollX = '400px', scrollY = "450px", 
        info=FALSE, paging=FALSE, 
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
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
      if (input$Player) {
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
      if (input$Player) {
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
  output$Plot_tab2.1_Footer_A <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "file-medical",
      numberColor = "aqua", 
      header =  
        if (nrow(Plot_tab2.1_Footer_A()) == 0) { 0 } else { Plot_tab2.1_Footer_A() },
      text = "Total de Molestias Musculares"
    )
  })
  Plot_tab2.1_Footer_B <- reactive({
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
  output$Plot_tab2.1_Footer_B <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "file-medical",
      numberColor = "aqua", 
      header =  
        if (nrow(Plot_tab2.1_Footer_B()) == 0) { 0 } else { Plot_tab2.1_Footer_B() },
      text = "Total de Lesiones Musculares"
    )
  })
  Plot_tab2.1_Footer_C_A <- reactive({
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
  Plot_tab2.1_Footer_C_B <- reactive({
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
  output$Plot_tab2.1_Footer_C <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "file-medical",
      numberColor = "aqua", 
      header =  
        if (is.na(Plot_tab2.1_Footer_C_A()) == TRUE) { 0 } else { Plot_tab2.1_Footer_C_A() } + 
        if (is.na(Plot_tab2.1_Footer_C_B()) == TRUE) { 0 } else { Plot_tab2.1_Footer_C_B() },      
      text = "Total de Lesiones + Molestias de Tendón"
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
    
    # Creating Df Object
    filtered <- df_CED_fil() %>%
      select(
        "ID_Diagnóstico",
        input$cInput_tab1.2,
        input$cInput_tab1.3
      ) %>% 
      distinct() %>% 
      select(!ID_Diagnóstico) %>% 
      drop_na() %>%
      table() %>%
      as.data.frame() %>%
      rename(Cantidad = Freq)
    
    # if (is.element('Diagnóstico', colnames(filtered)) &
    #     is.element('Categoría_I', colnames(filtered))) {
    #   filtered <-
    #     filtered %>% filter(Categoría_I != "Molestia")
    #   filtered$Categoría_I <-
    #     filtered$Categoría_I %>%
    #     factor(levels = filtered$Categoría_I %>% unique())
    # }
    
    # Visualization
    if ( filtered %>% filter(!Cantidad == 0) %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('esta combinación de Variables')      
      )
      
    } else {
      
      # Visualization
      plot_ly() %>%
        add_trace(
          orientation = 'h',
          type='bar',
          y = filtered %>% pull(input$cInput_tab1.2),
          x = filtered$Cantidad,
          color = filtered %>% pull(input$cInput_tab1.3),
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          ),
          text = paste(
            "<b>",input$cInput_tab1.2,":</b> ", filtered %>% pull(input$cInput_tab1.2),
            "<br><b>",input$cInput_tab1.3,":</b> ", filtered %>% pull(input$cInput_tab1.3),
            "<br><b>Cantidad:</b> ", filtered %>% pull(Cantidad)
          ),
          hoverinfo = 'text'
        ) %>% 
        layout(
          legend = list(
            x = 100, y = 1, 
            title = list(text=paste("<b>",input$cInput_tab1.3,"</b><br>"))
          ),
          #xaxis = list(range = c(0, (max(filtered$Cantidad)+18))),
          yaxis = list(
            ticktext = filtered %>% pull(input$cInput_tab1.2) %>% unique(),
            autotick = FALSE,
            ticks = "outside",
            tick0 = 0,
            dtick = 0.5,
            ticklen = 8,
            tickwidth = 1.4,
            tickcolor = toRGB("black")
          ),
          barmode = 'stack'
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
            scale = 3
          )
        )
      
    }
    
  }) 
  ####  TAB_2.2  #### 
  output$Plot_tab2.1.2 <- renderPlotly({
    
    # Creating Df Object
    filtered <- df_CED_fil() %>%
      select(
        ID_Diagnóstico,
        FechaDiagnóstico,
        input$cInput_tab1.2,
        input$cInput_tab1.3
      ) %>% 
      distinct() %>% 
      select(!ID_Diagnóstico) %>%
      mutate("Semana" = lubridate::week(FechaDiagnóstico))%>% 
      drop_na() %>%
      select(!FechaDiagnóstico) %>%
      table() %>%
      as.data.frame() %>%
      rename(Cantidad = Freq) 
    
    
    # if (is.element('Diagnóstico', colnames(filtered)) & 
    #     is.element('Categoría_I', colnames(filtered))) {
    #   filtered <- 
    #     filtered %>% filter(Categoría_I != "Molestia")
    #   filtered$Categoría_I <- 
    #     filtered$Categoría_I %>% 
    #     factor(levels = filtered$Categoría_I %>% unique())
    # } 
    
    # Visualization
    if ( filtered %>% filter(!Cantidad == 0) %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('esta combinación de Variables')      
      )
      
    } else if ( filtered$Semana %>% unique() %>% length() < 2 ) { 
      
      emptyChart(
        emptyMessage('esta combinación de Variables')      
      )
      
    } else {
      
      # Visualization
      plot_ly() %>%
        add_trace(
          orientation = 'h',
          type='bar',
          y = filtered %>% pull(input$cInput_tab1.2),
          x = filtered$Cantidad,
          color = filtered %>% pull(input$cInput_tab1.3),
          marker = list(line = list(width = line_with_bar, 
                                    color = 'rgb(0, 0, 0)')),
          text = paste(
            "<b>Semana:</b> ", filtered %>% pull(Semana),
            "<br><b>",input$cInput_tab1.2,":</b> ", filtered %>% pull(input$cInput_tab1.2),
            "<br><b>",input$cInput_tab1.3,":</b> ", filtered %>% pull(input$cInput_tab1.3),
            "<br><b>Cantidad:</b> ", filtered$Cantidad
          ),
          hoverinfo = 'text',
          frame = filtered$Semana
        ) %>% 
        layout(
          legend = list(
            x = 100, y = 1, 
            title = list(text=paste("<b>",input$cInput_tab1.3,"</b><br>"))
          ),
          xaxis = list(range = c(0, (max(filtered$Cantidad)+6))),
          yaxis = list(
            #tickvals = ~(filtered %>% pull(input$cInput_tab1.2)),
            ticktext = filtered %>% pull(input$cInput_tab1.2) %>% unique(),
            tickmode = "array",
            autotick = FALSE,
            ticks = "outside",
            tick0 = .5,
            dtick = .5,
            ticklen = 10,
            tickwidth = 1.4,
            tickcolor = toRGB("black")
          ),
          barmode = 'stack'
        ) %>% 
        animation_opts(
          frame = 2000, 
          transition = 800
          # redraw = FALSE,
          # easing = "elastic",
          # mode = "afterall"
        ) %>% 
        animation_slider(
          currentvalue = list(prefix = "Semana: "),
          hide = FALSE
        ) %>%
        animation_button(
          #x = 1.05, xanchor = "left", y =0, yanchor = "up",
          label = "Recorrido"
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
            scale = 3
          )
        )
      
    }
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
  
  ####  TAB_3.1  #### 
  output$Plot_tab3.1 <- renderPlotly({
    
    if ( 
      df_CED_fil() %>% nrow() == 0 &
      df_KA_fil() %>% nrow() == 0 &
      df_KT_fil() %>% nrow() == 0 &
      df_PD_F_fil() %>% nrow() == 0
    ) { 
      
      emptyChart(
        emptyMessage('Molestias, Lesiones y Enfermedades')      
      )
      
    } else {
      
      ## DF
      df.ID <- 
        rbind(
          df_KT_fil() %>% 
            group_by(FechaTratamientoKinésico) %>% 
            summarise(
              Cantidad=n_distinct(ID_TratamientoKinésico)
            ) %>% 
            mutate(Grupo="Tratamientos Kinésicos") %>%
            rename(Fecha=FechaTratamientoKinésico),
          df_KA_fil() %>% 
            group_by(FechaAcciónTerapéutica) %>% 
            summarise(
              Cantidad=n_distinct(ID_AcciónTerapéutica)
            ) %>% 
            mutate(Grupo="Acciones Terapéuticas") %>%
            rename(Fecha=FechaAcciónTerapéutica),
          df_CED_fil() %>% 
            group_by(FechaEventoClínico) %>% 
            summarise(
              Cantidad=n_distinct(ID_EventoClínico)
            ) %>% 
            mutate(Grupo="Eventos Clínicos") %>%
            rename(Fecha=FechaEventoClínico),
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
      
      if ( 
        df.ID %>% nrow() < 2
      ) { 
        
        emptyChart(
          emptyMessage('Molestias, Lesiones y Enfermedades')      
        )
        
      } else {
        
        ## Empty Range Date
        date_range <- 
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
                Grupo = "Tratamientos Kinésicos"
              ),
              data.frame(
                Fecha = seq.Date(
                  from = min(df.ID$Fecha),
                  to = max(df.ID$Fecha),
                  by = "day"
                ),
                Cantidad = 0,
                Grupo = "Acciones Terapéuticas"
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
        ## General DF
        DF_CKM_F <- 
          df.ID %>% 
          spread(Grupo,Cantidad) %>% 
          ungroup() %>%
          mutate_if (is.numeric , replace_na, replace = 0) %>% 
          mutate_if (is.numeric , as.integer) %>%
          arrange(Fecha)
        
        if (
          DF_CKM_F$Fecha %>% unique() %>% length() < 2 
        ) { 
          
          emptyChart(
            emptyMessage('Molestias, Lesiones y Enfermedades')      
          )
          
        } else {
          
          ## Games
          games_CKM_F <- inner_join(
            DF_CKM_F %>% 
              select(Fecha) %>% 
              unique(),
            df_G_T() %>%
              filter(TipoMedición %in% "Partido") %>%
              select(Fecha),
            by='Fecha'
          ) %>% 
            pull(Fecha)
          
          ## Max value
          max_value <- max(c(
            max(DF_CKM_F$`Eventos Clínicos`),
            max(DF_CKM_F$`Acciones Terapéuticas`),
            max(DF_CKM_F$`Tratamientos Kinésicos`),
            max(DF_CKM_F$`Masajes`)
          ))
          
          ## Visualization
          Plotly_1 <- 
            plot_ly( 
              DF_CKM_F,
              x = ~Fecha
            ) %>% 
            add_trace(
              name = 'Eventos Clínicos',
              color = I("#1348C2"), 
              DF_CKM_F, x = ~Fecha, y = DF_CKM_F$`Eventos Clínicos`,
              type = 'scatter', 
              mode = 'lines+markers',
              line = list(width = 2),
              marker = list(
                opacity = 1,
                size = ifelse(DF_CKM_F$`Eventos Clínicos` == 0, 1, 5)
              )
            ) %>% 
            add_trace(
              name = 'Acciones Terapéuticas',
              color = I("#179EB3"), 
              DF_CKM_F, x = ~Fecha, y = DF_CKM_F$`Acciones Terapéuticas`,
              type = 'scatter', 
              line = list(width = 2),
              marker = list(
                opacity = 1,
                size = ifelse(DF_CKM_F$`Acciones Terapéuticas` == 0, 1, 5)
              )
            ) %>% 
            add_trace(
              name = 'Tratamientos Kinésicos',
              color = I("#10B534"), 
              DF_CKM_F, x = ~Fecha, y = DF_CKM_F$`Tratamientos Kinésicos`,
              type = 'scatter', 
              mode = 'lines+markers',
              line = list(width = 2),
              marker = list(
                opacity = 1,
                size = ifelse(DF_CKM_F$`Tratamientos Kinésicos` == 0, 1, 5)
              )
            ) %>% 
            add_trace(
              name = 'Masajes',
              color = I("#C916C0"), 
              DF_CKM_F, x = ~Fecha, y = DF_CKM_F$Masajes,
              type = 'scatter', 
              mode = 'lines+markers',
              alpha = 1,
              line = list(width = 2),
              marker = list(
                opacity = 1,
                size = ifelse(DF_CKM_F$`Masajes` == 0, 1, 5)
              )
            ) %>%
            layout(
              xaxis = list(
                title = "",
                type = "date",
                #Range selected:
                #range = c(min(DF_CKM_F$Fecha),max(DF_CKM_F$Fecha)),
                zeroline = F,
                rangeselector = list(
                  buttons = list(
                    list(count = 10,
                         label = "10 días",
                         step = "day",
                         stepmode = "todate"),
                    list(count = 20,
                         label = "20 días",
                         step = "day",
                         stepmode = "todate"),
                    list(count = 30,
                         label = "30 días",
                         step = "day",
                         stepmode = "todate"),
                    list(
                      label = "Completo",
                      step = "all")
                  ))
              ),
              yaxis = list(
                title = "",
                zeroline = F
              )
            ) %>% 
            rangeslider(
              type = "date", 
              borderwidth = 1, 
              thickness = .1
            ) %>% 
            layout(
              yaxis = list(range = c(-1, (max(max_value) + 2))),
              legend = list(orientation = 'h'),
              hovermode = "x unified",
              hoverlabel = list(
                bordercolor = 'black',
                font = list(size = 13),
                namelength = 30
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
                  if (input$Player) {
                    paste(
                      "Diagrama de Frequencia de Eventos, Trastamientos, Acciones y Masajes del Jugador ", 
                      input$PlayerInput,
                      " del ", input$CategoryInput, 
                      " con rango de fecha desde ", input$timeFromInput, 
                      " hasta ", input$timeToInput,
                      sep = ""
                    )
                  } else {
                    paste(
                      "Diagrama de Frequencia de Eventos, Trastamientos, Acciones y Masajes del ", 
                      input$CategoryInput, 
                      " con rango de fecha desde ", input$timeFromInput, 
                      " hasta ", input$timeToInput,
                      sep = ""
                    )
                  },
                scale = 3
              )
            ) 
          if (length(games_CKM_F) != 0) {
            Plotly_1 <- 
              Plotly_1 %>%
              add_segments(
                name = "Fecha Partido",
                hoverinfo = 'text',
                text = paste("Fecha Partido: ", as.Date(games_CKM_F), sep=""),
                color = I("red"), alpha=.6, line = list(dash = "dash"),
                y = 0, yend = 40,
                x = as.Date(games_CKM_F),
                xend = as.Date(games_CKM_F)
              )
          }
          ## Second Plot
          Plotly_2 <- 
            plot_ly( 
              name = 'Cantidad',
              y = df.ID$Cantidad, 
              type = 'histogram', 
              mode = 'lines', 
              color = I("#00AAD6"), 
              fill = 'tozeroy',
              showlegend = FALSE,
              alpha = .8
            ) %>% 
            layout(
              bargap = 0.4,
              xaxis = list(
                title = "",
                zeroline = FALSE,
                showline = FALSE,
                showticklabels = FALSE,
                showgrid = FALSE
              )
            )
          
          # Final Subplot
          subplot(
            Plotly_1, 
            Plotly_2, 
            nrows = 1, 
            margin = 0.0, 
            widths = c(0.93, 0.07), 
            shareY = TRUE
          )  %>% 
            layout(
              yaxis = list(range = c(-1, (max(max_value) + 2))),
              legend = list(orientation = 'h'),
              hovermode = "x unified",
              hoverlabel = list(
                bordercolor = 'black',
                font = list(size = 13),
                namelength = 30
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
                  if (input$Player) {
                    paste(
                      "Diagrama Temporal de Frequencia de Eventos, Acciones, Tratamientos y Masajes de ", 
                      input$PlayerInput,
                      " del ", input$CategoryInput, 
                      " con rango de fecha desde ", input$timeFromInput, 
                      " hasta ", input$timeToInput,
                      sep = ""
                    )
                  } else {
                    paste(
                      "Diagrama Temporal de Frequencia de Eventos, Acciones, Tratamientos y Masajes del ", 
                      input$CategoryInput, 
                      " con rango de fecha desde ", input$timeFromInput, 
                      " hasta ", input$timeToInput,
                      sep = ""
                    )
                  },
                scale = 3
              )
            ) 
          
        }
        
      }
      
    }
    
  })
  
  ####  FOOTER_3.1  #### 
  
  Plot_tab3.1_Footer_A_1 <- reactive({
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
      header =  Plot_tab3.1_Footer_A_1(),
      text = "Total de Tratamientos Kinésicos"
    )
  })
  
  Plot_tab3.1_Footer_A_2 <- reactive({
    df_KA_fil() %>% 
      select(ID_AcciónTerapéutica) %>% 
      unique() %>% 
      drop_na() %>%
      nrow()
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
    df_KT_C() %>%
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
      text = "Total de Deportistas con Tratamientos Kinésicos"
    )
  })
  
  Plot_tab3.1_Footer_E <- reactive({
    df_G_T() %>%
      filter(TipoMedición %in% "Entrenamiento") %>%
      select(Fecha) %>%
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
    df_G_T() %>%
      filter(TipoMedición %in% "Partido") %>%
      select(Fecha) %>%
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
            group_by(FechaEventoClínico) %>% 
            summarise(
              'Eventos Clínicos'=n_distinct(ID_EventoClínico)
            ) %>%
            rename(Fecha=FechaEventoClínico),
          full_join(
            df_KA_fil() %>% 
              group_by(FechaAcciónTerapéutica) %>% 
              summarise(
                'Acciones Terapéuticas'=n_distinct(ID_AcciónTerapéutica)
              ) %>%
              rename(Fecha=FechaAcciónTerapéutica),
            df_KT_fil() %>% 
              group_by(FechaTratamientoKinésico) %>% 
              summarise(
                'Tratamientos Kinésicos'=n_distinct(ID_TratamientoKinésico)
              ) %>%
              rename(Fecha=FechaTratamientoKinésico),
            by = "Fecha"
          )
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
    full_join(
      df.T,
      df_G_T() %>% 
        filter(TipoMedición %in% c("Partido")) %>%
        select(Fecha) %>%
        mutate(Jornada = "Partido"),
      by = 'Fecha'
    ) %>%
      mutate(
        Jornada = Jornada %>% replace_na("Entrenamiento")
      ) 
  })
  output$Table_tab3.1 <- DT::renderDataTable({
    DT::datatable(
      Table_tab3.1(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        scrollX = '400px', scrollY = "300px", 
        info=FALSE, paging=FALSE, 
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) %>% 
      formatStyle(
        'Jornada',
        fontWeight = styleEqual(c("Partido"), c('bold')),
        color = styleEqual(c("Partido"), c('white'))
      )  %>% 
      formatStyle(
        'Jornada', 
        backgroundColor = styleEqual(c("Partido"), c('red'))
      ) 
  })
  output$download_Table_tab3.1.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla de Frequencia de Eventos, Tratamientos, Acciones y Masajes del Jugador ", 
          input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frequencia de Eventos, Tratamientos, Acciones y Masajes del ", 
          input$CategoryInput, 
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
      if (input$Player) {
        paste(
          "Tabla de Frequencia de Eventos, Tratamientos, Acciones y Masajes del Jugador ", 
          input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frequencia de Eventos, Tratamientos, Acciones y Masajes del ", 
          input$CategoryInput, 
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
  observeEvent(input$Table_tab3.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_3/Table_tab3.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab3.1_Modal", 
          icon = icon("times-circle"),
          label = "Cerrar", 
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab3.1_Modal,{
    removeModal()
  })
  
  ####  TABLE_3.2  #### 
  Table_tab3.2 <- reactive({
    data.frame(
      Medida = c(
        "Total Tratamientos Kinésicos",
        "Total Acciones Terapéuticas",
        "Total Masajes",
        "Total Eventos Clínicos",
        "Deportistas con Tratamientos Kinésicos",
        "Total Entrenamientos",
        "Total Partidos"
      ),
      Valor = c(
        Plot_tab3.1_Footer_A_1(),
        Plot_tab3.1_Footer_A_2(),
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
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        info=FALSE, paging=FALSE, 
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) 
  })
  output$download_Table_tab3.2.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
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
      if (input$Player) {
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
  
  ####  TAB_3.2.1  #### 
  
  df_tab3.2.1 <- reactive({
    ## Defining Objects and Matching Colnames
    df_KA_G <- df_KA_fil()
    ## Creating Df Object
    table.DF_KT <- 
      df_KA_G %>%
      select(AcciónTerapéutica) %>%
      drop_na() %>%
      table() %>% 
      as.data.frame() %>% 
      arrange(desc(Freq)) %>%
      filter(Freq != 0) 
    ## Condition
    if (table.DF_KT %>% nrow() != 0) {
      table.DF_KT <- 
        table.DF_KT %>% 
        rename("Cantidad"=Freq, Tipo='.') 
      ## Revalue
      table.DF_KT$Tipo <- 
        table.DF_KT$Tipo %>% 
        as.character() %>% 
        as.factor()
    }
    ## Final DF
    table.DF_KT
  })
  
  output$Plot_tab3.2.1 <- renderPlotly({
    
    # Defining the Object
    table.DF_KT <- df_tab3.2.1()
    
    # Visualization
    if ( table.DF_KT %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('Acciones Terapéuticas')      
      )
      
    } else {
      
      # Visualization
      plot_ly() %>%
        add_trace(
          orientation = 'h',
          type='bar',
          y=table.DF_KT$Tipo,
          x=table.DF_KT$Cantidad,
          color = table.DF_KT$Tipo,
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          ),
          text = paste(
            "<b>Tipo: </b>", table.DF_KT$Tipo,
            "<br><b>Cantidad: </b>", table.DF_KT$Cantidad
          ),
          hoverinfo = 'text'
        ) %>%
        layout(
          xaxis = list(range = c(0, (max(table.DF_KT$Cantidad)+10))),
          yaxis = list(
            autotick = FALSE,
            ticks = "outside",
            tick0 = 0,
            dtick = 0.25,
            ticklen = 5,
            tickwidth = 2,
            tickcolor = toRGB("blue")
          ),
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
              if (input$Player) {
                paste(
                  "Gráfica de Frecuencia de Acciones Terapéuticas del Jugador ", input$PlayerInput,
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              } else {
                paste(
                  "Gráfica de Frecuencia de Acciones Terapéuticas del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              },
            scale = 3
          )
        ) 
    }
    
  })
  
  ####  TAB_3.2.2  #### 
  
  df_tab3.2.2 <- reactive({
    
    ## Defining Objects and Matching Colnames
    df_KA_G <- 
      df_KA_fil()
    ## Years
    years_data <- 
      unique(format(df_KA_G$FechaAcciónTerapéutica, "%y"))
    ## Empty DF
    general_empty_df <- 
      data.frame(
        Tipo = factor(),
        Semana = factor(),
        Cantidad = integer()
      )
    ## General Loop & Condition
    if (df_KA_G %>% drop_na() %>% nrow() != 0) {
      
      for (year in seq(1,length(years_data))) {
        
        ## Creating Df Object
        initial_DF_KT <- 
          df_KA_G %>%
          select(AcciónTerapéutica,
                 FechaAcciónTerapéutica) %>%
          drop_na() %>%
          mutate(
            Año = format(FechaAcciónTerapéutica, "%y")
          ) %>%
          filter(
            Año == years_data[year]
          ) %>%
          select(!Año)
        table.DF_KT <- 
          initial_DF_KT %>%
          mutate("Semana" = lubridate::week(FechaAcciónTerapéutica)) %>% 
          select(!FechaAcciónTerapéutica) %>%
          table() %>% 
          as.data.frame() %>%
          filter(Freq != 0) %>%
          arrange(desc(Semana)) %>% 
          rename("Cantidad"=Freq,
                 "Tipo"=AcciónTerapéutica) 
        ## Revalue
        table.DF_KT$Tipo <- 
          table.DF_KT$Tipo %>% 
          as.character() %>% 
          as.factor() 
        ## Missing values
        # Empty DF
        empty_df <- 
          data.frame(
            Tipo = factor(),
            Semana = factor(),
            Cantidad = integer()
          )
        # Levels
        levels <- table.DF_KT$Tipo %>% unique()
        # Loop
        for (level in levels) {
          # DF
          df <- 
            data.frame(
              Tipo = level,
              Semana = seq(lubridate::week(min(initial_DF_KT$FechaAcciónTerapéutica)),
                           lubridate::week(max(initial_DF_KT$FechaAcciónTerapéutica))) %>% 
                as.factor(),
              Cantidad = 0
            )
          # Final DF
          empty_df <- 
            rbind(
              empty_df,
              df
            )
        }
        ## Grouping
        final_df <- 
          rbind(
            table.DF_KT,
            empty_df
          ) %>% 
          group_by(Tipo,Semana) %>%
          summarise(Cantidad = sum(Cantidad)) %>%
          arrange(desc(Cantidad))
        ## New Date order
        final_df$Semana <- 
          factor(
            final_df$Semana,
            levels = seq(lubridate::week(min(initial_DF_KT$FechaAcciónTerapéutica)),
                         lubridate::week(max(initial_DF_KT$FechaAcciónTerapéutica)))
          )
        ## Fianl DF
        final_df <- 
          final_df %>% 
          distinct() %>%
          arrange(desc(Semana)) %>%
          mutate(
            Semana =  as.factor(paste(years_data[year], Semana, sep = "-"))
          )
        ## Merging
        general_empty_df <- 
          rbind(
            general_empty_df,
            final_df
          )
        
      }
      
    }
    
    ## Final DF
    general_empty_df
    
  })
  
  output$Plot_tab3.2.2 <- renderPlotly({
    
    # Defining the Object
    table.DF_KT <- df_tab3.2.2()
    
    # Visualization
    if ( table.DF_KT %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('Acciones Terapéuticas')      
      )
      
    } else if ( table.DF_KT$Semana %>% unique() %>% length() < 2 ) { 
      
      emptyChart(
        emptyMessage('Acciones Terapéuticas')      
      )
      
    } else {
      
      # Visualization
      plot_ly() %>%
        add_trace(
          orientation = 'h',
          type = 'bar',
          y = table.DF_KT$Tipo,
          x = table.DF_KT$Cantidad,
          color = table.DF_KT$Tipo,
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          ),
          text = paste(
            "<b>Tipo: </b>", table.DF_KT$Tipo,
            "<br><b>Cantidad: </b>", table.DF_KT$Cantidad
          ),
          hoverinfo = 'text',
          frame = table.DF_KT$Semana
        ) %>%
        layout(
          xaxis = list(range = c(0, (max(table.DF_KT$Cantidad)+5))),
          yaxis = list(
            ticktext = table.DF_KT$Tipo %>% unique(),
            tickmode = "array",
            autotick = FALSE,
            ticks = "outside",
            tick0 = 0,
            dtick = 0.25,
            ticklen = 5,
            tickwidth = 2,
            tickcolor = toRGB("blue")
          ),
          showlegend = FALSE
        ) %>% 
        animation_opts(
          frame = 2000, 
          transition = 800
          # redraw = FALSE,
          # easing = "elastic",
          # mode = "afterall"
        ) %>% 
        animation_slider(
          currentvalue = list(prefix = "Semana: "),
          hide = FALSE
        ) %>%
        animation_button(
          #x = 1.05, xanchor = "left", y =0, yanchor = "up",
          label = "Recorrido"
        ) %>% 
        config(
          displaylogo = FALSE,
          modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                     "zoomOut2d", "lasso2d", 
                                     "toggleSpikelines"), 
          toImageButtonOptions = list(
            format = "jpeg",
            filename =
              if (input$Player) {
                paste(
                  "Gráfica de Frecuencia de Acciones Terapéuticas del Jugador ", input$PlayerInput,
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              } else {
                paste(
                  "Gráfica de Frecuencia de Acciones Terapéuticas Kinésico del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              },
            scale = 3
          )
        ) 
    }
  }
  )
  
  ####  TAB_3.2.3  #### 
  
  df_tab3.2.3 <- reactive({
    ## Defining Objects and Matching Colnames
    table.DF_KT <- df_KT_fil()
    
    ## Condition
    if (table.DF_KT %>% nrow() != 0) {
      # Empty DF
      df_KAT_F <- 
        data.frame(
          Tipo = factor(),
          Cantidad = numeric()
        )
      # Categories
      KT_KA <- 
        c("TERMO/CRIO","PRESOTERAPIA","MASOTERAPIA","ACTIVACIÓN","LIBERACIÓN","MIOFASIAL","LASER","DRENAJE",
          "LIB","CHC","TENS","TECAR","TEKAR","US","ET","FST")
      # Uppercase
      table.DF_KT$TratamientoKinésico <- 
        table.DF_KT$TratamientoKinésico %>% toupper() %>% as.character()
      # General Loop
      for (category in KT_KA) {
        # Searching Categories
        df_initial <- 
          table.DF_KT %>%
          mutate(
            TratamientoKinésico = case_when(
              stringr::str_detect(TratamientoKinésico, category) ~ category
            ) %>% 
              as.factor() 
          ) %>% 
          select(TratamientoKinésico,
                 FechaTratamientoKinésico) %>%
          drop_na()
        if (nrow(df_initial) != 0) {
          if (category == "TECAR" ) {
            df_initial$TratamientoKinésico <- 
              df_initial$TratamientoKinésico %>% 
              plyr::revalue(
                c(TECAR = "TEKAR")
              )
          } 
          if (category == "LIBERACIÓN" ) {
            df_initial$TratamientoKinésico <- 
              df_initial$TratamientoKinésico %>% 
              plyr::revalue(
                c(LIBERACIÓN = "LIB")
              )
          }
          df <- 
            df_initial %>%
            select(!FechaTratamientoKinésico) %>%
            table() %>% 
            as.data.frame() %>%
            rename(Tipo = '.',
                   Cantidad = 'Freq')
          # Building the DF
          df_KAT_F <- rbind(df_KAT_F,df) %>% 
            arrange(Cantidad) 
        }
      }
      # Final DF
      df_KAT_F <- 
        df_KAT_F %>% 
        group_by(Tipo) %>% 
        summarise(Cantidad = Cantidad %>% sum()) %>%
        filter(Cantidad != 0)
      df_KAT_F$Tipo <- 
        df_KAT_F$Tipo %>% as.character() %>% as.factor()
      table.DF_KT <- 
        df_KAT_F
    }
    table.DF_KT
  })
  
  output$Plot_tab3.2.3 <- renderPlotly({
    
    # Defining the Object
    table.DF_KT <- df_tab3.2.3()
    
    # Visualization
    if ( table.DF_KT %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('Tratamientos Kinésicos')      
      )
      
    } else {
      
      # Visualization
      plot_ly() %>%
        add_trace(
          orientation = 'h',
          type='bar',
          y=table.DF_KT$Tipo,
          x=table.DF_KT$Cantidad,
          color = table.DF_KT$Tipo,
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          ),
          text = paste(
            "<b>Tipo: </b>", table.DF_KT$Tipo,
            "<br><b>Cantidad: </b>", table.DF_KT$Cantidad
          ),
          hoverinfo = 'text'
        ) %>%
        layout(
          #margin = list(l = 200, r = 50, b = 100, t = 100, pad = 20),
          #xaxis = list(range = c(0, (max(table.DF_KT$Cantidad)+10))),
          yaxis = list(
            autotick = FALSE,
            ticks = "outside",
            tick0 = 0,
            dtick = 0.25,
            ticklen = 5,
            tickwidth = 2,
            tickcolor = toRGB("blue")
          ),
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
              if (input$Player) {
                paste(
                  "Gráfica de Frecuencia de Tratamientos Kinésicos del Jugador ", input$PlayerInput,
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              } else {
                paste(
                  "Gráfica de Frecuencia de Tratamientos Kinésicos del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              },
            scale = 3
          )
        ) 
    }
  })
  
  ####  TAB_3.2.4  #### 
  
  df_tab3.2.4 <- reactive({
    
    ## Defining Objects and Matching Colnames
    table.DF_KT <- 
      df_KT_fil()
    ## Years
    years_data <- 
      unique(format(table.DF_KT$FechaTratamientoKinésico, "%y"))
    ## Empty DF
    general_empty_df <- 
      data.frame(
        Tipo = factor(),
        Semana = factor(),
        Cantidad = integer()
      )
    
    ## General Loop & Condition
    if (table.DF_KT %>% drop_na() %>% nrow() != 0) {
      
      for (year in seq(1,length(years_data))) {
        
        # Initial DF
        df_Loop <- 
          table.DF_KT %>%
          mutate(
            Año = format(FechaTratamientoKinésico, "%y")
          ) %>%
          filter(
            Año == years_data[year]
          ) %>%
          select(!Año)
        # Empty DF
        df_KAT_F <- 
          data.frame(
            Tipo = factor(),
            Cantidad = numeric(),
            Semana = Date()
          )
        # Categories
        KT_KA <- 
          c("TERMO/CRIO","PRESOTERAPIA","MASOTERAPIA","ACTIVACIÓN","LIBERACIÓN","MIOFASIAL","LASER","DRENAJE",
            "LIB","CHC","TENS","TECAR","TEKAR","US","ET","FST")
        # Uppercase
        df_Loop$TratamientoKinésico <- 
          df_Loop$TratamientoKinésico %>% 
          toupper() %>% 
          as.character()
        # General Loop
        for (category in KT_KA) {
          # Searching Categories
          df_initial <- 
            df_Loop %>%
            mutate(
              TratamientoKinésico = case_when(
                stringr::str_detect(TratamientoKinésico, category) ~ category
              ) %>% 
                as.factor() 
            ) %>% 
            select(TratamientoKinésico,
                   FechaTratamientoKinésico) %>%
            drop_na()
          if (nrow(df_initial) != 0) {
            if (category == "TECAR" ) {
              df_initial$TratamientoKinésico <- 
                df_initial$TratamientoKinésico %>% 
                plyr::revalue(
                  c(TECAR = "TEKAR")
                )
            } 
            if (category == "LIBERACIÓN" ) {
              df_initial$TratamientoKinésico <- 
                df_initial$TratamientoKinésico %>% 
                plyr::revalue(
                  c(LIBERACIÓN = "LIB")
                )
            }
            df <- df_initial %>%
              mutate("Semana" = lubridate::week(FechaTratamientoKinésico)) %>% 
              select(!FechaTratamientoKinésico) %>%
              table() %>% 
              as.data.frame() %>%
              rename(Tipo = 'TratamientoKinésico',
                     Cantidad = 'Freq')
            # Building the DF
            df_KAT_F <- rbind(df_KAT_F,df) %>% 
              arrange(Cantidad) 
          }
        }
        # Final DF
        df_KAT_F <- 
          df_KAT_F %>% 
          group_by(Semana,Tipo) %>% 
          summarise(Cantidad = Cantidad %>% sum()) %>%
          filter(Cantidad != 0)
        ## Revalue
        df_KAT_F$Tipo <- 
          df_KAT_F$Tipo %>% 
          as.character() %>% 
          as.factor()
        ## Missing values
        # Empty DF
        empty_df <- 
          data.frame(
            Tipo = factor(),
            Semana = factor(),
            Cantidad = integer()
          )
        # Levels
        levels <- df_KAT_F$Tipo %>% unique()
        # Loop
        for (level in levels) {
          # DF
          df <- 
            data.frame(
              Tipo = level,
              Semana = seq(lubridate::week(min(df_Loop$FechaTratamientoKinésico)),
                           lubridate::week(max(df_Loop$FechaTratamientoKinésico))) %>% 
                as.factor(),
              Cantidad = 0
            )
          # Final DF
          empty_df <- 
            rbind(
              empty_df,
              df
            )
        }
        ## Grouping
        final_df <- 
          rbind(
            df_KAT_F,
            empty_df
          ) %>% 
          group_by(Tipo,Semana) %>%
          summarise(Cantidad = sum(Cantidad)) %>%
          arrange(desc(Cantidad))
        ## New Date order
        final_df$Semana <- 
          factor(
            final_df$Semana,
            levels = seq(lubridate::week(min(df_Loop$FechaTratamientoKinésico)),
                         lubridate::week(max(df_Loop$FechaTratamientoKinésico)))
          )
        ## Fianl DF
        final_df <- 
          final_df %>% 
          distinct() %>%
          arrange(desc(Semana)) %>%
          mutate(
            Semana =  as.factor(paste(years_data[year], Semana, sep = "-"))
          )
        ## Merging
        general_empty_df <- 
          rbind(
            final_df,
            general_empty_df
          )
        
      }
      
    }
    
    ## Final DF
    general_empty_df
    
  })
  
  output$Plot_tab3.2.4 <- renderPlotly({
    
    # Defining the Object
    df_KAT_F <- df_tab3.2.4()
    
    # Visualization
    if ( df_KAT_F %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('Tratamientos Kinésicos')      
      )
      
    } else if ( df_KAT_F$Semana %>% unique() %>% length() < 2 ) { 
      
      emptyChart(
        emptyMessage('Tratamientos Kinésicos')      
      )
      
    } else {
      
      # Visualization
      plot_ly() %>%
        add_trace(
          orientation = 'h',
          type='bar',
          y=df_KAT_F$Tipo,
          x=df_KAT_F$Cantidad,
          color = df_KAT_F$Tipo,
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          ),
          text = paste(
            "<b>Tipo: </b>", df_KAT_F$Tipo,
            "<br><b>Cantidad: </b>", df_KAT_F$Cantidad
          ),
          hoverinfo = 'text',
          frame = df_KAT_F$Semana
        ) %>%
        layout(
          xaxis = list(range = c(0, (max(df_KAT_F$Cantidad)+6))),
          yaxis = list(
            #tickvals = ~(filtered %>% pull(input$cInput_tab1.2)),
            ticktext = df_KAT_F$Tipo %>% unique(),
            tickmode = "array",
            autotick = FALSE,
            ticks = "outside",
            tick0 = 0,
            dtick = 0.25,
            ticklen = 5,
            tickwidth = 2,
            tickcolor = toRGB("blue")
          ),
          showlegend = FALSE
        ) %>% 
        animation_opts(
          frame = 2000, 
          transition = 800
          # redraw = FALSE,
          # easing = "elastic",
          # mode = "afterall"
        ) %>% 
        animation_slider(
          currentvalue = list(prefix = "Semana: "),
          hide = FALSE
        ) %>%
        animation_button(
          #x = 1.05, xanchor = "left", y =0, yanchor = "up",
          label = "Recorrido"
        ) %>% 
        config(
          displaylogo = FALSE,
          modeBarButtonsToRemove = c("select2d", "zoomIn2d", 
                                     "zoomOut2d", "lasso2d", 
                                     "toggleSpikelines"), 
          toImageButtonOptions = list(
            format = "jpeg",
            filename =
              if (input$Player) {
                paste(
                  "Gráfica de Frecuencia Tratamientos Kinésicos del Jugador ", input$PlayerInput,
                  " del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              } else {
                paste(
                  "Gráfica de Frecuencia de Tratamientos Kinésicos del ", input$CategoryInput, 
                  " con rango de fecha desde ", input$timeFromInput, 
                  " hasta ", input$timeToInput,
                  sep = ""
                )
              },
            scale = 3
          )
        )
    }
  })
  
  
  ####  TABLE_3.3.1  #### 
  
  output$Table_tab3.3.1 <- DT::renderDataTable({
    DT::datatable(
      df_tab3.2.1(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        scrollX = '400px', scrollY = "200px", 
        info=FALSE, paging=FALSE, 
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) 
  })
  output$download_Table_tab3.3.1.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla de Frequencia de Acciones Terapéuticas del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frequencia de Acciones Terapéuticas del ", input$PlayerInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(df_tab3.2.1(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab3.3.1.csv <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla de Frequencia de Acciones Terapéuticas del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frequencia de Acciones Terapéuticas del ", input$PlayerInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(df_tab3.2.1(), file, row.names = FALSE)
    }
  )
  
  ####  TABLE_3.3.2  #### 
  
  output$Table_tab3.3.2 <- DT::renderDataTable({
    DT::datatable(
      df_tab3.2.3(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching=TRUE, scrollCollapse=TRUE, 
        scrollX = '400px', scrollY = "200px", 
        info=FALSE, paging=FALSE, 
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) 
  })
  output$download_Table_tab3.3.2.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla de Frequencia de Tratamientos Kinésicos del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frequencia de Tratamientos Kinésicos del ", input$PlayerInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(df_tab3.2.3(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab3.3.2.csv <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla de Frequencia de Tratamientos Kinésicos del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla de Frequencia de Tratamientos Kinésicos del ", input$PlayerInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(df_tab3.2.3(), file, row.names = FALSE)
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
      df_TL_fil() %>%
        filter(
          Categoría_I %in% "Enfermedad"
        ) %>%
        pull(TimeLoss) %>%
        sum(),
      "Time Loss por Enfermedad",
      icon = icon("stethoscope"),
      color = "aqua"
    )
  })
  output$valuebox_tab4.3 <- renderValueBox({
    valueBox(
      df_TL_fil() %>%
        filter(
          Categoría_I %in% "Lesión"
        ) %>%
        pull(TimeLoss) %>%
        sum(),
      "Time Loss por Lesión",
      icon = icon("crutch"),
      color = "aqua"
    )
  })
  output$valuebox_tab4.4 <- renderValueBox({
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
    if ( 
      df_TL_fil() %>% 
      filter(Categoría_I %in% "Lesión") %>%
      select(Severidad) %>% 
      nrow() == 0 
    ) {  
      
      emptyChart(
        emptyMessage('Time Loss')      
      )
      
    } else {
      
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
        text = ~paste(
          Severidad, "/", 
          round((TimeLoss/sum(df_TL_table$TimeLoss))*100,1), "%", 
          " del Total con ", TimeLoss, ifelse(TimeLoss == 1, ' Registro', ' Registros')
        ),
        textfont = list(color = '#000000', size = 13),
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
                if (input$Player) {
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
            scale = 3
          )
        ) 
      
    }
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
    if ( 
      df_TL_fil() %>% 
      filter(Categoría_I %in% "Enfermedad") %>%
      select(Severidad) %>% 
      nrow() == 0 
    ) {  
      
      emptyChart(
        emptyMessage('Time Loss')      
      )
      
    } else {
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
        text = ~paste(
          Severidad, "/", 
          round((TimeLoss/sum(df_TL_table$TimeLoss))*100,1), "%", 
          " del Total con ", TimeLoss, ifelse(TimeLoss == 1, ' Registro', ' Registros')
        ),
        textfont = list(color = '#000000', size = 13),
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
                if (input$Player) {
                  paste(
                    "Diagrama de Severidad de Enfermedad del Jugador ", input$PlayerInput, 
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )  
                } else {
                  paste(
                    "Diagrama de Severidad de Enfermedad del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )  
                } 
              ),
            scale = 3
          )
        ) 
      
    }
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
  df_Tab4.1 <- reactive({
    ## General DF
    df_tab <- 
      df_TL_fil() %>% 
      arrange(desc(FechaTérmino_TimeLoss)) %>% 
      select(!c("Disponibilidad","Categoría")) %>%
      rename(
        'Fecha Inicio' = FechaInicio_TimeLoss,
        'Fecha Término' = FechaTérmino_TimeLoss,
        Categoría = Categoría_I
      ) %>%
      filter(
        !Momento %in% "Evento clínico externo (Selección/Club)"
      )
    ## Condition
    if (!input$TimeLoss_Injuries) {
      df_tab <- 
        df_tab %>%
        filter(!Categoría %in% "Molestia")
    } 
    if (!input$TimeLoss_Diseases) {
      df_tab <- 
        df_tab %>%
        filter(!Categoría %in% "Enfermedad")
    } 
    if (!input$TimeLoss_0) {
      df_tab <- 
        df_tab %>%
        filter(!TimeLoss == 0)
    } 
    ## Final DF
    df_tab
  })
  
  output$Table_tab4.1 <- DT::renderDataTable({
    DT::datatable(
      df_Tab4.1(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      selection = "multiple",
      options = list(
        ordering = FALSE,
        sDom = '<"top">lrt<"bottom">ip',
        searching = TRUE, scrollCollapse = TRUE, 
        scrollX = '400px', scrollY = "400px", 
        info = FALSE, paging = FALSE, 
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) 
  })
  output$download_Table_tab4.1.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla General Time Loss del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      } else {
        paste(
          "Tabla General Time Loss del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx", sep = ""
        )  
      }
    },
    content = function(file) {
      write.xlsx(df_Tab4.1(), file, col.names = TRUE, 
                 row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab4.1.csv <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla Time Loss del Jugador ", input$PlayerInput, 
          " del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } else {
        paste(
          "Tabla Time Loss del ", input$CategoryInput, 
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".csv", sep = ""
        )  
      } 
    },
    content = function(file) {
      write.csv(df_Tab4.1(), file, row.names = FALSE)
    }
  )
  
  
  #### --------------------------- TAB_5 --------------------------- #### 
  
  ####  UI  ####
  output$playerOption_tab5 <- renderUI({
    selectInput(
      inputId = 'PlayerInput_tab5', 
      label = "Jugador:",
      choices = levelsPlayers(),
      selected = "Pablo  Galdames"
    )
  })
  
  output$dateOption_tab5 <- renderUI({
    dateInput(
      width = "150px",
      inputId = "time_tab5.1", 
      label = "Fecha:",
      value = df.tab5.1_PD() %>% pull(FechaDimensión) %>% max(),
      min = NULL,
      max = NULL,
      startview = "month",
      language = "es"
    )
  })
  
  ####  DF_5  #### 
  
  Wellness  <- reactive({
    df_PD_fil() %>% 
      filter(
        Medición %in% c("Nivel de energía",
                        "Humor / Estado de ánimo",
                        "Estado general muscular",
                        "Calidad del sueño")
      ) %>% 
      pull(ValorMedición) 
  })
  
  ####  DF_5.0 #### 
  df.tab5.0_PD <- reactive({
    left_join(
      left_join(
        full_join(
          df_PD_CAT_T() %>%
            filter(
              Medición %in% "Percepción subjetiva del esfuerzo" 
            ) %>%
            group_by(Jugador,FechaDimensión) %>%
            summarise(
              Esfuerzo = sum(ValorMedición)
            ) %>%
            as.data.frame() ,
          df_PD_CAT_T() %>%
            filter(
              Medición %in% "Minutos de exposición" 
            ) %>%
            group_by(Jugador,FechaDimensión) %>%
            summarise(
              Minutos = sum(ValorMedición)
            ) %>%
            as.data.frame(),
          by = c('Jugador','FechaDimensión')
        ),
        df_PD_CAT_T() %>%
          filter(
            Medición %in% c("Nivel de energía",
                            "Humor / Estado de ánimo",
                            "Estado general muscular",
                            "Calidad del sueño")
          ) %>%
          group_by(Jugador,FechaDimensión) %>%
          summarise(
            TotalWellness = sum(ValorMedición)
          ) %>%
          as.data.frame(),
        by = c('Jugador','FechaDimensión')
      ),
      df_PD_CAT_T() %>%
        filter(
          Medición %in%  "T.Q.R" 
        ) %>%
        group_by(Jugador,FechaDimensión) %>%
        summarise(
          "T.Q.R" = sum(ValorMedición)
        ) %>%
        as.data.frame(),
      by = c('Jugador','FechaDimensión')
    ) %>% 
      mutate(
        CargaInterna = Minutos * Esfuerzo
      ) %>%
      select(-c("Esfuerzo","Minutos")) %>%
      filter(
        Jugador %in% input$PlayerInput_tab5
      ) %>%
      drop_na() %>%
      arrange(FechaDimensión) %>%
      slice_tail(n=10)
  })
  
  ####  DF_5.1 #### 
  df.tab5.1_PD <- reactive({
    left_join(
      left_join(
        full_join(
          df_PD_CAT_T() %>%
            filter(
              Medición %in% "Percepción subjetiva del esfuerzo" 
            ) %>%
            group_by(Jugador,FechaDimensión) %>%
            summarise(
              Esfuerzo = sum(ValorMedición)
            ) %>%
            as.data.frame() ,
          df_PD_CAT_T() %>%
            filter(
              Medición %in% "Minutos de exposición" 
            ) %>%
            group_by(Jugador,FechaDimensión) %>%
            summarise(
              Minutos = sum(ValorMedición)
            ) %>%
            as.data.frame(),
          by = c('Jugador','FechaDimensión')
        ),
        df_PD_CAT_T() %>%
          filter(
            Medición %in% c("Nivel de energía",
                            "Humor / Estado de ánimo",
                            "Estado general muscular",
                            "Calidad del sueño")
          ) %>%
          group_by(Jugador,FechaDimensión) %>%
          summarise(
            TotalWellness = sum(ValorMedición)
          ) %>%
          as.data.frame(),
        by = c('Jugador','FechaDimensión')
      ),
      df_PD_CAT_T() %>%
        filter(
          Medición %in%  "T.Q.R" 
        ) %>%
        group_by(Jugador,FechaDimensión) %>%
        summarise(
          "T.Q.R" = sum(ValorMedición)
        ) %>%
        as.data.frame(),
      by = c('Jugador','FechaDimensión')
    ) %>% 
      mutate(
        CargaInterna = Minutos * Esfuerzo
      ) %>%
      select(-c("Esfuerzo","Minutos")) %>%
      drop_na()
  })
  
  ####  DF_MP #### 
  df_MP <- reactive({
    
    # Date Variables
    begin_date <- 
      paste(
        input$dateInput_tab5.2,
        "01",
        "01",
        sep = "-"
      ) %>% 
      as.Date()
    end_date <- 
      paste(
        input$dateInput_tab5.2,
        "12",
        "31",
        sep = "-"
      ) %>% 
      as.Date()
    
    if (input$Player) {
      
      left_join(
        df_PD_CAT() %>%
          filter(
            Jugador %in% input$PlayerInput,
            Medición %in% "Minutos de exposición" 
          ) %>%
          group_by(Jugador, FechaDimensión) %>%
          summarise(
            Suma.Min.Exp = sum(ValorMedición)
          ) %>%
          mutate("Semana" = lubridate::week(FechaDimensión)),
        df_PD_CAT() %>%
          filter(
            Jugador %in% input$PlayerInput,
            Medición %in% "Percepción subjetiva del esfuerzo"
          ) %>%
          group_by(Jugador, FechaDimensión) %>%
          summarise(
            Suma.D.Med = sum(ValorMedición)
          ),
        by = c(
          "FechaDimensión" = "FechaDimensión",
          "Jugador" = "Jugador"
        )
      ) %>% 
        filter(
          FechaDimensión >= begin_date,
          FechaDimensión <= end_date
        )
      
    } else {
      
      left_join(
        df_PD_CAT() %>%
          filter(
            Medición %in% "Minutos de exposición" 
          ) %>%
          group_by(Jugador, FechaDimensión) %>%
          summarise(
            Suma.Min.Exp = sum(ValorMedición)
          ) %>%
          mutate("Semana" = lubridate::week(FechaDimensión)),
        df_PD_CAT() %>%
          filter(
            Medición %in% "Percepción subjetiva del esfuerzo"
          ) %>%
          group_by(Jugador, FechaDimensión) %>%
          summarise(
            Suma.D.Med = sum(ValorMedición)
          ),
        by = c(
          "FechaDimensión" = "FechaDimensión",
          "Jugador" = "Jugador"
        )
      ) %>% 
        filter(
          FechaDimensión >= begin_date,
          FechaDimensión <= end_date
        )
      
    }
    
  })
  
  ####  DF_5.2 #### 
  df.tab5.2_PD <- reactive({
    if (input$Player) {
      # Main DF
      df.W <-
        df_MP() %>%
        mutate(
          Suma.Diaria = Suma.Min.Exp*Suma.D.Med
        ) %>%
        drop_na() %>%
        group_by(FechaDimensión) %>%
        summarise(
          Promedio.Diario = mean(Suma.Diaria)
        ) %>%
        mutate(
          "Semana" = lubridate::week(FechaDimensión)
        ) %>%
        group_by(Semana) %>%
        summarise(
          Acute.Workload = sum(Promedio.Diario) %>% round(0)
        )
      # Filling Empty Weeks
      df.W <- 
        left_join(
          data.frame(
            Semana = seq(
              df.W$Semana %>% min(),
              df.W$Semana %>% max()
            )
          ),
          df.W,
          by = "Semana"
        )
      # New Object
      Chronic.Workload <-
        data.frame(
          "Chronic.Workload" = numeric()
        )
      # Defining new means
      for (i in 5:nrow(df.W)) {
        Chronic.Workload[i,1] <-
          round(sum(df.W[i-1,2]+df.W[i-2,2]+df.W[i-3,2]+df.W[i-4,2]) / 4 , 0)
      }
      # Final DF
      cbind(df.W,Chronic.Workload) %>%
        mutate(
          Chronic.Workload.Ratio  = round(Acute.Workload / Chronic.Workload, 2),
          Zscore = (
            (Acute.Workload  - mean(Acute.Workload )) / sd(Acute.Workload )
          ) %>% round(2)
        ) %>%
        rename(
          "Agudo" = Acute.Workload,
          "Crónico" = Chronic.Workload,
          "ACWR" = Chronic.Workload.Ratio
        ) %>%
        arrange(desc(Semana))
      
    } else {
      
      # Main DF
      df.W <-
        df_MP() %>%
        mutate(
          Suma.Diaria = Suma.Min.Exp*Suma.D.Med
        ) %>%
        drop_na() %>%
        group_by(FechaDimensión) %>%
        summarise(
          Promedio.Diario = mean(Suma.Diaria)
        ) %>%
        mutate(
          "Semana" = lubridate::week(FechaDimensión)
        ) %>%
        group_by(Semana) %>%
        summarise(
          Acute.Workload = sum(Promedio.Diario) %>% round(0)
        )
      # Filling Empty Weeks
      df.W <- 
        left_join(
          data.frame(
            Semana = seq(
              df.W$Semana %>% min(),
              df.W$Semana %>% max()
            )
          ),
          df.W,
          by = "Semana"
        )
      # New Object
      Chronic.Workload <-
        data.frame(
          "Chronic.Workload" = numeric()
        )
      # Defining new means
      for (i in 5:nrow(df.W)) {
        Chronic.Workload[i,1] <-
          round(sum(df.W[i-1,2]+df.W[i-2,2]+df.W[i-3,2]+df.W[i-4,2]) / 4 , 0)
      }
      # Final DF
      cbind(
        df.W,Chronic.Workload
      ) %>%
        mutate(
          Acute.Workload_0 = Acute.Workload
        ) %>%
        mutate_at(
          "Acute.Workload_0", ~replace(., is.na(.), 0)
        ) %>%
        mutate(
          Chronic.Workload.Ratio  = round(Acute.Workload / Chronic.Workload, 2),
          Zscore = (
            (Acute.Workload_0  - mean(Acute.Workload_0 )) / sd(Acute.Workload_0 )
          ) %>% round(2)
        ) %>%
        rename(
          "Agudo" = Acute.Workload,
          "Crónico" = Chronic.Workload,
          "ACWR" = Chronic.Workload.Ratio
        ) %>%
        arrange(desc(Semana)) %>%
        select(!Acute.Workload_0)
    }
  })
  
  ####  DF_5.3 #### 
  df.tab5.3_PD <- reactive({
    #
    # Main DF
    df.W <-
      left_join(
        df_PD %>%
          filter(
            Medición %in% "Minutos de exposición" 
          ) %>%
          group_by(Jugador, FechaDimensión) %>%
          summarise(
            Suma.Min.Exp = sum(ValorMedición)
          ) %>%
          mutate("Semana" = lubridate::week(FechaDimensión)),
        df_PD %>%
          filter(
            Medición %in% "Percepción subjetiva del esfuerzo"
          ) %>%
          group_by(Jugador, FechaDimensión) %>%
          summarise(
            Suma.D.Med = sum(ValorMedición)
          ),
        by = c(
          "FechaDimensión" = "FechaDimensión",
          "Jugador" = "Jugador"
        )
      ) %>%
      mutate(
        Suma.Diaria = Suma.Min.Exp*Suma.D.Med
      ) %>%
      drop_na() %>%
      group_by(FechaDimensión) %>%
      summarise(
        Promedio.Diario = mean(Suma.Diaria)
      ) %>%
      mutate(
        "Semana" = lubridate::week(FechaDimensión)
      ) %>%
      group_by(Semana) %>%
      summarise(
        Acute.Workload = sum(Promedio.Diario) %>% round(0)
      )
    # Filling Empty Weeks
    df.W <- 
      left_join(
        data.frame(
          Semana = seq(
            df.W$Semana %>% min(),
            df.W$Semana %>% max()
          )
        ),
        df.W,
        by = "Semana"
      )
    # New Object
    Chronic.Workload <-
      data.frame(
        "Chronic.Workload" = numeric()
      )
    # Defining new means
    for (i in 5:nrow(df.W)) {
      Chronic.Workload[i,1] <-
        round(sum(df.W[i-1,2]+df.W[i-2,2]+df.W[i-3,2]+df.W[i-4,2]) / 4 , 0)
    }
    # Final DF
    left_join(
      cbind(
        df.W,
        Chronic.Workload
      ) %>%
        mutate(
          Chronic.Workload.Ratio  = round(Acute.Workload / Chronic.Workload, 2)
        ) %>%
        rename(
          "Agudo" = Acute.Workload,
          "Crónico" = Chronic.Workload,
          "ACWR" = Chronic.Workload.Ratio
        ) %>%
        arrange(desc(Semana)),
      df_CED %>%
        filter(
          Categoría_I %in% "Lesión",
          MecanismoGeneral %in% "Mecanismo indirecto"
        ) %>%
        select(
          ID_Diagnóstico,
          FechaDiagnóstico,
          MecanismoGeneral,
          Categoría_I
        ) %>%
        distinct() %>%
        mutate(
          "Semana" = lubridate::week(FechaDiagnóstico)
        ) %>%
        group_by(
          Semana,
          MecanismoGeneral,
          Categoría_I
        ) %>%
        tally() %>%
        as.data.frame(),
      by = "Semana"
    ) %>%
      rename("Frequencia" = n) %>%
      drop_na()
  })
  
  ####  TABLE_5.0.1   ####
  
  Table_tab5.0.1   <- reactive({
    if (input$Player) {
      ## Main DF
      # Grouping and counting
      df_selreport <- 
        df_PD_fil() %>% 
        filter(
          Medición %in% c(
            # For both
            'Calidad del sueño',
            'Minutos de exposición',
            'Nivel de energía',
            'Percepción subjetiva del esfuerzo',
            # Real
            'Peso inicial',
            'T.Q.R',
            'Nivel de energía',
            'Estado general muscular',
            'Humor / Estado de ánimo'
          )
        ) %>% 
        group_by(FechaDimensión, Medición) %>% 
        summarise(
          ValorMedición = mean(ValorMedición) %>% round(1)
        ) %>% 
        spread(
          key = Medición,
          value = ValorMedición,
          fill = 0
        ) %>%
        as.data.frame() %>%
        arrange(desc(FechaDimensión)) %>%
        mutate(
          'Total Wellness' = 
            (`Estado general muscular`+
               `Calidad del sueño`+
               `Humor / Estado de ánimo`+
               `Nivel de energía`),
          'Carga Interna' = 
            (`Percepción subjetiva del esfuerzo` * 
               `Minutos de exposición`) %>% round(1),
          FechaDimensión = FechaDimensión %>% 
            as.character()
        ) %>%
        rename(Fecha = FechaDimensión,
               'Estado de ánimo' = 'Humor / Estado de ánimo',
               PSE = 'Percepción subjetiva del esfuerzo') 
      # Column order
      selected_variables <- c(
        'Fecha',
        'Peso inicial',
        'T.Q.R',
        'Calidad del sueño',
        'Nivel de energía', 
        'Estado general muscular',
        'Estado de ánimo',
        'Total Wellness',
        'PSE',
        'Minutos de exposición',
        'Carga Interna'
      )
      # Filtering
      col_order <- 
        selected_variables[
          selected_variables %in% colnames(df_selreport)
        ]
      # Ordering
      df_selreport <- 
        df_selreport[,col_order]
      
      # ## Mean and SD
      # # Empty vectors
      # mean_row <- c("Promedio")
      # sd_row <- c("Desviación Estandar")
      # # Loop for append
      # for (i in seq(2, ncol(df_selreport))) {
      #   mean_row <- 
      #     mean_row %>% 
      #     append(
      #       df_selreport[,i] %>% mean() %>% round(1)
      #     )
      #   sd_row <- 
      #     sd_row %>% 
      #     append(
      #       df_selreport[,i] %>% sd() %>% round(1)
      #     )
      # }
      # # Merging Results
      # df_selreport_final <- 
      #   df_selreport %>% 
      #   rbind(mean_row) %>% 
      #   rbind(sd_row)
      # # Final DF
      # df_selreport_final
      
      df_selreport
      
    } else {
      ## Main DF
      # Grouping and counting
      df_selreport <- 
        df_PD_fil() %>% 
        filter(
          Medición %in% c(
            # For calculation
            'Dolor muscular',
            'Estado de ánimo',
            # For both
            'Calidad del sueño',
            'Minutos de exposición',
            'Nivel de energía',
            'Percepción subjetiva del esfuerzo',
            # Real
            'Peso inicial',
            'T.Q.R',
            'Nivel de energía',
            'Estado general muscular',
            'Humor / Estado de ánimo'
          )
        ) %>% 
        group_by(FechaDimensión, Medición) %>% 
        summarise(
          ValorMedición = mean(ValorMedición) %>% round(1)
        ) %>% 
        spread(
          key = Medición,
          value = ValorMedición,
          fill = 0
        ) %>%
        as.data.frame() %>%
        arrange(desc(FechaDimensión)) %>%
        mutate(
          'Total Wellness' = 
            (`Estado general muscular`+
               `Calidad del sueño`+
               `Humor / Estado de ánimo`+
               `Nivel de energía`),
          'Carga Interna' = 
            (`Percepción subjetiva del esfuerzo` * 
               `Minutos de exposición`) %>% round(1),
          FechaDimensión = FechaDimensión %>% 
            as.character()
        ) %>%
        rename(Fecha = FechaDimensión,
               'Estado de ánimo' = 'Humor / Estado de ánimo',
               PSE = 'Percepción subjetiva del esfuerzo') 
      # Column order
      selected_variables <- c(
        'Fecha',
        'Peso inicial',
        'T.Q.R',
        'Calidad del sueño',
        'Nivel de energía', 
        'Estado general muscular',
        'Estado de ánimo',
        'Total Wellness',
        'PSE',
        'Minutos de exposición',
        'Carga Interna'
      )
      # Filtering
      col_order <- 
        selected_variables[
          selected_variables %in% colnames(df_selreport)
        ]
      # Ordering
      df_selreport <- 
        df_selreport[,col_order]
      # # Loop for Colnames
      # for (i in seq(2,ncol(df_selreport))) {
      #   colnames(df_selreport)[i] <- paste('Promedio de', colnames(df_selreport)[i])
      # }
      # Final DF
      df_selreport
    }
  })
  
  output$Table_tab5.0.1 <- DT::renderDataTable({
    DT::datatable(
      Table_tab5.0.1(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "350px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) %>%
      formatStyle(
        'Peso inicial',
        background = styleColorBar(Table_tab5.0.1()$`Peso inicial`, 'lightblue'),
        backgroundSize = '100%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      formatStyle(
        'T.Q.R',
        fontWeight = 'bold',
        color = styleInterval(6.9, c('black', 'white')),
        backgroundColor = styleInterval(c(3.9,6.9), c('red', 'yellow','green'))
      ) %>%
      formatStyle(
        'Calidad del sueño',
        fontWeight = 'bold',
        color = styleInterval(3.9, c('black', 'white')),
        backgroundColor = styleInterval(c(2.9,3.9), c('red', 'yellow','green'))
      ) %>%
      formatStyle(
        'Nivel de energía', 
        fontWeight = 'bold',
        color = styleInterval(3.9, c('black', 'white')),
        backgroundColor = styleInterval(c(2.9,3.9), c('red', 'yellow','green'))
      ) %>%
      formatStyle(
        'Estado general muscular',
        fontWeight = 'bold',
        color = styleInterval(3.9, c('black', 'white')),
        backgroundColor = styleInterval(c(2.9,3.9), c('red', 'yellow','green'))
      ) %>%
      formatStyle(
        'Estado de ánimo',
        fontWeight = 'bold',
        color = styleInterval(3.9, c('black', 'white')),
        backgroundColor = styleInterval(c(2.9,3.9), c('red', 'yellow','green'))
      ) %>%
      formatStyle(
        'Total Wellness',
        fontWeight = 'bold',
        color = styleInterval(14.9, c('black', 'white')),
        backgroundColor = styleInterval(c(9.9,14.9), c('red', 'yellow','green'))
      ) %>%
      formatStyle(
        'PSE',
        fontWeight = 'bold',
        color = styleInterval(7.9, c('black', 'white')),
        backgroundColor = styleInterval(c(3.9,7.9), c('green', 'yellow','red'))
      ) %>%
      formatStyle(
        'Minutos de exposición',
        background = styleColorBar(Table_tab5.0.1()$`Minutos de exposición`, 'lightblue'),
        backgroundSize = '100%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      formatStyle(
        'Carga Interna',
        background = styleColorBar(Table_tab5.0.1()$`Carga Interna`, 'lightblue'),
        backgroundSize = '100%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      )
  })
  output$download_Table_tab5.0.1.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla General de Autoreporte del Jugador ", input$PlayerInput,
          " del ", input$CategoryInput,
          ".xlsx",
          sep = ""
        )
      } else {
        paste(
          "Tabla General de Promedios de Autoreporte del ", input$CategoryInput,
          ".xlsx",
          sep = ""
        )
      }
    },
    content = function(file) {
      write.xlsx(Table_tab5.0.1(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab5.0.1.csv <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla General de Autoreporte del Jugador ", input$PlayerInput,
          " del ", input$CategoryInput,
          ".csv",
          sep = ""
        )
      } else {
        paste(
          "Tabla General de Promedios de Autoreporte del ", input$CategoryInput,
          ".csv",
          sep = ""
        )
      }
    },
    content = function(file) {
      write.csv(Table_tab5.0.1(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab5.0.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Table_tab5.0.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab5.0.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab5.0.1_Modal,{
    removeModal()
  })
  
  ####  TAB_5.0 ####
  output$Plot_tab5.0 <- renderPlotly({
    filtered <- 
      df.tab5.0_PD() %>%
      arrange(
        FechaDimensión
      ) %>%
      mutate(
        FechaDimensión = format(FechaDimensión, "%Y-%m-%d") 
      )
    max_date <- 
      ((df.tab5.0_PD() %>% 
          pull(FechaDimensión) %>% 
          max()) + 1) %>% 
      format("%m-%d") 
    
    # Visualization
    if ( filtered %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('Autoreporte')
      )
      
    } else {
      
      # Defining Values
      filtered$FechaDimensión <-
        factor(
          filtered$FechaDimensión,
          unique(filtered$FechaDimensión)
        )
      
      # Visualization
      plot_ly() %>%
        add_trace(
          type = 'bar',
          x = filtered$FechaDimensión,
          y = filtered$TotalWellness,
          color = I("#2089E0E2"),
          name = 'Total Wellness',
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          )
        ) %>%
        add_trace(
          type = 'scatter',
          x = filtered$FechaDimensión,
          y = filtered$CargaInterna,
          color = I("#EB1C15"),
          marker = list(
            size = 8,
            line = list(width = line_with_point, 
                        color = 'rgb(0, 0, 0)')
          ),
          line = list(
            width = 4
          ),
          yaxis = "y2",
          name = "Carga Interna"
        ) %>%
        add_trace(
          type = 'scatter',
          x = filtered$FechaDimensión %>% as.character(),
          y = filtered$`T.Q.R`,
          color = I("#66CC66"),
          marker = list(
            size = 8,
            line = list(width = line_with_point, 
                        color = 'rgb(0, 0, 0)')
          ),
          line = list(
            width = 4
          ),
          name = "T.Q.R"
        ) %>%
        add_trace(
          type = 'bar',
          x = "Promedio CI",
          y = filtered$CargaInterna %>% mean() %>% round(1),
          color = I("#EB1C15"),
          name = 'Promedio CI',
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          ),
          yaxis = "y2"
        ) %>%
        layout(
          hovermode = 'compare',
          legend = list(
            y = 1.02,
            x = 1.07,
            title = list(text = paste("<b>",input$PlayerInput_tab5,"<b><br>"))
          ),
          #xaxis= list(showticklabels = FALSE),
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
                "Total Wellness y Carga Interna del Jugador ", input$PlayerInput_tab5,
                sep = ""
              ),
            scale = 3
          )
        ) 
    }
  })
  observeEvent(input$Plot_tab5.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Plot_tab5.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab5.0_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab5.0_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab5.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Input_tab5.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab5.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab5.0_Modal,{
    removeModal()
  })
  
  ####  TABLE_5.0   ####
  
  Table_tab5.0   <- reactive({
    df.tab5.0_PD() %>%
      mutate(
        Zscore_Wellness = ( 
          (TotalWellness - mean(TotalWellness)) / sd(TotalWellness) 
        ) %>% round(2),
        Zscore_Carga = ( 
          (CargaInterna - mean(CargaInterna)) / sd(CargaInterna) 
        ) %>% round(2)
      ) %>%
      mutate(
        "TotalWellness (Zscore)" = paste(TotalWellness," (",Zscore_Wellness,")", sep = ""),
        "CargaInterna (Zscore)" = paste(CargaInterna," (",Zscore_Carga,")", sep = "")
      ) %>%
      select(
        "Fecha Mediciones" = FechaDimensión,
        "TotalWellness (Zscore)",
        "CargaInterna (Zscore)"
      )
  })
  
  output$Table_tab5.0 <- DT::renderDataTable({
    DT::datatable(
      Table_tab5.0(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "280px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_tab5.0.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Total Wellness y Carga Interna del Jugador ", input$PlayerInput_tab5,
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(Table_tab5.0(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab5.0.csv <- downloadHandler(
    filename = function() {
      paste(
        "Total Wellness y Carga Interna del Jugador ", input$PlayerInput_tab5,
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(Table_tab5.0(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab5.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Table_tab5.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab5.0_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab5.0_Modal,{
    removeModal()
  })
  
  ####  TAB_5.1 ####
  output$Plot_tab5.1 <- renderPlotly({
    
    # DF
    filtered <- 
      df.tab5.1_PD() %>% 
      filter(
        FechaDimensión == input$time_tab5.1
      ) %>% distinct()
    
    # Visualization
    if ( filtered %>% nrow() == 0 ) { 
      
      emptyChart(
        emptyMessage('Autoreporte')      
      )
      
    } else {
      
      # Defining Values
      filtered$Jugador <- 
        factor(
          filtered$Jugador,  
          unique(filtered$Jugador)
        )
      
      # Visualization
      plot_ly() %>%
        add_trace(
          type = 'bar',
          x = filtered$Jugador,
          y = filtered$TotalWellness,
          color = I("#2089E0E2"),
          name = 'Total Wellness',
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          )
        ) %>%
        add_trace(
          type = 'scatter',
          x = filtered$Jugador,
          y = filtered$CargaInterna,
          color = I("#EB1C15"),
          marker = list(
            size = 8,
            line = list(width = line_with_point, 
                        color = 'rgb(0, 0, 0)')
          ),
          line = list(
            width = 4
          ),
          yaxis = "y2",
          name = "Carga Interna"
        ) %>%
        add_trace(
          type = 'scatter',
          x = filtered$Jugador,
          y = filtered$`T.Q.R`,
          color = I("#66CC66"),
          marker = list(
            size = 8,
            line = list(width = line_with_point, 
                        color = 'rgb(0, 0, 0)')
          ),
          line = list(
            width = 4
          ),
          name = "T.Q.R"
        ) %>%
        add_trace(
          type = 'bar',
          x = "_Promedio CI",
          y = filtered$CargaInterna %>% mean() %>% round(1),
          color = I("#EB1C15"),
          name = 'Promedio CI',
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          ),
          xaxis = "",
          yaxis = "y2"
        ) %>%
        layout(
          hovermode = 'compare',
          legend = list(
            orientation = 'h',
            y = 1.25, 
            x = 0.01,
            title = list(text = paste("<b>",input$time_tab5.1,"<b><br>"))
          ),
          margin = list(
            l = 20,
            r = 40,
            b = 20,
            t = 20,
            pad = 0
          ),
          #xaxis= list(showticklabels = FALSE),
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
                "Total Wellness y Carga Interna del ", input$CategoryInput,
                " en la fecha ", input$time_tab5.1,
                sep = ""
              ),
            scale = 3
          )
        )
      
    }
    
  })
  observeEvent(input$Plot_tab5.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Plot_tab5.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab5.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab5.1_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab5.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Input_tab5.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab5.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab5.1_Modal,{
    removeModal()
  })
  
  Table_tab1.3.1  <- reactive({
    df.tab1.3.0_PD() %>%
      mutate(
        Zscore_Wellness = ( 
          (TotalWellness - mean(TotalWellness)) / sd(TotalWellness) 
        ) %>% round(2),
        Zscore_Carga = ( 
          (CargaInterna - mean(CargaInterna)) / sd(CargaInterna) 
        ) %>% round(2)
      ) %>%
      mutate(
        "TotalWellness (Zscore)" = paste(TotalWellness," (",Zscore_Wellness,")", sep = ""),
        "CargaInterna (Zscore)" = paste(CargaInterna," (",Zscore_Carga,")", sep = "")
      ) %>%
      select(
        "Fecha Mediciones" = FechaDimensión,
        "TotalWellness (Zscore)",
        "CargaInterna (Zscore)"
      )
  })
  
  ####  TABLE_5.1  ####
  
  Table_tab5.1  <- reactive({
    df.tab5.1_PD() %>%
      mutate(
        Zscore_Wellness = ( 
          (TotalWellness - mean(TotalWellness)) / sd(TotalWellness) 
        ) %>% round(2),
        Zscore_Carga = ( 
          (CargaInterna - mean(CargaInterna)) / sd(CargaInterna) 
        ) %>% round(2)
      ) %>%
      mutate(
        "TotalWellness (Zscore)" = paste(TotalWellness," (",Zscore_Wellness,")", sep = ""),
        "CargaInterna (Zscore)" = paste(CargaInterna," (",Zscore_Carga,")", sep = "")
      ) %>%
      select(
        "Jugador",
        "Fecha" = FechaDimensión,
        "TotalWellness (Zscore)",
        "CargaInterna (Zscore)"
      ) %>% 
      filter(
        Fecha == input$time_tab5.1
      ) 
  })
  
  output$Table_tab5.1 <- DT::renderDataTable({
    DT::datatable(
      Table_tab5.1(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "320px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_tab5.1.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Total Wellness y Carga Interna del ", input$CategoryInput,
        " en la fecha ", input$time_tab5.1,
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(Table_tab5.1(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab5.1.csv <- downloadHandler(
    filename = function() {
      paste(
        "Total Wellness y Carga Interna del ", input$CategoryInput,
        " en la fecha ", input$time_tab5.1,
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(Table_tab5.1(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab5.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Table_tab5.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab5.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab5.1_Modal,{
    removeModal()
  })
  
  ####  TAB_5.2  ####
  output$Plot_tab5.2 <- renderPlotly({
    
    # Visualization
    if ( 
      df_MP() %>% nrow() == 0 ||
      lubridate::week(df_MP()$FechaDimensión) < 5 
    ) { 
      
      emptyChart(
        emptyMessage('Autoreporte')      
      )
      
    } else {
      
      # Selecting Rows
      filtered <-
        df.tab5.2_PD() %>%
        arrange(desc(Semana)) %>%
        slice(1:8)
      
      # Visualization
      plot_ly() %>%
        add_trace(
          type = 'bar',
          x = filtered$Semana,
          y = filtered$Agudo,
          color = I("#2089E0E2"),
          name = "Agudo",
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          )
        ) %>%
        add_trace(
          type = 'bar',
          x = filtered$Semana,
          y = filtered$Crónico,
          color = I("#1DDE64D1"),
          name = "Crónico",
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          )
        ) %>%
        add_trace(
          type = 'scatter',
          x = filtered$Semana,
          y = filtered$ACWR,
          color = I("#FF0900DF"),
          marker = list(
            size = 8,
            line = list(width = line_with_point, 
                        color = 'rgb(0, 0, 0)')
          ),
          line = list(
            width = 4
          ),
          yaxis = "y2",
          name = "ACWR"
        ) %>%
        layout(
          hovermode = 'compare',
          legend = list(
            x = 1.02
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
            scale = 3
          )
        ) 
    }
  })
  observeEvent(input$Plot_tab5.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Plot_tab5.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab5.2_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab5.2_Modal,{
    removeModal()
  })
  observeEvent(input$Input_tab5.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Input_tab5.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Input_tab5.2_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Input_tab5.2_Modal,{
    removeModal()
  })
  
  ####  TABLE_5.2  ####
  
  Table_tab5.2  <- reactive({
    
    if ( df_MP() %>% nrow() == 0 ) {
      
      df_MP()
      
    } else {
      
      DF <- df.tab5.2_PD()
      DF[is.na(DF)] <- 0
      DF %>%
        mutate(
          "Agudo (Zscore)" = paste(Agudo," (",Zscore,")", sep = ""),
          .before = "Crónico"
        ) %>%
        select(-c(Agudo,Zscore))
      
    }
    
  })
  
  output$Table_tab5.2 <- DT::renderDataTable({
    DT::datatable(
      Table_tab5.2(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "300px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_tab5.2.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Promedios de ", input$TypeMetInput_tap1.3,
        " del ", input$CategoryInput,
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(Table_tab5.2(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab5.2.csv <- downloadHandler(
    filename = function() {
      paste(
        "Promedios de ", input$TypeMetInput_tap1.3,
        " del ", input$CategoryInput,
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(Table_tab5.2(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab5.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Table_tab5.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab5.2_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab5.2_Modal,{
    removeModal()
  })
  
  
  ####  TAB_5.3  ####
  output$Plot_tab5.3 <- renderPlotly({
    ggplotly(
      ggplot(df.tab5.3_PD(), aes(x=ACWR, y=Frequencia, group=1)) +
        stat_smooth(color="#FC4E07", fill="#FC4E07",
                    size=.6, alpha=0.1,
                    method="loess", formula = y~I(x^2)) +
        geom_point(size=1.5) +
        annotate(geom="rect", alpha=.05, 
                 fill="black", color="black",
                 xmin=max(df.tab5.3_PD()$ACWR)*.1,
                 xmax=max(df.tab5.3_PD()$ACWR)*.4,
                 ymin=max(df.tab5.3_PD()$Frequencia)*.8,
                 ymax=max(df.tab5.3_PD()$Frequencia)*1.6) +
        labs(x=NULL, y=NULL, colour=NULL, fill=NULL) +
        theme(panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA))
    ) %>%
      add_annotations(
        x=max(df.tab5.3_PD()$ACWR)*.25,
        y=max(df.tab5.3_PD()$Frequencia)*1.4,
        text=paste("Correlación: ",
                   cor(df.tab5.3_PD()$ACWR,df.tab5.3_PD()$Frequencia,
                       use="complete.obs") %>% round(4)),
        showarrow=FALSE
      ) %>%
      add_annotations(
        x=max(df.tab5.3_PD()$ACWR)*.25,
        y=max(df.tab5.3_PD()$Frequencia)*1,
        text=paste("P valor: ",
                   cor.test(df.tab5.3_PD()$ACWR,
                            df.tab5.3_PD()$Frequencia)$p.value %>% round(4)),
        showarrow=FALSE
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
              "Gráfica de Lesiones por Contacto Indirecto según ACWR",
              sep = ""
            ),
          scale = 3
        )
      )
  })
  observeEvent(input$Plot_tab5.3_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Plot_tab5.3_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab5.3_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab5.3_Modal,{
    removeModal()
  })
  
  ####  TABLE_5.3  ####
  output$Table_tab5.3 <- DT::renderDataTable({
    DT::datatable(
      df.tab5.3_PD() %>% select(c(ACWR, Frequencia)) %>% arrange(ACWR),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs=list(list(className="dt-center", targets="_all"))
      )
    )
  })
  output$download_Table_tab5.3.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Tabla de Lesiones por Contacto Indirecto según ACWR",
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(df.tab5.3_PD(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab5.3.csv <- downloadHandler(
    filename = function() {
      paste(
        "Tabla de Lesiones por Contacto Indirecto según ACWR",
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(df.tab5.3_PD(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab5.3_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_5/Table_tab5.3_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab5.3_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab5.3_Modal,{
    removeModal()
  })
  
  #### --------------------------- TAB_6 --------------------------- #### 
  
  ####  DF_6  #### 
  
  df.tab6_N  <- reactive({
    df_PD_fil() %>% 
      filter(
        Dimensión %in% "Nutrición"
      ) %>%
      select(
        Jugador,
        FechaDimensión,
        TipoMedición,
        Medición,
        ValorMedición
      ) %>%
      mutate(
        FechaDimensión = FechaDimensión %>% format("%y-%m") # "%Y-%m"
      ) %>% 
      distinct()
  })
  
  df.tab6_G <- reactive({
    df_PD_CAT() %>%  
      filter(
        Dimensión %in% "Nutrición"
      ) %>%
      select(
        Jugador,
        FechaDimensión,
        TipoMedición,
        Medición,
        ValorMedición
      ) %>%
      mutate(
        FechaDimensión = FechaDimensión %>% format("%y-%m") # "%Y-%m"
      ) %>% 
      distinct()
  })
  
  df.tab6_G_T <- reactive({
    
    df_PD_CAT_T() %>%  
      filter(
        Dimensión %in% "Nutrición"
      ) %>%
      select(
        Jugador,
        FechaDimensión,
        TipoMedición,
        Medición,
        ValorMedición
      ) %>%
      mutate(
        FechaDimensión = FechaDimensión %>% format("%y-%m") # "%Y-%m"
      ) %>% 
      distinct()
    
  })
  
  ####  UI  ####
  
  levelsDate_tab6 <- reactive({
    df.tab6_G() %>% 
      pull(FechaDimensión) %>% 
      unique()
  })
  output$uiTab6.1 <- renderUI({
    selectInput(
      inputId = 'cInput_tab6.1',
      label = 'Año-Mes:',
      choices = levelsDate_tab6()
    )
  })
  
  levelsMeasureType_tab6 <- reactive({
    df.tab6_G() %>% 
      filter(FechaDimensión %in% input$cInput_tab6.1) %>%
      pull(TipoMedición) %>%
      unique()
  })
  output$uiTab6.2 <- renderUI({
    selectInput(
      inputId = 'cInput_tab6.2',
      label = 'Tipo:',
      choices = levelsMeasureType_tab6()
    )
  })
  
  levelsMeasure_tab6 <- reactive({
    df.tab6_G() %>% 
      filter(TipoMedición %in% input$cInput_tab6.2) %>%
      pull(Medición) %>%
      unique() 
  })
  output$uiTab6.3 <- renderUI({
    selectInput(
      inputId = 'cInput_tab6.3',
      label = 'Medición:',
      choices = levelsMeasure_tab6()
    )
  })
  
  ####  TAB_6.1  #### 
  output$Plot_tab6.1 <- renderPlotly({
    
    if (input$Player) {
      
      # Data
      main_df <- 
        df.tab6_N() %>% 
        filter(
          TipoMedición %in% "Masa Grasa",  
          Medición %in% "Porcentaje"
        ) %>%
        as.data.frame() %>%
        mutate(
          Group = "Jugador"
        ) %>%
        select(!c("Jugador","TipoMedición","Medición"))
      # Date
      month_values <- 
        main_df %>% 
        pull(FechaDimensión) %>% 
        unique()
      # Filtered
      filtered <- 
        rbind(
          main_df,
          df.tab6_G() %>% 
            filter(
              FechaDimensión %in% month_values,
              TipoMedición %in% "Masa Grasa", 
              Medición %in% "Porcentaje"
            ) %>% 
            group_by(FechaDimensión) %>%
            summarise(ValorMedición = mean(ValorMedición) %>% round(1)) %>%
            as.data.frame() %>%
            mutate(
              Group = "Promedio"
            )
        ) %>%
        spread(
          key = Group,
          value = ValorMedición
        )
      
      # Visualization
      if ( filtered %>% nrow() == 0 ) {  
        
        emptyChart(
          emptyMessage('Masa Grasa')      
        )
        
      } else {
        
        # Visualization
        plot_ly(
          filtered,
          x = filtered$FechaDimensión
        ) %>% 
          add_trace(
            name = "Jugador",
            y = filtered$Jugador,
            color = I("#1348C2"),
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          add_trace(
            name = "Promedio <br> Plantel",
            y = filtered$Promedio,    
            color = I("#FF0000"),
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          layout(
            # barmode = 'group',
            hovermode = "x",
            title= list(
              text = paste("<b>",input$PlayerInput,"<b>"),
              font = list(size = 12),
              x = 0.12, y = 0.97
            ),
            legend = list(
              orientation = "h",
              xanchor = "center",  
              x = 0.5,
              y = -0.3,
              title = list(text="<b></b>")
            ),
            yaxis = list(
              title = ""
            ),
            xaxis = list(
              title = "",
              #showticklabels = FALSE
              tickfont = list(color = '#000000',
                              size = 8),
              autotick = FALSE,
              ticks = "outside",
              tick0 = 0,
              dtick = 0.5,
              ticklen = 8,
              tickwidth = 1.4,
              tickcolor = toRGB("black")
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
                if (input$Player) {
                  paste(
                    "Valores de Porcentaje Masa Grasa de ", input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Valores Promedio de Porcentaje Masa Grasa del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
      }
      
    } else {
      
      # DF
      filtered <- 
        df.tab6_N() %>% 
        filter(
          TipoMedición %in% "Masa Grasa", 
          Medición %in% "Porcentaje"
        ) %>% 
        group_by(FechaDimensión) %>%
        summarise(ValorMedición = mean(ValorMedición) %>% round(1)) %>%
        as.data.frame()
      
      # Visualization
      if ( filtered %>% nrow() == 0 ) {  
        
        emptyChart(
          emptyMessage('Masa Grasa')      
        )
        
      } else {
        plot_ly( 
          filtered,
          x = ~FechaDimensión
        ) %>% 
          add_trace(
            name = 'Masa Grasa',
            color = I("#1348C2"), 
            y = ~ValorMedición,
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          layout(
            # barmode = 'group',
            hovermode = "x",
            title= list(
              text = "<b>Promedio Plantel<b>",
              font = list(size = 12),
              x = 0.12, y = 0.97
            ),
            legend = list(
              title = list(text="<b>Mes</b>"),
              x = 100, y = 1
            ),
            yaxis = list(
              title = ""
            ),
            xaxis = list(
              title = "",
              #showticklabels = FALSE
              tickfont = list(color = '#000000',
                              size = 8),
              autotick = FALSE,
              ticks = "outside",
              tick0 = 0,
              dtick = 0.5,
              ticklen = 8,
              tickwidth = 1.4,
              tickcolor = toRGB("black")
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
                if (input$Player) {
                  paste(
                    "Valores de Porcentaje Masa Grasa de ", input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Valores Promedio de Porcentaje Masa Grasa del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
      }
    }
    
    
  }) 
  
  ####  TAB_6.2  #### 
  output$Plot_tab6.2 <- renderPlotly({
    
    if (input$Player) {
      
      # Data
      main_df <- 
        df.tab6_N() %>% 
        filter(
          TipoMedición %in% "Masa Muscular",  
          Medición %in% "Porcentaje"
        ) %>%
        as.data.frame() %>%
        mutate(
          Group = "Jugador"
        ) %>%
        select(!c("Jugador","TipoMedición","Medición"))
      # Date
      month_values <- 
        main_df %>% 
        pull(FechaDimensión) %>% 
        unique()
      # Filtered
      filtered <- 
        rbind(
          main_df,
          df.tab6_G() %>% 
            filter(
              FechaDimensión %in% month_values,
              TipoMedición %in% "Masa Muscular", 
              Medición %in% "Porcentaje"
            ) %>% 
            group_by(FechaDimensión) %>%
            summarise(ValorMedición = mean(ValorMedición) %>% round(1)) %>%
            as.data.frame() %>%
            mutate(
              Group = "Promedio"
            )
        ) %>%
        spread(
          key = Group,
          value = ValorMedición
        )
      
      # Visualization
      if ( filtered %>% nrow() == 0 ) {  
        
        emptyChart(
          emptyMessage('Masa Muscular')      
        )
        
      } else {
        
        # Visualization
        plot_ly(
          filtered,
          x = filtered$FechaDimensión
        ) %>% 
          add_trace(
            name = "Jugador",
            y = filtered$Jugador,
            color = I("#179EB3"), 
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          add_trace(
            name = "Promedio <br> Plantel",
            y = filtered$Promedio,    
            color = I("#FF0000"),
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          layout(
            # barmode = 'group',
            hovermode = "x",
            title= list(
              text = paste("<b>",input$PlayerInput,"<b>"),
              font = list(size = 12),
              x = 0.12, y = 0.97
            ),
            legend = list(
              orientation = "h",
              xanchor = "center",  
              x = 0.5,
              y = -0.3,
              title = list(text="<b></b>")
            ),
            yaxis = list(
              title = ""
            ),
            xaxis = list(
              title = "",
              #showticklabels = FALSE
              tickfont = list(color = '#000000',
                              size = 8),
              autotick = FALSE,
              ticks = "outside",
              tick0 = 0,
              dtick = 0.5,
              ticklen = 8,
              tickwidth = 1.4,
              tickcolor = toRGB("black")
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
                if (input$Player) {
                  paste(
                    "Valores de Porcentaje Masa Muscular de ", input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Valores Promedio de Porcentaje Masa Muscular del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
      }
      
    } else {
      
      # DF
      filtered <- 
        df.tab6_N() %>% 
        filter(
          TipoMedición %in% "Masa Muscular", 
          Medición %in% "Porcentaje"
        ) %>% 
        group_by(FechaDimensión) %>%
        summarise(ValorMedición = mean(ValorMedición) %>% round(1)) %>%
        as.data.frame()
      
      # Visualization
      if ( filtered %>% nrow() == 0 ) {  
        
        emptyChart(
          emptyMessage('Masa Muscular')      
        )
        
      } else {
        plot_ly( 
          filtered,
          x = ~FechaDimensión
        ) %>% 
          add_trace(
            name = 'Masa Muscular',
            color = I("#179EB3"), 
            y = ~ValorMedición,
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          layout(
            # barmode = 'group',
            hovermode = "x",
            title= list(
              text = "<b>Promedio Plantel<b>",
              font = list(size = 12),
              x = 0.12, y = 0.97
            ),
            legend = list(
              title = list(text="<b>Mes</b>"),
              x = 100, y = 1
            ),
            yaxis = list(
              title = ""
            ),
            xaxis = list(
              title = "",
              #showticklabels = FALSE
              tickfont = list(color = '#000000',
                              size = 8),
              autotick = FALSE,
              ticks = "outside",
              tick0 = 0,
              dtick = 0.5,
              ticklen = 8,
              tickwidth = 1.4,
              tickcolor = toRGB("black")
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
                if (input$Player) {
                  paste(
                    "Valores de Porcentaje Masa Muscular de ", input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Valores Promedio de Porcentaje Masa Muscular del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
      }
    }
  }) 
  
  ####  TAB_6.3  #### 
  output$Plot_tab6.3 <- renderPlotly({
    
    if (input$Player) {
      
      # Data
      main_df <- 
        df.tab6_N() %>% 
        filter( 
          Medición %in% "Sumatoria de 6 Pliegues"
        ) %>%
        as.data.frame() %>%
        mutate(
          Group = "Jugador"
        ) %>%
        select(!c("Jugador","TipoMedición","Medición"))
      # Date
      month_values <- 
        main_df %>% 
        pull(FechaDimensión) %>% 
        unique()
      # Filtered
      filtered <- 
        rbind(
          main_df,
          df.tab6_G() %>% 
            filter(
              FechaDimensión %in% month_values,
              Medición %in% "Sumatoria de 6 Pliegues"
            ) %>% 
            group_by(FechaDimensión) %>%
            summarise(ValorMedición = mean(ValorMedición) %>% round(1)) %>%
            as.data.frame() %>%
            mutate(
              Group = "Promedio"
            )
        ) %>%
        spread(
          key = Group,
          value = ValorMedición
        )
      
      # Visualization
      if ( filtered %>% nrow() == 0 ) {  
        
        emptyChart(
          emptyMessage('Sumatoria 6 Pliegues')      
        )
        
      } else {
        
        # Visualization
        plot_ly(
          filtered,
          x = filtered$FechaDimensión
        ) %>% 
          add_trace(
            name = "Jugador",
            y = filtered$Jugador,
            color = I("#10B534"), 
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          add_trace(
            name = "Promedio <br> Plantel",
            y = filtered$Promedio,    
            color = I("#FF0000"),
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          layout(
            # barmode = 'group',
            hovermode = "x",
            title= list(
              text = paste("<b>",input$PlayerInput,"<b>"),
              font = list(size = 12),
              x = 0.12, y = 0.97
            ),
            legend = list(
              orientation = "h",
              xanchor = "center",  
              x = 0.5,
              y = -0.3,
              title = list(text="<b></b>")
            ),
            yaxis = list(
              title = ""
            ),
            xaxis = list(
              title = "",
              #showticklabels = FALSE
              tickfont = list(color = '#000000',
                              size = 8),
              autotick = FALSE,
              ticks = "outside",
              tick0 = 0,
              dtick = 0.5,
              ticklen = 8,
              tickwidth = 1.4,
              tickcolor = toRGB("black")
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
                if (input$Player) {
                  paste(
                    "Valores de Sumatoria de 6 Pliegues de ", input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Valores Promedio de Sumatoria de 6 Pliegues del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
      }
      
    } else {
      
      # DF
      filtered <- 
        df.tab6_N() %>% 
        filter(
          Medición %in% "Sumatoria de 6 Pliegues"
        ) %>% 
        group_by(FechaDimensión) %>%
        summarise(ValorMedición = mean(ValorMedición) %>% round(1)) %>%
        as.data.frame()
      
      # Visualization
      if ( filtered %>% nrow() == 0 ) {  
        
        emptyChart(
          emptyMessage('Sumatoria 6 Pliegues')      
        )
        
      } else {
        plot_ly( 
          filtered,
          x = ~FechaDimensión
        ) %>% 
          add_trace(
            name = 'Sumatoria de 6 Pliegues',
            color = I("#10B534"), 
            y = ~ValorMedición,
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          layout(
            # barmode = 'group',
            hovermode = "x",
            title= list(
              text = "<b>Promedio Plantel<b>",
              font = list(size = 12),
              x = 0.12, y = 0.97
            ),
            legend = list(
              title = list(text="<b>Mes</b>"),
              x = 100, y = 1
            ),
            yaxis = list(
              title = ""
            ),
            xaxis = list(
              title = "",
              #showticklabels = FALSE
              tickfont = list(color = '#000000',
                              size = 8),
              autotick = FALSE,
              ticks = "outside",
              tick0 = 0,
              dtick = 0.5,
              ticklen = 8,
              tickwidth = 1.4,
              tickcolor = toRGB("black")
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
                if (input$Player) {
                  paste(
                    "Valores de Sumatoria de 6 Pliegues de ", input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Valores Promedio de Sumatoria de 6 Pliegues del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
      }
    }
    
  }) 
  
  ####  TAB_6.4  #### 
  output$Plot_tab6.4 <- renderPlotly({
    
    if (input$Player) {
      
      # Data
      main_df <- 
        df.tab6_N() %>% 
        filter( 
          Medición %in% "Peso actual"
        ) %>%
        as.data.frame() %>%
        mutate(
          Group = "Jugador"
        ) %>%
        select(!c("Jugador","TipoMedición","Medición"))
      # Date
      month_values <- 
        main_df %>% 
        pull(FechaDimensión) %>% 
        unique()
      # Filtered
      filtered <- 
        rbind(
          main_df,
          df.tab6_G() %>% 
            filter(
              FechaDimensión %in% month_values,
              Medición %in% "Sumatoria de 6 Pliegues"
            ) %>% 
            group_by(FechaDimensión) %>%
            summarise(ValorMedición = mean(ValorMedición) %>% round(1)) %>%
            as.data.frame() %>%
            mutate(
              Group = "Promedio"
            )
        ) %>%
        spread(
          key = Group,
          value = ValorMedición
        )
      
      # Visualization
      if ( filtered %>% nrow() == 0 ) {  
        
        emptyChart(
          emptyMessage('Peso Actual')      
        )
        
      } else {
        
        # Visualization
        plot_ly(
          filtered,
          x = filtered$FechaDimensión
        ) %>% 
          add_trace(
            name = "Jugador",
            y = filtered$Jugador,
            color = I("#C916C0"), 
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          add_trace(
            name = "Promedio <br> Plantel",
            y = filtered$Promedio,    
            color = I("#FF0000"),
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          layout(
            # barmode = 'group',
            hovermode = "x",
            title= list(
              text = paste("<b>",input$PlayerInput,"<b>"),
              font = list(size = 12),
              x = 0.12, y = 0.97
            ),
            legend = list(
              orientation = "h",
              xanchor = "center",  
              x = 0.5,
              y = -0.3,
              title = list(text="<b></b>")
            ),
            yaxis = list(
              title = ""
            ),
            xaxis = list(
              title = "",
              #showticklabels = FALSE
              tickfont = list(color = '#000000',
                              size = 8),
              autotick = FALSE,
              ticks = "outside",
              tick0 = 0,
              dtick = 0.5,
              ticklen = 8,
              tickwidth = 1.4,
              tickcolor = toRGB("black")
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
                if (input$Player) {
                  paste(
                    "Valores de Peso actual de ", input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Valores Promedio de Peso actual del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
      }
      
    } else {
      
      # DF
      filtered <- 
        df.tab6_N() %>% 
        filter(
          Medición %in% "Peso actual"
        ) %>% 
        group_by(FechaDimensión) %>%
        summarise(ValorMedición = mean(ValorMedición) %>% round(1)) %>%
        as.data.frame()
      
      # Visualization
      if ( filtered %>% nrow() == 0 ) {  
        
        emptyChart(
          emptyMessage('Peso Actual')      
        )
        
      } else {
        plot_ly( 
          filtered,
          x = ~FechaDimensión
        ) %>% 
          add_trace(
            name = 'Peso actual',
            color = I("#C916C0"), 
            y = ~ValorMedición,
            type = 'scatter', 
            mode = 'lines+markers',
            line = list(simplyfy = F),
            marker = list(
              line = list(width = 1.2, 
                          color = 'rgb(0, 0, 0)')
            )
          ) %>% 
          layout(
            # barmode = 'group',
            hovermode = "x",
            title= list(
              text = "<b>Promedio Plantel<b>",
              font = list(size = 12),
              x = 0.12, y = 0.97
            ),
            legend = list(
              title = list(text="<b>Mes</b>"),
              x = 100, y = 1
            ),
            yaxis = list(
              title = ""
            ),
            xaxis = list(
              title = "",
              #showticklabels = FALSE
              tickfont = list(color = '#000000',
                              size = 8),
              autotick = FALSE,
              ticks = "outside",
              tick0 = 0,
              dtick = 0.5,
              ticklen = 8,
              tickwidth = 1.4,
              tickcolor = toRGB("black")
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
                if (input$Player) {
                  paste(
                    "Valores de Peso actual de ", input$PlayerInput,
                    " del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                } else {
                  paste(
                    "Valores Promedio de Peso actual del ", input$CategoryInput, 
                    " con rango de fecha desde ", input$timeFromInput, 
                    " hasta ", input$timeToInput,
                    sep = ""
                  )
                },
              scale = 3
            )
          ) 
      }
    }
  }) 
  
  ####  TABLE_6.0  ####
  
  Table_tab6.0  <- reactive({
    
    # Building Main DF
    join_df <- 
      left_join(
        df.tab6_G_T(),
        df_CED %>% select(Jugador,Posición) %>% unique(),
        by = "Jugador"
      )
    
    # Merging All Variables
    join_df %>%
      filter(
        Medición %in% "Sumatoria de 6 Pliegues"
      ) %>%
      group_by(Posición) %>%
      summarise(
        Mean = mean(ValorMedición) %>% round(1),
        SD = sd(ValorMedición) %>% round(1)
      ) %>% 
      as.data.frame() %>%
      mutate(
        "Sumatoria de 6 Pliegues (X/D.E)" = paste(Mean,"+-",SD)
      ) %>%
      select(!c(Mean,SD)) %>%
      # First Join
      left_join(
        join_df %>%
          filter(
            Medición %in% "Peso actual"
          ) %>%
          group_by(Posición) %>%
          summarise(
            Mean = mean(ValorMedición) %>% round(1),
            SD = sd(ValorMedición) %>% round(1)
          ) %>% 
          as.data.frame() %>%
          mutate(
            "Peso actual (X/D.E)" = paste(Mean,"+-",SD)
          ) %>%
          select(!c(Mean,SD)),
        by = "Posición"
      ) %>%
      # Second Join
      left_join(
        join_df %>%
          filter(
            TipoMedición %in% "Masa Grasa",  
            Medición %in% "Porcentaje"
          ) %>%
          group_by(Posición) %>%
          summarise(
            Mean = mean(ValorMedición) %>% round(1),
            SD = sd(ValorMedición) %>% round(1)
          ) %>% 
          as.data.frame() %>%
          mutate(
            "Porcentaje Masa Grasa (X/D.E)" = paste(Mean,"+-",SD)
          ) %>%
          select(!c(Mean,SD)),
        by = "Posición"
      ) %>%
      # Third Join
      left_join(
        join_df %>%
          filter(
            TipoMedición %in% "Masa Muscular",  
            Medición %in% "Porcentaje"
          ) %>%
          group_by(Posición) %>%
          summarise(
            Mean = mean(ValorMedición) %>% round(1),
            SD = sd(ValorMedición) %>% round(1)
          ) %>% 
          as.data.frame() %>%
          mutate(
            "Porcentaje Masa Muscular (X/D.E)" = paste(Mean,"+-",SD)
          ) %>%
          select(!c(Mean,SD)),
        by = "Posición"
      )
    
  })
  
  output$Table_tab6.0 <- DT::renderDataTable({
    DT::datatable(
      Table_tab6.0(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', 
        scrollY = "250px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_tab6.0.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Tabla de Nutrición según Posición del ", input$CategoryInput,
        " con rango de fecha desde ", input$timeFromInput, 
        " hasta ", input$timeToInput,
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(Table_tab6.0(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab6.0.csv <- downloadHandler(
    filename = function() {
      paste(
        "Tabla de Nutrición según Posición del ", input$CategoryInput,
        " con rango de fecha desde ", input$timeFromInput, 
        " hasta ", input$timeToInput,
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(Table_tab6.0(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab6.0_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_6/Table_tab6.0_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab6.0_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab6.0_Modal,{
    removeModal()
  })
  
  ####  TAB_6.5  #### 
  output$Plot_tab6.5 <- renderPlotly({
    
    df_filtered <- 
      df.tab6_G() %>%
      filter(
        TipoMedición %in% input$cInput_tab6.2, 
        Medición %in% input$cInput_tab6.3
      ) %>%
      mutate(
        Zscore = ( 
          (ValorMedición - mean(ValorMedición)) / sd(ValorMedición) 
        ) %>% round(2)
      ) %>%
      filter(
        FechaDimensión %in% input$cInput_tab6.1 
      )
    
    if (input$Mean_Zscore) {
      value_Y_axis <- 
        df_filtered$Zscore
      name_Y_axis <- 
        "Zscore"
      marker_list <- 
        list(
          line = list(width = line_with_point, 
                      color = 'rgb(0, 0, 0)')
        )
    } else {
      value_Y_axis <- 
        df_filtered$ValorMedición %>% 
        mean() %>%
        round(1)
      name_Y_axis <- 
        "Promedio"
      marker_list <- 
        list()
    }
    
    if ( df_filtered %>% nrow() == 0 ) {  
      
      emptyChart(
        emptyMessage('este tipo de Variable de Nutrición')      
      )
      
    } else {
      # Visualization
      plot_ly() %>%
        add_trace(
          type='bar',
          x = df_filtered$Jugador %>% as.character(),
          y = df_filtered$ValorMedición,
          color = I("#2089E0E2"),
          name = input$cInput_tab6.3,
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          )
        ) %>% 
        add_lines(
          x = df_filtered$Jugador %>% as.character(),
          y = value_Y_axis,
          name = name_Y_axis,
          color = I("#FF0000"),
          line = list(shape = "linear"),
          marker = marker_list,
          yaxis = ifelse(input$Mean_Zscore,"y2","y"),
        ) %>%
        layout(
          hovermode = 'compare',
          legend = list(
            y = 1.02,
            x = 1,
            title = list(text = paste("<b>", input$cInput_tab6.2 ,"<b><br>"))
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
                "Comparativa del ", input$CategoryInput,
                " en el mes de ", input$cInput_tab6.1,
                " respecto de ", input$cInput_tab6.3,
                " en ", input$cInput_tab6.2,
                sep = ""
              ),
            scale = 3
          )
        ) 
      
    }
  }) 
  observeEvent(input$Plot_tab6.5_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_6/Plot_tab6.5_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab6.5_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab6.5_Modal,{
    removeModal()
  })
  
  ####  TABLE_6.1  ####
  
  Table_tab6.1  <- reactive({
    rbind(
      df.tab6_N() %>%
        filter(
          !TipoMedición %in% c('Masa Muscular','Masa Grasa')
        ),
      df.tab6_N() %>%
        filter(
          TipoMedición %in% c('Masa Muscular','Masa Grasa')
        ) %>%
        mutate(
          Medición = paste(TipoMedición,Medición)
        )
    ) %>%
      select(!TipoMedición) %>%
      group_by(Medición) %>%
      summarise(
        Media = mean(ValorMedición) %>% round(1),
        Mediana = median(ValorMedición) %>% round(1),
        Mínimo = min(ValorMedición) %>% round(1),
        Máximo = max(ValorMedición) %>% round(1),
        Desviación = sd(ValorMedición) %>% round(1)
      ) %>%
      distinct()
  })
  
  output$Table_tab6.1 <- DT::renderDataTable({
    DT::datatable(
      Table_tab6.1(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "250px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_tab6.1.xlsx <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla Estadística de Nutrición de ", input$PlayerInput,
          " del ", input$CategoryInput,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx",
          sep = ""
        )
      } else {
        paste(
          "Tabla Estadística de Nutrición del ", input$CategoryInput,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx",
          sep = ""
        )
      }
    },
    content = function(file) {
      write.xlsx(Table_tab6.1(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab6.1.csv <- downloadHandler(
    filename = function() {
      if (input$Player) {
        paste(
          "Tabla Nutrición de ", input$PlayerInput,
          " del ", input$CategoryInput,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx",
          sep = ""
        )
      } else {
        paste(
          "Tabla Nutrición del ", input$CategoryInput,
          " con rango de fecha desde ", input$timeFromInput, 
          " hasta ", input$timeToInput,
          ".xlsx",
          sep = ""
        )
      }
    },
    content = function(file) {
      write.csv(Table_tab6.1(), file, row.names = FALSE)
    }
  )
  observeEvent(input$Table_tab6.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_6/Table_tab6.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab6.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab6.1_Modal,{
    removeModal()
  })
  
  
  #### --------------------------- TAB_7 --------------------------- #### 
  
  
  ####  LIST_7.1  #### 
  
  df.tab7_1_list  <- reactive({
    ## Empty List
    loop_list <- 
      list()
    ## Main Loop
    for (dimension in dimensions) {
      ## Initial DF
      df_PF <- 
        df_BM_CAT() %>%
        filter(
          Dimensión %in% dimension
        ) %>%
        select(
          Jugador,
          FechaDimensión,
          Medición,
          ValorMedición
        ) 
      ## Empty
      loop_df <- 
        tibble(
          Jugador = factor(),
          Medición = factor(),
          ValorMedición = numeric()
        )
      ## Middle Loop
      for (player in unique(df_PF$Jugador)) {
        # Player
        df_player <- 
          df_PF %>%
          filter(
            Jugador == player
          ) %>%
          filter(
            FechaDimensión == max(FechaDimensión)
          ) %>% 
          select(!FechaDimensión)
        # Loop DF
        loop_df <- 
          rbind(
            loop_df,
            df_player
          )
      }
      ## Final DF
      final_df <- 
        spread(
          loop_df,
          key = 'Medición',
          value = 'ValorMedición' 
        ) %>% 
        mutate(
          across(everything(), ~replace_na(.x, 0)) 
          # final_df[is.na(final_df)] = 'Sin dato'
        )
      ## Appending General List
      loop_list <- 
        loop_list %>%
        append(
          list(final_df)
        )
    }
    ## Adding Titles
    names(loop_list) <- 
      dimensions
    ##Final List
    loop_list
  })
  
  ####  TABLE_7.1.1  #### 
  
  output$Table_tab7.1.1 <- DT::renderDataTable({
    
    if (nrow(df.tab7_1_list()[[1]]) == 0) {
      
      DT::datatable(
        df.tab7_1_list()[[1]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      )
      
    } else {
      
      DT::datatable(
        df.tab7_1_list()[[1]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      ) %>%
        formatStyle(
          "Abalakov-Valor Altura máxima",
          fontWeight = 'bold',
          color = styleInterval(c(41,45), c('white', 'black','white')),
          backgroundColor = styleInterval(c(41,45), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "CMJ-Valor Altura máxima",
          fontWeight = 'bold',
          color = styleInterval(c(34,38.6), c('white', 'black','white')),
          backgroundColor = styleInterval(c(34,38.6), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "SQ-Índice de utilización de brazos",
          fontWeight = 'bold',
          color = styleInterval(c(7,14), c('white', 'black','white')),
          backgroundColor = styleInterval(c(7,14), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "SQ-Índice Elástico sj cmj",
          fontWeight = 'bold',
          color = styleInterval(c(4,10), c('white', 'black','white')),
          backgroundColor = styleInterval(c(4,10), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "SQ-Valor Altura máxima",
          fontWeight = 'bold',
          color = styleInterval(c(32,36), c('white', 'black','white')),
          backgroundColor = styleInterval(c(32,36), c('red', 'yellow','green'))
        ) 
      
    }
    
  })
  
  ####  TABLE_7.1.2  #### 
  
  output$Table_tab7.1.2 <- DT::renderDataTable({
    
    if (nrow(df.tab7_1_list()[[2]]) == 0) {
      
      DT::datatable(
        df.tab7_1_list()[[2]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      )
      
    } else { 
      
      DT::datatable(
        df.tab7_1_list()[[2]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      ) %>%
        formatStyle(
          "Derecha-Aquiles valor Stiffness",
          background = styleColorBar(
            df.tab7_1_list()[[2]]$`Derecha-Aquiles valor Stiffness`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Derecha-Biceps femoral valor Stiffness",
          background = styleColorBar(
            df.tab7_1_list()[[2]]$`Derecha-Biceps femoral valor Stiffness`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Derecha-Semitendinoso valor Stiffness",
          background = styleColorBar(
            df.tab7_1_list()[[2]]$`Derecha-Semitendinoso valor Stiffness`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Izquierda-Aquiles valor Stiffness",
          background = styleColorBar(
            df.tab7_1_list()[[2]]$`Izquierda-Aquiles valor Stiffness`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Izquierda-Biceps femoral valor Stiffness",
          background = styleColorBar(
            df.tab7_1_list()[[2]]$`Izquierda-Biceps femoral valor Stiffness`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Izquierda-Semitendinoso valor Stiffness",
          background = styleColorBar(
            df.tab7_1_list()[[2]]$`Izquierda-Semitendinoso valor Stiffness`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Relación dere/izq-Aquiles asimetría %",
          fontWeight = 'bold',
          color = styleInterval(c(4.9,16.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(4.9,16.1), c('green', 'yellow','red'))
        ) %>%
        formatStyle(
          "Relación dere/izq-Biceps femoral asimetría %",
          fontWeight = 'bold',
          color = styleInterval(c(4.9,16.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(4.9,16.1), c('green', 'yellow','red'))
        ) %>%
        formatStyle(
          "Relación dere/izq-Semitendinoso asimetría %",
          fontWeight = 'bold',
          color = styleInterval(c(4.9,16.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(4.9,16.1), c('green', 'yellow','red'))
        )
      
    }
  })
  
  ####  TABLE_7.1.3  #### 
  
  output$Table_tab7.1.3 <- DT::renderDataTable({
    
    if (nrow(df.tab7_1_list()[[3]]) == 0) {
      
      DT::datatable(
        df.tab7_1_list()[[3]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      )
      
    } else {
      
      DT::datatable(
        df.tab7_1_list()[[3]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      ) %>%
        formatStyle(
          "Derecha-Relativo al peso",
          background = styleColorBar(
            df.tab7_1_list()[[3]]$`Derecha-Relativo al peso`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Izquierda-Relativo al peso",
          background = styleColorBar(
            df.tab7_1_list()[[3]]$`Izquierda-Relativo al peso`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Derecha-Valor N",
          fontWeight = 'bold',
          color = styleInterval(c(189.9,279.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(189.9,279.1), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Izquierda-Valor N",
          fontWeight = 'bold',
          color = styleInterval(c(189.9,279.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(189.9,279.1), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Relaciónn dere/izq-Asimetría %",
          fontWeight = 'bold',
          color = styleInterval(c(9.9,20.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(9.9,20.1), c('green', 'yellow','red'))
        )
      
    }
  })
  
  ####  TABLE_7.1.4  #### 
  
  output$Table_tab7.1.4 <- DT::renderDataTable({
    
    if (nrow(df.tab7_1_list()[[4]]) == 0) {
      
      DT::datatable(
        df.tab7_1_list()[[4]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      )
      
    } else {
      
      DT::datatable(
        df.tab7_1_list()[[4]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      ) %>%
        formatStyle(
          "Derecha-Plano anteroposterior valor promedio/DS",
          fontWeight = 'bold',
          color = styleInterval(c(0.09,0.16,0.23,0.30), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(0.09,0.16,0.23,0.30), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Derecha-Plano general valor promedio/DS",
          fontWeight = 'bold',
          color = styleInterval(c(1.90,2.15,2.66,2.80), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(1.90,2.15,2.66,2.80), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Derecha-Plano mediolateral valor promedio/DS",
          fontWeight = 'bold',
          color = styleInterval(c(0.47,0.58,0.71,0.81), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(0.47,0.58,0.71,0.81), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Derecha-Plano vertical superior valor promedio/DS",
          fontWeight = 'bold',
          color = styleInterval(c(1.89,2.04,2.55,2.79), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(1.89,2.04,2.55,2.79), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Izquierda-Plano anteroposterior valor promedio/DS",
          fontWeight = 'bold',
          color = styleInterval(c(0.09,0.16,0.23,0.30), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(0.09,0.16,0.23,0.30), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Izquierda-Plano general valor promedio/DS",
          fontWeight = 'bold',
          color = styleInterval(c(1.90,2.15,2.66,2.80), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(1.90,2.15,2.66,2.80), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Izquierda-Plano mediolateral valor promedio/DS",
          fontWeight = 'bold',
          color = styleInterval(c(0.47,0.58,0.71,0.81), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(0.47,0.58,0.71,0.81), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Izquierda-Plano vertical superior valor promedio/DS",
          fontWeight = 'bold',
          color = styleInterval(c(1.89,2.04,2.55,2.79), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(1.89,2.04,2.55,2.79), c('red', 'yellow','green','yellow','red'))
        )
      
    }
  })
  
  ####  TABLE_7.1.5 #### 
  
  output$Table_tab7.1.5 <- DT::renderDataTable({
    
    if (nrow(df.tab7_1_list()[[5]]) == 0) {
      
      DT::datatable(
        df.tab7_1_list()[[5]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      )
      
    } else {
      
      DT::datatable(
        df.tab7_1_list()[[5]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      ) %>%
        formatStyle(
          "Derecha-Cuádriceps 60° valor N/m",
          fontWeight = 'bold',
          color = styleInterval(c(139.9,186), c('white', 'black','white')),
          backgroundColor = styleInterval(c(139.9,186), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Derecha-Isquiotibiales 30° valor N/m",
          fontWeight = 'bold',
          color = styleInterval(c(59,96), c('white', 'black','white')),
          backgroundColor = styleInterval(c(59.9,96), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Izquierda-Cuádriceps 60° valor N/m",
          fontWeight = 'bold',
          color = styleInterval(c(139.9,186), c('white', 'black','white')),
          backgroundColor = styleInterval(c(139.9,186), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Izquierda-Isquiotibiales 30° valor N/m",
          fontWeight = 'bold',
          color = styleInterval(c(59,96), c('white', 'black','white')),
          backgroundColor = styleInterval(c(59.9,96), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Relación dere/izq-Cuádriceps 60° asimetría%",
          fontWeight = 'bold',
          color = styleInterval(c(9.9,20.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(9.9,20.1), c('green', 'yellow','red'))
        ) %>%
        formatStyle(
          "Relación dere/izq-Cuádriceps 60° Relación Qcps/Iqt",
          fontWeight = 'bold',
          color = styleInterval(c(39.9,54.9,65,75), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(39.9,54.9,65,75), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Relación dere/izq-Isquiotibiales 30° asimetría %",
          fontWeight = 'bold',
          color = styleInterval(c(9.9,20.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(9.9,20.1), c('green', 'yellow','red'))
        ) %>%
        formatStyle(
          "Relación dere/izq-Isquiotibiales 30° Relación Qcps/Iqt",
          fontWeight = 'bold',
          color = styleInterval(c(39.9,54.9,65,75), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(39.9,54.9,65,75), c('red', 'yellow','green','yellow','red'))
        )
      
    }
  })
  
  ####  TABLE_7.1.6 #### 
  
  output$Table_tab7.1.6 <- DT::renderDataTable({
    
    if (nrow(df.tab7_1_list()[[6]]) == 0) {
      
      DT::datatable(
        df.tab7_1_list()[[6]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      )
      
    } else {
      
      DT::datatable(
        df.tab7_1_list()[[6]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      ) %>%
        formatStyle(
          "Derecha-Torque máximo cuádriceps",
          fontWeight = 'bold',
          color = styleInterval(c(179.9,200.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(179.9,200.1), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Derecha-Torque máximo isquiotibial",
          fontWeight = 'bold',
          color = styleInterval(c(129.9,160), c('white', 'black','white')),
          backgroundColor = styleInterval(c(129.9,160), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Izquierda-Torque máximo cuádriceps",
          fontWeight = 'bold',
          color = styleInterval(c(179.9,200.1), c('white', 'black','white')),
          backgroundColor = styleInterval(c(179.9,200.1), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Izquierda-Torque máximo isquiotibial",
          fontWeight = 'bold',
          color = styleInterval(c(129.9,160), c('white', 'black','white')),
          backgroundColor = styleInterval(c(129.9,160), c('red', 'yellow','green'))
        ) %>%
        formatStyle(
          "Relación dere/izq-Relación iqt der/izq %",
          background = styleColorBar(
            df.tab7_1_list()[[6]]$`Relación dere/izq-Relación iqt der/izq %`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Relación dere/izq-Relación qcps izq /der %",
          background = styleColorBar(
            df.tab7_1_list()[[6]]$`Relación dere/izq-Relación qcps izq /der %`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          "Relación dere/izq-Relación qcps/iqt  der%",
          fontWeight = 'bold',
          color = styleInterval(c(39.9,54.9,65,75), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(39.9,54.9,65,75), c('red', 'yellow','green','yellow','red'))
        ) %>%
        formatStyle(
          "Relación dere/izq-Relación qcps/iqt izq %",
          fontWeight = 'bold',
          color = styleInterval(c(39.9,54.9,65,75), c('white', 'black','white','black','white')),
          backgroundColor = styleInterval(c(39.9,54.9,65,75), c('red', 'yellow','green','yellow','red'))
        )
      # formatStyle(
      #   names(df.tab7_1_list()[[6]][6]),
      #   fontWeight = 'bold',
      #   color = styleInterval(c(39.9,54.9,65,75), c('white', 'black','white','black','white')),
      #   backgroundColor = styleInterval(c(39.9,54.9,65,75), c('red', 'yellow','green','yellow','red'))
      # ) %>%
      # formatStyle(
      #   names(df.tab7_1_list()[[6]][7]),
      #   fontWeight = 'bold',
      #   color = styleInterval(c(39.9,54.9,65,75), c('white', 'black','white','black','white')),
      #   backgroundColor = styleInterval(c(39.9,54.9,65,75), c('red', 'yellow','green','yellow','red'))
      # ) %>%
      
    }
  })
  
  ####  TABLE_7.1.7 #### 
  
  output$Table_tab7.1.7 <- DT::renderDataTable({
    
    if (nrow(df.tab7_1_list()[[7]]) == 0) {
      
      DT::datatable(
        df.tab7_1_list()[[7]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      )
      
    } else {
      
      DT::datatable(
        df.tab7_1_list()[[7]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      ) %>%
        formatStyle(
          "Core Plank Test-Valor",
          fontWeight = 'bold',
          color = styleInterval(c(59.9,180), c('white', 'black','white')),
          backgroundColor = styleInterval(c(59,180), c('red', 'yellow','green'))
        )
      
    }
  })
  
  ####  TABLE_7.1.8 #### 
  
  output$Table_tab7.1.8 <- DT::renderDataTable({
    
    if (nrow(df.tab7_1_list()[[8]]) == 0) {
      
      DT::datatable(
        df.tab7_1_list()[[8]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      )
      
    } else {
      
      DT::datatable(
        df.tab7_1_list()[[8]] ,
        style = "bootstrap",
        rownames = FALSE,
        class = "cell-border stripe",
        width = "100%",
        selection = "multiple",
        options=list(
          ordering = F,
          sDom = '<"top">lrt<"bottom">ip',
          searching = TRUE, info = FALSE,
          scrollX = '400px', scrollY = "400px",
          scrollCollapse = TRUE, paging = FALSE,
          columnDefs = list(list(className = "dt-center", targets = "_all")),
          language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
        )
      ) %>%
        formatStyle(
          "Consumo máximo de oxigeno-V02",
          background = styleColorBar(
            df.tab7_1_list()[[8]]$`Consumo máximo de oxigeno-V02`, 
            'lightblue'
          ),
          backgroundSize = '100%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        )  %>%
        formatStyle(
          "Consumo máximo de oxigeno-Vo2max relativo al peso",
          fontWeight = 'bold',
          color = styleInterval(c(35,45), c('white', 'black','white')),
          backgroundColor = styleInterval(c(40,45), c('red', 'yellow','green'))
        )
      
    }
  })
  
  output$download_Table_tab7.1.csv <- downloadHandler(
    filename = function() {
      paste("Biomecánica por Jugador ", input$CategoryInput, ".zip", sep = "")
    },
    content = function(file) {
      owd <- 
        setwd(tempdir())
      on.exit(setwd(owd))
      files <- NULL;
      for (i in 1:8) {
        fileName <- 
          paste(names(df.tab7_1_list()[i]),".csv",sep = "")
        write.table(
          df.tab7_1_list()[[i]], 
          fileName, 
          sep = ';', 
          row.names = FALSE, 
          col.names = TRUE
        )
        files <- 
          c(fileName,files)
      }
      zip(file,files)
    }
  )
  
  output$download_Table_tab7.1.xlsx <- downloadHandler(
    filename = function() {
      paste("Biomecánica por Jugador ", input$CategoryInput, ".zip", sep = "")
    },
    content = function(file) {
      owd <- 
        setwd(tempdir())
      on.exit(setwd(owd))
      files <- NULL;
      for (i in 1:8) {
        fileName <- 
          paste(names(df.tab7_1_list()[i]),".xlsx",sep = "")
        write.xlsx(
          df.tab7_1_list()[[i]], 
          fileName,
          col.names = TRUE, 
          row.names = TRUE, 
          append = FALSE
        )
        files <- 
          c(fileName,files)
      }
      zip(file,files)
    }
  )
  
  observeEvent(input$Table_tab7.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_7/Table_tab7.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab7.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab7.1_Modal,{
    removeModal()
  })
  
  
  
  ####  TAB_7.1  #### 
  
  df.tab7.1  <- reactive({
    ## Empty List
    final_df <- 
      tibble(
        Jugador = factor(),
        Medición = factor(),
        ValorMedición = numeric(),
        ValorMétrica = numeric()
      )
    ## Main Loop
    for (dimension in dimensions) {
      initial_df <- 
        df_BM_CAT() %>%
        filter(
          Dimensión %in% dimension
        )
      ## Empty
      loop_df <- 
        tibble(
          Jugador = factor(),
          Medición = factor(),
          ValorMedición = numeric(),
          ValorMétrica = numeric()
        )
      ## Middle Loop
      for (player in unique(initial_df$Jugador)) {
        # Player
        df_player <- 
          initial_df %>%
          filter(
            Jugador == player
          ) %>%
          filter(
            FechaDimensión == max(FechaDimensión)
          ) %>% 
          select(!FechaDimensión)
        # Loop DF
        loop_df <- 
          rbind(
            loop_df,
            df_player
          )
      }
      ## Final DF
      final_df <- 
        rbind(
          final_df,
          loop_df
        ) 
    }
    ## DF
    final_df
    
  })
  
  df.tab7.1.1  <- reactive({
    ## Metric DF
    df_BM_metric <- 
      df.tab7.1() %>%
      group_by(Jugador,Dimensión) %>% 
      summarise(
        Valor = sum(ValorMétrica)
      ) %>%
      as.data.frame()
    ## Final DF
    df_BM_metric
  })
  
  df.tab7.1.2  <- reactive({
    ## Metric DF
    df_BM_metric <- 
      df.tab7.1() %>%
      group_by(Dimensión) %>% 
      summarise(
        Valor = sum(ValorMétrica)
      ) %>%
      as.data.frame()
    ## Final DF
    df_BM_metric
  })
  
  df.tab7.1.3  <- reactive({
    ## Metric DF
    df_BM_metric <- 
      df.tab7.1() %>% 
      group_by(Jugador,Dimensión) %>% 
      summarise(
        Valor = sum(ValorMétrica)
      ) %>%
      as.data.frame() %>%
      spread(
        key = 'Dimensión',
        value = 'Valor' 
      ) %>% 
      mutate(
        'Total Puntuación' = rowSums(across(where(is.numeric))) 
      ) %>% 
      arrange(desc('Total Puntuación')) %>%
      rename(
        'Consumo máximo oxigeno' = 'Consumo máximo de oxigeno',
        'Índice Postural' = 'Índice postural dinámico para tobillo',
        'Plataforma de Fuerza' = 'Plataforma de fuerza'
      )
    ## Final DF
    df_BM_metric
  })
  
  output$Plot_tab7.1 <- renderPlotly({
    
    ## DF
    df.tab7_fil <- 
      df.tab7.1.1()
    
    ## Visualization
    if (nrow(df.tab7_fil) == 0) { 
      
      emptyChart(
        emptyMessage('Biomecánica')      
      )
      
    } else {
      
      # Visualization
      plot_ly() %>%
        add_trace(
          orientation = 'h',
          type = 'bar',
          x = df.tab7_fil$Valor,
          y = df.tab7_fil$Jugador,
          color = df.tab7_fil$Dimensión,
          marker = list(
            line = list(width = line_with_bar, 
                        color = 'rgb(0, 0, 0)')
          ),
          text = paste(
            "<b>Jugador: </b>", df.tab7_fil$Jugador,
            "<br><b>Dimensión: </b>", df.tab7_fil$Dimensión,
            "<br><b>Valor: </b>", df.tab7_fil$Valor
          ),
          hoverinfo = 'text'
        ) %>%
        layout(
          barmode = 'stack',
          #xaxis = list(range = c(0,(max(df.tab7_fil$Valor)+2))),
          yaxis = list(
            autotick = FALSE,
            ticks = "outside",
            tick0 = 0,
            dtick = 0.25,
            ticklen = 5,
            tickwidth = 2,
            tickcolor = toRGB("black")
          ),
          #hovermode = 'compare',
          legend = list(
            orientation = 'h',
            y = 1.3, 
            x = 0,
            title = list(
              text = "<b>Dimensiones   <br>Biomecánica   <b>"
            )
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
                "Gráfica Biomecánica por Jugador y Dimensión de ", 
                input$CategoryInput,
                " con fecha ", Sys.Date(),
                sep = ""
              ),
            scale = 3
          )
        ) 
    }
  })
  
  observeEvent(input$Plot_tab7.1_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_7/Plot_tab7.1_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Plot_tab7.1_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Plot_tab7.1_Modal,{
    removeModal()
  })
  
  ####  FOOTER_7.1  #### 
  
  Plot_tab7.1_Footer_A <- reactive({
    df.tab7.1.2() %>%
      filter(
        Dimensión == "Consumo máximo de oxigeno" 
      ) %>%
      pull(Valor)
  })
  output$Plot_tab7.1_Footer_A <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "lungs",
      numberColor = "aqua", 
      header =  Plot_tab7.1_Footer_A(),
      text = "Total Consumo Oxígeno"
    )
  })
  
  Plot_tab7.1_Footer_B <- reactive({
    df.tab7.1.2() %>%
      filter(
        Dimensión == "Core Plank Test" 
      ) %>%
      pull(Valor)
  })
  output$Plot_tab7.1_Footer_B <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "ruler",
      numberColor = "aqua", 
      header =  Plot_tab7.1_Footer_B(),
      text = "Total Core Plank Test"
    )
  })
  
  Plot_tab7.1_Footer_C <- reactive({
    df.tab7.1.2() %>%
      filter(
        Dimensión == "Fuerza Isométrica" 
      ) %>%
      pull(Valor)
  })
  output$Plot_tab7.1_Footer_C <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "prescription-bottle",
      numberColor = "aqua", 
      header =  Plot_tab7.1_Footer_C(),
      text = "Total Fuerza Isométrica"
    )
  })
  
  Plot_tab7.1_Footer_D <- reactive({
    df.tab7.1.2() %>%
      filter(
        Dimensión == "Índice postural dinámico para tobillo" 
      ) %>%
      pull(Valor)
  })
  output$Plot_tab7.1_Footer_D <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "hospital",
      numberColor = "aqua", 
      header =  Plot_tab7.1_Footer_D(),
      text = "Total Índice Postural"
    )
  })
  
  Plot_tab7.1_Footer_E <- reactive({
    df.tab7.1.2() %>%
      filter(
        Dimensión == "Isocinética" 
      ) %>%
      pull(Valor)
  })
  output$Plot_tab7.1_Footer_E <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "ruler-combined",
      numberColor = "aqua", 
      header =  Plot_tab7.1_Footer_E(),
      text = "Total Isocinética"
    )
  })
  
  Plot_tab7.1_Footer_F <- reactive({
    df.tab7.1.2() %>%
      filter(
        Dimensión == "Miotone" 
      ) %>%
      pull(Valor)
  })
  output$Plot_tab7.1_Footer_F <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "bong",
      numberColor = "aqua", 
      header =  Plot_tab7.1_Footer_F(),
      text = "Total Miotone"
    )
  })
  
  Plot_tab7.1_Footer_G <- reactive({
    df.tab7.1.2() %>%
      filter(
        Dimensión == "Nórdicos Isquiotibiales" 
      ) %>%
      pull(Valor)
  })
  output$Plot_tab7.1_Footer_G <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "bars",
      numberColor = "aqua", 
      header =  Plot_tab7.1_Footer_G(),
      text = "Total Nórdicos Isquiotibiales"
    )
  })
  
  Plot_tab7.1_Footer_H <- reactive({
    df.tab7.1.2() %>%
      filter(
        Dimensión == "Plataforma de fuerza" 
      ) %>%
      pull(Valor)
  })
  output$Plot_tab7.1_Footer_H <- renderUI({
    descriptionBlock(
      rightBorder = TRUE,
      marginBottom = FALSE,
      number = "", 
      numberIcon = "list",
      numberColor = "aqua", 
      header =  Plot_tab7.1_Footer_H(),
      text = "Total Plataforma de Fuerza"
    )
  })
  
  ####  TABLE_7.3  #### 
  
  output$Table_tab7.3 <- DT::renderDataTable({
    DT::datatable(
      df.tab7.1.3(),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    ) %>%
      formatStyle(
        "Total Puntuación",
        background = styleColorBar(
          df.tab7.1.3()$`Total Puntuación`, 
          'lightblue'
        ),
        backgroundSize = '100%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      )
  })
  
  output$download_Table_tab7.3.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Tabla Biomecánica por Jugador y Dimensión de ", 
        input$CategoryInput,
        " con fecha ", Sys.Date(),
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(df.tab7.1.3(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_tab7.3.csv <- downloadHandler(
    filename = function() {
      paste(
        "Tabla Biomecánica por Jugador y Dimensión de ", 
        input$CategoryInput,
        " con fecha ", Sys.Date(),
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(df.tab7.1.3(), file, row.names = FALSE)
    }
  )
  
  
  ####  LIST_7.2  #### 
  
  df.tab7_2_list  <- reactive({
    
    ## Empty List
    loop_list <- 
      list()
    ## Main Loop
    for (dimension in dimensions) {
      ## Initial DF
      df_PF <- 
        df_BM_CAT() %>%
        filter(
          Dimensión %in% dimension
        ) %>%
        select(
          Jugador,
          FechaDimensión,
          Medición,
          ValorMedición
        ) 
      ## Final DF
      final_df <- 
        left_join(
          df_PF,
          df_CED %>% 
            select(Jugador,Posición) %>% 
            unique(),
          by = "Jugador"
        ) %>% 
        group_by(Posición,Medición) %>%
        summarise(
          Promedio = round(mean(ValorMedición),1),
          Desviación = round(sd(ValorMedición),1)
        ) %>%
        mutate(
          Valor = paste(Promedio,"+-",Desviación)
        ) %>%
        select(
          Posición,
          Medición,
          Valor
        ) %>%
        spread(
          key = 'Medición',
          value = 'Valor' 
        ) %>%
        as.data.frame()
      ## Appending General List
      loop_list <- 
        loop_list %>%
        append(
          list(final_df)
        )
    }
    ## Adding Titles
    names(loop_list) <- 
      dimensions
    ## Final List
    loop_list
  })
  
  ####  TABLE_7.2.1  #### 
  
  output$Table_tab7.2.1 <- DT::renderDataTable({
    DT::datatable(
      df.tab7_2_list()[[1]] ,
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  
  ####  TABLE_7.2.2  #### 
  
  output$Table_tab7.2.2 <- DT::renderDataTable({
    DT::datatable(
      df.tab7_2_list()[[2]] ,
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  
  ####  TABLE_7.2.3  #### 
  
  output$Table_tab7.2.3 <- DT::renderDataTable({
    DT::datatable(
      df.tab7_2_list()[[3]] ,
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  
  ####  TABLE_7.2.4  #### 
  
  output$Table_tab7.2.4 <- DT::renderDataTable({
    DT::datatable(
      df.tab7_2_list()[[4]] ,
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  
  ####  TABLE_7.2.5  #### 
  
  output$Table_tab7.2.5 <- DT::renderDataTable({
    DT::datatable(
      df.tab7_2_list()[[5]] ,
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  
  ####  TABLE_7.2.6  #### 
  
  output$Table_tab7.2.6 <- DT::renderDataTable({
    DT::datatable(
      df.tab7_2_list()[[6]] ,
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  
  ####  TABLE_7.2.7  #### 
  
  output$Table_tab7.2.7 <- DT::renderDataTable({
    DT::datatable(
      df.tab7_2_list()[[7]] ,
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  
  ####  TABLE_7.2.8  #### 
  
  output$Table_tab7.2.8 <- DT::renderDataTable({
    DT::datatable(
      df.tab7_2_list()[[8]] ,
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      selection = "multiple",
      options=list(
        ordering=F,
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "400px",
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  
  output$download_Table_tab7.2.csv <- downloadHandler(
    filename = function() {
      paste("Biomecánica ", input$CategoryInput, ".zip", sep = "")
    },
    content = function(file) {
      owd <- 
        setwd(tempdir())
      on.exit(setwd(owd))
      files <- NULL;
      for (i in 1:8) {
        fileName <- 
          paste(names(df.tab7_2_list()[i]),".csv",sep = "")
        write.table(
          df.tab7_2_list()[[i]], 
          fileName, 
          sep = ';', 
          row.names = FALSE, 
          col.names = TRUE
        )
        files <- 
          c(fileName,files)
      }
      zip(file,files)
    }
  )
  
  output$download_Table_tab7.2.xlsx <- downloadHandler(
    filename = function() {
      paste("Biomecánica ", input$CategoryInput, ".zip", sep = "")
    },
    content = function(file) {
      owd <- 
        setwd(tempdir())
      on.exit(setwd(owd))
      files <- NULL;
      for (i in 1:8) {
        fileName <- 
          paste(names(df.tab7_2_list()[i]),".xlsx",sep = "")
        write.xlsx(
          df.tab7_2_list()[[i]], 
          fileName,
          col.names = TRUE, 
          row.names = TRUE, 
          append = FALSE
        )
        files <- 
          c(fileName,files)
      }
      zip(file,files)
    }
  )
  
  observeEvent(input$Table_tab7.2_HELP, {
    showModal(
      modalDialog(
        includeHTML("Modals/Tab_7/Table_tab7.2_HELP.html"),
        easyClose = TRUE,
        size = "m",
        footer = actionButton(
          inputId = "Table_tab7.2_Modal",
          icon = icon("times-circle"),
          label = "Cerrar",
          style = "color: white;  background: linear-gradient(60deg, #142c59, #00C0EF);"
        )
      )
    )
  })
  observeEvent(input$Table_tab7.2_Modal,{
    removeModal()
  })
  
  
  
  
  #### --------------------------- TAB_API --------------------------- #### 
  
  ####  Table_API_1  ####
  output$Table_API_1 <- DT::renderDataTable({
    DT::datatable(
      rbind(df_PD_CAT_T(),
            df_PD_F_C()),
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "260px", 
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_API_1.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Dimensiones Numéricas de Jugadores del ", input$CategoryInput, 
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(
        rbind(df_PD_CAT_T(),
              df_PD_F_C()), 
        file, col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_API_1.csv <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Dimensiones Numéricas de Jugadores del ", input$CategoryInput, 
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(
        rbind(df_PD_CAT_T(),
              df_PD_F_C()), 
        file, row.names = FALSE)
    }
  )
  
  ####  Table_API_2  ####
  output$Table_API_2 <- DT::renderDataTable({
    DT::datatable(
      df_AC_C(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "260px", 
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_API_2.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Dimensiones Categóricas de Jugadores del ", input$CategoryInput, 
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(df_AC_C(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_API_2.csv <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Dimensiones Categóricas de Jugadores del ", input$CategoryInput, 
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(df_AC_C(), file, row.names = FALSE)
    }
  )
  
  ####  Table_API_3  ####
  output$Table_API_3 <- DT::renderDataTable({
    DT::datatable(
      df_CED_C(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "260px", 
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_API_3.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Eventos Clínicos y Diagnósticos del ", input$CategoryInput, 
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(df_CED_C(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_API_3.csv <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Eventos Clínicos y Diagnósticos del ", input$CategoryInput, 
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(df_CED_C(), file, row.names = FALSE)
    }
  )
  
  ####  Table_API_4  ####
  output$Table_API_4 <- DT::renderDataTable({
    DT::datatable(
      df_KT_C(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "260px", 
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_API_4.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Tratamientos Kinésicos del ", input$CategoryInput, 
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(df_KT_C(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_API_4.csv <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Tratamientos Kinésicos del ", input$CategoryInput, 
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(df_KT_C(), file, row.names = FALSE)
    }
  )
  
  ####  Table_API_5  ####
  output$Table_API_5 <- DT::renderDataTable({
    DT::datatable(
      df_MED_C(), 
      style = "bootstrap",
      rownames = FALSE,
      class = "cell-border stripe",
      width = "100%",
      filter = 'top',
      selection = "multiple",
      options=list(
        sDom  = '<"top">lrt<"bottom">ip',
        searching = TRUE, info = FALSE,
        scrollX = '400px', scrollY = "260px", 
        scrollCollapse = TRUE, paging = FALSE,
        columnDefs = list(list(className = "dt-center", targets = "_all")),
        language = list(zeroRecords = "No hay suficientes datos para generar la Tabla")
      )
    )
  })
  output$download_Table_API_5.xlsx <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Medicina del ", input$CategoryInput, 
        ".xlsx",
        sep = ""
      )
    },
    content = function(file) {
      write.xlsx(df_MED_C(), file,
                 col.names = TRUE, row.names = TRUE, append = FALSE)
    }
  )
  output$download_Table_API_5.csv <- downloadHandler(
    filename = function() {
      paste(
        "Tabla General Medicina del ", input$CategoryInput, 
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(df_MED_C(), file, row.names = FALSE)
    }
  )
  
  
  #### --------------------------- TAB_RELOAD --------------------------- #### 
  
  ####  Loading  ####
  output$plotUpdate <- renderPlot({
    input$update
  })
  
  ####  Process  ####
  observeEvent(input$update, {
    
    shinyjs::disable('update')
    
    show_spinner(spin_id = NULL, session = shiny::getDefaultReactiveDomain())
    
    ## Starting Time
    start_tenant_time <- 
      Sys.time()
    
    ## Connection
    con <- 
      do.call(
        DBI::dbConnect, 
        dbi_PROD
      )
    
    ## Encodin UTF-8 in SQL
    dbSendQuery(con, "SET NAMES utf8")
    
    ##  df_DM 
    df_DM <- 
      dbGetQuery(
        con,
        stringr::str_glue(
          "
          ##############  MEDICIONES DIARIAS  ##############
          
          SELECT DISTINCT
          # DM ID
          dm.id AS ID_DM,
          # Jugador
          concat(us.name,' ',us.last_name) AS Jugador,
          if (pl.side=1,'Diestro','Zurdo') AS Lateralidad,
          pl.height AS Estatura,
          pl.initial_weight AS Peso,
          ct.name_category AS Categoría,
          pt.name_position AS Posición,
          # Mediciones Diarias
          if (dm.measurement_moment=1,'Entrenamiento','Partido') AS MomentoMedición,
          mt.name AS TipoMedición,
          dm.value AS ValorMedición,
          dm.date AS FechaMedición
          
          FROM player pl 
            # Jugador
            LEFT JOIN user us ON us.id = pl.id_user 
                  AND us.deleted = 0
                  AND us.id_user_type = 12
                  AND us.tenant_code = '{tenant}'
            LEFT JOIN user_type ust ON ust.id = us.id_user_type 
            LEFT JOIN category_type ct ON pl.id_category_type = ct.id
            LEFT JOIN position_type pt ON pl.id_position_type = pt.id
            # Mediciones Diarias
            LEFT JOIN daily_measurements dm ON dm.id_player = pl.id 
                  AND dm.deleted = 0
                  # AND dm.tenant_code = '{tenant}'
            LEFT JOIN measurement_type mt ON mt.id = dm.measurement_type  
                  AND mt.deleted = 0
                  # AND mt.tenant_code = '{tenant}'
          
          WHERE pl.deleted = 0 
            AND pl.tenant_code = '{tenant}'
            
          ;
          
          "
        )
      ) %>% as.data.frame() 
    # df_PD_G
    df_PD_G <- 
      dbGetQuery(
        con,
        stringr::str_glue(
          "
          ##############  DIMENSIONES DE JUGADOR  ##############
          
          SELECT 
          # PD ID
          pldm.id AS ID_PlayerDimension,
          # Jugador
          concat(us.name,' ',us.last_name) AS Jugador,
          ct.name_category AS Categoría,
          # Dimensiones de Jugador
          dm.name AS Dimensión,
          pldm.date AS FechaDimensión,
          # Meters
          pldm.meters AS Medición
          
          FROM player pl 
            # Jugador
            LEFT JOIN user us ON us.id = pl.id_user 
                  AND us.deleted = 0
                  AND us.id_user_type = 12
                  AND us.tenant_code = '{tenant}'
            LEFT JOIN user_type ust ON ust.id = us.id_user_type 
            LEFT JOIN category_type ct ON pl.id_category_type = ct.id
            # Dimensiones de Jugador
            LEFT JOIN player_dimension pldm ON pl.id = pldm.id_player 
                  AND pldm.deleted = 0
                  # AND us.tenant_code = '{tenant}'
            LEFT JOIN dimension dm ON dm.id = pldm.id_dimension
                  # AND dm.tenant_code = '{tenant}'
            
          WHERE pl.deleted = 0 
            AND pl.tenant_code = '{tenant}'
            
          ;
          "
        )     
      )
    # Disconnection
    dbDisconnect(con)
    
    ##df_PD_reload I  
    # DF
    df_PD_I <- 
      df_PD_G %>% 
      distinct() %>%
      drop_na() %>%
      # slice(1:100) %>%
      arrange(desc(ID_PlayerDimension)) %>% 
      filter(FechaDimensión >= input$timeReloadFromInput)
    
    if (nrow(df_PD_I) != 0) {
      
      # Removing ID adn Medición
      df_PD_reload<- 
        df_PD_I %>% 
        select(!c(ID_PlayerDimension, Medición))
      
      # Defining Specific Json's Meters Data Frame
      df_Json <- 
        df_PD_I %>% 
        select(Medición)
      json <- 
        df_Json$Medición 
      
      # Creating DF's Structutre
      df <- 
        data.frame(
          "id" = integer(),
          "name" = character(),
          "value" = double(),
          "TipoMedición" = character(),
          "Jugador" = character(),      
          "Categoría" = character(),             
          "Dimensión" = character(),             
          "FechaDimensión" = character()     
        )
      
      # Triple Loop for Building the whole DT
      for (i in (1:length(json))) {
        json_n <-
          json[i] %>%
          jsonlite::fromJSON()
        for (j in (1:length(json_n))) {
          json_df_b <- 
            json_n[[j]] %>%
            jsonlite::fromJSON()
          for (b in (1:length(json_df_b))) {
            json_df <- 
              json_df_b[[b]]
            for (k in (1:length(json_df$meters))) {
              json_m <- 
                json_df$meters[[k]] %>%
                as.data.frame() %>%
                mutate("TipoMedición" = json_df$name)
              if (df_PD_reload[i,"Dimensión"] %in% "Masoterápea") { 
                json_m <- 
                  json_m %>%
                  mutate("value" = 0)
              }
              json_df_c <-
                cbind(json_m,
                      df_PD_reload[i,] %>%
                        slice(rep(1:n(), each = nrow(json_m))))
              df <- 
                rbind(df,json_df_c)
            }
          }
        }
      }
      
      # print("Lleguamos hasta aquí nomas !!")
      
      # Renaming, Relocating and Filtering
      df_PD_reload<- 
        df %>% 
        select(-id) %>% 
        rename(
          "Medición" = name,
          "ValorMedición" = value
        ) %>% 
        relocate(
          "Jugador", 
          "Categoría",           
          "FechaDimensión",
          "Dimensión",
          "TipoMedición",
          "Medición",
          "ValorMedición"
        ) %>% 
        filter(!ValorMedición == "") %>% 
        rbind(
          df_DM %>%
            select(!ID_DM) %>% 
            rename(
              "Medición" = TipoMedición,
              "TipoMedición" = MomentoMedición,
              "FechaDimensión" = FechaMedición
            ) %>%
            mutate(Dimensión = "GPS") %>% 
            relocate(
              Jugador,
              Categoría,
              FechaDimensión,
              Dimensión,
              TipoMedición,
              Medición,
              ValorMedición
            ) %>%
            select(!c(
              Posición,Peso,Estatura,Lateralidad
            ))
        )
      
      ##  df_PD_F_reload
      df_PD_F_reload<- 
        rbind(
          df_PD_reload %>% 
            filter(
              Dimensión %in% "Masoterápea"
            ),
          df_PD_reload %>% 
            filter(
              Medición %in% "PCR"
            ) %>%
            mutate(
              PCR = df_PD_reload %>%
                filter(
                  Medición %in% "PCR"
                ) %>% 
                pull(ValorMedición) %>%
                recode(
                  "58"="Negativo",
                  "59"="Positivo",
                  "60"="Negativo",
                  "61"="Positivo"
                )
            ) %>%
            select(!ValorMedición) %>%
            rename(ValorMedición=PCR)
        )
      df_PD_F_reload$Categoría <- df_PD_F_reload$Categoría %>% as.factor()
      df_PD_F_reload$Jugador <- df_PD_F_reload$Jugador %>% as.factor()
      df_PD_F_reload$FechaDimensión <- df_PD_F_reload$FechaDimensión %>% as.Date()
      df_PD_F_reload$TipoMedición <- df_PD_F_reload$TipoMedición %>% as.factor()
      df_PD_F_reload$Medición <- 
        gsub("\\s*\\([^\\)]+\\)","",
             as.character(df_PD_F_reload$Medición)) %>% as.factor()
      df_PD_F_reload$Medición <- df_PD_F_reload$Medición %>% as.factor()
      df_PD_F_reload$ValorMedición <- df_PD_F_reload$ValorMedición %>% as.factor()
      
      ##  df_PD_reload II
      df_PD_reload<- 
        df_PD_reload%>% 
        filter(
          !Dimensión %in% "Masoterápea",
          !Medición %in% c("PCR","Estress")
        )
      df_PD_reload$ValorMedición <- df_PD_reload$ValorMedición %>% as.numeric()
      df_PD_reload$Categoría <- df_PD_reload$Categoría %>% as.factor()
      df_PD_reload$Jugador <- df_PD_reload$Jugador %>% as.factor()
      df_PD_reload$FechaDimensión <- df_PD_reload$FechaDimensión %>% as.Date()
      df_PD_reload$TipoMedición <- df_PD_reload$TipoMedición %>% as.factor()
      df_PD_reload$Medición <- df_PD_reload$Medición %>% as.factor()
      df_PD_reload$Medición <- 
        gsub("\\s*\\([^\\)]+\\)","",
             as.character(df_PD_reload$Medición)) %>% as.factor()
      df_PD_reload$Dimensión <- df_PD_reload$Dimensión %>% as.factor()
      # Droping NA
      df_PD_reload<- 
        df_PD_reload %>% 
        drop_na() %>% 
        filter(ValorMedición >= 0)
      # re Value
      df_PD_reload$Medición <- 
        df_PD_reload$Medición %>% 
        plyr::revalue(c(
          "Nivel de percepción por el esfuerzo" = "Percepción subjetiva del esfuerzo",
          "Total Duration" = "Minutos de exposición",
          "Dolor muscular" = "Estado general muscular",
          "Estado de ánimo" = "Humor / Estado de ánimo",
          'T.Q.R Recuperación física' = 'T.Q.R'
        )) 
      df_PD$Medición <- 
        factor(
          df_PD$Medición, 
          unique(df_PD$Medición)
        )
      
      ##  MERGING DFs 
      # df_PD_F
      dropboxDownload(tenant, 'df_PD.rds')
      df_PD_prev <- 
        readRDS("df_PD.rds") %>%
        filter(FechaDimensión < input$timeReloadFromInput)
      df_PD_reload<- 
        rbind(
          df_PD_reload,
          df_PD_prev
        ) %>% 
        distinct()
      # df_PD
      dropboxDownload(tenant, 'df_PD_F.rds')
      df_PD_F_prev <- 
        readRDS("df_PD_F.rds") %>%
        filter(FechaDimensión < input$timeReloadFromInput)
      df_PD_F_reload<- 
        rbind(
          df_PD_F_reload,
          df_PD_F_prev
        ) %>% 
        distinct()
      
      ## Uploading
      # Local
      saveRDS(df_PD_reload, file = "df_PD.rds")
      saveRDS(df_PD_F_reload, file = "df_PD_F.rds")
      # Dropbox
      dropboxUpload(tenant, 'df_PD.rds')
      dropboxUpload(tenant, 'df_PD_F.rds')
      
    }
    
    ## Ending Time
    end_tenant_time <- 
      Sys.time()
    
    ## Total Time
    total_tenant_time <- 
      difftime(
        end_tenant_time,
        start_tenant_time,
        units = c("mins")
      ) %>% 
      as.numeric() %>%
      round(1)
    print(
      paste(
        "Tiempo de procesamiento de Recarga del Tenant ", tenant,
        " con fecha ", Sys.time(), ": ", 
        as.numeric(total_tenant_time), " minutos.", 
        sep = ""
      )
    )
    
    hide_spinner(spin_id = NULL, session = shiny::getDefaultReactiveDomain())
    
    shinyjs::enable('update')
    
  })
  
  ####  Modal  ####
  observeEvent( input$update, {
    show_alert(
      title = "Datos actualizados con éxito !",
      text = "Vuelva a cargar sus visualizaciones para poder observar los cambios.",
      # "Cierre la Aplicación de Reconquer por 5 minutos y luego vuelva a iniciarla."
      type = "success",
      btn_labels = "Entendido",
      btn_colors = "#142c59",
      width = "40%"
    )
  })
  # observeEvent(input$update, {
  #   Sys.sleep(15)
  #   closeSweetAlert(
  #     session = shiny::getDefaultReactiveDomain()
  #   )
  # })
  
  
  #### --------------------------- TAB_REPORT --------------------------- #### 
  
  ####  Loading  ####
  output$plotReport <- renderPlot({
    input$generate_report
  })
  
  ####  UI  ####
  output$initialCondition <- renderUI({
    textAreaInput(
      width = "380px",
      height = "60px",
      inputId = "initialConditionInput", 
      label = 'Condición de Ingreso', 
      value = ""
    )
  })
  output$finalCondition <- renderUI({
    textAreaInput(
      width = "380px",
      height = "60px",
      inputId = "finalConditionInput", 
      label = 'Condición de Salida', 
      value = ""
    )
  })
  output$entryDate <- renderUI({
    dateInput(
      width = "120px",
      inputId = "entryDateInput", 
      label = "Fecha ingreso:",
      value = min(date_range),
      min = NULL,
      max = NULL,
      startview = "month",
      language = "es"
    )
  })
  output$leaveDate <- renderUI({
    dateInput(
      width = "120px",
      inputId = "leaveDateInput", 
      label = "Fecha salida:",
      value = max(date_range),
      min = NULL,
      max = NULL,
      startview = "month",
      language = "es"
    )
  })
  
  ####  Process  ####
  observeEvent( input$generate_report, {
    
    
    if ( 
      stringr::str_detect(input$ReportEmailInput, "[.]") == FALSE |
      stringr::str_detect(input$ReportEmailInput, "email") == TRUE |
      stringr::str_detect(input$ReportEmailInput, "@") == FALSE 
    ) {
      
    } else {
      
      shinyjs::disable('generate_report')
      
      show_spinner(spin_id = NULL, session = shiny::getDefaultReactiveDomain())
      
      
      ## Starting Time
      start_report_time <- 
        Sys.time()
      
      ### INPUTS
      # Client
      client <- 
        ifelse(
          tenant == "some_tenant", 
          "some_tenant", 
          stringr::str_to_title(tenant)
        )
      # Category
      filter_category <- 
        input$CategoryInput
      # Period
      start_date <- 
        input$timeFromInput
      end_date <- 
        input$timeToInput
      # Mail
      email_adress <- 
        input$ReportEmailInput
      #second_email_adress <- userEmail()
      
      
      ### IMPORTING
      df_CED_report <- df_CED_fil()
      df_CED_TE_report <- df_CED_TE_fil() 
      df_KT_report <- df_KT_fil()
      df_KA_report <- df_KA_fil() 
      df_PD_report <- df_PD_fil() 
      df_PD_F_report <- df_PD_F_fil() 
      df_TL_report <- df_TL_fil()
      df_MED_report <- df_MED_fil()
      df_AC_report <- df_AC_fil()
      df_EO_report <- df_EO_fil() 
      
      
      ####  SAVING  #### 
      # Web
      saveRDS(df_CED_report, 'df_CED.rds')
      saveRDS(df_CED_report, 'df_CED_G.rds')
      saveRDS(df_CED_TE_report, 'df_CED_TE.rds')
      saveRDS(df_KT_report, 'df_KT.rds')
      saveRDS(df_KA_report, 'df_KA.rds')
      saveRDS(df_PD_report, 'df_PD.rds')
      saveRDS(df_PD_F_report, 'df_PD_F.rds')
      saveRDS(df_TL_report, 'df_TL.rds')
      saveRDS(df_MED_report, 'df_MED.rds')
      saveRDS(df_AC_report, 'df_AC.rds')
      saveRDS(df_EO_report, 'df_EO.rds')
      # Local
      # saveRDS(df_CED_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_CED.rds')
      # saveRDS(df_CED_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_CED_G.rds')
      # saveRDS(df_CED_TE_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_CED_TE.rds')
      # saveRDS(df_KT_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_KT.rds')
      # saveRDS(df_KA_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_KA.rds')
      # saveRDS(df_PD_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_PD.rds')
      # saveRDS(df_PD_F_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_PD_F.rds')
      # saveRDS(df_TL_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_TL.rds')
      # saveRDS(df_MED_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_MED.rds')
      # saveRDS(df_AC_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_AC.rds')
      # saveRDS(df_EO_report, '/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/df_EO.rds')
      
      
      ### RENDERING
      
      if ( input$Player ) {
        
        if ( input$conditionReport ) {
          
          ### Variables
          # Player Info
          player <- 
            input$PlayerInput
          df_current_player <- 
            df_PC %>% 
            filter(Jugador == player)
          ID_Jugador <- 
            df_current_player %>% 
            pull(ID_Jugador)
          ID_Categoría_Jugador <- 
            df_current_player %>% 
            pull(ID_Categoría)
          # Conditions
          CondiciónIngreso <- 
            input$initialConditionInput %>% 
            as.character()
          CondiciónEgreso <- 
            input$finalConditionInput %>% 
            as.character()
          FechaIngreso <- 
            input$entryDateInput %>% 
            as.character()
          FechaEgreso <- 
            input$leaveDateInput %>% 
            as.character()
          # Date
          time_difference <- 0 
          current_date <- 
            Sys.time() %>% 
            clock::add_hours(time_difference) %>% 
            format("%Y-%m-%d %H:%M:%S")
          
          ### Report
          file_report <- 
            paste0('Reporte_', player, "_", Sys.Date(), "_ID", sample(1:10000,1), '.html', sep = "")
          rmarkdown::render(
            'Report_I_C.Rmd', 
            #'/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/Report_I_C.Rmd', 
            output_file = file_report
          )
          
          ### SQL
          # Connection
          con <- 
            do.call(
              DBI::dbConnect, 
              dbi_SAMPLE
            )
          # Encodin UTF-8 in SQL
          dbSendQuery(
            con, 
            "SET NAMES utf8"
          )
          # Setting Auto Increment
          dbSendQuery(
            con,
            "SET auto_increment_increment = 1;"
          )
          # Sending Query 1
          dbSendQuery(
            con,
            stringr::str_glue(
              "
              INSERT INTO player_conditions (id_player, id_category_type, 
                                             initial_condition, final_condition, 
                                             initial_date, final_date, created)
              VALUES ('{ID_Jugador}','{ID_Categoría_Jugador}',
                      '{CondiciónIngreso}','{CondiciónEgreso}',
                      '{FechaIngreso}','{FechaEgreso}','{current_date}')
              ;
              "
            )
          )
          # Disconnection
          dbDisconnect(con)
          rm(con)
          
        } else {
          
          # Variables
          player <- 
            input$PlayerInput
          
          file_report <- 
            paste0('Reporte_', player, "_", Sys.Date(), "_ID", sample(1:10000,1), '.html', sep = "")
          rmarkdown::render(
            'Report_I.Rmd', 
            #'/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/Report_I.Rmd', 
            output_file = file_report
          )
          
        }
        
      } else {
        
        file_report <- 
          paste0('Reporte_', client, "_", Sys.Date(), "_ID", sample(1:10000,1), '.html', sep = "")
        rmarkdown::render(
          'Report_G.Rmd', 
          #'/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/Report_G.Rmd', 
          output_file = file_report
        )
        
      }
      
      ## Path
      report_path <- 
        file_report
        #paste('/Users/usuario/Documents/RStudio/Projects/ReConquer/Report/', file_report, sep = "")
      
      
      ### Dropbox
      ## Uploading
      drop_upload(
        file = stringr::str_glue(report_path), 
        path = stringr::str_glue("ReConquer/R Data/{tenant}/Report/"), 
        mode = "overwrite"
      )
      ## Dropbox link
      sharing_link <- 
        drop_share(stringr::str_glue("ReConquer/R Data/{tenant}/Report/{file_report}"))$url[1]
      
      
      ### MAIL
      time <- 
        Sys.Date()
      title <- 
        paste("Informe Clínico-Deportivo de ", client, sep = "")
      message <- 
        stringr::str_glue(
          "<p>Estimado(a), 
           <br><br>A continuación encontrará, con fecha {time}, 
                   un Link de acceso para la descarga del Informe Clínico-Deportivo 
                   considerando datos ingresados en nuestra plataforma
                   entre las fechas {start_date} y {end_date}. 
          <br><br>{sharing_link}
          <br><br>Saluda atenatamente a Ud. 
          <br><br>Equipo <b style='color: rgb(73,170,230);'>ReConquer</b></p>
          <br><br>P.D. <i>Dado que el formato del archivo es HTML, 
                  para visualizarlo correctamente recomendamos
                  abrirlo desde un computador haciendo <b>doble click</b> en él</i>."
        )
      ## Structure
      email <- 
        envelope() %>%
        to(email_adress) %>% 
        #cc(second_email_adress) %>% 
        subject(title) %>% 
        html(message) %>%
        sender("ReConquer Analytics") %>%
        from("ReConquer Analytics")
      ## Sending Email
      smtp(
        email, 
        verbose = TRUE
      )
      
      ## Ending Time
      end_report_time <- 
        Sys.time()
      
      ## Total Time
      total_report_time <- 
        difftime(
          end_report_time,
          start_report_time,
          units = c("secs")
        ) %>% 
        as.numeric() %>%
        round(1)
      print(
        paste(
          "Tiempo de procesamiento del Informe del Tenant ", tenant,
          " con fecha ", Sys.time(), ": ", 
          as.numeric(total_report_time), " segundos", 
          sep = ""
        )
      )
      
      hide_spinner(spin_id = NULL, session = shiny::getDefaultReactiveDomain())
      
      shinyjs::enable('generate_report')
      
    }
    
  })
  
  ####  Modal  ####
  
  observeEvent( req(input$conditionReport == TRUE), {
    show_alert(
      title = "Atención",
      text = "Es importante verificar que las Condiciones y Fechas ingresadas sean correctas.",
      type = "warning",
      btn_labels = "Entendido",
      btn_colors = "#142c59",
      width = "40%"
    )
  })
  # observeEvent( req(input$conditionReport == TRUE), {
  #   Sys.sleep(5)
  #   closeSweetAlert(
  #     session = shiny::getDefaultReactiveDomain()
  #   )
  # })
  
  observeEvent(input$generate_report, {
    
    if (
      stringr::str_detect(input$ReportEmailInput, "email") == TRUE
    ) {
      show_alert(
        title = "Error de envio",
        text = "Verifique el nombre inicial de su Email.",
        btn_labels = "Vamos a corregirlo",
        type = "error",
        btn_colors = "#142c59",
        width = "80%"
      )
    } else if (
      stringr::str_detect(input$ReportEmailInput, "@") == FALSE
    ) {
      show_alert(
        title = "Error de envio",
        text = "Verifique el ingreso del @ en el Email.",
        btn_labels = "Vamos a corregirlo",
        type = "error",
        btn_colors = "#142c59",
        width = "80%"
      )
    } else if (
      stringr::str_detect(input$ReportEmailInput, "[.]") == FALSE 
    ) {
      show_alert(
        title = "Error de envio",
        text = "Verifique la terminación del Email.",
        btn_labels = "Vamos a corregirlo",
        type = "error",
        btn_colors = "#142c59",
        width = "80%"
      )
    } else {
      show_alert(
        title = "Informe enviado con éxito !",
        text = paste(
          "No olvide revisar su carpeta de Spam.",
          "Se aconseja Descargar el archivo y luego visualizarlo desde su navegador de preferencia.",
          sep = " "
        ),
        type = "success",
        btn_labels = "Vamos a descargarlo",
        btn_colors = "#142c59",
        width = "40%"
      )
    }
    
  })
  
  
}

####  INTERFACE  #### 

shinyApp(ui = ui, server = server)

